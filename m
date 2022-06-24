Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D92C559F3E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 19:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbiFXRIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiFXRIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:08:17 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C4145517
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:08:16 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ge10so5951291ejb.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B3kbilczJ8RqirddUQQRugRdMnYuaeBC6YottAZodwA=;
        b=HRBaG764wephebWOC8/49MIYVztpToSxXeB0QsyV22rOgy8GG7+IV6JbhsDyVBO8Gv
         fxdW2KYjaM16uOxKmVZSOuAJAKR/kFTEs02n7ITm9uXnV10YRgVgu9jfruDqQiarOpft
         fxeakHN0/TAdKp1Qml2w6Gd0Szlu+Ln1r9h1el/0hvvNw7PblN2PimBFJPmH9TzJ+AXp
         lsywsu8YIyLROyBxAZPk0rjDc1yc7bTet143kWB634CeJ7brnl+opM0bkpYwWfF9p/ra
         PHvm2mrFQm+eR3dnUFyfvTbOKITIJdV47k4+pjsbbk/qAhDoowIx0Z3+JOFbDRAlgyq4
         Q4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B3kbilczJ8RqirddUQQRugRdMnYuaeBC6YottAZodwA=;
        b=y1Pz8i5imET5/bmxjbcx6ouvhAaJFKAozihSb8XbpK7zRQOtK3eQryTUTNi0ce5ZEo
         AxRV9t5PLRAp9MdJGnzZ1H10MB2YmaNqYE6HiWgfcLtrJdcEbaOeq55rFe2A08M74KF3
         vyAVPcxiDPHD0Verw11YwpFj0wDD2IPjHz8r1gAskiMta6Uy3r12A+MfKIot+8heAGhe
         EP2DGR836MwSj/lPWoyrCXfUFpcnyCWwxq5AJWVCCni09ny7JngbuR6SD9FJJSb2QHsf
         OQmun8Y+q5kPMHl57i2oToGP4u2zYWfHWlAs8/jNhUZp1T9FmnndJVyAdll0eDdQy6QE
         axSg==
X-Gm-Message-State: AJIora+2ELFX3BanDpC819874i5JqQae3YdOAHtDJu/ZzgNvCJ1PJko6
        d7qICGWgzD+CZdI3a8K0WzaU1AnzzfSLag==
X-Google-Smtp-Source: AGRyM1uof2YdzllXeIBAMDcOip+DoGmlHYw/RrLhxqqbIl9BLXRgli7t/mzBKTyj/GlSUCJJRAzFSQ==
X-Received: by 2002:a17:907:9727:b0:6fe:d943:312f with SMTP id jg39-20020a170907972700b006fed943312fmr14178971ejc.263.1656090496153;
        Fri, 24 Jun 2022 10:08:16 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id i24-20020a170906251800b007262a1c8d20sm1433742ejb.19.2022.06.24.10.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 10:08:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] riscv: dts: align gpio-key node names with dtschema
Date:   Fri, 24 Jun 2022 19:08:11 +0200
Message-Id: <20220624170811.66395-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node names should be generic and DT schema expects certain pattern
(e.g. with key/button/switch).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

See: https://lore.kernel.org/all/20220616005224.18391-1-krzysztof.kozlowski@linaro.org/
---
 arch/riscv/boot/dts/canaan/canaan_kd233.dts     | 2 +-
 arch/riscv/boot/dts/canaan/sipeed_maix_bit.dts  | 2 +-
 arch/riscv/boot/dts/canaan/sipeed_maix_dock.dts | 2 +-
 arch/riscv/boot/dts/canaan/sipeed_maix_go.dts   | 6 +++---
 arch/riscv/boot/dts/canaan/sipeed_maixduino.dts | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/boot/dts/canaan/canaan_kd233.dts b/arch/riscv/boot/dts/canaan/canaan_kd233.dts
index 039b92abf046..f72540bd14a3 100644
--- a/arch/riscv/boot/dts/canaan/canaan_kd233.dts
+++ b/arch/riscv/boot/dts/canaan/canaan_kd233.dts
@@ -35,7 +35,7 @@ led1 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		key0 {
+		key {
 			label = "KEY0";
 			linux,code = <BTN_0>;
 			gpios = <&gpio0 10 GPIO_ACTIVE_LOW>;
diff --git a/arch/riscv/boot/dts/canaan/sipeed_maix_bit.dts b/arch/riscv/boot/dts/canaan/sipeed_maix_bit.dts
index b9e30df127fe..8abdbe26a1d0 100644
--- a/arch/riscv/boot/dts/canaan/sipeed_maix_bit.dts
+++ b/arch/riscv/boot/dts/canaan/sipeed_maix_bit.dts
@@ -47,7 +47,7 @@ led2 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		boot {
+		key-boot {
 			label = "BOOT";
 			linux,code = <BTN_0>;
 			gpios = <&gpio0 0 GPIO_ACTIVE_LOW>;
diff --git a/arch/riscv/boot/dts/canaan/sipeed_maix_dock.dts b/arch/riscv/boot/dts/canaan/sipeed_maix_dock.dts
index 8d23401b0bbb..3c6df1ecf76f 100644
--- a/arch/riscv/boot/dts/canaan/sipeed_maix_dock.dts
+++ b/arch/riscv/boot/dts/canaan/sipeed_maix_dock.dts
@@ -52,7 +52,7 @@ led2 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		boot {
+		key-boot {
 			label = "BOOT";
 			linux,code = <BTN_0>;
 			gpios = <&gpio0 0 GPIO_ACTIVE_LOW>;
diff --git a/arch/riscv/boot/dts/canaan/sipeed_maix_go.dts b/arch/riscv/boot/dts/canaan/sipeed_maix_go.dts
index 24fd83b43d9d..03c9843d503e 100644
--- a/arch/riscv/boot/dts/canaan/sipeed_maix_go.dts
+++ b/arch/riscv/boot/dts/canaan/sipeed_maix_go.dts
@@ -46,19 +46,19 @@ led2 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		up {
+		key-up {
 			label = "UP";
 			linux,code = <BTN_1>;
 			gpios = <&gpio1_0 7 GPIO_ACTIVE_LOW>;
 		};
 
-		press {
+		key-press {
 			label = "PRESS";
 			linux,code = <BTN_0>;
 			gpios = <&gpio0 0 GPIO_ACTIVE_LOW>;
 		};
 
-		down {
+		key-down {
 			label = "DOWN";
 			linux,code = <BTN_2>;
 			gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
diff --git a/arch/riscv/boot/dts/canaan/sipeed_maixduino.dts b/arch/riscv/boot/dts/canaan/sipeed_maixduino.dts
index 25341f38292a..7164ad063178 100644
--- a/arch/riscv/boot/dts/canaan/sipeed_maixduino.dts
+++ b/arch/riscv/boot/dts/canaan/sipeed_maixduino.dts
@@ -23,7 +23,7 @@ chosen {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		boot {
+		key-boot {
 			label = "BOOT";
 			linux,code = <BTN_0>;
 			gpios = <&gpio0 0 GPIO_ACTIVE_LOW>;
-- 
2.34.1

