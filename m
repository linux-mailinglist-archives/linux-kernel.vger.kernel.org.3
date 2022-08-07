Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BA658BB19
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 15:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbiHGNzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 09:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233945AbiHGNzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 09:55:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC87529F
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 06:55:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4DF35B80AB2
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 13:55:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4849DC433D7
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 13:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659880498;
        bh=Uv/2fiNW3gL3K4lEM7P9/rRP/Qw2zN9UFuQQtUAZKLE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QmTiXXNZSlxADWj9wNz5oTOAUc8KDWpplkIt9359llU1bV8F0FTX9lvEacyNpk6te
         KbYPmFJK0DY0Q6LC4yPqf8l7PuXE/kmyh9OxbhWD18EyJoKbYpX1iEAiEQLbgGhIKt
         6/fBZO02WeF67Dbhqa6gULeIebC5ghHvAThBWEFI4ErKj69NjHN8WBRcMQQzrCY64e
         I0/xEKb/u67L20OJyOLXDMXjIzEE4rWE2R9EYvaoXMn8iQLFFWyGdUqGJD2PnBP4f6
         55WqmQ3FO+gJZRfhxl3XagvsHlSUQ2155ZpVXGalee8RyiCeLiTtllh9aACZC9+oko
         Y06U93wRx0wRw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] habanalabs: remove left-over code from bring-up
Date:   Sun,  7 Aug 2022 16:54:48 +0300
Message-Id: <20220807135452.1219894-2-ogabbay@kernel.org>
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

There is some left-over code from the gaudi2 bring-up that wasn't
removed so far.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c  | 20 -------------
 .../habanalabs/include/common/hl_boot_if.h    | 28 ++++++++++++++-----
 2 files changed, 21 insertions(+), 27 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index cbcb9442bdca..12d0f18c1f6c 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -15,14 +15,6 @@
 
 #define FW_FILE_MAX_SIZE		0x1400000 /* maximum size of 20MB */
 
-struct fw_binning_conf {
-	u64 tpc_binning;
-	u32 dec_binning;
-	u32 hbm_binning;
-	u32 edma_binning;
-	u32 mme_redundancy;
-};
-
 static char *extract_fw_ver_from_str(const char *fw_str)
 {
 	char *str, *fw_ver, *whitespace;
@@ -2424,18 +2416,6 @@ static int hl_fw_dynamic_send_msg(struct hl_device *hdev,
 		msg.reset_cause = *(__u8 *) data;
 		break;
 
-	case HL_COMMS_BINNING_CONF_TYPE:
-	{
-		struct fw_binning_conf *binning_conf = (struct fw_binning_conf *) data;
-
-		msg.tpc_binning_conf = cpu_to_le64(binning_conf->tpc_binning);
-		msg.dec_binning_conf = cpu_to_le32(binning_conf->dec_binning);
-		msg.hbm_binning_conf = cpu_to_le32(binning_conf->hbm_binning);
-		msg.edma_binning_conf = cpu_to_le32(binning_conf->edma_binning);
-		msg.mme_redundancy_conf = cpu_to_le32(binning_conf->mme_redundancy);
-		break;
-	}
-
 	default:
 		dev_err(hdev->dev,
 			"Send COMMS message - invalid message type %u\n",
diff --git a/drivers/misc/habanalabs/include/common/hl_boot_if.h b/drivers/misc/habanalabs/include/common/hl_boot_if.h
index a3594119bc51..f2f6488de625 100644
--- a/drivers/misc/habanalabs/include/common/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/common/hl_boot_if.h
@@ -465,6 +465,26 @@ enum comms_msg_type {
 	HL_COMMS_BINNING_CONF_TYPE = 3,
 };
 
+/*
+ * Binning information shared between LKD and FW
+ * @tpc_mask - TPC binning information
+ * @dec_mask - Decoder binning information
+ * @hbm_mask - HBM binning information
+ * @edma_mask - EDMA binning information
+ * @mme_mask_l - MME binning information lower 32
+ * @mme_mask_h - MME binning information upper 32
+ * @reserved - reserved field for 64 bit alignment
+ */
+struct lkd_fw_binning_info {
+	__le64 tpc_mask;
+	__le32 dec_mask;
+	__le32 hbm_mask;
+	__le32 edma_mask;
+	__le32 mme_mask_l;
+	__le32 mme_mask_h;
+	__le32 reserved;
+};
+
 /* TODO: remove this struct after the code is updated to use message */
 /* this is the comms descriptor header - meta data */
 struct comms_desc_header {
@@ -525,13 +545,7 @@ struct lkd_fw_comms_msg {
 		struct {
 			__u8 fw_cfg_skip; /* 1 - skip, 0 - don't skip */
 		};
-		struct {
-			__le64 tpc_binning_conf;
-			__le32 dec_binning_conf;
-			__le32 hbm_binning_conf;
-			__le32 edma_binning_conf;
-			__le32 mme_redundancy_conf; /* use MME_REDUNDANT_COLUMN */
-		};
+		struct lkd_fw_binning_info binning_info;
 	};
 };
 
-- 
2.25.1

