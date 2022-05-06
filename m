Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE7251D5C9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 12:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391030AbiEFKfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 06:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390996AbiEFKfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 06:35:08 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519296339E
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 03:31:25 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ks9so7212652ejb.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 03:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hX+bUnGQklZfPo10HNtNpaHXzVfVIfhC6tt2tyy3JGo=;
        b=Hxkl01nfUbxKKI00kRBh9Gcu7zvQXvR6UAMrlyarMSOLeJ5PAkxhOLGYOe8Y70lC3W
         UKaSAOx5/jMVJYFFs1ye3BOyjzWNvRnRiw8S6NjAuxJS2HZOhH68BVixzH0oG4BmDPiG
         CI5o/debIKh1HNhpjKC0yPb8QDVT4AWOyJHTNH28e8/ni0FMGkOv3j/vBTH+/Bq0kXjO
         p79FMh4iBV9JeJzJq6JMfApnXEa2GeP5cLJ3dYJQ7upgvN/UZFnqwbJpIrOyZ2QU6Wwn
         fA1qQtMugOnYuP1MvJIeP11qKKqlL8oRwsLetTqScpbl+n3kspG28HDd3Z19Fe4j1SLp
         YCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hX+bUnGQklZfPo10HNtNpaHXzVfVIfhC6tt2tyy3JGo=;
        b=zdjavsTBm4HXPrm4wBj0J1TuYWIbGk8Jp3TTJGBGbmtt0t0iBmu5qhA5ehSKGixTqr
         hXKHl/3PFMw5pAALkK1Y7g7Nk0feqkVDQCRzi90Nn8p6+FVkfvyVlTR/sBseIsd87E/x
         jaXdx7j9KGikQv9+q9+nLPaAszo0oWQJBvGdVcNKEMWpGm4cZEq2SvT0ja8BUhKC00N2
         A1paq6ddBrJX7OREvdJxGz9asHi24xL/3pEUj8eQmlXcDM27BZ0iAVnC3BkKTVF0g08x
         489R+bufZhCL3Zl1eZyQllHHgM68wP+K8LpD7VOsuuM2choB6wbjtzNvLMtlqboww8Oe
         NL0A==
X-Gm-Message-State: AOAM532OInX47O/EgyIfQrjNo1lh+6RzJt9RC/ucSXIVjGf2wp2xFidE
        oQDzC9n8kLZfyH6dw8pPgy7zBg==
X-Google-Smtp-Source: ABdhPJwH+hPF5K3N9aW6eY3Qw6APVauglrw/noPEyvnOPVy+FL0vUwY5aKJvpfWcuGyA9Z3sUntOuA==
X-Received: by 2002:a17:907:6e8b:b0:6f4:7147:a6ac with SMTP id sh11-20020a1709076e8b00b006f47147a6acmr2380194ejc.187.1651833083764;
        Fri, 06 May 2022 03:31:23 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id em10-20020a170907288a00b006f3ef214e6dsm1726957ejc.211.2022.05.06.03.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 03:31:23 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 3/3] scsi: ufs: ufshcd: constify pointed data
Date:   Fri,  6 May 2022 12:31:15 +0200
Message-Id: <20220506103115.307410-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220506103115.307410-1-krzysztof.kozlowski@linaro.org>
References: <20220506103115.307410-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constify arrays and pointers to data which is not modified for code
safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/scsi/ufs/ufshcd-priv.h |  6 ++---
 drivers/scsi/ufs/ufshcd.c      | 42 ++++++++++++++++++----------------
 drivers/scsi/ufs/ufshcd.h      |  6 ++---
 3 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd-priv.h b/drivers/scsi/ufs/ufshcd-priv.h
index 38bc77d3dbbd..3fa4163516fb 100644
--- a/drivers/scsi/ufs/ufshcd-priv.h
+++ b/drivers/scsi/ufs/ufshcd-priv.h
@@ -215,7 +215,7 @@ static inline void ufshcd_vops_config_scaling_param(struct ufs_hba *hba,
 		hba->vops->config_scaling_param(hba, p, data);
 }
 
-extern struct ufs_pm_lvl_states ufs_pm_lvl_states[];
+extern const struct ufs_pm_lvl_states ufs_pm_lvl_states[];
 
 /**
  * ufshcd_scsi_to_upiu_lun - maps scsi LUN to UPIU LUN
@@ -234,8 +234,8 @@ static inline u8 ufshcd_scsi_to_upiu_lun(unsigned int scsi_lun)
 
 int __ufshcd_write_ee_control(struct ufs_hba *hba, u32 ee_ctrl_mask);
 int ufshcd_write_ee_control(struct ufs_hba *hba);
-int ufshcd_update_ee_control(struct ufs_hba *hba, u16 *mask, u16 *other_mask,
-			     u16 set, u16 clr);
+int ufshcd_update_ee_control(struct ufs_hba *hba, u16 *mask,
+			     const u16 *other_mask, u16 set, u16 clr);
 
 static inline int ufshcd_update_ee_drv_mask(struct ufs_hba *hba,
 					    u16 set, u16 clr)
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 2b4390a1106e..ea43aa2d26e1 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -175,7 +175,7 @@ enum {
 #define ufshcd_clear_eh_in_progress(h) \
 	((h)->eh_flags &= ~UFSHCD_EH_IN_PROGRESS)
 
-struct ufs_pm_lvl_states ufs_pm_lvl_states[] = {
+const struct ufs_pm_lvl_states ufs_pm_lvl_states[] = {
 	[UFS_PM_LVL_0] = {UFS_ACTIVE_PWR_MODE, UIC_LINK_ACTIVE_STATE},
 	[UFS_PM_LVL_1] = {UFS_ACTIVE_PWR_MODE, UIC_LINK_HIBERN8_STATE},
 	[UFS_PM_LVL_2] = {UFS_SLEEP_PWR_MODE, UIC_LINK_ACTIVE_STATE},
@@ -363,7 +363,7 @@ static void ufshcd_add_tm_upiu_trace(struct ufs_hba *hba, unsigned int tag,
 }
 
 static void ufshcd_add_uic_command_trace(struct ufs_hba *hba,
-					 struct uic_command *ucmd,
+					 const struct uic_command *ucmd,
 					 enum ufs_trace_str_t str_t)
 {
 	u32 cmd;
@@ -443,11 +443,11 @@ static void ufshcd_print_clk_freqs(struct ufs_hba *hba)
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
@@ -497,7 +497,7 @@ static void ufshcd_print_evt_hist(struct ufs_hba *hba)
 static
 void ufshcd_print_trs(struct ufs_hba *hba, unsigned long bitmap, bool pr_prdt)
 {
-	struct ufshcd_lrb *lrbp;
+	const struct ufshcd_lrb *lrbp;
 	int prdt_length;
 	int tag;
 
@@ -553,7 +553,7 @@ static void ufshcd_print_tmrs(struct ufs_hba *hba, unsigned long bitmap)
 
 static void ufshcd_print_host_state(struct ufs_hba *hba)
 {
-	struct scsi_device *sdev_ufs = hba->ufs_device_wlun;
+	const struct scsi_device *sdev_ufs = hba->ufs_device_wlun;
 
 	dev_err(hba->dev, "UFS Host state=%d\n", hba->ufshcd_state);
 	dev_err(hba->dev, "outstanding reqs=0x%lx tasks=0x%lx\n",
@@ -1098,7 +1098,7 @@ static bool ufshcd_is_devfreq_scaling_required(struct ufs_hba *hba,
  */
 static u32 ufshcd_pending_cmds(struct ufs_hba *hba)
 {
-	struct scsi_device *sdev;
+	const struct scsi_device *sdev;
 	u32 pending = 0;
 
 	lockdep_assert_held(hba->host->host_lock);
@@ -2069,14 +2069,15 @@ static inline int ufshcd_monitor_opcode2dir(u8 opcode)
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
@@ -2087,14 +2088,14 @@ static void ufshcd_start_monitor(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
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
 
@@ -4902,7 +4903,7 @@ static int ufshcd_get_lu_wp(struct ufs_hba *hba,
  *
  */
 static inline void ufshcd_get_lu_power_on_wp_status(struct ufs_hba *hba,
-						    struct scsi_device *sdev)
+						    const struct scsi_device *sdev)
 {
 	if (hba->dev_info.f_power_on_wp_en &&
 	    !hba->dev_info.is_lu_power_on_wp) {
@@ -5421,8 +5422,8 @@ int ufshcd_write_ee_control(struct ufs_hba *hba)
 	return err;
 }
 
-int ufshcd_update_ee_control(struct ufs_hba *hba, u16 *mask, u16 *other_mask,
-			     u16 set, u16 clr)
+int ufshcd_update_ee_control(struct ufs_hba *hba, u16 *mask,
+			     const u16 *other_mask, u16 set, u16 clr)
 {
 	u16 new_mask, ee_ctrl_mask;
 	int err = 0;
@@ -7349,7 +7350,8 @@ static int ufshcd_eh_host_reset_handler(struct scsi_cmnd *cmd)
  *
  * Returns calculated max ICC level for specific regulator
  */
-static u32 ufshcd_get_max_icc_level(int sup_curr_uA, u32 start_scan, char *buff)
+static u32 ufshcd_get_max_icc_level(int sup_curr_uA, u32 start_scan,
+				    const char *buff)
 {
 	int i;
 	int curr_uA;
@@ -7396,7 +7398,7 @@ static u32 ufshcd_get_max_icc_level(int sup_curr_uA, u32 start_scan, char *buff)
  * Returns calculated ICC level
  */
 static u32 ufshcd_find_max_sup_active_icc_level(struct ufs_hba *hba,
-							u8 *desc_buf, int len)
+						const u8 *desc_buf, int len)
 {
 	u32 icc_level = 0;
 
@@ -7546,7 +7548,7 @@ static int ufshcd_scsi_add_wlus(struct ufs_hba *hba)
 	return ret;
 }
 
-static void ufshcd_wb_probe(struct ufs_hba *hba, u8 *desc_buf)
+static void ufshcd_wb_probe(struct ufs_hba *hba, const u8 *desc_buf)
 {
 	struct ufs_dev_info *dev_info = &hba->dev_info;
 	u8 lun;
@@ -7617,7 +7619,7 @@ static void ufshcd_wb_probe(struct ufs_hba *hba, u8 *desc_buf)
 	hba->caps &= ~UFSHCD_CAP_WB_EN;
 }
 
-static void ufshcd_temp_notif_probe(struct ufs_hba *hba, u8 *desc_buf)
+static void ufshcd_temp_notif_probe(struct ufs_hba *hba, const u8 *desc_buf)
 {
 	struct ufs_dev_info *dev_info = &hba->dev_info;
 	u32 ext_ufs_feature;
@@ -7851,7 +7853,7 @@ static int ufshcd_quirk_tune_host_pa_tactivate(struct ufs_hba *hba)
 	u32 granularity, peer_granularity;
 	u32 pa_tactivate, peer_pa_tactivate;
 	u32 pa_tactivate_us, peer_pa_tactivate_us;
-	u8 gran_to_us_table[] = {1, 4, 8, 16, 32, 100};
+	const u8 gran_to_us_table[] = {1, 4, 8, 16, 32, 100};
 
 	ret = ufshcd_dme_get(hba, UIC_ARG_MIB(PA_GRANULARITY),
 				  &granularity);
@@ -7968,7 +7970,7 @@ struct ufs_ref_clk {
 	enum ufs_ref_clk_freq val;
 };
 
-static struct ufs_ref_clk ufs_ref_clk_freqs[] = {
+static const struct ufs_ref_clk ufs_ref_clk_freqs[] = {
 	{19200000, REF_CLK_FREQ_19_2_MHZ},
 	{26000000, REF_CLK_FREQ_26_MHZ},
 	{38400000, REF_CLK_FREQ_38_4_MHZ},
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 2b0f3441b813..0b8d0192f069 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -1217,14 +1217,14 @@ static inline int ufshcd_vops_phy_initialization(struct ufs_hba *hba)
 	return 0;
 }
 
-extern struct ufs_pm_lvl_states ufs_pm_lvl_states[];
+extern const struct ufs_pm_lvl_states ufs_pm_lvl_states[];
 
 int ufshcd_dump_regs(struct ufs_hba *hba, size_t offset, size_t len,
 		     const char *prefix);
 
 int __ufshcd_write_ee_control(struct ufs_hba *hba, u32 ee_ctrl_mask);
 int ufshcd_write_ee_control(struct ufs_hba *hba);
-int ufshcd_update_ee_control(struct ufs_hba *hba, u16 *mask, u16 *other_mask,
-			     u16 set, u16 clr);
+int ufshcd_update_ee_control(struct ufs_hba *hba, u16 *mask,
+			     const u16 *other_mask, u16 set, u16 clr);
 
 #endif /* End of Header */
-- 
2.32.0

