Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F5C57BE91
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 21:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbiGTT3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 15:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbiGTT22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 15:28:28 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830C84BD10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:28:25 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id t1so31829740lft.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VypNKwMbA62CLeNoVmJCaXcGhkuttVEBZr0IDp/c4J8=;
        b=ovGBk2Bv7cBQcvFYuuTj9LgZpGqS4tlwaBkTlX7OT9RdWQeahEXYHP/qnBY7jfELVV
         hYJgZqSB9pjIJWg4ds3FI0Mc/RQkb9oADdavQ0IWckydUC80yrtuo3ArQ8X3dLpi1G/D
         CU2NGSIzA2gG21ihfwu8SbkweW8Cv4cOBOz6Zq09QWN/lIx8TvKwh0oQCz5SgnsKJtat
         CiI+7fgsyjYeRogCnF3n+IAiJyP4A8kCFScfP9CzO50enRue3dAqs+eSHd2lIXdDE6lq
         s+j2hm2Bs9YCgl2zlZQ8o0oXIVVU28SHwcZUDYcqwh+ECr8aTz6l0JYnM5CXpxN7Y2gL
         7rxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VypNKwMbA62CLeNoVmJCaXcGhkuttVEBZr0IDp/c4J8=;
        b=YnxFy7rcR6VLHMUusVd9rzBpomwhTCP8csRi3Vupwb3rJpCTEzgsZ5QuABllivGVhE
         Pr1Kmf7FiWywZC7vmNyuwn/YA1sWg2DqndiGXdXP4rg61W51n08tLJBKOVDLnPikAVl1
         sg6dn6Y4eINvsx/EUDVo8ha5iWrftoasmBEyq8yzRvxQLie4sy/eSSB9DozwdfociMxt
         IRRvvtUloc6jEqRrHpz5+aUAwE/i/hM+AGzIjPyt4adIpHtm80i481dViJ0PRBEmeFBW
         HhgWLXSJRJ+39eEvc0ylMUkMyBSdnLnVAFaSBAkoW4gEyoDCW7BW1g7OjvDvzet2LCa6
         EbHA==
X-Gm-Message-State: AJIora9asdiLFmjMsfFs4sGVJFkmqcxiEdAS9sEEAqpQAFok0POOIF6H
        sorghAkb/xAMb7Y2JyUzMZBaqA==
X-Google-Smtp-Source: AGRyM1tYmwR8LBsY9/SmQxiA79aZNoXVeIp0JWO7GsoAzhc3Ar5yV4bftKxyxXibB4bCD4e/EunHgA==
X-Received: by 2002:a05:6512:2304:b0:48a:48e6:619f with SMTP id o4-20020a056512230400b0048a48e6619fmr7511108lfu.434.1658345304944;
        Wed, 20 Jul 2022 12:28:24 -0700 (PDT)
Received: from krzk-bin.. (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id h32-20020a0565123ca000b0047fac0f34absm3985771lfv.196.2022.07.20.12.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 12:28:24 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH 10/10] arm64: dts: qcom: sdm845: add LLCC BWMON
Date:   Wed, 20 Jul 2022 21:28:07 +0200
Message-Id: <20220720192807.130098-11-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220720192807.130098-1-krzysztof.kozlowski@linaro.org>
References: <20220720192807.130098-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SDM845 comes with few instances of Bandwidth Monitor.  The already
supported one monitors traffic between CPU and Last Level Cache
Controller (LLCC) and in downstream sources is called BWMON v4 (or v4 of
register layout).

SDM845 also has also BWMON instance measuring traffic between LLCC and
memory with different register layout: called v5.

Cc: Rajendra Nayak <quic_rjendra@quicinc.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 37 ++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index fe14f7e7523b..4aab464e2bd6 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2053,6 +2053,43 @@ llcc: system-cache-controller@1100000 {
 			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		pmu@114a000 {
+			compatible = "qcom,sdm845-llcc-bwmon";
+			reg = <0 0x0114a000 0 0x1000>;
+			interrupts = <GIC_SPI 580 IRQ_TYPE_LEVEL_HIGH>;
+			interconnects = <&mem_noc MASTER_LLCC 3 &mem_noc SLAVE_EBI1 3>;
+
+			operating-points-v2 = <&llcc_bwmon_opp_table>;
+
+			llcc_bwmon_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				/*
+				 * The interconnect path bandwidth taken from
+				 * cpu4_opp_table bandwidth for gladiator_noc-mem_noc
+				 * interconnect.  This also matches the
+				 * bandwidth table of qcom,llccbw (qcom,bw-tbl,
+				 * bus width: 4 bytes) from msm-4.9 downstream
+				 * kernel.
+				 */
+				opp-0 {
+					opp-peak-kBps = <800000>;
+				};
+				opp-1 {
+					opp-peak-kBps = <1804000>;
+				};
+				opp-2 {
+					opp-peak-kBps = <3072000>;
+				};
+				opp-3 {
+					opp-peak-kBps = <5412000>;
+				};
+				opp-4 {
+					opp-peak-kBps = <7216000>;
+				};
+			};
+		};
+
 		pmu@1436400 {
 			compatible = "qcom,sdm845-bwmon", "qcom,msm8998-bwmon";
 			reg = <0 0x01436400 0 0x600>;
-- 
2.34.1

