Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658CF576830
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 22:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiGOUhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 16:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiGOUhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 16:37:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837077D1F2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 13:37:06 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oCS3Z-0004tT-Ad; Fri, 15 Jul 2022 22:37:01 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oCS3Y-001BFp-Ke; Fri, 15 Jul 2022 22:37:00 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oCS3X-005PyV-Tq; Fri, 15 Jul 2022 22:36:59 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] interconnect: Make icc_provider_del() return void
Date:   Fri, 15 Jul 2022 22:36:51 +0200
Message-Id: <20220715203652.89912-8-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220715203652.89912-1-u.kleine-koenig@pengutronix.de>
References: <20220715203652.89912-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2130; h=from:subject; bh=n7ouJxzj7vqUld5FBMHrGeB81LM5WBQ347j0wY3D8po=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBi0c+prNCY2MkDBjsDbX9CO0306kJbYFPVvfGSc0hD cE/xWRyJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYtHPqQAKCRDB/BR4rcrsCVSfCA CAimBeZMb/So+BHgyWnIp6cAcWPOgbjLmfK20qFBx6OjUobP0sOcc3NL2Qx+oPM+GoAqpPOaonHeuP E03Ci7dgi0EewCsI6UbASjvaoWlei9Izfu4QzPKr4dZCL65H/afgRxsb9e780mD4HacGCoBrN4I8dg 3RgQhNj6JQBGgFq/UpEmAmCwV33L6/khHbfwjIZmo5yA1NImy68ECiwi6RcYr7FMrcsvDURlfI8uiC +LzLwSFNoGhWFxkyb17TMzq3eN9JqeRmQdRhFkax3CaTIfi56hF5s4blWQ+SkQnGiYeC+NR/Vc9lIt TW13nUPqPo2ApNvBMFFSUF1MPQqydi
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

All users ignore the return value of icc_provider_del(). Consequently
make it not return an error code.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/interconnect/core.c           | 10 +++-------
 include/linux/interconnect-provider.h |  2 +-
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 808f6e7a8048..25debded65a8 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -1057,29 +1057,25 @@ EXPORT_SYMBOL_GPL(icc_provider_add);
 /**
  * icc_provider_del() - delete previously added interconnect provider
  * @provider: the interconnect provider that will be removed from topology
- *
- * Return: 0 on success, or an error code otherwise
  */
-int icc_provider_del(struct icc_provider *provider)
+void icc_provider_del(struct icc_provider *provider)
 {
 	mutex_lock(&icc_lock);
 	if (provider->users) {
 		pr_warn("interconnect provider still has %d users\n",
 			provider->users);
 		mutex_unlock(&icc_lock);
-		return -EBUSY;
+		return;
 	}
 
 	if (!list_empty(&provider->nodes)) {
 		pr_warn("interconnect provider still has nodes\n");
 		mutex_unlock(&icc_lock);
-		return -EBUSY;
+		return;
 	}
 
 	list_del(&provider->provider_list);
 	mutex_unlock(&icc_lock);
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(icc_provider_del);
 
diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
index 6bd01f7159c6..191f083d1f3b 100644
--- a/include/linux/interconnect-provider.h
+++ b/include/linux/interconnect-provider.h
@@ -123,7 +123,7 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider);
 void icc_node_del(struct icc_node *node);
 int icc_nodes_remove(struct icc_provider *provider);
 int icc_provider_add(struct icc_provider *provider);
-int icc_provider_del(struct icc_provider *provider);
+void icc_provider_del(struct icc_provider *provider);
 struct icc_node_data *of_icc_get_from_provider(struct of_phandle_args *spec);
 void icc_sync_state(struct device *dev);
 
-- 
2.36.1

