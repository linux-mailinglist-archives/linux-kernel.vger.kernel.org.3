Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D064B3D4A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 21:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238120AbiBMUNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 15:13:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238055AbiBMUNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 15:13:07 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A91E4A912;
        Sun, 13 Feb 2022 12:12:56 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21DKCo2o015311;
        Sun, 13 Feb 2022 14:12:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644783170;
        bh=9irqzYnrEpjWi9U3Xpk+DuQR+/hIGdWOOh9XnlBDeH0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=mqg31rRxFQoh9uwzs82GMt0MYdPhhWfznOUXujfzScP9BPiB9oEvpG9sReET0AjX9
         OtRcQWYqnyKRruiKwRtT2B2XjD5PiBLiSNRE/MDF7kf/AMNm3YWaRtJJMJqA+3CmuQ
         XfVL4RS4YHzTac7dWMvEE8G7Tup6ynevoVe+5Jck=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21DKCogc065496
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 13 Feb 2022 14:12:50 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sun, 13
 Feb 2022 14:12:49 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sun, 13 Feb 2022 14:12:49 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21DKCnQO085417;
        Sun, 13 Feb 2022 14:12:49 -0600
Received: from localhost ([10.249.37.221])
        by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 21DKCnNG002412;
        Sun, 13 Feb 2022 14:12:49 -0600
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Hari Nagalla <hnagalla@ti.com>, Praneeth Bajjuri <praneeth@ti.com>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH v3 1/5] remoteproc: Change rproc_shutdown() to return a status
Date:   Sun, 13 Feb 2022 14:12:42 -0600
Message-ID: <20220213201246.25952-2-s-anna@ti.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220213201246.25952-1-s-anna@ti.com>
References: <20220213201246.25952-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rproc_shutdown() function is currently not returning any
error code, and any failures within rproc_stop() are not passed
back to the users. Change the signature to return a success value
back to the callers.

The remoteproc sysfs and cdev interfaces are also updated to
return back this status to userspace.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
v3:
 - New patch in place of v2 patch "remoteproc: Add support for detach-only 
   during shutdown",  
   https://patchwork.kernel.org/project/linux-remoteproc/patch/20210723220248.6554-2-s-anna@ti.com/

 Documentation/staging/remoteproc.rst  | 3 ++-
 drivers/remoteproc/remoteproc_cdev.c  | 2 +-
 drivers/remoteproc/remoteproc_core.c  | 9 ++++++---
 drivers/remoteproc/remoteproc_sysfs.c | 2 +-
 include/linux/remoteproc.h            | 2 +-
 5 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/Documentation/staging/remoteproc.rst b/Documentation/staging/remoteproc.rst
index 9cccd3dd6a4b..348ee7e508ac 100644
--- a/Documentation/staging/remoteproc.rst
+++ b/Documentation/staging/remoteproc.rst
@@ -49,13 +49,14 @@ might also consider using dev_archdata for this).
 
 ::
 
-  void rproc_shutdown(struct rproc *rproc)
+  int rproc_shutdown(struct rproc *rproc)
 
 Power off a remote processor (previously booted with rproc_boot()).
 In case @rproc is still being used by an additional user(s), then
 this function will just decrement the power refcount and exit,
 without really powering off the device.
 
+Returns 0 on success, and an appropriate error value otherwise.
 Every call to rproc_boot() must (eventually) be accompanied by a call
 to rproc_shutdown(). Calling rproc_shutdown() redundantly is a bug.
 
diff --git a/drivers/remoteproc/remoteproc_cdev.c b/drivers/remoteproc/remoteproc_cdev.c
index 4ad98b0b8caa..906ff3c4dfdd 100644
--- a/drivers/remoteproc/remoteproc_cdev.c
+++ b/drivers/remoteproc/remoteproc_cdev.c
@@ -42,7 +42,7 @@ static ssize_t rproc_cdev_write(struct file *filp, const char __user *buf, size_
 		    rproc->state != RPROC_ATTACHED)
 			return -EINVAL;
 
-		rproc_shutdown(rproc);
+		ret = rproc_shutdown(rproc);
 	} else if (!strncmp(cmd, "detach", len)) {
 		if (rproc->state != RPROC_ATTACHED)
 			return -EINVAL;
diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 69f51acf235e..c510125769b9 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -2061,16 +2061,18 @@ EXPORT_SYMBOL(rproc_boot);
  *   which means that the @rproc handle stays valid even after rproc_shutdown()
  *   returns, and users can still use it with a subsequent rproc_boot(), if
  *   needed.
+ *
+ * Return: 0 on success, and an appropriate error value otherwise
  */
-void rproc_shutdown(struct rproc *rproc)
+int rproc_shutdown(struct rproc *rproc)
 {
 	struct device *dev = &rproc->dev;
-	int ret;
+	int ret = 0;
 
 	ret = mutex_lock_interruptible(&rproc->lock);
 	if (ret) {
 		dev_err(dev, "can't lock rproc %s: %d\n", rproc->name, ret);
-		return;
+		return ret;
 	}
 
 	/* if the remote proc is still needed, bail out */
@@ -2097,6 +2099,7 @@ void rproc_shutdown(struct rproc *rproc)
 	rproc->table_ptr = NULL;
 out:
 	mutex_unlock(&rproc->lock);
+	return ret;
 }
 EXPORT_SYMBOL(rproc_shutdown);
 
diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index ea8b89f97d7b..645c70c8109b 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -206,7 +206,7 @@ static ssize_t state_store(struct device *dev,
 		    rproc->state != RPROC_ATTACHED)
 			return -EINVAL;
 
-		rproc_shutdown(rproc);
+		ret = rproc_shutdown(rproc);
 	} else if (sysfs_streq(buf, "detach")) {
 		if (rproc->state != RPROC_ATTACHED)
 			return -EINVAL;
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index e0600e1e5c17..cfc0c95c95b2 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -669,7 +669,7 @@ rproc_of_resm_mem_entry_init(struct device *dev, u32 of_resm_idx, size_t len,
 			     u32 da, const char *name, ...);
 
 int rproc_boot(struct rproc *rproc);
-void rproc_shutdown(struct rproc *rproc);
+int rproc_shutdown(struct rproc *rproc);
 int rproc_detach(struct rproc *rproc);
 int rproc_set_firmware(struct rproc *rproc, const char *fw_name);
 void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type);
-- 
2.32.0

