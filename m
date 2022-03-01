Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40EEA4C9461
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 20:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236408AbiCATfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 14:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235497AbiCATe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 14:34:59 -0500
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135AC53700;
        Tue,  1 Mar 2022 11:34:17 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-2d62593ad9bso156104457b3.8;
        Tue, 01 Mar 2022 11:34:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9DZJnhr29vpOQyROdrlyWLXjl59bG6U5FIQs203mj1A=;
        b=W7NtD8WYCQMAmlG1g/9bjsGeond2WkKLpdNNcAC4uhHGVwQPmZbVescyRAzkKDyoSq
         QPHeEDpp8mj/roGxgCxZhmpCo+SFYnFHUdidnXsKU7DL0jPOjvqYpCZ1ONyi3CUucGX8
         QQbJ7oPAecY3cqkw6c37zv49e5SDtSffSkzov5KeVVtUeC9LUbVJl0qSGI/OEzg8lHpM
         VOuTz+qms5fLRkjzsUS8TfwBgF4ScpLqGPjkNiwjiv4YJvWdaPm36c/zm7W6yd0y1Eou
         1c8koH95VdnsoWYGy/ZHxR+XGd57bc0qi1BjxrYFdTDGtCKVJlnPqPp2C7K+rxgrOeXP
         xj6A==
X-Gm-Message-State: AOAM531yZlxP8RYN5caIQq7WVut9nW7VhCx6zFVOJnZPE3T3drJL2JSy
        LtLVcgcvgdWgyRpO/4XUSxofuADAGiMG0JPeh2g=
X-Google-Smtp-Source: ABdhPJwCLejG5kiIYQpx3A1AUwAU/+8fLgf6SxdpxfT69jyVuABWhmZihgMkTJs1vMM/TeQ/ul05xly58HT0YJUlpKg=
X-Received: by 2002:a81:1611:0:b0:2d6:3290:9bd3 with SMTP id
 17-20020a811611000000b002d632909bd3mr26833208yww.19.1646163256373; Tue, 01
 Mar 2022 11:34:16 -0800 (PST)
MIME-Version: 1.0
References: <20220223160708.88100-1-mark@yotsuba.nl> <303dc74a-4d63-70a2-9891-af3e3d8baf26@redhat.com>
In-Reply-To: <303dc74a-4d63-70a2-9891-af3e3d8baf26@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Mar 2022 20:34:05 +0100
Message-ID: <CAJZ5v0gVN_nsB5eqfWzyG3+LyvAmOJKsVbA4_sOiAV+RnjG64w@mail.gmail.com>
Subject: Re: [PATCH] x86/acpi: Work around broken XSDT on SEGA AALE board
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Cilissen <mark@yotsuba.nl>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        x86@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 9:41 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Mark,
>
> On 2/23/22 17:07, Mark Cilissen wrote:
> > On this board the ACPI RSDP structure points to both a RSDT and an XSDT,
> > but the XSDT points to a truncated FADT. This causes all sorts of trouble
> > and usually a complete failure to boot after the following error occurs:
> >
> >   ACPI Error: Unsupported address space: 0x20 (*/hwregs-*)
> >   ACPI Error: AE_SUPPORT, Unable to initialize fixed events (*/evevent-*)
> >   ACPI: Unable to start ACPI Interpreter
> >
> > This leaves the ACPI implementation in such a broken state that subsequent
> > kernel subsystem initialisations go wrong, resulting in among others
> > mismapped PCI memory, SATA and USB enumeration failures, and freezes.
> >
> > As this is an older embedded platform that will likely never see any BIOS
> > updates to address this issue and its default shipping OS only complies to
> > ACPI 1.0, work around this by forcing `acpi=rsdt`. This patch, applied on
> > top of Linux 5.10.102, was confirmed on real hardware to fix the issue.
> >
> > Signed-off-by: Mark Cilissen <mark@yotsuba.nl>
> > Cc: stable@vger.kernel.org
>
> Wow, you got it working, cool!
>
> The patch looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Applied as 5.18 material, thanks!

> > ---
> >  arch/x86/kernel/acpi/boot.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> > index 5b6d1a95776f..7caf4da075cd 100644
> > --- a/arch/x86/kernel/acpi/boot.c
> > +++ b/arch/x86/kernel/acpi/boot.c
> > @@ -1328,6 +1328,17 @@ static int __init disable_acpi_pci(const struct dmi_system_id *d)
> >       return 0;
> >  }
> >
> > +static int __init disable_acpi_xsdt(const struct dmi_system_id *d)
> > +{
> > +     if (!acpi_force) {
> > +             pr_notice("%s detected: force use of acpi=rsdt\n", d->ident);
> > +             acpi_gbl_do_not_use_xsdt = TRUE;
> > +     } else {
> > +             pr_notice("Warning: DMI blacklist says broken, but acpi XSDT forced\n");
> > +     }
> > +     return 0;
> > +}
> > +
> >  static int __init dmi_disable_acpi(const struct dmi_system_id *d)
> >  {
> >       if (!acpi_force) {
> > @@ -1451,6 +1462,20 @@ static const struct dmi_system_id acpi_dmi_table[] __initconst = {
> >                    DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 360"),
> >                    },
> >        },
> > +     /*
> > +      * Boxes that need ACPI XSDT use disabled due to corrupted tables
> > +      */
> > +     {
> > +      .callback = disable_acpi_xsdt,
> > +      .ident = "SEGA AALE",
> > +      .matches = {
> > +                  DMI_MATCH(DMI_SYS_VENDOR, "NEC"),
> > +                  DMI_MATCH(DMI_PRODUCT_NAME, "Bearlake CRB Board"),
> > +                  DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
> > +                  DMI_MATCH(DMI_BIOS_VERSION, "V1.12"),
> > +                  DMI_MATCH(DMI_BIOS_DATE, "02/01/2011"),
> > +                  },
> > +     },
> >       {}
> >  };
> >
> >
> > base-commit: cfb92440ee71adcc2105b0890bb01ac3cddb8507
>
