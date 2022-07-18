Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC475781E7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbiGRMOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbiGRMOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:14:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C052219C2B
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:14:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oDPdg-0005d8-F0; Mon, 18 Jul 2022 14:14:16 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oDPde-001i3u-VS; Mon, 18 Jul 2022 14:14:14 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oDPde-005xVP-84; Mon, 18 Jul 2022 14:14:14 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     kernel@pengutronix.de, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/8] interconnect: icc-rpm: Ignore return value of icc_provider_del() in .remove()
Date:   Mon, 18 Jul 2022 14:14:03 +0200
Message-Id: <20220718121409.171773-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220718121409.171773-1-u.kleine-koenig@pengutronix.de>
References: <20220718121409.171773-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1077; h=from:subject; bh=uiTryKzy9Ktzb3mNysXudEYw9T8hjrPFSFUDOIoCHGE=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBi1U54DBHDAilwBL6MlUFk0KjKJ2pw2UfdD3SolwxQ kIZRiNyJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYtVOeAAKCRDB/BR4rcrsCSWMB/ 9DVXamekMik/9jBrdtZnmwsnE6Wr2RSV+lTWCIWpOg/L2UpBQyHst3hMG4iZejSgB+DNZKgamQ8icg /3aTQNJt2Ve97UjsVNIcWdrWAOouJWqZOvk9VCO8tNq8XYcLD8cQbc4cEYVI51I1pYJcqF0mIV0lYq 5hzPyC9vvwpWTue8sdElCN1uKHwf6bGPDMvfmGe5c4aSnTE6iLkhv17P0IzOTtQLQb9rdYPD6LVWGN CLPpiEkulhAYWXsyXKm9sPXYkCp/SNK1TlXUd9daS99VYGkDDseILdvnur/ucVXptKpe6khCsHUguy kdaKS1pY0QKp85YdQgUvD8gOe8uBy/
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
 drivers/interconnect/qcom/icc-rpm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index fb013191c29b..189c25f8207a 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -447,6 +447,8 @@ int qnoc_remove(struct platform_device *pdev)
 
 	icc_nodes_remove(&qp->provider);
 	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
-	return icc_provider_del(&qp->provider);
+	icc_provider_del(&qp->provider);
+
+	return 0;
 }
 EXPORT_SYMBOL(qnoc_remove);
-- 
2.36.1

