Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF2646C930
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 01:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243048AbhLHAmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 19:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238724AbhLHAlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 19:41:47 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E31C0698C8;
        Tue,  7 Dec 2021 16:38:09 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id k4so569564pgb.8;
        Tue, 07 Dec 2021 16:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5gmXyyY9vTjgG6NNFdPthaMWLoPgaSufYqbs7mIvW+A=;
        b=MwXiuJ/b0gxSL1j7FSe+siBazA1GRaPlNa02gOcObhcQ2YZtGmDEwbgYTOwqSf0jBc
         di2unhIxUnJDEnjD7xX8UYfh0Te9VZ1upgG1ah39TDPl4oMki2h3gqLWn61Y7RsX5nzm
         CsBtBfJIKtD2R18dFn20zhgVexcPSt5WmPyexUD8lUxcZXCRpX2VQSRrKNaEHu65BkI5
         F4QzYhnU0XPoK9edBGIB8g76I7G1f7DljvedBUFc+Ilm4tbxNLkVFa4y8hVtBxZzzSU3
         hPXU0sOIe5Jq521oy3BdQfQrd/3z8Y8gPqKbUdWD7bVNzJUXzksnh8Jv3UwT949teiKz
         baxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5gmXyyY9vTjgG6NNFdPthaMWLoPgaSufYqbs7mIvW+A=;
        b=NIJ8ahFsAme5ltet9oNZMRofinBVFDy0LfZI9pVs5E2Uj/FhziYq35we7vm6O6P9wj
         xwJZr+jZJxIEUfdg+JUkjMZ+JtQfp+OU81B+Xh/rzyUtt9/y+9YGVLJuVlcQtJg4cR5Z
         1Cy2OG0WQ3K/nNyIo/xkZhlS/WOrfrL8YQp3/slbs/RPmWe2Ugi1B1vaHmaB94zoqwlR
         Ax1pJUwDufAMfsGbe91pP/aOEpPwzfaDDVX5kTp1cXdv/Skmt6mIqTjadPpiXLmNQxcs
         n1DWLC2bZTXIj1KAuB93ZjVWv3+M9/sgzMo3vbZ7Rt+5XwM/ocXtLdeM2RkYPynD4Kxe
         baNg==
X-Gm-Message-State: AOAM533VqA7vvPEUzNc1UA/ww589E2ekTEun7uvsSJibkrpAz584bswS
        nIEn1XHeSkNN6xYT1Vt9oV7i4GGXf9M=
X-Google-Smtp-Source: ABdhPJx6I0VqsO9majNCKhWXpr8k35E34Ms8KS9sAJ7063yo0qrrL+bJYyd926Lh7ftQolw1HzYm7Q==
X-Received: by 2002:a63:1d15:: with SMTP id d21mr26467833pgd.541.1638923888037;
        Tue, 07 Dec 2021 16:38:08 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n16sm926379pfv.123.2021.12.07.16.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 16:38:07 -0800 (PST)
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
Subject: [PATCH v3 10/15] dt-bindings: rng: Convert iProc RNG200 to YAML
Date:   Tue,  7 Dec 2021 16:37:21 -0800
Message-Id: <20211208003727.3596577-11-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208003727.3596577-1-f.fainelli@gmail.com>
References: <20211208003727.3596577-1-f.fainelli@gmail.com>
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

