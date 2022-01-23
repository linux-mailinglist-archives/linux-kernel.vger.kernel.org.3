Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF074973D7
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 18:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239394AbiAWRwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 12:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239342AbiAWRwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 12:52:14 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A28FC061748
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 09:52:14 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nBh29-0007aE-Qo; Sun, 23 Jan 2022 18:52:09 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nBh28-00BycB-7D; Sun, 23 Jan 2022 18:52:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nBh26-000tzX-Kp; Sun, 23 Jan 2022 18:52:06 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, Noralf Tronnes <notro@tronnes.org>,
        linux-staging@lists.linux.dev, dri-devel@lists.freedesktop.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 1/5] staging: fbtft: Fix error path in fbtft_driver_module_init()
Date:   Sun, 23 Jan 2022 18:51:57 +0100
Message-Id: <20220123175201.34839-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220123175201.34839-1-u.kleine-koenig@pengutronix.de>
References: <20220123175201.34839-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1472; h=from:subject; bh=i2X5yNCIOCOFDIMQl+gbf/QxZ3EJl4WBdI8+Ry87svQ=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBh7ZWrOh19itJwy3A6u3yWbUTSiEplUaCg/AdalVp/ 1dxUs4SJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYe2VqwAKCRDB/BR4rcrsCcnVCA CGzmOKybWQk3bG9qPzyrR4sinHLhsqEKAvXaLEm5q8uy0OpszNQ7nW1a0QM6JkRi3oCfPUu6EgwGl0 Te30YS0YHfiZzBt2r5ajXFNJChzYJwr2BcogYA4ep+/F6Y4S2zkX/zZ7rAeh4qRPXj1A5SyHvrSvTW wMihZM7kIOX4GbOy++5PGjG/Bojb0MFgVoHuEemX7mkjQ4FEE0kYBDL1+FY4yVAnn8NrTGg2EyFbRY ePWfgrh5brbPbyibSbwh5Uxp5xLiE9CP6vNZzvhGjCSb7CpGAls8G/l1H7743sjHSdn2gBreuYrocS 6AFKf/IGRfm3gnK8hvjx9Oz1/2Db27
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If registering the platform driver fails, the function must not return
without undoing the spi driver registration first.

Fixes: c296d5f9957c ("staging: fbtft: core support")
Link: https://lore.kernel.org/r/20220118181338.207943-1-u.kleine-koenig@pengutronix.de
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/staging/fbtft/fbtft.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index 4cdec34e23d2..55677efc0138 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -334,7 +334,10 @@ static int __init fbtft_driver_module_init(void)                           \
 	ret = spi_register_driver(&fbtft_driver_spi_driver);               \
 	if (ret < 0)                                                       \
 		return ret;                                                \
-	return platform_driver_register(&fbtft_driver_platform_driver);    \
+	ret = platform_driver_register(&fbtft_driver_platform_driver);     \
+	if (ret < 0)                                                       \
+		spi_unregister_driver(&fbtft_driver_spi_driver);           \
+	return ret;                                                        \
 }                                                                          \
 									   \
 static void __exit fbtft_driver_module_exit(void)                          \
-- 
2.34.1

