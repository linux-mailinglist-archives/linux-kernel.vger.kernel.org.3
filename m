Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFDF573D9E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 22:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236821AbiGMULL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 16:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbiGMULH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 16:11:07 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [5.144.164.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A282A701
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 13:11:05 -0700 (PDT)
Received: from localhost.localdomain (abxj14.neoplus.adsl.tpnet.pl [83.9.3.14])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 5FC843F7A0;
        Wed, 13 Jul 2022 22:11:03 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] arm64: dts: qcom: sm8450: Adjust memory map
Date:   Wed, 13 Jul 2022 22:10:45 +0200
Message-Id: <20220713201047.1449786-2-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220713201047.1449786-1-konrad.dybcio@somainline.org>
References: <20220713201047.1449786-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up the camera region (cross-referenced different vendors' msm-5.10
drops, 9f500000 is the default location for SM8450) and reserve the
second chunk occupied by xbl_sc.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 7d08fad76371..09e7587de0de 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -436,11 +436,6 @@ cdsp_secure_heap: memory@80c00000 {
 			no-map;
 		};
 
-		camera_mem: memory@85200000 {
-			reg = <0x0 0x85200000 0x0 0x500000>;
-			no-map;
-		};
-
 		video_mem: memory@85700000 {
 			reg = <0x0 0x85700000 0x0 0x700000>;
 			no-map;
@@ -503,6 +498,11 @@ cvp_mem: memory@9ee00000 {
 			no-map;
 		};
 
+		camera_mem: memory@9f500000 {
+			reg = <0x0 0x9f500000 0x0 0x800000>;
+			no-map;
+		};
+
 		rmtfs_mem: memory@9fd00000 {
 			compatible = "qcom,rmtfs-mem";
 			reg = <0x0 0x9fd00000 0x0 0x280000>;
@@ -512,6 +512,11 @@ rmtfs_mem: memory@9fd00000 {
 			qcom,vmid = <15>;
 		};
 
+		xbl_sc_mem2: memory@a6e00000 {
+			reg = <0x0 0xa6e00000 0x0 0x40000>;
+			no-map;
+		};
+
 		global_sync_mem: memory@a6f00000 {
 			reg = <0x0 0xa6f00000 0x0 0x100000>;
 			no-map;
-- 
2.37.0

