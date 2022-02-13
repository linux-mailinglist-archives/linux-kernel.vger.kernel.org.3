Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F5E4B3D31
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 20:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238050AbiBMTtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 14:49:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbiBMTtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 14:49:04 -0500
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC33339695
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 11:48:57 -0800 (PST)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id JKrendyPyuvBOJKrenOULd; Sun, 13 Feb 2022 20:48:56 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 13 Feb 2022 20:48:56 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Iwona Winiarska <iwona.winiarska@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-hwmon@vger.kernel.org
Subject: [PATCH] hwmon: peci: Use devm_delayed_work_autocancel() to simplify code
Date:   Sun, 13 Feb 2022 20:48:53 +0100
Message-Id: <fd277a708ede3882d7df6831f02d2e3c0cb813b8.1644781718.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_delayed_work_autocancel() instead of hand writing it. This is
less verbose and saves a few lines of code.

devm_delayed_work_autocancel() uses devm_add_action() instead of
devm_add_action_or_reset(). This is fine, because if the underlying memory
allocation fails, no work has been scheduled yet. So there is nothing to
undo.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/hwmon/peci/dimmtemp.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/peci/dimmtemp.c b/drivers/hwmon/peci/dimmtemp.c
index c8222354c005..96b9919db357 100644
--- a/drivers/hwmon/peci/dimmtemp.c
+++ b/drivers/hwmon/peci/dimmtemp.c
@@ -4,6 +4,7 @@
 #include <linux/auxiliary_bus.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/devm-helpers.h>
 #include <linux/hwmon.h>
 #include <linux/jiffies.h>
 #include <linux/module.h>
@@ -378,13 +379,6 @@ static void create_dimm_temp_info_delayed(struct work_struct *work)
 		dev_err(priv->dev, "Failed to populate DIMM temp info\n");
 }
 
-static void remove_delayed_work(void *_priv)
-{
-	struct peci_dimmtemp *priv = _priv;
-
-	cancel_delayed_work_sync(&priv->detect_work);
-}
-
 static int peci_dimmtemp_probe(struct auxiliary_device *adev, const struct auxiliary_device_id *id)
 {
 	struct device *dev = &adev->dev;
@@ -415,9 +409,8 @@ static int peci_dimmtemp_probe(struct auxiliary_device *adev, const struct auxil
 			 "Unexpected PECI revision %#x, some features may be unavailable\n",
 			 peci_dev->info.peci_revision);
 
-	INIT_DELAYED_WORK(&priv->detect_work, create_dimm_temp_info_delayed);
-
-	ret = devm_add_action_or_reset(priv->dev, remove_delayed_work, priv);
+	ret = devm_delayed_work_autocancel(priv->dev, &priv->detect_work,
+					   create_dimm_temp_info_delayed);
 	if (ret)
 		return ret;
 
-- 
2.32.0

