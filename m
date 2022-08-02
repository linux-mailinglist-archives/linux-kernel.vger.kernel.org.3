Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BF15883B8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 23:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbiHBVog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 17:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbiHBVoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 17:44:32 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7788192B3
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 14:44:29 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 130so6921740pfv.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 14:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jx77LHzy5pMrCy8NUb4I/3IoM72bQAsPqELbMVaVYMI=;
        b=M+FWZiBkOwo7uh9T3nWcMkcWmtG6C2yzvR27hmerBUYdhTpujV7CuAQxjNmM81QRzx
         oVhkDJ8m6h7pH/CNhQWnIfbiYPgrNL/PzQP0GkwY1AkhDwJgg7tCtTiT+ZgUFSmBqbk8
         u8gAK+JKQPs/OQ2dEpNxLQlxJFDcjd7a1GNVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jx77LHzy5pMrCy8NUb4I/3IoM72bQAsPqELbMVaVYMI=;
        b=oftIWwu87bbSgv2BpQyKqaaC2zRt6fdG/7MKdturY1jVZpcyrLeVxzyS1Df6P9p28k
         31MJgcY88aTtB9C71znb1oO9pUa8xC3EGaky2PTQVit2UXflMPIs0rT/rSHpVaCm1kv8
         qyoYJ96CS0ySNrWM9ORe6xTZWNXzn72uQeufSdwl+ch4GZp1p/bqPdmHXFD8reJ2fVUp
         n6lSuZfD1mVnoCuxnWDo4jTR0XdF/JuXsg2homHTddJSkjQUBQIK9VeGyWs1bMJgyZo8
         lK3nTywrpKgqBYmasTjCMOuKsLLU+kr8sey1p3qGMOr4tTfo7Z8+3VfjNY84ZFNSgiK/
         wrtw==
X-Gm-Message-State: AJIora/7aHTs7L1UTVJni8ctcTeK9EVv5E5xQN/7a7zhH/1702CCWXXd
        JypW+bK0djHkEYu86IaWtXlP89CrBB3rKA==
X-Google-Smtp-Source: AGRyM1tGwvgbGA4/CpS7LVOQe6EcV1n7uxiobzbS/WgUEYaEjD3YAs5mz5nhXZ1zm2vU3ZYBZXOvgg==
X-Received: by 2002:a63:f306:0:b0:41a:6258:dcd2 with SMTP id l6-20020a63f306000000b0041a6258dcd2mr18010158pgh.28.1659476669200;
        Tue, 02 Aug 2022 14:44:29 -0700 (PDT)
Received: from dlunevwfh.roam.corp.google.com (n122-107-196-14.sbr2.nsw.optusnet.com.au. [122.107.196.14])
        by smtp.gmail.com with ESMTPSA id x11-20020a170902a38b00b0015e9f45c1f4sm161459pla.186.2022.08.02.14.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 14:44:28 -0700 (PDT)
From:   Daniil Lunev <dlunev@chromium.org>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Stanley Chu <chu.stanley@gmail.com>
Cc:     Daniil Lunev <dlunev@chromium.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH v4] ufs: core: ufshcd: use local_clock() for debugging timestamps
Date:   Wed,  3 Aug 2022 07:44:19 +1000
Message-Id: <20220803074349.v4.1.I699244ea7efbd326a34a6dfd9b5a31e78400cf68@changeid>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
dmesg entries, which are timestamped with local_clock().

This CL changes the used clock to local_clock() for the informational
timestamp variables and adds mirroring *_local_clock instances for
variables used in subsequent derevations (to not change the semantics of
those derevations).

Signed-off-by: Daniil Lunev <dlunev@chromium.org>

---

Changes in v4:
- Use div_u64 instead of "/"

Changes in v3:
- Add missing header

Changes in v2:
- Use local clock to better align with dmesg
- Correct commit message

 drivers/ufs/core/ufshcd.c | 20 ++++++++++++--------
 include/ufs/ufshcd.h      | 14 +++++++++-----
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index ce86d1b790c05..3b3c011d81e36 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -21,6 +21,7 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
+#include <linux/sched/clock.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_dbg.h>
 #include <scsi/scsi_driver.h>
@@ -460,7 +461,7 @@ static void ufshcd_print_evt(struct ufs_hba *hba, u32 id,
 		if (e->tstamp[p] == 0)
 			continue;
 		dev_err(hba->dev, "%s[%d] = 0x%x at %lld us\n", err_name, p,
-			e->val[p], ktime_to_us(e->tstamp[p]));
+			e->val[p], div_u64(e->tstamp[p], 1000));
 		found = true;
 	}
 
@@ -505,9 +506,9 @@ void ufshcd_print_trs(struct ufs_hba *hba, unsigned long bitmap, bool pr_prdt)
 		lrbp = &hba->lrb[tag];
 
 		dev_err(hba->dev, "UPIU[%d] - issue time %lld us\n",
-				tag, ktime_to_us(lrbp->issue_time_stamp));
+				tag, div_u64(lrbp->issue_time_stamp_local_clock, 1000));
 		dev_err(hba->dev, "UPIU[%d] - complete time %lld us\n",
-				tag, ktime_to_us(lrbp->compl_time_stamp));
+				tag, div_u64(lrbp->compl_time_stamp_local_clock, 1000));
 		dev_err(hba->dev,
 			"UPIU[%d] - Transfer Request Descriptor phys@0x%llx\n",
 			tag, (u64)lrbp->utrd_dma_addr);
@@ -569,10 +570,10 @@ static void ufshcd_print_host_state(struct ufs_hba *hba)
 	dev_err(hba->dev, "Clk gate=%d\n", hba->clk_gating.state);
 	dev_err(hba->dev,
 		"last_hibern8_exit_tstamp at %lld us, hibern8_exit_cnt=%d\n",
-		ktime_to_us(hba->ufs_stats.last_hibern8_exit_tstamp),
+		div_u64(hba->ufs_stats.last_hibern8_exit_tstamp, 1000),
 		hba->ufs_stats.hibern8_exit_cnt);
 	dev_err(hba->dev, "last intr at %lld us, last intr status=0x%x\n",
-		ktime_to_us(hba->ufs_stats.last_intr_ts),
+		div_u64(hba->ufs_stats.last_intr_ts, 1000),
 		hba->ufs_stats.last_intr_status);
 	dev_err(hba->dev, "error handling flags=0x%x, req. abort count=%d\n",
 		hba->eh_flags, hba->req_abort_count);
@@ -2142,7 +2143,9 @@ void ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag)
 	unsigned long flags;
 
 	lrbp->issue_time_stamp = ktime_get();
+	lrbp->issue_time_stamp_local_clock = local_clock();
 	lrbp->compl_time_stamp = ktime_set(0, 0);
+	lrbp->compl_time_stamp_local_clock = 0;
 	ufshcd_add_command_trace(hba, task_tag, UFS_CMD_SEND);
 	ufshcd_clk_scaling_start_busy(hba);
 	if (unlikely(ufshcd_should_inform_monitor(hba, lrbp)))
@@ -4199,7 +4202,7 @@ int ufshcd_uic_hibern8_exit(struct ufs_hba *hba)
 	} else {
 		ufshcd_vops_hibern8_notify(hba, UIC_CMD_DME_HIBER_EXIT,
 								POST_CHANGE);
-		hba->ufs_stats.last_hibern8_exit_tstamp = ktime_get();
+		hba->ufs_stats.last_hibern8_exit_tstamp = local_clock();
 		hba->ufs_stats.hibern8_exit_cnt++;
 	}
 
@@ -4696,7 +4699,7 @@ void ufshcd_update_evt_hist(struct ufs_hba *hba, u32 id, u32 val)
 
 	e = &hba->ufs_stats.event[id];
 	e->val[e->pos] = val;
-	e->tstamp[e->pos] = ktime_get();
+	e->tstamp[e->pos] = local_clock();
 	e->cnt += 1;
 	e->pos = (e->pos + 1) % UFS_EVENT_HIST_LENGTH;
 
@@ -5329,6 +5332,7 @@ static void __ufshcd_transfer_req_compl(struct ufs_hba *hba,
 	for_each_set_bit(index, &completed_reqs, hba->nutrs) {
 		lrbp = &hba->lrb[index];
 		lrbp->compl_time_stamp = ktime_get();
+		lrbp->compl_time_stamp_local_clock = local_clock();
 		cmd = lrbp->cmd;
 		if (cmd) {
 			if (unlikely(ufshcd_should_inform_monitor(hba, lrbp)))
@@ -6617,7 +6621,7 @@ static irqreturn_t ufshcd_intr(int irq, void *__hba)
 
 	intr_status = ufshcd_readl(hba, REG_INTERRUPT_STATUS);
 	hba->ufs_stats.last_intr_status = intr_status;
-	hba->ufs_stats.last_intr_ts = ktime_get();
+	hba->ufs_stats.last_intr_ts = local_clock();
 
 	/*
 	 * There could be max of hba->nutrs reqs in flight and in worst case
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index a92271421718e..2de73196bb779 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -160,8 +160,10 @@ struct ufs_pm_lvl_states {
  * @task_tag: Task tag of the command
  * @lun: LUN of the command
  * @intr_cmd: Interrupt command (doesn't participate in interrupt aggregation)
- * @issue_time_stamp: time stamp for debug purposes
- * @compl_time_stamp: time stamp for statistics
+ * @issue_time_stamp: time stamp for debug purposes (CLOCK_MONOTONIC)
+ * @issue_time_stamp_local_clock: time stamp for debug purposes (local_clock)
+ * @compl_time_stamp: time stamp for statistics (CLOCK_MONOTONIC)
+ * @compl_time_stamp_local_clock: time stamp for debug purposes (local_clock)
  * @crypto_key_slot: the key slot to use for inline crypto (-1 if none)
  * @data_unit_num: the data unit number for the first block for inline crypto
  * @req_abort_skip: skip request abort task flag
@@ -185,7 +187,9 @@ struct ufshcd_lrb {
 	u8 lun; /* UPIU LUN id field is only 8-bit wide */
 	bool intr_cmd;
 	ktime_t issue_time_stamp;
+	u64 issue_time_stamp_local_clock;
 	ktime_t compl_time_stamp;
+	u64 compl_time_stamp_local_clock;
 #ifdef CONFIG_SCSI_UFS_CRYPTO
 	int crypto_key_slot;
 	u64 data_unit_num;
@@ -430,7 +434,7 @@ struct ufs_clk_scaling {
 struct ufs_event_hist {
 	int pos;
 	u32 val[UFS_EVENT_HIST_LENGTH];
-	ktime_t tstamp[UFS_EVENT_HIST_LENGTH];
+	u64 tstamp[UFS_EVENT_HIST_LENGTH];
 	unsigned long long cnt;
 };
 
@@ -446,10 +450,10 @@ struct ufs_event_hist {
  */
 struct ufs_stats {
 	u32 last_intr_status;
-	ktime_t last_intr_ts;
+	u64 last_intr_ts;
 
 	u32 hibern8_exit_cnt;
-	ktime_t last_hibern8_exit_tstamp;
+	u64 last_hibern8_exit_tstamp;
 	struct ufs_event_hist event[UFS_EVT_CNT];
 };
 
-- 
2.31.0

