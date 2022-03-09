Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E0C4D39CC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 20:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237444AbiCITQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 14:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237364AbiCITQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 14:16:19 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D67910EC58;
        Wed,  9 Mar 2022 11:15:20 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id x15so4533830wru.13;
        Wed, 09 Mar 2022 11:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D+rLs9tzqVI3gBUs7BM99DY73Xg0WBVGdTXSmZY7KpY=;
        b=Vz5Rr8lr9II3batw1H25VUHCkqNuREl857dWo+OL9XBQIE+mtKEBKHGAOVxGLZ6CY0
         VRprLAHhv9RfAd3GubfBBmzdn6af7BiZh8Vii/q957dyt4w2sUEf5MduNIs8Iw4w2gy/
         0ybtCD23MFsfPvxh4grRZJO0a/JAMxWjabJRvrEM8CQ0JYg15zCMM4lBAM7hhYTn8Y8I
         Y8ji4w2P/pjte/6q/hM8q45Bxgf1hsdhreu/i8x+KFOwe8kpp2UaHGDzGwiWOGPebU1P
         teHyvQSntZ65n6IHWf9J+xyV79ERwL/vmJQGztKcuF4Cn9xtD1+l3G9xQj/BekkTB26P
         0tNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D+rLs9tzqVI3gBUs7BM99DY73Xg0WBVGdTXSmZY7KpY=;
        b=AI4G+4a3O0p7QxzG3rihuVE9NR4tEzYLFqp0yeSmivWsQvknj4w/yyidQzvH532R2J
         8u7GlZcNLPMKhohnba8DR1/Z2BDF1r1Cw07TsmRQZMdD5vpDpjrnbbd+izYofbPaTU2j
         MNgh/OM8JPYzRJlMwF5SzaRLB0BCKF0WvB3Dpf2GNHQuk9Z9xJkD+5D1koU4teSCxsdu
         IS+vhUx6sz5i01qijgiUS857El04llvkHKpnSf9LkyR/gXXfiMYcc72tBbXE1mWKov5s
         9t1uUwjiMwmYO4cDsi8moqk8TjYQbxfMD2to+x3mLP/d9N20YEK98vC5NPcBiEpwDa7g
         3Wdw==
X-Gm-Message-State: AOAM531qUjXgKbF2Ga5U3GbTIjMIfbobBCNdfr2o5iGjxrIFcILTMs7t
        GPKhJJoYOa5QPGxKMm4HLWE=
X-Google-Smtp-Source: ABdhPJw5GAvVIPpyl970bhVQm3Zg02EHB4hlYetFHoqX/PoCPdmoNRWJXjiv5oBrRxu00VzpBZ0yww==
X-Received: by 2002:a5d:5687:0:b0:1f0:9663:c80e with SMTP id f7-20020a5d5687000000b001f09663c80emr854243wrv.343.1646853318996;
        Wed, 09 Mar 2022 11:15:18 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-79-47-249-147.retail.telecomitalia.it. [79.47.249.147])
        by smtp.googlemail.com with ESMTPSA id w6-20020a5d6806000000b002036515dda7sm2396699wru.33.2022.03.09.11.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 11:15:18 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Jonathan McDowell <noodles@earth.li>
Subject: [PATCH v3 03/18] ARM: dts: qcom: add missing rpm regulators and cells for ipq8064
Date:   Wed,  9 Mar 2022 20:01:37 +0100
Message-Id: <20220309190152.7998-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220309190152.7998-1-ansuelsmth@gmail.com>
References: <20220309190152.7998-1-ansuelsmth@gmail.com>
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

Add cells definition for rpm node and add missing regulators for the 4
regulator present on ipq8064. There regulators are controlled by rpm and
to correctly works gsbi4_i2c require to be NEVER disabled or rpm will
reject any regulator change request.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Tested-by: Jonathan McDowell <noodles@earth.li>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 36 +++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index b309bc0fbbcd..0938838a4af8 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -842,10 +842,46 @@ rpm: rpm@108000 {
 			clocks = <&gcc RPM_MSG_RAM_H_CLK>;
 			clock-names = "ram";
 
+			#address-cells = <1>;
+			#size-cells = <0>;
+
 			rpmcc: clock-controller {
 				compatible = "qcom,rpmcc-ipq806x", "qcom,rpmcc";
 				#clock-cells = <1>;
 			};
+
+			smb208_regulators: regulators {
+				compatible = "qcom,rpm-smb208-regulators";
+				status = "okay";
+
+				smb208_s1a: s1a {
+					regulator-min-microvolt = <1050000>;
+					regulator-max-microvolt = <1150000>;
+
+					qcom,switch-mode-frequency = <1200000>;
+				};
+
+				smb208_s1b: s1b {
+					regulator-min-microvolt = <1050000>;
+					regulator-max-microvolt = <1150000>;
+
+					qcom,switch-mode-frequency = <1200000>;
+				};
+
+				smb208_s2a: s2a {
+					regulator-min-microvolt = < 800000>;
+					regulator-max-microvolt = <1250000>;
+
+					qcom,switch-mode-frequency = <1200000>;
+				};
+
+				smb208_s2b: s2b {
+					regulator-min-microvolt = < 800000>;
+					regulator-max-microvolt = <1250000>;
+
+					qcom,switch-mode-frequency = <1200000>;
+				};
+			};
 		};
 
 		tcsr: syscon@1a400000 {
-- 
2.34.1

