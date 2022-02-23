Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420814C0DFD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 09:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238919AbiBWIEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 03:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbiBWIEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 03:04:13 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFB979C6D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 00:03:46 -0800 (PST)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nMmci-0008Hg-S5; Wed, 23 Feb 2022 09:03:44 +0100
Received: from sha by dude02.hi.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1nMmci-00Fbls-Ar; Wed, 23 Feb 2022 09:03:44 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, kernel@pengutronix.de,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: [PATCH] PM: domains: use dev_err_probe() to simplify error handling
Date:   Wed, 23 Feb 2022 09:03:23 +0100
Message-Id: <20220223080323.3717853-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: sha@pengutronix.de
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

From: Ahmad Fatoum <a.fatoum@pengutronix.de>

dev_err_probe() can reduce code size, makes the code easier to read
and has the added benefit of recording the defer reason for later
read out. Use it where appropriate.

This also fixes an issue, where an error message in __genpd_dev_pm_attach
was not terminated by a line break.

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 drivers/base/power/domain.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 5db704f02e712..29428ae91349d 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2248,12 +2248,8 @@ int of_genpd_add_provider_simple(struct device_node *np,
 	/* Parse genpd OPP table */
 	if (genpd->set_performance_state) {
 		ret = dev_pm_opp_of_add_table(&genpd->dev);
-		if (ret) {
-			if (ret != -EPROBE_DEFER)
-				dev_err(&genpd->dev, "Failed to add OPP table: %d\n",
-					ret);
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(&genpd->dev, ret, "Failed to add OPP table\n");
 
 		/*
 		 * Save table for faster processing while setting performance
@@ -2312,9 +2308,8 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 		if (genpd->set_performance_state) {
 			ret = dev_pm_opp_of_add_table_indexed(&genpd->dev, i);
 			if (ret) {
-				if (ret != -EPROBE_DEFER)
-					dev_err(&genpd->dev, "Failed to add OPP table for index %d: %d\n",
-						i, ret);
+				dev_err_probe(&genpd->dev, ret,
+					      "Failed to add OPP table for index %d\n", i);
 				goto error;
 			}
 
@@ -2672,12 +2667,8 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 	ret = genpd_add_device(pd, dev, base_dev);
 	mutex_unlock(&gpd_list_lock);
 
-	if (ret < 0) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to add to PM domain %s: %d",
-				pd->name, ret);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to add to PM domain %s\n", pd->name);
 
 	dev->pm_domain->detach = genpd_dev_pm_detach;
 	dev->pm_domain->sync = genpd_dev_pm_sync;
-- 
2.30.2

