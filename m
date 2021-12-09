Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B121246E6BD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbhLIKjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 05:39:21 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60224 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234937AbhLIKjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:39:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7EBDB82439;
        Thu,  9 Dec 2021 10:35:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167AAC004DD;
        Thu,  9 Dec 2021 10:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639046139;
        bh=RscXmgq2TBxbIk/PdUAA1U2yb/wZ/iwgvquLb7D706I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ijlTBznkKd1uyJJ1eR3z28wWotkKotS8G5Hq7vyEbuCBtqaOOGaqVPV5aNo+wV1rq
         Ifz5eNMPN/CRfHaW9JE9SaAtbe0LxESRGRkWbwgsp6Q71oXC+e6cuXIR5fWyYgKp4u
         06UkLJoJ9aQ88kQtEeEXxHFIvuTmGWayUuo9LKfDe5ro71z1kgVoC8Wr4O/8hEis1X
         OybGn9ZOeZl8dr5tp/ebpNqDbsPhR/wCXYkvVZZ+xN3MRyoTxENEoapKhfG1JbHchJ
         D8K0DT5lJgAmuFwnze/LlU1vlnvfRhu0CjuM2o3SoIsbucjIRTSsWsSowK89rJh/hO
         hwy5Nluah4KXA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/13] arm64: dts: qcom: sm8450-qrd: enable ufs nodes
Date:   Thu,  9 Dec 2021 16:05:00 +0530
Message-Id: <20211209103505.197453-9-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211209103505.197453-1-vkoul@kernel.org>
References: <20211209103505.197453-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the UFS and phy node and add the regulators used by them.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/sm8450-qrd.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
index 26d2b5aa8dff..6cf584ebf1ed 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
@@ -356,3 +356,23 @@ &tlmm {
 &uart7 {
 	status = "okay";
 };
+
+&ufs_mem_hc {
+	status = "okay";
+
+	reset-gpios = <&tlmm 210 GPIO_ACTIVE_LOW>;
+
+	vcc-supply = <&vreg_l7b_2p5>;
+	vcc-max-microamp = <1100000>;
+	vccq-supply = <&vreg_l9b_1p2>;
+	vccq-max-microamp = <1200000>;
+};
+
+&ufs_mem_phy {
+	status = "okay";
+
+	vdda-phy-supply = <&vreg_l5b_0p88>;
+	vdda-pll-supply = <&vreg_l6b_1p2>;
+	vdda-max-microamp = <173000>;
+	vdda-pll-max-microamp = <24900>;
+};
-- 
2.31.1

