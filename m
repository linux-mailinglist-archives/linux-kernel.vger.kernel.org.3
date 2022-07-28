Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2A55836AD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 04:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbiG1CHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 22:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236314AbiG1CHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 22:07:31 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2503259244
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 19:07:30 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 917FD3F11C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 02:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1658974048;
        bh=QUeZnOPqdNL4lvXqREiShbeO7BuLmw+2Wa9bS3C20Po=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=r7gf7GwkMPy/+xd44vOiLRkRMQPpGLxowqCxYzm2a6RpslBQLu/cXcx1LABAYg7VP
         9Ny4wO3YKqFTTYXhqnv5JZxP5R+KrwC4S6tl2K0JYEUdh/MbFAxDDI7OIxXiTbYogV
         amsfEoYOnvUNxvS/UEHT4TWOJLRb3ThCqoK2w5gE6fVDQKezhVs9SPh43w8Qcr+0+G
         OyQ2CYmbUK+EErtbWMkOJkfryrwPH8+AlLAgWjYYeHw9xfVUNyoTkrhXo7OTmHd/2e
         SxRwQirvmIrma9MaqIO4Jr9mE6xTP/mzrW0yChDJCn1S2X42IYL29eeg2hjPP18Qe5
         EzQg8P437idSA==
Received: by mail-ed1-f70.google.com with SMTP id y2-20020a056402440200b0043bd6c898deso295105eda.20
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 19:07:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QUeZnOPqdNL4lvXqREiShbeO7BuLmw+2Wa9bS3C20Po=;
        b=a8iU70KO3wE8yIaya7wGlmgVYJmXAsH2/kJCuhsU7RJdIQMXqoBtdqub3gut/G1AhY
         K6gcZNAAsZaIQDiJPq3I1mjBJPxRhjP64bBp0ED7eGy4E59LdNGLbwNpXeMiwnAv9HGj
         wynfL4Z/ixIjT3S4yLe6ZUWqfIhcKjrinJjJZ4xB7rj8hfz4SpHAmJzByfgcmq21X5cq
         blYjBJ0mg3MNlFpUTOpvYg8CIQWOx1lVvn0gp4v+pM/qZIiVDHjlwr2whviBDV/Fp5dq
         iwwYiJiBgFSGbACSXNvI9UYh3CScVNqD2rtbEIkMsh7a+Q6XpUN8BePowYz8jw+zEasm
         t5Jw==
X-Gm-Message-State: AJIora/uAkbok830xqjilK0Ewfosr5CnFJQjy7tisXXmwLwdDP8ZmPY/
        t5E/bjm6N8MYug6FG7NWCHGgtd8SOM2XPrPGl7SUehKfmTjRxMtwun59RLv9Q2jZzikL6w++/zD
        GXRh0ImAlMfB3DQ0nZ9ZPU/2TFjywRwv8QKO1K9DN3weKh2TZPRSHui3vkw==
X-Received: by 2002:a05:6402:90a:b0:439:c144:24cd with SMTP id g10-20020a056402090a00b00439c14424cdmr25378473edz.209.1658974047990;
        Wed, 27 Jul 2022 19:07:27 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1urft1cdryKbyaflp+Ot0/rCIr+tsT9IAXM7GyhPEI+FSLjVVjgy9a+LoWFyg24/KqgAuBNxgoWOfX/dVyjPWQ=
X-Received: by 2002:a05:6402:90a:b0:439:c144:24cd with SMTP id
 g10-20020a056402090a00b00439c14424cdmr25378456edz.209.1658974047669; Wed, 27
 Jul 2022 19:07:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAFv23QmH4ooXJzX9A0CBObrETZgb9sT4dfh03NZA--fKfZnHDA@mail.gmail.com>
 <87fsixz8cb.wl-maz@kernel.org> <CAFv23Q=O29J4K_bdTi_SuThsEZN_SFNNz+bBPQSA+RGCANm6=w@mail.gmail.com>
 <CAAd53p7GGjqpo97VP=uXnJQstKzxCf9Si+ZCD98UsbdJ7oS=SA@mail.gmail.com>
 <CAJZ5v0jYJxk1B1XORLQkGf=R9HDPbUzAjb3_2GUM0XtfmyXfZA@mail.gmail.com> <CAAd53p77SiW+uuZM9FAXiPooC-CN7BxVwj1LPJjEfbZZb_q14g@mail.gmail.com>
In-Reply-To: <CAAd53p77SiW+uuZM9FAXiPooC-CN7BxVwj1LPJjEfbZZb_q14g@mail.gmail.com>
From:   AceLan Kao <acelan.kao@canonical.com>
Date:   Thu, 28 Jul 2022 10:07:16 +0800
Message-ID: <CAFv23QkMZiXs8N_+gt0d7aFf=iNt3ynVBG2RrUjW_mqNvCwHAw@mail.gmail.com>
Subject: Re: There are not enough CPU0 APIC IRQs while doing IRQ migration
 during S3
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kai-Heng Feng <kai.heng.feng@canonical.com> =E6=96=BC 2022=E5=B9=B47=E6=9C=
=8821=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8811:02=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Wed, Jul 20, 2022 at 6:11 PM Rafael J. Wysocki <rafael@kernel.org> wro=
te:
> >
> > On Wed, Jul 20, 2022 at 5:16 AM Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:
> > >
> > > [+Cc Rafael, linux-pm]
> > >
> > > On Wed, Jul 20, 2022 at 10:53 AM AceLan Kao <acelan.kao@canonical.com=
> wrote:
> > > >
> > > > Marc Zyngier <maz@kernel.org> =E6=96=BC 2022=E5=B9=B47=E6=9C=8819=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=886:48=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > > > >
> > > > > [- Jason]
> > > > >
> > > > > On Tue, 19 Jul 2022 06:55:21 +0100,
> > > > > AceLan Kao <acelan.kao@canonical.com> wrote:
> > > > > >
> > > > > > HI all,
> > > > > >
> > > > > > I encountered an issue while doing S3, it shows below message a=
nd then
> > > > > > failed to enter S3
> > > > > > [  106.731140] CPU 31 has 116 vectors, 85 available. Cannot dis=
able CPU
> > > > > > [  106.731551] ACPI: \_PR_.C01F: Found 2 idle states
> > > > > > [  106.732610] Error taking CPU31 down: -28
> > > > > > [  106.732612] Non-boot CPUs are not disabled
> > > > > >
> > > > > > CPU: AMD Ryzen Threadripper PRO 3955WX 16-Cores
> > > > > > Kernel: v5.19-rc7
> > > > > > There are 5 PCI to 4 type-c ports USB cards on the machine, and=
 It
> > > > > > wouldn't lead to the issue if only 4 cards are plugged. So, it =
looks
> > > > > > like it can't handle 5 cards, and failed on the IRQ migration.
> > > > > >
> > > > > > The workaround provided by kaiheng is to release the irq while
> > > > > > suspending and request irq while resuming.
> > > > > > I'm wondering do we have a better solution for this kind of iss=
ue?
> > > > > > Thanks.
> > > > > >
> > > > > > diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> > > > > > index edc6881c8a1b..91c79b21cb57 100644
> > > > > > --- a/drivers/usb/host/xhci.c
> > > > > > +++ b/drivers/usb/host/xhci.c
> > > > > > @@ -17,6 +17,7 @@
> > > > > > #include <linux/slab.h>
> > > > > > #include <linux/dmi.h>
> > > > > > #include <linux/dma-mapping.h>
> > > > > > +#include <linux/suspend.h>
> > > > > >
> > > > > > #include "xhci.h"
> > > > > > #include "xhci-trace.h"
> > > > > > @@ -1079,6 +1080,9 @@ int xhci_suspend(struct xhci_hcd *xhci, b=
ool do_wakeup)
> > > > > >                                __func__);
> > > > > >        }
> > > > > >
> > > > > > +       if (pm_suspend_via_firmware())
> > > > > > +               xhci_cleanup_msix(xhci);
> > > > >
> > > > > I'm a bit clueless when it comes to the combination of x86 and xh=
ci,
> > > > > but doesn't this prevent resuming on a xhci interrupt?
> > > > The PCI cards provide 4 type-c USB ports, and in the beginning we
> > > > found that removing one PCI card fixed the issue, so we were trying=
 to
> > > > fix the issue in xhci driver.
> > > > The USB ports on the PCI cards can't resume the system from S3 even
> > > > without the workaround,
> > > > but the USB ports on the rear panel of the motherboard still work w=
ith
> > > > the workaround.
> > >
> > > The isn't xHCI specific. The issue here is that CPU0 APIC doesn't hav=
e
> > > enough IRQ vector for ACPI S3 suspend.
> > > Ideally we don't want to tear down IRQs during suspend, but for this
> > > case minimizing IRQ numbers means successful S3.
> > >
> > > So maybe we can have a suspend flow like this:
> > > - At the beginning of suspend, check if there's enough free IRQ for
> > > CPU0 migration.
> > > - If there isn't enough free slots, hint drivers to tear down non-wak=
e
> > > IRQs. Maybe use a global variable if we don't want to add a new
> > > parameter to current PM ops.
> > > - If it's still not enough, abort suspend.
> > >
> > > For suspend that doesn't unplug CPU like suspend-to-idle, no
> > > modification is needed.
> > > I wonder if that makes sense?
> >
> > Quite probably, IRQs need not be migrated during system suspend, so it
> > should be possible to avoid doing that entirely on "hot remove" if it
> > is part of the suspend flow.
>
> So is it required to disable all CPUs except CPU0 for ACPI S3?
> ACPI spec rev 6.3, "7.4.2.4 System \_S3 State" says "The processors
> are not executing instructions. The processor-complex context is not
> maintained." it doesn't say the CPUs have to be disabled.
> So as long as CPUs are quiesced, is pm_sleep_disable_secondary_cpus()
> still needed for S3?
>
I'm still doing some tests for this issue and tried to not migrate
IRQs or do not offline CPUs while suspending,
but I can't find a good path to do it well, and the system may fail to
enter suspended or fail to be waken up.

I also checked the available vectors when the CPU is going offline,
and found the available vector reduces by around 200 when one CPU is
offline.
So that makes the available vectors are not sufficient at the end,
I'm wondering if the calculation for the deducted vectors is reasonable?
Or could we allocate more vectors in the beginning?

u@u-M12SWA-TF:~$ sudo cat /sys/kernel/debug/irq/domains/VECTOR
name:   VECTOR
size:   0
mapped: 371
flags:  0x00000003
Online bitmaps:       32
Global available:   6150
Global reserved:      57
Total allocated:     282
System: 39: 0-19,29,32,50,128,236,240-242,244,246-255
| CPU | avl | man | mac | act | vectors
    0   192     1     1    9  33-40,48
    1   191     1     1   10  33-42
    2   192     1     1    9  33-41
    3   192     1     1    9  33-36,38-42
    4   192     1     1    9  33-36,38-42
    5   192     1     1    9  33-40,43
    6   193     1     1    8  33-36,38-39,41-42
    7   191     1     1   10  33-42
    8   192     1     1    9  33-38,40-42
    9   192     1     1    9  33-41
   10   192     1     1    9  33-41
   11   192     1     1    9  33-41
   12   192     1     1    9  33-41
   13   194     1     1    7  33-36,38,40-41
   14   193     1     1    8  33-36,38-41
   15   193     1     1    8  33-38,40-41
   16   192     1     1    9  33-41
   17   194     1     1    7  33-39
   18   192     1     1    9  33-41
   19   191     1     1   10  33-42
   20   193     1     1    8  33-38,40,42
   21   192     1     1    9  33-38,40-42
   22   192     1     1    9  33-40,42
   23   192     1     1    9  33-41
   24   191     1     1   10  33-37,39-43
   25   192     1     1    9  33-41
   26   192     1     1    9  33-40,43
   27   193     1     1    8  33-40
   28   193     1     1    8  33-39,42
   29   192     1     1    9  33-41
   30   192     1     1    9  33-41
   31   192     1     1    9  33-41
u@u-M12SWA-TF:~$ sudo chcpu -d 1
CPU 1 disabled
u@u-M12SWA-TF:~$ sudo cat /sys/kernel/debug/irq/domains/VECTOR
name:   VECTOR
size:   0
mapped: 371
flags:  0x00000003
Online bitmaps:       31
Global available:   5950
Global reserved:      57
Total allocated:     281
System: 39: 0-19,29,32,50,128,236,240-242,244,246-255
| CPU | avl | man | mac | act | vectors
    0   192     1     1    9  33-40,48
    2   192     1     1    9  33-41
    3   192     1     1    9  33-36,38-42
    4   192     1     1    9  33-36,38-42
    5   192     1     1    9  33-40,43
    6   193     1     1    8  33-36,38-39,41-42
    7   191     1     1   10  33-42
    8   192     1     1    9  33-38,40-42
    9   192     1     1    9  33-41
   10   192     1     1    9  33-41
   11   192     1     1    9  33-41
   12   192     1     1    9  33-41
   13   193     1     1    8  33-38,40-41
   14   193     1     1    8  33-36,38-41
   15   193     1     1    8  33-38,40-41
   16   192     1     1    9  33-41
   17   186     1     1   15  33-47
   18   192     1     1    9  33-41
   19   191     1     1   10  33-42
   20   193     1     1    8  33-38,40,42
   21   192     1     1    9  33-38,40-42
   22   192     1     1    9  33-40,42
   23   192     1     1    9  33-41
   24   191     1     1   10  33-37,39-43
   25   192     1     1    9  33-41
   26   192     1     1    9  33-40,43
   27   193     1     1    8  33-40
   28   193     1     1    8  33-39,42
   29   192     1     1    9  33-41
   30   192     1     1    9  33-41
   31   192     1     1    9  33-41
u@u-M12SWA-TF:~$ sudo chcpu -d 2
CPU 2 disabled
u@u-M12SWA-TF:~$ sudo cat /sys/kernel/debug/irq/domains/VECTOR
name:   VECTOR
size:   0
mapped: 371
flags:  0x00000003
Online bitmaps:       30
Global available:   5750
Global reserved:      57
Total allocated:     280
System: 39: 0-19,29,32,50,128,236,240-242,244,246-255
| CPU | avl | man | mac | act | vectors
    0   192     1     1    9  33-40,48
    3   192     1     1    9  33-36,38-42
    4   192     1     1    9  33-36,38-42
    5   192     1     1    9  33-40,43
    6   193     1     1    8  33-36,38-39,41-42
    7   191     1     1   10  33-42
    8   192     1     1    9  33-38,40-42
    9   192     1     1    9  33-41
   10   192     1     1    9  33-41
   11   192     1     1    9  33-41
   12   192     1     1    9  33-41
   13   193     1     1    8  33-38,40-41
   14   193     1     1    8  33-36,38-41
   15   193     1     1    8  33-38,40-41
   16   192     1     1    9  33-41
   17   186     1     1   15  33-47
   18   184     1     1   17  33-49
   19   191     1     1   10  33-42
   20   193     1     1    8  33-38,40,42
   21   192     1     1    9  33-38,40-42
   22   192     1     1    9  33-40,42
   23   192     1     1    9  33-41
   24   191     1     1   10  33-37,39-43
   25   192     1     1    9  33-41
   26   192     1     1    9  33-40,43
   27   193     1     1    8  33-40
   28   193     1     1    8  33-39,42
   29   192     1     1    9  33-41
   30   192     1     1    9  33-41
   31   192     1     1    9  33-41
