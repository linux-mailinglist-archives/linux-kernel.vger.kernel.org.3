Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA1352341A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238226AbiEKNVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243791AbiEKNUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:20:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BCE2469CF
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 06:19:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51AA4B823DC
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 13:19:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23EE4C34112;
        Wed, 11 May 2022 13:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652275194;
        bh=wOtB+Buzvelw0zCj5dXvDag7eeVBFMQDGau1jG60SfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TfdtRzpnUjxd3QVcQMFXkqd5eqoQs/Fa7UpZF+7Sm5Ui319U8gT5eI7TWivVlVMSC
         AUiUJh0GYrhFAP589Ur1NSwYpiaJ1A6o8x8hMTP+X7TZGNL1y0gsFtWW02KNmK0i84
         NBLHNU78rlwOxPhwAfrVCEpILyMu0srpIKqgC3Y+HFrjrwPqsvoW7+hI2TLzf/Dt2H
         jX/IG1djAB3Qki7cekm9WXKw1f8vtr8JqVoMS05a07ENiMlrW3E0tmplgXp7t6FiiY
         VB+1AmAUseh7D+gmuXQXu45YEz+IaneEbadobJVyUkYnDmENWxvq/KQ3sFRmG18kLT
         j6GO5KpJWST3w==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>
Subject: [PATCH 2/3] habanalabs: use NULL for eventfd
Date:   Wed, 11 May 2022 16:19:47 +0300
Message-Id: <20220511131948.1156471-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511131948.1156471-1-ogabbay@kernel.org>
References: <20220511131948.1156471-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

eventfd is pointer. As such, it should be initialized to NULL, not to 0.

In addition, no need to initialize it after creation because the
entire structure is zeroed-out. Also, no need to initialize it before
release because the entire structure is freed.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c           | 8 ++------
 drivers/misc/habanalabs/common/habanalabs_drv.c   | 4 ----
 drivers/misc/habanalabs/common/habanalabs_ioctl.c | 4 ++--
 3 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 315510aaca35..0908ac301c70 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -286,10 +286,8 @@ static void hpriv_release(struct kref *ref)
 	hdev->compute_ctx_in_release = 0;
 
 	/* release the eventfd */
-	if (hpriv->notifier_event.eventfd) {
+	if (hpriv->notifier_event.eventfd)
 		eventfd_ctx_put(hpriv->notifier_event.eventfd);
-		hpriv->notifier_event.eventfd = 0;
-	}
 
 	mutex_destroy(&hpriv->notifier_event.lock);
 
@@ -364,10 +362,8 @@ static int hl_device_release_ctrl(struct inode *inode, struct file *filp)
 	mutex_unlock(&hdev->fpriv_ctrl_list_lock);
 out:
 	/* release the eventfd */
-	if (hpriv->notifier_event.eventfd) {
+	if (hpriv->notifier_event.eventfd)
 		eventfd_ctx_put(hpriv->notifier_event.eventfd);
-		hpriv->notifier_event.eventfd = 0;
-	}
 
 	mutex_destroy(&hpriv->notifier_event.lock);
 	put_pid(hpriv->taskpid);
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index c97173e9507d..9ead0927208d 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -134,8 +134,6 @@ int hl_device_open(struct inode *inode, struct file *filp)
 	hpriv->hdev = hdev;
 	filp->private_data = hpriv;
 	hpriv->filp = filp;
-	hpriv->notifier_event.events_mask = 0;
-	hpriv->notifier_event.eventfd = 0;
 
 	mutex_init(&hpriv->notifier_event.lock);
 	mutex_init(&hpriv->restore_phase_mutex);
@@ -246,8 +244,6 @@ int hl_device_open_ctrl(struct inode *inode, struct file *filp)
 	hpriv->hdev = hdev;
 	filp->private_data = hpriv;
 	hpriv->filp = filp;
-	hpriv->notifier_event.events_mask = 0;
-	hpriv->notifier_event.eventfd = 0;
 
 	mutex_init(&hpriv->notifier_event.lock);
 	nonseekable_open(inode, filp);
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index d1ef56a8d3ac..51fa56287309 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -647,7 +647,7 @@ static int eventfd_register(struct hl_fpriv *hpriv, struct hl_info_args *args)
 	hpriv->notifier_event.eventfd = eventfd_ctx_fdget(args->eventfd);
 	if (IS_ERR(hpriv->notifier_event.eventfd)) {
 		rc = PTR_ERR(hpriv->notifier_event.eventfd);
-		hpriv->notifier_event.eventfd = 0;
+		hpriv->notifier_event.eventfd = NULL;
 		mutex_unlock(&hpriv->notifier_event.lock);
 		return rc;
 	}
@@ -665,7 +665,7 @@ static int eventfd_unregister(struct hl_fpriv *hpriv, struct hl_info_args *args)
 	}
 
 	eventfd_ctx_put(hpriv->notifier_event.eventfd);
-	hpriv->notifier_event.eventfd = 0;
+	hpriv->notifier_event.eventfd = NULL;
 	mutex_unlock(&hpriv->notifier_event.lock);
 	return 0;
 }
-- 
2.25.1

