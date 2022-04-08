Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8F74F944B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 13:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbiDHLlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 07:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiDHLlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 07:41:39 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578D631900;
        Fri,  8 Apr 2022 04:39:36 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id r13so16778019ejd.5;
        Fri, 08 Apr 2022 04:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=18wquxzAz+n1ScgoEWY4/IKvflx8A2Z+AYoS3QqfJ8Q=;
        b=VEQC5+bvls2vZOkiJIYl1IXx7Thh7i+nLcFJJZwKWxidPwY8EbyKVR/mOthKGWGe80
         jFMYCChnOfbFTpejdBW83KuqPnKFZvKeJWAkbcooEJQO4I7IHnD96PA5thg7oV+j3lW1
         zd54tBmUVKPot/mup6F9Ct9yjhHmzzexQPpIEkgI24xK6E14j63g8tdk1lrg9nVN99FG
         cHt1wCk6iqvcdSmDnYcDBFzMz/U919wDrm7AMw0VIQXEpaEoeWbxTd1HIt/+vQXtgwMq
         c1uyvfez63x9v1YV6jXX0jMW1DcXN6QK7oz/8pv5A/4qbbnupiAvxQ42YLAJ9zvzYIVh
         mGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=18wquxzAz+n1ScgoEWY4/IKvflx8A2Z+AYoS3QqfJ8Q=;
        b=ePNMih11DzExwjhqvFrCOpnRYTC4MIUteDJ/fU69PQlHqhqqvT/MheJCXhqg/GRn0R
         nQb4YFlWIwKE+qdkKjyI5DT7esryUoY3ZkXKDh+BZ8H/CsvQBVe7AP6D7x3luHN2DGRM
         jYEzGFPSFK20wa/RCITZrdRvh5vSQ2PpxeSdcDdGJVI9bOwQ6oIxz+SDgx17tZqitLw8
         lLR+4t7JQZaBc8yvWksQ4MOc6Rk6fASIaul0G75ZmXMVRY6jOP7d+8O4zvGCRmTfby/d
         GqQLswuKkk7VpWgWzVBtdHtNEAOllGrM5het9P/QxKSZDbqI7SHiVoFgfX9PYV9YPqhi
         qkLg==
X-Gm-Message-State: AOAM530/Yh73IaT+D2i7KGPqNIJ6f/mV0cGaPs/Hyrg42pCyVd77qdpz
        7Ch5hi/4pJhGiSFu/eUl7O/hjVPf8dPUM1ry+ng=
X-Google-Smtp-Source: ABdhPJyx4Hwm0L/rT6G2qrVhVrJfK29yddhRF03FHn7KTlBGfpFZBD/fguFHm5wVg0Jk1STV60qEKREpFAs0jgVsJjY=
X-Received: by 2002:a17:907:968e:b0:6db:aed5:43c8 with SMTP id
 hd14-20020a170907968e00b006dbaed543c8mr17992154ejc.636.1649417974738; Fri, 08
 Apr 2022 04:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220405135444.199295-1-maz@kernel.org>
In-Reply-To: <20220405135444.199295-1-maz@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 8 Apr 2022 14:35:20 +0300
Message-ID: <CAHp75VfxBWw307nxz8mpZHrvD6dFis8XPD0qO0gzWq5q_dL7hg@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] gpiolib: Handle immutable irq_chip structures
To:     Marc Zyngier <maz@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
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
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm@vger.kernel.org,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 6, 2022 at 2:06 PM Marc Zyngier <maz@kernel.org> wrote:
>
> This is a followup from [1].
>
> I recently realised that the gpiolib play ugly tricks on the
> unsuspecting irq_chip structures by patching the callbacks.
>
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

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
for the patches 1-3,9 and 10 after clarifying one example case.

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
>
>  Documentation/driver-api/gpio/driver.rst | 175 ++++++++++++++++++-----
>  drivers/gpio/TODO                        |  19 +++
>  drivers/gpio/gpio-pl061.c                |  32 +++--
>  drivers/gpio/gpio-tegra186.c             |  32 +++--
>  drivers/gpio/gpiolib.c                   |  13 +-
>  drivers/pinctrl/pinctrl-amd.c            |  11 +-
>  drivers/pinctrl/pinctrl-apple-gpio.c     |  29 ++--
>  drivers/pinctrl/qcom/pinctrl-msm.c       |  53 ++++---
>  include/linux/gpio/driver.h              |  16 +++
>  include/linux/irq.h                      |   2 +
>  kernel/irq/debugfs.c                     |   1 +
>  11 files changed, 293 insertions(+), 90 deletions(-)
>
> --
> 2.34.1
>


-- 
With Best Regards,
Andy Shevchenko
