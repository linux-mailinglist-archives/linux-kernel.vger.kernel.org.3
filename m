Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE8858CC8B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 19:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236747AbiHHRLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 13:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiHHRK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:10:58 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BFB9FDD;
        Mon,  8 Aug 2022 10:10:55 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-328303afa6eso87464777b3.10;
        Mon, 08 Aug 2022 10:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=nWit7Kn68GEMPw7G4wEbtJxZwK0Ee9idrNPto3C7Rb4=;
        b=lUGrnrYwTXB1WdRVHQWoYUBNs5MSz8xz2uoCV+mzOfFYO/Jvmf/pdrxW/8VLNDqcly
         jjKnCcsm12VtF90EkL7JRI0zdZ+H9KM56ZUICdgYelSSsWhEHXe6LrlhbNkHeI4SqQqz
         YeTqLh2cNeJhtU1tlaD+9QFGCZPB1nFOmu3FlTaWJwegOlTS6fr6KLLI/t6PJkQO6Ju0
         CqT2PW5johVndBy4Mh3pQYU0UPpk7oOJdQR3O6jmg3DxuYFbncyNsLYU+kS+NCUE8pbc
         Vf8/gWaV1nyL/R3h5Ghnuw/Vcutyw8G73Lh6ypyBmfswHqnuHlHZ5thSljxnZShbVrj0
         JZJg==
X-Gm-Message-State: ACgBeo0qZkRNHix1QuG1+TAhRZR8kHD2/MK+vnzUmxYKQTDSMg9HSs+S
        kpiHXlI64igw14iZsfrgv6usVpD/c/NTGPDTtQI=
X-Google-Smtp-Source: AA6agR7Ato2DCBx203VKocNIXQ8BeokFSfhIucyMnDZXDO5irSPSPb5f5Mz32kBJ/Rrv0I4Ay+BbZg1UXz+IiD+c1AM=
X-Received: by 2002:a81:7485:0:b0:329:a463:1ff4 with SMTP id
 p127-20020a817485000000b00329a4631ff4mr6653113ywc.19.1659978654940; Mon, 08
 Aug 2022 10:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <12042830.O9o76ZdvQC@kreacher> <1c7fa65d-47ab-b064-9087-648bcfbf4ab5@amd.com>
 <CAJZ5v0ie7B=GvhbfBsi7Zxu+=YzYKUqvUNs6dNZQfT3CRm=KPg@mail.gmail.com>
 <a2d2b61e-87c0-ee39-ea4e-3c575da0a66c@redhat.com> <CAHQZ30DjkyDT8KbsHzfwiyg6Tst9EFhtCnjx3MmwbWRerzW_6A@mail.gmail.com>
In-Reply-To: <CAHQZ30DjkyDT8KbsHzfwiyg6Tst9EFhtCnjx3MmwbWRerzW_6A@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 8 Aug 2022 19:10:43 +0200
Message-ID: <CAJZ5v0gXizr6szRA09fNYC0njUv-Dg7kDSu9FtmfDRgX2n45wg@mail.gmail.com>
Subject: Re: [PATCH] i2c: ACPI: Do not check ACPI_FADT_LOW_POWER_S0
To:     Raul Rangel <rrangel@chromium.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-input <linux-input@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
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

On Sat, Aug 6, 2022 at 4:20 AM Raul Rangel <rrangel@chromium.org> wrote:
>
> I do plan on coming back and updating those patches. I got derailed
> with other priorities.

I'll leave it to you then.  I'm mostly interested in dropping the
misguided ACPI_FADT_LOW_POWER_S0 check.

> But as Hans pointed out, we wanted to use
> `ExclusiveAndWake` to make the decision since not all IRQs can be wake
> sources while in s0i3.

S0i3 is still S0, so all of the interrupts that work in S0 will still work.

What really matters is whether or not enable_irq_wake() is called for
the given IRQ, but I'm not sufficiently familiar with the code in
question to comment on it any further without thorough investigation.

And of course the device needs to be able to generate interrupts in
the first place and if it is power-manageable by ACPI, I would just
leave the wakeup handling to the generic ACPI code.

>
> On Fri, Aug 5, 2022 at 12:54 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >
> > Hi,
> >
> > On 8/5/22 19:08, Rafael J. Wysocki wrote:
> > > On Fri, Aug 5, 2022 at 6:59 PM Limonciello, Mario
> > > <mario.limonciello@amd.com> wrote:
> > >>
> > >> On 8/5/2022 11:51, Rafael J. Wysocki wrote:
> > >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >>>
> > >>> The ACPI_FADT_LOW_POWER_S0 flag merely means that it is better to
> > >>> use low-power S0 idle on the given platform than S3 (provided that
> > >>> the latter is supported) and it doesn't preclude using either of
> > >>> them (which of them will be used depends on the choices made by user
> > >>> space).
> > >>>
> > >>> Because of that, ACPI_FADT_LOW_POWER_S0 is generally not sufficient
> > >>> for making decisions in device drivers and so i2c_hid_acpi_probe()
> > >>> should not use it.
> > >>>
> > >>> Moreover, Linux always supports suspend-to-idle, so if a given
> > >>> device can wake up the system from suspend-to-idle, then it can be
> > >>> marked as wakeup capable unconditionally, so make that happen in
> > >>> i2c_hid_acpi_probe().
> > >>>
> > >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >>
> > >> +Raul
> > >> +Hans
> > >> +KH
> > >>
> > >> Raul had a patch that was actually going to just tear out this code
> > >> entirely:
> > >> https://lkml.kernel.org/lkml/20211220163823.1.Ie20ca47a26d3ea68124d8197b67bb1344c67f650@changeid/
> > >>
> > >> As part of that patch series discussion another suggestion had
> > >> transpired
> > >> (https://patchwork.kernel.org/project/linux-input/patch/20211220163823.2.Id022caf53d01112188308520915798f08a33cd3e@changeid/#24681016):
> > >>
> > >> ```
> > >> if ((acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) &&
> > >>             !adev->flags.power_manageable) {
> > >>                  device_set_wakeup_capable(dev, true);
> > >>                  device_set_wakeup_enable(dev, false);
> > >>          }
> > >> ```
> > >>
> > >> If this is being changed, maybe consider that suggestion to
> > >> check `adev->flags.power_manageable`.
> > >
> > > Fair enough, I'll send a v2 with this check added.
> >
> > Re-reading the original thread:
> > https://lkml.kernel.org/lkml/20211220163823.1.Ie20ca47a26d3ea68124d8197b67bb1344c67f650@changeid/T/#u
> >
> > The conclusion there was that the :
> >
> >                  device_set_wakeup_capable(dev, true);
> >                  device_set_wakeup_enable(dev, false);
> >
> > Calls should be made conditional on the IRQ being
> > marked ExclusiveAndWake instead of the ACPI_FADT_LOW_POWER_S0
> > check.
> >
> > Regards,
> >
> > Hans
> >
