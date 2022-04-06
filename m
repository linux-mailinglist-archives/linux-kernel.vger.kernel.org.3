Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115A14F6BC2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 22:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbiDFUzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 16:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbiDFUyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:54:09 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABD612559E;
        Wed,  6 Apr 2022 12:13:12 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-e2442907a1so3620215fac.8;
        Wed, 06 Apr 2022 12:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=gCyouhm8Sz3EhCsia+t+VgyOXZaTMfQNweSUJUNG5Vk=;
        b=T/pBo2oeUhWQSCUuDLDl54v0FgIwIzkyx1iDXnhFewMPFPcE3ZKUw2dLLAqkfJnRpr
         9zhrcPcBmefo51GBPSshoolhTaheGNBvZQvT2jM/+VSL2b7wFf23Q/9yPSMWLafoD2mD
         cy6F+QYIhaO+yN+JDRTxtwDhOCtco0S5aPtRGlEjUa4wdb2RutDe9Sj/H6+Lo/cFFxDA
         jbCkUMq82nwksFIThCf5xejZIZpVUSs3EuC3gpHlzrxoNeYVJ4P4c1P28XaBWdClPwdq
         4FIJeRwbxGuNtXpLntSQPG8XEvAoGwKBPXFVFt3h4JNKN1NBxhPc84tmo1/zfDWWa8I8
         lAsA==
X-Gm-Message-State: AOAM533IHwMuiKi4HElSs68Q+fcKJexcD/GabmaD8Ru5ysPEBQQl7Lvt
        +NNzezOy/+jlE32Dg4+QPg==
X-Google-Smtp-Source: ABdhPJzXfDW3cJtPjB0lFkipxOAvJxKg9qeFR3aBPGtvrh2pIydzjyd6xMIC22kk1pNdQvj/iix21w==
X-Received: by 2002:a05:6870:b402:b0:d3:3712:efa7 with SMTP id x2-20020a056870b40200b000d33712efa7mr4529972oap.88.1649272392232;
        Wed, 06 Apr 2022 12:13:12 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v13-20020a4ae6cd000000b00328882a2388sm6375281oot.14.2022.04.06.12.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 12:13:11 -0700 (PDT)
Received: (nullmailer pid 2608637 invoked by uid 1000);
        Wed, 06 Apr 2022 19:13:11 -0000
Date:   Wed, 6 Apr 2022 14:13:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, soc@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] arm: dts: imx: Fix boolean properties with values
Message-ID: <Yk3mR5yae3gCkKhp@robh.at.kernel.org>
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
Can someone please apply this for 5.18.

 arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi  | 32 +++++++++----------
 .../dts/imx6ul-phytec-segin-peb-av-02.dtsi    |  4 +--
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi b/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
index 563bf9d44fe0..0b90c3f59f89 100644
--- a/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
@@ -154,112 +154,112 @@ pmic@58 {
 		regulators {
 			bcore1 {
 				regulator-name = "bcore1";
-				regulator-always-on = <1>;
+				regulator-always-on;
 				regulator-min-microvolt = <300000>;
 				regulator-max-microvolt = <3300000>;
 			};
 
 			bcore2 {
 				regulator-name = "bcore2";
-				regulator-always-on = <1>;
+				regulator-always-on;
 				regulator-min-microvolt = <300000>;
 				regulator-max-microvolt = <3300000>;
 			};
 
 			bpro {
 				regulator-name = "bpro";
-				regulator-always-on = <1>;
+				regulator-always-on;
 				regulator-min-microvolt = <300000>;
 				regulator-max-microvolt = <3300000>;
 			};
 
 			bperi {
 				regulator-name = "bperi";
-				regulator-always-on = <1>;
+				regulator-always-on;
 				regulator-min-microvolt = <300000>;
 				regulator-max-microvolt = <3300000>;
 			};
 
 			bmem {
 				regulator-name = "bmem";
-				regulator-always-on = <1>;
+				regulator-always-on;
 				regulator-min-microvolt = <300000>;
 				regulator-max-microvolt = <3300000>;
 			};
 
 			ldo2 {
 				regulator-name = "ldo2";
-				regulator-always-on = <1>;
+				regulator-always-on;
 				regulator-min-microvolt = <300000>;
 				regulator-max-microvolt = <1800000>;
 			};
 
 			ldo3 {
 				regulator-name = "ldo3";
-				regulator-always-on = <1>;
+				regulator-always-on;
 				regulator-min-microvolt = <300000>;
 				regulator-max-microvolt = <3300000>;
 			};
 
 			ldo4 {
 				regulator-name = "ldo4";
-				regulator-always-on = <1>;
+				regulator-always-on;
 				regulator-min-microvolt = <300000>;
 				regulator-max-microvolt = <3300000>;
 			};
 
 			ldo5 {
 				regulator-name = "ldo5";
-				regulator-always-on = <1>;
+				regulator-always-on;
 				regulator-min-microvolt = <300000>;
 				regulator-max-microvolt = <3300000>;
 			};
 
 			ldo6 {
 				regulator-name = "ldo6";
-				regulator-always-on = <1>;
+				regulator-always-on;
 				regulator-min-microvolt = <300000>;
 				regulator-max-microvolt = <3300000>;
 			};
 
 			ldo7 {
 				regulator-name = "ldo7";
-				regulator-always-on = <1>;
+				regulator-always-on;
 				regulator-min-microvolt = <300000>;
 				regulator-max-microvolt = <3300000>;
 			};
 
 			ldo8 {
 				regulator-name = "ldo8";
-				regulator-always-on = <1>;
+				regulator-always-on;
 				regulator-min-microvolt = <300000>;
 				regulator-max-microvolt = <3300000>;
 			};
 
 			ldo9 {
 				regulator-name = "ldo9";
-				regulator-always-on = <1>;
+				regulator-always-on;
 				regulator-min-microvolt = <300000>;
 				regulator-max-microvolt = <3300000>;
 			};
 
 			ldo10 {
 				regulator-name = "ldo10";
-				regulator-always-on = <1>;
+				regulator-always-on;
 				regulator-min-microvolt = <300000>;
 				regulator-max-microvolt = <3300000>;
 			};
 
 			ldo11 {
 				regulator-name = "ldo11";
-				regulator-always-on = <1>;
+				regulator-always-on;
 				regulator-min-microvolt = <300000>;
 				regulator-max-microvolt = <3300000>;
 			};
 
 			bio {
 				regulator-name = "bio";
-				regulator-always-on = <1>;
+				regulator-always-on;
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 			};
diff --git a/arch/arm/boot/dts/imx6ul-phytec-segin-peb-av-02.dtsi b/arch/arm/boot/dts/imx6ul-phytec-segin-peb-av-02.dtsi
index 7cda6944501d..205e4d462702 100644
--- a/arch/arm/boot/dts/imx6ul-phytec-segin-peb-av-02.dtsi
+++ b/arch/arm/boot/dts/imx6ul-phytec-segin-peb-av-02.dtsi
@@ -72,8 +72,8 @@ stmpe_touchscreen {
 			st,settling = <2>;
 			st,fraction-z = <7>;
 			st,i-drive = <1>;
-			touchscreen-inverted-x = <1>;
-			touchscreen-inverted-y = <1>;
+			touchscreen-inverted-x;
+			touchscreen-inverted-y;
 		};
 	};
 };
-- 
2.32.0

