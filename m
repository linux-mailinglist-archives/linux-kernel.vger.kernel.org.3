Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D386946A482
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347231AbhLFSba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347331AbhLFSaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:30:10 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74802C0613F8;
        Mon,  6 Dec 2021 10:26:41 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id np3so8369733pjb.4;
        Mon, 06 Dec 2021 10:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5gmXyyY9vTjgG6NNFdPthaMWLoPgaSufYqbs7mIvW+A=;
        b=XykpGBuJu//2niZHEQIDL2lbru2DFhZcmKdAqvLjHjhv/M54vXhJn9mzWI+02UmDHH
         oM7v1TdkbycZq1yH19C9+7HtRHI14x4ddbNDXc5VwIidbRFA4nILorcOaOQ2plEJyky7
         N16cUwd/RepTtPobRwYqxTrzkQvuvv8ynNo29TaVBAiYbfxp0xz98UEeYlbOFeenym4M
         niJCQSjk0bcCuUgfFHGp6lbcfXVPqb6+VYbg5XNOV+cZ6cupl0NGq2++xW9a/169ZBoa
         aXbLte3yrWV8Bq93mjmqzaEAODhS4eX+kCbFnez1GRbyekx8COrxZ5IEHZjNvlbh7ddz
         7MOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5gmXyyY9vTjgG6NNFdPthaMWLoPgaSufYqbs7mIvW+A=;
        b=RcL2v7pbvXi5ROChN8xsRItlhO/l0g6L5nmfduRP78oWmkPaOgaAodb0HyfMuHO2NE
         BWxqH6K6lKr5Em61FgAunhnCMmQyyJXWp/P5fDb/vdvJ6mM+wRTh2SwsinOn5L5LBaEj
         Kdq9iSo0vjGPDNc/YzTZ5xGtib4ygrDTmzuG789ZXCD7NPc7vhVOrHmT9VjgZNV16TRV
         Sp2vl5ceh05h0QBRwVC+4VJEx6pRD4KzcwoZeHCsIY5H/WZzE6hMLbHiDq6sHBU3k4WH
         418o+usS3cDmoBSMN5A70ZLuR+Rut2HMuFJVZhlKZXe0xnvpVLw6xH4JopPdSSgxZpe0
         /Jjg==
X-Gm-Message-State: AOAM532watTKi9P3q0EYC6iRE1cWzFyBOYXL8ZpVkb4c8dnmF46tgcS+
        yHwrc43AdY0rwIwDYnD0e7paL2fbDTM=
X-Google-Smtp-Source: ABdhPJyYpTuBsMaSI7mapnBSdMONeO3H4LSAXaCouwtwzKi5i0aYXm9MiQs9n/lflxL+0HR/krHtig==
X-Received: by 2002:a17:90a:7e10:: with SMTP id i16mr205681pjl.185.1638815200695;
        Mon, 06 Dec 2021 10:26:40 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a22sm12773097pfh.111.2021.12.06.10.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 10:26:40 -0800 (PST)
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
Subject: [PATCH v2 10/14] dt-bindings: rng: Convert iProc RNG200 to YAML
Date:   Mon,  6 Dec 2021 10:26:12 -0800
Message-Id: <20211206182616.2089677-11-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211206182616.2089677-1-f.fainelli@gmail.com>
References: <20211206182616.2089677-1-f.fainelli@gmail.com>
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

