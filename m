Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8657D5A3188
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 23:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345329AbiHZVt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 17:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345318AbiHZVt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 17:49:28 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92583E97FE
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 14:48:37 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id l5so2046954qvs.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 14:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=IxFQvG8uCDNWfOw4XKW76il4dfl0HaGEva3keb0z0fc=;
        b=iSpsXSQHohS4/3ld/K/EJJ3fu7p0M/ym/KZ9P84gjCtQTisLl0uc+udZl4PcGZiroN
         ECjHNIvFpuFmqHTl203if+F0+fLgqxvjTBKmycWTPWcvSrC6iFmQbW+HZl9n9A9FrcNt
         IUn+3rzkAPoKjJBQXmI7r0IMbwGNggWtdIq/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=IxFQvG8uCDNWfOw4XKW76il4dfl0HaGEva3keb0z0fc=;
        b=uERW3pTOaOUbO4+XctxS3QCDaW9YmqYesfWqF+WytB4ZxkzAfProxOMD+YK8a26oKy
         iTH6s9vGSN0kXVE7cnAHv5mLf8xpMgqeYAstyqegzdasGZbFY8EEWN6D0zJbW75ltxDF
         XguzvmV44auhMeni+k0DKiedqmuezkgK4XkIN/otZnmvYB92QMuLZRxDTEkwHV9nVcZE
         A4XaxDBulU20tMkhKC8kzVdL7dL6G4SkTBC/ZibcRL4thFYWmdUz5aCTV7Ok8Y/GbNS4
         8AvejIg3AsxHjlqC2mfSpEhldF5eij7pJvIDHiBtuqct3NF+i6zTjnMdvlkASi7nO311
         CQZw==
X-Gm-Message-State: ACgBeo2uelGC7Ko6Dg7PhxYP9CkgqXQkNdsXNLnROgnIhHMQZa0KG70b
        8IzyJOJ8k4Pj1Xl5WUNVCrY48mLH56eanA==
X-Google-Smtp-Source: AA6agR5owK3OO0fDHyIb+UZcKsDvMBKtvxrVQWT5T7PDgpyIWkj0epVYPefJxB1vJa1/mV5ljAJqNw==
X-Received: by 2002:a05:6214:19e1:b0:476:95b7:1dc9 with SMTP id q1-20020a05621419e100b0047695b71dc9mr1331184qvc.124.1661550516493;
        Fri, 26 Aug 2022 14:48:36 -0700 (PDT)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com. [209.85.160.172])
        by smtp.gmail.com with ESMTPSA id y13-20020a05620a44cd00b006bb8b5b79efsm623605qkp.129.2022.08.26.14.48.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 14:48:36 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id a4so2259053qto.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 14:48:35 -0700 (PDT)
X-Received: by 2002:a05:622a:1196:b0:342:f7a9:a138 with SMTP id
 m22-20020a05622a119600b00342f7a9a138mr1432696qtk.344.1661550515375; Fri, 26
 Aug 2022 14:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <12042830.O9o76ZdvQC@kreacher> <1c7fa65d-47ab-b064-9087-648bcfbf4ab5@amd.com>
 <CAJZ5v0ie7B=GvhbfBsi7Zxu+=YzYKUqvUNs6dNZQfT3CRm=KPg@mail.gmail.com>
 <a2d2b61e-87c0-ee39-ea4e-3c575da0a66c@redhat.com> <CAHQZ30DjkyDT8KbsHzfwiyg6Tst9EFhtCnjx3MmwbWRerzW_6A@mail.gmail.com>
 <CAJZ5v0gXizr6szRA09fNYC0njUv-Dg7kDSu9FtmfDRgX2n45wg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gXizr6szRA09fNYC0njUv-Dg7kDSu9FtmfDRgX2n45wg@mail.gmail.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Fri, 26 Aug 2022 15:48:24 -0600
X-Gmail-Original-Message-ID: <CAHQZ30CNORQMD=URhEv3mCV8ELGYs8W6Z2tSqrLiUbxUbikauA@mail.gmail.com>
Message-ID: <CAHQZ30CNORQMD=URhEv3mCV8ELGYs8W6Z2tSqrLiUbxUbikauA@mail.gmail.com>
Subject: Re: [PATCH] i2c: ACPI: Do not check ACPI_FADT_LOW_POWER_S0
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-input <linux-input@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Tim Van Patten <timvp@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So after tracing a bunch of code, I finally got a solution that I
think will work. I just uploaded the patch train here:
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/3858568.
I'll push it to the mailing list once I do a bit more testing.

Do we need to support setting the wake_irq for systems that don't use
DT or ACPI? Ideally I would drop the following block:

if (!dev->of_node && !has_acpi_companion(dev)) {
    device_init_wakeup(dev, true);
    dev_pm_set_wake_irq(dev, client->irq);
}

There are also a few other i2c drivers that need cleanup:
* https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/third_party/kernel/v5.15/drivers/mfd/max8925-i2c.c;l=218
* https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/third_party/kernel/v5.15/drivers/input/touchscreen/elants_i2c.c;l=1629
* https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/third_party/kernel/v5.15/drivers/input/touchscreen/raydium_i2c_ts.c;l=1190

I can send CLs to delete the enable_irq_wake calls from those drivers
if we don't need to support non-DT/non-ACPI boards. Or I can send CLs
to add the boiler plate from above. Do we even need the `disable_irq`
calls in the suspend handlers or can the PM subsystem take care of
that?

Do we also need to handle reading the wake bit from Interrupt/IRQ ACPI
resources? Can those actually wake the system? On AMD platforms the
IO-APIC/PIC can't actually wake the system. It either needs to be an
ACPI GPE or the GPIO controller. If we do need to support it, I can
add some more plumbing.

Thanks!


On Mon, Aug 8, 2022 at 11:10 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Sat, Aug 6, 2022 at 4:20 AM Raul Rangel <rrangel@chromium.org> wrote:
> >
> > I do plan on coming back and updating those patches. I got derailed
> > with other priorities.
>
> I'll leave it to you then.  I'm mostly interested in dropping the
> misguided ACPI_FADT_LOW_POWER_S0 check.
>
> > But as Hans pointed out, we wanted to use
> > `ExclusiveAndWake` to make the decision since not all IRQs can be wake
> > sources while in s0i3.
>
> S0i3 is still S0, so all of the interrupts that work in S0 will still work.
>
> What really matters is whether or not enable_irq_wake() is called for
> the given IRQ, but I'm not sufficiently familiar with the code in
> question to comment on it any further without thorough investigation.
>
> And of course the device needs to be able to generate interrupts in
> the first place and if it is power-manageable by ACPI, I would just
> leave the wakeup handling to the generic ACPI code.
>
> >
> > On Fri, Aug 5, 2022 at 12:54 PM Hans de Goede <hdegoede@redhat.com> wrote:
> > >
> > > Hi,
> > >
> > > On 8/5/22 19:08, Rafael J. Wysocki wrote:
> > > > On Fri, Aug 5, 2022 at 6:59 PM Limonciello, Mario
> > > > <mario.limonciello@amd.com> wrote:
> > > >>
> > > >> On 8/5/2022 11:51, Rafael J. Wysocki wrote:
> > > >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >>>
> > > >>> The ACPI_FADT_LOW_POWER_S0 flag merely means that it is better to
> > > >>> use low-power S0 idle on the given platform than S3 (provided that
> > > >>> the latter is supported) and it doesn't preclude using either of
> > > >>> them (which of them will be used depends on the choices made by user
> > > >>> space).
> > > >>>
> > > >>> Because of that, ACPI_FADT_LOW_POWER_S0 is generally not sufficient
> > > >>> for making decisions in device drivers and so i2c_hid_acpi_probe()
> > > >>> should not use it.
> > > >>>
> > > >>> Moreover, Linux always supports suspend-to-idle, so if a given
> > > >>> device can wake up the system from suspend-to-idle, then it can be
> > > >>> marked as wakeup capable unconditionally, so make that happen in
> > > >>> i2c_hid_acpi_probe().
> > > >>>
> > > >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >>
> > > >> +Raul
> > > >> +Hans
> > > >> +KH
> > > >>
> > > >> Raul had a patch that was actually going to just tear out this code
> > > >> entirely:
> > > >> https://lkml.kernel.org/lkml/20211220163823.1.Ie20ca47a26d3ea68124d8197b67bb1344c67f650@changeid/
> > > >>
> > > >> As part of that patch series discussion another suggestion had
> > > >> transpired
> > > >> (https://patchwork.kernel.org/project/linux-input/patch/20211220163823.2.Id022caf53d01112188308520915798f08a33cd3e@changeid/#24681016):
> > > >>
> > > >> ```
> > > >> if ((acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) &&
> > > >>             !adev->flags.power_manageable) {
> > > >>                  device_set_wakeup_capable(dev, true);
> > > >>                  device_set_wakeup_enable(dev, false);
> > > >>          }
> > > >> ```
> > > >>
> > > >> If this is being changed, maybe consider that suggestion to
> > > >> check `adev->flags.power_manageable`.
> > > >
> > > > Fair enough, I'll send a v2 with this check added.
> > >
> > > Re-reading the original thread:
> > > https://lkml.kernel.org/lkml/20211220163823.1.Ie20ca47a26d3ea68124d8197b67bb1344c67f650@changeid/T/#u
> > >
> > > The conclusion there was that the :
> > >
> > >                  device_set_wakeup_capable(dev, true);
> > >                  device_set_wakeup_enable(dev, false);
> > >
> > > Calls should be made conditional on the IRQ being
> > > marked ExclusiveAndWake instead of the ACPI_FADT_LOW_POWER_S0
> > > check.
> > >
> > > Regards,
> > >
> > > Hans
> > >
