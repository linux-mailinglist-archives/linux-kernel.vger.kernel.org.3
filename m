Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B923E576836
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 22:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiGOUh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 16:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiGOUhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 16:37:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E24087343
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 13:37:16 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oCS3Y-0004t6-GV; Fri, 15 Jul 2022 22:37:00 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oCS3X-001BFV-OD; Fri, 15 Jul 2022 22:36:59 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oCS3W-005PyD-W4; Fri, 15 Jul 2022 22:36:58 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     kernel@pengutronix.de, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] interconnect: icc-rpm: Ignore return value of icc_provider_del() in .remove()
Date:   Fri, 15 Jul 2022 22:36:46 +0200
Message-Id: <20220715203652.89912-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220715203652.89912-1-u.kleine-koenig@pengutronix.de>
References: <20220715203652.89912-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1077; h=from:subject; bh=uiTryKzy9Ktzb3mNysXudEYw9T8hjrPFSFUDOIoCHGE=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBi0c+YDBHDAilwBL6MlUFk0KjKJ2pw2UfdD3SolwxQ kIZRiNyJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYtHPmAAKCRDB/BR4rcrsCYuVB/ 4z8K8ezfAkl8+qkHmofwpyUYVNfhK3T58nW6m/GphCnLfZKkK6dA21kZvxTIPfhwR6hZbWpIcaQRQV 0mVg8SJsKRAOhqpXusufELyekGY5sqtloEI7uoIaE2+m3M5Qtqb/B4uF5b/AhDVvIC9+Z9iJdKv1p/ JGOs2NYVTP8SdlCO69bj1hll0wUu9+j8wnBr5XpEB1TcRrQqxfZclYg8ehBdbD7avKoAJj+rR4qejD NiFPFUJn/HuD9BnIAJIu7yKBQzBuh7CeebvOTlkJHodd2uDRbQIismPUmHTPkTnWuDuK7DoCEYR8+1 b+n80xLTquyBFlN+49uzP0a2lCQJtc
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

