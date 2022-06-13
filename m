Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628B05499E9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbiFMRZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240438AbiFMRZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:25:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 691CB129C05;
        Mon, 13 Jun 2022 05:43:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4104215A1;
        Mon, 13 Jun 2022 05:43:48 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.35.216])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 26B143F73B;
        Mon, 13 Jun 2022 05:43:46 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, viresh.kumar@linaro.org, rafael@kernel.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mingo@redhat.com
Subject: [PATCH v2 4/4] thermal: devfreq_cooling: Extend the devfreq_cooling_device with ops
Date:   Mon, 13 Jun 2022 13:43:27 +0100
Message-Id: <20220613124327.30766-5-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220613124327.30766-1-lukasz.luba@arm.com>
References: <20220613124327.30766-1-lukasz.luba@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded global variable devfreq_cooling_ops which is used only
as a copy pattern. Instead, extend the struct devfreq_cooling_device with
the needed ops structure. This also simplifies the allocation/free code
during the setup/cleanup.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/devfreq_cooling.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index 8c76f9655e57..67b618b1afc8 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -28,6 +28,7 @@
  * struct devfreq_cooling_device - Devfreq cooling device
  *		devfreq_cooling_device registered.
  * @cdev:	Pointer to associated thermal cooling device.
+ * @cooling_ops: devfreq callbacks to thermal cooling device ops
  * @devfreq:	Pointer to associated devfreq device.
  * @cooling_state:	Current cooling state.
  * @freq_table:	Pointer to a table with the frequencies sorted in descending
@@ -48,6 +49,7 @@
  */
 struct devfreq_cooling_device {
 	struct thermal_cooling_device *cdev;
+	struct thermal_cooling_device_ops cooling_ops;
 	struct devfreq *devfreq;
 	unsigned long cooling_state;
 	u32 *freq_table;
@@ -290,12 +292,6 @@ static int devfreq_cooling_power2state(struct thermal_cooling_device *cdev,
 	return 0;
 }
 
-static struct thermal_cooling_device_ops devfreq_cooling_ops = {
-	.get_max_state = devfreq_cooling_get_max_state,
-	.get_cur_state = devfreq_cooling_get_cur_state,
-	.set_cur_state = devfreq_cooling_set_cur_state,
-};
-
 /**
  * devfreq_cooling_gen_tables() - Generate frequency table.
  * @dfc:	Pointer to devfreq cooling device.
@@ -363,18 +359,18 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
 	char *name;
 	int err, num_opps;
 
-	ops = kmemdup(&devfreq_cooling_ops, sizeof(*ops), GFP_KERNEL);
-	if (!ops)
-		return ERR_PTR(-ENOMEM);
 
 	dfc = kzalloc(sizeof(*dfc), GFP_KERNEL);
-	if (!dfc) {
-		err = -ENOMEM;
-		goto free_ops;
-	}
+	if (!dfc)
+		return ERR_PTR(-ENOMEM);
 
 	dfc->devfreq = df;
 
+	ops = &dfc->cooling_ops;
+	ops->get_max_state = devfreq_cooling_get_max_state;
+	ops->get_cur_state = devfreq_cooling_get_cur_state;
+	ops->set_cur_state = devfreq_cooling_set_cur_state;
+
 	em = em_pd_get(dev);
 	if (em && !em_is_artificial(em)) {
 		dfc->em_pd = em;
@@ -437,8 +433,6 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
 	kfree(dfc->freq_table);
 free_dfc:
 	kfree(dfc);
-free_ops:
-	kfree(ops);
 
 	return ERR_PTR(err);
 }
@@ -520,13 +514,11 @@ EXPORT_SYMBOL_GPL(devfreq_cooling_em_register);
 void devfreq_cooling_unregister(struct thermal_cooling_device *cdev)
 {
 	struct devfreq_cooling_device *dfc;
-	const struct thermal_cooling_device_ops *ops;
 	struct device *dev;
 
 	if (IS_ERR_OR_NULL(cdev))
 		return;
 
-	ops = cdev->ops;
 	dfc = cdev->devdata;
 	dev = dfc->devfreq->dev.parent;
 
@@ -537,6 +529,5 @@ void devfreq_cooling_unregister(struct thermal_cooling_device *cdev)
 
 	kfree(dfc->freq_table);
 	kfree(dfc);
-	kfree(ops);
 }
 EXPORT_SYMBOL_GPL(devfreq_cooling_unregister);
-- 
2.17.1

