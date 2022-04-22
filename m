Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A40550C4D8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiDVXsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 19:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiDVXsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 19:48:30 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B169F57B38;
        Fri, 22 Apr 2022 16:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650671135; x=1682207135;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=4lI5QQVTvYeP8wkKNBfN+3WtQcv3wu/e6yW5dEZ3qWQ=;
  b=e1tgnpCOdd8bDpKJ8wPl5sRRrXOOkgmnrIR70CxQUl0rgJ2CeCiF4RAD
   vO3YluGEUOACPx+KqaJFSW/wAKJ8W5AUBl+Fs8TdLac8TyOtA++9Gf8RB
   eCfS+za2tGLXcqCD1x1nVtfMv6DnRPVEdTIKxG0RnITHcOHpjXKxdmGQJ
   0=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 22 Apr 2022 16:45:34 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 16:45:33 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 22 Apr 2022 16:45:33 -0700
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 22 Apr 2022 16:45:32 -0700
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <robdclark@gmail.com>, <sean@poorly.run>, <swboyd@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@linux.ie>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <bjorn.andersson@linaro.org>
CC:     <quic_abhinavk@quicinc.com>, <quic_aravindh@quicinc.com>,
        <quic_khsieh@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/msm/dp: move add fail safe mode to dp_connector_get_mode()
Date:   Fri, 22 Apr 2022 16:45:23 -0700
Message-ID: <1650671124-14030-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current DP driver implementation has adding safe mode done at
dp_hpd_plug_handle() which is expected to be executed under event
thread context.

However there is possible circular locking happen (see blow stack trace)
after edp driver call dp_hpd_plug_handle() from dp_bridge_enable() which
is executed under drm_thread context.

To break this circular locking, this patch have safe mode added at
dp_connector_get_mode() which is executed under drm thread context.
Therefore no lock acquired required for &dev->mode_config.mutex while
adding fail safe mode since it has been hold by drm thread already.

======================================================
 WARNING: possible circular locking dependency detected
 5.15.35-lockdep #6 Tainted: G        W
 ------------------------------------------------------
 frecon/429 is trying to acquire lock:
 ffffff808dc3c4e8 (&dev->mode_config.mutex){+.+.}-{3:3}, at:
dp_panel_add_fail_safe_mode+0x4c/0xa0

 but task is already holding lock:
 ffffff808dc441e0 (&kms->commit_lock[i]){+.+.}-{3:3}, at: lock_crtcs+0xb4/0x124

 which lock already depends on the new lock.

 the existing dependency chain (in reverse order) is:

 -> #3 (&kms->commit_lock[i]){+.+.}-{3:3}:
        __mutex_lock_common+0x174/0x1a64
        mutex_lock_nested+0x98/0xac
        lock_crtcs+0xb4/0x124
        msm_atomic_commit_tail+0x330/0x748
        commit_tail+0x19c/0x278
        drm_atomic_helper_commit+0x1dc/0x1f0
        drm_atomic_commit+0xc0/0xd8
        drm_atomic_helper_set_config+0xb4/0x134
        drm_mode_setcrtc+0x688/0x1248
        drm_ioctl_kernel+0x1e4/0x338
        drm_ioctl+0x3a4/0x684
        __arm64_sys_ioctl+0x118/0x154
        invoke_syscall+0x78/0x224
        el0_svc_common+0x178/0x200
        do_el0_svc+0x94/0x13c
        el0_svc+0x5c/0xec
        el0t_64_sync_handler+0x78/0x108
        el0t_64_sync+0x1a4/0x1a8

 -> #2 (crtc_ww_class_mutex){+.+.}-{3:3}:
        __mutex_lock_common+0x174/0x1a64
        ww_mutex_lock+0xb8/0x278
        modeset_lock+0x304/0x4ac
        drm_modeset_lock+0x4c/0x7c
        drmm_mode_config_init+0x4a8/0xc50
        msm_drm_init+0x274/0xac0
        msm_drm_bind+0x20/0x2c
        try_to_bring_up_master+0x3dc/0x470
        __component_add+0x18c/0x3c0
        component_add+0x1c/0x28
        dp_display_probe+0x954/0xa98
        platform_probe+0x124/0x15c
        really_probe+0x1b0/0x5f8
        __driver_probe_device+0x174/0x20c
        driver_probe_device+0x70/0x134
        __device_attach_driver+0x130/0x1d0
        bus_for_each_drv+0xfc/0x14c
        __device_attach+0x1bc/0x2bc
        device_initial_probe+0x1c/0x28
        bus_probe_device+0x94/0x178
        deferred_probe_work_func+0x1a4/0x1f0
        process_one_work+0x5d4/0x9dc
        worker_thread+0x898/0xccc
        kthread+0x2d4/0x3d4
        ret_from_fork+0x10/0x20

 -> #1 (crtc_ww_class_acquire){+.+.}-{0:0}:
        ww_acquire_init+0x1c4/0x2c8
        drm_modeset_acquire_init+0x44/0xc8
        drm_helper_probe_single_connector_modes+0xb0/0x12dc
        drm_mode_getconnector+0x5dc/0xfe8
        drm_ioctl_kernel+0x1e4/0x338
        drm_ioctl+0x3a4/0x684
        __arm64_sys_ioctl+0x118/0x154
        invoke_syscall+0x78/0x224
        el0_svc_common+0x178/0x200
        do_el0_svc+0x94/0x13c
        el0_svc+0x5c/0xec
        el0t_64_sync_handler+0x78/0x108
        el0t_64_sync+0x1a4/0x1a8

 -> #0 (&dev->mode_config.mutex){+.+.}-{3:3}:
        __lock_acquire+0x2650/0x672c
        lock_acquire+0x1b4/0x4ac
        __mutex_lock_common+0x174/0x1a64
        mutex_lock_nested+0x98/0xac
        dp_panel_add_fail_safe_mode+0x4c/0xa0
        dp_hpd_plug_handle+0x1f0/0x280
        dp_bridge_enable+0x94/0x2b8
        drm_atomic_bridge_chain_enable+0x11c/0x168
        drm_atomic_helper_commit_modeset_enables+0x500/0x740
        msm_atomic_commit_tail+0x3e4/0x748
        commit_tail+0x19c/0x278
        drm_atomic_helper_commit+0x1dc/0x1f0
        drm_atomic_commit+0xc0/0xd8
        drm_atomic_helper_set_config+0xb4/0x134
        drm_mode_setcrtc+0x688/0x1248
        drm_ioctl_kernel+0x1e4/0x338
        drm_ioctl+0x3a4/0x684
        __arm64_sys_ioctl+0x118/0x154
        invoke_syscall+0x78/0x224
        el0_svc_common+0x178/0x200
        do_el0_svc+0x94/0x13c
        el0_svc+0x5c/0xec
        el0t_64_sync_handler+0x78/0x108
        el0t_64_sync+0x1a4/0x1a8

Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c |  6 ------
 drivers/gpu/drm/msm/dp/dp_panel.c   | 23 +++++++++++++----------
 2 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 92cd50f..01453db 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -555,12 +555,6 @@ static int dp_hpd_plug_handle(struct dp_display_private *dp, u32 data)
 
 	mutex_unlock(&dp->event_mutex);
 
-	/*
-	 * add fail safe mode outside event_mutex scope
-	 * to avoid potiential circular lock with drm thread
-	 */
-	dp_panel_add_fail_safe_mode(dp->dp_display.connector);
-
 	/* uevent will complete connection part */
 	return 0;
 };
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index 1aa9aa8c..23fee42 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -151,15 +151,6 @@ static int dp_panel_update_modes(struct drm_connector *connector,
 	return rc;
 }
 
-void dp_panel_add_fail_safe_mode(struct drm_connector *connector)
-{
-	/* fail safe edid */
-	mutex_lock(&connector->dev->mode_config.mutex);
-	if (drm_add_modes_noedid(connector, 640, 480))
-		drm_set_preferred_mode(connector, 640, 480);
-	mutex_unlock(&connector->dev->mode_config.mutex);
-}
-
 int dp_panel_read_sink_caps(struct dp_panel *dp_panel,
 	struct drm_connector *connector)
 {
@@ -216,7 +207,11 @@ int dp_panel_read_sink_caps(struct dp_panel *dp_panel,
 			goto end;
 		}
 
-		dp_panel_add_fail_safe_mode(connector);
+		/* fail safe edid */
+		mutex_lock(&connector->dev->mode_config.mutex);
+		if (drm_add_modes_noedid(connector, 640, 480))
+			drm_set_preferred_mode(connector, 640, 480);
+		mutex_unlock(&connector->dev->mode_config.mutex);
 	}
 
 	if (panel->aux_cfg_update_done) {
@@ -266,6 +261,14 @@ int dp_panel_get_modes(struct dp_panel *dp_panel,
 		return -EINVAL;
 	}
 
+	/*
+	 * add fail safe mode (640x480) here
+	 * since we are executed in drm_thread context,
+	 * no mode_config.mutex acquired required
+	 */
+	if (drm_add_modes_noedid(connector, 640, 480))
+		drm_set_preferred_mode(connector, 640, 480);
+
 	if (dp_panel->edid)
 		return dp_panel_update_modes(connector, dp_panel->edid);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

