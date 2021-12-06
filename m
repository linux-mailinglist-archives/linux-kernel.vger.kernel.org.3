Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C27746A44F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347666AbhLFSbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347123AbhLFS35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:29:57 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2A9C061359;
        Mon,  6 Dec 2021 10:26:28 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id x5so11014783pfr.0;
        Mon, 06 Dec 2021 10:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v2A5xiMCMD01rja8VsVDsIJrjuLJ0aPnQc2VQht4HL0=;
        b=c9Jsl2hZOfK0CYPT8V2GSfwPGDLRR5wg6YINAn5nKczCXrlhzTlNGzRFKGGjPeJe1L
         xcEGaTzkkHOWgB9L45gGuzZZUG7Ut9ZJ7dKufiNqNv1bxgPX2p9fOzRu2CdoFh8uLNIz
         UZ96AUHAk8flm4/uhavpoF/IGLg+6oXhr+LFejLHPxlYlOl95pYWUlchHyru6lKDooL2
         bmBWmr8VG66nkD9Z1SLxuF/OrdgqSiIXCu3L06erm//1JT1V+I262+CW1FwnnMMrEHh9
         iQfgmdmLTa0b75zTtlRhkGKuczBcUiODdXe4wElcxw2vuKw3drCoMsgT4g6gb+BerwVs
         44Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v2A5xiMCMD01rja8VsVDsIJrjuLJ0aPnQc2VQht4HL0=;
        b=XEZkXgWiOFsG3a9iz5m8Tjk0DL2yHSFHMcUnD2C+3+Ex+hbDPGq1wW8LDNo3mEnb2P
         ak2t+UZJ6eV3WBhYpmNCQGRSKI8sv+FnpZiSEd+cdrh2pX9xDeWI5kM1GLe5+sK0En5N
         uISCT1bXDkD1sX1iUE5KDAuJbvMlGDTT8LjLUJDEmAbZZnCyOxmLZIsmMXYvgJTSektl
         e1GBiEuf7gSci2sOB65sx9GRYyVrb/yDth3i+ZduGFqtTAWibDb5NdwRmqMstBp8x5w7
         +FvTcmER5MRWxi7p3lQE3YSJfzmoPFE96upZzgJeYX8kTsL4ThXBvTnETH2NuVInq9V1
         tzCQ==
X-Gm-Message-State: AOAM531MfoOqs/FPZF5FkMtQ0nTt3JciOMX6IxJCruQ6R5ainqwkUeye
        NiFmyFnSt7HHWtuuQz7LBR6gmQY3AOw=
X-Google-Smtp-Source: ABdhPJwRnUOiI2e1NM8GsgG18O/2CJ88XFMg7KlTym3Di4SpobO10rebateGY5tG5eLZs3t3nGd7yQ==
X-Received: by 2002:a63:4c58:: with SMTP id m24mr19807730pgl.597.1638815188066;
        Mon, 06 Dec 2021 10:26:28 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a22sm12773097pfh.111.2021.12.06.10.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 10:26:27 -0800 (PST)
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
Subject: [PATCH v2 04/14] dt-bindings: rtc: Convert Broadcom STB waketimer to YAML
Date:   Mon,  6 Dec 2021 10:26:06 -0800
Message-Id: <20211206182616.2089677-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211206182616.2089677-1-f.fainelli@gmail.com>
References: <20211206182616.2089677-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Broadcom STB waketimer Device Tree binding to YAML to help
with validation.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../bindings/rtc/brcm,brcmstb-waketimer.txt   | 20 ---------
 .../bindings/rtc/brcm,brcmstb-waketimer.yaml  | 44 +++++++++++++++++++
 2 files changed, 44 insertions(+), 20 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/rtc/brcm,brcmstb-waketimer.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/brcm,brcmstb-waketimer.yaml

diff --git a/Documentation/devicetree/bindings/rtc/brcm,brcmstb-waketimer.txt b/Documentation/devicetree/bindings/rtc/brcm,brcmstb-waketimer.txt
deleted file mode 100644
index d946f28502b3..000000000000
--- a/Documentation/devicetree/bindings/rtc/brcm,brcmstb-waketimer.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-Broadcom STB wake-up Timer
-
-The Broadcom STB wake-up timer provides a 27Mhz resolution timer, with the
-ability to wake up the system from low-power suspend/standby modes.
-
-Required properties:
-- compatible     : should contain "brcm,brcmstb-waketimer"
-- reg            : the register start and length for the WKTMR block
-- interrupts     : The TIMER interrupt
-- clocks	 : The phandle to the UPG fixed clock (27Mhz domain)
-
-Example:
-
-waketimer@f0411580 {
-	compatible = "brcm,brcmstb-waketimer";
-	reg = <0xf0411580 0x14>;
-	interrupts = <0x3>;
-	interrupt-parent = <&aon_pm_l2_intc>;
-	clocks = <&upg_fixed>;
-};
diff --git a/Documentation/devicetree/bindings/rtc/brcm,brcmstb-waketimer.yaml b/Documentation/devicetree/bindings/rtc/brcm,brcmstb-waketimer.yaml
new file mode 100644
index 000000000000..9fe079917a98
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/brcm,brcmstb-waketimer.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/brcm,brcmstb-waketimer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom STB wake-up Timer
+
+maintainers:
+  - Florian Fainelli <f.fainelli@gmail.com>
+
+description:
+  The Broadcom STB wake-up timer provides a 27Mhz resolution timer, with the
+  ability to wake up the system from low-power suspend/standby modes.
+
+allOf:
+  - $ref: "rtc.yaml#"
+
+properties:
+  compatible:
+    const: brcm,brcmstb-waketimer
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: the TIMER interrupt
+    maxItems: 1
+
+  clocks:
+    description: clock reference in the 27MHz domain
+    maxItems: 1
+
+additionalProperties: false
+
+examples:
+  - |
+    rtc@f0411580 {
+        compatible = "brcm,brcmstb-waketimer";
+        reg = <0xf0411580 0x14>;
+        interrupts = <0x3>;
+        interrupt-parent = <&aon_pm_l2_intc>;
+        clocks = <&upg_fixed>;
+    };
-- 
2.25.1

