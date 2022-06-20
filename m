Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDEB551C2F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 15:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245163AbiFTNQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 09:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343859AbiFTNJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 09:09:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571641ADBA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:04:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C11E4B811B9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 13:04:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4CCC385A2;
        Mon, 20 Jun 2022 13:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655730280;
        bh=4mWPS+IfdQfX2LFjSB1gQ8XAQoFyzPvPGQA6/ViGNYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KuJZ8+kv4fsJf8BiGugozyqf60OTkrTlIdWIcI8yrTvi0LpCB/Hh2E0JuxvVW8kAM
         9VtBV1WX99d3my3TEiaZJi/Tu+Olv2iE7g8nea4aUNJRzR8wfhJc8iaL1vyWBSJ6tT
         y9BsP49hVm7DcazSA3iiLSFKottkehj0LiF9J2bHoZXzDkylGgqRngPTZW+bmeXoSc
         JWLiung0jYb+o2850+kd0XGHAUxnJP64gXQwq8hHjXHQfvjTzc4V/9sou4/1fUWX7/
         ah88arg2Sy/gi47RiD9pY1fg9V1l//rajgWYFzs90yQWQE23jzZRpFDpJue7/IlJz7
         HWaC5CjSyYpew==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tal Cohen <talcohen@habana.ai>
Subject: [PATCH 02/17] habanalabs: expose undefined opcode status via info ioctl
Date:   Mon, 20 Jun 2022 16:04:17 +0300
Message-Id: <20220620130432.1180451-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220620130432.1180451-1-ogabbay@kernel.org>
References: <20220620130432.1180451-1-ogabbay@kernel.org>
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

From: Tal Cohen <talcohen@habana.ai>

The info ioctl retrieves information on the last undefined opcode
occurred.

Signed-off-by: Tal Cohen <talcohen@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../misc/habanalabs/common/habanalabs_ioctl.c | 25 ++++++++++++++++
 include/uapi/misc/habanalabs.h                | 30 +++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index c7864d6bb0a1..fe7ed46cd1c5 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -610,6 +610,28 @@ static int razwi_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 	return copy_to_user(out, &info, min_t(size_t, max_size, sizeof(info))) ? -EFAULT : 0;
 }
 
+static int undefined_opcode_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
+{
+	struct hl_device *hdev = hpriv->hdev;
+	u32 max_size = args->return_size;
+	struct hl_info_undefined_opcode_event info = {0};
+	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
+
+	if ((!max_size) || (!out))
+		return -EINVAL;
+
+	info.timestamp = ktime_to_ns(hdev->last_error.undef_opcode.timestamp);
+	info.engine_id = hdev->last_error.undef_opcode.engine_id;
+	info.cq_addr = hdev->last_error.undef_opcode.cq_addr;
+	info.cq_size = hdev->last_error.undef_opcode.cq_size;
+	info.stream_id = hdev->last_error.undef_opcode.stream_id;
+	info.cb_addr_streams_len = hdev->last_error.undef_opcode.cb_addr_streams_len;
+	memcpy(info.cb_addr_streams, hdev->last_error.undef_opcode.cb_addr_streams,
+			sizeof(info.cb_addr_streams));
+
+	return copy_to_user(out, &info, min_t(size_t, max_size, sizeof(info))) ? -EFAULT : 0;
+}
+
 static int dev_mem_alloc_page_sizes_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 {
 	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
@@ -718,6 +740,9 @@ static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 	case HL_INFO_RAZWI_EVENT:
 		return razwi_info(hpriv, args);
 
+	case HL_INFO_UNDEFINED_OPCODE_EVENT:
+		return undefined_opcode_info(hpriv, args);
+
 	case HL_INFO_DEV_MEM_ALLOC_PAGE_SIZES:
 		return dev_mem_alloc_page_sizes_info(hpriv, args);
 
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index c94b89cf1ec1..5f9a6097f5f3 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -352,6 +352,7 @@ enum hl_server_type {
  * HL_INFO_REGISTER_EVENTFD   - Register eventfd for event notifications.
  * HL_INFO_UNREGISTER_EVENTFD - Unregister eventfd
  * HL_INFO_GET_EVENTS         - Retrieve the last occurred events
+ * HL_INFO_UNDEFINED_OPCODE_EVENT - Retrieve last undefined opcode error information.
  */
 #define HL_INFO_HW_IP_INFO			0
 #define HL_INFO_HW_EVENTS			1
@@ -380,6 +381,7 @@ enum hl_server_type {
 #define HL_INFO_REGISTER_EVENTFD		28
 #define HL_INFO_UNREGISTER_EVENTFD		29
 #define HL_INFO_GET_EVENTS			30
+#define HL_INFO_UNDEFINED_OPCODE_EVENT		31
 
 #define HL_INFO_VERSION_MAX_LEN			128
 #define HL_INFO_CARD_NAME_MAX_LEN		16
@@ -656,6 +658,34 @@ struct hl_info_razwi_event {
 	__u8 pad[2];
 };
 
+#define MAX_QMAN_STREAMS_INFO		4
+#define OPCODE_INFO_MAX_ADDR_SIZE	8
+/**
+ * struct hl_info_undefined_opcode_event - info about last undefined opcode error
+ * @timestamp: timestamp of the undefined opcode error
+ * @cb_addr_streams: CB addresses (per stream) that are currently exists in the PQ
+ *                   entiers. In case all streams array entries are
+ *                   filled with values, it means the execution was in Lower-CP.
+ * @cq_addr: the address of the current handled command buffer
+ * @cq_size: the size of the current handled command buffer
+ * @cb_addr_streams_len: num of streams - actual len of cb_addr_streams array.
+ *                       should be equal to 1 incase of undefined opcode
+ *                       in Upper-CP (specific stream) and equal to 4 incase
+ *                       of undefined opcode in Lower-CP.
+ * @engine_id: engine-id that the error occurred on
+ * @stream_id: the stream id the error occurred on. In case the stream equals to
+ *             MAX_QMAN_STREAMS_INFO it means the error occurred on a Lower-CP.
+ */
+struct hl_info_undefined_opcode_event {
+	__s64 timestamp;
+	__u64 cb_addr_streams[MAX_QMAN_STREAMS_INFO][OPCODE_INFO_MAX_ADDR_SIZE];
+	__u64 cq_addr;
+	__u32 cq_size;
+	__u32 cb_addr_streams_len;
+	__u32 engine_id;
+	__u32 stream_id;
+};
+
 /**
  * struct hl_info_dev_memalloc_page_sizes - valid page sizes in device mem alloc information.
  * @page_order_bitmask: bitmap in which a set bit represents the order of the supported page size
-- 
2.25.1

