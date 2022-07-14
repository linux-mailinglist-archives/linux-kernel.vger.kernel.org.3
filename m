Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7C0575726
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 23:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240513AbiGNVpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 17:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiGNVpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 17:45:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37216F7C0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 14:45:43 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oC6eU-0008JV-3X; Thu, 14 Jul 2022 23:45:42 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oC6eT-000zKG-5p; Thu, 14 Jul 2022 23:45:41 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oC6eS-005Djk-F7; Thu, 14 Jul 2022 23:45:40 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] pcmcia: sa1100: Make sa11x0_drv_pcmcia_legacy_remove() return void
Date:   Thu, 14 Jul 2022 23:45:34 +0200
Message-Id: <20220714214534.63517-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1617; h=from:subject; bh=/KOsnQwcJQVul4wMzQAkJkQgZTHjXHM4GxuzMgZHL1U=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBi0I569TxNv3HYoElZc4+pNv/N2YOMXVuT93gDKAID G4FwQDaJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYtCOegAKCRDB/BR4rcrsCRTyCA CgnIgi+VonYXuvbkCdcqh+cyc24vNYs8Q5lIsEQQfymaN6V2G5tk82VmjclsN5LjRkFIRWTfoEOFfP yHUtm2UDzJaJmX1IXYO1zVOeibblusd7KGaO+uDevXb2QU8+hogcWwK4ybFvJVgeNCg1tyfIaHomOe 0vfsO+6vmEe6OULTq+rQBagUF0hvvu3SUIXc8sLQvP+c8K8KvKqB78cibJE3+9toA49/rXE5fCXs0j ozBeO31236HRaLx4som/DnP0rtzmdratSUXT19p3eUyEjSh4ffCWcVMvsS5Z7V3Mxpg/UDnctkZS/3 tq7zAPCdnkhZ0Z/feC0x9Ps6pe8hnl
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sa11x0_drv_pcmcia_legacy_remove() returns zero unconditionally. Letting it
return void instead makes it easier to see in the caller that there is no
error to handle.

This is a preparation for making platform remove callbacks return void.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pcmcia/sa1100_generic.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pcmcia/sa1100_generic.c b/drivers/pcmcia/sa1100_generic.c
index 47b060c57418..c2b6e828c2c6 100644
--- a/drivers/pcmcia/sa1100_generic.c
+++ b/drivers/pcmcia/sa1100_generic.c
@@ -125,7 +125,7 @@ static int sa11x0_drv_pcmcia_legacy_probe(struct platform_device *dev)
 	return ret;
 }
 
-static int sa11x0_drv_pcmcia_legacy_remove(struct platform_device *dev)
+static void sa11x0_drv_pcmcia_legacy_remove(struct platform_device *dev)
 {
 	struct skt_dev_info *sinfo = platform_get_drvdata(dev);
 	int i;
@@ -134,8 +134,6 @@ static int sa11x0_drv_pcmcia_legacy_remove(struct platform_device *dev)
 
 	for (i = 0; i < sinfo->nskt; i++)
 		soc_pcmcia_remove_one(&sinfo->skt[i]);
-
-	return 0;
 }
 
 static int sa11x0_drv_pcmcia_probe(struct platform_device *pdev)
@@ -167,8 +165,10 @@ static int sa11x0_drv_pcmcia_remove(struct platform_device *dev)
 {
 	struct soc_pcmcia_socket *skt;
 
-	if (dev->id == -1)
-		return sa11x0_drv_pcmcia_legacy_remove(dev);
+	if (dev->id == -1) {
+		sa11x0_drv_pcmcia_legacy_remove(dev);
+		return 0;
+	}
 
 	skt = platform_get_drvdata(dev);
 

base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
2.36.1

