Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488D0507C38
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 23:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358105AbiDSV7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 17:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346765AbiDSV7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 17:59:13 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A08740A26
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:56:29 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2ef4a241cc5so180737247b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o5U1cn6+o5nTDbwZR88CUNrm0hxDesFUSzgqVEiUi5k=;
        b=Rgs08pIBuoNzE/5T67y5y27kHtxOzCdiKXIXfbLP1qlmASEYTIEu/XjHcO/rDO14A6
         GQofJtAwB0/xUZLDKRcnIEIXp2FsW1WwyL7vydwDc0dU8fbMhwh8hBmxz6STE937cn9Y
         q2wjhmuR4iVMC9hCbZvSiEDPnjzDEO/nDjs153YTLRSBVAhoAqw65EqVZfN28Kkxyobj
         khYzChEq1we63DZSaHCfxzxQG4wjqi+tM4F/RZDXbUcfs0nyU7WRkd+vyTJaweEv1IJT
         35X+lqw214/+wupT0lHG8hOkDdMPQkm/VkaSnzhZ39CvUL0swNgKVlFkhcusk9FLuMlX
         IKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o5U1cn6+o5nTDbwZR88CUNrm0hxDesFUSzgqVEiUi5k=;
        b=YkbBM7SR/m1FHdJ/WzLcu+VMuMxp9zX0aCWd6r2XrMMWcuVQ0LwQW3E2cYpsP74Xah
         rLjdBScHaB3Xw6es8S3MG964/LLnNDAxJpptX5rRc+xHwg1Qnn70aLVJd6oDm8tP7Pxe
         U6KHuj2C6oc8j0d72J3X3raLgu1XCAT+r42j/x8HAyVw5A2Wr5LVcdpJFR3seUtp0t/l
         zSgNk7hlmYMeCOSdRt3s4LVnlDCwcaISAnlKQWd3zfBHXOVRRCpJOrYHYmu8kdOWaSYi
         GIuqIxOt/vwKrLdWFFbr0LuvMM/p5adDMcVcazP7tXssx0BefdxFbP+Hgvfd1xpgpeRs
         VOzQ==
X-Gm-Message-State: AOAM530FMJ8ah66I9JB/01aBpgSBM8Iqa8isZaY/LMvkJFugDc28NPxO
        X+QHKF15WW1aa94w03ZfyjAexAem7pI8yXiNfdXf7Q==
X-Google-Smtp-Source: ABdhPJxFEHSE/pis5LX657I4YxyA6XvsGZ/n2P/4VzVlx4ahwA45KoXz1mcjGguqs6qs5VDzjUIJdwSIBd9PekozwM0=
X-Received: by 2002:a81:b50d:0:b0:2e5:b653:7e97 with SMTP id
 t13-20020a81b50d000000b002e5b6537e97mr19299462ywh.140.1650405388892; Tue, 19
 Apr 2022 14:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220405135444.199295-1-maz@kernel.org>
In-Reply-To: <20220405135444.199295-1-maz@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 19 Apr 2022 23:56:17 +0200
Message-ID: <CACRpkdbdo=Es8VU_td6S3LCVCsYpcWC=pW1SGDXEAe2Gp8uZcA@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] gpiolib: Handle immutable irq_chip structures
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 5, 2022 at 3:55 PM Marc Zyngier <maz@kernel.org> wrote:

> Not only this breaks when an irq_chip structure is made const (which
> really should be the default case), but it also forces this structure
> to be copied at nauseam for each instance of the GPIO block, which is
> a waste of memory.
>
> My current approach is to add a new irq_chip flag (IRQCHIP_IMMUTABLE)
> which does what it says on the tin: don't you dare writing to them.
> Gpiolib is further updated not to install its own callbacks, and it
> becomes the responsibility of the driver to call into the gpiolib when
> required. This is similar to what we do for other subsystems such as
> PCI-MSI.
>
> 5 drivers are updated to this new model: M1, QC, Tegra, pl061 and AMD
> (as I actively use them) keeping a single irq_chip structure, marking
> it const, and exposing the new flag.
>
> Nothing breaks, the volume of change is small, the memory usage goes
> down and we have fewer callbacks that can be used as attack vectors.
> What's not to love?
>
> * From v1 [1]:
>   - pl061 and AMD drivers converted
>   - New helpers to keep the changes small
>   - New warning for non-converted drivers
>   - Documentation and TODO updates
>
> [1] https://lore.kernel.org/r/20220223154405.54912-1-maz@kernel.org
>
> Marc Zyngier (10):
>   gpio: Don't fiddle with irqchips marked as immutable
>   gpio: Expose the gpiochip_irq_re[ql]res helpers
>   gpio: Add helpers to ease the transition towards immutable irq_chip
>   gpio: tegra186: Make the irqchip immutable
>   gpio: pl061: Make the irqchip immutable
>   pinctrl: apple-gpio: Make the irqchip immutable
>   pinctrl: msmgpio: Make the irqchip immutable
>   pinctrl: amd: Make the irqchip immutable
>   gpio: Update TODO to mention immutable irq_chip structures
>   Documentation: Update the recommended pattern for GPIO irqchips

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
