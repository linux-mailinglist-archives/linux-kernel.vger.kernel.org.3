Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63FDC46A40D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347052AbhLFS3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346999AbhLFS3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:29:50 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AF3C061354;
        Mon,  6 Dec 2021 10:26:20 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id z6so7632033plk.6;
        Mon, 06 Dec 2021 10:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hE2WN/DCm9N6dOZUu7hJVv+yyUkTDtyJAizkqbQOmeM=;
        b=ipaMazgxgTpkYikqGl6f7YCz3dX0DH+kDEHQf9IPrXn8Ty2anNzxe5KfYlV9DKm45W
         6LcK8K52jRcL5K9k/42alehFViSE1QSnRhzjLtXd3eN7VBi5wToe9wdkyXDAGEJgDygg
         XhSMYxgkyh8wjxjdMyVsvXhk1aE0DQvfO4C5pZBMPZlsUk4V+e2QgcgAzEU0j3AFiSx4
         h7n9OXSRpGq6ztUgfpDLuXGOVbcSB+Vf/goU2C53KQnpyGTGHsRhf9cwPPeUSkfFFgiA
         5PBTFLrA8M+fmqv5jj4nU15Nh1TPtq61NJxqjPcus1YOURkR8gu7zepJsCz61vYuF6E4
         1ikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hE2WN/DCm9N6dOZUu7hJVv+yyUkTDtyJAizkqbQOmeM=;
        b=7odm4aRBpSoh/ebdkrGXB3ba3PnSfCw6W2aKzwZYvX6d/s7L7iqSfZVeDYPCVpJf2T
         uRhIRo+ljNpVAq0Z8mtNXfx4ECPKdp+d2WRWMTdC6PBLhZ0mjp/iksEwHBolIxCoalVg
         k3ZNGSSfqAa+b17msqH3P+HLhL64qPqr8Hb2zCdJkVT605rb5KW59bBMnzGxd8X9cCun
         6E63j6GHOoD0Lhz6PUF2FJjo1Fui7oO1+ZokuwHHIMfpLqYXSSIYirOhwzz3D7fzf6pn
         jSK6dqO3SSv8M3KPpjvxEha/5jC0/cIJiPmxeVQ2HrOWiOCqBD07sAS1OwnQTYmpvTRY
         DH/w==
X-Gm-Message-State: AOAM530FLKYcriURdysHPBtcWPD5eI0z+lRPdlZTZHIUCeR2FHMbJHfq
        w+IOU/1/oBhI+ltGf4mvN09DZIWHpPM=
X-Google-Smtp-Source: ABdhPJzHrXUEulYgTnv8rmP1N2EktMiXwXTNQXI/qz7ddNDdC9RmNahV0Zhzd5IDB4MUonyGD9AseQ==
X-Received: by 2002:a17:90b:1892:: with SMTP id mn18mr250556pjb.178.1638815179928;
        Mon, 06 Dec 2021 10:26:19 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a22sm12773097pfh.111.2021.12.06.10.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 10:26:19 -0800 (PST)
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
Subject: [PATCH v2 00/14] Broadcom DT bindings updates to YAML
Date:   Mon,  6 Dec 2021 10:26:02 -0800
Message-Id: <20211206182616.2089677-1-f.fainelli@gmail.com>
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

Changes in v2:

- rebased against dt/next
- addressed Gregory's feedback on the GPIO binding change
- added Damien's Acked-by to the ATA binding patch

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
 .../bindings/gpio/brcm,brcmstb-gpio.yaml      | 105 ++++++++++++
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
 28 files changed, 936 insertions(+), 572 deletions(-)
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

