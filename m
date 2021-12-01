Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F3A465804
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240069AbhLAU7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353223AbhLAUzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:55:21 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57563C061574;
        Wed,  1 Dec 2021 12:51:59 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id n8so18654153plf.4;
        Wed, 01 Dec 2021 12:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5gmXyyY9vTjgG6NNFdPthaMWLoPgaSufYqbs7mIvW+A=;
        b=VHdDTBvpNdZrRzIzl5J13AIjbqWOvPml1ApO2g+zKV52iBxwe4TYcMXl6ppHsH1Vgf
         IzxHv+LIKQLMyJIsHCYRiu6W+waG1PySnPyh8kIhNAiX2aKk9v58JURW52f02i7hykIG
         0AhvpuetbMa1S+IkyLOl3eWjc5lsGiNvLKDFsNcq4zwJgbr+NeAn5syaqCKgp8nilbUz
         JjgwJeNzW48G/+/PwdqWau+s3WJNcskKkzNsnqnNniocllk9UidWEhaytrM2+czeltb/
         1ECEwTZCEOOrcOljtZAc3k/9fuBAmozHmU+qUugvCaJwPG41rmPPbG35y9GrRk8PoxZr
         Y/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5gmXyyY9vTjgG6NNFdPthaMWLoPgaSufYqbs7mIvW+A=;
        b=ODkpiaBTNNEDowqMKrOuX3SnUvrvkDPEzYfK7ze/z23wLzsmn2DthdRy/XvZgLxq4l
         TqUVCOlJHmIp0GjnIu68I1n/jWSlFh5uLe/CEgV4PB1Cw+Rg1lVp3+PyzWk6KlJIBtow
         kYxhsL7s+cnAIx2rCXa82PNamtCx0ymgrKvopVTVZ8buxSzxTJ88Lbmk02vxC4EL5IL7
         OtVbV8FpIu813TnediWwvRABnWs8A3mwcs6ewv/rUlQiz60MOMae2ha1O6zQnuRabtQZ
         Yqw/0mRaJIPSrWg/7jICm7O/rdPULXZjrrfj6qA5kRJU6QKSrtgndTbibjJbFPi5CBXs
         othQ==
X-Gm-Message-State: AOAM530hCZbp+6QlSGE1rqqLd7ksr5oT/lbOZjntQ5J6T4vSwoCEZRSS
        F2WEKEFEXl3ORxHaLlmj6zlJxa6AmoQ=
X-Google-Smtp-Source: ABdhPJwU1Gf8e1n5UHFbSxvLPBdz0cW1AouPT7hiHSWkPGUsuL5QrbhyjjmQSgnEAxAK7TMIx0c7ww==
X-Received: by 2002:a17:90b:4a43:: with SMTP id lb3mr743999pjb.222.1638391918364;
        Wed, 01 Dec 2021 12:51:58 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p20sm729117pfw.96.2021.12.01.12.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 12:51:57 -0800 (PST)
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
Subject: [PATCH 10/14] dt-bindings: rng: Convert iProc RNG200 to YAML
Date:   Wed,  1 Dec 2021 12:51:06 -0800
Message-Id: <20211201205110.41656-11-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201205110.41656-1-f.fainelli@gmail.com>
References: <20211201205110.41656-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Broadcom iProc RNG200 HWRNG Device Tree binding to YAML to
help with validation.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../bindings/rng/brcm,iproc-rng200.txt        | 16 ----------
 .../bindings/rng/brcm,iproc-rng200.yaml       | 29 +++++++++++++++++++
 2 files changed, 29 insertions(+), 16 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/rng/brcm,iproc-rng200.txt
 create mode 100644 Documentation/devicetree/bindings/rng/brcm,iproc-rng200.yaml

diff --git a/Documentation/devicetree/bindings/rng/brcm,iproc-rng200.txt b/Documentation/devicetree/bindings/rng/brcm,iproc-rng200.txt
deleted file mode 100644
index 802523196ee5..000000000000
--- a/Documentation/devicetree/bindings/rng/brcm,iproc-rng200.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-HWRNG support for the iproc-rng200 driver
-
-Required properties:
-- compatible : Must be one of:
-	       "brcm,bcm2711-rng200"
-	       "brcm,bcm7211-rng200"
-	       "brcm,bcm7278-rng200"
-	       "brcm,iproc-rng200"
-- reg : base address and size of control register block
-
-Example:
-
-rng {
-        compatible = "brcm,iproc-rng200";
-        reg = <0x18032000 0x28>;
-};
diff --git a/Documentation/devicetree/bindings/rng/brcm,iproc-rng200.yaml b/Documentation/devicetree/bindings/rng/brcm,iproc-rng200.yaml
new file mode 100644
index 000000000000..53baaec966e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/rng/brcm,iproc-rng200.yaml
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/rng/brcm,iproc-rng200.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: HWRNG support for the iproc-rng200 driver
+
+maintainers:
+  - Florian Fainelli <f.fainelli@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - brcm,bcm2711-rng200
+      - brcm,bcm7211-rng200
+      - brcm,bcm7278-rng200
+      - brcm,iproc-rng200
+  reg:
+    description: base address and size of control register block
+
+additionalProperties: false
+
+examples:
+  - |
+    rng@18032000 {
+        compatible = "brcm,iproc-rng200";
+        reg = <0x18032000 0x28>;
+    };
-- 
2.25.1

