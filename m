Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A955781ED
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbiGRMOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbiGRMO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:14:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310C91BEA2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:14:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oDPdg-0005dA-97; Mon, 18 Jul 2022 14:14:16 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oDPdf-001i40-3U; Mon, 18 Jul 2022 14:14:15 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oDPde-005xVS-Cx; Mon, 18 Jul 2022 14:14:14 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     kernel@pengutronix.de, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] interconnect: icc-rpmh: Ignore return value of icc_provider_del() in .remove()
Date:   Mon, 18 Jul 2022 14:14:04 +0200
Message-Id: <20220718121409.171773-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220718121409.171773-1-u.kleine-koenig@pengutronix.de>
References: <20220718121409.171773-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1110; h=from:subject; bh=4P7pEEWJE4q945kfcZ1EiPaX1AVcTXRUZ4+IUCb3Z4Q=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBi1U58v9/JBoqQ4Ftg7dm4gkIhxFUBmOGzdaIgyhvd Ao7XKCOJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYtVOfAAKCRDB/BR4rcrsCZMDB/ 4gsxSFJ6J4Ect7uJmyGCSAhW6HvQlti9VBz89vHEkdEv3D0sF0HcdZGt3SmsK628OYw9GY6rSJzRhB FZNi2gO2pkxX+ABUTmVyVsBCyvxDDWWje0p993HE55zGBo98e0T30e+/PpdxWolDYCpQglu3M7Xab/ ijEVz0sStyFMN5IvhWbQ6x6qMo64VgUlzcirjyfPp7Md27M6iO0Y695W1x2/UnhKGFfh3zNfySzXCV aPE0oKRaJONqIObB0HMY5TWMMNjfVzKfqzrM+zlED4pEix3jnL9QKdGTPiV2F+VbtF3SBo4LEdgbKA i99vMCwFBIYkyepdaL6/o5VSfSsdms
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

