Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3667B5650CB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbiGDJaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbiGDJ34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:29:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B876B1114
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 02:29:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE493B80E40
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 09:29:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0B5C341CA;
        Mon,  4 Jul 2022 09:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656926992;
        bh=DZvEnsukZHgqwQx3Xk1OfD7ULNaxWpPpcCEK9RlBfO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tTfY8RKXE3A4fe7rotu0QM4IwkddV7/HkXyDMjvVzqXVAoZhLuJF9qO7Hl/Sp3NtI
         p7NozSFDCaYdTFGz7TtbZeYtO0OKtcOWt6p1nrI/AZq7SPqRhSFnjWgKeUnGlvJTG5
         +4rGxunJfP/lRfHvKfJi57ltrbpxLVy3IUfqblDgoj1sqTJrwlYD4pnM7mIi5XLHfI
         pUchuL1qvii96Im7ZJZm+pkyTEzI8yp4kfdWEkr3L2+2qfRsOiaAyLyjPCsdkMMuLd
         f9TvlZqztAkLawwjOWRh1eSemq3Lgra72TSCEURdCoq5rQ8A348rqq2nnBLuk4d6Gy
         fslLvh0Ay5Dvw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Sagiv Ozeri <sozeri@habana.ai>
Subject: [PATCH 05/12] habanalabs: save f/w preboot minor version
Date:   Mon,  4 Jul 2022 12:29:34 +0300
Message-Id: <20220704092941.2237683-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220704092941.2237683-1-ogabbay@kernel.org>
References: <20220704092941.2237683-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sagiv Ozeri <sozeri@habana.ai>

We need this property for backward compatibility against the f/w.

Signed-off-by: Sagiv Ozeri <sozeri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 49 ++++++++++++++++----
 drivers/misc/habanalabs/common/habanalabs.h  |  4 +-
 2 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 64c5cdfc6dcf..04ca4aaee446 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -41,7 +41,7 @@ static char *extract_fw_ver_from_str(const char *fw_str)
 	ver_offset = str - fw_str;
 
 	/* Copy until the next whitespace */
-	whitespace =  strnstr(str, " ", VERSION_MAX_LEN - ver_offset);
+	whitespace = strnstr(str, " ", VERSION_MAX_LEN - ver_offset);
 	if (!whitespace)
 		goto free_fw_ver;
 
@@ -54,6 +54,43 @@ static char *extract_fw_ver_from_str(const char *fw_str)
 	return NULL;
 }
 
+static int extract_fw_sub_versions(struct hl_device *hdev, char *preboot_ver)
+{
+	char major[8], minor[8], *first_dot, *second_dot;
+	int rc;
+
+	first_dot = strnstr(preboot_ver, ".", 10);
+	if (first_dot) {
+		strscpy(major, preboot_ver, first_dot - preboot_ver + 1);
+		rc = kstrtou32(major, 10, &hdev->fw_major_version);
+	} else {
+		rc = -EINVAL;
+	}
+
+	if (rc) {
+		dev_err(hdev->dev, "Error %d parsing preboot major version\n", rc);
+		goto out;
+	}
+
+	/* skip the first dot */
+	first_dot++;
+
+	second_dot = strnstr(first_dot, ".", 10);
+	if (second_dot) {
+		strscpy(minor, first_dot, second_dot - first_dot + 1);
+		rc = kstrtou32(minor, 10, &hdev->fw_minor_version);
+	} else {
+		rc = -EINVAL;
+	}
+
+	if (rc)
+		dev_err(hdev->dev, "Error %d parsing preboot minor version\n", rc);
+
+out:
+	kfree(preboot_ver);
+	return rc;
+}
+
 static int hl_request_fw(struct hl_device *hdev,
 				const struct firmware **firmware_p,
 				const char *fw_name)
@@ -2012,18 +2049,14 @@ static int hl_fw_dynamic_read_device_fw_version(struct hl_device *hdev,
 
 		preboot_ver = extract_fw_ver_from_str(prop->preboot_ver);
 		if (preboot_ver) {
-			char major[8];
 			int rc;
 
 			dev_info(hdev->dev, "preboot version %s\n", preboot_ver);
-			sprintf(major, "%.2s", preboot_ver);
-			kfree(preboot_ver);
 
-			rc = kstrtou32(major, 10, &hdev->fw_major_version);
-			if (rc) {
-				dev_err(hdev->dev, "Error %d parsing preboot major version\n", rc);
+			/* This function takes care of freeing preboot_ver */
+			rc = extract_fw_sub_versions(hdev, preboot_ver);
+			if (rc)
 				return rc;
-			}
 		}
 
 		break;
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 7e84f2ce49ae..72cb12f2068a 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -3012,7 +3012,8 @@ struct hl_reset_info {
  * @last_error: holds information about last session in which CS timeout or razwi error occurred.
  * @reset_info: holds current device reset information.
  * @stream_master_qid_arr: pointer to array with QIDs of master streams.
- * @fw_major_version: major version of current loaded preboot
+ * @fw_major_version: major version of current loaded preboot.
+ * @fw_minor_version: minor version of current loaded preboot.
  * @dram_used_mem: current DRAM memory consumption.
  * @memory_scrub_val: the value to which the dram will be scrubbed to using cb scrub_device_dram
  * @timeout_jiffies: device CS timeout value.
@@ -3186,6 +3187,7 @@ struct hl_device {
 
 	u32				*stream_master_qid_arr;
 	u32				fw_major_version;
+	u32				fw_minor_version;
 	atomic64_t			dram_used_mem;
 	u64				memory_scrub_val;
 	u64				timeout_jiffies;
-- 
2.25.1

