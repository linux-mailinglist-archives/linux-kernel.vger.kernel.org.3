Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E954BAE80
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiBRAbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 19:31:02 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiBRAar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 19:30:47 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6297E5F260;
        Thu, 17 Feb 2022 16:30:26 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d27so11754149wrc.6;
        Thu, 17 Feb 2022 16:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lreGuZZ1/UTYaXGy3klqMzC8wmdCRTsvJ1KVZ4ZinfQ=;
        b=FHPcZb/0PHll/Ll4Pothjqh75qRU7XbKBlZK0uNPCOIcaGATgHQ5VDRZo3TE41XhsW
         fk4EJkv5aXiCPNVPbzja54IWDvHfTaXk8vIMbZNZUDkXFETD+7W3memn3uTpiqGCYh2n
         PwK9EEIKHb8/JNQAQl+XaiwyPvW57Ionsb0OtUJMS8wrqOJ4zMZxT66jfsRruG+6xkyG
         WovJbU3EPbDSMKZhj2HTb5fsZqiqlZZI0pZnbi8z8alnAevibyS8mBidpH8eMpGuue4c
         cpZoDmGv6m0LIEvX+YPf4EXHenNYIAjHqp7QyKtwwaiCMtel3upaParjA6vPBLEXfcFH
         shUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lreGuZZ1/UTYaXGy3klqMzC8wmdCRTsvJ1KVZ4ZinfQ=;
        b=jWP/UamCExfW9+l/U5uGO0hUWdhFA4FqGoUK3LKWnKAG660Mv/9bU+PLlXxq5EnIBF
         OjHnGxebP1XK5OTA45iA1LMusTB5lRxzA1MViAyUSV49cnKoFvAyRV4l/AuuDlfM3UR6
         1D4GAYZFcgCFgw0Wd9nsBrl13mQiK2GTUep6jDtEN57Y5y6LWN6B+ggUhPsBuCAm3sGj
         oxAlH9KAAe9U4bulkNE5XcrsFO+zwTyy2NZjKDKU7hgjztWUeRekeIRjdrRKFU0nUiDk
         M8JoH+n7gnVeh4ZOgGEjWzCipN1wsXZ+1Z8IPr2axUpuAIndkiQdmziBsAGPOtcnMoSn
         EkFg==
X-Gm-Message-State: AOAM531P1AhEKFkn9/YxnFtLgjWrMizDejE/vZZPdBjIFeWqVsBzL1QW
        CcnGwQZQ6lsO5UD+xu7ktfcLFbFqxQM=
X-Google-Smtp-Source: ABdhPJyj9SORQmnYwQ7RBtWksR8H96M/Vi/pejqyBcslVL/UZ7lHcR2i1w+zLIDFozecBYTo+MS/LQ==
X-Received: by 2002:a5d:59ab:0:b0:1e3:2576:215 with SMTP id p11-20020a5d59ab000000b001e325760215mr4186665wrr.496.1645144207122;
        Thu, 17 Feb 2022 16:30:07 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id d29sm3640406wra.63.2022.02.17.16.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 16:30:06 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH v2 12/18] ARM: dts: qcom: fix and add some missing gsbi node for ipq8064
Date:   Fri, 18 Feb 2022 01:29:50 +0100
Message-Id: <20220218002956.6590-13-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218002956.6590-1-ansuelsmth@gmail.com>
References: <20220218002956.6590-1-ansuelsmth@gmail.com>
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

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 50 ++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index df2702e6136d..7dd0b901cd30 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -568,6 +568,41 @@ sic_non_secure: sic-non-secure@12100000 {
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
@@ -591,7 +626,7 @@ gsbi2_serial: serial@12490000 {
 				status = "disabled";
 			};
 
-			i2c@124a0000 {
+			gsbi2_i2c: i2c@124a0000 {
 				compatible = "qcom,i2c-qup-v1.1.1";
 				reg = <0x124a0000 0x1000>;
 				interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>;
@@ -753,6 +788,19 @@ gsbi7_serial: serial@16640000 {
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
2.34.1

