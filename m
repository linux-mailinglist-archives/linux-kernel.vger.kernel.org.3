Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BA257B52E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234912AbiGTLPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbiGTLPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:15:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266C125C55
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 04:15:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9963B81E20
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 11:15:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74C8C3411E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 11:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658315734;
        bh=ahfxepYWmDb8a2E/BPIW58QQG289wAVylz/ze1XMYtQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ntNFhLV0BA/sdOvf0Mw2GJI42c6DcQglhb2MABX+iIG01RTAN5Iicp0T0coiRA9dh
         KdF+z/OidV0yDfMkdErHqdX4ipOF7wQUtnjfojweGc43E6EBkM/zB6bTI3DfSIJI6W
         ZNMxvM71CnlfRIzE2TKnb1hUplimnFTFT4w5utPwU8VbdCpTYK7MOgozFmmpV6vJ9K
         WAYVGtnlbv5Nz9M8Key+GtVGPpaKS5lyKho7FvwxcMUc0L+Z6E9Nn44Zh/2tEOVTOE
         h0if+E0HzyLP8cndqm/0YII7D7b26+1InIWHoTXa54Gs/lSranYWhtfU+eblvtdZOT
         +cioJ68gRcc1w==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] habanalabs/gaudi: increase default cs timeout to 10 minutes
Date:   Wed, 20 Jul 2022 14:15:19 +0300
Message-Id: <20220720111523.4069830-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220720111523.4069830-1-ogabbay@kernel.org>
References: <20220720111523.4069830-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to improve scalability and reduce host overhead, it is better
to increase the default TDR timeout of Gaudi1 from 30 seconds to
10 minutes.

This will allow the DL Framework (e.g. PyTorch, TensorFlow) to remove
the host sync they are using now and improve overall performance on
scaleout training.

Note that one can always set the timeout to a custom value via
a kernel module parameter given during driver load.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../misc/habanalabs/common/habanalabs_drv.c   | 23 +++++++++++++++----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index f733ead605e7..d59d8cdf33e6 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -27,7 +27,10 @@ static struct class *hl_class;
 static DEFINE_IDR(hl_devs_idr);
 static DEFINE_MUTEX(hl_devs_idr_lock);
 
-static int timeout_locked = 30;
+#define HL_DEFAULT_TIMEOUT_LOCKED	30	/* 30 seconds */
+#define GAUDI_DEFAULT_TIMEOUT_LOCKED	600	/* 10 minutes */
+
+static int timeout_locked = HL_DEFAULT_TIMEOUT_LOCKED;
 static int reset_on_lockup = 1;
 static int memory_scrub;
 static ulong boot_error_status_mask = ULONG_MAX;
@@ -314,12 +317,22 @@ static void copy_kernel_module_params_to_device(struct hl_device *hdev)
 	hdev->boot_error_status_mask = boot_error_status_mask;
 }
 
-static void fixup_device_params_per_asic(struct hl_device *hdev)
+static void fixup_device_params_per_asic(struct hl_device *hdev, int timeout)
 {
 	switch (hdev->asic_type) {
-	case ASIC_GOYA:
 	case ASIC_GAUDI:
 	case ASIC_GAUDI_SEC:
+		/* If user didn't request a different timeout than the default one, we have
+		 * a different default timeout for Gaudi
+		 */
+		if (timeout == HL_DEFAULT_TIMEOUT_LOCKED)
+			hdev->timeout_jiffies = msecs_to_jiffies(GAUDI_DEFAULT_TIMEOUT_LOCKED *
+										MSEC_PER_SEC);
+
+		hdev->reset_upon_device_release = 0;
+		break;
+
+	case ASIC_GOYA:
 		hdev->reset_upon_device_release = 0;
 		break;
 
@@ -339,7 +352,7 @@ static int fixup_device_params(struct hl_device *hdev)
 	hdev->fw_comms_poll_interval_usec = HL_FW_STATUS_POLL_INTERVAL_USEC;
 
 	if (tmp_timeout)
-		hdev->timeout_jiffies = msecs_to_jiffies(tmp_timeout * 1000);
+		hdev->timeout_jiffies = msecs_to_jiffies(tmp_timeout * MSEC_PER_SEC);
 	else
 		hdev->timeout_jiffies = MAX_SCHEDULE_TIMEOUT;
 
@@ -360,7 +373,7 @@ static int fixup_device_params(struct hl_device *hdev)
 	if (!hdev->cpu_queues_enable)
 		hdev->heartbeat = 0;
 
-	fixup_device_params_per_asic(hdev);
+	fixup_device_params_per_asic(hdev, tmp_timeout);
 
 	return 0;
 }
-- 
2.25.1

