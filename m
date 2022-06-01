Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B6553A226
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 12:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351864AbiFAKMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 06:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351834AbiFAKMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 06:12:03 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA6BCC4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 03:11:53 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id gi33so2733022ejc.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 03:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0VLAI4Ml+SYHKdIrxqb9eLy4RuGSKwigpqa2hE5EhyM=;
        b=KdTk+xeAXQ8wsm4aSQlIU20whz1IffM5ydaFwWfMSZfBnChnZFwu+RsXjFj/7lC3NP
         q/bLiDhiB8llQRYKV8jfOjp/zRGu6Oj7aq1VciRM8fxWt8W2JAlIC+0ozACUPthXCcCb
         3+4dGTpxNvEDJRp6T2Gyub+mS2i0g4/3OKsgzwVK8gciPoDRCoRfMoXPRiqQVOH53s9O
         N7xkmRlxSVVmbRFheCIkjZ8sSmuhslQ/iBHFBq4e6JGUpWgBNKpiN1tUAT/vLqRQohnm
         0jm1mAyL1DIbO1jE1V0i+NH1A10gTA3QYwUtWqS1imlYNfOYqA8KOG+/RGyWdhw1UV07
         6n4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0VLAI4Ml+SYHKdIrxqb9eLy4RuGSKwigpqa2hE5EhyM=;
        b=S5RJG+C+ReDqZoVf310TYXLqsmNzEmnVKnPQQ2bz35Rn6wr2AAnpGT8IVLGUcGuRxb
         ZWz3XoJZgN2Tna7wXFqIzE59iP2k1qT/qWbfGu7iLAg2z7kbrVH8ifJ+zrkrNzhvi2Yh
         WpvCetkXP/50fU4xDHq7WPiMt5u1x+tKSGL0bR+NkiRwjz17y+gswSFn3bbzxqsV1hvu
         Q9IrSXKIQjQOTVwg68T8jsctxQFB371VrzdnVkBhBxwpPhLIfYLOPgtch9p4Q1KGlP8U
         9/4A2lQkAwAZY4n2ncyidfrQBNvJdHrSS/Q+1iVSekhramqV4cV1Nzw7J9gdlvnRbwPt
         wWqQ==
X-Gm-Message-State: AOAM531GuiqyAMYelFNu9wt10USKcklxo5fuysCKEGy6qseSl3ZDiSU8
        hAroV3ve0wTFmKNqhWBsM2AJ/A==
X-Google-Smtp-Source: ABdhPJxYMIZaapgsvY80qG/83T9mL1n8nrcG58gH9s/gwMkjWMv3ztULv3t9VCh7k6hav4WBZ1rz0w==
X-Received: by 2002:a17:907:16ac:b0:6fe:b7db:8af5 with SMTP id hc44-20020a17090716ac00b006feb7db8af5mr48421039ejc.433.1654078312673;
        Wed, 01 Jun 2022 03:11:52 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id m9-20020a170906580900b006feb7b1379dsm501373ejq.181.2022.06.01.03.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 03:11:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Thara Gopinath <thara.gopinath@linaro.org>
Subject: [PATCH v4 4/4] arm64: dts: qcom: sdm845: Add CPU BWMON
Date:   Wed,  1 Jun 2022 12:11:40 +0200
Message-Id: <20220601101140.170504-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220601101140.170504-1-krzysztof.kozlowski@linaro.org>
References: <20220601101140.170504-1-krzysztof.kozlowski@linaro.org>
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

Performance impact (SDM845-MTP RB3 board, linux next-20220422):
1. No noticeable impact when running with schedutil or performance
   governors.

2. When comparing to customized kernel with synced interconnects and
   without bandwidth votes from CPU freq, the sysbench memory tests
   show significant improvement with bwmon for blocksizes past the L3
   cache.  The results for such superficial comparison:

sysbench memory test, results in MB/s (higher is better)
 bs kB |  type |    V  | V+no bw votes | bwmon | benefit %
     1 | W/seq | 14795 |          4816 |  4985 |      3.5%
    64 | W/seq | 41987 |         10334 | 10433 |      1.0%
  4096 | W/seq | 29768 |          8728 | 32007 |    266.7%
 65536 | W/seq | 17711 |          4846 | 18399 |    279.6%
262144 | W/seq | 16112 |          4538 | 17429 |    284.1%
    64 | R/seq | 61202 |         67092 | 66804 |     -0.4%
  4096 | R/seq | 23871 |          5458 | 24307 |    345.4%
 65536 | R/seq | 18554 |          4240 | 18685 |    340.7%
262144 | R/seq | 17524 |          4207 | 17774 |    322.4%
    64 | W/rnd |  2663 |          1098 |  1119 |      1.9%
 65536 | W/rnd |   600 |           316 |   610 |     92.7%
    64 | R/rnd |  4915 |          4784 |  4594 |     -4.0%
 65536 | R/rnd |   664 |           281 |   678 |    140.7%

Legend:
bs kB: block size in KB (small block size means only L1-3 caches are
      used
type: R - read, W - write, seq - sequential, rnd - random
V: vanilla (next-20220422)
V + no bw votes: vanilla without bandwidth votes from CPU freq
bwmon: bwmon without bandwidth votes from CPU freq
benefit %: difference between vanilla without bandwidth votes and bwmon
           (higher is better)

Co-developed-by: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 54 ++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 83e8b63f0910..adffb9c70566 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2026,6 +2026,60 @@ llcc: system-cache-controller@1100000 {
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
+				 * The interconnect paths bandwidths taken from
+				 * cpu4_opp_table bandwidth.
+				 * They also match different tables from
+				 * msm-4.9 downstream kernel:
+				 *  - the gladiator_noc-mem_noc from bandwidth
+				 *    table of qcom,llccbw (property qcom,bw-tbl);
+				 *    bus width: 4 bytes;
+				 *  - the OSM L3 from bandwidth table of
+				 *    qcom,cpu4-l3lat-mon (qcom,core-dev-table);
+				 *    bus width: 16 bytes;
+				 */
+				opp-0 {
+					opp-peak-kBps = <800000 4800000>;
+				};
+				opp-1 {
+					opp-peak-kBps = <1804000 9216000>;
+				};
+				opp-2 {
+					opp-peak-kBps = <2188000 11980800>;
+				};
+				opp-3 {
+					opp-peak-kBps = <3072000 15052800>;
+				};
+				opp-4 {
+					opp-peak-kBps = <4068000 19353600>;
+				};
+				opp-5 {
+					opp-peak-kBps = <5412000 20889600>;
+				};
+				opp-6 {
+					opp-peak-kBps = <6220000 22425600>;
+				};
+				opp-7 {
+					opp-peak-kBps = <7216000 25497600>;
+				};
+			};
+		};
+
 		pcie0: pci@1c00000 {
 			compatible = "qcom,pcie-sdm845";
 			reg = <0 0x01c00000 0 0x2000>,
-- 
2.34.1

