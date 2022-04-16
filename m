Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C27503400
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiDPDBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 23:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiDPDBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 23:01:40 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833BDF9555;
        Fri, 15 Apr 2022 19:59:09 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id bv19so18176842ejb.6;
        Fri, 15 Apr 2022 19:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+NV5gOjwMPjEqQproX/5dQ/w1lbzwSeSIPPGmGmAZ3I=;
        b=RYIPfsH2KIfCp4UttHOWlCbyVTpvnGtqEE84nK/CADuaYB1ZDqZTzHR9JqzM4+S2W3
         UKIjFYHVC5w+DgYU1O3Dv5Wm4MuBtwBA3yDEnV0CCj1Cv+CwSzpz/xJITdUhFS6IJICE
         MNg9np+HR4PTq1UXHRsHFU7zgSoeJUPOA8JsF5z7D8seKLMX1pcdXHX7mfaEoX9nKv0k
         T48IoL3dm2AJOBwx62hnxrC2yOPt0+gIqohxvAvKPvD5PCvJ7FOWv2oYk4fXGDgfDGAJ
         c0El2HUgZh7DRY5Lhg4BSUjz+FI8omeATbTn7aw9I0mEcr+u4ajAI1H1M/G8JkAk+avH
         JSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+NV5gOjwMPjEqQproX/5dQ/w1lbzwSeSIPPGmGmAZ3I=;
        b=zwXlz/HprFPjHOtCaARuvKws3GWGerpcnDOt6U2JJkgm9cxD/ClbDW51D5oC+5fGuQ
         sDMxC/yTatgbuImRNVMwcv4pMpRz0jUdJJunD0j9fP4wthtt+AaTd931UAQefDA6mKHY
         7PXbWI24GqSdbM4TyF3tN6WVHcWo2e+93VNrvFNZg2Wcfj7yvp/aFydxY7tnS0UEzwjT
         httkgBhSdqwgcpKWMStoVZfE3j+q7YWS4EayWmHu45DEzyZ5rfKO0BfRvQ3LyBxUyYHd
         yxXYdcVkx79j3A5+o35qVaRvJdm3ox6+ltg/2OhojMfC1FDCVnvt6vD/iyZDhdFV96Gl
         BmwQ==
X-Gm-Message-State: AOAM532R+XcS1KkEhe3xn5rSVmWE5zYlAKlq2EZiwBF3l1F37cIH2/1m
        H/SswYR9dcLWn34ZJ90/YXA=
X-Google-Smtp-Source: ABdhPJxLLGhJogsJ4zEG4NYzQ7tVDi+L+unDNFU+r2d5G+qQ6zKcY5MPnOc+CXkWyR9doSbBCH8DTA==
X-Received: by 2002:a17:906:4944:b0:6e8:a48d:804e with SMTP id f4-20020a170906494400b006e8a48d804emr1366676ejt.164.1650077948116;
        Fri, 15 Apr 2022 19:59:08 -0700 (PDT)
Received: from localhost.localdomain ([138.199.7.159])
        by smtp.gmail.com with ESMTPSA id oz20-20020a170906cd1400b006e872188edbsm2200915ejb.104.2022.04.15.19.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 19:59:07 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH RESEND v2 8/9] arm64: dts: qcom: msm8996: Add MSM8996 Pro support
Date:   Sat, 16 Apr 2022 06:56:36 +0400
Message-Id: <20220416025637.83484-9-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220416025637.83484-1-y.oudjana@protonmail.com>
References: <20220416025637.83484-1-y.oudjana@protonmail.com>
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

Add a new DTSI for MSM8996 Pro (MSM8996SG) with msm-id and CPU/GPU OPPs.
CBF OPPs and CPR parameters will be added to it as well once support for
CBF scaling and CPR is introduced.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 arch/arm64/boot/dts/qcom/msm8996pro.dtsi | 281 +++++++++++++++++++++++
 1 file changed, 281 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8996pro.dtsi

diff --git a/arch/arm64/boot/dts/qcom/msm8996pro.dtsi b/arch/arm64/boot/dts/qcom/msm8996pro.dtsi
new file mode 100644
index 000000000000..8c8dd5614f4d
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8996pro.dtsi
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2021, Yassine Oudjana <y.oudjana@protonmail.com>
+ */
+
+#include "msm8996.dtsi"
+
+/*
+ * MSM8996 Pro (also known as MSM8996SG) is a revision of MSM8996 with
+ * different CPU, CBF and GPU frequencies as well as CPR parameters.
+ */
+/delete-node/ &cluster0_opp;
+/delete-node/ &cluster1_opp;
+
+/ {
+	qcom,msm-id = <305 0x10000>;
+
+	cluster0_opp: opp_table0 {
+		compatible = "operating-points-v2-kryo-cpu";
+		nvmem-cells = <&speedbin_efuse>;
+		opp-shared;
+
+		opp-307200000 {
+			opp-hz = /bits/ 64 <307200000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-384000000 {
+			opp-hz = /bits/ 64 <384000000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-460800000 {
+			opp-hz = /bits/ 64 <460800000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-537600000 {
+			opp-hz = /bits/ 64 <537600000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-614400000 {
+			opp-hz = /bits/ 64 <614400000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-691200000 {
+			opp-hz = /bits/ 64 <691200000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-768000000 {
+			opp-hz = /bits/ 64 <768000000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-844800000 {
+			opp-hz = /bits/ 64 <844800000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-902400000 {
+			opp-hz = /bits/ 64 <902400000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-979200000 {
+			opp-hz = /bits/ 64 <979200000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1056000000 {
+			opp-hz = /bits/ 64 <1056000000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1132800000 {
+			opp-hz = /bits/ 64 <1132800000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1209600000 {
+			opp-hz = /bits/ 64 <1209600000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1286400000 {
+			opp-hz = /bits/ 64 <1286400000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1363200000 {
+			opp-hz = /bits/ 64 <1363200000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1440000000 {
+			opp-hz = /bits/ 64 <1440000000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1516800000 {
+			opp-hz = /bits/ 64 <1516800000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1593600000 {
+			opp-hz = /bits/ 64 <1593600000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1996800000 {
+			opp-hz = /bits/ 64 <1996800000>;
+			opp-supported-hw = <0x2>;
+			clock-latency-ns = <200000>;
+		};
+		opp-2188800000 {
+			opp-hz = /bits/ 64 <2188800000>;
+			opp-supported-hw = <0x1>;
+			clock-latency-ns = <200000>;
+		};
+	};
+
+	cluster1_opp: opp_table1 {
+		compatible = "operating-points-v2-kryo-cpu";
+		nvmem-cells = <&speedbin_efuse>;
+		opp-shared;
+
+		opp-307200000 {
+			opp-hz = /bits/ 64 <307200000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-384000000 {
+			opp-hz = /bits/ 64 <384000000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-460800000 {
+			opp-hz = /bits/ 64 <460800000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-537600000 {
+			opp-hz = /bits/ 64 <537600000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-614400000 {
+			opp-hz = /bits/ 64 <614400000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-691200000 {
+			opp-hz = /bits/ 64 <691200000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-748800000 {
+			opp-hz = /bits/ 64 <748800000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-825600000 {
+			opp-hz = /bits/ 64 <825600000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-902400000 {
+			opp-hz = /bits/ 64 <902400000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-979200000 {
+			opp-hz = /bits/ 64 <979200000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1056000000 {
+			opp-hz = /bits/ 64 <1056000000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1132800000 {
+			opp-hz = /bits/ 64 <1132800000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1209600000 {
+			opp-hz = /bits/ 64 <1209600000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1286400000 {
+			opp-hz = /bits/ 64 <1286400000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1363200000 {
+			opp-hz = /bits/ 64 <1363200000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1440000000 {
+			opp-hz = /bits/ 64 <1440000000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1516800000 {
+			opp-hz = /bits/ 64 <1516800000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1593600000 {
+			opp-hz = /bits/ 64 <1593600000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1670400000 {
+			opp-hz = /bits/ 64 <1670400000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1747200000 {
+			opp-hz = /bits/ 64 <1747200000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1824000000 {
+			opp-hz = /bits/ 64 <1824000000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1900800000 {
+			opp-hz = /bits/ 64 <1900800000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1977600000 {
+			opp-hz = /bits/ 64 <1977600000>;
+			opp-supported-hw = <0x3>;
+			clock-latency-ns = <200000>;
+		};
+		opp-2054400000 {
+			opp-hz = /bits/ 64 <2054400000>;
+			opp-supported-hw = <0x3>;
+			clock-latency-ns = <200000>;
+		};
+		opp-2150400000 {
+			opp-hz = /bits/ 64 <2150400000>;
+			opp-supported-hw = <0x3>;
+			clock-latency-ns = <200000>;
+		};
+		opp-2246400000 {
+			opp-hz = /bits/ 64 <2246400000>;
+			opp-supported-hw = <0x1>;
+			clock-latency-ns = <200000>;
+		};
+		opp-2342400000 {
+			opp-hz = /bits/ 64 <2342400000>;
+			opp-supported-hw = <0x1>;
+			clock-latency-ns = <200000>;
+		};
+	};
+};
+
+&gpu_opp_table {
+	/*
+	 * All MSM8996 GPU OPPs are available on MSM8996 Pro,
+	 * in addition to one:
+	 */
+	opp-652800000 {
+		opp-hz = /bits/ 64 <652800000>;
+		opp-supported-hw = <0x1>;
+	};
+};
+
+&kryocc {
+	compatible = "qcom,msm8996pro-apcc";
+};
-- 
2.35.1

