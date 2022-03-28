Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FF94E8C33
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 04:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237627AbiC1CcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 22:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237611AbiC1CcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 22:32:09 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103833EB82;
        Sun, 27 Mar 2022 19:30:29 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E0C411A2337;
        Mon, 28 Mar 2022 04:30:27 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A8D621A2331;
        Mon, 28 Mar 2022 04:30:27 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 969A0183AD0B;
        Mon, 28 Mar 2022 10:30:26 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com
Subject: [PATCH v2 2/2] remoteproc: core: Move state checking to remoteproc_core
Date:   Mon, 28 Mar 2022 10:20:12 +0800
Message-Id: <1648434012-16655-3-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1648434012-16655-1-git-send-email-shengjiu.wang@nxp.com>
References: <1648434012-16655-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no mutex protection of these state checking for 'stop'
and 'detach' which can't guarantee there is no another instance
is trying to do same operation.

Consider two instances case:
Instance1: echo stop > /sys/class/remoteproc/remoteproc0/state
Instance2: echo stop > /sys/class/remoteproc/remoteproc0/state

The issue is that the instance2 case may success, Or it
may fail with -EINVAL, which is uncertain.

So move this state checking in rproc_cdev_write() and
state_store() for 'stop', 'detach' operation to
'rproc_shutdown' , 'rproc_detach' function under the mutex
protection.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 drivers/remoteproc/remoteproc_cdev.c  |  7 -------
 drivers/remoteproc/remoteproc_core.c  | 11 +++++++++++
 drivers/remoteproc/remoteproc_sysfs.c |  7 -------
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_cdev.c b/drivers/remoteproc/remoteproc_cdev.c
index 62001eda780c..687f205fd70a 100644
--- a/drivers/remoteproc/remoteproc_cdev.c
+++ b/drivers/remoteproc/remoteproc_cdev.c
@@ -34,15 +34,8 @@ static ssize_t rproc_cdev_write(struct file *filp, const char __user *buf, size_
 	if (!strncmp(cmd, "start", len)) {
 		ret = rproc_boot(rproc);
 	} else if (!strncmp(cmd, "stop", len)) {
-		if (rproc->state != RPROC_RUNNING &&
-		    rproc->state != RPROC_ATTACHED)
-			return -EINVAL;
-
 		ret = rproc_shutdown(rproc);
 	} else if (!strncmp(cmd, "detach", len)) {
-		if (rproc->state != RPROC_ATTACHED)
-			return -EINVAL;
-
 		ret = rproc_detach(rproc);
 	} else {
 		dev_err(&rproc->dev, "Unrecognized option\n");
diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index c510125769b9..4b344d7271e3 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -2075,6 +2075,12 @@ int rproc_shutdown(struct rproc *rproc)
 		return ret;
 	}
 
+	if (rproc->state != RPROC_RUNNING &&
+	    rproc->state != RPROC_ATTACHED) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	/* if the remote proc is still needed, bail out */
 	if (!atomic_dec_and_test(&rproc->power))
 		goto out;
@@ -2134,6 +2140,11 @@ int rproc_detach(struct rproc *rproc)
 		return ret;
 	}
 
+	if (rproc->state != RPROC_ATTACHED) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	/* if the remote proc is still needed, bail out */
 	if (!atomic_dec_and_test(&rproc->power)) {
 		ret = 0;
diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index ac64d69085ab..8c7ea8922638 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -198,15 +198,8 @@ static ssize_t state_store(struct device *dev,
 		if (ret)
 			dev_err(&rproc->dev, "Boot failed: %d\n", ret);
 	} else if (sysfs_streq(buf, "stop")) {
-		if (rproc->state != RPROC_RUNNING &&
-		    rproc->state != RPROC_ATTACHED)
-			return -EINVAL;
-
 		ret = rproc_shutdown(rproc);
 	} else if (sysfs_streq(buf, "detach")) {
-		if (rproc->state != RPROC_ATTACHED)
-			return -EINVAL;
-
 		ret = rproc_detach(rproc);
 	} else {
 		dev_err(&rproc->dev, "Unrecognised option: %s\n", buf);
-- 
2.17.1

