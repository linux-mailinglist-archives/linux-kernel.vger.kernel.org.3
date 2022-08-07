Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6335D58BB1B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 15:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbiHGNzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 09:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbiHGNzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 09:55:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA9564F2
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 06:55:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C4C2B80B48
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 13:55:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE623C433D7;
        Sun,  7 Aug 2022 13:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659880501;
        bh=YqL5hVbTduOLYacfaW6D5OrsJLDmpwexRMpaYCbTX5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ckYDPuV0Xpg8EVmBHiVSqgGKv3U56dAUCv5NHy0NuS3lOFnioZwMsOy9Kf3wyZAR1
         Ea38FhodNHO1QGzml1siwQcn/zsO1RL5R3aaiFb1o8Ck0Z78nGK+9RphcT1Zy0tOpN
         CD0uwsX4ZDgtstn/1ZLzOT5HghxALzepjPsmafiPklQNZR5n5T89WVBEDVvbOcD27f
         abI4YWgTe17MQRxcWFt3uH8/YXEIP0nmIL3twx4yu0PXcZ7nKnRB3L66nDOVJbGWMG
         f0P0CZl9z8AJJPivNH/Ab7n/dFpuuF8swwKhzATqQVWNTq8LnxpSyzBeNE02mZcrCr
         Fm69pwoWECS/Q==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 4/6] habanalabs: unify hwmon resources clean up
Date:   Sun,  7 Aug 2022 16:54:50 +0300
Message-Id: <20220807135452.1219894-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220807135452.1219894-1-ogabbay@kernel.org>
References: <20220807135452.1219894-1-ogabbay@kernel.org>
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

From: Dani Liberman <dliberman@habana.ai>

Since hwmon fini code is common for all asics, unified it to common
function.

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h |  1 +
 drivers/misc/habanalabs/common/hwmon.c      | 21 +++++++++++++++++++++
 drivers/misc/habanalabs/gaudi/gaudi.c       | 18 +-----------------
 drivers/misc/habanalabs/gaudi2/gaudi2.c     | 18 +-----------------
 drivers/misc/habanalabs/goya/goya.c         | 17 +----------------
 5 files changed, 25 insertions(+), 50 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index ae3f5832fe58..f495a4b82f73 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -3529,6 +3529,7 @@ void hl_sysfs_fini(struct hl_device *hdev);
 
 int hl_hwmon_init(struct hl_device *hdev);
 void hl_hwmon_fini(struct hl_device *hdev);
+void hl_hwmon_release_resources(struct hl_device *hdev);
 
 int hl_cb_create(struct hl_device *hdev, struct hl_mem_mgr *mmg,
 			struct hl_ctx *ctx, u32 cb_size, bool internal_cb,
diff --git a/drivers/misc/habanalabs/common/hwmon.c b/drivers/misc/habanalabs/common/hwmon.c
index 57f5d2c48330..8c262aeb425e 100644
--- a/drivers/misc/habanalabs/common/hwmon.c
+++ b/drivers/misc/habanalabs/common/hwmon.c
@@ -910,3 +910,24 @@ void hl_hwmon_fini(struct hl_device *hdev)
 
 	hwmon_device_unregister(hdev->hwmon_dev);
 }
+
+void hl_hwmon_release_resources(struct hl_device *hdev)
+{
+	const struct hwmon_channel_info **channel_info_arr;
+	int i = 0;
+
+	if (!hdev->hl_chip_info->info)
+		return;
+
+	channel_info_arr = hdev->hl_chip_info->info;
+
+	while (channel_info_arr[i]) {
+		kfree(channel_info_arr[i]->config);
+		kfree(channel_info_arr[i]);
+		i++;
+	}
+
+	kfree(channel_info_arr);
+
+	hdev->hl_chip_info->info = NULL;
+}
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 7f52935dc603..96020693ac29 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -1682,23 +1682,7 @@ static int gaudi_late_init(struct hl_device *hdev)
 
 static void gaudi_late_fini(struct hl_device *hdev)
 {
-	const struct hwmon_channel_info **channel_info_arr;
-	int i = 0;
-
-	if (!hdev->hl_chip_info->info)
-		return;
-
-	channel_info_arr = hdev->hl_chip_info->info;
-
-	while (channel_info_arr[i]) {
-		kfree(channel_info_arr[i]->config);
-		kfree(channel_info_arr[i]);
-		i++;
-	}
-
-	kfree(channel_info_arr);
-
-	hdev->hl_chip_info->info = NULL;
+	hl_hwmon_release_resources(hdev);
 }
 
 static int gaudi_alloc_cpu_accessible_dma_mem(struct hl_device *hdev)
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index d7fd5f916083..538ae2cf9626 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -2711,23 +2711,7 @@ static int gaudi2_late_init(struct hl_device *hdev)
 
 static void gaudi2_late_fini(struct hl_device *hdev)
 {
-	const struct hwmon_channel_info **channel_info_arr;
-	int i = 0;
-
-	if (!hdev->hl_chip_info->info)
-		return;
-
-	channel_info_arr = hdev->hl_chip_info->info;
-
-	while (channel_info_arr[i]) {
-		kfree(channel_info_arr[i]->config);
-		kfree(channel_info_arr[i]);
-		i++;
-	}
-
-	kfree(channel_info_arr);
-
-	hdev->hl_chip_info->info = NULL;
+	hl_hwmon_release_resources(hdev);
 }
 
 static void gaudi2_user_mapped_dec_init(struct gaudi2_device *gaudi2, u32 start_idx)
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 91429d6ea037..87465a28af0d 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -916,26 +916,11 @@ int goya_late_init(struct hl_device *hdev)
  */
 void goya_late_fini(struct hl_device *hdev)
 {
-	const struct hwmon_channel_info **channel_info_arr;
 	struct goya_device *goya = hdev->asic_specific;
-	int i = 0;
 
 	cancel_delayed_work_sync(&goya->goya_work->work_freq);
 
-	if (!hdev->hl_chip_info->info)
-		return;
-
-	channel_info_arr = hdev->hl_chip_info->info;
-
-	while (channel_info_arr[i]) {
-		kfree(channel_info_arr[i]->config);
-		kfree(channel_info_arr[i]);
-		i++;
-	}
-
-	kfree(channel_info_arr);
-
-	hdev->hl_chip_info->info = NULL;
+	hl_hwmon_release_resources(hdev);
 }
 
 static void goya_set_pci_memory_regions(struct hl_device *hdev)
-- 
2.25.1

