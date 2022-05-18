Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD76152B62F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbiERJUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbiERJUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:20:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65681498DC;
        Wed, 18 May 2022 02:20:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6216061709;
        Wed, 18 May 2022 09:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F03DC36AE7;
        Wed, 18 May 2022 09:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652865611;
        bh=Cql491K1t+dfQO8pYwTPLCim5Mq2N8776frrbXulDa8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HUCSWnHXQSPEX7jiRqehzn6zwCcL9Mh1kn+iAflUDNnv39lt5Cy553O20DkYiDcDD
         ORf9JVu9utWev76TKj6keOSNfmPEnMFkz78amEw+SYkz2FtsGtcx0pktvubU9r5gl6
         5AMyZitjZ8g+n61tf9mAT6lE/7NVY35SpxjHaivDsuQTL5gB821vx89cpwuKHT0MQu
         Y9VUkMxoM4vP/fcVNetN4r9KrVcH9QZDP0VEoB5rFynA6xIfVbZZsZglnz3abWQnXY
         +Q6f0qnzcAcbytNtoSXbslo9tLK+yOUBYY556u40M9qWk38OAYL4CMBRQDL9UvmBPv
         SXudYf9QFUeUQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/3] arm64: dts: qcom: sm8450: rename interconnect nodes
Date:   Wed, 18 May 2022 14:49:59 +0530
Message-Id: <20220518092001.2262024-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220518092001.2262024-1-vkoul@kernel.org>
References: <20220518092001.2262024-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk-virt and mc-virt interconnect nodes were named interconnect@0 and
interconnect@1. That is incorrect as we don't have unit addresses 0/1
for these node.

This causes warning:
arch/arm64/boot/dts/qcom/sm8450.dtsi:255.27-259.4:
	Warning (unit_address_vs_reg): /interconnect@0:
	node has a unit name, but no reg or ranges property
arch/arm64/boot/dts/qcom/sm8450.dtsi:261.26-265.4:
	Warning (unit_address_vs_reg): /interconnect@1:
	node has a unit name, but no reg or ranges property
arch/arm64/boot/dts/qcom/sm8450.dtsi:255.27-259.4:
	Warning (unique_unit_address_if_enabled): /interconnect@0:
	duplicate unit-address (also used in node /soc@0)

Rename the nodes to interconnect-0 and interconnect-1 to fix the
warning.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 7f52c3cfdfb7..d7a296c87220 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -262,13 +262,13 @@ scm: scm {
 		};
 	};
 
-	clk_virt: interconnect@0 {
+	clk_virt: interconnect-0 {
 		compatible = "qcom,sm8450-clk-virt";
 		#interconnect-cells = <2>;
 		qcom,bcm-voters = <&apps_bcm_voter>;
 	};
 
-	mc_virt: interconnect@1 {
+	mc_virt: interconnect-1 {
 		compatible = "qcom,sm8450-mc-virt";
 		#interconnect-cells = <2>;
 		qcom,bcm-voters = <&apps_bcm_voter>;
-- 
2.34.1

