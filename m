Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD5646481E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347320AbhLAH3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:29:03 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56406 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347371AbhLAH2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:28:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F3D0B81DE0;
        Wed,  1 Dec 2021 07:25:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27070C53FCE;
        Wed,  1 Dec 2021 07:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638343532;
        bh=wnueZpn2aeaR5LqTiYSRzkTKFKIfl2LLkOyYv758vV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PpKhpsq/+B5M0mRb+ObB/3/hI+tm+xCkWG24r96jMb1g+kM0h26otvv9g8Ex06Gza
         4FFOfmZtKPnp1z8DQ/FZ9ZoSoaXgRjrhvOPhHmW6tqv8tHj2daQHoxBGN9i+dDGuFt
         BotpD16yZscREOxz3pxqWHRWY2MZczE+eZZWinpHr0n3V86DpdK/WHhC0fz1VDrE89
         l9vR74PBYSj2S06YdDdfHLUIupe/5PDSdQIAxVQQF5BjAk+GqBYXHkW6/n5aeNnBK/
         7y4MmnQeNZKpNKR7zYM0+fXjVCN8WWc5YVGZOQzSa1W/TyE3YCEOdQnmnwAkfiiitE
         hXbTqNLLbYg+A==
From:   Vinod Koul <vkoul@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/2] regulator: qcom-rpmh: Add support for PM8450 regulators
Date:   Wed,  1 Dec 2021 12:55:15 +0530
Message-Id: <20211201072515.3968843-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211201072515.3968843-1-vkoul@kernel.org>
References: <20211201072515.3968843-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the rpmh regulators found in PM8450 PMIC

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/regulator/qcom-rpmh-regulator.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index 12425f667c00..cea6d7413864 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -969,6 +969,20 @@ static const struct rpmh_vreg_init_data pm8350c_vreg_data[] = {
 	{}
 };
 
+static const struct rpmh_vreg_init_data pm8450_vreg_data[] = {
+	RPMH_VREG("smps1",  "smp%s1",  &pmic5_ftsmps520, "vdd-s1"),
+	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps520, "vdd-s2"),
+	RPMH_VREG("smps3",  "smp%s3",  &pmic5_ftsmps520, "vdd-s3"),
+	RPMH_VREG("smps4",  "smp%s4",  &pmic5_ftsmps520, "vdd-s4"),
+	RPMH_VREG("smps5",  "smp%s5",  &pmic5_ftsmps520, "vdd-s5"),
+	RPMH_VREG("smps6",  "smp%s6",  &pmic5_ftsmps520, "vdd-s6"),
+	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo,      "vdd-l1"),
+	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_nldo,      "vdd-l2"),
+	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo,      "vdd-l3"),
+	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_pldo_lv,   "vdd-l4"),
+	{}
+};
+
 static const struct rpmh_vreg_init_data pm8009_vreg_data[] = {
 	RPMH_VREG("smps1",  "smp%s1",  &pmic5_hfsmps510, "vdd-s1"),
 	RPMH_VREG("smps2",  "smp%s2",  &pmic5_hfsmps515, "vdd-s2"),
@@ -1213,6 +1227,10 @@ static const struct of_device_id __maybe_unused rpmh_regulator_match_table[] = {
 		.compatible = "qcom,pm8350c-rpmh-regulators",
 		.data = pm8350c_vreg_data,
 	},
+	{
+		.compatible = "qcom,pm8450-rpmh-regulators",
+		.data = pm8450_vreg_data,
+	},
 	{
 		.compatible = "qcom,pm8998-rpmh-regulators",
 		.data = pm8998_vreg_data,
-- 
2.31.1

