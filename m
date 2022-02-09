Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6434AEFBE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 12:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiBILKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 06:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiBILKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 06:10:03 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CEFE082424
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 02:05:42 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id qe15so1686736pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 02:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WzBlRAqaKZt/cvk0GvDHVFqZ6keDkxqYndpAeLkDyks=;
        b=C8ZToXeYb3OeIPRNngYQSOXNJ1gqjdWUq+gQaO8OntsooEx/OU2yn3zdiFOGpgocgW
         AWFh19Oo/61mShAM1TFTOje5jFEc/lpv74LqBceEAsKYq0LVwc5fkssp8JDoIlBdMrpR
         3FasoEZI0OhcPTu8AertWdw2kkBqZejH5pwJEIGucaGarKlQXSNlj4MICNo8sm6TnOVq
         Pz+TtKkUO4E+H0sQLEDpMIwIvlF95PN5Sqa/pZT0aiUBMBWDEqSw3c2B3LqBpRtWlw7S
         +2xnU7xycQcCRLC18PbTkfiIp6ojOwdgRd+Wrm3v4JZbw+/eCoeL4jaAJC0elX1s0oLq
         /vfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WzBlRAqaKZt/cvk0GvDHVFqZ6keDkxqYndpAeLkDyks=;
        b=qzO3z+Vo0PpdnfY8apTSCQxbyJcJj85dsYzFAEMSOT9G/FhU8BtZMrGTWHOLHNQj0V
         4g3hluttKbMaXmMQ0OM7lQOzRPqfUJNmxE82LjgROjI4L+/H82z3gNeou5h/pINVxqBc
         z6Z+AW3CVupJ0utTzKMZBiF4HFhZQXcs582N4eHN02o8ZUW/7K6cuYuX1YE04M6whXZG
         +73LQSUbBepWLOKqXwZwUAgyI/jS4Ftfs0e7b3kzRA3bBOROKGoIPGjr/VSyR9sLCXlB
         WrrD1nljwEsTC75B/FAA6bNB1+JLrCcnVIZzHHGc68aowjCJLuouWkxkdtkfTw8IGEzg
         K6AQ==
X-Gm-Message-State: AOAM533hAUQI1PEkG97zKLMb8VWsr9BrPH7cxbTGVlYCUR/ecpRqmhpP
        gGOCwUenSpU4FRy5+7t8Ijlq
X-Google-Smtp-Source: ABdhPJw7vFQFce7/ORmItBfpRIo0eyAoh0l/LsY9aXaHO0USLjCN40tyenV3pWif85NZQlC+dqXwpQ==
X-Received: by 2002:a17:902:d48e:: with SMTP id c14mr1616183plg.129.1644401137907;
        Wed, 09 Feb 2022 02:05:37 -0800 (PST)
Received: from localhost.localdomain ([117.217.179.178])
        by smtp.gmail.com with ESMTPSA id p2sm6722024pfo.125.2022.02.09.02.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 02:05:37 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        vbadigan@codeaurora.org, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 05/23] bus: mhi: Make mhi_state_str[] array static inline and move to common.h
Date:   Wed,  9 Feb 2022 15:26:06 +0530
Message-Id: <20220209095624.26389-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209095624.26389-1-manivannan.sadhasivam@linaro.org>
References: <20220209095624.26389-1-manivannan.sadhasivam@linaro.org>
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

mhi_state_str[] array could be used by MHI endpoint stack also. So let's
make the array as "static inline function" and move it inside the
"common.h" header so that the endpoint stack could also make use of it.

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
index 0d13a202d334..897813c58ffb 100644
--- a/drivers/bus/mhi/common.h
+++ b/drivers/bus/mhi/common.h
@@ -159,9 +159,30 @@ struct mhi_cmd_ctxt {
 	__le64 wp __packed __aligned(4);
 };
 
-extern const char * const mhi_state_str[MHI_STATE_MAX];
-#define TO_MHI_STATE_STR(state) ((state >= MHI_STATE_MAX || \
-				  !mhi_state_str[state]) ? \
-				"INVALID_STATE" : mhi_state_str[state])
+static inline const char * const mhi_state_str(enum mhi_state state)
+{
+	switch(state) {
+	case MHI_STATE_RESET:
+		return "RESET";
+	case MHI_STATE_READY:
+		return "READY";
+	case MHI_STATE_M0:
+		return "M0";
+	case MHI_STATE_M1:
+		return "M1";
+	case MHI_STATE_M2:
+		return"M2";
+	case MHI_STATE_M3:
+		return"M3";
+	case MHI_STATE_M3_FAST:
+		return"M3 FAST";
+	case MHI_STATE_BHI:
+		return"BHI";
+	case MHI_STATE_SYS_ERR:
+		return "SYS ERROR";
+	default:
+		return "Unknown state";
+	}
+};
 
 #endif /* _MHI_COMMON_H */
diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
index 74295d3cc662..93cb705614c6 100644
--- a/drivers/bus/mhi/host/boot.c
+++ b/drivers/bus/mhi/host/boot.c
@@ -68,7 +68,7 @@ static int __mhi_download_rddm_in_panic(struct mhi_controller *mhi_cntrl)
 
 	dev_dbg(dev, "Entered with pm_state:%s dev_state:%s ee:%s\n",
 		to_mhi_pm_state_str(mhi_cntrl->pm_state),
-		TO_MHI_STATE_STR(mhi_cntrl->dev_state),
+		mhi_state_str(mhi_cntrl->dev_state),
 		TO_MHI_EXEC_STR(mhi_cntrl->ee));
 
 	/*
diff --git a/drivers/bus/mhi/host/debugfs.c b/drivers/bus/mhi/host/debugfs.c
index d818586c229d..399d0db1f1eb 100644
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
index 17db8602d9ee..12ce688a0734 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -44,18 +44,6 @@ const char * const dev_state_tran_str[DEV_ST_TRANSITION_MAX] = {
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
index 85f4f7c8d7c6..e436c2993d97 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -479,8 +479,8 @@ irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *priv)
 	ee = mhi_get_exec_env(mhi_cntrl);
 	dev_dbg(dev, "local ee: %s state: %s device ee: %s state: %s\n",
 		TO_MHI_EXEC_STR(mhi_cntrl->ee),
-		TO_MHI_STATE_STR(mhi_cntrl->dev_state),
-		TO_MHI_EXEC_STR(ee), TO_MHI_STATE_STR(state));
+		mhi_state_str(mhi_cntrl->dev_state),
+		TO_MHI_EXEC_STR(ee), mhi_state_str(state));
 
 	if (state == MHI_STATE_SYS_ERR) {
 		dev_dbg(dev, "System error detected\n");
@@ -846,7 +846,7 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
 			new_state = MHI_TRE_GET_EV_STATE(local_rp);
 
 			dev_dbg(dev, "State change event to state: %s\n",
-				TO_MHI_STATE_STR(new_state));
+				mhi_state_str(new_state));
 
 			switch (new_state) {
 			case MHI_STATE_M0:
@@ -873,7 +873,7 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
 			}
 			default:
 				dev_err(dev, "Invalid state: %s\n",
-					TO_MHI_STATE_STR(new_state));
+					mhi_state_str(new_state));
 			}
 
 			break;
diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
index c35c5ddc7220..088ade0f3e0b 100644
--- a/drivers/bus/mhi/host/pm.c
+++ b/drivers/bus/mhi/host/pm.c
@@ -545,7 +545,7 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
 
 	dev_dbg(dev, "Exiting with PM state: %s, MHI state: %s\n",
 		to_mhi_pm_state_str(mhi_cntrl->pm_state),
-		TO_MHI_STATE_STR(mhi_cntrl->dev_state));
+		mhi_state_str(mhi_cntrl->dev_state));
 
 	mutex_unlock(&mhi_cntrl->pm_mutex);
 }
@@ -689,7 +689,7 @@ static void mhi_pm_sys_error_transition(struct mhi_controller *mhi_cntrl)
 exit_sys_error_transition:
 	dev_dbg(dev, "Exiting with PM state: %s, MHI state: %s\n",
 		to_mhi_pm_state_str(mhi_cntrl->pm_state),
-		TO_MHI_STATE_STR(mhi_cntrl->dev_state));
+		mhi_state_str(mhi_cntrl->dev_state));
 
 	mutex_unlock(&mhi_cntrl->pm_mutex);
 }
@@ -864,7 +864,7 @@ int mhi_pm_suspend(struct mhi_controller *mhi_cntrl)
 	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
 		dev_err(dev,
 			"Did not enter M3 state, MHI state: %s, PM state: %s\n",
-			TO_MHI_STATE_STR(mhi_cntrl->dev_state),
+			mhi_state_str(mhi_cntrl->dev_state),
 			to_mhi_pm_state_str(mhi_cntrl->pm_state));
 		return -EIO;
 	}
@@ -890,7 +890,7 @@ static int __mhi_pm_resume(struct mhi_controller *mhi_cntrl, bool force)
 
 	dev_dbg(dev, "Entered with PM state: %s, MHI state: %s\n",
 		to_mhi_pm_state_str(mhi_cntrl->pm_state),
-		TO_MHI_STATE_STR(mhi_cntrl->dev_state));
+		mhi_state_str(mhi_cntrl->dev_state));
 
 	if (mhi_cntrl->pm_state == MHI_PM_DISABLE)
 		return 0;
@@ -900,7 +900,7 @@ static int __mhi_pm_resume(struct mhi_controller *mhi_cntrl, bool force)
 
 	if (mhi_get_mhi_state(mhi_cntrl) != MHI_STATE_M3) {
 		dev_warn(dev, "Resuming from non M3 state (%s)\n",
-			 TO_MHI_STATE_STR(mhi_get_mhi_state(mhi_cntrl)));
+			 mhi_state_str(mhi_get_mhi_state(mhi_cntrl)));
 		if (!force)
 			return -EINVAL;
 	}
@@ -937,7 +937,7 @@ static int __mhi_pm_resume(struct mhi_controller *mhi_cntrl, bool force)
 	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
 		dev_err(dev,
 			"Did not enter M0 state, MHI state: %s, PM state: %s\n",
-			TO_MHI_STATE_STR(mhi_cntrl->dev_state),
+			mhi_state_str(mhi_cntrl->dev_state),
 			to_mhi_pm_state_str(mhi_cntrl->pm_state));
 		return -EIO;
 	}
@@ -1088,7 +1088,7 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
 
 	state = mhi_get_mhi_state(mhi_cntrl);
 	dev_dbg(dev, "Attempting power on with EE: %s, state: %s\n",
-		TO_MHI_EXEC_STR(current_ee), TO_MHI_STATE_STR(state));
+		TO_MHI_EXEC_STR(current_ee), mhi_state_str(state));
 
 	if (state == MHI_STATE_SYS_ERR) {
 		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_RESET);
-- 
2.25.1

