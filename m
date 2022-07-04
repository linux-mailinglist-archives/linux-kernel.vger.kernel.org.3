Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860CF565505
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbiGDMSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbiGDMSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:18:07 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD9712631
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 05:17:41 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id b19so10849029ljf.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 05:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C1M+FtKCNKsX4tOnqV3xDo7Y0vEiWdZsYEx0bmq2vBw=;
        b=kgzluWAvls5eerYpL69ZSzolkF0CaWpkf9EzpVbG6E0L1l7pR39XWHBbKr5mU1Jflv
         uuKViK6Kg/iq4NwIpV2QdaTD+aaoFNX6FEMYhN1SHkFE1BVErFf+WnUcewHo/ep2sca9
         eN5z2VHHp734YiJgDG3HY3haLn1azLzbes0GKc/cOUCuQEhAAM7fopEETWAY+STAZAvk
         Fng1zOxtF+R+ecobWOUQIK4iojMAFoheWVkMNPAjXWynolW6lF70JUYK71a6b0V/d2N3
         iNdJfW2ETnbEqa/y/BH5bhS9uRwFbaNFWePpmTUCza9bmCkRxvskjUMQgrPxJXEJ8oWm
         46NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C1M+FtKCNKsX4tOnqV3xDo7Y0vEiWdZsYEx0bmq2vBw=;
        b=6fozYlcP/mga6n3yen0eensU8yy7sJe14GanaBoo6ZwqxGqNH1ABKUVvmb331nEP6a
         xdQbCo4fg3xiVzAmyjr6fhLBofHPw74oQfWVk8PYiYfSv6ITgOU+ylbeENGB4NnnkMes
         ZqCzI1yrOFqjvPKm5b0pIrtwUTirE32seSAEb0gyAGx1tN/p3Q2xKPx1uzKgJBDSmhJx
         xuRe0ieMMjckkSFOhRYlTGGv6Ayz6o5kS05DaVS5ILCbggTUzy0lHRzw0lVQdiy57ybQ
         E0RNjO+msBIr/07vfOcQu7veYN317fkC4Xe5Riua0aPHYNtFSHWytvEsGeCXXl0C8IEB
         2tbQ==
X-Gm-Message-State: AJIora+rjfB8UZ2ZcVoz1SzydHfX+oofDd8NAVey7dvC++OWz7wzSVWG
        80pLsL7NE/mdpvnlaN5hHW1jTw==
X-Google-Smtp-Source: AGRyM1tea0fdyzeMMijwvCjJj/z/c6EDy7K9Gdk1BfLqZOaT1ngMIkM67D9M61fD/2namUFa4HF2Qg==
X-Received: by 2002:a2e:889a:0:b0:25a:ca71:823e with SMTP id k26-20020a2e889a000000b0025aca71823emr15873247lji.11.1656937059833;
        Mon, 04 Jul 2022 05:17:39 -0700 (PDT)
Received: from krzk-bin.home ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id u11-20020a05651220cb00b0047faa01edd9sm5102149lfr.229.2022.07.04.05.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 05:17:39 -0700 (PDT)
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
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>,
        Thara Gopinath <thara.gopinath@gmail.com>
Subject: [PATCH v8 4/4] arm64: dts: qcom: sdm845: Add CPU BWMON
Date:   Mon,  4 Jul 2022 14:17:30 +0200
Message-Id: <20220704121730.127925-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220704121730.127925-1-krzysztof.kozlowski@linaro.org>
References: <20220704121730.127925-1-krzysztof.kozlowski@linaro.org>
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
SDM845 measuring bandwidth between CPU (gladiator_noc) and Last Level
Cache (memnoc).  Usage of this BWMON allows to remove fixed bandwidth
votes from cpufreq (CPU nodes) thus achieve high memory throughput even
with lower CPU frequencies.

Co-developed-by: Thara Gopinath <thara.gopinath@gmail.com>
Signed-off-by: Thara Gopinath <thara.gopinath@gmail.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 37 ++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 83e8b63f0910..e65dedfa6cee 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2026,6 +2026,43 @@ llcc: system-cache-controller@1100000 {
 			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		pmu@1436400 {
+			compatible = "qcom,sdm845-bwmon", "qcom,msm8998-bwmon";
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
+				 * The interconnect path bandwidth taken from
+				 * cpu4_opp_table bandwidth for OSM L3
+				 * interconnect.  This also matches the OSM L3
+				 * from bandwidth table of qcom,cpu4-l3lat-mon
+				 * (qcom,core-dev-table, bus width: 16 bytes)
+				 * from msm-4.9 downstream kernel.
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

