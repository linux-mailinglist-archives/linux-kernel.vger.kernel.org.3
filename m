Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A0657683A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 22:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiGOUhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 16:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiGOUhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 16:37:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98BF7E82B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 13:37:14 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oCS3Y-0004t7-M3; Fri, 15 Jul 2022 22:37:00 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oCS3X-001BFZ-Tx; Fri, 15 Jul 2022 22:36:59 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oCS3X-005PyG-5g; Fri, 15 Jul 2022 22:36:59 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     kernel@pengutronix.de, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] interconnect: icc-rpmh: Ignore return value of icc_provider_del() in .remove()
Date:   Fri, 15 Jul 2022 22:36:47 +0200
Message-Id: <20220715203652.89912-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220715203652.89912-1-u.kleine-koenig@pengutronix.de>
References: <20220715203652.89912-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1110; h=from:subject; bh=4P7pEEWJE4q945kfcZ1EiPaX1AVcTXRUZ4+IUCb3Z4Q=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBi0c+cv9/JBoqQ4Ftg7dm4gkIhxFUBmOGzdaIgyhvd Ao7XKCOJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYtHPnAAKCRDB/BR4rcrsCVkuB/ 9CbWCt1xsrBlzvz9L90TCYedsAGyrP63SrZmM9+/uss9nnm1F1vUytWY6ZVwNZD2HDhBZbM/HWIZP4 njZsQVe+lnorCju1m7ly1HN5l/fCXnpZJwfIhAuNke6dop7Xce9Fhthx60++c/w3JAptNLOFtFOddZ VINCi2ykjbOYq6wndSeyWR163l5vb7bOqViS7iDNDhaIoqtuPNs8QUFEOuQaEfMyb52D5zOEF9ZxQ7 301yj+VRj4GOVqNZyUG+LOsoKYxpzyL5WsWnbEKcI5KgAWIGmEjmHy3CBVoAK3DsYGMxRUvy0Bg/zd FpocfUQD+T13leFZ/mwjYjs5BNle9Q
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
 drivers/interconnect/qcom/icc-rpmh.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index 3c40076eb5fb..5846dafbe40e 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -271,7 +271,9 @@ int qcom_icc_rpmh_remove(struct platform_device *pdev)
 	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
 
 	icc_nodes_remove(&qp->provider);
-	return icc_provider_del(&qp->provider);
+	icc_provider_del(&qp->provider);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(qcom_icc_rpmh_remove);
 
-- 
2.36.1

