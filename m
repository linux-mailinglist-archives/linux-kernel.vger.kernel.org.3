Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E65B5855A6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 21:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238520AbiG2Tmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 15:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237395AbiG2TmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 15:42:25 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB976D54E;
        Fri, 29 Jul 2022 12:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1659123743;
        bh=yfpz3eZOzFusdrvGSIrT5vP213KUwZ2IU/B7Jq1m2iQ=;
        h=Message-ID:Subject:From:To:Date:From;
        b=KK3XAgAB8W4tAkjRvqN1BO9jOs9hZ0tMpFS434sVoLyHzr9g+4dWtL86JnlzpewvK
         fNb7/wWYWoY3ja6jEypBk/Mji/qcrdeykIj/GvugE8tpNSt41jD7UtjF75rc/o+TAl
         B9N7pa9jEb0+OAKHTcKLTxwf5DPqdG2G/J3uoPq0=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 66E8E1280728;
        Fri, 29 Jul 2022 15:42:23 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sAM1TJKT386L; Fri, 29 Jul 2022 15:42:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1659123743;
        bh=yfpz3eZOzFusdrvGSIrT5vP213KUwZ2IU/B7Jq1m2iQ=;
        h=Message-ID:Subject:From:To:Date:From;
        b=KK3XAgAB8W4tAkjRvqN1BO9jOs9hZ0tMpFS434sVoLyHzr9g+4dWtL86JnlzpewvK
         fNb7/wWYWoY3ja6jEypBk/Mji/qcrdeykIj/GvugE8tpNSt41jD7UtjF75rc/o+TAl
         B9N7pa9jEb0+OAKHTcKLTxwf5DPqdG2G/J3uoPq0=
Received: from [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b] (unknown [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id DB6A61280614;
        Fri, 29 Jul 2022 15:42:22 -0400 (EDT)
Message-ID: <d3a4b15f5eab509f9830f858a82f0db394d201db.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 5.19-rc8
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 29 Jul 2022 15:42:21 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Four fixes, three in drivers.  The two biggest fixes are ufs and the
remaining driver and core fix are small and obvious (and the core fix
is low risk).

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Bart Van Assche (1):
      scsi: ufs: core: Fix a race condition related to device management

David Jeffery (1):
      scsi: mpt3sas: Stop fw fault watchdog work item during system shutdown

Jason Yan (1):
      scsi: core: Fix warning in scsi_alloc_sgtables()

Liang He (1):
      scsi: ufs: host: Hold reference returned by of_parse_phandle()

And the diffstat:

 drivers/scsi/mpt3sas/mpt3sas_scsih.c |  1 +
 drivers/scsi/scsi_ioctl.c            |  2 +-
 drivers/ufs/core/ufshcd.c            | 58 +++++++++++++++++++++++++-----------
 drivers/ufs/host/ufshcd-pltfrm.c     | 15 ++++++++--
 4 files changed, 55 insertions(+), 21 deletions(-)

With full diff below.

James

---
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index b519f4b59d30..5e8887fa02c8 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -11386,6 +11386,7 @@ scsih_shutdown(struct pci_dev *pdev)
 	_scsih_ir_shutdown(ioc);
 	_scsih_nvme_shutdown(ioc);
 	mpt3sas_base_mask_interrupts(ioc);
+	mpt3sas_base_stop_watchdog(ioc);
 	ioc->shost_recovery = 1;
 	mpt3sas_base_make_ioc_ready(ioc, SOFT_RESET);
 	ioc->shost_recovery = 0;
diff --git a/drivers/scsi/scsi_ioctl.c b/drivers/scsi/scsi_ioctl.c
index a480c4d589f5..729e309e6034 100644
--- a/drivers/scsi/scsi_ioctl.c
+++ b/drivers/scsi/scsi_ioctl.c
@@ -450,7 +450,7 @@ static int sg_io(struct scsi_device *sdev, struct sg_io_hdr *hdr, fmode_t mode)
 		goto out_put_request;
 
 	ret = 0;
-	if (hdr->iovec_count) {
+	if (hdr->iovec_count && hdr->dxfer_len) {
 		struct iov_iter i;
 		struct iovec *iov = NULL;
 
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index c7b337480e3e..3d367be71728 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2953,37 +2953,59 @@ ufshcd_dev_cmd_completion(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 static int ufshcd_wait_for_dev_cmd(struct ufs_hba *hba,
 		struct ufshcd_lrb *lrbp, int max_timeout)
 {
-	int err = 0;
-	unsigned long time_left;
+	unsigned long time_left = msecs_to_jiffies(max_timeout);
 	unsigned long flags;
+	bool pending;
+	int err;
 
+retry:
 	time_left = wait_for_completion_timeout(hba->dev_cmd.complete,
-			msecs_to_jiffies(max_timeout));
+						time_left);
 
-	spin_lock_irqsave(hba->host->host_lock, flags);
-	hba->dev_cmd.complete = NULL;
 	if (likely(time_left)) {
+		/*
+		 * The completion handler called complete() and the caller of
+		 * this function still owns the @lrbp tag so the code below does
+		 * not trigger any race conditions.
+		 */
+		hba->dev_cmd.complete = NULL;
 		err = ufshcd_get_tr_ocs(lrbp);
 		if (!err)
 			err = ufshcd_dev_cmd_completion(hba, lrbp);
-	}
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
-
-	if (!time_left) {
+	} else {
 		err = -ETIMEDOUT;
 		dev_dbg(hba->dev, "%s: dev_cmd request timedout, tag %d\n",
 			__func__, lrbp->task_tag);
-		if (!ufshcd_clear_cmds(hba, 1U << lrbp->task_tag))
+		if (ufshcd_clear_cmds(hba, 1U << lrbp->task_tag) == 0) {
 			/* successfully cleared the command, retry if needed */
 			err = -EAGAIN;
-		/*
-		 * in case of an error, after clearing the doorbell,
-		 * we also need to clear the outstanding_request
-		 * field in hba
-		 */
-		spin_lock_irqsave(&hba->outstanding_lock, flags);
-		__clear_bit(lrbp->task_tag, &hba->outstanding_reqs);
-		spin_unlock_irqrestore(&hba->outstanding_lock, flags);
+			/*
+			 * Since clearing the command succeeded we also need to
+			 * clear the task tag bit from the outstanding_reqs
+			 * variable.
+			 */
+			spin_lock_irqsave(&hba->outstanding_lock, flags);
+			pending = test_bit(lrbp->task_tag,
+					   &hba->outstanding_reqs);
+			if (pending) {
+				hba->dev_cmd.complete = NULL;
+				__clear_bit(lrbp->task_tag,
+					    &hba->outstanding_reqs);
+			}
+			spin_unlock_irqrestore(&hba->outstanding_lock, flags);
+
+			if (!pending) {
+				/*
+				 * The completion handler ran while we tried to
+				 * clear the command.
+				 */
+				time_left = 1;
+				goto retry;
+			}
+		} else {
+			dev_err(hba->dev, "%s: failed to clear tag %d\n",
+				__func__, lrbp->task_tag);
+		}
 	}
 
 	return err;
diff --git a/drivers/ufs/host/ufshcd-pltfrm.c b/drivers/ufs/host/ufshcd-pltfrm.c
index e7332cc65b1f..173aea8e9997 100644
--- a/drivers/ufs/host/ufshcd-pltfrm.c
+++ b/drivers/ufs/host/ufshcd-pltfrm.c
@@ -108,9 +108,20 @@ static int ufshcd_parse_clock_info(struct ufs_hba *hba)
 	return ret;
 }
 
+static bool phandle_exists(const struct device_node *np,
+			   const char *phandle_name, int index)
+{
+	struct device_node *parse_np = of_parse_phandle(np, phandle_name, index);
+
+	if (parse_np)
+		of_node_put(parse_np);
+
+	return parse_np != NULL;
+}
+
 #define MAX_PROP_SIZE 32
 static int ufshcd_populate_vreg(struct device *dev, const char *name,
-		struct ufs_vreg **out_vreg)
+				struct ufs_vreg **out_vreg)
 {
 	char prop_name[MAX_PROP_SIZE];
 	struct ufs_vreg *vreg = NULL;
@@ -122,7 +133,7 @@ static int ufshcd_populate_vreg(struct device *dev, const char *name,
 	}
 
 	snprintf(prop_name, MAX_PROP_SIZE, "%s-supply", name);
-	if (!of_parse_phandle(np, prop_name, 0)) {
+	if (!phandle_exists(np, prop_name, 0)) {
 		dev_info(dev, "%s: Unable to find %s regulator, assuming enabled\n",
 				__func__, prop_name);
 		goto out;

