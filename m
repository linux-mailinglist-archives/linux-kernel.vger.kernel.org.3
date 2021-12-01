Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58458464855
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347520AbhLAHcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:32:01 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:54734 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347470AbhLAHbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:31:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2B56CCE1D74;
        Wed,  1 Dec 2021 07:28:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D03C53FCE;
        Wed,  1 Dec 2021 07:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638343705;
        bh=pFW9LLeGFw6OFl+VdNxQE9t4wzrVcZdf1yS0WSs+cFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pkzyv2vCJiDoN6dJJEQevuSWnKvXajRjtI5o//ZGegx3kwlVUX2Ztywep+/FO3rt+
         Rz5AR0+fkzI2bv+7zaKLnEZASqvg/pWZLVv5qwCyQrjRIaytSt8OFrg5XWX1qYYJnr
         lkeF/kkZDny/MJ+9JamZAKRTVufUGbcg8KcuwtmeQbbt9Vcpz40vNY9D3nl/eQ9lBo
         Krb/iPcLxqSWvu1vzmYrsNLPhkJaWnpcAcbZcWoSeWp0fE1TsT9/jpe6h5fNf1sU6a
         Qf1kqbozHgelxGjnis5iQHbyPsPqmdPXTbuHaDZXfV7P8DupvS3yI9ha8YbbTDt5sm
         sHlHsC51SMjLw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6/7] soc: qcom: rpmhpd: Add SM8450 power domains
Date:   Wed,  1 Dec 2021 12:57:44 +0530
Message-Id: <20211201072745.3969077-7-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211201072745.3969077-1-vkoul@kernel.org>
References: <20211201072745.3969077-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Add the power domains exposed by RPMH in the Qualcomm SM8450 platform.
Unlike previous generations CX domain is not a child of MX domain.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/soc/qcom/rpmhpd.c | 52 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
index 1118345d8824..e7e150ce1b1a 100644
--- a/drivers/soc/qcom/rpmhpd.c
+++ b/drivers/soc/qcom/rpmhpd.c
@@ -253,6 +253,57 @@ static const struct rpmhpd_desc sm8350_desc = {
 	.num_pds = ARRAY_SIZE(sm8350_rpmhpds),
 };
 
+/* SM8450 RPMH powerdomains */
+static struct rpmhpd sm8450_cx_ao;
+static struct rpmhpd sm8450_cx = {
+	.pd = { .name = "cx", },
+	.peer = &sm8450_cx_ao,
+	.res_name = "cx.lvl",
+};
+
+static struct rpmhpd sm8450_cx_ao = {
+	.pd = { .name = "cx_ao", },
+	.active_only = true,
+	.res_name = "cx.lvl",
+};
+
+static struct rpmhpd sm8450_mmcx_ao;
+static struct rpmhpd sm8450_mmcx = {
+	.pd = { .name = "mmcx", },
+	.peer = &sm8450_mmcx_ao,
+	.parent = &sm8450_cx.pd,
+	.res_name = "mmcx.lvl",
+};
+
+static struct rpmhpd sm8450_mmcx_ao = {
+	.pd = { .name = "mmcx_ao", },
+	.active_only = true,
+	.peer = &sm8450_mmcx,
+	.parent = &sm8450_cx_ao.pd,
+	.res_name = "mmcx.lvl",
+};
+
+static struct rpmhpd *sm8450_rpmhpds[] = {
+	[SM8450_CX] = &sm8450_cx,
+	[SM8450_CX_AO] = &sm8450_cx_ao,
+	[SM8450_EBI] = &sdm845_ebi,
+	[SM8450_GFX] = &sdm845_gfx,
+	[SM8450_LCX] = &sdm845_lcx,
+	[SM8450_LMX] = &sdm845_lmx,
+	[SM8450_MMCX] = &sm8450_mmcx,
+	[SM8450_MMCX_AO] = &sm8450_mmcx_ao,
+	[SM8450_MX] = &sdm845_mx,
+	[SM8450_MX_AO] = &sdm845_mx_ao,
+	[SM8450_MXC] = &sm8350_mxc,
+	[SM8450_MXC_AO] = &sm8350_mxc_ao,
+	[SM8450_MSS] = &sdm845_mss,
+};
+
+static const struct rpmhpd_desc sm8450_desc = {
+	.rpmhpds = sm8450_rpmhpds,
+	.num_pds = ARRAY_SIZE(sm8450_rpmhpds),
+};
+
 /* SC7180 RPMH powerdomains */
 static struct rpmhpd *sc7180_rpmhpds[] = {
 	[SC7180_CX] = &sdm845_cx,
@@ -318,6 +369,7 @@ static const struct of_device_id rpmhpd_match_table[] = {
 	{ .compatible = "qcom,sm8150-rpmhpd", .data = &sm8150_desc },
 	{ .compatible = "qcom,sm8250-rpmhpd", .data = &sm8250_desc },
 	{ .compatible = "qcom,sm8350-rpmhpd", .data = &sm8350_desc },
+	{ .compatible = "qcom,sm8450-rpmhpd", .data = &sm8450_desc },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, rpmhpd_match_table);
-- 
2.31.1

