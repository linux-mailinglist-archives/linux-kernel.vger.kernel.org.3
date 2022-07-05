Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1205670B3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbiGEONt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbiGEOMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:12:55 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAF7B62;
        Tue,  5 Jul 2022 07:07:24 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id q6so21772238eji.13;
        Tue, 05 Jul 2022 07:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zXxdTzLtVzA6nQfdAGvX6tJEz3Yjxo/s4geT8TfRcGo=;
        b=SZfVB+1zzI1T+iXrP4WmNZWTmn75otUK6q11/R9OnEwPjnfUnFcMF+yr7GaYasyDTi
         jsEW9WW+Edgz9RkipF2ox0LXxFS7aOuTNQY3aai0IbdmPRMg2ueqQWF8seGz6EMZozzw
         GgV2+6BhTpMggFeBoD1wZamWj4lWldFv9YiOP9C70QjQUlqqjBUsIyfKu4uaMMwnRm13
         uvxt1FP94O3/WDRFLf09wCtmYa0KjYus3raB8X51t5+cal9xO7Vd/mww4ZSXgeo4BbBg
         K73+TbSmctzs9MzxnSdgAzLHcPo7de+8HytkCKYK1hFNMrZ1R+6OTX9rj23AWP8UF3TZ
         BIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zXxdTzLtVzA6nQfdAGvX6tJEz3Yjxo/s4geT8TfRcGo=;
        b=qbICOG2CfoblrH1ejX899lB+yoDip+xSuXNcjz+vjK5SseJ7LjgppATgtwZOWftaUa
         LhMKIy51HMeZkJVB2FCKtAbRVtuG9p2uNvfJtuOSGBgAqw3tFPbgXkueGt+QGNs0HMiM
         0hltwfbRTSYqGWxlwjEOhY4HG1ikoDheE62+igFti7UZs0QWOyCO/YjMkZl5YZdsi1bO
         EU2HXmwcYPwRRVNK5+VmcJlLJ3AdTLChUZ5+ryc/GsZONWm1Zl46boOlMRSz1XTxcc75
         ScvEg7D50otKuie++mTYDbSEsncQQzZdFSzF65UDUnHWNEYOltkbWwwdTLNYO43p8/yW
         gwzg==
X-Gm-Message-State: AJIora+ksUKBgayj3Ib6KTYHBunfv+Dm4PAHz4L5gM3RcE0h43dp2aSA
        r15v8T1pj/XjroaWUE0AfTY=
X-Google-Smtp-Source: AGRyM1sSOXlEUaSLfiV/NgRP5TX5QdjI6DQptupsYXmv01bFs1kUEzUsPeDYtHOseKOnIQd5kNyzvQ==
X-Received: by 2002:a17:906:af12:b0:722:f9f0:cb75 with SMTP id lx18-20020a170906af1200b00722f9f0cb75mr34463221ejb.643.1657030000713;
        Tue, 05 Jul 2022 07:06:40 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id ku5-20020a170907788500b0072aee605e0esm399709ejc.60.2022.07.05.07.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 07:06:40 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Jonathan McDowell <noodles@earth.li>
Subject: [PATCH 11/13] ARM: dts: qcom: fix and add some missing gsbi node for ipq8064
Date:   Tue,  5 Jul 2022 15:39:15 +0200
Message-Id: <20220705133917.8405-12-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220705133917.8405-1-ansuelsmth@gmail.com>
References: <20220705133917.8405-1-ansuelsmth@gmail.com>
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

Add some tag for gsbi to make them usable for ipq8064 SoC. Add missing
gsbi7 i2c node and gsbi1 node.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Tested-by: Jonathan McDowell <noodles@earth.li>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 50 ++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index ef8faee6dfd4..777851bed95a 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -548,6 +548,41 @@ sic_non_secure: sic-non-secure@12100000 {
 			reg = <0x12100000 0x10000>;
 		};
 
+		gsbi1: gsbi@12440000 {
+			compatible = "qcom,gsbi-v1.0.0";
+			cell-index = <1>;
+			reg = <0x12440000 0x100>;
+			clocks = <&gcc GSBI1_H_CLK>;
+			clock-names = "iface";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			status = "disabled";
+
+			syscon-tcsr = <&tcsr>;
+
+			gsbi1_serial: serial@12450000 {
+				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
+				reg = <0x12450000 0x100>,
+				      <0x12400000 0x03>;
+				interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gcc GSBI1_UART_CLK>, <&gcc GSBI1_H_CLK>;
+				clock-names = "core", "iface";
+				status = "disabled";
+			};
+
+			gsbi1_i2c: i2c@12460000 {
+				compatible = "qcom,i2c-qup-v1.1.1";
+				reg = <0x12460000 0x1000>;
+				interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gcc GSBI1_QUP_CLK>, <&gcc GSBI1_H_CLK>;
+				clock-names = "core", "iface";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+		};
+
 		gsbi2: gsbi@12480000 {
 			compatible = "qcom,gsbi-v1.0.0";
 			cell-index = <2>;
@@ -571,7 +606,7 @@ gsbi2_serial: serial@12490000 {
 				status = "disabled";
 			};
 
-			i2c@124a0000 {
+			gsbi2_i2c: i2c@124a0000 {
 				compatible = "qcom,i2c-qup-v1.1.1";
 				reg = <0x124a0000 0x1000>;
 				interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>;
@@ -733,6 +768,19 @@ gsbi7_serial: serial@16640000 {
 				clock-names = "core", "iface";
 				status = "disabled";
 			};
+
+			gsbi7_i2c: i2c@16680000 {
+				compatible = "qcom,i2c-qup-v1.1.1";
+				reg = <0x16680000 0x1000>;
+				interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
+
+				clocks = <&gcc GSBI7_QUP_CLK>, <&gcc GSBI7_H_CLK>;
+				clock-names = "core", "iface";
+				status = "disabled";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 
 		rng@1a500000 {
-- 
2.36.1

