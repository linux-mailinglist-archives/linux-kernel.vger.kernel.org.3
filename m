Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCE647383E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 00:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244095AbhLMXBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 18:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237229AbhLMXBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 18:01:02 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CD0C061574;
        Mon, 13 Dec 2021 15:01:02 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id q3so29556449wru.5;
        Mon, 13 Dec 2021 15:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ephq20rQt+MOngFtWVtlg58TGs+92rcxlnvsoir2Wzs=;
        b=nPstnvqAz4ADugRknu1btzvImsrQCxQ7Pzz6SqBDP739cRCnOX9JpmB97V1i17T4d6
         nroPOYJg5SXIamySda/Z3Rxs/+g/QjftOA8uZso7drWOScZqTrgFPNfgcv/nLpjiF5hR
         z/gNDuUjviON9CrLzb2ZQuIdm61jXwlqYTvSrKpstW/4u9ngBtKcGq1Mz/fBqVVOiobS
         rbcZKUn3cEMqOUeP8DNP9H0W6sdOhvCC237jThL3aVNQmpxUPgcP4E4r83w+9E468vgX
         Ebno+MN8h6vsBorqmv/fwy6Bo2xgrAegyoJ0sLQ8L/ONimfiOkEPeWcFvBi7NQcBLlsJ
         qfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ephq20rQt+MOngFtWVtlg58TGs+92rcxlnvsoir2Wzs=;
        b=vx/DvhoECRfmk3xyIrRgRV4m3k1cI+Jw3+tBdcmyKwQLWmsysI6UOICJHhFYb1a8lx
         22QGXzQFaSPWDT0yC9Ur6ObB+VlGRBgf7kJDj4par+7+UvRYQgGEy6E9/j60fYiwBKDI
         TKq5FWiEjvF1XADx6ZWU1HMLgLrrv+uweaZC2BJrX1E5j61fWlvswruwDMKzsOw7r5eZ
         ZD55YL2wH9yxbw6hjgGQaQd+b1hRHAqYRnCA5fZPaLmH+eQOD7JWqOY5hyyzag3rXx4n
         dXxwh9E2tJ6OMVlYkBQ5K4eWnCA4KK/OpJae0rdyntPdThXJTH1pf28Dx00id9ZNlnDx
         ExJA==
X-Gm-Message-State: AOAM533+SJND+ePSCFf1HcjIyQ8ytoS0s9075t67YT2PX5jDGZOHfuqC
        7k9DpPhRJdskC0iTXe74V8U=
X-Google-Smtp-Source: ABdhPJzfPUaWZPuCTRu1sm4F76wU/r8aqtJ7gNV47GaoyKf5G1YNNvGbWhnrJBIoGtrMkUw9gqI69w==
X-Received: by 2002:adf:c5d1:: with SMTP id v17mr1498475wrg.571.1639436460592;
        Mon, 13 Dec 2021 15:01:00 -0800 (PST)
Received: from ubuntu-laptop.speedport.ip (p200300e94714d5665ac960fd9f7a69e0.dip0.t-ipconnect.de. [2003:e9:4714:d566:5ac9:60fd:9f7a:69e0])
        by smtp.gmail.com with ESMTPSA id q26sm12025586wrc.39.2021.12.13.15.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 15:01:00 -0800 (PST)
From:   Bean Huo <huobean@gmail.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        cang@codeaurora.org, daejun7.park@samsung.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] scsi: ufs: Fix deadlock issue in ufshcd_wait_for_doorbell_clr()
Date:   Tue, 14 Dec 2021 00:00:45 +0100
Message-Id: <20211213230045.492994-1-huobean@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Call shost_for_each_device() with host->host_lock is held will cause
a deadlock situation, which will cause the system to stall (the log
as follow). Fix this issue by narrowing the scope of the lock.

stalls on CPUs/tasks:
all trace:
__switch_to+0x120/0x170
0xffff800011643998
ask dump for CPU 5:
ask:kworker/u16:2   state:R  running task     stack:    0 pid:   80 ppid:     2 flags:0x0000000a
orkqueue: events_unbound async_run_entry_fn
all trace:
__switch_to+0x120/0x170
0x0
ask dump for CPU 6:
ask:kworker/u16:6   state:R  running task     stack:    0 pid:  164 ppid:     2 flags:0x0000000a
orkqueue: events_unbound async_run_entry_fn
all trace:
__switch_to+0x120/0x170
0xffff54e7c4429f80
ask dump for CPU 7:
ask:kworker/u16:4   state:R  running task     stack:    0 pid:  153 ppid:     2 flags:0x0000000a
orkqueue: events_unbound async_run_entry_fn
all trace:
__switch_to+0x120/0x170
blk_mq_run_hw_queue+0x34/0x110
blk_mq_sched_insert_request+0xb0/0x120
blk_execute_rq_nowait+0x68/0x88
blk_execute_rq+0x4c/0xd8
__scsi_execute+0xec/0x1d0
scsi_vpd_inquiry+0x84/0xf0
scsi_get_vpd_buf+0x34/0xb8
scsi_attach_vpd+0x34/0x140
scsi_probe_and_add_lun+0xa6c/0xab8
__scsi_scan_target+0x438/0x4f8
scsi_scan_channel+0x6c/0xa8
scsi_scan_host_selected+0xf0/0x150
do_scsi_scan_host+0x88/0x90
scsi_scan_host+0x1b4/0x1d0
ufshcd_async_scan+0x248/0x310
async_run_entry_fn+0x30/0x178
process_one_work+0x1e8/0x368
worker_thread+0x40/0x478
kthread+0x174/0x180
ret_from_fork+0x10/0x20

Fixes: 8d077ede48c1 ("scsi: ufs: Optimize the command queueing code")
Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/scsi/ufs/ufshcd.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 6dd517267f1b..15333a327b93 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -1099,19 +1099,21 @@ static int ufshcd_wait_for_doorbell_clr(struct ufs_hba *hba,
 	ktime_t start;
 
 	ufshcd_hold(hba, false);
-	spin_lock_irqsave(hba->host->host_lock, flags);
 	/*
 	 * Wait for all the outstanding tasks/transfer requests.
 	 * Verify by checking the doorbell registers are clear.
 	 */
 	start = ktime_get();
 	do {
+		spin_lock_irqsave(hba->host->host_lock, flags);
 		if (hba->ufshcd_state != UFSHCD_STATE_OPERATIONAL) {
 			ret = -EBUSY;
+			spin_unlock_irqrestore(hba->host->host_lock, flags);
 			goto out;
 		}
-
 		tm_doorbell = ufshcd_readl(hba, REG_UTP_TASK_REQ_DOOR_BELL);
+		spin_unlock_irqrestore(hba->host->host_lock, flags);
+
 		tr_pending = ufshcd_pending_cmds(hba);
 		if (!tm_doorbell && !tr_pending) {
 			timeout = false;
@@ -1120,7 +1122,6 @@ static int ufshcd_wait_for_doorbell_clr(struct ufs_hba *hba,
 			break;
 		}
 
-		spin_unlock_irqrestore(hba->host->host_lock, flags);
 		schedule();
 		if (ktime_to_us(ktime_sub(ktime_get(), start)) >
 		    wait_timeout_us) {
@@ -1132,7 +1133,6 @@ static int ufshcd_wait_for_doorbell_clr(struct ufs_hba *hba,
 			 */
 			do_last_check = true;
 		}
-		spin_lock_irqsave(hba->host->host_lock, flags);
 	} while (tm_doorbell || tr_pending);
 
 	if (timeout) {
@@ -1142,7 +1142,6 @@ static int ufshcd_wait_for_doorbell_clr(struct ufs_hba *hba,
 		ret = -EBUSY;
 	}
 out:
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
 	ufshcd_release(hba);
 	return ret;
 }
-- 
2.25.1

