Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6C94C6CF3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236625AbiB1Mps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbiB1Mpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:45:34 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A1F70CFD
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:44:47 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id c9so10652088pll.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8XW1DXTUUHZ5Z5Syo/ynDiVEDVbCzVzE/LdyTRsVwy8=;
        b=BFSPOxBUwQ2ic9VQq7Da5uUlpUvg5prCb77ip8BmkHVBsq495LI2S7NxCLjoJgqOgE
         o+y7EQ8B5gZS7LnWm6ylRuaZSDji/GNzVODGtvWMwagkTi5Wh1hF/opqWKT1FHaHs94f
         ZE8uBFr6WrF4t+lqf4SvqKvHjeGH576Sa8WNt5BlTQh8nVfCKCh0wwi+bQYLA82vpfbC
         jI4eBundwdiyjlz3XZV7R2B9U7UHFvIdTrIkl3JDusHqwWljCZOYKltNc+vsPQ86O/4I
         tN3HLEhe56taK3vNcOjQ8ZDdLbvLmSRLwfsmam2nDN0dBstrLVHRC/yD0xx7PmdOOlpC
         wXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8XW1DXTUUHZ5Z5Syo/ynDiVEDVbCzVzE/LdyTRsVwy8=;
        b=nzwo9WcaxweuVL96BB5/weVhKAnd8jrHCIJZlyez6fryCdYEJrFAuFXA2U3zLRPkan
         Xz2qnE4EZCD3SyFEWusIcIDBt9iORCXPYFV7mwbDVBlNuqwy1qwMC5I7akMJ0Sy8MLt9
         XTWnlUY1Cjc2cbQLyFWcSg2I1uReqFezboKIz9eHRmaSZQYTtkPJOo8ODCK9tPp09pnW
         74f+r4QY9zPa7LC4iu9syhz4d7AmhzPSwvqh3daloFDFQUn5TXRb1yQ9HKkulNevcAbR
         LAb46S6cw1SlnZoOvFLNcTMytCFAUndJS7nG0YIibzf0vzxzviuKcuFEpjVAzbCt43mR
         Y71w==
X-Gm-Message-State: AOAM533XWdxL5fwKH0w8qDEou3ot6uYJxepleiSPnpi0VzaMKbGKfYE8
        hFSqNzryezg8gLr51xSZxo+C
X-Google-Smtp-Source: ABdhPJxKpp+glzQIp7wyN6o1dTiUL3cT6S2WBnSxDCx4MXU22iqzGE7UczsqWmqcM7XSPn3RX4/Iuw==
X-Received: by 2002:a17:902:cf02:b0:14f:e0c2:1514 with SMTP id i2-20020a170902cf0200b0014fe0c21514mr20483417plg.90.1646052286817;
        Mon, 28 Feb 2022 04:44:46 -0800 (PST)
Received: from localhost.localdomain ([117.207.25.37])
        by smtp.gmail.com with ESMTPSA id y12-20020a056a00190c00b004f39e28fb87sm14256737pfi.98.2022.02.28.04.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 04:44:46 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        quic_vbadigan@quicinc.com, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Hemant Kumar <hemantk@codeaurora.org>
Subject: [PATCH v4 09/27] bus: mhi: Make mhi_state_str[] array static inline and move to common.h
Date:   Mon, 28 Feb 2022 18:13:26 +0530
Message-Id: <20220228124344.77359-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228124344.77359-1-manivannan.sadhasivam@linaro.org>
References: <20220228124344.77359-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mhi_state_str[] array could be used by MHI endpoint stack also. So let's
make the array as "static inline function" and move it inside the
"common.h" header so that the endpoint stack could also make use of it.

Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/common.h       | 29 +++++++++++++++++++++++++----
 drivers/bus/mhi/host/boot.c    |  2 +-
 drivers/bus/mhi/host/debugfs.c |  6 +++---
 drivers/bus/mhi/host/init.c    | 12 ------------
 drivers/bus/mhi/host/main.c    |  8 ++++----
 drivers/bus/mhi/host/pm.c      | 14 +++++++-------
 6 files changed, 40 insertions(+), 31 deletions(-)

diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
index f2690bf11c99..ec75ba1e6686 100644
--- a/drivers/bus/mhi/common.h
+++ b/drivers/bus/mhi/common.h
@@ -275,9 +275,30 @@ struct mhi_ring_element {
 	__le32 dword[2];
 };
 
-extern const char * const mhi_state_str[MHI_STATE_MAX];
-#define TO_MHI_STATE_STR(state) ((state >= MHI_STATE_MAX || \
-				  !mhi_state_str[state]) ? \
-				"INVALID_STATE" : mhi_state_str[state])
+static inline const char * const mhi_state_str(enum mhi_state state)
+{
+	switch (state) {
+	case MHI_STATE_RESET:
+		return "RESET";
+	case MHI_STATE_READY:
+		return "READY";
+	case MHI_STATE_M0:
+		return "M0";
+	case MHI_STATE_M1:
+		return "M1";
+	case MHI_STATE_M2:
+		return "M2";
+	case MHI_STATE_M3:
+		return "M3";
+	case MHI_STATE_M3_FAST:
+		return "M3 FAST";
+	case MHI_STATE_BHI:
+		return "BHI";
+	case MHI_STATE_SYS_ERR:
+		return "SYS ERROR";
+	default:
+		return "Unknown state";
+	}
+};
 
 #endif /* _MHI_COMMON_H */
diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
index d5ba3c7efb61..b0da7ca4519c 100644
--- a/drivers/bus/mhi/host/boot.c
+++ b/drivers/bus/mhi/host/boot.c
@@ -67,7 +67,7 @@ static int __mhi_download_rddm_in_panic(struct mhi_controller *mhi_cntrl)
 
 	dev_dbg(dev, "Entered with pm_state:%s dev_state:%s ee:%s\n",
 		to_mhi_pm_state_str(mhi_cntrl->pm_state),
-		TO_MHI_STATE_STR(mhi_cntrl->dev_state),
+		mhi_state_str(mhi_cntrl->dev_state),
 		TO_MHI_EXEC_STR(mhi_cntrl->ee));
 
 	/*
diff --git a/drivers/bus/mhi/host/debugfs.c b/drivers/bus/mhi/host/debugfs.c
index bdc875d7bd4d..cfec7811dfbb 100644
--- a/drivers/bus/mhi/host/debugfs.c
+++ b/drivers/bus/mhi/host/debugfs.c
@@ -20,7 +20,7 @@ static int mhi_debugfs_states_show(struct seq_file *m, void *d)
 	seq_printf(m, "PM state: %s Device: %s MHI state: %s EE: %s wake: %s\n",
 		   to_mhi_pm_state_str(mhi_cntrl->pm_state),
 		   mhi_is_active(mhi_cntrl) ? "Active" : "Inactive",
-		   TO_MHI_STATE_STR(mhi_cntrl->dev_state),
+		   mhi_state_str(mhi_cntrl->dev_state),
 		   TO_MHI_EXEC_STR(mhi_cntrl->ee),
 		   mhi_cntrl->wake_set ? "true" : "false");
 
@@ -206,13 +206,13 @@ static int mhi_debugfs_regdump_show(struct seq_file *m, void *d)
 
 	seq_printf(m, "Host PM state: %s Device state: %s EE: %s\n",
 		   to_mhi_pm_state_str(mhi_cntrl->pm_state),
-		   TO_MHI_STATE_STR(mhi_cntrl->dev_state),
+		   mhi_state_str(mhi_cntrl->dev_state),
 		   TO_MHI_EXEC_STR(mhi_cntrl->ee));
 
 	state = mhi_get_mhi_state(mhi_cntrl);
 	ee = mhi_get_exec_env(mhi_cntrl);
 	seq_printf(m, "Device EE: %s state: %s\n", TO_MHI_EXEC_STR(ee),
-		   TO_MHI_STATE_STR(state));
+		   mhi_state_str(state));
 
 	for (i = 0; regs[i].name; i++) {
 		if (!regs[i].base)
diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index 016dcc35db80..a665b8e92408 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -45,18 +45,6 @@ const char * const dev_state_tran_str[DEV_ST_TRANSITION_MAX] = {
 	[DEV_ST_TRANSITION_DISABLE] = "DISABLE",
 };
 
-const char * const mhi_state_str[MHI_STATE_MAX] = {
-	[MHI_STATE_RESET] = "RESET",
-	[MHI_STATE_READY] = "READY",
-	[MHI_STATE_M0] = "M0",
-	[MHI_STATE_M1] = "M1",
-	[MHI_STATE_M2] = "M2",
-	[MHI_STATE_M3] = "M3",
-	[MHI_STATE_M3_FAST] = "M3 FAST",
-	[MHI_STATE_BHI] = "BHI",
-	[MHI_STATE_SYS_ERR] = "SYS ERROR",
-};
-
 const char * const mhi_ch_state_type_str[MHI_CH_STATE_TYPE_MAX] = {
 	[MHI_CH_STATE_TYPE_RESET] = "RESET",
 	[MHI_CH_STATE_TYPE_STOP] = "STOP",
diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index dabf85b92a84..9021be7f2359 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -477,8 +477,8 @@ irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *priv)
 	ee = mhi_get_exec_env(mhi_cntrl);
 	dev_dbg(dev, "local ee: %s state: %s device ee: %s state: %s\n",
 		TO_MHI_EXEC_STR(mhi_cntrl->ee),
-		TO_MHI_STATE_STR(mhi_cntrl->dev_state),
-		TO_MHI_EXEC_STR(ee), TO_MHI_STATE_STR(state));
+		mhi_state_str(mhi_cntrl->dev_state),
+		TO_MHI_EXEC_STR(ee), mhi_state_str(state));
 
 	if (state == MHI_STATE_SYS_ERR) {
 		dev_dbg(dev, "System error detected\n");
@@ -844,7 +844,7 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
 			new_state = MHI_TRE_GET_EV_STATE(local_rp);
 
 			dev_dbg(dev, "State change event to state: %s\n",
-				TO_MHI_STATE_STR(new_state));
+				mhi_state_str(new_state));
 
 			switch (new_state) {
 			case MHI_STATE_M0:
@@ -871,7 +871,7 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
 			}
 			default:
 				dev_err(dev, "Invalid state: %s\n",
-					TO_MHI_STATE_STR(new_state));
+					mhi_state_str(new_state));
 			}
 
 			break;
diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
index bb8a23e80e19..3d90b8ecd3d9 100644
--- a/drivers/bus/mhi/host/pm.c
+++ b/drivers/bus/mhi/host/pm.c
@@ -541,7 +541,7 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
 
 	dev_dbg(dev, "Exiting with PM state: %s, MHI state: %s\n",
 		to_mhi_pm_state_str(mhi_cntrl->pm_state),
-		TO_MHI_STATE_STR(mhi_cntrl->dev_state));
+		mhi_state_str(mhi_cntrl->dev_state));
 
 	mutex_unlock(&mhi_cntrl->pm_mutex);
 }
@@ -684,7 +684,7 @@ static void mhi_pm_sys_error_transition(struct mhi_controller *mhi_cntrl)
 exit_sys_error_transition:
 	dev_dbg(dev, "Exiting with PM state: %s, MHI state: %s\n",
 		to_mhi_pm_state_str(mhi_cntrl->pm_state),
-		TO_MHI_STATE_STR(mhi_cntrl->dev_state));
+		mhi_state_str(mhi_cntrl->dev_state));
 
 	mutex_unlock(&mhi_cntrl->pm_mutex);
 }
@@ -859,7 +859,7 @@ int mhi_pm_suspend(struct mhi_controller *mhi_cntrl)
 	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
 		dev_err(dev,
 			"Did not enter M3 state, MHI state: %s, PM state: %s\n",
-			TO_MHI_STATE_STR(mhi_cntrl->dev_state),
+			mhi_state_str(mhi_cntrl->dev_state),
 			to_mhi_pm_state_str(mhi_cntrl->pm_state));
 		return -EIO;
 	}
@@ -885,7 +885,7 @@ static int __mhi_pm_resume(struct mhi_controller *mhi_cntrl, bool force)
 
 	dev_dbg(dev, "Entered with PM state: %s, MHI state: %s\n",
 		to_mhi_pm_state_str(mhi_cntrl->pm_state),
-		TO_MHI_STATE_STR(mhi_cntrl->dev_state));
+		mhi_state_str(mhi_cntrl->dev_state));
 
 	if (mhi_cntrl->pm_state == MHI_PM_DISABLE)
 		return 0;
@@ -895,7 +895,7 @@ static int __mhi_pm_resume(struct mhi_controller *mhi_cntrl, bool force)
 
 	if (mhi_get_mhi_state(mhi_cntrl) != MHI_STATE_M3) {
 		dev_warn(dev, "Resuming from non M3 state (%s)\n",
-			 TO_MHI_STATE_STR(mhi_get_mhi_state(mhi_cntrl)));
+			 mhi_state_str(mhi_get_mhi_state(mhi_cntrl)));
 		if (!force)
 			return -EINVAL;
 	}
@@ -932,7 +932,7 @@ static int __mhi_pm_resume(struct mhi_controller *mhi_cntrl, bool force)
 	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
 		dev_err(dev,
 			"Did not enter M0 state, MHI state: %s, PM state: %s\n",
-			TO_MHI_STATE_STR(mhi_cntrl->dev_state),
+			mhi_state_str(mhi_cntrl->dev_state),
 			to_mhi_pm_state_str(mhi_cntrl->pm_state));
 		return -EIO;
 	}
@@ -1083,7 +1083,7 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
 
 	state = mhi_get_mhi_state(mhi_cntrl);
 	dev_dbg(dev, "Attempting power on with EE: %s, state: %s\n",
-		TO_MHI_EXEC_STR(current_ee), TO_MHI_STATE_STR(state));
+		TO_MHI_EXEC_STR(current_ee), mhi_state_str(state));
 
 	if (state == MHI_STATE_SYS_ERR) {
 		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_RESET);
-- 
2.25.1

