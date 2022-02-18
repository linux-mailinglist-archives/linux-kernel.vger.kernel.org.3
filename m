Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501874BAE92
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiBRAbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 19:31:05 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiBRAau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 19:30:50 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0431C674CF;
        Thu, 17 Feb 2022 16:30:28 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id l67-20020a1c2546000000b00353951c3f62so5213884wml.5;
        Thu, 17 Feb 2022 16:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wDwyZnWxamRTsoYfzAkv2d0Y/zklcsBany9cWTtij48=;
        b=IZ9LNRqG1d+/6Apsw17xrj42gtDjqXVt9PSeMycsd5XaTpiXJIzH6IX3HBYRwJb21p
         i8px4n2DiZPl1oZuO9hdPQLStNeTBt8Eh7gYnV8cr1tdc+d4rLfKOT33XuuSLuzgmm0d
         zg08aZXuZTwRV9SamW1VHo5heL8qETQ02ipWO1VuZX6AjHz5QtfwiooC4Zc7niwuvkZb
         gGAigyUvQ1E+6r/f8CAE3lXDCD8nILiWwOImRvVNMniYk0S334uJDyoyjbXxikD2UWCw
         RFzD3xaNsaAhUqWZGXtbA4I17kWM/XRfItL09S46/tdTgx2qqVGRu2CYMOGgf/RW285p
         H8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wDwyZnWxamRTsoYfzAkv2d0Y/zklcsBany9cWTtij48=;
        b=I1hPyHlIDbizzkeAblxWbBnXjZN0hAQj5kw/dApJ9yTF9vL2N3FjBz9KBXQgSUkdvi
         9hJNMUMR5zuXqaUsRm7xn8vMq0dIoNzahh9eVoMmgk40zUmQOs6EF8UCMpsrwRyQB9MR
         FiB4LXhuDMYJttj/o3ZMQ0MDSCKor8QzIZUQhkr6zO/sYc/24/n1QeHjrixFAcvpr9z4
         h/ethavBMhBzwYNvnIldKGm9MMgj0cdn25lEx0rOLW1ttm2HGAQVjxoSjiNZKe9xua6B
         +0CuBJ0bMC4FFq/tsyCUUAIQMGNqVRht2M4L9+rwJuVKeGiI0iHRZBiRTx1xYWdYEhph
         o+nw==
X-Gm-Message-State: AOAM532LvqJ50jJng0bKA8gKBzXhmQ+mwAwwt9UKZrw8ItRjAAdlxwVY
        BdxzRvRM1fJpEXffk9Y8+tZzkEqN1JQ=
X-Google-Smtp-Source: ABdhPJx7FXzTQGNEmv/XQH7bFallE+L5eGA3mZuRmAEzMN5lIX7S+ATl9VORodQRwPDGtb3Wl7IScw==
X-Received: by 2002:a1c:e915:0:b0:37b:d847:e127 with SMTP id q21-20020a1ce915000000b0037bd847e127mr4806931wmc.180.1645144207993;
        Thu, 17 Feb 2022 16:30:07 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id d29sm3640406wra.63.2022.02.17.16.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 16:30:07 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH v2 13/18] ARM: dts: qcom: add opp table for cpu and l2 for ipq8064
Date:   Fri, 18 Feb 2022 01:29:51 +0100
Message-Id: <20220218002956.6590-14-ansuelsmth@gmail.com>
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

