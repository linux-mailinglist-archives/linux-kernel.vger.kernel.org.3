Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A8A57B44F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 12:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbiGTKL6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 20 Jul 2022 06:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbiGTKL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 06:11:57 -0400
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBC2545E8;
        Wed, 20 Jul 2022 03:11:56 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id l11so31253227ybu.13;
        Wed, 20 Jul 2022 03:11:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HPxfGl62Grx8smrWYOlzrFoO6DOehrIgEYjXrU1sD0o=;
        b=xkNsGZGVYeood3x9zDpxV25KOZEQt/cuyR4STO1so5VkHbdXzhJuBYDAxyN+Fl4D0Y
         TH/W2gcloj/S7SgSRYnlRA2fUYNzmggBYMZoyz4mxr99N17jIfXpXlN2/4dvfEliCCmk
         Iz3y7pTzSGdPYKtSMUE3N2NibNJHOvLoN3x1t1oE4V5D0mwuYu1LxUaXNkEvNEfsGfp2
         xWd9YcY2lwBRsRpddxMgM+mCQweh8KLFmE6vhC3mAJLkqpiuuKBBCxe22BeeU/QB1d1x
         E4VFwDOBQcbvTZwWe9jap7pC/lgrYEyCsMCKC8Pw/RmgYCeVHaOoogtpTnBZw1xElHN8
         F8bw==
X-Gm-Message-State: AJIora9F/G3DMIqmSHI6m5bbYjla3POb2ELUDSq3WvpNTvZLIc922hWv
        WHxkPaP+a4RqTd47rj74Usqd0yZgxjuRDY1DVBLKIEWW
X-Google-Smtp-Source: AGRyM1t+W3Hm0oVvCSceKj5BBeNajD+cXnrdGlvpODvEOlVC6+3nCFWc6wPhP0rzw9VzQXuULX4Qg/afdDiytzTYfLE=
X-Received: by 2002:a05:6902:154f:b0:66e:e2d3:ce1 with SMTP id
 r15-20020a056902154f00b0066ee2d30ce1mr33331218ybu.365.1658311915502; Wed, 20
 Jul 2022 03:11:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAFv23QmH4ooXJzX9A0CBObrETZgb9sT4dfh03NZA--fKfZnHDA@mail.gmail.com>
 <87fsixz8cb.wl-maz@kernel.org> <CAFv23Q=O29J4K_bdTi_SuThsEZN_SFNNz+bBPQSA+RGCANm6=w@mail.gmail.com>
 <CAAd53p7GGjqpo97VP=uXnJQstKzxCf9Si+ZCD98UsbdJ7oS=SA@mail.gmail.com>
In-Reply-To: <CAAd53p7GGjqpo97VP=uXnJQstKzxCf9Si+ZCD98UsbdJ7oS=SA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Jul 2022 12:11:44 +0200
Message-ID: <CAJZ5v0jYJxk1B1XORLQkGf=R9HDPbUzAjb3_2GUM0XtfmyXfZA@mail.gmail.com>
Subject: Re: There are not enough CPU0 APIC IRQs while doing IRQ migration
 during S3
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     AceLan Kao <acelan.kao@canonical.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 5:16 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> [+Cc Rafael, linux-pm]
>
> On Wed, Jul 20, 2022 at 10:53 AM AceLan Kao <acelan.kao@canonical.com> wrote:
> >
> > Marc Zyngier <maz@kernel.org> 於 2022年7月19日 週二 下午6:48寫道：
> > >
> > > [- Jason]
> > >
> > > On Tue, 19 Jul 2022 06:55:21 +0100,
> > > AceLan Kao <acelan.kao@canonical.com> wrote:
> > > >
> > > > HI all,
> > > >
> > > > I encountered an issue while doing S3, it shows below message and then
> > > > failed to enter S3
> > > > [  106.731140] CPU 31 has 116 vectors, 85 available. Cannot disable CPU
> > > > [  106.731551] ACPI: \_PR_.C01F: Found 2 idle states
> > > > [  106.732610] Error taking CPU31 down: -28
> > > > [  106.732612] Non-boot CPUs are not disabled
> > > >
> > > > CPU: AMD Ryzen Threadripper PRO 3955WX 16-Cores
> > > > Kernel: v5.19-rc7
> > > > There are 5 PCI to 4 type-c ports USB cards on the machine, and It
> > > > wouldn't lead to the issue if only 4 cards are plugged. So, it looks
> > > > like it can't handle 5 cards, and failed on the IRQ migration.
> > > >
> > > > The workaround provided by kaiheng is to release the irq while
> > > > suspending and request irq while resuming.
> > > > I'm wondering do we have a better solution for this kind of issue?
> > > > Thanks.
> > > >
> > > > diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> > > > index edc6881c8a1b..91c79b21cb57 100644
> > > > --- a/drivers/usb/host/xhci.c
> > > > +++ b/drivers/usb/host/xhci.c
> > > > @@ -17,6 +17,7 @@
> > > > #include <linux/slab.h>
> > > > #include <linux/dmi.h>
> > > > #include <linux/dma-mapping.h>
> > > > +#include <linux/suspend.h>
> > > >
> > > > #include "xhci.h"
> > > > #include "xhci-trace.h"
> > > > @@ -1079,6 +1080,9 @@ int xhci_suspend(struct xhci_hcd *xhci, bool do_wakeup)
> > > >                                __func__);
> > > >        }
> > > >
> > > > +       if (pm_suspend_via_firmware())
> > > > +               xhci_cleanup_msix(xhci);
> > >
> > > I'm a bit clueless when it comes to the combination of x86 and xhci,
> > > but doesn't this prevent resuming on a xhci interrupt?
> > The PCI cards provide 4 type-c USB ports, and in the beginning we
> > found that removing one PCI card fixed the issue, so we were trying to
> > fix the issue in xhci driver.
> > The USB ports on the PCI cards can't resume the system from S3 even
> > without the workaround,
> > but the USB ports on the rear panel of the motherboard still work with
> > the workaround.
>
> The isn't xHCI specific. The issue here is that CPU0 APIC doesn't have
> enough IRQ vector for ACPI S3 suspend.
> Ideally we don't want to tear down IRQs during suspend, but for this
> case minimizing IRQ numbers means successful S3.
>
> So maybe we can have a suspend flow like this:
> - At the beginning of suspend, check if there's enough free IRQ for
> CPU0 migration.
> - If there isn't enough free slots, hint drivers to tear down non-wake
> IRQs. Maybe use a global variable if we don't want to add a new
> parameter to current PM ops.
> - If it's still not enough, abort suspend.
>
> For suspend that doesn't unplug CPU like suspend-to-idle, no
> modification is needed.
> I wonder if that makes sense?

Quite probably, IRQs need not be migrated during system suspend, so it
should be possible to avoid doing that entirely on "hot remove" if it
is part of the suspend flow.
