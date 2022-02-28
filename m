Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FDF4C6EBF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 14:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236840AbiB1N75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 08:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236884AbiB1N5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 08:57:54 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530DD7DA85;
        Mon, 28 Feb 2022 05:57:15 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id t21so10320030qkg.6;
        Mon, 28 Feb 2022 05:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BiTCbZuuiqDpXPtBKnm7lrk6/Udlslh2uUBYoU46tJs=;
        b=Vzhk/l+RrcplqcRl2cXSbNL0mIvK0CRqty0syf5bQQUmHMjOBGQmTZCuabndtJHS36
         xXaS4lzWK+xROz5TJtKNdPabb1zD5XMcj4+8BJ5pRW46wRhJ+pp+amtp6rm129LF0Z6P
         7ztxky6Yjxzt3HkgcC59vTDSAEagAB5PTSfMz+Df08fUXW1QA8QCZVkc8XBylIYP5kdJ
         J5nblzMm70KMGgf8Gy5HTHfnfzsopKw26AIwtBXz0ZgsHC2XSeecPMN/tspvdph4+Jwi
         NspRDdkxFAH/8L4MY1lUMC/CNvDJN+Ru3ekvwruL+yW2a8U0nPvi6Pt4ggbw0GI9+zNl
         eXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BiTCbZuuiqDpXPtBKnm7lrk6/Udlslh2uUBYoU46tJs=;
        b=aYPGngkqgd8E2kSv2mCrWTFHaIxbjYLje2B3VemjlJ9gR0yPLrpAWWpWC+WFka85o4
         XGkvf0yoLGmS5d3LMfAHgZQVbfp8fSkLRIYaVwslmn6o8dF6lXpNy5Jv9XWQJKjTArGr
         nII+pql/P4zbtkEx0iiu2FJZ5gb4KuqzTZLRErXWV4g83QxsJ1oYMh5RiW9rwH4EIIL+
         bGoslh0ksU7Z6sB56HAX4LsHJvNG28GRxZ5r5pvQ+BHDGqXuGoAuVvmZplc1yZv4cnsJ
         u5z8j+cpWLW24zkDjiAIKNyZGHpcc61uH2DrtY3PQsYh0NrGmI/pbnorZLFgrP+toxyb
         2cbw==
X-Gm-Message-State: AOAM5334GnBLO3hxutjiVJQyAxWZeaB8EXb4z/BJatD+A8ATTywjHIch
        zU1wY1MTIImGMdds1VCUm74=
X-Google-Smtp-Source: ABdhPJzISx6l4WShDyY6KCDsf7X9XfgYN06iL4IV/tf8V+edYxOG/JAz48GCLYEo1nlBEeZAzQqvNg==
X-Received: by 2002:a05:620a:8ce:b0:60e:1351:94bb with SMTP id z14-20020a05620a08ce00b0060e135194bbmr10731362qkz.63.1646056634470;
        Mon, 28 Feb 2022 05:57:14 -0800 (PST)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id b8-20020a05620a088800b00648bfd00a41sm4932244qka.80.2022.02.28.05.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 05:57:14 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, michael.riesch@wolfvision.net,
        jbx6244@gmail.com, Peter Geis <pgwipeout@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 7/8] arm64: dts: rockchip: enable dwc3 on quartz64-a
Date:   Mon, 28 Feb 2022 08:56:58 -0500
Message-Id: <20220228135700.1089526-8-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228135700.1089526-1-pgwipeout@gmail.com>
References: <20220228135700.1089526-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The quartz64 model a has support for both the dwc3 otg port and the dwc3
host port. Add the otg power supply and dwc3 nodes to the device tree to
enable support for these.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
index dd7f4b9b686b..141a433429b5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
@@ -151,6 +151,16 @@ vcc5v0_usb20_host: vcc5v0_usb20_host {
 		vin-supply = <&vcc5v0_usb>;
 	};
 
+	vcc5v0_usb20_otg: vcc5v0_usb20_otg {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio4 RK_PB5 GPIO_ACTIVE_HIGH>;
+		regulator-name = "vcc5v0_usb20_otg";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&dcdc_boost>;
+	};
+
 	vcc3v3_sd: vcc3v3_sd {
 		compatible = "regulator-fixed";
 		enable-active-low;
@@ -187,6 +197,10 @@ vcc_wl: vcc_wl {
 	};
 };
 
+&combphy1 {
+	status = "okay";
+};
+
 &cpu0 {
 	cpu-supply = <&vdd_cpu>;
 };
@@ -672,6 +686,29 @@ &usb_host1_ohci {
 	status = "okay";
 };
 
+&usb_host0_xhci {
+	status = "okay";
+};
+
+/* usb3 controller is muxed with sata1 */
+&usb_host1_xhci {
+	status = "okay";
+};
+
+&usb2phy0 {
+	status = "okay";
+};
+
+&usb2phy0_host {
+	phy-supply = <&vcc5v0_usb20_host>;
+	status = "okay";
+};
+
+&usb2phy0_otg {
+	phy-supply = <&vcc5v0_usb20_otg>;
+	status = "okay";
+};
+
 &usb2phy1 {
 	status = "okay";
 };
-- 
2.25.1

