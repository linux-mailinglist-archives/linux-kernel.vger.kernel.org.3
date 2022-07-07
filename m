Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CC056AA6F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236194AbiGGSYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235637AbiGGSYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:24:00 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5648D205F3;
        Thu,  7 Jul 2022 11:23:59 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id j3so8398331pfb.6;
        Thu, 07 Jul 2022 11:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hQHooeYpBPLqhLw4iyaicqWZ8U8iT/gDaXg8Zs9aODs=;
        b=Sx5FRvZ7QwI1k5mlx5HVc8zV8L6yX8BkzuLV6xWaMYwxoV9IEmxav452EFSv1yaRTg
         6M1f/Zr4ijUYy3UQeqKtjrfc41NnV117hgRxVDKfruhh6G1V0nGzk2OQVqmrQikUniul
         AkJD85s/nJQVbExGSDJK3Wy+q93j1ASFedP+Ck4MiZL6OOllxLimyBmeGFwyxngUvHJh
         4NQiYwY1QTsPZhlKYVmVZOb4FacQZ/3GTthgegHvJIdrVQPHZShTniSSvPO+Y0Iq+gM/
         8Xv6RNkMduZJ7MY5fQ1BisYQTMmlmYlcyil4ysUeNllSstSSfGJ9BA8R6W8F07krorZM
         6rMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hQHooeYpBPLqhLw4iyaicqWZ8U8iT/gDaXg8Zs9aODs=;
        b=4I7WjUhhVVxftbZHkqf819lHlZ6PmxG9VhDM2tjS/tGVmyuT9ECBQ+i7gnw8edmCxo
         kdAqJZRmPwqscvuI4BlLHv5Z6g6623GxWdwkTNn4JuO4jif4rUbwxRqndVbd05U//DSX
         EqqNKYRKGaR9HJIqGt+2EjfSy/nCDN1Xrseu3Rm4AHFvx8awlXokZ/i/tqN65ODpkt05
         DMZuml6tF7vdm2pXoC22ZKxNecMnDTUUltW53LhQV5NuVJOlGXz7EymoqI31m7gcFgIr
         SZzKcUSknChK/LOL+hQrXB4YDYkpKormnZD5zJHUJup2M05p6uYghJlNm2260u9NvQqB
         XyPQ==
X-Gm-Message-State: AJIora8ISDASUxODQ7NQQuBOyP/9mKqU7KuDtIRE75PU/sMO2DrRRMlL
        G9KuTxVPX2DJ6oibSnt54JIo+PzrD+8=
X-Google-Smtp-Source: AGRyM1uU7YSCIUD0jrjk1cuFuvNKKMo0gPiJm0l1nzNXzfY/UMVr9kZrx4Ww+2U3XI1Kk8Pv4SIWNQ==
X-Received: by 2002:a17:90b:4f48:b0:1ed:45e5:dc8c with SMTP id pj8-20020a17090b4f4800b001ed45e5dc8cmr6732899pjb.131.1657218238815;
        Thu, 07 Jul 2022 11:23:58 -0700 (PDT)
Received: from prasmi.domain.name ([103.219.60.85])
        by smtp.gmail.com with ESMTPSA id o12-20020a170902d4cc00b0016a3f9e4865sm28589279plg.148.2022.07.07.11.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 11:23:58 -0700 (PDT)
From:   prabhakar.csengg@gmail.com
X-Google-Original-From: prabhakar.mahadev-lad.rj@bp.renesas.com
To:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v8 0/6] Renesas RZ/G2L IRQC support
Date:   Thu,  7 Jul 2022 19:23:08 +0100
Message-Id: <20220707182314.66610-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

The RZ/G2L Interrupt Controller is a front-end for the GIC found on
Renesas RZ/G2L SoC's with below pins:
- IRQ sense select for 8 external interrupts, mapped to 8 GIC SPI
  interrupts
- GPIO pins used as external interrupt input pins out of GPIOINT0-122 a
  maximum of only 32 can be mapped to 32 GIC SPI interrupts,
- NMI edge select.

                                                             _____________
                                                             |    GIC     |
                                                             |  ________  |
                                      ____________           | |        | |
NMI --------------------------------->|          |  SPI0-479 | | GIC-600| |
             _______                  |          |------------>|        | |
             |      |                 |          |  PPI16-31 | |        | |
             |      | IRQ0-IRQ7       |   IRQC   |------------>|        | |
P0_P48_4 --->| GPIO |---------------->|          |           | |________| |
             |      |GPIOINT0-122     |          |           |            |
             |      |---------------->| TINT0-31 |           |            |
             |______|                 |__________|           |____________|

The proposed patches add hierarchical IRQ domain, one in IRQC driver and
another in pinctrl driver. Upon interrupt requests map the interrupt to
GIC. Out of GPIOINT0-122 only 32 can be mapped to GIC SPI, this mapping is
handled by the pinctrl and IRQC driver.

Cheers,
Prabhakar

v7->v8
* Fixed return value in case of devm_reset_control_get_exclusive() failure.
* Included patch [0] from Marc ([0] https://git.kernel.org/pub/scm/linux/kernel/
  git/maz/arm-platforms.git/patch/?id=178b7e21459e9a7e2a2c369711ef0cc9b1cfbcd7)

v6->v7:
* Used devm_reset_control_get_exclusive() instead of
  devm_reset_control_get_exclusive_by_index()
* Included RB tag from Linus for patch 5/5
* Switched to newer version of populate_parent_alloc_arg() (patch depends
  on https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/
  patch/?id=178b7e21459e9a7e2a2c369711ef0cc9b1cfbcd7)

v5->v6:
* Fixed review comments pointed by Marc
* Included Ack from Rob

v4->v5:
* Updated commit message for patch 3/5
* Dropped interrupt-parent from and included RB tag from Geert
  for patch 4/5
* Implemented init_valid_mask() callback
* Dropped ngirq patch from previous series
* Dropped patches 4/7 and 5/7 from previous patch series will handle
  it separately.

v3->v4:
* Updated description for interrupts-cells property in patch #1
* Dropped the patch which overriding free callback in gpiolib
* Used devm helpers in patch#2
* Patch #4, #5 and #6 are newly added
* In patch #7 dropped using gpio offset as hwirq
* Implemented immutable GPIO in patch #7
* Implemented child_offset_to_irq() callback in patch #7

v2->v3:
* Updated description for interrupts-cells property in patch #1
* Included RB tag from Geert for binding patch
* Fixed review comments pointed by Geert, Biju and Sergei.

v1->v2:
* Included RB tag from Rob
* Fixed review comments pointed by Geert
* included GPIO driver changes

RFCV4 -> V1:
* Used unevaluatedProperties.
* Altered the sequence of reg property
* Set the parent type
* Used raw_spin_lock() instead of raw_spin_lock_irqsave()
* Simplified parsing IRQ map.
* Will send the GPIO and pinctrl changes as part of separate series

RFC v4:
* Used locking while RMW
* Now using interrupts property instead of interrupt-map
* Patch series depends on [0]
* Updated binding doc
* Fixed comments pointed by Andy

[0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/
20220316200633.28974-1-prabhakar.mahadev-lad.rj@xxxxxxxxxxxxxx/

RFC v3:
-> Re-structured the driver as a hierarchical irq domain instead of chained
-> made use of IRQCHIP_* macros
-> dropped locking
-> Added support for IRQ0-7 interrupts
-> Introduced 2 new patches for GPIOLIB
-> Switched to using GPIOLIB for irqdomains in pinctrl

RFC v2: https://patchwork.kernel.org/project/linux-renesas-soc/cover/
20210921193028.13099-1-prabhakar.mahadev-lad.rj@xxxxxxxxxxxxxx/

RFC v1: https://patchwork.kernel.org/project/linux-renesas-soc/cover/
20210803175109.1729-1-prabhakar.mahadev-lad.rj@xxxxxxxxxxxxxx/

Lad Prabhakar (5):
  dt-bindings: interrupt-controller: Add Renesas RZ/G2L Interrupt
    Controller
  irqchip: Add RZ/G2L IA55 Interrupt Controller driver
  gpio: gpiolib: Allow free() callback to be overridden
  dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Document the properties
    to handle GPIO IRQ
  pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain to handle GPIO
    interrupt

Marc Zyngier (1):
  gpio: Remove dynamic allocation from populate_parent_alloc_arg()

 .../renesas,rzg2l-irqc.yaml                   | 133 ++++++
 .../pinctrl/renesas,rzg2l-pinctrl.yaml        |  15 +
 drivers/gpio/gpio-msc313.c                    |  15 +-
 drivers/gpio/gpio-tegra.c                     |  15 +-
 drivers/gpio/gpio-tegra186.c                  |  15 +-
 drivers/gpio/gpio-thunderx.c                  |  15 +-
 drivers/gpio/gpio-visconti.c                  |  15 +-
 drivers/gpio/gpiolib.c                        |  51 ++-
 drivers/irqchip/Kconfig                       |   8 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-renesas-rzg2l.c           | 393 ++++++++++++++++++
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c      |  15 +-
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       | 233 +++++++++++
 include/linux/gpio/driver.h                   |  42 +-
 14 files changed, 862 insertions(+), 104 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
 create mode 100644 drivers/irqchip/irq-renesas-rzg2l.c

-- 
2.25.1

