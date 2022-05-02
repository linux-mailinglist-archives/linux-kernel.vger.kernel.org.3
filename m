Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B3151760E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 19:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386718AbiEBRox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 13:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386668AbiEBRog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 13:44:36 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2AE5F45
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 10:41:05 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id a1so17432568edt.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 10:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=db4sc5OrkSnoCCAKUJDacMNlzRQIVW40R0PO9szPpSw=;
        b=ivv4TiIFET9Plo0mYU0pmkto0Jb+VpOTR2H6nDBQe/bIP3sx4kj0NNACW2MGDYGO5p
         dRvVcuqcUDjnWPTOnrMu71i/ThRkYAfUstYUe5nTVK4RHUbPM/VxBtZywaO8H9tIC+TD
         zIFxmZ8nD9tqWYpgH4W6ABFE4y1h+Lypo/T5F84LRDZYRKs1oYMunObyGXOsswdaF+pt
         Nf+0JZyCeZK0CQzXfmvz4f1B9CIK+RfyISoXvdOLwLEsKjUPxInpoSGVpJxHq/MBWLWa
         TDDSosZLpczwQN8vTSc6bvAf3exs0tKnStUaORbqh2rfW60nwl2itT6EyEVMr0ueyOx9
         ceeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=db4sc5OrkSnoCCAKUJDacMNlzRQIVW40R0PO9szPpSw=;
        b=oa/CQWgXDDdka/aOp32Mq2kmXAxEwVgc1dfXFglfMhCSh8Q+enGDR3VHwalrzZccrU
         jLGl3fNFhXVY1SdDqv2yBe73ey3ThPDngAb9WiZZ9bugEMO+xI6hD3BMyQ82KOpLJD3l
         nZv7cGyiW5wyEymF5xwxBCyftDnjM7DROPKbfSJwT7LedYwv0mCMACoIo6RCsYAtRLDA
         ihzXFwP7RMY8koSUh8oCRJE4irzitxBl7V5VnpOpNdvyJjE57f2qS4c/wzkHkLA1oxgq
         Vh4ZnzsRpL+1XFRROOG7u5Ky9dDj08NLUS43LOhBXrUttceCqiaDBQ81itAXG+mPZyIM
         IPtg==
X-Gm-Message-State: AOAM532eU9cPMYzTrsxs9hZ9dC+dUQsK+rx4SjakWdrIKIyp02GBoaXK
        j4JTAwA6AbxTE6VZSQm7iT9muw==
X-Google-Smtp-Source: ABdhPJw1vcECAN0GdEjQTb0sBwVUfthEx3gj2y1wxgUs6ErO7gvNMoDhI87r8wi2EufVqDu8nRm7Kw==
X-Received: by 2002:aa7:dbc5:0:b0:423:f451:bb50 with SMTP id v5-20020aa7dbc5000000b00423f451bb50mr14140414edt.79.1651513263662;
        Mon, 02 May 2022 10:41:03 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id n9-20020aa7c689000000b0042617ba639csm6908547edq.38.2022.05.02.10.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 10:41:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thara Gopinath <thara.gopinath@linaro.org>
Subject: [PATCH 4/4] arm64: dts: qcom: sdm845: Add CPU BWMON
Date:   Mon,  2 May 2022 19:40:46 +0200
Message-Id: <20220502174046.139234-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220502174046.139234-1-krzysztof.kozlowski@linaro.org>
References: <20220502174046.139234-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device node for CPU-memory BWMON device (bandwidth monitoring) on
SDM845.

Co-developed-by: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 60 ++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 692cf4be4eef..bd4577f0a92f 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2026,6 +2026,66 @@ llcc: system-cache-controller@1100000 {
 			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		pmu@1436400 {
+			compatible = "qcom,sdm845-cpu-bwmon";
+			reg = <0 0x01436400 0 0x600>;
+
+			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
+
+			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			interconnect-names = "ddr", "l3c";
+
+			operating-points-v2 = <&cpu_bwmon_opp_table>;
+
+			cpu_bwmon_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				/*
+				 * The interconnect paths bandwidths calculated
+				 * from msm-4.9 downstream kernel:
+				 *  - the gladiator_noc-mem_noc from bandwidth
+				 *    table of qcom,llccbw (property qcom,bw-tbl);
+				 *    bus width: 4 bytes;
+				 *  - the OSM L3 from bandiwdth table of
+				 *    qcom,cpu4-l3lat-mon (qcom,core-dev-table);
+				 *    bus width: 16 bytes;
+				 */
+				opp-0 {
+					opp-peak-kBps = <800000 4800000>;
+					opp-avg-kBps = <800000 4800000>;
+				};
+				opp-1 {
+					opp-peak-kBps = <1804000 9216000>;
+					opp-avg-kBps = <1804000 9216000>;
+				};
+				opp-2 {
+					opp-peak-kBps = <2188000 11980800>;
+					opp-avg-kBps = <2188000 11980800>;
+				};
+				opp-3 {
+					opp-peak-kBps = <3072000 15052800>;
+					opp-avg-kBps = <3072000 15052800>;
+				};
+				opp-4 {
+					opp-peak-kBps = <4068000 19353600>;
+					opp-avg-kBps = <4068000 19353600>;
+				};
+				opp-5 {
+					opp-peak-kBps = <5412000 20889600>;
+					opp-avg-kBps = <5412000 20889600>;
+				};
+				opp-6 {
+					opp-peak-kBps = <6220000 22425600>;
+					opp-avg-kBps = <6220000 22425600>;
+				};
+				opp-7 {
+					opp-peak-kBps = <7216000 25497600>;
+					opp-avg-kBps = <7216000 25497600>;
+				};
+			};
+		};
+
 		pcie0: pci@1c00000 {
 			compatible = "qcom,pcie-sdm845";
 			reg = <0 0x01c00000 0 0x2000>,
-- 
2.32.0

