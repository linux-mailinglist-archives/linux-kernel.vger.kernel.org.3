Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C616C5524F7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244729AbiFTUGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236360AbiFTUGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:06:17 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0152AF8;
        Mon, 20 Jun 2022 13:06:16 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id p6-20020a05600c1d8600b0039c630b8d96so6919402wms.1;
        Mon, 20 Jun 2022 13:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oX9lN4QRIjjDytL1egq7FKfqlZ9uKSn9qlbeSJsieqg=;
        b=K+4UeUWjHq6YAI9jmYvUTMkv1gq1iw00GX/6AlYN+9b41Q3kf86nQDTqY6rD37C4HI
         kzPm2mFeTHl+1E1B1XQfdRnKW8+YaELFKaQgGAqgsXl7/q1p71QRVLhIGdeg4j5KK+cP
         3YX3ykOuY2lgJL2B7erq/iMhopV+WmK1QZ8/MAPeoCMn4tyiCnMezfoZOyzEos9QqFg2
         e5w+U0RJhQvBhZddSX2H2SbdIyiKQLQYRn4o5iDRWV3n6i8JNHC0MqRAoimLsqSlXU0f
         qGvg/aHb4Vfv5PQh5RZ68Qw5K5jk6ukus9q+UPCgwRCPHKmP1bzrm1D+okCYj+yUNj2Q
         +fUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oX9lN4QRIjjDytL1egq7FKfqlZ9uKSn9qlbeSJsieqg=;
        b=a8H96RgpN96G0T5Iv7wKFAuPnjIPjQ50bAsCth6/GDrxHPSXSmVPztD2BQ77zhcG8F
         RfNj5WoCvLjcildybIeqYJnFWSpzuSdFwX9rGQwiTjccEiBJ+Qo1D79g+mXOeWEJIytq
         AFGHmVMgaLvIx0sT30N6EpDwy4wuz4ZuIlg9WHJyJ6wtGd88t7N8SI8VOwX4Cjg/HNx0
         5c+fsydMBXXX8v+2tlhdLlfZQ+PI+6hP0LXgYzWhXaODPFOfyMFUmb+qJgZMyK+9lubo
         SORdpWS4TE2Yc0uziplsd/SJ8HtCyswKOvXV9uI95xptCN/UV06uvweFMPu+ywGXqCGi
         z5vw==
X-Gm-Message-State: AOAM532QsphJ9yvxqwEy8cryQ6/1/6cE4NFWINYRdDIkKeZAr9bjNkK/
        lAYSSK6Qg7ypgFku5HCWTqE=
X-Google-Smtp-Source: ABdhPJxsi6sQIkVr9H0Bu1PTh/rzJ3ELem1KRMbimP0CLQUhYJkhAnA3ChsXiGO+dNs73Bpag9foIA==
X-Received: by 2002:a05:600c:3acc:b0:39c:7427:d379 with SMTP id d12-20020a05600c3acc00b0039c7427d379mr36991978wms.32.1655755574785;
        Mon, 20 Jun 2022 13:06:14 -0700 (PDT)
Received: from localhost (92.40.169.68.threembb.co.uk. [92.40.169.68])
        by smtp.gmail.com with ESMTPSA id eh1-20020a05600c61c100b003973d425a7fsm17910543wmb.41.2022.06.20.13.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:06:14 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        srinivas.kandagatla@linaro.org, bgoswami@codeaurora.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        cw00.choi@samsung.com, krzysztof.kozlowski@linaro.org,
        b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        michael@walle.cc, linus.walleij@linaro.org, brgl@bgdev.pl,
        tglx@linutronix.de, maz@kernel.org, lee.jones@linaro.org,
        mani@kernel.org, cristian.ciocaltea@gmail.com, wens@csie.org,
        tharvey@gateworks.com, rjones@gateworks.com,
        mazziesaccount@gmail.com, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        jernej.skrabec@gmail.com, samuel@sholland.org, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        alsa-devel@alsa-project.org
Subject: [PATCH 00/49] regmap-irq cleanups and refactoring
Date:   Mon, 20 Jun 2022 21:05:55 +0100
Message-Id: <20220620200644.1961936-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Here's a bunch of cleanups for regmap-irq focused on simplifying the API
and generalizing it a bit. It's broken up into three refactors, focusing
on one area at a time.

* Patches 01 and 02 are straightforward bugfixes, independent of the
  rest of the series. Neither of the bugs are triggered by in-tree
  drivers but they might be worth picking up early anyhow.

* Patches 03-13 clean up everything related to configuring IRQ types.

* Patches 14-45 deal with mask/unmask registers. First, make unmask
  registers behave more intuitively and usefully, and get rid of the
  mask_invert flag in favor of describing inverted mask registers as
  unmask registers. Second, make the mask_writeonly flag more useful
  and enable it for two chips where it makes sense.

* Patches 46-49 refactor sub_irq_reg() as a get_irq_reg() callback,
  and use that to eliminate the not_fixed_stride flag.

The approach I used when refactoring is pretty simple: (1) introduce new
functionality in regmap-irq, (2) convert the drivers, and (3) remove any
old code. Nothing should break in the middle.

The patches can be re-ordered to some extent if that's preferable, but
it's best to add get_irq_reg() last to avoid having to think about how
it interacts with features that'll be removed anyway.

I can't test most of the devices affected by this series so a lot of the
code is only build tested. I've tested on real hardware with my AXP192
patchset[1], although it only provides limited code coverage.

qcom-pm8008 in particular deserves careful testing - it used all of the
features touched by the refactors and required the most changes. Other
drivers only required trivial changes but there are three of them worth
mentioning: wcd943x, wcd9335, and wcd938x. They have suspicious looking
IRQ type definitions and I'm pretty sure aren't working properly, but
I can't fix them myself. The refactor shouldn't affect their behavior
so how / when / if they get fixed shouldn't be much of an issue.

Oh, and I added the 'mask_writeonly' flag and volatile ranges to the
stpmic1 driver based on its datasheet[2] as a small optimization. It's
probably fine but testing would be a good idea.

[1]: https://lore.kernel.org/linux-iio/20220618214009.2178567-1-aidanmacdonald.0x0@gmailcom/
[2]: https://www.st.com/resource/en/datasheet/stpmic1.pdf

Aidan MacDonald (49):
  regmap-irq: Fix a bug in regmap_irq_enable() for type_in_mask chips
  regmap-irq: Fix offset/index mismatch in read_sub_irq_data()
  regmap-irq: Remove an unnecessary restriction on type_in_mask
  regmap-irq: Introduce config registers for irq types
  mfd: qcom-pm8008: Convert irq chip to config regs
  mfd: wcd934x: Convert irq chip to config regs
  sound: soc: codecs: wcd9335: Convert irq chip to config regs
  sound: soc: codecs: wcd938x: Remove spurious type_base from irq chip
  mfd: max77650: Remove useless type_invert flag
  regmap-irq: Remove virtual registers support
  regmap-irq: Remove old type register support, refactor
  regmap-irq: Remove unused type_reg_stride field
  regmap-irq: Remove unused type_invert flag
  regmap-irq: Do not use regmap_irq_update_bits() for wake regs
  regmap-irq: Change the behavior of mask_writeonly
  regmap-irq: Rename regmap_irq_update_bits()
  regmap-irq: Add broken_mask_unmask flag
  mfd: qcom-pm8008: Add broken_mask_unmask irq chip flag
  mfd: stpmic1: Add broken_mask_unmask irq chip flag
  regmap-irq: Fix inverted handling of unmask registers
  mfd: tps65090: replace irqchip mask_invert with unmask_base
  mfd: sun4i-gpadc: replace irqchip mask_invert with unmask_base
  mfd: sprd-sc27xx-spi: replace irqchip mask_invert with unmask_base
  mfd: rt5033: replace irqchip mask_invert with unmask_base
  mfd: rohm-bd71828: replace irqchip mask_invert with unmask_base
  mfd: rn5t618: replace irqchip mask_invert with unmask_base
  mfd: gateworks-gsc: replace irqchip mask_invert with unmask_base
  mfd: axp20x: replace irqchip mask_invert with unmask_base
  mfd: atc260x: replace irqchip mask_invert with unmask_base
  mfd: 88pm800: replace irqchip mask_invert with unmask_base
  mfd: max14577: replace irqchip mask_invert with unmask_base
  mfd: max77693: replace irqchip mask_invert with unmask_base
  mfd: rohm-bd718x7: drop useless mask_invert flag on irqchip
  mfd: max77843: drop useless mask_invert flag on irqchip
  extcon: max77843: replace irqchip mask_invert with unmask_base
  extcon: sm5502: drop useless mask_invert flag on irqchip
  extcon: rt8973a: drop useless mask_invert flag on irqchip
  irqchip: sl28cpld: replace irqchip mask_invert with unmask_base
  gpio: sl28cpld: replace irqchip mask_invert with unmask_base
  mfd: stpmic1: Fix broken mask/unmask in irq chip
  mfd: stpmic1: Enable mask_writeonly flag for irq chip
  mfd: qcom-pm8008: Fix broken mask/unmask in irq chip
  mfd: qcom-pm8008: Enable mask_writeonly flag for irq chip
  regmap-irq: Remove broken_mask_unmask flag
  regmap-irq: Remove mask_invert flag
  regmap-irq: Refactor checks for status bulk read support
  regmap-irq: Add get_irq_reg() callback
  mfd: qcom-pm8008: Use get_irq_reg() for irq chip
  regmap-irq: Remove not_fixed_stride flag

 drivers/base/regmap/regmap-irq.c | 457 ++++++++++++++-----------------
 drivers/extcon/extcon-max77843.c |   3 +-
 drivers/extcon/extcon-rt8973a.c  |   1 -
 drivers/extcon/extcon-sm5502.c   |   2 -
 drivers/gpio/gpio-sl28cpld.c     |   3 +-
 drivers/irqchip/irq-sl28cpld.c   |   3 +-
 drivers/mfd/88pm800.c            |   3 +-
 drivers/mfd/atc260x-core.c       |   6 +-
 drivers/mfd/axp20x.c             |  21 +-
 drivers/mfd/gateworks-gsc.c      |   3 +-
 drivers/mfd/max14577.c           |   7 +-
 drivers/mfd/max77650.c           |   1 -
 drivers/mfd/max77693.c           |   6 +-
 drivers/mfd/max77843.c           |   1 -
 drivers/mfd/qcom-pm8008.c        | 131 ++++-----
 drivers/mfd/rn5t618.c            |   3 +-
 drivers/mfd/rohm-bd71828.c       |   6 +-
 drivers/mfd/rohm-bd718x7.c       |   1 -
 drivers/mfd/rt5033.c             |   3 +-
 drivers/mfd/sprd-sc27xx-spi.c    |   3 +-
 drivers/mfd/stpmic1.c            |   7 +-
 drivers/mfd/sun4i-gpadc.c        |   3 +-
 drivers/mfd/tps65090.c           |   3 +-
 drivers/mfd/wcd934x.c            |  11 +-
 include/linux/regmap.h           |  59 ++--
 sound/soc/codecs/wcd9335.c       |  10 +-
 sound/soc/codecs/wcd938x.c       |   1 -
 27 files changed, 332 insertions(+), 426 deletions(-)

-- 
2.35.1

