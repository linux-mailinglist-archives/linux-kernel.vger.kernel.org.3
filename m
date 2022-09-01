Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732A25A901A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbiIAHZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233920AbiIAHZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:25:25 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2531257DC;
        Thu,  1 Sep 2022 00:24:28 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id h204-20020a1c21d5000000b003a5b467c3abso809261wmh.5;
        Thu, 01 Sep 2022 00:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=L2uh9K2VjTAJTjLgoqSW0ywBONxF4H1K/tbZKUAc0eA=;
        b=hBWb4GP47ntfmGRvHuSrfGPYqGQRtFAwq1nikuVZZqnJkqfSkJcQp47DPSC65opylY
         0EYXGX1bZF+15wlvmz/w7TRV8ovc86C/LIX2In7KdUBHS2t2pcPFye8hAo2qLp0vzJVw
         4G6a3TaJN8B7GxAuBvvfvgq3Lqrz3E9dQGzQik7wC19VrDPfKSdJnsU4QorV/UraWcVR
         FhM8SxaUlzF2zHRK3MdXfrKrjo2juNIbZoUJh3de6IA5yWiC4vJ1ZUwtKP/iixyaOPTS
         7BuCVAr+74FjcXWJadKlatxLTvyF4dABuZeVTe5knjDd1l+ad9Uvb/MyMtXAZV2bf9v6
         4SUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=L2uh9K2VjTAJTjLgoqSW0ywBONxF4H1K/tbZKUAc0eA=;
        b=gSn5QI9NKSksq+75wLw4eEo38kl5NLT7TQT129uJ51SV0csrFFU6NR3kvE9npGAOpA
         YBp1gPJmc3OL803iq/QKhEAdFhxaD3BcVxsiphzjhwrHIMp2EFWchJk04X5KGkzT8gsg
         XoqiwaxwsScQ/yBVL4Mp0NI70wkplE2e44sqzUZyPRJoHGAYh6R4Q5W3a86ydcaGdU1F
         k3KVBu9vrC3AYeBxAIjgLJFVod0NgN9zT0811H5vsvWqpBx9WRMyHxQLXldHiHp0O1LN
         5y9v4yTXjTuaiUCwwT3pyrLrG6OiSEB+oIB9ZavDIuMIJattzISCdWtd5oErSmyCI3ho
         FdNA==
X-Gm-Message-State: ACgBeo1K3/Mkvpxktew4aUbekC0pGDr99FHmMfzJRqRrsdan2Gg49Tt1
        pEKMy9ghqXWqWYfbbL79CKw=
X-Google-Smtp-Source: AA6agR7DVwjOuMe0d4rXBImHXkagxdxmES+lDo9YMMrhu8jSGJNmB47udGmtZk1oy8P1L/nYE9OC4A==
X-Received: by 2002:a05:600c:2059:b0:3a5:92cc:19c5 with SMTP id p25-20020a05600c205900b003a592cc19c5mr3996426wmg.101.1662017066816;
        Thu, 01 Sep 2022 00:24:26 -0700 (PDT)
Received: from localhost (87-126-55-15.ip.btc-net.bg. [87.126.55.15])
        by smtp.gmail.com with ESMTPSA id q28-20020a056000137c00b002205cbc1c74sm13768905wrz.101.2022.09.01.00.24.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 00:24:26 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/14] arm64: dts: qcom: sm6115: Add rpmcc and rpmpd nodes
Date:   Thu,  1 Sep 2022 10:24:01 +0300
Message-Id: <20220901072414.1923075-3-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220901072414.1923075-1-iskren.chernev@gmail.com>
References: <20220901072414.1923075-1-iskren.chernev@gmail.com>
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

The sm6115 uses glink rpm to control some clocks and regulators.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 67 ++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 69d9de540478..7496b3e0ff48 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -315,6 +315,66 @@ linux_cma_mem: memory@fdc00000 {
 
 	};
 
+	rpm-glink {
+		compatible = "qcom,glink-rpm";
+
+		interrupts = <GIC_SPI 194 IRQ_TYPE_EDGE_RISING>;
+		qcom,rpm-msg-ram = <&rpm_msg_ram>;
+		mboxes = <&apcs_glb 0>;
+
+		rpm_requests: rpm-requests {
+			compatible = "qcom,rpm-sm6115";
+			qcom,glink-channels = "rpm_requests";
+
+			rpmcc: rpmcc {
+				compatible = "qcom,rpmcc-sm6115";
+				#clock-cells = <1>;
+			};
+
+			rpmpd: power-controller {
+				compatible = "qcom,sm6115-rpmpd";
+				#power-domain-cells = <1>;
+				operating-points-v2 = <&rpmpd_opp_table>;
+
+				rpmpd_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					rpmpd_opp_min_svs: opp1 {
+						opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
+					};
+
+					rpmpd_opp_low_svs: opp2 {
+						opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
+					};
+
+					rpmpd_opp_svs: opp3 {
+						opp-level = <RPM_SMD_LEVEL_SVS>;
+					};
+
+					rpmpd_opp_svs_plus: opp4 {
+						opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
+					};
+
+					rpmpd_opp_nom: opp5 {
+						opp-level = <RPM_SMD_LEVEL_NOM>;
+					};
+
+					rpmpd_opp_nom_plus: opp6 {
+						opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
+					};
+
+					rpmpd_opp_turbo: opp7 {
+						opp-level = <RPM_SMD_LEVEL_TURBO>;
+					};
+
+					rpmpd_opp_turbo_plus: opp8 {
+						opp-level = <RPM_SMD_LEVEL_TURBO_NO_CPR>;
+					};
+				};
+			};
+		};
+	};
+
 	smem {
 		compatible = "qcom,smem";
 		memory-region = <&smem_mem>;
@@ -350,6 +410,13 @@ rpm_msg_ram: memory@45f0000 {
 			reg = <0x45f0000 0x7000>;
 		};
 
+		apcs_glb: mailbox@f111000 {
+			compatible = "qcom,sm6115-apcs-hmss-global";
+			reg = <0xf111000 0x1000>;
+
+			#mbox-cells = <1>;
+		};
+
 		timer@f120000 {
 			compatible = "arm,armv7-timer-mem";
 			#address-cells = <1>;
-- 
2.37.2

