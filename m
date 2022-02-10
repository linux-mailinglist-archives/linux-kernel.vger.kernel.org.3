Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D915E4B1142
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 16:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243427AbiBJPFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 10:05:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243423AbiBJPFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 10:05:48 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E8E398
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 07:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644505549; x=1676041549;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=avB9gfF1dQpf9ouXWAEoycsyJSGtDd8lbJbB9o+Q0FQ=;
  b=hKTqFW3OMmwu8lThCAHycPCDiJ3xGtjeWjPGkjZmebT/fNuP7Fl8vGTa
   OmyzAjk3KeOgzEU2mmeQZtzbDL0lgUlkgVeZYAbeWi1kOAX0sOtYKojvd
   tPSX2G89O5qG9VjWqSyr1R/9hAPedDxdhZrOoDI2b9MhWNWoPLye/Ay4D
   2LNTVfsmjvAVoq/weOaI3YVCDTFxKZzUu6Blv2GNdHP89wlZbQhdyAWfp
   uH/bbkGl8YkhwLZlSuSbXBKRRDLq/PRhigLHFf5sbl2x98efID8d6Q0oH
   H2IpG9B35092GhKEUlDuzqrcgMsspbGbfobG5rIKUgUXqQXTOUNQt+Cf3
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="230153297"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="230153297"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 07:05:49 -0800
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="500422667"
Received: from barabano-mobl.ccr.corp.intel.com (HELO pujfalus-desk.ger.corp.intel.com) ([10.252.41.18])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 07:05:46 -0800
From:   Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To:     lgirdwood@gmail.com, broonie@kernel.org,
        pierre-louis.bossart@linux.intel.com,
        ranjani.sridharan@linux.intel.com
Cc:     alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, tiwai@suse.com,
        linux-kernel@vger.kernel.org, fred.oh@linux.intel.com
Subject: [PATCH v2 6/9] ASoC: SOF: sof-client: Add support for clients not managed by pm framework
Date:   Thu, 10 Feb 2022 17:05:22 +0200
Message-Id: <20220210150525.30756-7-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220210150525.30756-1-peter.ujfalusi@linux.intel.com>
References: <20220210150525.30756-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SOF client can be of 'passive' type, meaning that they do not handle
PM framework callbacks by themselves but rely on the auxiliary driver's
suspend and resume callbacks to be notified about the core's suspend or
resume event.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/pm.c         | 13 ++++++++++-
 sound/soc/sof/sof-client.c | 46 ++++++++++++++++++++++++++++++++++++++
 sound/soc/sof/sof-priv.h   | 12 ++++++++++
 3 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/pm.c b/sound/soc/sof/pm.c
index 197a88695fef..7300ecadabd9 100644
--- a/sound/soc/sof/pm.c
+++ b/sound/soc/sof/pm.c
@@ -167,6 +167,9 @@ static int sof_resume(struct device *dev, bool runtime_resume)
 		return ret;
 	}
 
+	/* Notify clients not managed by pm framework about core resume */
+	sof_resume_clients(sdev);
+
 	/* notify DSP of system resume */
 	ret = sof_send_pm_ctx_ipc(sdev, SOF_IPC_PM_CTX_RESTORE);
 	if (ret < 0)
@@ -180,6 +183,7 @@ static int sof_resume(struct device *dev, bool runtime_resume)
 static int sof_suspend(struct device *dev, bool runtime_suspend)
 {
 	struct snd_sof_dev *sdev = dev_get_drvdata(dev);
+	pm_message_t pm_state;
 	u32 target_state = 0;
 	int ret;
 
@@ -205,16 +209,23 @@ static int sof_suspend(struct device *dev, bool runtime_suspend)
 	}
 
 	target_state = snd_sof_dsp_power_target(sdev);
+	pm_state.event = target_state;
 
 	/* Skip to platform-specific suspend if DSP is entering D0 */
-	if (target_state == SOF_DSP_PM_D0)
+	if (target_state == SOF_DSP_PM_D0) {
+		/* Notify clients not managed by pm framework about core suspend */
+		sof_suspend_clients(sdev, pm_state);
 		goto suspend;
+	}
 
 	sof_tear_down_pipelines(sdev, false);
 
 	/* release trace */
 	snd_sof_release_trace(sdev);
 
+	/* Notify clients not managed by pm framework about core suspend */
+	sof_suspend_clients(sdev, pm_state);
+
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_DEBUG_ENABLE_DEBUGFS_CACHE)
 	/* cache debugfs contents during runtime suspend */
 	if (runtime_suspend)
diff --git a/sound/soc/sof/sof-client.c b/sound/soc/sof/sof-client.c
index 6f747d051b59..932bdea49c24 100644
--- a/sound/soc/sof/sof-client.c
+++ b/sound/soc/sof/sof-client.c
@@ -169,6 +169,52 @@ int sof_client_ipc_tx_message(struct sof_client_dev *cdev, void *ipc_msg,
 }
 EXPORT_SYMBOL_NS_GPL(sof_client_ipc_tx_message, SND_SOC_SOF_CLIENT);
 
+int sof_suspend_clients(struct snd_sof_dev *sdev, pm_message_t state)
+{
+	struct auxiliary_driver *adrv;
+	struct sof_client_dev *cdev;
+
+	mutex_lock(&sdev->ipc_client_mutex);
+
+	list_for_each_entry(cdev, &sdev->ipc_client_list, list) {
+		/* Skip devices without loaded driver */
+		if (!cdev->auxdev.dev.driver)
+			continue;
+
+		adrv = to_auxiliary_drv(cdev->auxdev.dev.driver);
+		if (adrv->suspend)
+			adrv->suspend(&cdev->auxdev, state);
+	}
+
+	mutex_unlock(&sdev->ipc_client_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(sof_suspend_clients, SND_SOC_SOF_CLIENT);
+
+int sof_resume_clients(struct snd_sof_dev *sdev)
+{
+	struct auxiliary_driver *adrv;
+	struct sof_client_dev *cdev;
+
+	mutex_lock(&sdev->ipc_client_mutex);
+
+	list_for_each_entry(cdev, &sdev->ipc_client_list, list) {
+		/* Skip devices without loaded driver */
+		if (!cdev->auxdev.dev.driver)
+			continue;
+
+		adrv = to_auxiliary_drv(cdev->auxdev.dev.driver);
+		if (adrv->resume)
+			adrv->resume(&cdev->auxdev);
+	}
+
+	mutex_unlock(&sdev->ipc_client_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(sof_resume_clients, SND_SOC_SOF_CLIENT);
+
 struct dentry *sof_client_get_debugfs_root(struct sof_client_dev *cdev)
 {
 	return cdev->sdev->debugfs_root;
diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index f641833f3ff9..39bbba5aeab2 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -653,6 +653,8 @@ int sof_register_clients(struct snd_sof_dev *sdev);
 void sof_unregister_clients(struct snd_sof_dev *sdev);
 void sof_client_ipc_rx_dispatcher(struct snd_sof_dev *sdev, void *msg_buf);
 void sof_client_fw_state_dispatcher(struct snd_sof_dev *sdev);
+int sof_suspend_clients(struct snd_sof_dev *sdev, pm_message_t state);
+int sof_resume_clients(struct snd_sof_dev *sdev);
 #else /* CONFIG_SND_SOC_SOF_CLIENT */
 static inline int sof_client_dev_register(struct snd_sof_dev *sdev, const char *name,
 					  u32 id, const void *data, size_t size)
@@ -681,6 +683,16 @@ static inline void sof_client_ipc_rx_dispatcher(struct snd_sof_dev *sdev, void *
 static inline void sof_client_fw_state_dispatcher(struct snd_sof_dev *sdev)
 {
 }
+
+static inline int sof_suspend_clients(struct snd_sof_dev *sdev, pm_message_t state)
+{
+	return 0;
+}
+
+static inline int sof_resume_clients(struct snd_sof_dev *sdev)
+{
+	return 0;
+}
 #endif /* CONFIG_SND_SOC_SOF_CLIENT */
 
 #endif
-- 
2.35.1

