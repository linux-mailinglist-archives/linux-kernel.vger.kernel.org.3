Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C577D4C5EDF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 21:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbiB0U5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 15:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiB0U5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 15:57:01 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3A9A31222
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 12:56:23 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF331106F;
        Sun, 27 Feb 2022 12:56:23 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 509053F66F;
        Sun, 27 Feb 2022 12:56:22 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        peter.hilber@opensynergy.com, cristian.marussi@arm.com
Subject: [RFC PATCH 01/16] firmware: arm_scmi: Simplify scmi_devm_notifier_unregister
Date:   Sun, 27 Feb 2022 20:55:53 +0000
Message-Id: <20220227205608.30812-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220227205608.30812-1-cristian.marussi@arm.com>
References: <20220227205608.30812-1-cristian.marussi@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unregistering SCMI notifications using the managed devres interface can be
done providing as a reference simply the previously successfully registered
notification block since it could have been registered only on one kernel
notification_chain: drop any reference to SCMI protocol, events and
sources.

Devres internal helpers can search for the provided notification block
reference and, once found, the associated devres object will already
provide the above SCMI references for the event.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/notify.c | 30 ++++--------------------------
 include/linux/scmi_protocol.h      |  2 --
 2 files changed, 4 insertions(+), 28 deletions(-)

diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
index 0efd20cd9d69..7d0b01b59616 100644
--- a/drivers/firmware/arm_scmi/notify.c
+++ b/drivers/firmware/arm_scmi/notify.c
@@ -1498,17 +1498,12 @@ static int scmi_devm_notifier_register(struct scmi_device *sdev,
 static int scmi_devm_notifier_match(struct device *dev, void *res, void *data)
 {
 	struct scmi_notifier_devres *dres = res;
-	struct scmi_notifier_devres *xres = data;
+	struct notifier_block *nb = data;
 
-	if (WARN_ON(!dres || !xres))
+	if (WARN_ON(!dres || !nb))
 		return 0;
 
-	return dres->proto_id == xres->proto_id &&
-		dres->evt_id == xres->evt_id &&
-		dres->nb == xres->nb &&
-		((!dres->src_id && !xres->src_id) ||
-		  (dres->src_id && xres->src_id &&
-		   dres->__src_id == xres->__src_id));
+	return dres->nb == nb;
 }
 
 /**
@@ -1516,10 +1511,6 @@ static int scmi_devm_notifier_match(struct device *dev, void *res, void *data)
  * notifier_block for an event
  * @sdev: A reference to an scmi_device whose embedded struct device is to
  *	  be used for devres accounting.
- * @proto_id: Protocol ID
- * @evt_id: Event ID
- * @src_id: Source ID, when NULL register for events coming form ALL possible
- *	    sources
  * @nb: A standard notifier block to register for the specified event
  *
  * Generic devres managed helper to explicitly un-register a notifier_block
@@ -1529,25 +1520,12 @@ static int scmi_devm_notifier_match(struct device *dev, void *res, void *data)
  * Return: 0 on Success
  */
 static int scmi_devm_notifier_unregister(struct scmi_device *sdev,
-					 u8 proto_id, u8 evt_id,
-					 const u32 *src_id,
 					 struct notifier_block *nb)
 {
 	int ret;
-	struct scmi_notifier_devres dres;
-
-	dres.handle = sdev->handle;
-	dres.proto_id = proto_id;
-	dres.evt_id = evt_id;
-	if (src_id) {
-		dres.__src_id = *src_id;
-		dres.src_id = &dres.__src_id;
-	} else {
-		dres.src_id = NULL;
-	}
 
 	ret = devres_release(&sdev->dev, scmi_devm_release_notifier,
-			     scmi_devm_notifier_match, &dres);
+			     scmi_devm_notifier_match, nb);
 
 	WARN_ON(ret);
 
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index b87551f41f9f..b0652f1411b9 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -595,8 +595,6 @@ struct scmi_notify_ops {
 					    const u32 *src_id,
 					    struct notifier_block *nb);
 	int (*devm_event_notifier_unregister)(struct scmi_device *sdev,
-					      u8 proto_id, u8 evt_id,
-					      const u32 *src_id,
 					      struct notifier_block *nb);
 	int (*event_notifier_register)(const struct scmi_handle *handle,
 				       u8 proto_id, u8 evt_id,
-- 
2.17.1

