Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16119476F87
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236460AbhLPLIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:08:40 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57360 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236447AbhLPLIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:08:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C494B8237B;
        Thu, 16 Dec 2021 11:08:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82B0C36AE8;
        Thu, 16 Dec 2021 11:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639652916;
        bh=HcAx3FUj1jfhygvbz1d3e421uZRDUhS6whbtnO88oRk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YpvhGSs8L89zPPIuKwl40tobTA05LDBGEiNGvnYRvaTGOJACKqsxEBJ/g+1tvjBsx
         myVwQuxz7O/qBYea2gBiZfeRWjhPkB0jh5xNXd4AYfst1WimilzWp11bWlheZR6ygR
         GgcaSKa1U0u6auOtTPbzUxchMuKSti1RDaZOvbQ12Uue4Q+etiL1ivWEqfhg16Dr/p
         VWueUW9pB/+AvH2Qj6ktKASjH31o+UVru9j4cAQA6EH9nJJRC/XC0zgd5Zs1g6m8ky
         bOWVClqWiGHIrVYqoI1GbfQB+AL4jYSK3z6C8TvX7W0kknDcEij0GdU4iozPF9hj+8
         qSSi+BLTiF/lQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: qcom: sm8450-qrd: Enable USB nodes
Date:   Thu, 16 Dec 2021 16:38:13 +0530
Message-Id: <20211216110813.658384-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216110813.658384-1-vkoul@kernel.org>
References: <20211216110813.658384-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the usb phy and usb controller in peripheral mode. This helps to
get the adb working with the QRD board.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8450-qrd.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
index 6cf584ebf1ed..13d702946668 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
@@ -376,3 +376,26 @@ &ufs_mem_phy {
 	vdda-max-microamp = <173000>;
 	vdda-pll-max-microamp = <24900>;
 };
+
+&usb_1 {
+	status = "okay";
+};
+
+&usb_1_dwc3 {
+	dr_mode = "peripheral";
+};
+
+&usb_1_hsphy {
+	status = "okay";
+
+	vdda-pll-supply = <&vreg_l5b_0p88>;
+	vdda18-supply = <&vreg_l1c_1p8>;
+	vdda33-supply = <&vreg_l2b_3p07>;
+};
+
+&usb_1_qmpphy {
+	status = "okay";
+
+	vdda-phy-supply = <&vreg_l6b_1p2>;
+	vdda-pll-supply = <&vreg_l1b_0p91>;
+};
-- 
2.31.1

