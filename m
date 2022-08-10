Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0840958EAF7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 13:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbiHJLLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 07:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbiHJLK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 07:10:58 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0193122A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 04:10:57 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id o2so13421327lfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 04:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=0NJYHxl2sSCARSpRmKocAQQrRAIzRJl2BopY1qIZr58=;
        b=yYKmSFSYuFZDUIyulwETMHk2j/hRz95hjs/CF67Z32pIDxgAGmzlAEJJk7I1X1Xu2A
         ByhvPuzMbhDR67O2E6e6onPPB61pCwpUcSnDpTJBNSWOUdc8bpFrVF3SEjExkWs/TTem
         MHqPlctS+ArKjrM4h1ehmanWsvvJH2rTU44TJXqJmiJFHvymPcPGY6lOGQcrVZKvcD7h
         DwUtChuFaX1cT+mY/J7AZ6TRJT2gRFo+/qohKWWIBWDhsvzY4DJ+lU2ifLODakE6c/X9
         uXewaovVpd0yJfYrX4Rs454H94pU9v7m+PsHS5zOBF2ChGW/pxkNw5JpcDIRlF/30gcR
         aARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=0NJYHxl2sSCARSpRmKocAQQrRAIzRJl2BopY1qIZr58=;
        b=N6UXC9b6sbfhf/qv8p/1yXqgmAdMMnVdVWoXXL+ugARj1/1Rdy4x8a2PDu38UYyaZw
         AReqWj0qtWgiHcII9RNmBB/yPyKTwV9vZL1EiUDdaMXg2kkSagtAOfRZhys6iwbxYI/O
         SDhFQXWuCFbpnZ9m0VnysKNyRE0ixhmvhlcGUd01vcrp74GVvHU9zFJHSHMtMwFb0Epc
         dA08l1Ia/cd3RxoLts98GzIN+LGseZlhTwmFoS0+XdQLXiEG9jKHW9AkpxJddez6it/l
         sF9iSkmf8EM1g1Ya3H1XTBQRPfOm9Tyc1Uh3ZfL1h7lLuiHTIxEiYYhCi/uanNidHCYk
         6t0w==
X-Gm-Message-State: ACgBeo0NFAWX+PaFR/2ph/1lYnKp9KIudLeWjTjGg6p88YTE7KvrAHL6
        b2jnv6Haj8yX/6xm4bIXvFDEyw==
X-Google-Smtp-Source: AA6agR5GoInR6KReW/mZtzk5A0uaQ3P93T+dRq6tcxr9aUYfVjXkcKSvMWQv7PKkGeZsRRaMbwpr4A==
X-Received: by 2002:a05:6512:3a90:b0:48a:fcf6:3137 with SMTP id q16-20020a0565123a9000b0048afcf63137mr8780363lfu.255.1660129855544;
        Wed, 10 Aug 2022 04:10:55 -0700 (PDT)
Received: from localhost.localdomain ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id t8-20020a199108000000b0048af39ff3edsm304347lfd.122.2022.08.10.04.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 04:10:55 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: vf610: align SPI node name with dtschema
Date:   Wed, 10 Aug 2022 14:10:53 +0300
Message-Id: <20220810111053.281003-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node names should be generic and DT schema expects certain pattern.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/vf610-bk4.dts           | 2 +-
 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/vf610-bk4.dts b/arch/arm/boot/dts/vf610-bk4.dts
index 830c85476b3d..551a4c3ff4fa 100644
--- a/arch/arm/boot/dts/vf610-bk4.dts
+++ b/arch/arm/boot/dts/vf610-bk4.dts
@@ -61,7 +61,7 @@ reg_vcc_3v3_mcu: regulator-vcc3v3mcu {
 		regulator-max-microvolt = <3300000>;
 	};
 
-	spi-gpio {
+	spi {
 		compatible = "spi-gpio";
 		pinctrl-0 = <&pinctrl_gpio_spi>;
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts b/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
index 1f9686c33a84..42ed4a04a12e 100644
--- a/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
+++ b/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
@@ -288,7 +288,7 @@ mdio_mux_8: mdio@8 {
 		};
 	};
 
-	spi0 {
+	spi-0 {
 		compatible = "spi-gpio";
 		pinctrl-0 = <&pinctrl_gpio_spi0>;
 		pinctrl-names = "default";
-- 
2.34.1

