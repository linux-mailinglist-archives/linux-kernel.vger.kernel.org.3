Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD918500AE0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242187AbiDNKTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234231AbiDNKTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:19:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6AD716E8;
        Thu, 14 Apr 2022 03:16:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BC1761E80;
        Thu, 14 Apr 2022 10:16:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73885C385AB;
        Thu, 14 Apr 2022 10:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649931405;
        bh=eWSuTzQIdCpcp7wBi/vcp2ypL+Y0N4uLV0cvMiaCagk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jfzmDxGZT+wBJXbTlE24zBER1/D37jua/LZ/4V/ygcygMf7tlDq/FllX8NN1HvIik
         av4u6IqNI9yTQT7Q7ZITuySBh/9G549wYixkdRbnQ0yJU/6rzhF/YtooRCU0cRvZUS
         FSujsnQ6OkF+Ng5+7tRRhpAg439HkwcJMx6XSEbd4VbAerF5zpXXNt34sT5PjuFnYM
         k9cCDqpIJ/93PS24W7/sQatOGVQJ0RhXuzLDKeVF5nTwW/oLA9WbFJljkZZLXt3lp9
         qbIPHdivpH0r5tPWaGXLMCwyctz7tRHSGjKkmeBL9SSyTaWdZjUS0PaJY6X1J9RIst
         JA9Cc5qUNYWLg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] arm64: dts: qcom: sm8450: Fix missing iommus for qup
Date:   Thu, 14 Apr 2022 15:46:25 +0530
Message-Id: <20220414101630.1189052-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220414101630.1189052-1-vkoul@kernel.org>
References: <20220414101630.1189052-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qupv3_id_0 was missing iommus property which cause any dma transaction
to fail and board crash. So add the missing iommus.

While at it also add interconnect nodes for qup

Fixes: 5188049c9b36 ("arm64: dts: qcom: Add base SM8450 DTSI")
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index bfbb6e04fcb4..93ff677f0d35 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -738,6 +738,9 @@ qupv3_id_0: geniqup@9c0000 {
 			clock-names = "m-ahb", "s-ahb";
 			clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
 				 <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
+			iommus = <&apps_smmu 0x5a3 0x0>;
+			interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>;
+			interconnect-names = "qup-core";
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
-- 
2.34.1

