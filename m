Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF14057B4B4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 12:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiGTKpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 06:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiGTKpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 06:45:04 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630A967160
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 03:45:02 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id z3so2246306plb.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 03:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=edMiP3VKUnufxzBjIC5MgcE0lainFg/2U5cyekfrTG4=;
        b=HniASQ2L9k8UMEuAb3TlBCA54u7DbsdPTYay7uumNfTeFkxKbxuGYIiCiuktGjNw6F
         u/5e/msrL2VltXJjD4V6eIZ9/enKGtJKYciDfRu4OC8V0kkGEd7TS6Ju1/vRnft5mcZT
         XWGHWBij3Syq2YYKX6a5s7Fxa4e854C6MWTsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=edMiP3VKUnufxzBjIC5MgcE0lainFg/2U5cyekfrTG4=;
        b=WI3alQaAbgplB68gOFuVMot7QcDG0SZ2xZEXZtsOeHqnN4FNOofZJjL8LuwVFeaPBp
         779bzUD/kC4n/oi93zw7CZUKk/5rU8YTcKdBiKzQPVX7445g6O9L/iugPm/RPFlEwSJ8
         uaa+B1f+4N2XKXiNvubC9H2i2MDuTwim4STQeoA++Cbb1WXPZg5/v7ZabO7Um6NDfwje
         K46agmzu6ba7Q3lHDpad0jfL1OnhFlEnE/bgmCAzy8x7PrmzMXWafnz6q3dfu5zdGtPG
         hOFYfi58zaVVzyLnH2wCFcwEmqI8erMEwlwYvvYO35VDpqEMGaLzdl3+WSdai1d6Zc3u
         8ncg==
X-Gm-Message-State: AJIora+ku5y8U90FhVDjsJfqGURNLvPBbU0pE8YjRA9J7mxuAwmNRd8J
        Uos3pG9YhALgSZnU3cokcxWZgA==
X-Google-Smtp-Source: AGRyM1sGExFoHxztZJ83BE8q39RcOwcxm9DxL0kivjbJw+pA7cfXUirQF3MeRMAte/FYgmlaaJYXZA==
X-Received: by 2002:a17:903:40cc:b0:16c:115d:5e80 with SMTP id t12-20020a17090340cc00b0016c115d5e80mr37383248pld.0.1658313901809;
        Wed, 20 Jul 2022 03:45:01 -0700 (PDT)
Received: from dlunevwfh.roam.corp.google.com (n122-107-196-14.sbr2.nsw.optusnet.com.au. [122.107.196.14])
        by smtp.gmail.com with ESMTPSA id g9-20020a625209000000b0051bc5f4df1csm13158421pfb.154.2022.07.20.03.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 03:45:01 -0700 (PDT)
From:   Daniil Lunev <dlunev@chromium.org>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Daniil Lunev <dlunev@chromium.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] ufs: core: ufshcd: use CLOCK_BOOTTIME for debugging timestamps
Date:   Wed, 20 Jul 2022 20:44:36 +1000
Message-Id: <20220720204414.1.I699244ea7efbd326a34a6dfd9b5a31e78400cf68@changeid>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CLOCK_MONOTONIC is not advanced when the system is in suspend. This
becomes problematic when debugging issues related to suspend-resume:
the timestamps printed by ufshcd_print_trs can not be correlated with
dmesg entries, which are timestamped with CLOCK_BOOTTIME.

This CL changes the used clock to CLOCK_BOOTTIME for the informational
timestamp variables and adds mirroring CLOCK_BOOTIME instances for
variables used in subsequent derevations (to not change the semantics of
those derevations).

Signed-off-by: Daniil Lunev <dlunev@chromium.org>

---

 drivers/ufs/core/ufshcd.c | 13 ++++++++-----
 include/ufs/ufshcd.h      |  8 ++++++--
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index ce86d1b790c05..7726fa93b2e2a 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -505,9 +505,9 @@ void ufshcd_print_trs(struct ufs_hba *hba, unsigned long bitmap, bool pr_prdt)
 		lrbp = &hba->lrb[tag];
 
 		dev_err(hba->dev, "UPIU[%d] - issue time %lld us\n",
-				tag, ktime_to_us(lrbp->issue_time_stamp));
+				tag, ktime_to_us(lrbp->issue_time_stamp_boottime));
 		dev_err(hba->dev, "UPIU[%d] - complete time %lld us\n",
-				tag, ktime_to_us(lrbp->compl_time_stamp));
+				tag, ktime_to_us(lrbp->compl_time_stamp_boottime));
 		dev_err(hba->dev,
 			"UPIU[%d] - Transfer Request Descriptor phys@0x%llx\n",
 			tag, (u64)lrbp->utrd_dma_addr);
@@ -2142,7 +2142,9 @@ void ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag)
 	unsigned long flags;
 
 	lrbp->issue_time_stamp = ktime_get();
+	lrbp->issue_time_stamp_boottime = ktime_get_boottime();
 	lrbp->compl_time_stamp = ktime_set(0, 0);
+	lrbp->compl_time_stamp_boottime = ktime_set(0, 0);
 	ufshcd_add_command_trace(hba, task_tag, UFS_CMD_SEND);
 	ufshcd_clk_scaling_start_busy(hba);
 	if (unlikely(ufshcd_should_inform_monitor(hba, lrbp)))
@@ -4199,7 +4201,7 @@ int ufshcd_uic_hibern8_exit(struct ufs_hba *hba)
 	} else {
 		ufshcd_vops_hibern8_notify(hba, UIC_CMD_DME_HIBER_EXIT,
 								POST_CHANGE);
-		hba->ufs_stats.last_hibern8_exit_tstamp = ktime_get();
+		hba->ufs_stats.last_hibern8_exit_tstamp = ktime_get_boottime();
 		hba->ufs_stats.hibern8_exit_cnt++;
 	}
 
@@ -4696,7 +4698,7 @@ void ufshcd_update_evt_hist(struct ufs_hba *hba, u32 id, u32 val)
 
 	e = &hba->ufs_stats.event[id];
 	e->val[e->pos] = val;
-	e->tstamp[e->pos] = ktime_get();
+	e->tstamp[e->pos] = ktime_get_boottime();
 	e->cnt += 1;
 	e->pos = (e->pos + 1) % UFS_EVENT_HIST_LENGTH;
 
@@ -5329,6 +5331,7 @@ static void __ufshcd_transfer_req_compl(struct ufs_hba *hba,
 	for_each_set_bit(index, &completed_reqs, hba->nutrs) {
 		lrbp = &hba->lrb[index];
 		lrbp->compl_time_stamp = ktime_get();
+		lrbp->compl_time_stamp_boottime = ktime_get_boottime();
 		cmd = lrbp->cmd;
 		if (cmd) {
 			if (unlikely(ufshcd_should_inform_monitor(hba, lrbp)))
@@ -6617,7 +6620,7 @@ static irqreturn_t ufshcd_intr(int irq, void *__hba)
 
 	intr_status = ufshcd_readl(hba, REG_INTERRUPT_STATUS);
 	hba->ufs_stats.last_intr_status = intr_status;
-	hba->ufs_stats.last_intr_ts = ktime_get();
+	hba->ufs_stats.last_intr_ts = ktime_get_boottime();
 
 	/*
 	 * There could be max of hba->nutrs reqs in flight and in worst case
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index a92271421718e..d4ef09910d0ef 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -160,8 +160,10 @@ struct ufs_pm_lvl_states {
  * @task_tag: Task tag of the command
  * @lun: LUN of the command
  * @intr_cmd: Interrupt command (doesn't participate in interrupt aggregation)
- * @issue_time_stamp: time stamp for debug purposes
- * @compl_time_stamp: time stamp for statistics
+ * @issue_time_stamp: time stamp for debug purposes (CLOCK_MONOTONIC)
+ * @issue_time_stamp_boottime: time stamp for debug purposes (CLOCK_BOOTTIME)
+ * @compl_time_stamp: time stamp for statistics (CLOCK_MONOTONIC)
+ * @compl_time_stamp_boottime: time stamp for debug purposes (CLOCK_BOOTTIME)
  * @crypto_key_slot: the key slot to use for inline crypto (-1 if none)
  * @data_unit_num: the data unit number for the first block for inline crypto
  * @req_abort_skip: skip request abort task flag
@@ -185,7 +187,9 @@ struct ufshcd_lrb {
 	u8 lun; /* UPIU LUN id field is only 8-bit wide */
 	bool intr_cmd;
 	ktime_t issue_time_stamp;
+	ktime_t issue_time_stamp_boottime;
 	ktime_t compl_time_stamp;
+	ktime_t compl_time_stamp_boottime;
 #ifdef CONFIG_SCSI_UFS_CRYPTO
 	int crypto_key_slot;
 	u64 data_unit_num;
-- 
2.31.0

