Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F014D6C8D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 05:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiCLFAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 00:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiCLFAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 00:00:31 -0500
Received: from out29-149.mail.aliyun.com (out29-149.mail.aliyun.com [115.124.29.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9C7369FF;
        Fri, 11 Mar 2022 20:59:24 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07676834|-1;BR=01201311R121S41rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00954498-0.000797976-0.989657;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=kant@allwinnertech.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.N2bFlkM_1647061161;
Received: from sunxibot.allwinnertech.com(mailfrom:kant@allwinnertech.com fp:SMTPD_---.N2bFlkM_1647061161)
          by smtp.aliyun-inc.com(10.147.40.233);
          Sat, 12 Mar 2022 12:59:22 +0800
From:   Kant Fan <kant@allwinnertech.com>
To:     rafael@kernel.org (supporter:THERMAL),
        daniel.lezcano@linaro.org (supporter:THERMAL)
Cc:     Kant Fan <kant@allwinnertech.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] thermal: devfreq_cooling: use local ops instead of global ops
Date:   Sat, 12 Mar 2022 12:59:21 +0800
Message-Id: <20220312045922.9779-1-kant@allwinnertech.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix access illegal address problem in following condition:
There are muti devfreq cooling devices in system, some of them has
em model but other does not, energy model ops such as state2power will
append to global devfreq_cooling_ops when the cooling device with
em model register. It makes the cooling device without em model
also use devfreq_cooling_ops after appending when register later by
of_devfreq_cooling_register_power() or of_devfreq_cooling_register().

IPA governor regards the cooling devices without em model as a power actor
because they also have energy model ops, and will access illegal address
at dfc->em_pd when execute cdev->ops->get_requested_power,
cdev->ops->state2power or cdev->ops->power2state.

Signed-off-by: Kant Fan <kant@allwinnertech.com>
---
 drivers/thermal/devfreq_cooling.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index 4310cb342a9f..d38a80adec73 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -358,21 +358,28 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
 	struct thermal_cooling_device *cdev;
 	struct device *dev = df->dev.parent;
 	struct devfreq_cooling_device *dfc;
+	struct thermal_cooling_device_ops *ops;
 	char *name;
 	int err, num_opps;
 
-	dfc = kzalloc(sizeof(*dfc), GFP_KERNEL);
-	if (!dfc)
+	ops = kmemdup(&devfreq_cooling_ops, sizeof(*ops), GFP_KERNEL);
+	if (!ops)
 		return ERR_PTR(-ENOMEM);
 
+	dfc = kzalloc(sizeof(*dfc), GFP_KERNEL);
+	if (!dfc) {
+		err = -ENOMEM;
+		goto free_ops;
+	}
+
 	dfc->devfreq = df;
 
 	dfc->em_pd = em_pd_get(dev);
 	if (dfc->em_pd) {
-		devfreq_cooling_ops.get_requested_power =
+		ops->get_requested_power =
 			devfreq_cooling_get_requested_power;
-		devfreq_cooling_ops.state2power = devfreq_cooling_state2power;
-		devfreq_cooling_ops.power2state = devfreq_cooling_power2state;
+		ops->state2power = devfreq_cooling_state2power;
+		ops->power2state = devfreq_cooling_power2state;
 
 		dfc->power_ops = dfc_power;
 
@@ -407,8 +414,7 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
 	if (!name)
 		goto remove_qos_req;
 
-	cdev = thermal_of_cooling_device_register(np, name, dfc,
-						  &devfreq_cooling_ops);
+	cdev = thermal_of_cooling_device_register(np, name, dfc, ops);
 	kfree(name);
 
 	if (IS_ERR(cdev)) {
@@ -429,6 +435,8 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
 	kfree(dfc->freq_table);
 free_dfc:
 	kfree(dfc);
+free_ops:
+	kfree(ops);
 
 	return ERR_PTR(err);
 }
@@ -510,11 +518,13 @@ EXPORT_SYMBOL_GPL(devfreq_cooling_em_register);
 void devfreq_cooling_unregister(struct thermal_cooling_device *cdev)
 {
 	struct devfreq_cooling_device *dfc;
+	const struct thermal_cooling_device_ops *ops;
 	struct device *dev;
 
 	if (IS_ERR_OR_NULL(cdev))
 		return;
 
+	ops = cdev->ops;
 	dfc = cdev->devdata;
 	dev = dfc->devfreq->dev.parent;
 
@@ -525,5 +535,6 @@ void devfreq_cooling_unregister(struct thermal_cooling_device *cdev)
 
 	kfree(dfc->freq_table);
 	kfree(dfc);
+	kfree(ops);
 }
 EXPORT_SYMBOL_GPL(devfreq_cooling_unregister);
-- 
2.29.0

