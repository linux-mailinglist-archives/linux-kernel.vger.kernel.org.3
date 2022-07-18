Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9B55781EF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbiGRMOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbiGRMO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:14:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BABA23173
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:14:27 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oDPdh-0005d7-6Y; Mon, 18 Jul 2022 14:14:17 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oDPde-001i3q-Sy; Mon, 18 Jul 2022 14:14:14 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oDPde-005xVM-2R; Mon, 18 Jul 2022 14:14:14 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Georgi Djakov <djakov@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/8] interconnect: imx: Ignore return value of icc_provider_del() in .remove()
Date:   Mon, 18 Jul 2022 14:14:02 +0200
Message-Id: <20220718121409.171773-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220718121409.171773-1-u.kleine-koenig@pengutronix.de>
References: <20220718121409.171773-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1010; h=from:subject; bh=5nfrAM364jApg4Q2MKumCrNEZPHrPDHSb2BBL1GlFyE=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBi1U51Bo/VP+y2LBs+bQ2iRcEHbN/g7A/4uFcglu5y qC3AKbSJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYtVOdQAKCRDB/BR4rcrsCZqvB/ 9hWfAifxAcGqp8Uiy8/z98ko8j0zZM/C09D66GMAFl1yTDfz2NvcwV52aphTRMrD8sS2Cgm9Y4r754 fGkfiGs4UlqQ/PAU8pT3aTW0xLWOqnYGEFDdWPtBU9+0aJuRh918sd/Axxf830NM9LgKzYZyRWCCVF fPze1raCc+1o4n/1u/MQ5b0C2paSy20X57zgAF3bgSskWBGhn28pQoHZ/D+pkzYIY5aDQ7gE6LBDdC mmdRkQetYH7MJYQsIQmsiG9bWeNSroz58NjYOSfS1XAZnW3X1eCmH7TH/E6KeqKabAQNSR9IZrMCRq j7u0merMlnMVnsbyv2XpZxZVMpEo5J
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
 drivers/interconnect/imx/imx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
index 249ca25d1d55..4c70530e3064 100644
--- a/drivers/interconnect/imx/imx.c
+++ b/drivers/interconnect/imx/imx.c
@@ -280,7 +280,9 @@ int imx_icc_unregister(struct platform_device *pdev)
 
 	imx_icc_unregister_nodes(provider);
 
-	return icc_provider_del(provider);
+	icc_provider_del(provider);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(imx_icc_unregister);
 
-- 
2.36.1

