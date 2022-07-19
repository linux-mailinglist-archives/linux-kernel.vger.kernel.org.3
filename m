Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E4A57960B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235935AbiGSJSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237207AbiGSJSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:18:12 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9298D220CC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:18:11 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso7385562wma.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pNhfidQZPy4nesbmSTVW7vok5HUfn+3S34+KfpxEpgw=;
        b=EnGSNGy5RdfoxqGyaL/6Mfl5Mu4xeaV+lNE4hr5eRrn20ZkeahpfXqHZuwz1pkiCIe
         eSeBtn0JfJor56Q1n3t4BdKFhDrVc1V1dk0a612Zam9WSWVnweal1KpNVfyvnYIwtrYW
         GiNIhhvSLMAcgPHYQ4j6JFmxLEKQI/P+aHql3gs3www91xMJZl2Xg7r4Nt9bOJmvx8sn
         flGsgBv+NBMa0hMdQVfr1ITNdoDxx3H+0qphqxZLmxis+CI1Px8LkUqo9X1hyae5YMv9
         KmkNvxPuLmCSiCDfCxuD9/L2rvbX//TpjkN1M5rZrCyx1lBk+5+RCTW+PmFQ2zbEeCi6
         NZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pNhfidQZPy4nesbmSTVW7vok5HUfn+3S34+KfpxEpgw=;
        b=NWjr4pl+Np/Wlni5ZS36gy5FyeC3BwECsZl8a0wQ8hPBMfrp9f83q1z7ahAAzog0E0
         EYGv7RvCe5hfYX2AkMKy0mH+i9663YNXO08blC/ZZII0PMBHozTziPzJFC6pUApa91F2
         3aDclM9zN5aOzBBeDzlcMhB10RcyozJVARWV8LlyJLBmQVGBgvTWz9MBRcmpfWXSujeN
         VbM67rGw5YFKcnpvqq8yx03mXHdHGT00biGnRu/mp9Ek0ZGF4mDWcJ4uxHqQXNeFMQc+
         WWOSd6pwGAdGlPNcj4zaIfY4SgcFFqoSpx+SAuU+K/J41aa1RY/uaAZpxRpiuKWV1169
         J1eg==
X-Gm-Message-State: AJIora8QRvna+83TFxzAvLFDNdUBU3QkmVdJIdeysq9VmCgf3g3xV5lq
        42aOgsIbLx7a0jfydLOuSopcXQ==
X-Google-Smtp-Source: AGRyM1s8oukaSdO5ADKKkCh/UFBb/VAgqcixFfxa+iFckKbglDwEWQMz369PqIshcKY298IzgWmHQQ==
X-Received: by 2002:a1c:7401:0:b0:3a3:182f:7be9 with SMTP id p1-20020a1c7401000000b003a3182f7be9mr10987620wmc.189.1658222290089;
        Tue, 19 Jul 2022 02:18:10 -0700 (PDT)
Received: from localhost.localdomain (192.201.68.85.rev.sfr.net. [85.68.201.192])
        by smtp.gmail.com with ESMTPSA id bk19-20020a0560001d9300b0021d63fe0f03sm12944281wrb.12.2022.07.19.02.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 02:18:09 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org
Cc:     khilman@baylibre.com, narmstrong@baylibre.com, msp@baylibre.com,
        j-keerthy@ti.c, lee.jones@linaro.org, jneanne@baylibre.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 12/14] arm64: dts: ti: Add pinmux and irq mapping for TPS65219 external interrupts
Date:   Tue, 19 Jul 2022 11:17:40 +0200
Message-Id: <20220719091742.3221-13-jneanne@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220719091742.3221-1-jneanne@baylibre.com>
References: <20220719091742.3221-1-jneanne@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interrupt occurring on PMIC TPS65219 is propagated to SOC
through EXTINTn pin connected to gic500 interrupt controller

Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am642-sk.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 4daf55b9d61a..7a84223406f5 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -285,6 +285,12 @@
 			AM64X_IOPAD(0x00b8, PIN_INPUT, 7) /* (Y7) PRG1_PRU0_GPO0.GPIO0_45 */
 		>;
 	};
+
+	pmic_irq_pins_default: pmic-irq-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0278, PIN_INPUT, 0) /* (C19) EXTINTn */
+		>;
+	};
 };
 
 &mcu_uart0 {
@@ -338,6 +344,12 @@
 		compatible = "ti,tps65219";
 		reg = <0x30>;
 		system-power-controller;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_irq_pins_default>;
+		interrupt-parent = <&gic500>;
+		interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
 
 		buck1-supply = <&vcc_3v3_sys>;
 		buck2-supply = <&vcc_3v3_sys>;
-- 
2.17.1

