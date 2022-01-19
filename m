Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 992E0493E18
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 17:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355669AbiASQMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 11:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355602AbiASQMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 11:12:25 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55814C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 08:12:24 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id x31-20020a056830245f00b00599111c8b20so3721370otr.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 08:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/vGtPLORiS4o8oqYCG9wkvpb33rPtGx/ltb6A3ipjGQ=;
        b=nHiXddQHq9egKu5SATqkmHcrBRKx9lhhZfmvBf+DprzabfEu0LqYw1j02SXdqAS7Nj
         UdXFib4lYSZxC5Qq9AcDMgfNvM9NCVWM3RyGTWnHgni5aAt6Pxr2ivoAOB3vFoCcs2yI
         KeggiddGsTSc27w3URi+hv3L2Rd420D0Tmp/Rxp7MmXv7JhWP/aRire0Oco8B7w7TR3t
         rIBQ8y7IPN24KN0DlLCwkuZ1bZToocSankSWBfD/IiVyf+oY/Vpw84P38E0L0sTWnKEs
         5Q+VlJFueyJ1lDl/3fTkymPyK4umYQX0ByT7Enotzhg4h6EoA1NhZ8f4wX+THFCl0pU2
         l3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/vGtPLORiS4o8oqYCG9wkvpb33rPtGx/ltb6A3ipjGQ=;
        b=pYPt2veVDT/V9OOaa2uWAfJQKPFs7BxB9vrkudwfrl8E8HHNwCKVvvmZksTD0cC1GC
         +Xris19PNWt0/jDzWWPy2x99RCUiP1MDIflJeoxF3eMnrqS3rajwIucs4JxdRwkVRIkq
         zxILg+Ab7iyrkwoa+Qzu+Br3+MuqHAJISGqAP4bQmKOGH+gPm/ei0mT/kYPXiBrj1s8k
         QCawJhxGfe57icJNNghGscGUt9XOy2VPBc+IT81sJ7Ebx6Qmv1Yv6nhJZHYudhJpF7ij
         WJ1st+skJwqHj3PTNtDstPT/G73xsgmIW27GayRzR4+nbh/33seGqiITVgYAV6xBwQRT
         OLdA==
X-Gm-Message-State: AOAM5322iwjSa1xxp2CJDjNz8qNg22tpQrHTT+NyUapxE6WY93codwxV
        SVx1pm0SE9nlDhGWSVvDK8Q94fIVzrge/TITpcjRVA==
X-Google-Smtp-Source: ABdhPJxu2SBeItDzdj36K6MZL1PvG3jgXDGRTv5cAJfadvYZnnxrpf/YEFpVM7KSIOhjoTDBaQO0ppJvc02BQa0NYg4=
X-Received: by 2002:a9d:4719:: with SMTP id a25mr1385525otf.35.1642608743667;
 Wed, 19 Jan 2022 08:12:23 -0800 (PST)
MIME-Version: 1.0
References: <20220104140913.29699-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220104140913.29699-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 19 Jan 2022 17:12:11 +0100
Message-ID: <CACRpkdY-=7dTn8WosPUmQRPkE_VMoupgupYUHYLkwrRrb=1Tig@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: at91-pio4: Use platform_get_irq() to get the interrupt
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 4, 2022 at 3:10 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:

> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
>
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq().
>
> While at it, replace the dev_err() with dev_dbg() as platform_get_irq()
> prints an error message upon error.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Patch applied!

Yours,
Linus Walleij
