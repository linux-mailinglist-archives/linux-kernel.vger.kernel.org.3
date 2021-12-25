Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCFEF47F355
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 14:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbhLYNvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 08:51:19 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:55664
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231668AbhLYNvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 08:51:17 -0500
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5040A3FFE5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 13:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640440276;
        bh=7SRFgSIJ9SDQXLp5krc7uekTyBrqLQJbKNIu2yWX+4w=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=mInCccGXRrFQZDz7FOwlq3ABMV5eck9qMFzX/pFtHlHUO0tBJOGrBCj3VC5zKlDla
         T7GoWKamA+WqGiY21e0ysgqP5AMifo8fRcEaGowVSzihBEN6OZd7NXGjjCTId8FR0k
         z4J9MMQOSFVdJEFLUgFOxj4riEgj2kpXnOD+t5evufxLYb15W1PsHmsmWsFmQzrjJL
         +gIqYK2uBBD0V75ZOqsuMyCvZW2XPRK+gNBryoOQrljMU9iBqDECS0YnG5aSdpsLNp
         LIkVi8xJaGK/Gv7dF4Iv21fSIDdG95G7+y7EOS+eBssDDkpYIWw3v9sujbEYp6e810
         VoO1wXJwE0XTw==
Received: by mail-oo1-f69.google.com with SMTP id 125-20020a4a1b83000000b002dab693b008so4684337oop.8
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 05:51:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7SRFgSIJ9SDQXLp5krc7uekTyBrqLQJbKNIu2yWX+4w=;
        b=fjdMQXQ5hlaynxHeFJmFXv5h3XWE4bqEdqWxgBLfvTrC+3j7l6ccTHtP0Chs2HOyXU
         x2tvdx/H4OOL8+f5nYgxcD2bxaFr6MeNb9bhMeQujGYsWErsdJZUuGsp55VneGfnkVCG
         SIiKnwi3T9kHLVvoWCnRCVrUp+PhhspoEJ4IlMFQ7b3UqftnX7+bHwjNziz1KEsnxP6V
         r2oh2/XoNKBAshrVQ11q6h7JyAxzPaCDWGwnA6xgguRgBEFfCtGiD9eitVpSm5MxK5T5
         iULL7ea7ugRZPyAnrxQj4htrRZcj8DJ8YVpBwIDFLfQH4acKLvy/qTay7b/aLFoDiuGD
         Ov0w==
X-Gm-Message-State: AOAM530eCNZ8u+1IgHWhETkpCR7fFzPsKoXh6MJZeAUptGBETVOM0VHF
        FWDTEopRNpBCAqrqo03RfV61nVpgWswPPZPQ7y5t44PxsAIL/7AssmFsZl05sRVrwUrMJClmtha
        V5ePBDUzQWVTL6mTNVDEIQityyJ9IzxXx/Mq/9hovDpdPZa3MiyULzOLOLg==
X-Received: by 2002:aca:ad05:: with SMTP id w5mr7626254oie.41.1640440274843;
        Sat, 25 Dec 2021 05:51:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyizRJi22btx64kfUhbzRooA54rKAq7hFCHkYzF/1bFymE91QqV2vJ58T4rIE/HCPV5MlxrOLxQgsfXKexycWA=
X-Received: by 2002:aca:ad05:: with SMTP id w5mr7626245oie.41.1640440274510;
 Sat, 25 Dec 2021 05:51:14 -0800 (PST)
MIME-Version: 1.0
References: <20211220234346.2798027-1-rrangel@chromium.org>
 <20211220163823.2.Id022caf53d01112188308520915798f08a33cd3e@changeid>
 <YcE+xrSnS7qw0G1/@google.com> <9b004b3d-deed-1b63-2344-a445a9e53b61@redhat.com>
 <YcToUCQ8gzzSWbrm@google.com> <a71d4e73-6db8-16e7-2a3c-e50e26c0a07e@redhat.com>
In-Reply-To: <a71d4e73-6db8-16e7-2a3c-e50e26c0a07e@redhat.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Sat, 25 Dec 2021 21:51:03 +0800
Message-ID: <CAAd53p4UbV=M_GrDMFz7qqqWRF23mXD=D7bDj-4b6rxgWupDMA@mail.gmail.com>
Subject: Re: [PATCH 2/3] Input: elan_i2c - Use PM subsystem to manage wake irq
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Raul E Rangel <rrangel@chromium.org>,
        linux-kernel@vger.kernel.org, Mario.Limonciello@amd.com,
        linux-input@vger.kernel.org, dianders@chromium.org,
        "jingle.wu" <jingle.wu@emc.com.tw>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2021 at 7:11 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 12/23/21 22:21, Dmitry Torokhov wrote:
> > On Thu, Dec 23, 2021 at 03:42:24PM +0100, Hans de Goede wrote:
> >> Hi,
> >>
> >> On 12/21/21 03:41, Dmitry Torokhov wrote:
> >>> Hi Raul,
> >>>
> >>> On Mon, Dec 20, 2021 at 04:43:45PM -0700, Raul E Rangel wrote:
> >>>> @@ -1368,11 +1367,13 @@ static int elan_probe(struct i2c_client *client,
> >>>>    }
> >>>>
> >>>>    /*
> >>>> -   * Systems using device tree should set up wakeup via DTS,
> >>>> +   * Systems using device tree or ACPI should set up wakeup via DTS/ACPI,
> >>>>     * the rest will configure device as wakeup source by default.
> >>>>     */
> >>>> -  if (!dev->of_node)
> >>>> +  if (!dev->of_node && !ACPI_COMPANION(dev)) {
> >>>
> >>> I think this will break our Rambis that use ACPI for enumeration but
> >>> actually lack _PRW. As far as I remember their trackpads were capable
> >>> of waking up the system.
> >>>
> >>> I think we should remove this chunk completely and instead add necessary
> >>> code to drivers/platform/chrome/chrome-laptop.c (I suppose we need to
> >>> have additional member in struct acpi_peripheral to indicate whether
> >>> device needs to be configured for wakeup and then act upon it in
> >>> chromeos_laptop_adjust_client().
> >
> > FWIW I looked at Rambi some more and I see that it actually defines a
> > separate device an ACPI to handle wakeups, it is separate from the ACPI
> > node for the trackpad:
> >
> > Scope (\_SB)
> > {
> > #ifdef BOARD_TRACKPAD_IRQ
> >         /* Wake device for touchpad */
> >         Device (TPAD)
> >         {
> >                 Name (_HID, EisaId ("PNP0C0E"))
> >                 Name (_UID, 1)
> >                 Name (_PRW, Package() { BOARD_TRACKPAD_WAKE_GPIO, 0x3 })
> >
> >                 Name (RBUF, ResourceTemplate()
> >                 {
> >                         Interrupt (ResourceConsumer, Level, ActiveLow)
> >                         {
> >                                 BOARD_TRACKPAD_IRQ
> >                         }
> >                 })
> >
> >                 Method (_CRS)
> >                 {
> >                         /* Only return interrupt if I2C1 is PCI mode */
> >                         If (LEqual (\S1EN, 0)) {
> >                                 Return (^RBUF)
> >                         }
> >
> >                         /* Return empty resource template otherwise */
> >                         Return (ResourceTemplate() {})
> >                 }
> >         }
> > #endif
> >
> > I am not quite sure why we did this...
> >
> >>>
> >>>>            device_init_wakeup(dev, true);
> >>>> +          dev_pm_set_wake_irq(dev, client->irq);
> >>>> +  }
> >>
> >> As I already mentioned in my other reply in this thread:
> >>
> >> https://lore.kernel.org/linux-input/f594afab-8c1a-8821-a775-e5512e17ce8f@redhat.com/
> >>
> >> AFAICT most x86 ACPI laptops do not use GPEs for wakeup by touchpad and
> >> as such they do not have a _PRW method.
> >>
> >> So for wakeup by elan_i2c touchpads to keep working this code is not
> >> just necessary for some ChromeOS devices, but it is necessary on
> >> most ACPI devices.
> >>
> >> The problem of not making these calls on devices where a GPE is actually
> >> used for touchpad wakeup (which at least for now is the exception not
> >> the rule) should probably be fixed by no running this "chunk"
> >> when the device has an ACPI_COMPANION (as this patch already checks)
> >> *and* that ACPI_COMPANION has a valid _PRW method.
> >>
> >> Simply removing this chunk, or taking this patch as is will very
> >> likely lead to regressions on various x86 laptop models.
> >
> > Hans, could you share a couple of DSDTs for devices that do not use GPEs
> > for wakeup?
> >
> > For OF we already recognize that wakeup source/interrupt might differ
> > from "main" I2C interrupt, I guess we need to do similar for ACPI cases.
> > The question is to how determine if a device is supposed to be a wakeup
> > source if it does not have _PRW.
>
> With s2idle (rather then S3) we never really suspend, we just put
> everything in an as low power state as possible and call halt on the
> CPU and then hope that the SoC power-management-unit shuts of a whole
> bunch of power-planes based on all the devices being in a low power
> state.
>
> This means that in practice with s2idle any device can be a wakeup
> device since regular IRQs work fine as wakeup sources in s2idle.
>
> This is what the s2idle support in the i2c-hid code is based on:
> drivers/hid/i2c-hid/i2c-hid-acpi.c:
>
>         if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
>                 device_set_wakeup_capable(dev, true);
>                 device_set_wakeup_enable(dev, false);
>         }
>
> So I did just test this on a Lenovo ThinkPad X1 carbon gen 8, which
> uses i2c_hid_acpi as driver for its touchpad and if I echo
> enabled to the wakeup attr there, then wakeup by touchpad does work.
>
> One interesting thing there is that the touchpad ACPI node does not
> have _PS0 and _PS3. Which means that the touchpad working as wakeup
> device makes sense, since it can not be turned off at all.
>
> So I guess we could extend the above check in the i2c-hid-acpi
> code to read:
>
>         if ((acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) &&
>             !adev->flags.power_manageable) {
>                 device_set_wakeup_capable(dev, true);
>                 device_set_wakeup_enable(dev, false);
>         }
>
> Because if there is a _PS3, which presumably is the case for
> the troublesome touchscreen Raul is trying to fix, then we
> will call that on suspend; and after that it is likely that
> the device will not work as a wakeup source.
>
> And I just checked the DSDT of a couple of devices where I'm
> reasonable sure that the touchpad uses I2C-HID and none of
> them define _PS0/_PS3 methods on the touchpad ACPI node.
>
> So I think that the above suggestion should fix things
> for the i2c-hid case.
>
> I've added Kai-Heng, the author of the original change
> introducing the device_set_wakeup_capable() call, to the Cc.
> Kai-Heng what do you think about this ?
>
> Raul, can you check if this resolves your issue?
>
> FWIW here is an acpidump of the X1C8:
> https://fedorapeople.org/~jwrdegoede/acpidump-lenovo-x1c8
>
> Regards,
>
> Hans
>
>
> p.s.
>
> An other interesting datapoint is that despite not declaring
> a _PRW method the DSDTs which I've checked do all 3 contain
> an _S0W method, returning 3 or 4. Which suggests that maybe the
> ACPI code should look at _S0W even when no GPE is being used?
>

Maybe "ExclusiveAndWake" in _CRS is enough? ACPI spec says "whether it
is capable of waking the system from a low-power idle or system sleep
state" without mentioning the need for _PRW.

Kai-Heng
