Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B11C4BD255
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 23:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245161AbiBTWbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 17:31:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244570AbiBTWbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 17:31:05 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027F84B873;
        Sun, 20 Feb 2022 14:30:44 -0800 (PST)
Received: from localhost.localdomain (ip-213-127-118-180.ip.prioritytelecom.net [213.127.118.180])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 84A4FC83D5;
        Sun, 20 Feb 2022 22:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1645396242; bh=Z5QyXYJWluQNgIrdnzlQ4wsGTvrvV8OZI8S3n9fVWDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VrmjH+NWxb72osI6sMg+QGUlxa27NpwFsjA5gZCKFfTGFa0FNAo3IqPFzzBL05Hct
         BrXvSzIyIqo9or+3qIcmSvw9Q2ffcuvIVyqVAOwWfqpWKDKSoG72CvFVXYYLYm+lDu
         CF0T3GKlGsS6LPjFpN/8wueE/HKEd+K36dbi2Y1o=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] soc: qcom: rpmpd: Add MSM8226 support
Date:   Sun, 20 Feb 2022 23:30:02 +0100
Message-Id: <20220220223004.507739-2-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220220223004.507739-1-luca@z3ntu.xyz>
References: <20220220223004.507739-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the power domains preset in MSM8226.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/soc/qcom/rpmpd.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index 0a8d8d24bfb7..95a2b4a64801 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -138,6 +138,22 @@ static const struct rpmpd_desc mdm9607_desc = {
 	.max_state = RPM_SMD_LEVEL_TURBO,
 };
 
+/* msm8226 RPM Power Domains */
+DEFINE_RPMPD_PAIR(msm8226, vddcx, vddcx_ao, SMPA, CORNER, 1);
+DEFINE_RPMPD_VFC(msm8226, vddcx_vfc, SMPA, 1);
+
+static struct rpmpd *msm8226_rpmpds[] = {
+	[MSM8226_VDDCX] =	&msm8226_vddcx,
+	[MSM8226_VDDCX_AO] =	&msm8226_vddcx_ao,
+	[MSM8226_VDDCX_VFC] =	&msm8226_vddcx_vfc,
+};
+
+static const struct rpmpd_desc msm8226_desc = {
+	.rpmpds = msm8226_rpmpds,
+	.num_pds = ARRAY_SIZE(msm8226_rpmpds),
+	.max_state = MAX_CORNER_RPMPD_STATE,
+};
+
 /* msm8939 RPM Power Domains */
 DEFINE_RPMPD_PAIR(msm8939, vddmd, vddmd_ao, SMPA, CORNER, 1);
 DEFINE_RPMPD_VFC(msm8939, vddmd_vfc, SMPA, 1);
@@ -436,6 +452,7 @@ static const struct rpmpd_desc qcm2290_desc = {
 
 static const struct of_device_id rpmpd_match_table[] = {
 	{ .compatible = "qcom,mdm9607-rpmpd", .data = &mdm9607_desc },
+	{ .compatible = "qcom,msm8226-rpmpd", .data = &msm8226_desc },
 	{ .compatible = "qcom,msm8916-rpmpd", .data = &msm8916_desc },
 	{ .compatible = "qcom,msm8939-rpmpd", .data = &msm8939_desc },
 	{ .compatible = "qcom,msm8953-rpmpd", .data = &msm8953_desc },
-- 
2.35.1

