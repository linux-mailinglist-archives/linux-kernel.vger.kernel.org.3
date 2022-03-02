Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D294CAEF0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242120AbiCBToQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 14:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242082AbiCBToL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:44:11 -0500
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CC7CA0DF;
        Wed,  2 Mar 2022 11:43:24 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id g26so5538209ybj.10;
        Wed, 02 Mar 2022 11:43:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5wvrt4mN5pwwCtlrrq6xd2uRhH3ZrSedQGiLgTtwogM=;
        b=YaQNHym3tiesS2Tc0ukoLuesX5mNmGnN8db2GEaB6Mja/8MGC9lSzokzxV0LZO9Lpi
         JHPavshPjZfEgURxMABWNe0ONl3YyBzz1+wMRVK3mCKqy+U6O7N0ze9KXx/6TBO5cH/6
         1KxRMlDExARJXst6BDx15X2QUr+v00YXEJhWzYbEqXqgYW2cIOmBJVF+LTQcO6Ye19Lp
         TXbBfz/H8YS/EMyHjeFb2jubDgdU4zO3yfWLMQagCOfTtVpxZxB/JLtB+EHwT6KVDM3w
         aInFhBfZ0ywbW72p+vyUq4dKoTnRy5RYTBIkkH/6IvGA/Txpof/R6TCQ9jSyn7U3amCR
         HD8Q==
X-Gm-Message-State: AOAM532P+730t04OrkYYKPp35F8HhY4XXvo+i5kmORKQIMdnMtN1noPz
        7fb3uTGpDpYjFW0dL20r37u+hvtwud3ZQAG7sdc=
X-Google-Smtp-Source: ABdhPJylJxJ02SR2t3nFiQMP5hcdt++ycrqhmtMvNSGMlP5wyagWCqyYKwxGDNnqZY9IO3rDIcfxNVBvZtwv768sIPA=
X-Received: by 2002:a25:bbc1:0:b0:610:b4ce:31db with SMTP id
 c1-20020a25bbc1000000b00610b4ce31dbmr30378943ybk.482.1646250173910; Wed, 02
 Mar 2022 11:42:53 -0800 (PST)
MIME-Version: 1.0
References: <20220223160708.88100-1-mark@yotsuba.nl> <303dc74a-4d63-70a2-9891-af3e3d8baf26@redhat.com>
 <CAJZ5v0gVN_nsB5eqfWzyG3+LyvAmOJKsVbA4_sOiAV+RnjG64w@mail.gmail.com>
In-Reply-To: <CAJZ5v0gVN_nsB5eqfWzyG3+LyvAmOJKsVbA4_sOiAV+RnjG64w@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 2 Mar 2022 20:42:43 +0100
Message-ID: <CAJZ5v0gPxZ_m=7bqgo54kb1Kx5ut_KZ2iOeWo2ak0AFJq7rpjw@mail.gmail.com>
Subject: Re: [PATCH] x86/acpi: Work around broken XSDT on SEGA AALE board
To:     Mark Cilissen <mark@yotsuba.nl>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 1, 2022 at 8:34 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Feb 24, 2022 at 9:41 AM Hans de Goede <hdegoede@redhat.com> wrote:
> >
> > Hi Mark,
> >
> > On 2/23/22 17:07, Mark Cilissen wrote:
> > > On this board the ACPI RSDP structure points to both a RSDT and an XSDT,
> > > but the XSDT points to a truncated FADT. This causes all sorts of trouble
> > > and usually a complete failure to boot after the following error occurs:
> > >
> > >   ACPI Error: Unsupported address space: 0x20 (*/hwregs-*)
> > >   ACPI Error: AE_SUPPORT, Unable to initialize fixed events (*/evevent-*)
> > >   ACPI: Unable to start ACPI Interpreter
> > >
> > > This leaves the ACPI implementation in such a broken state that subsequent
> > > kernel subsystem initialisations go wrong, resulting in among others
> > > mismapped PCI memory, SATA and USB enumeration failures, and freezes.
> > >
> > > As this is an older embedded platform that will likely never see any BIOS
> > > updates to address this issue and its default shipping OS only complies to
> > > ACPI 1.0, work around this by forcing `acpi=rsdt`. This patch, applied on
> > > top of Linux 5.10.102, was confirmed on real hardware to fix the issue.
> > >
> > > Signed-off-by: Mark Cilissen <mark@yotsuba.nl>
> > > Cc: stable@vger.kernel.org
> >
> > Wow, you got it working, cool!
> >
> > The patch looks good to me:
> >
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>
> Applied as 5.18 material, thanks!

And dropped due to a problem introduced by it.

Also please note that the x86 mailing list address originally used in
the CC list was incorrect.
