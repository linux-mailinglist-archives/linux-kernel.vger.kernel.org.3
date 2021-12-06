Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE4B46A41D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347203AbhLFSaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347059AbhLFS3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:29:53 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CEEC061746;
        Mon,  6 Dec 2021 10:26:24 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso562144pjb.2;
        Mon, 06 Dec 2021 10:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=22u1YgEGuUE2NUBm4aUIXRHhe1NgL4IlQ7p6nHAEJMg=;
        b=Zh+U2u/a5Qx3uOWo98Uixyx5LiZdxs452Y1/RvET1RUL7tNPzzTZ3Y4OOkm0b8ie/K
         foW1LcD7tb6JZbs+kIWgP5LZnk//3T3gZHNNSAFbG01vJNhjAtXS9yhJsN00v3EZNV1U
         CKc7fS3F+j/Wj+8WVY3UpM2dBT1bZeDIAnhTK/6ZkTJ5xIGWgtc36aqlr6yOYZI2HanH
         c1lArW+KbzPpLWPNFFsLpcuOZoaVtolS+NcpjHhUC+zKEqAH7mTsvaB3o6o0VajXlS9C
         +i2oopFItEGl7iwTxUtXO6D7zh8+o3jUEsf7mHA2/k1iODI1rtMVcWnMzBqncSV8Vnwq
         NsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=22u1YgEGuUE2NUBm4aUIXRHhe1NgL4IlQ7p6nHAEJMg=;
        b=mzA3lOJnhnuUy6ARx9SCNJ60/TlsFyYUHtSrFl6YVWP5L0HYtr4fwpQHGB85IX47PS
         ggGtyyaZfzjZuJEO8SyriHdFmEOa0h4jl829NG3QGpiY57I/cvcRMu6NWDoOU5saGMXT
         j5e5gw0x5yfqjhBWcTyh7d8MxsqIkg9/gQ88MqbsOQRFV28Rft8uf5xvIlFCeq8WsGz+
         zPfbCNNoG7Xxs7bIqNJYrOobqGML9asR6ZqEgAAw5rz0XsQ6+7GDxhnRnTOkrCBS3YDc
         4v5oMN4MYCPqXFCO8CCftokI+jsRhN9uUPZ2dJJzsZ9UDW7G5zZZJDAr9vijMNhdmBnL
         un2w==
X-Gm-Message-State: AOAM530AYPG4CR8TdjHUOmO+44N4egGk2R87KF3y1I82A5R3bhJZ2/77
        mitayZGEc6plHWudhmSu0zkHyqx8OPA=
X-Google-Smtp-Source: ABdhPJwSVbvjR1dpvgyfdF4mNAKyCGmG960Qi+UT5jB5j7oT2D5zmuuwNPilnYXVThDeFf9l4VDShQ==
X-Received: by 2002:a17:90a:9a8e:: with SMTP id e14mr196284pjp.231.1638815183952;
        Mon, 06 Dec 2021 10:26:23 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a22sm12773097pfh.111.2021.12.06.10.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 10:26:23 -0800 (PST)
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
Subject: [PATCH v2 02/14] dt-bindings: reset: Convert Broadcom STB reset to YAML
Date:   Mon,  6 Dec 2021 10:26:04 -0800
Message-Id: <20211206182616.2089677-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211206182616.2089677-1-f.fainelli@gmail.com>
References: <20211206182616.2089677-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Broadcom STB SW_INIT style reset controller binding to YAML.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../bindings/reset/brcm,brcmstb-reset.txt     | 27 -----------
 .../bindings/reset/brcm,brcmstb-reset.yaml    | 48 +++++++++++++++++++
 2 files changed, 48 insertions(+), 27 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.txt
 create mode 100644 Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.yaml

diff --git a/Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.txt b/Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.txt
deleted file mode 100644
index ee59409640f2..000000000000
--- a/Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-Broadcom STB SW_INIT-style reset controller
-===========================================
-
-Broadcom STB SoCs have a SW_INIT-style reset controller with separate
-SET/CLEAR/STATUS registers and possibly multiple banks, each of 32 bit
-reset lines.
-
-Please also refer to reset.txt in this directory for common reset
-controller binding usage.
-
-Required properties:
-- compatible: should be brcm,brcmstb-reset
-- reg: register base and length
-- #reset-cells: must be set to 1
-
-Example:
-
-	reset: reset-controller@8404318 {
-		compatible = "brcm,brcmstb-reset";
-		reg = <0x8404318 0x30>;
-		#reset-cells = <1>;
-	};
-
-	&ethernet_switch {
-		resets = <&reset 26>;
-		reset-names = "switch";
-	};
diff --git a/Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.yaml b/Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.yaml
new file mode 100644
index 000000000000..e00efa88a198
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/reset/brcm,brcmstb-reset.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Broadcom STB SW_INIT-style reset controller
+
+description:
+  Broadcom STB SoCs have a SW_INIT-style reset controller with separate
+  SET/CLEAR/STATUS registers and possibly multiple banks, each of 32 bit
+  reset lines.
+
+  Please also refer to reset.txt in this directory for common reset
+  controller binding usage.
+
+maintainers:
+  - Florian Fainelli <f.fainelli@gmail.com>
+
+properties:
+  compatible:
+    const: brcm,brcmstb-reset
+
+  reg:
+    maxItems: 1
+
+  "#reset-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - "#reset-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    reset: reset-controller@8404318 {
+      compatible = "brcm,brcmstb-reset";
+      reg = <0x8404318 0x30>;
+      #reset-cells = <1>;
+    };
+
+    ethernet_switch {
+      resets = <&reset 26>;
+      reset-names = "switch";
+    };
-- 
2.25.1

