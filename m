Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2A15781EC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbiGRMOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbiGRMO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:14:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9139321E20
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:14:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oDPdg-0005dB-97; Mon, 18 Jul 2022 14:14:16 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oDPdf-001i44-CS; Mon, 18 Jul 2022 14:14:15 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oDPde-005xVV-Ix; Mon, 18 Jul 2022 14:14:14 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     kernel@pengutronix.de, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/8] interconnect: msm8974: Ignore return value of icc_provider_del() in .remove()
Date:   Mon, 18 Jul 2022 14:14:05 +0200
Message-Id: <20220718121409.171773-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220718121409.171773-1-u.kleine-koenig@pengutronix.de>
References: <20220718121409.171773-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1126; h=from:subject; bh=FJpmWEXN+H+dGnE/UQ8dINtNJBHBVROLu55mJZbljTU=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBi1U5/n8V4MYO8Y+Zd92pavKNcD2A1mz6JcJosSBcZ rJbUi5GJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYtVOfwAKCRDB/BR4rcrsCc7nB/ 4w5+KeQHTMWPcF99k4itfpcfFB76jJd8Aww4ey6+keJNxd0YHv7L+fLPESeYCg8qtvaWvTLCYjP4pU AHJWz3e5X3Assxd85GrMTL+1kUbrl18mWO/taSKtr2C/GJcE0hekg0CKJdtIH4l1LJI3Bgm1lS5Nid Swf2dx9A053mUy0OUIKsTZmi+hdMrA3L1+CqXrqt9aklZh8HZL9Q9/VnxDiTMtOuaraiV/P3XjYc/r /xTL/LpViys99gCXKcLMH97Z9h+t1ulrXarzaQXu1KbLiYcdW70fhS26HlgsHuXWt0NfhOJ83tGbw7 WS6wdzi4Qb5RfWsDu5I+cL+Ltv4MNu
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

icc_provider_del() already emits an error message on failure. In this
case letting .remove() return the corresponding error code results in
another error message and the device is removed anyhow. (See
platform_remove().)

So ignore the return value of icc_provider_del() and return 0
unconditionally.

This is a preparation for making platform remove callbacks return void.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/interconnect/qcom/msm8974.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/msm8974.c b/drivers/interconnect/qcom/msm8974.c
index 6fa0ad90fc3d..5ea192f1141d 100644
--- a/drivers/interconnect/qcom/msm8974.c
+++ b/drivers/interconnect/qcom/msm8974.c
@@ -749,7 +749,9 @@ static int msm8974_icc_remove(struct platform_device *pdev)
 
 	icc_nodes_remove(&qp->provider);
 	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
-	return icc_provider_del(&qp->provider);
+	icc_provider_del(&qp->provider);
+
+	return 0;
 }
 
 static const struct of_device_id msm8974_noc_of_match[] = {
-- 
2.36.1

