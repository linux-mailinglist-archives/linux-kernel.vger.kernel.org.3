Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1734F92F6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 12:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbiDHKc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 06:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbiDHKcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:32:42 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A549219C819
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 03:30:38 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q19so12151528wrc.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 03:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=goRlQM30zfyuhFWXpIh6wI0jTG2AzkOHo69J00w1PBM=;
        b=bGIA7Z/TXrXO2+MKbbhDdpM9dW8n7NxGLROivgfDWpAJJzvTZwLbGH9i7z59HFzM7P
         0YYC0Emm0EDqpA1a6bWke6GorwifBkMbJl5zaHNsdl5RdcmVs4YEFu9cf1Xhlp3mBGLj
         dmtpBZviZwaSHXDV8E1BpaUvRIATu/9BAW+FtBt1NaZLxzudxoCmeCZXvb/nizxwdToF
         C7/6a7tiGaXRF/wx+RVRAjRxK6gmmhVq7tv3N/ypAaCHr+kfEu4VL58RyShE8hmA7Kgo
         wVXd9/izPfEYj2CHSqT7tdq+1OvpDsKMN3XStQUD3z+n4YTkHFQnPPSGZU7La9uFZhpG
         E7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=goRlQM30zfyuhFWXpIh6wI0jTG2AzkOHo69J00w1PBM=;
        b=Sf3hX2WM49xRTb+eXV9dAe0b8CGdnihXoO9ITJEJ3Te1uo53tZu38PARPFTBG2UJUI
         WI/CIe8JY2lB6uULpTwGnHch/7FymyRbGzGZl7yyLpSHhL6ZZpCQzdAcdqAcsUHlTtfL
         pqjB1xKgzgC6BxoX45+Y9gVWdksEGXSUWlDKmsyMRUcRTVccwrEnIgnJnW9eicwU3F64
         KXdYM/l94GlsPTQJWZ90TT4XEEd++86QjDVGg2Z2BjMimMTdlT2zdYcTOT3ZMksNTSmY
         sqX779znQ5aUw5yyHiGtQ71CdCDMtjKQyb2hdzaPLEXfkTmAeAendacveFcKiHZfI/l5
         lBYw==
X-Gm-Message-State: AOAM532qmGOtJNCAdicB37iIB6uyi0amOV6mz13q1mpMJ1vwiO0pEqzi
        od39tlWNE4n4gIF1yB3y7Yq3cQ==
X-Google-Smtp-Source: ABdhPJyxVzgdM9g2LQRAkic6H8k7Q4GPXCT6OByFbkbnbGzPUUgCwxy5hPEQPrwQpU1yTGnSqhNrlw==
X-Received: by 2002:adf:e6c3:0:b0:207:972c:d69 with SMTP id y3-20020adfe6c3000000b00207972c0d69mr1788951wrm.655.1649413837223;
        Fri, 08 Apr 2022 03:30:37 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id n2-20020adfb742000000b00205eda3b3c1sm20181920wre.34.2022.04.08.03.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 03:30:36 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/4] scsi: ufs: ufshcd: constify pointed data
Date:   Fri,  8 Apr 2022 12:30:27 +0200
Message-Id: <20220408103027.311624-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220408103027.311624-1-krzysztof.kozlowski@linaro.org>
References: <20220408103027.311624-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constify arrays and pointers to data which is not modified for code
safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/scsi/ufs/ufshcd.c | 48 ++++++++++++++++++++-------------------
 drivers/scsi/ufs/ufshcd.h |  9 ++++----
 2 files changed, 30 insertions(+), 27 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 3f9caafa91bf..5bfa62fa288a 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -162,7 +162,7 @@ enum {
 #define ufshcd_clear_eh_in_progress(h) \
 	((h)->eh_flags &= ~UFSHCD_EH_IN_PROGRESS)
 
-struct ufs_pm_lvl_states ufs_pm_lvl_states[] = {
+const struct ufs_pm_lvl_states ufs_pm_lvl_states[] = {
 	[UFS_PM_LVL_0] = {UFS_ACTIVE_PWR_MODE, UIC_LINK_ACTIVE_STATE},
 	[UFS_PM_LVL_1] = {UFS_ACTIVE_PWR_MODE, UIC_LINK_HIBERN8_STATE},
 	[UFS_PM_LVL_2] = {UFS_SLEEP_PWR_MODE, UIC_LINK_ACTIVE_STATE},
@@ -204,7 +204,7 @@ ufs_get_desired_pm_lvl_for_dev_link_state(enum ufs_dev_pwr_mode dev_state,
 	return UFS_PM_LVL_0;
 }
 
-static struct ufs_dev_fix ufs_fixups[] = {
+static const struct ufs_dev_fix ufs_fixups[] = {
 	/* UFS cards deviations table */
 	UFS_FIX(UFS_VENDOR_MICRON, UFS_ANY_MODEL,
 		UFS_DEVICE_QUIRK_DELAY_BEFORE_LPM |
@@ -343,7 +343,7 @@ static void ufshcd_add_tm_upiu_trace(struct ufs_hba *hba, unsigned int tag,
 }
 
 static void ufshcd_add_uic_command_trace(struct ufs_hba *hba,
-					 struct uic_command *ucmd,
+					 const struct uic_command *ucmd,
 					 enum ufs_trace_str_t str_t)
 {
 	u32 cmd;
@@ -423,11 +423,11 @@ static void ufshcd_print_clk_freqs(struct ufs_hba *hba)
 }
 
 static void ufshcd_print_evt(struct ufs_hba *hba, u32 id,
-			     char *err_name)
+			     const char *err_name)
 {
 	int i;
 	bool found = false;
-	struct ufs_event_hist *e;
+	const struct ufs_event_hist *e;
 
 	if (id >= UFS_EVT_CNT)
 		return;
@@ -477,7 +477,7 @@ static void ufshcd_print_evt_hist(struct ufs_hba *hba)
 static
 void ufshcd_print_trs(struct ufs_hba *hba, unsigned long bitmap, bool pr_prdt)
 {
-	struct ufshcd_lrb *lrbp;
+	const struct ufshcd_lrb *lrbp;
 	int prdt_length;
 	int tag;
 
@@ -533,7 +533,7 @@ static void ufshcd_print_tmrs(struct ufs_hba *hba, unsigned long bitmap)
 
 static void ufshcd_print_host_state(struct ufs_hba *hba)
 {
-	struct scsi_device *sdev_ufs = hba->sdev_ufs_device;
+	const struct scsi_device *sdev_ufs = hba->sdev_ufs_device;
 
 	dev_err(hba->dev, "UFS Host state=%d\n", hba->ufshcd_state);
 	dev_err(hba->dev, "outstanding reqs=0x%lx tasks=0x%lx\n",
@@ -1083,7 +1083,7 @@ static bool ufshcd_is_devfreq_scaling_required(struct ufs_hba *hba,
  */
 static u32 ufshcd_pending_cmds(struct ufs_hba *hba)
 {
-	struct scsi_device *sdev;
+	const struct scsi_device *sdev;
 	u32 pending = 0;
 
 	lockdep_assert_held(hba->host->host_lock);
@@ -2046,14 +2046,15 @@ static inline int ufshcd_monitor_opcode2dir(u8 opcode)
 static inline bool ufshcd_should_inform_monitor(struct ufs_hba *hba,
 						struct ufshcd_lrb *lrbp)
 {
-	struct ufs_hba_monitor *m = &hba->monitor;
+	const struct ufs_hba_monitor *m = &hba->monitor;
 
 	return (m->enabled && lrbp && lrbp->cmd &&
 		(!m->chunk_size || m->chunk_size == lrbp->cmd->sdb.length) &&
 		ktime_before(hba->monitor.enabled_ts, lrbp->issue_time_stamp));
 }
 
-static void ufshcd_start_monitor(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
+static void ufshcd_start_monitor(struct ufs_hba *hba,
+				 const struct ufshcd_lrb *lrbp)
 {
 	int dir = ufshcd_monitor_opcode2dir(*lrbp->cmd->cmnd);
 	unsigned long flags;
@@ -2064,14 +2065,14 @@ static void ufshcd_start_monitor(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
 }
 
-static void ufshcd_update_monitor(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
+static void ufshcd_update_monitor(struct ufs_hba *hba, const struct ufshcd_lrb *lrbp)
 {
 	int dir = ufshcd_monitor_opcode2dir(*lrbp->cmd->cmnd);
 	unsigned long flags;
 
 	spin_lock_irqsave(hba->host->host_lock, flags);
 	if (dir >= 0 && hba->monitor.nr_queued[dir] > 0) {
-		struct request *req = scsi_cmd_to_rq(lrbp->cmd);
+		const struct request *req = scsi_cmd_to_rq(lrbp->cmd);
 		struct ufs_hba_monitor *m = &hba->monitor;
 		ktime_t now, inc, lat;
 
@@ -4888,7 +4889,7 @@ static int ufshcd_get_lu_wp(struct ufs_hba *hba,
  *
  */
 static inline void ufshcd_get_lu_power_on_wp_status(struct ufs_hba *hba,
-						    struct scsi_device *sdev)
+						    const struct scsi_device *sdev)
 {
 	if (hba->dev_info.f_power_on_wp_en &&
 	    !hba->dev_info.is_lu_power_on_wp) {
@@ -5407,8 +5408,8 @@ int ufshcd_write_ee_control(struct ufs_hba *hba)
 	return err;
 }
 
-int ufshcd_update_ee_control(struct ufs_hba *hba, u16 *mask, u16 *other_mask,
-			     u16 set, u16 clr)
+int ufshcd_update_ee_control(struct ufs_hba *hba, u16 *mask,
+			     const u16 *other_mask, u16 set, u16 clr)
 {
 	u16 new_mask, ee_ctrl_mask;
 	int err = 0;
@@ -7343,7 +7344,8 @@ static int ufshcd_eh_host_reset_handler(struct scsi_cmnd *cmd)
  *
  * Returns calculated max ICC level for specific regulator
  */
-static u32 ufshcd_get_max_icc_level(int sup_curr_uA, u32 start_scan, char *buff)
+static u32 ufshcd_get_max_icc_level(int sup_curr_uA, u32 start_scan,
+				    const char *buff)
 {
 	int i;
 	int curr_uA;
@@ -7390,7 +7392,7 @@ static u32 ufshcd_get_max_icc_level(int sup_curr_uA, u32 start_scan, char *buff)
  * Returns calculated ICC level
  */
 static u32 ufshcd_find_max_sup_active_icc_level(struct ufs_hba *hba,
-							u8 *desc_buf, int len)
+						const u8 *desc_buf, int len)
 {
 	u32 icc_level = 0;
 
@@ -7540,7 +7542,7 @@ static int ufshcd_scsi_add_wlus(struct ufs_hba *hba)
 	return ret;
 }
 
-static void ufshcd_wb_probe(struct ufs_hba *hba, u8 *desc_buf)
+static void ufshcd_wb_probe(struct ufs_hba *hba, const u8 *desc_buf)
 {
 	struct ufs_dev_info *dev_info = &hba->dev_info;
 	u8 lun;
@@ -7611,7 +7613,7 @@ static void ufshcd_wb_probe(struct ufs_hba *hba, u8 *desc_buf)
 	hba->caps &= ~UFSHCD_CAP_WB_EN;
 }
 
-static void ufshcd_temp_notif_probe(struct ufs_hba *hba, u8 *desc_buf)
+static void ufshcd_temp_notif_probe(struct ufs_hba *hba, const u8 *desc_buf)
 {
 	struct ufs_dev_info *dev_info = &hba->dev_info;
 	u32 ext_ufs_feature;
@@ -7634,9 +7636,9 @@ static void ufshcd_temp_notif_probe(struct ufs_hba *hba, u8 *desc_buf)
 	}
 }
 
-void ufshcd_fixup_dev_quirks(struct ufs_hba *hba, struct ufs_dev_fix *fixups)
+void ufshcd_fixup_dev_quirks(struct ufs_hba *hba, const struct ufs_dev_fix *fixups)
 {
-	struct ufs_dev_fix *f;
+	const struct ufs_dev_fix *f;
 	struct ufs_dev_info *dev_info = &hba->dev_info;
 
 	if (!fixups)
@@ -7844,7 +7846,7 @@ static int ufshcd_quirk_tune_host_pa_tactivate(struct ufs_hba *hba)
 	u32 granularity, peer_granularity;
 	u32 pa_tactivate, peer_pa_tactivate;
 	u32 pa_tactivate_us, peer_pa_tactivate_us;
-	u8 gran_to_us_table[] = {1, 4, 8, 16, 32, 100};
+	const u8 gran_to_us_table[] = {1, 4, 8, 16, 32, 100};
 
 	ret = ufshcd_dme_get(hba, UIC_ARG_MIB(PA_GRANULARITY),
 				  &granularity);
@@ -7956,7 +7958,7 @@ static int ufshcd_device_geo_params_init(struct ufs_hba *hba)
 	return err;
 }
 
-static struct ufs_ref_clk ufs_ref_clk_freqs[] = {
+static const struct ufs_ref_clk ufs_ref_clk_freqs[] = {
 	{19200000, REF_CLK_FREQ_19_2_MHZ},
 	{26000000, REF_CLK_FREQ_26_MHZ},
 	{38400000, REF_CLK_FREQ_38_4_MHZ},
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 94f545be183a..1a8f7b8977e6 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -1185,7 +1185,8 @@ int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
 
 void ufshcd_auto_hibern8_enable(struct ufs_hba *hba);
 void ufshcd_auto_hibern8_update(struct ufs_hba *hba, u32 ahit);
-void ufshcd_fixup_dev_quirks(struct ufs_hba *hba, struct ufs_dev_fix *fixups);
+void ufshcd_fixup_dev_quirks(struct ufs_hba *hba,
+			     const struct ufs_dev_fix *fixups);
 #define SD_ASCII_STD true
 #define SD_RAW false
 int ufshcd_read_string_desc(struct ufs_hba *hba, u8 desc_index,
@@ -1371,7 +1372,7 @@ static inline void ufshcd_vops_config_scaling_param(struct ufs_hba *hba,
 		hba->vops->config_scaling_param(hba, profile, data);
 }
 
-extern struct ufs_pm_lvl_states ufs_pm_lvl_states[];
+extern const struct ufs_pm_lvl_states ufs_pm_lvl_states[];
 
 /*
  * ufshcd_scsi_to_upiu_lun - maps scsi LUN to UPIU LUN
@@ -1393,8 +1394,8 @@ int ufshcd_dump_regs(struct ufs_hba *hba, size_t offset, size_t len,
 
 int __ufshcd_write_ee_control(struct ufs_hba *hba, u32 ee_ctrl_mask);
 int ufshcd_write_ee_control(struct ufs_hba *hba);
-int ufshcd_update_ee_control(struct ufs_hba *hba, u16 *mask, u16 *other_mask,
-			     u16 set, u16 clr);
+int ufshcd_update_ee_control(struct ufs_hba *hba, u16 *mask,
+			     const u16 *other_mask, u16 set, u16 clr);
 
 static inline int ufshcd_update_ee_drv_mask(struct ufs_hba *hba,
 					    u16 set, u16 clr)
-- 
2.32.0

