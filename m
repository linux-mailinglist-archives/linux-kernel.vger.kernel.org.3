Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4054CDECB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 21:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiCDU0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiCDU0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:26:14 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CFA1EC255;
        Fri,  4 Mar 2022 12:25:24 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id j9-20020a9d7d89000000b005ad5525ba09so8305495otn.10;
        Fri, 04 Mar 2022 12:25:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EY9hak+iu9fGJ+F3hWusD/srRz90e1L1jUM7ENmyTjs=;
        b=l+DxP2oJjty/u46LNZs+Qi7LbA2CRhrNdrElLtawR3UjQjKTwV1S5Nvzu4rDiWJb3+
         pR+/4GzKloIk6dxL5mtTtE1xL3KAqbF6cvE4eD3hTYl2cm9WN60ktAIEjCsC1wL21L3x
         6MfiB3yS9nmfW+ly8T/AQ2r8xYBCsfD28CgI+chUczK/04sdUe7Hu3kyxUJVwMWA0XUz
         jXDoSxk5xTIUhVnzXWCjqEXQoyO7FrWG6i3sHcCVFAKzOf6VroVk6HdTSXGXvS67997y
         nwie4908Cx83uV/Uk/OgayzAWfQQSdKQxC7z9IjbgGSx9+DBlB4FoNEdhb3VaZpKcJ3m
         PoBg==
X-Gm-Message-State: AOAM531iz72SgVtBYjWvjam0rSUSvWmpLXQhXKfEUqKFSkrR0eJasB9H
        CZEApikcuiT485mnhEoIhQ==
X-Google-Smtp-Source: ABdhPJyI3sBYN7F8FzB/KuOuXSlwGVsJINPbqQfCsq0CFoblbCsISWpZWtB9rBhIXcQCO8PE8U1yXQ==
X-Received: by 2002:a9d:4b17:0:b0:5af:a888:d0e1 with SMTP id q23-20020a9d4b17000000b005afa888d0e1mr202230otf.163.1646425523375;
        Fri, 04 Mar 2022 12:25:23 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id b15-20020a05687061cf00b000d17a5f0ee6sm2834507oah.11.2022.03.04.12.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 12:25:22 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm: dts: imx: Fix boolean properties with values
Date:   Fri,  4 Mar 2022 14:25:18 -0600
Message-Id: <20220304202518.316164-1-robh@kernel.org>
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

