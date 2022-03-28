Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E034E8C35
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 04:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237623AbiC1CcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 22:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237599AbiC1CcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 22:32:09 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F093EAB2;
        Sun, 27 Mar 2022 19:30:29 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C28D12018FC;
        Mon, 28 Mar 2022 04:30:27 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8AE912018FF;
        Mon, 28 Mar 2022 04:30:27 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 0530C183ACCB;
        Mon, 28 Mar 2022 10:30:25 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com
Subject: [PATCH v2 1/2] remoteproc: core: Remove state checking before calling rproc_boot()
Date:   Mon, 28 Mar 2022 10:20:11 +0800
Message-Id: <1648434012-16655-2-git-send-email-shengjiu.wang@nxp.com>
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

There is no mutex protection of the state checking before rproc_boot(),
which can't guarantee there is no another instance is trying to do
same operation.

Consider two instances case:
Instance1: echo start > /sys/class/remoteproc/remoteproc0/state
Instance2: echo start > /sys/class/remoteproc/remoteproc0/state
...
Instance2: echo stop > /sys/class/remoteproc/remoteproc0/state
...
Instance1: echo stop > /sys/class/remoteproc/remoteproc0/state

The one issue is that the instance2 case may success when 'start'
happens at same time as instance1, then rproc->power = 2; Or it
may fail with -BUSY, then rproc->power = 1; which is uncertain.

The another issue is for 'stop' operation, if the rproc->power = 1,
when instance2 'stop' the remoteproc the instance1 will be
impacted for it still needs the service at that time.

The reference counter rproc->power is used to manage state
changing and there is mutex protection in each operation
function for multi instance case.

So remove this state checking in rproc_cdev_write() and
state_store() for 'start' operation, just let reference
counter rproc->power to manage the behaviors.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 drivers/remoteproc/remoteproc_cdev.c  | 4 ----
 drivers/remoteproc/remoteproc_sysfs.c | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_cdev.c b/drivers/remoteproc/remoteproc_cdev.c
index 906ff3c4dfdd..62001eda780c 100644
--- a/drivers/remoteproc/remoteproc_cdev.c
+++ b/drivers/remoteproc/remoteproc_cdev.c
@@ -32,10 +32,6 @@ static ssize_t rproc_cdev_write(struct file *filp, const char __user *buf, size_
 		return -EFAULT;
 
 	if (!strncmp(cmd, "start", len)) {
-		if (rproc->state == RPROC_RUNNING ||
-		    rproc->state == RPROC_ATTACHED)
-			return -EBUSY;
-
 		ret = rproc_boot(rproc);
 	} else if (!strncmp(cmd, "stop", len)) {
 		if (rproc->state != RPROC_RUNNING &&
diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index 51a04bc6ba7a..ac64d69085ab 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -194,10 +194,6 @@ static ssize_t state_store(struct device *dev,
 	int ret = 0;
 
 	if (sysfs_streq(buf, "start")) {
-		if (rproc->state == RPROC_RUNNING ||
-		    rproc->state == RPROC_ATTACHED)
-			return -EBUSY;
-
 		ret = rproc_boot(rproc);
 		if (ret)
 			dev_err(&rproc->dev, "Boot failed: %d\n", ret);
-- 
2.17.1

