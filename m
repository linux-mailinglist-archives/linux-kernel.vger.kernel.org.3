Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CFA57AE2B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240284AbiGTCx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbiGTCxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:53:54 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCBF52E42
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:53:51 -0700 (PDT)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D2D743F127
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 02:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1658285628;
        bh=gob9NxQ6ggYl9WM0KIFG2awSk2lOWPYON8bIG1P4U8I=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=FmJXW4h4kZEBb5nhQLIhinrCEeoIVTjj6syZbPRGfBEoi1UwbLP8kilKmUS1+kuhP
         Oaegb8chcWMlcizHY+q0UX0P7qxZJJ7ind6BKJIidzGuoZzdSXDXxNMHbvlJ5Hcqgr
         cjP3BIqsEHn4oly7afUltd8WF2P0eU1AEq1Hf8g3+PIuMtunHOPiSKCdCoyAQCOoPQ
         /1AhQKCCpZVw8LvoOnQCR8jaRJEvCXXKCKS6EoGZrvJnysC5ISJdIwfY6hC/Bt9WqP
         QauzIqRoxBOQ4lFRYo2BkrdiuB9CGTWklmXLc9ZaH8Az2GpRr3vv3Zm0DSz33Gcj9c
         HXgqB//FdNIYw==
Received: by mail-ed1-f72.google.com with SMTP id y21-20020a056402359500b0043adf65d1a0so11123037edc.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:53:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gob9NxQ6ggYl9WM0KIFG2awSk2lOWPYON8bIG1P4U8I=;
        b=NS7OovTeQVWs2/n39Twkc1Q7+hBVZbG4HuEEul3m4jXyuA3j86Ol5BrzlCLUO86fRW
         3EfiHt+UUPMBbGOqxPInC5lh3nwNhUmaGLZdok6rdNglyYqmfpL4HWt0Et1tcec2bAlk
         q82lw75s7a4H4wrqYPiPm+tYMZabJmQy9dS0smCcHXD2Vh7TxSLBHeA79+JSoI5n7L0v
         CH+gv3TIXREgq76je3IyhtW4dEJ4HWhOJTqG7uPc159XSM46PUfNO12GoP94ATzP8QfB
         wgKMPDVE4FyUZR0/NYuSX6gYygvnE0gfGXbAPXHhAIHohyaB5qj9gh3WmDCUwrvhZ1Vf
         Kjbg==
X-Gm-Message-State: AJIora99i+otAuGjU7W3wv3hz6JtvxzTJVZ1G8GH8mGt/JyKdre7/n5M
        N5hP4hxztyLG1i9P1oA08dl9OPu0NxgFXzLYhf2hsd7BauTMYAm/28WaxeYIMgBAhyw23DJYlc+
        DdYOegu7vPbqpN0c5/JkBBWKhZvtDWzFf84X6z/Kw9aacg9vN8w0+7CRzGQ==
X-Received: by 2002:a05:6402:1d53:b0:43a:9ba7:315b with SMTP id dz19-20020a0564021d5300b0043a9ba7315bmr48379664edb.350.1658285628300;
        Tue, 19 Jul 2022 19:53:48 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tyHGAiksDLj4Jve2f/VZJY2zE+GVloIptw1qEFSJKteG3aPVFvdmyP0dc1jDV1HF2wr7JCLGAVhHDHrgBgaW4=
X-Received: by 2002:a05:6402:1d53:b0:43a:9ba7:315b with SMTP id
 dz19-20020a0564021d5300b0043a9ba7315bmr48379653edb.350.1658285628077; Tue, 19
 Jul 2022 19:53:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAFv23QmH4ooXJzX9A0CBObrETZgb9sT4dfh03NZA--fKfZnHDA@mail.gmail.com>
 <87fsixz8cb.wl-maz@kernel.org>
In-Reply-To: <87fsixz8cb.wl-maz@kernel.org>
From:   AceLan Kao <acelan.kao@canonical.com>
Date:   Wed, 20 Jul 2022 10:53:37 +0800
Message-ID: <CAFv23Q=O29J4K_bdTi_SuThsEZN_SFNNz+bBPQSA+RGCANm6=w@mail.gmail.com>
Subject: Re: There are not enough CPU0 APIC IRQs while doing IRQ migration
 during S3
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Zyngier <maz@kernel.org> =E6=96=BC 2022=E5=B9=B47=E6=9C=8819=E6=97=A5 =
=E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=886:48=E5=AF=AB=E9=81=93=EF=BC=9A
>
> [- Jason]
>
> On Tue, 19 Jul 2022 06:55:21 +0100,
> AceLan Kao <acelan.kao@canonical.com> wrote:
> >
> > HI all,
> >
> > I encountered an issue while doing S3, it shows below message and then
> > failed to enter S3
> > [  106.731140] CPU 31 has 116 vectors, 85 available. Cannot disable CPU
> > [  106.731551] ACPI: \_PR_.C01F: Found 2 idle states
> > [  106.732610] Error taking CPU31 down: -28
> > [  106.732612] Non-boot CPUs are not disabled
> >
> > CPU: AMD Ryzen Threadripper PRO 3955WX 16-Cores
> > Kernel: v5.19-rc7
> > There are 5 PCI to 4 type-c ports USB cards on the machine, and It
> > wouldn't lead to the issue if only 4 cards are plugged. So, it looks
> > like it can't handle 5 cards, and failed on the IRQ migration.
> >
> > The workaround provided by kaiheng is to release the irq while
> > suspending and request irq while resuming.
> > I'm wondering do we have a better solution for this kind of issue?
> > Thanks.
> >
> > diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> > index edc6881c8a1b..91c79b21cb57 100644
> > --- a/drivers/usb/host/xhci.c
> > +++ b/drivers/usb/host/xhci.c
> > @@ -17,6 +17,7 @@
> > #include <linux/slab.h>
> > #include <linux/dmi.h>
> > #include <linux/dma-mapping.h>
> > +#include <linux/suspend.h>
> >
> > #include "xhci.h"
> > #include "xhci-trace.h"
> > @@ -1079,6 +1080,9 @@ int xhci_suspend(struct xhci_hcd *xhci, bool do_w=
akeup)
> >                                __func__);
> >        }
> >
> > +       if (pm_suspend_via_firmware())
> > +               xhci_cleanup_msix(xhci);
>
> I'm a bit clueless when it comes to the combination of x86 and xhci,
> but doesn't this prevent resuming on a xhci interrupt?
The PCI cards provide 4 type-c USB ports, and in the beginning we
found that removing one PCI card fixed the issue, so we were trying to
fix the issue in xhci driver.
The USB ports on the PCI cards can't resume the system from S3 even
without the workaround,
but the USB ports on the rear panel of the motherboard still work with
the workaround.
