Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BC24CDED7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 21:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiCDU1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiCDU1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:27:02 -0500
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772951E7A6C;
        Fri,  4 Mar 2022 12:26:13 -0800 (PST)
Received: by mail-oo1-f51.google.com with SMTP id 6-20020a4a0906000000b0031d7eb98d31so10710277ooa.10;
        Fri, 04 Mar 2022 12:26:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9/hN8e4a43/QLz2i6lMzgZn6XDbc+w5WzcndHI+jnhw=;
        b=I+x/dbemgT0T5Y5eI4Agg7DhNef4zEUyPzzfmProybjDT2b0bsepGHCwoPXkGKHwh0
         pjwDxXPnTxpMDgwsHZpWrntgeUlkfmNSDx3umeUpsz0Zew08n4vexFy8TlomQHYKa34T
         JRj6xMtgNrseqOykdDlaNXdc1MPndeikIik6tcIIH+S5DnrMx0ttDznI0QZgMguJWvUO
         7tf6KtVT4Rjz+DC+/bFyQ9vB5kFjb0EWlL7djYckW88hCr8vz0OUEHrRrJBNKwz7hvYP
         BdqZjCmx0TJdSfPjmBw6w3u1UQQxvPvr83UDtuev+CBPoGnewdiA+vxTG0AA0S1e7YXJ
         wTpQ==
X-Gm-Message-State: AOAM530Boj38geBM3AjiiP41o8N57/uBdAGvdXoHvxWrWZMlSugu2G9W
        yLUT87RKfkfoX3UFjvN+9A==
X-Google-Smtp-Source: ABdhPJxt9dNQmQOPXOGuqsdjcoj+0CZfKjqCLGlWC/9ueZPqjYuLgOB+F39C/q5Z11Zru6nHlNoYsA==
X-Received: by 2002:a05:6870:96ac:b0:d9:cb7a:e382 with SMTP id o44-20020a05687096ac00b000d9cb7ae382mr3786739oaq.175.1646425572743;
        Fri, 04 Mar 2022 12:26:12 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id j10-20020a4ad2ca000000b0031c515672d0sm2707636oos.23.2022.03.04.12.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 12:26:12 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: tegra: Fix boolean properties with values
Date:   Fri,  4 Mar 2022 14:26:06 -0600
Message-Id: <20220304202607.318086-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boolean properties in DT are present or not present and don't take a value.
A property such as 'foo = <0>;' evaluated to true. IOW, the value doesn't
matter.

It may have been intended that 0 values are false, but there is no change
in behavior with this patch.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi            | 8 ++++----
 .../boot/dts/nvidia/tegra186-p3509-0000+p3636-0001.dts    | 8 ++++----
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi            | 6 +++---
 arch/arm64/boot/dts/nvidia/tegra194-p3668.dtsi            | 6 +++---
 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi            | 6 +++---
 arch/arm64/boot/dts/nvidia/tegra210-p2894.dtsi            | 8 ++++----
 arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts        | 8 ++++----
 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts             | 4 ++--
 8 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
index aff857df25cf..1df84335925b 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
@@ -262,25 +262,25 @@ gpio3 {
 					gpio4 {
 						pins = "gpio4";
 						function = "32k-out1";
-						drive-push-pull = <1>;
+						drive-push-pull;
 					};
 
 					gpio5 {
 						pins = "gpio5";
 						function = "gpio";
-						drive-push-pull = <0>;
+						drive-push-pull;
 					};
 
 					gpio6 {
 						pins = "gpio6";
 						function = "gpio";
-						drive-push-pull = <1>;
+						drive-push-pull;
 					};
 
 					gpio7 {
 						pins = "gpio7";
 						function = "gpio";
-						drive-push-pull = <0>;
+						drive-push-pull;
 					};
 				};
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p3509-0000+p3636-0001.dts b/arch/arm64/boot/dts/nvidia/tegra186-p3509-0000+p3636-0001.dts
index 4631504c3c7a..1ab132c152bb 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186-p3509-0000+p3636-0001.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p3509-0000+p3636-0001.dts
@@ -462,25 +462,25 @@ gpio3 {
 					gpio4 {
 						pins = "gpio4";
 						function = "32k-out1";
-						drive-push-pull = <1>;
+						drive-push-pull;
 					};
 
 					gpio5 {
 						pins = "gpio5";
 						function = "gpio";
-						drive-push-pull = <0>;
+						drive-push-pull;
 					};
 
 					gpio6 {
 						pins = "gpio6";
 						function = "gpio";
-						drive-push-pull = <1>;
+						drive-push-pull;
 					};
 
 					gpio7 {
 						pins = "gpio7";
 						function = "gpio";
-						drive-push-pull = <1>;
+						drive-push-pull;
 					};
 				};
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
index a7d7cfd66379..634d0f493c2e 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
@@ -174,19 +174,19 @@ gpio3 {
 					gpio4 {
 						pins = "gpio4";
 						function = "32k-out1";
-						drive-push-pull = <1>;
+						drive-push-pull;
 					};
 
 					gpio6 {
 						pins = "gpio6";
 						function = "gpio";
-						drive-push-pull = <1>;
+						drive-push-pull;
 					};
 
 					gpio7 {
 						pins = "gpio7";
 						function = "gpio";
-						drive-push-pull = <0>;
+						drive-push-pull;
 					};
 				};
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p3668.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p3668.dtsi
index 0bd66f9c620b..0b219e72765e 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p3668.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p3668.dtsi
@@ -148,19 +148,19 @@ gpio3 {
 					gpio4 {
 						pins = "gpio4";
 						function = "32k-out1";
-						drive-push-pull = <1>;
+						drive-push-pull;
 					};
 
 					gpio6 {
 						pins = "gpio6";
 						function = "gpio";
-						drive-push-pull = <1>;
+						drive-push-pull;
 					};
 
 					gpio7 {
 						pins = "gpio7";
 						function = "gpio";
-						drive-push-pull = <0>;
+						drive-push-pull;
 					};
 				};
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
index 75eb743a7242..0fe772b04bd0 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
@@ -59,7 +59,7 @@ gpio0 {
 				gpio1 {
 					pins = "gpio1";
 					function = "fps-out";
-					drive-push-pull = <1>;
+					drive-push-pull;
 					maxim,active-fps-source = <MAX77620_FPS_SRC_0>;
 					maxim,active-fps-power-up-slot = <7>;
 					maxim,active-fps-power-down-slot = <0>;
@@ -68,7 +68,7 @@ gpio1 {
 				gpio2_3 {
 					pins = "gpio2", "gpio3";
 					function = "fps-out";
-					drive-open-drain = <1>;
+					drive-open-drain;
 					maxim,active-fps-source = <MAX77620_FPS_SRC_0>;
 				};
 
@@ -80,7 +80,7 @@ gpio4 {
 				gpio5_6_7 {
 					pins = "gpio5", "gpio6", "gpio7";
 					function = "gpio";
-					drive-push-pull = <1>;
+					drive-push-pull;
 				};
 			};
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2894.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2894.dtsi
index 10347b6e6e84..936a309e288c 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2894.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2894.dtsi
@@ -1351,7 +1351,7 @@ gpio0 {
 				gpio1 {
 					pins = "gpio1";
 					function = "fps-out";
-					drive-push-pull = <1>;
+					drive-push-pull;
 					maxim,active-fps-source = <MAX77620_FPS_SRC_0>;
 					maxim,active-fps-power-up-slot = <7>;
 					maxim,active-fps-power-down-slot = <0>;
@@ -1360,14 +1360,14 @@ gpio1 {
 				gpio2 {
 					pins = "gpio2";
 					function = "fps-out";
-					drive-open-drain = <1>;
+					drive-open-drain;
 					maxim,active-fps-source = <MAX77620_FPS_SRC_0>;
 				};
 
 				gpio3 {
 					pins = "gpio3";
 					function = "fps-out";
-					drive-open-drain = <1>;
+					drive-open-drain;
 					maxim,active-fps-source = <MAX77620_FPS_SRC_0>;
 				};
 
@@ -1379,7 +1379,7 @@ gpio4 {
 				gpio5_6_7 {
 					pins = "gpio5", "gpio6", "gpio7";
 					function = "gpio";
-					drive-push-pull = <1>;
+					drive-push-pull;
 				};
 			};
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts b/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
index 72c2dc3c14ea..f6446120c267 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
@@ -195,7 +195,7 @@ gpio0 {
 				gpio1 {
 					pins = "gpio1";
 					function = "fps-out";
-					drive-push-pull = <1>;
+					drive-push-pull;
 					maxim,active-fps-source = <MAX77620_FPS_SRC_NONE>;
 					maxim,active-fps-power-up-slot = <0>;
 					maxim,active-fps-power-down-slot = <7>;
@@ -204,7 +204,7 @@ gpio1 {
 				gpio2 {
 					pins = "gpio2";
 					function = "fps-out";
-					drive-open-drain = <1>;
+					drive-open-drain;
 					maxim,active-fps-source = <MAX77620_FPS_SRC_0>;
 					maxim,active-fps-power-up-slot = <0>;
 					maxim,active-fps-power-down-slot = <7>;
@@ -213,7 +213,7 @@ gpio2 {
 				gpio3 {
 					pins = "gpio3";
 					function = "fps-out";
-					drive-open-drain = <1>;
+					drive-open-drain;
 					maxim,active-fps-source = <MAX77620_FPS_SRC_0>;
 					maxim,active-fps-power-up-slot = <4>;
 					maxim,active-fps-power-down-slot = <3>;
@@ -227,7 +227,7 @@ gpio4 {
 				gpio5_6_7 {
 					pins = "gpio5", "gpio6", "gpio7";
 					function = "gpio";
-					drive-push-pull = <1>;
+					drive-push-pull;
 				};
 			};
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
index a263d51882ee..e42384f097d6 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
@@ -1386,7 +1386,7 @@ gpio0_1_2_7 {
 				gpio3 {
 					pins = "gpio3";
 					function = "fps-out";
-					drive-open-drain = <1>;
+					drive-open-drain;
 					maxim,active-fps-source = <MAX77620_FPS_SRC_0>;
 					maxim,active-fps-power-up-slot = <4>;
 					maxim,active-fps-power-down-slot = <2>;
@@ -1395,7 +1395,7 @@ gpio3 {
 				gpio5_6 {
 					pins = "gpio5", "gpio6";
 					function = "gpio";
-					drive-push-pull = <1>;
+					drive-push-pull;
 				};
 
 				gpio4 {
-- 
2.32.0

