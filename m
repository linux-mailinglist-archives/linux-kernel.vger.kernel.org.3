Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03C34F6BC5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 22:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbiDFUzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 16:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234611AbiDFUzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:55:17 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C383E3D5194;
        Wed,  6 Apr 2022 12:17:32 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-e2442907a1so3633166fac.8;
        Wed, 06 Apr 2022 12:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=+elv5nUcYO+9KxIPsGLm8mW7Otl7wTZ4tdEnucwBh/c=;
        b=sLmennbdlBWZSwfIzISplH5XthZ61aHvz+6WZnd83vyqTRRWt1Pbkp/O/a851/RO8C
         q2SgGyiGkBBCftm7FAd84G2yV432bSUITj/2fdlZ1ZuIlntVKv62b8l10UHFYAcfbtPx
         s40EWiDhejKLwf+DSdBpbqAMXNMsLRpMSbaJn1yh6rjcHlbJDRy69hq0sKIzl1T5kMpL
         Wn5XIfyFKVcpyLhZKY0ZKc4lkhwbln410YOYY6hyCJTW9iuDGWDhk7h0HliQwRJ0aIiA
         TAxBDKo5w+0L1CTH7M7SgnWhIhQjURDcGc9BeI641owdWwZaqJqASz7hFQdJRWU/Hyck
         S/2Q==
X-Gm-Message-State: AOAM533uN4la/lF/WRHLyGLom3JOA73Yhc5wIm87erPjzlPtOruXHEGI
        pzNUK2665wryGvA+TKmHEg==
X-Google-Smtp-Source: ABdhPJzWUypFFpBzMufl7IKO2Huhe7Ol7N6/hBhhXxa5wzfiiHRzIVxOp8s5NaDTX2ceV8BZrbhv6g==
X-Received: by 2002:a05:6870:9628:b0:e1:c420:af75 with SMTP id d40-20020a056870962800b000e1c420af75mr4617093oaq.246.1649272652036;
        Wed, 06 Apr 2022 12:17:32 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k30-20020a056870819e00b000e18ee342c0sm7171247oae.18.2022.04.06.12.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 12:17:31 -0700 (PDT)
Received: (nullmailer pid 2614465 invoked by uid 1000);
        Wed, 06 Apr 2022 19:17:30 -0000
Date:   Wed, 6 Apr 2022 14:17:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, soc@kernel.org
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] arm64: dts: tegra: Fix boolean properties with values
Message-ID: <Yk3nShkFzNJaI3/Z@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.32.0
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
Can someone apply this for 5.18.

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

