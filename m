Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC60655F9A6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 09:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbiF2Hxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 03:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbiF2HxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 03:53:15 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9843B554
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 00:53:02 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id eq6so20968845edb.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 00:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wfc98UIdtcTx3Uk4wA7IydSC5XqKZoBwf1qoiSGq7iA=;
        b=I2OK1McGbJoBW21ZZeM4sydqnxk1iFbRCGkI6B363FKEW1FIlXSshq4qaP2D7pvPDw
         1G18YVReHPvzbZSLXEW2RH9dg6IdzjUC+1u3f1/hNRJNNlVuThDvrxvjbwFvZXi2sVD5
         peCT3dZD6c2lI3aGEc9U8744hIe+u+Vb/U0Q4o7s0CyLRJHQtJmrHf+Av5OaBHIoE/QX
         VqM6LPRtHlz78oms7iX3isNg0ZgbqizAuUeu6KeEvwOWSuiEeSQErdqtSi1vgplh6Z0s
         1D79/zo52w4GN9eMnr/HhGbWv8oFi7VWLDGvXtmLySCgKR2M2RmmJUdYVOgLc6k8prjR
         QZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wfc98UIdtcTx3Uk4wA7IydSC5XqKZoBwf1qoiSGq7iA=;
        b=noQH4+aCDRvnDfdgKJqoIfG9vzP+VtgFYp4Zj0Jq/HnscE+bDmTbtDRCkBc1I3nKq5
         8ik27GiuDzEvy1gPs1e7Fa1cnQ8DcVydustRqvybqHBvB7cvHgVwG8yjLxDvaCD5XIbv
         0klCSg4vcGxlH92k4bPdU0+KPJuKZZDbnulp3ncCsgIK5T7rVNByU6FvNm6Wzw/Ca3rD
         pvZuCiePBUHSwCVS0UIAcwXtuvVLNuBW/ThgS1cNbeeUmHWDUdgzo5sAliLfi5QwCW5A
         JzSU+FVCMzg5EYKNQMMxdhC/UQAg/erdBxd+MrVh13mhDpfJcke/9vHGimRIcyHurbyw
         eVLw==
X-Gm-Message-State: AJIora8vU/dUl9aqciB/lgs3tJeruLdGILtza3sIu5JXATukfqucTlsP
        ja2qIRE2ul3f3KytIhHE4nA5eA==
X-Google-Smtp-Source: AGRyM1um2rliocS+nP8zYQiLFTaGyhO3zUYztQsruEO8RAF5jxnR5TWfwm/XUIood6h0BQlrMa5vhg==
X-Received: by 2002:a05:6402:43c7:b0:435:8a92:e8d0 with SMTP id p7-20020a05640243c700b004358a92e8d0mr2517359edc.174.1656489181164;
        Wed, 29 Jun 2022 00:53:01 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id t2-20020a056402020200b00437db6acaeesm432173edv.95.2022.06.29.00.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 00:53:00 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Thara Gopinath <thara.gopinath@gmail.com>
Subject: [PATCH v5 4/4] arm64: dts: qcom: sdm845: Add CPU BWMON
Date:   Wed, 29 Jun 2022 09:52:50 +0200
Message-Id: <20220629075250.17610-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220629075250.17610-1-krzysztof.kozlowski@linaro.org>
References: <20220629075250.17610-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device node for CPU-memory BWMON device (bandwidth monitoring) on
SDM845 measuring bandwidth between CPU (gladiator_noc) and Last Level
Cache (memnoc).  Usage of this BWMON allows to remove fixed bandwidth
votes from cpufreq (CPU nodes) thus achieve high memory throughput even
with lower CPU frequencies.

Co-developed-by: Thara Gopinath <thara.gopinath@gmail.com>
Signed-off-by: Thara Gopinath <thara.gopinath@gmail.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 38 ++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 83e8b63f0910..e0f088996390 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2026,6 +2026,44 @@ llcc: system-cache-controller@1100000 {
 			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		pmu@1436400 {
+			compatible = "qcom,sdm845-cpu-bwmon", "qcom,msm8998-cpu-bwmon";
+			reg = <0 0x01436400 0 0x600>;
+			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
+			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_LLCC 3>;
+
+			operating-points-v2 = <&cpu_bwmon_opp_table>;
+
+			cpu_bwmon_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				/*
+				 * The interconnect paths bandwidths taken from
+				 * cpu4_opp_table bandwidth.
+				 * They also match different tables from
+				 * msm-4.9 downstream kernel:
+				 *  - the OSM L3 from bandwidth table of
+				 *    qcom,cpu4-l3lat-mon (qcom,core-dev-table);
+				 *    bus width: 16 bytes;
+				 */
+				opp-0 {
+					opp-peak-kBps = <4800000>;
+				};
+				opp-1 {
+					opp-peak-kBps = <9216000>;
+				};
+				opp-2 {
+					opp-peak-kBps = <15052800>;
+				};
+				opp-3 {
+					opp-peak-kBps = <20889600>;
+				};
+				opp-4 {
+					opp-peak-kBps = <25497600>;
+				};
+			};
+		};
+
 		pcie0: pci@1c00000 {
 			compatible = "qcom,pcie-sdm845";
 			reg = <0 0x01c00000 0 0x2000>,
-- 
2.34.1

