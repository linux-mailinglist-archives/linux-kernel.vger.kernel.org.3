Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7786856498D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 21:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbiGCTk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 15:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiGCTk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 15:40:57 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDDE2DF5;
        Sun,  3 Jul 2022 12:40:56 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id l12so1493409plk.13;
        Sun, 03 Jul 2022 12:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lAoaIRrd1I/n/Cuuoagyu6zAUL7znWkZoM3y7bdJxaE=;
        b=SCYngpB2DkzYud52C7EepURTDXeNb5P89mRRWjlt30i6qqPmb2RgS0Dl1SYG/F/TJj
         PdCpoq2KkX8RBh7qcZypNRpSUVSMJRLl+mJvt8nUVhdWZZtj2X+gzq6tMmUIGIKvjJF5
         g5tyV9K4h46GsX93JlVdNNVGC0whi2dovTeCCFlJ4LvVF43sfB6oYJUBnooYAV+asAsX
         pq2xxcVdXszRV+wfeHstnfhBZRCP75KksS27WlQPnp2fRzmFxrs6AnRMbo+WWCMqaTL+
         zlsI1eZYsYyJyZuPzJZ2x/qjegv6NcMpBWHMkqRjZOVmVy4ggSTUorXJUbQJwycjwiSi
         xZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lAoaIRrd1I/n/Cuuoagyu6zAUL7znWkZoM3y7bdJxaE=;
        b=q0mGTZjvHcH67hyGT/EjKbtvzX/NeemAf8wDjFDpxk/rldr3aYyaEAEHfES4JNG8HK
         G+GQDCaIB+UDm0OijEVRuLAkH9xTk05yRO4vKz2j+ct+tA5XPXi/3rOxcQv5k1bbWOdu
         4chFKKXIE1MwE/x1YJtt87Zau5libE79yCBcAw12dXcoez1+1/bV0Mj1INLkpecnuMvd
         sP7tCdXzcyO/wP+Yp2jpOEuCrG9+2QPCj56hIxg1kb6US9ElunoKopH8ASVaswCMB+Cf
         Gv26ZJofcTcRJMhwK8Wy2I0P9Ce3Tu2F0BMrTO0RAiUzLKKKIYWKguTqJI0X/U9NCv3P
         /iqA==
X-Gm-Message-State: AJIora85P6nLtMdp4z8kWGUR2tlbRmf4L5H/PQ/fi7FF0BwITDhaZeB0
        Ic7PoxBOioJX1Ulk3qnhhvWeuohRwVE=
X-Google-Smtp-Source: AGRyM1sPiC7Kfi98iW4U80YQ4Kg/zMfwiOUu7ZPS0991iyDMATwtDOt+yZcCswNdEcBbPcVObq8mDg==
X-Received: by 2002:a17:90b:388f:b0:1ed:3b:6c64 with SMTP id mu15-20020a17090b388f00b001ed003b6c64mr30416152pjb.34.1656877256000;
        Sun, 03 Jul 2022 12:40:56 -0700 (PDT)
Received: from prasmi.domain.name ([103.219.60.86])
        by smtp.gmail.com with ESMTPSA id y19-20020a17090aca9300b001e0c5da6a51sm10656104pjt.50.2022.07.03.12.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 12:40:55 -0700 (PDT)
From:   Lad Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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
Subject: [PATCH v7 0/5] Renesas RZ/G2L IRQC support
Date:   Sun,  3 Jul 2022 20:40:15 +0100
Message-Id: <20220703194020.78701-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

 .../renesas,rzg2l-irqc.yaml                   | 133 ++++++
 .../pinctrl/renesas,rzg2l-pinctrl.yaml        |  15 +
 drivers/gpio/gpiolib.c                        |   9 +-
 drivers/irqchip/Kconfig                       |   8 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-renesas-rzg2l.c           | 393 ++++++++++++++++++
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       | 233 +++++++++++
 7 files changed, 789 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
 create mode 100644 drivers/irqchip/irq-renesas-rzg2l.c

-- 
2.25.1

