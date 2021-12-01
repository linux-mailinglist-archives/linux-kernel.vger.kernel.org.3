Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6BC84657EB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353202AbhLAU4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353129AbhLAUzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:55:00 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3C9C06175B;
        Wed,  1 Dec 2021 12:51:38 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id w33-20020a17090a6ba400b001a722a06212so1726089pjj.0;
        Wed, 01 Dec 2021 12:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oF513HL59Lq2r+t8IJTJGHwJx0tkD87dfhsL+nC0qZs=;
        b=Gu38bNP42GQE4Q0wImmTZ533tndkyxXvDUIKcsJTjIxxjFfJCiJYD9Wz33X+jnoBhc
         +jpr+NiaprWjfgXcTDZ9Piw5b3gkZRsZ8kqvNPn1pGzodSq8kqlKhVMpKc87WCBJ2Y/I
         B3eTDOSzJJXQ4kk5ObP0xNTTU1El/AczBrET8obTDAOH0sOqp1OaudYSr3pUN0LZ38oW
         ow+aon7mUPajiUVfOWv1VBvPmDE3wYZOjFQCd/zyI4oBp5nyoqkaHatYjiQxdIz3nE5I
         i6m2D5Ww/igRWPSNkR9m5fH59vNqQLgTp6v/FhNUWC8WT2sWU5PL4aEICwr3YJJhWv/V
         /uVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oF513HL59Lq2r+t8IJTJGHwJx0tkD87dfhsL+nC0qZs=;
        b=ipHcxlMfPLSaYUVt2wAI8lcoN1NOnsSj4JjVk5Vp23kZQ+exK67PDjlMOR/yts4O5G
         aFXCt/stVDB7TWNowWhUaiKdc8CtG1Nl8SmXnn6GsPzGNSUUN6RrsPQJq6hDykRurFZn
         fxcx31PzH7u+51s3Pga2GmnytGUfm1erCJKRMV6VB6VKR28OpkL1ZVjGYZlm76KtEomb
         F0C923tyktNJjXQykNr5WDbOI1BvgXI8x+qmxzF/SKgnRDGCJ/VyH1KqJKI2R8eQZE7E
         kjDOoK8qmC/5WvyAlYFEkKL1enmfCL45z5UO6Rl3wNbJah6Y79DRczlpX7dqN6L//eA7
         8xKQ==
X-Gm-Message-State: AOAM530x26KVKYLi4OT8YCbQT1KzOxRE8e7HSZMeR+ns4CdeFnb4ramB
        UsE0Hi5uBj+CZ9zW76uJwGJzkwAA8s8=
X-Google-Smtp-Source: ABdhPJy1qEUa/nopWxDTuz1Ua9yO5XGnE1dzsGDNJjYVNCnS9wBraDlcVnsGOkzNzSpxgmK+2E8yGg==
X-Received: by 2002:a17:902:e294:b0:143:86a8:c56d with SMTP id o20-20020a170902e29400b0014386a8c56dmr10082966plc.22.1638391897408;
        Wed, 01 Dec 2021 12:51:37 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p20sm729117pfw.96.2021.12.01.12.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 12:51:36 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), Gregory Fong <gregory.0xf0@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Cooper <alcooperx@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)), linux-kernel@vger.kernel.org (open list),
        linux-gpio@vger.kernel.org (open list:GPIO SUBSYSTEM),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE),
        linux-mmc@vger.kernel.org (open list:MULTIMEDIA CARD (MMC), SECURE
        DIGITAL (SD) AND...),
        linux-pwm@vger.kernel.org (open list:PWM SUBSYSTEM),
        linux-crypto@vger.kernel.org (open list:HARDWARE RANDOM NUMBER
        GENERATOR CORE),
        linux-rtc@vger.kernel.org (open list:REAL TIME CLOCK (RTC) SUBSYSTEM),
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-usb@vger.kernel.org (open list:USB SUBSYSTEM)
Subject: [PATCH 00/14] Broadcom DT bindings updates to YAML
Date:   Wed,  1 Dec 2021 12:50:56 -0800
Message-Id: <20211201205110.41656-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

This patch series contains a number of device tree bindings being
converted to YAML to help with validation.

There will be second, and possibly third rounds later on after those
land in.

Thanks!

Florian Fainelli (14):
  dt-bindings: mmc: Convert Broadcom STB SDHCI binding to YAML
  dt-bindings: reset: Convert Broadcom STB reset to YAML
  dt-bindings: pwm: Convert BCM7038 PWM binding to YAML
  dt-bindings: rtc: Convert Broadcom STB waketimer to YAML
  dt-bindings: gpio: Convert Broadcom STB GPIO to YAML
  dt-binding: interrupt-controller: Convert BCM7038 L1 intc to YAML
  dt-bindings: interrupt-controller: Convert BCM7120 L2 to YAML
  dt-bindings: interrupt-controller: Merge BCM3380 with BCM7120
  dt-bindings: interrupt-controller: Convert Broadcom STB L2 to YAML
  dt-bindings: rng: Convert iProc RNG200 to YAML
  dt-bindings: thermal: Convert Broadcom TMON to YAML
  dt-bindings: ata: Convert Broadcom SATA to YAML
  dt-bindings: bus: Convert GISB arbiter to YAML
  dt-bindings: usb: Convert BDC to YAML

 .../bindings/ata/brcm,sata-brcm.txt           |  45 ------
 .../bindings/ata/brcm,sata-brcm.yaml          |  91 +++++++++++
 .../devicetree/bindings/bus/brcm,gisb-arb.txt |  34 ----
 .../bindings/bus/brcm,gisb-arb.yaml           |  66 ++++++++
 .../bindings/gpio/brcm,brcmstb-gpio.txt       |  83 ----------
 .../bindings/gpio/brcm,brcmstb-gpio.yaml      | 104 ++++++++++++
 .../brcm,bcm3380-l2-intc.txt                  |  39 -----
 .../brcm,bcm7038-l1-intc.txt                  |  61 -------
 .../brcm,bcm7038-l1-intc.yaml                 |  91 +++++++++++
 .../brcm,bcm7120-l2-intc.txt                  |  88 -----------
 .../brcm,bcm7120-l2-intc.yaml                 | 149 ++++++++++++++++++
 .../interrupt-controller/brcm,l2-intc.txt     |  31 ----
 .../interrupt-controller/brcm,l2-intc.yaml    |  64 ++++++++
 .../bindings/mmc/brcm,sdhci-brcmstb.txt       |  53 -------
 .../bindings/mmc/brcm,sdhci-brcmstb.yaml      | 100 ++++++++++++
 .../bindings/pwm/brcm,bcm7038-pwm.txt         |  20 ---
 .../bindings/pwm/brcm,bcm7038-pwm.yaml        |  43 +++++
 .../bindings/reset/brcm,brcmstb-reset.txt     |  27 ----
 .../bindings/reset/brcm,brcmstb-reset.yaml    |  48 ++++++
 .../bindings/rng/brcm,iproc-rng200.txt        |  16 --
 .../bindings/rng/brcm,iproc-rng200.yaml       |  29 ++++
 .../bindings/rtc/brcm,brcmstb-waketimer.txt   |  20 ---
 .../bindings/rtc/brcm,brcmstb-waketimer.yaml  |  44 ++++++
 .../bindings/thermal/brcm,avs-tmon.txt        |  23 ---
 .../bindings/thermal/brcm,avs-tmon.yaml       |  57 +++++++
 .../devicetree/bindings/usb/brcm,bdc.txt      |  29 ----
 .../devicetree/bindings/usb/brcm,bdc.yaml     |  46 ++++++
 MAINTAINERS                                   |   6 +-
 28 files changed, 935 insertions(+), 572 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt
 create mode 100644 Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
 delete mode 100644 Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt
 create mode 100644 Documentation/devicetree/bindings/bus/brcm,gisb-arb.yaml
 delete mode 100644 Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm3380-l2-intc.txt
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml
 delete mode 100644 Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.txt
 create mode 100644 Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.yaml
 delete mode 100644 Documentation/devicetree/bindings/rng/brcm,iproc-rng200.txt
 create mode 100644 Documentation/devicetree/bindings/rng/brcm,iproc-rng200.yaml
 delete mode 100644 Documentation/devicetree/bindings/rtc/brcm,brcmstb-waketimer.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/brcm,brcmstb-waketimer.yaml
 delete mode 100644 Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,avs-tmon.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/brcm,bdc.txt
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,bdc.yaml

-- 
2.25.1

