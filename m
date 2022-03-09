Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48444D39D5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 20:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237393AbiCITQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 14:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237526AbiCITQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 14:16:37 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618D01107C7;
        Wed,  9 Mar 2022 11:15:35 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h15so4578953wrc.6;
        Wed, 09 Mar 2022 11:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v+iY+TRExJIc70bBVgk3nQfXctI6G7hPCCrLkPdhNl0=;
        b=QPQuv5n46kKpwoNTjdEiO37RwlOn6o1ecymwktJF82FRbsffq5IoNicaHFKbhF+rFu
         t/qX9cFH/Fg3kYlBCDWylKZ+LswvxIs3ZRorpygeV8y0/uv3tDE/lfbHhIhyvTDlpFMt
         P5ntL8YwJ70C0XV7oPsMt5JsJL4DpgkI9ycK3HJccrCRPPj/hyExxccOkoQN0YKyYQ4y
         FmRCY9XOuBt7ELplG2HPPN7dQimFccWnUlRic96tBcD2luZu5wwxHwktL9i5eTryPDVw
         ai5IG/Ojk/kIejpOhksm/LAkQB5oRv5tPNC3wmlWnmgrMt2SQ/AMbxPChfEtS9DTFc4a
         6Q6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v+iY+TRExJIc70bBVgk3nQfXctI6G7hPCCrLkPdhNl0=;
        b=ZaFh8Qe0/iVXm805p2XxrIHwOYEiEI4uYo1Vg1kS6xKhct3ukEQtzG1qKpLNNbTMjo
         dnbYeDQsO/FJA8PWWQ7xZIvVldvh7nXrWysM47tIgUerbcq+VGrXO2/6raEoY6zk42Kx
         VqpajIrtWPuVhDwdMSiQg8UwfmWUGLIRPA2b1AKYtoGmxGmxRDRcX3OysZjauJr3F0Rd
         DA7zw5SaTvkEcAsiuVZvP0y0DJBklsRLgfzF465yycfQUdIhxgc0xvCjW7NsT9DkfTbv
         YY5SCtvYYb/ShMX06bz37z/VMrL/8dVnkGh59DakwTA4l33x0IFthq7Elj9nufI3DBBn
         TYfg==
X-Gm-Message-State: AOAM533GhYSjIo1VX1EyrE6UyLZquwaPDZHzITbXzWcVQhCjnQGhiI8y
        RL8j6hDCPqBh4U05KlJXLYo=
X-Google-Smtp-Source: ABdhPJxFmHBCHHHap1aYKXVs9bhz/jOXciGyyLUyEOhB6hN5EuavuOEwuSvT5zi6z3fK5wFYmXphCw==
X-Received: by 2002:a5d:52c5:0:b0:1f2:1a3:465a with SMTP id r5-20020a5d52c5000000b001f201a3465amr860258wrv.206.1646853333396;
        Wed, 09 Mar 2022 11:15:33 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-79-47-249-147.retail.telecomitalia.it. [79.47.249.147])
        by smtp.googlemail.com with ESMTPSA id w6-20020a5d6806000000b002036515dda7sm2396699wru.33.2022.03.09.11.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 11:15:32 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Jonathan McDowell <noodles@earth.li>
Subject: [PATCH v3 13/18] ARM: dts: qcom: add opp table for cpu and l2 for ipq8064
Date:   Wed,  9 Mar 2022 20:01:47 +0100
Message-Id: <20220309190152.7998-14-ansuelsmth@gmail.com>
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

Add opp table for cpu and l2 cache. While the current cpufreq is
the generic one that doesn't scale the L2 cache, we add the l2
cache opp anyway for the sake of completeness. This will be handy in the
future when a dedicated cpufreq driver is introduced for krait cores
that will correctly scale l2 cache with the core freq.

Opp-level is set based on the logic of
0: idle level
1: normal level
2: turbo level

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Tested-by: Jonathan McDowell <noodles@earth.li>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 99 +++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 7dd0b901cd30..a1079583def9 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -48,6 +48,105 @@ L2: l2-cache {
 		};
 	};
 
+	opp_table_l2: opp_table_l2 {
+		compatible = "operating-points-v2";
+
+		opp-384000000 {
+			opp-hz = /bits/ 64 <384000000>;
+			opp-microvolt = <1100000>;
+			clock-latency-ns = <100000>;
+			opp-level = <0>;
+		};
+
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <1100000>;
+			clock-latency-ns = <100000>;
+			opp-level = <1>;
+		};
+
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1150000>;
+			clock-latency-ns = <100000>;
+			opp-level = <2>;
+		};
+	};
+
+	opp_table0: opp_table0 {
+		compatible = "operating-points-v2-kryo-cpu";
+		nvmem-cells = <&speedbin_efuse>;
+
+		/*
+		 * Voltage thresholds are <target min max>
+		 */
+		opp-384000000 {
+			opp-hz = /bits/ 64 <384000000>;
+			opp-microvolt-speed0-pvs0-v0 = <1000000 950000 1050000>;
+			opp-microvolt-speed0-pvs1-v0 = <925000 878750 971250>;
+			opp-microvolt-speed0-pvs2-v0 = <875000 831250 918750>;
+			opp-microvolt-speed0-pvs3-v0 = <800000 760000 840000>;
+			opp-supported-hw = <0x1>;
+			clock-latency-ns = <100000>;
+			opp-level = <0>;
+		};
+
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt-speed0-pvs0-v0 = <1050000 997500 1102500>;
+			opp-microvolt-speed0-pvs1-v0 = <975000 926250 1023750>;
+			opp-microvolt-speed0-pvs2-v0 = <925000 878750 971250>;
+			opp-microvolt-speed0-pvs3-v0 = <850000 807500 892500>;
+			opp-supported-hw = <0x1>;
+			clock-latency-ns = <100000>;
+			opp-level = <1>;
+		};
+
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt-speed0-pvs0-v0 = <1100000 1045000 1155000>;
+			opp-microvolt-speed0-pvs1-v0 = <1025000 973750 1076250>;
+			opp-microvolt-speed0-pvs2-v0 = <995000 945250 1044750>;
+			opp-microvolt-speed0-pvs3-v0 = <900000 855000 945000>;
+			opp-supported-hw = <0x1>;
+			clock-latency-ns = <100000>;
+			opp-level = <1>;
+		};
+
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt-speed0-pvs0-v0 = <1150000 1092500 1207500>;
+			opp-microvolt-speed0-pvs1-v0 = <1075000 1021250 1128750>;
+			opp-microvolt-speed0-pvs2-v0 = <1025000 973750 1076250>;
+			opp-microvolt-speed0-pvs3-v0 = <950000 902500 997500>;
+			opp-supported-hw = <0x1>;
+			clock-latency-ns = <100000>;
+			opp-level = <1>;
+		};
+
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt-speed0-pvs0-v0 = <1200000 1140000 1260000>;
+			opp-microvolt-speed0-pvs1-v0 = <1125000 1068750 1181250>;
+			opp-microvolt-speed0-pvs2-v0 = <1075000 1021250 1128750>;
+			opp-microvolt-speed0-pvs3-v0 = <1000000 950000 1050000>;
+			opp-supported-hw = <0x1>;
+			clock-latency-ns = <100000>;
+			opp-level = <2>;
+		};
+
+		opp-1400000000 {
+			opp-hz = /bits/ 64 <1400000000>;
+			opp-microvolt-speed0-pvs0-v0 = <1250000 1187500 1312500>;
+			opp-microvolt-speed0-pvs1-v0 = <1175000 1116250 1233750>;
+			opp-microvolt-speed0-pvs2-v0 = <1125000 1068750 1181250>;
+			opp-microvolt-speed0-pvs3-v0 = <1050000 997500 1102500>;
+			opp-supported-hw = <0x1>;
+			clock-latency-ns = <100000>;
+			opp-level = <2>;
+		};
+	};
+
 	thermal-zones {
 		sensor0-thermal {
 			polling-delay-passive = <0>;
-- 
2.34.1

