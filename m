Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A9A538F4D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 12:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343653AbiEaKwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 06:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbiEaKwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 06:52:04 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93C8590A1
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 03:52:02 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id b8so8990848edf.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 03:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0VLAI4Ml+SYHKdIrxqb9eLy4RuGSKwigpqa2hE5EhyM=;
        b=Ircbk0hZlXm80bfKncdNpRQnwpqdJf0Or7kiCzAJodozD6rJ0gornPINQpedK+w0Ng
         4JQbNZ0/nunG08IvmzRNK9jgtl0aO0wShaJ8z25Z4NDyWjpFYv7iUyCKM7n1/FlUMmd8
         kEh/YC4cqLyGtdgpOTamcW+COdIEejfU0XruVAgeEP4zHn8Jdp9REQZS+8shyUkDJWRh
         1G73faKLccu2KgPk9VwpuWWtkX5/V0V3KrQ+/xRYpxRVAFbY8ua7L0SwvbpwCh1mH6sV
         liCys8pboL2t2sJ6zLvyxFYI8ast30W51L20UoXkDX9RL5M4QzaH8Gb4jYIDcSIGvxC0
         xMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0VLAI4Ml+SYHKdIrxqb9eLy4RuGSKwigpqa2hE5EhyM=;
        b=LUv7RkL2pnefok9ZRA14KkEjtFd+gttH/u/qFQzU4hLyWn7USnEaGhSvgY6o7MklfY
         s1NOtwr1o/DNPfBZf0eIdOWRr8E1CMM2IJpL7fkKQ61Fvy4ez77kOMIMd8lYZ62cepDK
         fAAsvr/TZ16a6r0QCOmBwDtFVhf2Gn7ltUmRY/1vtK5jsBp56vyd8x3azTo49ejj52lR
         jvEQGwMijR4EBs9YBYGplis1e4n2/20j9jvZI0gIizE5edSZCEn5k1aF1IFN9xCXdnFr
         Nsj3huV9wQo9JR+stO73DdTk/nKtTWEcT9cZ9kMic7ATfPsLg8OnJ4ZpJi0OoybQCZYj
         FjTg==
X-Gm-Message-State: AOAM531KOLdbxk41TpnZTJdFh7apVw2lZWc5YzQ7/8Dp45W6Lp423OU7
        85OQVsSMoPKK7aD7EI5Gkg89Cg==
X-Google-Smtp-Source: ABdhPJxeyRyKKO7bmN1vHfs62vzjhcZu15ey+2f7vqPj4eKKuw8I/4AAaIoQs3LZtcKAYTu97DFvaQ==
X-Received: by 2002:a05:6402:17c8:b0:42d:dc6f:f17c with SMTP id s8-20020a05640217c800b0042ddc6ff17cmr5646106edy.17.1653994321314;
        Tue, 31 May 2022 03:52:01 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q3-20020a50aa83000000b0042dc513ced8sm5117441edc.30.2022.05.31.03.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 03:52:00 -0700 (PDT)
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
Cc:     Thara Gopinath <thara.gopinath@linaro.org>
Subject: [PATCH v3 4/4] arm64: dts: qcom: sdm845: Add CPU BWMON
Date:   Tue, 31 May 2022 12:51:37 +0200
Message-Id: <20220531105137.110050-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220531105137.110050-1-krzysztof.kozlowski@linaro.org>
References: <20220531105137.110050-1-krzysztof.kozlowski@linaro.org>
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

