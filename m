Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233B44E6121
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 10:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349239AbiCXJfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 05:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239204AbiCXJf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 05:35:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616551CFCB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 02:33:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0E01B82324
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 09:33:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60639C340EC;
        Thu, 24 Mar 2022 09:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648114435;
        bh=QrqRx47XNsSKHXwLP52FhvHN1EdDyNlsDVDAtsaTBsk=;
        h=From:To:Cc:Subject:Date:From;
        b=WXzarG5X7siBO+IZN3ug0X5Sfkwlbb5iD6dKQgQDwaLFz7NDe+YtivbEfPzjekay2
         gacvwh/EFx1sktdNbsq8IckkeEo4Drw465TJHGP3amRE+3vk1/OaS3US5pS6+qOkev
         wU1F9anUjVo1UVKmXCeIVujImlV3erv3fAFtWR0tghPJk2cyWggrF4pAbPic23IdrU
         55VJEf+qsc2Xsw8qeA1taLqoApZUr+x5NHW486ZWUM9CFvgCSCIAXwONRL4ADXf+UH
         IFsi0y5yVdobfgg8HeSiMmmsfjB/U9nSdhh9OW3sOS7E/hNp0/294/yosRA6d9FlKZ
         uNzMJRWXSRnIw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 1/7] habanalabs: save f/w preboot major version
Date:   Thu, 24 Mar 2022 11:33:43 +0200
Message-Id: <20220324093349.3245973-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

We need this property for doing backward compatibility hacks against
the f/w.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 30 +++++++++++++-------
 drivers/misc/habanalabs/common/habanalabs.h  |  2 ++
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 2665919dbbdd..42dce28ca815 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -1911,7 +1911,7 @@ static int hl_fw_dynamic_request_descriptor(struct hl_device *hdev,
  * @fwc: the firmware component
  * @fw_version: fw component's version string
  */
-static void hl_fw_dynamic_read_device_fw_version(struct hl_device *hdev,
+static int hl_fw_dynamic_read_device_fw_version(struct hl_device *hdev,
 					enum hl_fw_component fwc,
 					const char *fw_version)
 {
@@ -1935,23 +1935,33 @@ static void hl_fw_dynamic_read_device_fw_version(struct hl_device *hdev,
 						VERSION_MAX_LEN);
 		if (preboot_ver && preboot_ver != prop->preboot_ver) {
 			strscpy(btl_ver, prop->preboot_ver,
-				min((int) (preboot_ver - prop->preboot_ver),
-									31));
+				min((int) (preboot_ver - prop->preboot_ver), 31));
 			dev_info(hdev->dev, "%s\n", btl_ver);
 		}
 
 		preboot_ver = extract_fw_ver_from_str(prop->preboot_ver);
 		if (preboot_ver) {
-			dev_info(hdev->dev, "preboot version %s\n",
-								preboot_ver);
+			char major[8];
+			int rc;
+
+			dev_info(hdev->dev, "preboot version %s\n", preboot_ver);
+			sprintf(major, "%.2s", preboot_ver);
 			kfree(preboot_ver);
+
+			rc = kstrtou32(major, 10, &hdev->fw_major_version);
+			if (rc) {
+				dev_err(hdev->dev, "Error %d parsing preboot major version\n", rc);
+				return rc;
+			}
 		}
 
 		break;
 	default:
 		dev_warn(hdev->dev, "Undefined FW component: %d\n", fwc);
-		return;
+		return -EINVAL;
 	}
+
+	return 0;
 }
 
 /**
@@ -2123,9 +2133,10 @@ static int hl_fw_dynamic_load_image(struct hl_device *hdev,
 		goto release_fw;
 
 	/* read preboot version */
-	hl_fw_dynamic_read_device_fw_version(hdev, cur_fwc,
+	rc = hl_fw_dynamic_read_device_fw_version(hdev, cur_fwc,
 				fw_loader->dynamic_loader.comm_desc.cur_fw_ver);
-
+	if (rc)
+		goto release_fw;
 
 	/* update state according to boot stage */
 	if (cur_fwc == FW_COMP_BOOT_FIT) {
@@ -2392,9 +2403,8 @@ static int hl_fw_dynamic_init_cpu(struct hl_device *hdev,
 			goto protocol_err;
 
 		/* read preboot version */
-		hl_fw_dynamic_read_device_fw_version(hdev, FW_COMP_PREBOOT,
+		return hl_fw_dynamic_read_device_fw_version(hdev, FW_COMP_PREBOOT,
 				fw_loader->dynamic_loader.comm_desc.cur_fw_ver);
-		return 0;
 	}
 
 	/* load boot fit to FW */
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 3e7012f7b1a3..9c70d95883a2 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2647,6 +2647,7 @@ struct hl_reset_info {
  * @reset_info: holds current device reset information.
  * @last_error: holds information about last session in which CS timeout or razwi error occurred.
  * @stream_master_qid_arr: pointer to array with QIDs of master streams.
+ * @fw_major_version: major version of current loaded preboot
  * @dram_used_mem: current DRAM memory consumption.
  * @timeout_jiffies: device CS timeout value.
  * @max_power: the max power of the device, as configured by the sysadmin. This
@@ -2785,6 +2786,7 @@ struct hl_device {
 	struct hl_reset_info		reset_info;
 
 	u32				*stream_master_qid_arr;
+	u32				fw_major_version;
 	atomic64_t			dram_used_mem;
 	u64				timeout_jiffies;
 	u64				max_power;
-- 
2.25.1

