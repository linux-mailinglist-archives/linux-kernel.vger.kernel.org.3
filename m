Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB4957C6A5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbiGUImI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbiGUImF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:42:05 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6CD3A4AF
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 01:42:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EC521CE2344
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 08:41:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C836C3411E;
        Thu, 21 Jul 2022 08:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658392916;
        bh=70QCC848OBrtjsDeSLadwcsuFbILcIblyOLHWV2NckE=;
        h=From:To:Cc:Subject:Date:From;
        b=kfoy2xtyPtUkh4TrtHSjLbzjqXu/OhRMzzT+MrHuHvWe+2p2c5wrZP0ClJXsYalDm
         mUvruXUj1fNWooUnbUrFdCuZRKBehONvuTOjjjD20O7pQj1FSQu0RRa9/60/NGCi1m
         XyWx3PXI7edTdysX/51kQ8XJxbS5Fvz3YDO5a+Bj1tpYFjekzKcAr9la0/UF55U4Jk
         jMTMlBR9mz7JkdK2riLNkXqnBWMOqoBq98kZ88j6lxmzemIc25/yVnBsRhcutqapZ7
         CFcmtaepOdgll7RA85t+4rQDnnDanu32eNcHlNAMraaifi9sqV2ZoomaVsGW1elBQ/
         YLHYHR6h4RF7g==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 1/2] habanalabs: add uapi to retrieve engines status
Date:   Thu, 21 Jul 2022 11:41:49 +0300
Message-Id: <20220721084150.4147483-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
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

From: Dani Liberman <dliberman@habana.ai>

Currently, to get engines status, user needed to read debugfs file
with root permissions.

This new uapi allows user apace apps retrieve status, so for example,
in case of failure, status can be retrieved immediately by the
application itself which runs without root permissions.

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/debugfs.c      |  3 +-
 .../misc/habanalabs/common/habanalabs_ioctl.c | 40 +++++++++++++++++++
 include/uapi/misc/habanalabs.h                |  9 +++++
 3 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index 90c91c1b2c10..c297248748d3 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -17,7 +17,6 @@
 #define MMU_ASID_BUF_SIZE	10
 #define MMU_KBUF_SIZE		(MMU_ADDR_BUF_SIZE + MMU_ASID_BUF_SIZE)
 #define I2C_MAX_TRANSACTION_LEN	8
-#define ENGINES_DATA_MAX_SIZE	SZ_16K
 
 static struct dentry *hl_debug_root;
 
@@ -626,7 +625,7 @@ static int engines_show(struct seq_file *s, void *data)
 	}
 
 	eng_data.actual_size = 0;
-	eng_data.allocated_buf_size = ENGINES_DATA_MAX_SIZE;
+	eng_data.allocated_buf_size = HL_ENGINES_DATA_MAX_SIZE;
 	eng_data.buf = vmalloc(eng_data.allocated_buf_size);
 	if (!eng_data.buf)
 		return -ENOMEM;
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index 6a30bd98ab5e..ec55c66fedd6 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -14,6 +14,7 @@
 #include <linux/fs.h>
 #include <linux/uaccess.h>
 #include <linux/slab.h>
+#include <linux/vmalloc.h>
 
 static u32 hl_debug_struct_size[HL_DEBUG_OP_TIMESTAMP + 1] = {
 	[HL_DEBUG_OP_ETR] = sizeof(struct hl_debug_params_etr),
@@ -697,6 +698,42 @@ static int eventfd_unregister(struct hl_fpriv *hpriv, struct hl_info_args *args)
 	return 0;
 }
 
+static int engine_status_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
+{
+	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
+	u32 status_buf_size = args->return_size;
+	struct hl_device *hdev = hpriv->hdev;
+	struct engines_data eng_data;
+	int rc;
+
+	if ((status_buf_size < SZ_1K) || (status_buf_size > HL_ENGINES_DATA_MAX_SIZE) || (!out))
+		return -EINVAL;
+
+	eng_data.actual_size = 0;
+	eng_data.allocated_buf_size = status_buf_size;
+	eng_data.buf = vmalloc(status_buf_size);
+	if (!eng_data.buf)
+		return -ENOMEM;
+
+	hdev->asic_funcs->is_device_idle(hdev, NULL, 0, &eng_data);
+
+	if (eng_data.actual_size > eng_data.allocated_buf_size) {
+		dev_err(hdev->dev,
+			"Engines data size (%d Bytes) is bigger than allocated size (%u Bytes)\n",
+			eng_data.actual_size, status_buf_size);
+		vfree(eng_data.buf);
+		return -ENOMEM;
+	}
+
+	args->user_buffer_actual_size = eng_data.actual_size;
+	rc = copy_to_user(out, eng_data.buf, min_t(size_t, status_buf_size, eng_data.actual_size)) ?
+				-EFAULT : 0;
+
+	vfree(eng_data.buf);
+
+	return rc;
+}
+
 static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 				struct device *dev)
 {
@@ -812,6 +849,9 @@ static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 	case HL_INFO_UNREGISTER_EVENTFD:
 		return eventfd_unregister(hpriv, args);
 
+	case HL_INFO_ENGINE_STATUS:
+		return engine_status_info(hpriv, args);
+
 	default:
 		dev_err(dev, "Invalid request %d\n", args->op);
 		rc = -EINVAL;
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index be06b1307c44..83ca6f40f4ba 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -787,10 +787,14 @@ enum hl_server_type {
 #define HL_INFO_UNREGISTER_EVENTFD		29
 #define HL_INFO_GET_EVENTS			30
 #define HL_INFO_UNDEFINED_OPCODE_EVENT		31
+#define HL_INFO_ENGINE_STATUS			32
 
 #define HL_INFO_VERSION_MAX_LEN			128
 #define HL_INFO_CARD_NAME_MAX_LEN		16
 
+/* Maximum buffer size for retrieving engines status */
+#define HL_ENGINES_DATA_MAX_SIZE	SZ_1M
+
 /**
  * struct hl_info_hw_ip_info - hardware information on various IPs in the ASIC
  * @sram_base_address: The first SRAM physical base address that is free to be
@@ -1130,6 +1134,10 @@ enum gaudi_dcores {
  *             resolution. Currently not in use.
  * @pll_index: Index as defined in hl_<asic type>_pll_index enumeration.
  * @eventfd: event file descriptor for event notifications.
+ * @user_buffer_actual_size: Actual data size which was copied to user allocated buffer by the
+ *                           driver. It is possible for the user to allocate buffer larger than
+ *                           needed, hence updating this variable so user will know the exact amount
+ *                           of bytes copied by the kernel to the buffer.
  * @pad: Padding to 64 bit.
  */
 struct hl_info_args {
@@ -1143,6 +1151,7 @@ struct hl_info_args {
 		__u32 period_ms;
 		__u32 pll_index;
 		__u32 eventfd;
+		__u32 user_buffer_actual_size;
 	};
 
 	__u32 pad;
-- 
2.25.1

