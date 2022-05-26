Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1ED5354D7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240036AbiEZUot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349055AbiEZUoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:44:06 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2BABF4B
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:43:56 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id u20so3163327edd.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dsi9QOKKEq+Gq7K5pC3bfltgznXdiEGEzIyAtjmGd6w=;
        b=sN5esgzHy1r7EwRHGOK1EJV2hGeoC/W0RBHlEDlv2hQHGJ7OEHtkQqFWASC2zx46MP
         ghDuKZMrm4pGE5vCoZUYYdcx8o02iKMrd9mVmVIr4VSUUz1QhGz0c9cf+p2GEVeGUcv/
         P05kttBYygAtI0BgYwqMFgZ7XeCkcj61UTRi1ounkhJ8Yh2GnNyTFzaUQ4aUfxkepSx4
         5ZngsVua4LQzjirQG5Y8IVlp9UvLj3ppKu0oHe4Z96gXkSdoY93VN8o+81uD9TKAUXVK
         v8d0vTFaZihcAwDvc3LBLpOPODeyZVti48ZZK2XPSP7UL13hSIZ5JoE3slktoWewLZEC
         ZlSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dsi9QOKKEq+Gq7K5pC3bfltgznXdiEGEzIyAtjmGd6w=;
        b=J/l/6IZ++zjzBgW5OEqHR4rwdrXrLF/4oK8o+mD3ZaY6BsdfckUwoVxiDU7QqmBie1
         Y5bMHMFz0ldUOAfU4eLKvQL9e/dhtcqGiQ98O6RT9TMZYgMLDukNMUhjnWTF74R74Tbg
         oX2+dbCTSP1t7E7GDhYPPx4/yxzcyZtLuVvzlj6wCgBC+Udgu0tvlFRavy/hT7rE9V0y
         H69WuAmDndkTDcv8i7sFaG8qiFaahkfqieNO6VujVuJy82IQVFYqOijWXqPl750b4Pom
         94i0tk9b4viV9HbirBCzKUfJq0OSeyNBoOQuO0ZKb3f7DYBhNaoGnPS5fZXEFanxQ0FA
         NKqg==
X-Gm-Message-State: AOAM531eLvj/yeencH4auxF+rtmH6KQJkG9YG+sGzsrpW5FT6JXKCw2h
        mfxmLlPZgdHD7rcmIRLp7iqDFg==
X-Google-Smtp-Source: ABdhPJy39XOcWA6QrDYRwoFCG5pXOg3b6bp6ZaoAT2xwYTfDZBle+zPNr3kYUdwVsE9J0/wT97cd/g==
X-Received: by 2002:a05:6402:12d5:b0:42b:c6a8:ab3 with SMTP id k21-20020a05640212d500b0042bc6a80ab3mr11276378edx.209.1653597836165;
        Thu, 26 May 2022 13:43:56 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id h4-20020a17090619c400b006f3ef214e6esm817635ejd.212.2022.05.26.13.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:43:55 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: arm: adjust whitespace around '='
Date:   Thu, 26 May 2022 22:43:50 +0200
Message-Id: <20220526204350.832361-1-krzysztof.kozlowski@linaro.org>
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

Fix whitespace coding style: use single space instead of tabs or
multiple spaces around '=' sign in property assignment.  No functional
changes (same DTB).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Output compared with dtx_diff and fdtdump.
---
 arch/arm64/boot/dts/arm/juno-base.dtsi    | 44 +++++++++++------------
 arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi | 16 ++++-----
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index 065381c1cbf5..8d0d45d168d1 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -581,36 +581,36 @@ cti_sys0: cti@20020000 { /* sys_cti_0 */
 
 		trig-conns@0 {
 			reg = <0>;
-			arm,trig-in-sigs=<2 3>;
-			arm,trig-in-types=<SNK_FULL SNK_ACQCOMP>;
-			arm,trig-out-sigs=<0 1>;
-			arm,trig-out-types=<SNK_FLUSHIN SNK_TRIGIN>;
+			arm,trig-in-sigs = <2 3>;
+			arm,trig-in-types = <SNK_FULL SNK_ACQCOMP>;
+			arm,trig-out-sigs = <0 1>;
+			arm,trig-out-types = <SNK_FLUSHIN SNK_TRIGIN>;
 			arm,cs-dev-assoc = <&etr_sys>;
 		};
 
 		trig-conns@1 {
 			reg = <1>;
-			arm,trig-in-sigs=<0 1>;
-			arm,trig-in-types=<SNK_FULL SNK_ACQCOMP>;
-			arm,trig-out-sigs=<7 6>;
-			arm,trig-out-types=<SNK_FLUSHIN SNK_TRIGIN>;
+			arm,trig-in-sigs = <0 1>;
+			arm,trig-in-types = <SNK_FULL SNK_ACQCOMP>;
+			arm,trig-out-sigs = <7 6>;
+			arm,trig-out-types = <SNK_FLUSHIN SNK_TRIGIN>;
 			arm,cs-dev-assoc = <&etf_sys0>;
 		};
 
 		trig-conns@2 {
 			reg = <2>;
-			arm,trig-in-sigs=<4 5 6 7>;
-			arm,trig-in-types=<STM_TOUT_SPTE STM_TOUT_SW
+			arm,trig-in-sigs = <4 5 6 7>;
+			arm,trig-in-types = <STM_TOUT_SPTE STM_TOUT_SW
 					   STM_TOUT_HETE STM_ASYNCOUT>;
-			arm,trig-out-sigs=<4 5>;
-			arm,trig-out-types=<STM_HWEVENT STM_HWEVENT>;
+			arm,trig-out-sigs = <4 5>;
+			arm,trig-out-types = <STM_HWEVENT STM_HWEVENT>;
 			arm,cs-dev-assoc = <&stm_sys>;
 		};
 
 		trig-conns@3 {
 			reg = <3>;
-			arm,trig-out-sigs=<2 3>;
-			arm,trig-out-types=<SNK_FLUSHIN SNK_TRIGIN>;
+			arm,trig-out-sigs = <2 3>;
+			arm,trig-out-types = <SNK_FLUSHIN SNK_TRIGIN>;
 			arm,cs-dev-assoc = <&tpiu_sys>;
 		};
 	};
@@ -628,24 +628,24 @@ cti_sys1: cti@20110000 { /* sys_cti_1 */
 
 		trig-conns@0 {
 			reg = <0>;
-			arm,trig-in-sigs=<0>;
-			arm,trig-in-types=<GEN_INTREQ>;
-			arm,trig-out-sigs=<0>;
-			arm,trig-out-types=<GEN_HALTREQ>;
+			arm,trig-in-sigs = <0>;
+			arm,trig-in-types = <GEN_INTREQ>;
+			arm,trig-out-sigs = <0>;
+			arm,trig-out-types = <GEN_HALTREQ>;
 			arm,trig-conn-name = "sys_profiler";
 		};
 
 		trig-conns@1 {
 			reg = <1>;
-			arm,trig-out-sigs=<2 3>;
-			arm,trig-out-types=<GEN_HALTREQ GEN_RESTARTREQ>;
+			arm,trig-out-sigs = <2 3>;
+			arm,trig-out-types = <GEN_HALTREQ GEN_RESTARTREQ>;
 			arm,trig-conn-name = "watchdog";
 		};
 
 		trig-conns@2 {
 			reg = <2>;
-			arm,trig-out-sigs=<1 6>;
-			arm,trig-out-types=<GEN_HALTREQ GEN_RESTARTREQ>;
+			arm,trig-out-sigs = <1 6>;
+			arm,trig-out-types = <GEN_HALTREQ GEN_RESTARTREQ>;
 			arm,trig-conn-name = "g_counter";
 		};
 	};
diff --git a/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi b/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
index 2e43f4531308..ba88d1596f6f 100644
--- a/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
@@ -96,24 +96,24 @@ cti_sys2: cti@20160000 { /* sys_cti_2 */
 
 		trig-conns@0 {
 			reg = <0>;
-			arm,trig-in-sigs=<0 1>;
-			arm,trig-in-types=<SNK_FULL SNK_ACQCOMP>;
-			arm,trig-out-sigs=<0 1>;
-			arm,trig-out-types=<SNK_FLUSHIN SNK_TRIGIN>;
+			arm,trig-in-sigs = <0 1>;
+			arm,trig-in-types = <SNK_FULL SNK_ACQCOMP>;
+			arm,trig-out-sigs = <0 1>;
+			arm,trig-out-types = <SNK_FLUSHIN SNK_TRIGIN>;
 			arm,cs-dev-assoc = <&etf_sys1>;
 		};
 
 		trig-conns@1 {
 			reg = <1>;
-			arm,trig-in-sigs=<2 3 4>;
-			arm,trig-in-types=<ELA_DBGREQ ELA_TSTART ELA_TSTOP>;
+			arm,trig-in-sigs = <2 3 4>;
+			arm,trig-in-types = <ELA_DBGREQ ELA_TSTART ELA_TSTOP>;
 			arm,trig-conn-name = "ela_clus_0";
 		};
 
 		trig-conns@2 {
 			reg = <2>;
-			arm,trig-in-sigs=<5 6 7>;
-			arm,trig-in-types=<ELA_DBGREQ ELA_TSTART ELA_TSTOP>;
+			arm,trig-in-sigs = <5 6 7>;
+			arm,trig-in-types = <ELA_DBGREQ ELA_TSTART ELA_TSTOP>;
 			arm,trig-conn-name = "ela_clus_1";
 		};
 	};
-- 
2.34.1

