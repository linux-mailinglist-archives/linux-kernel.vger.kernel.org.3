Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDB746884A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 00:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbhLDXlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 18:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233608AbhLDXla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 18:41:30 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463E6C0613F8
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 15:38:04 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id a11-20020a4ad1cb000000b002c2657270a0so3219860oos.8
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 15:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=trSplw+nhot93KoeiH0yY3mLr5CNf5Ad5Ms9Knh6UUA=;
        b=YXQtOnAsYXUdf/SzQIruzpKzFHzEydiR7SArS5CbCur6LJTwlPvdYpHhiwiKumz8XE
         RTNtr5Ox3jyzQ/aU3hPS57YShiWv4hIl+HXGTtBqk+mNgRuWSxvVmBAAt1e6yQJM62I+
         5WitJ00hhsB6JzAAQewHOJNeAyWHHGOY3Rk4Hc/PpmlBpGSwuyszLECAiv1ShtuxUQcV
         3Qe5AW/y3Hb+8KpwCcghHzqPAQHGjM/xycrS++wbZ9gwnpAe1yWSGAaM6j1ZJSXYaMP5
         9Fwo4FLPlPCI3oqvoZSbsap1v0ZKB28Qc2vOPVEXRTkj/l1Mh9iSV9od+VsSUo4fhix9
         8pKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=trSplw+nhot93KoeiH0yY3mLr5CNf5Ad5Ms9Knh6UUA=;
        b=inQ4u5pmkSUk+Lw/sh+unosfZoci3+RssR8oO5w4HGDwtRvX+/WTmKS8MTNdmjxb+d
         M8rVc7ePoVf2WYRqB1uJ+k2s6vsXn60zWavrrN/inrUJ2qw4y6ZpOvKWjT73tVJzKhr2
         NwzdfstUg0Ks2b1GEKmZZZTBjuDUMh92/NNTJqEBscsyrsvOD8C2p9WhkCQq/lR1YsPU
         RFjw1iIOEGSsIGXi28fs/md06nfkkqssycqXi7X99xqrPb7QzSKe6HtstjTmxtC50Odv
         bTAAp40QrchQgwiOo52eV1cSQSdNwJk53SXu/HRL/EodwHOcSl6rtSVGrbocHUEsVDrC
         vL8Q==
X-Gm-Message-State: AOAM5317YeiiQhBBdtx+RJzmIrUununTzF0sqTg1zOmFNj0dazOCrbzO
        eL2vgO4gNeT1fRZC8xfx5iKdK0livYBknPenf2KCnw==
X-Google-Smtp-Source: ABdhPJxAqv/xn3C5dPzAl5HRpbDK5uEX+KGGVV8X5QGIJ0tMt85CbgX1CE1+8Vz21+/VSbs77CahfO1GxRFwfb6pyFc=
X-Received: by 2002:a4a:e155:: with SMTP id p21mr17644649oot.84.1638661083480;
 Sat, 04 Dec 2021 15:38:03 -0800 (PST)
MIME-Version: 1.0
References: <20211202095255.165797-1-herve.codina@bootlin.com> <20211202095255.165797-6-herve.codina@bootlin.com>
In-Reply-To: <20211202095255.165797-6-herve.codina@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 5 Dec 2021 00:37:52 +0100
Message-ID: <CACRpkdbVfpmFKcdmNtcbpozuMt+EeJSmCuF4nJ--8oHrnyvLEA@mail.gmail.com>
Subject: Re: [PATCH 5/6] irq: spear-shirq: Add support for IRQ 0..6
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 2, 2021 at 10:53 AM Herve Codina <herve.codina@bootlin.com> wrote:

> IRQ 0..7 are not supported by the driver for SPEAr320 SOC family.
>
> IRQ 0 is not reserved in SPEAr320 SOC (assigned to GPIOINT).
> Furthermore, in SPEAr320s SOC variant, IRQ 0..6 are assigned
> as follow:
>   IRQ 6 - NGPIO_INTR: Combined status of edge programmable
>                       interrupts from GPIO ports
>   IRQ 5 - TX_OR_INTR: I2S interrupt on Transmit FIFO overrun
>   IRQ 4 - TX_EMP_INTR: I2S interrupt on Transmit FIFO empty
>   IRQ 3 - RX_OR_INTR: I2S interrupt on Receive FIFO overrun
>   IRQ 2 - RX_DA_INTR: I2S interrupt on data available in Receive FIFO
>   IRQ 1 - Reserved
>   IRQ 0 - GPIO_INTR: Legacy interrupt from GPIO ports
>
> Add support for these IRQs in SPEAr320 SOC family.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
