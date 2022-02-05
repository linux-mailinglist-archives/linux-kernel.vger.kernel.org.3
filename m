Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F734AAD15
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 00:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381470AbiBEXqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 18:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiBEXqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 18:46:12 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B41C061348;
        Sat,  5 Feb 2022 15:46:11 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v19so3236253wrv.6;
        Sat, 05 Feb 2022 15:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=67amdkFUWuBIO08FKhiKfYXgae2z4MWbXEmfuMC+Qms=;
        b=hKd4wQxWYrhyf+D1JwRfBmwl31Li6YTh8CeanNmEuYWH1jA5xkX1btXPhrnlZ+TNF3
         jncAg39V9i9/r0zLLyAzyVCUTWNAAnLLUwMIWCrmUcoE7a+lk19X7KaxQONts2+XS7Q4
         1BItkXSo/QmXqPmr1m0r8+/UnIObs2fTrXD9tmbK6qFzRPU5tMNh44A/bpsFwbiIoawi
         SnAyAbmARi3VFG9wxCFtbkxmKszVdcK9xD4Ka1XI+cn/tU5BM7eC25m1PPTWhS0W0BGs
         QauHvlK7GWcHemrbdZssXSRvCllMvcufR3X/gLlKR+29do9N7CSOlISIPCC7bg3Dkr0o
         +stQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=67amdkFUWuBIO08FKhiKfYXgae2z4MWbXEmfuMC+Qms=;
        b=Gxmz2UHUH7i2qkzW1gioHsnRdUVIhc1iwtllZrPWCWlW/er8axdl45wHoBM9hNJ27T
         eS8olHAYV2dsTAD6Bd8emYL1YGSXrkd1zAF6CWPegdTTZyOx5Gxv5ts+Sm0GguSPmJr3
         /TyW5jAuGtWtT6pJtYhw8BxRf7A+Tl78FIFr4NbS+RPzc24uBF3ZgCFQ996zGiSKOs6F
         hpdAE9kf8ATNw9dHMAtJ8WzBtjJGUS+qv5HeH/K4nknXLCVOvzYES+vLSOZ243tDc5nQ
         rXzRCs1aHrX4ehP8oDls+AqbR13k5/xsgLsAEC1dHho8/0Wn2xA69CpB1cRtzk/dfan2
         1p8w==
X-Gm-Message-State: AOAM530IjAgFjJ8yXsUAhidXezPXcRf2Y7kEWVj1vo5dsafU6vaoQVX2
        yGXxBoRZMhHdJqDgvKlBODc=
X-Google-Smtp-Source: ABdhPJzy8C11TxTT6dFAauGMg+9yI6/z23grQTnVgtPIhn4CY4AWhnII3nZsbSeEJBS2VbCqfqRx+g==
X-Received: by 2002:a05:6000:178b:: with SMTP id e11mr4513123wrg.634.1644104770317;
        Sat, 05 Feb 2022 15:46:10 -0800 (PST)
Received: from localhost.localdomain (cpc92882-cmbg20-2-0-cust452.5-4.cable.virginm.net. [86.31.103.197])
        by smtp.gmail.com with ESMTPSA id t14sm13644588wmq.43.2022.02.05.15.46.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Feb 2022 15:46:10 -0800 (PST)
From:   Benjamin Mordaunt <crawford.benjamin15@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Benjamin Mordaunt <crawford.benjamin15@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] add pmu to amlogic meson sm1
Date:   Sat,  5 Feb 2022 23:45:54 +0000
Message-Id: <20220205234554.4403-1-crawford.benjamin15@gmail.com>
X-Mailer: git-send-email 2.34.1
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

---
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
index 3d8b1f4f2..4147eecd2 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
@@ -6,6 +6,8 @@
 
 #include "meson-g12-common.dtsi"
 #include <dt-bindings/clock/axg-audio-clkc.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/meson-sm1-power.h>
 #include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
 #include <dt-bindings/reset/amlogic,meson-g12a-audio-reset.h>
@@ -90,7 +92,16 @@ l2: l2-cache0 {
 			compatible = "cache";
 		};
 	};
-
+	
+	arm-pmu {
+		compatible = "arm,cortex-a55-pmu";
+		interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
+	};
+	
 	cpu_opp_table: opp-table {
 		compatible = "operating-points-v2";
 		opp-shared;
-- 
2.34.1

