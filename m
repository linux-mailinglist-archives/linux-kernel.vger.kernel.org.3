Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B7E4CDECD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 21:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiCDU0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiCDU00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:26:26 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420A1139CFB;
        Fri,  4 Mar 2022 12:25:34 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id x193so9038125oix.0;
        Fri, 04 Mar 2022 12:25:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=62YFeQpLzf5pTSpYtUYru6W4+OnAejUs+X+2tlIjkF8=;
        b=uQTSwvavDEBthLX3mRSL021X7BIVHvPFxxF3bDpyw7h769G/+/wDa19UlugodiOCiA
         DuDNohf/jAMGJHSU4evz7o/2g0DdWUkI65B5Nnt7WvELbshVufxVKSz2oqub6s1+7XKh
         ++BeIeXXG6MjgprVAGGAM7Xs6XD5BpjaUfvgD9mOyBvlCUkzPs6FlAKY6Z80rHMNIwhL
         /p2V9BpHNAWvfWjlUSsfH5vz2b7mxN7VxXBJCujuYQk0eTWH1k0ZfIcLhbAXhQmumRh7
         rOVNnFnL+YfxaN1+m3WIdHOKyACOPmhdFaEhycdk+ZJxHE9Ywr+4YJK5TbKc/2ydvh/w
         4JmA==
X-Gm-Message-State: AOAM530+NtD9MfAhg2ZnB+ym7jqnuwuOjk45ErqpzxraqplIIymp6cYS
        xK1WkvwQZZa2MSQfw+HjIg==
X-Google-Smtp-Source: ABdhPJxtE0pfjW0OE2oWRHGt7Z13PJa6Uoev2TYDkI18tmNvBy/3t0kxIWgXk2RjJ+CLUTmzERqRng==
X-Received: by 2002:a05:6808:657:b0:2d7:5604:6472 with SMTP id z23-20020a056808065700b002d756046472mr10940474oih.39.1646425533576;
        Fri, 04 Mar 2022 12:25:33 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id x25-20020a056830409900b005af164235b4sm2703186ott.2.2022.03.04.12.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 12:25:33 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx: Fix imx8*-var-som touchscreen property sizes
Date:   Fri,  4 Mar 2022 14:25:27 -0600
Message-Id: <20220304202527.316532-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The common touchscreen properties are all 32-bit, not 16-bit. These
properties must not be too important as they are all ignored in case of an
error reading them.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi | 8 ++++----
 arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi
index 1dc9d187601c..a0bd540f27d3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi
@@ -89,12 +89,12 @@ touchscreen@0 {
 		pendown-gpio = <&gpio1 3 GPIO_ACTIVE_LOW>;
 
 		ti,x-min = /bits/ 16 <125>;
-		touchscreen-size-x = /bits/ 16 <4008>;
+		touchscreen-size-x = <4008>;
 		ti,y-min = /bits/ 16 <282>;
-		touchscreen-size-y = /bits/ 16 <3864>;
+		touchscreen-size-y = <3864>;
 		ti,x-plate-ohms = /bits/ 16 <180>;
-		touchscreen-max-pressure = /bits/ 16 <255>;
-		touchscreen-average-samples = /bits/ 16 <10>;
+		touchscreen-max-pressure = <255>;
+		touchscreen-average-samples = <10>;
 		ti,debounce-tol = /bits/ 16 <3>;
 		ti,debounce-rep = /bits/ 16 <1>;
 		ti,settle-delay-usec = /bits/ 16 <150>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi
index b16c7caf34c1..87b5e23c766f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi
@@ -70,12 +70,12 @@ touchscreen@0 {
 		pendown-gpio = <&gpio1 3 GPIO_ACTIVE_LOW>;
 
 		ti,x-min = /bits/ 16 <125>;
-		touchscreen-size-x = /bits/ 16 <4008>;
+		touchscreen-size-x = <4008>;
 		ti,y-min = /bits/ 16 <282>;
-		touchscreen-size-y = /bits/ 16 <3864>;
+		touchscreen-size-y = <3864>;
 		ti,x-plate-ohms = /bits/ 16 <180>;
-		touchscreen-max-pressure = /bits/ 16 <255>;
-		touchscreen-average-samples = /bits/ 16 <10>;
+		touchscreen-max-pressure = <255>;
+		touchscreen-average-samples = <10>;
 		ti,debounce-tol = /bits/ 16 <3>;
 		ti,debounce-rep = /bits/ 16 <1>;
 		ti,settle-delay-usec = /bits/ 16 <150>;
-- 
2.32.0

