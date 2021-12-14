Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 649E74741FF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 13:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbhLNMFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 07:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbhLNMFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 07:05:53 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C97C061574;
        Tue, 14 Dec 2021 04:05:53 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id k37-20020a05600c1ca500b00330cb84834fso16093897wms.2;
        Tue, 14 Dec 2021 04:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AisZhSfFVt6KKMPS8LBovqjr8Zf98fAlDJTnHrMPr4Y=;
        b=P3/LXQsafEeJG/gYJu0k44bwPuJDR03YUKJkWdBTwtbf1OSi3iCpeVOs+0wXS6FyxE
         ZELDMmPo8vSb21JGNvk6BhOrd+NYBW6lAqgz61p4A1CpIYZL6THqT7lF+2ASy3GOg2NN
         qAYfG/2wXOg0XPztIhEAzdrPfiMM3Chsn/wTjaA2KcXWERfkro/QxWXA2En7c+VazE56
         LYjHc7BgtO30dPFFdtzQhSZgWNBRHbIzjbzG0HGV9EZJs/6Ire172HNGEbe78v5ROoj6
         HJ4QF1DjT+6AxS2nKVcjPhyQ0aBHS8qQovR7POR2vp1CR19xvlz/LxvMIToYTB47fi7g
         ow1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AisZhSfFVt6KKMPS8LBovqjr8Zf98fAlDJTnHrMPr4Y=;
        b=Yr0nVqDAFNWpBgJBrrGT+LPVvU3fRspxmJu56GrzIATEPDWN4BMZhRWyvEsu1Qq1TG
         yiwldtyjuygwcHi2TVvcEzZfLb5QfQHJC+3ruhGZcX3Cdg9b/TvFMJEpPCONFNn2EJAi
         YOG6yazD/rmNn3m66t43GB7hoq4wyXgAy1V0lD/pVXkEn7rchPvrct1LMcY1OMK3LLdT
         MseEM9d46mL+Kwd9AaL8g5Oczo8wC8c5EufWl/r59S77ftaxLYm+ASx6Mf11vfgEVwPN
         M72VNIMF4iRCJb+eaGeOZnf24DFhgp4sU9FeyoWlFj1IseS3BhkGY8TrxK7cygd96B/B
         pFbA==
X-Gm-Message-State: AOAM5336I2ePsbDHawa/olRpK+ZfQl+A5moTScacz2zW3en+YatFrLFk
        MB+GPc4bo990VkDKJG2+0SI=
X-Google-Smtp-Source: ABdhPJyeRfA2JXgEYx8w7LpEPczhty92Xbahhzsxj6gtEk34EQ/Z/IcFDkktWfIeKI9w5QCUobwJng==
X-Received: by 2002:a1c:f70c:: with SMTP id v12mr6439093wmh.18.1639483552144;
        Tue, 14 Dec 2021 04:05:52 -0800 (PST)
Received: from ubuntu-laptop.speedport.ip (p200300e94714d5665ac960fd9f7a69e0.dip0.t-ipconnect.de. [2003:e9:4714:d566:5ac9:60fd:9f7a:69e0])
        by smtp.gmail.com with ESMTPSA id b6sm2235154wmq.45.2021.12.14.04.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 04:05:51 -0800 (PST)
From:   Bean Huo <huobean@gmail.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        cang@codeaurora.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        YongQin Liu <yongqin.liu@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH v2] scsi: ufs: Fix deadlock issue in ufshcd_wait_for_doorbell_clr()
Date:   Tue, 14 Dec 2021 13:05:37 +0100
Message-Id: <20211214120537.531628-1-huobean@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Call shost_for_each_device() with holding host->host_lock will cause
a deadlock situation, which will cause the system to stall (the log
as follow). Fix this issue by using __shost_for_each_device() in
ufshcd_pending_cmds().

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
Reported-by: YongQin Liu <yongqin.liu@linaro.org>
Reported-by: Amit Pundir <amit.pundir@linaro.org>
Tested-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/scsi/ufs/ufshcd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 6dd517267f1b..fbebb8309ef7 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -1082,7 +1082,8 @@ static u32 ufshcd_pending_cmds(struct ufs_hba *hba)
 	struct scsi_device *sdev;
 	u32 pending = 0;
 
-	shost_for_each_device(sdev, hba->host)
+	lockdep_assert_held(hba->host->host_lock);
+	__shost_for_each_device(sdev, hba->host)
 		pending += sbitmap_weight(&sdev->budget_map);
 
 	return pending;
-- 
2.25.1

