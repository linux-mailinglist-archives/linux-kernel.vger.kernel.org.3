Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EA45430CF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 14:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239753AbiFHMuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 08:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239571AbiFHMtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:49:46 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8A41ABA47;
        Wed,  8 Jun 2022 05:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1654692584; x=1686228584;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Az7iaov/jqOSBye4wlXBxEG7MK9CajccaCo5EeMi/+0=;
  b=pkAknF3BV/cJ/6DfgnUaj4TqRsw3x2Saf6x49b1mic880zhBYJC0QHOQ
   u9hFIT3MeYmCycf61p/aDWJiVR2biTQs3AyHzyYdDO9n7VDW9DGuwARhW
   aSUHWkSxQtBnsQ5e2y1UOUJUdz7IW3lUdjiG15otTzR6UVKxzanSkYXMY
   yh8P06VwsaIlQDTClhR0JoHkcbkah13FW7DOuXe2PRt/eJU8b2VZP4Zch
   ZJD9pPmRfVL7FuoDLCqo/GaI4P4NixwSAGIbvtXA4krc/eC1YwiYn3X0v
   SR/1Y89QwoZItF/YAV8ND5omiBZmx3li71DXeaQFPvt2P4DJc5GaSUSGD
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,286,1647298800"; 
   d="scan'208";a="24330551"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 08 Jun 2022 14:49:32 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 08 Jun 2022 14:49:32 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 08 Jun 2022 14:49:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1654692572; x=1686228572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Az7iaov/jqOSBye4wlXBxEG7MK9CajccaCo5EeMi/+0=;
  b=T6dWgZUcV6O2OOCc3nb49xZkyeqRdLXHKPPap29NNJ/sxXLsaFiI44dG
   gj5WXOCVvyt/qoR211FQyuNtahLurghTLhgJaZ3X5j1FOTi9RFW2b3yh1
   2rhLGi2+TtMD01qcISYN1looaHzBtinkxRjQP0wcBuk4wu3rjb1ydlCzV
   J7ruLqqJk8D8vUx4Tna1FlGGHNc2bgPV1jMBcwXnXU9v2AQ/8X7rwNoFj
   cwut+FFQjhDUIMbnnz4DTKY7xKxBHe42H3l6DiSRX+iLAz26ah838wZCF
   e5CsHvNGbg6+HC3+Py2TOQGdNaldEWX2Rw9lrQEK8YlSrtpgXu3WWgfPC
   g==;
X-IronPort-AV: E=Sophos;i="5.91,286,1647298800"; 
   d="scan'208";a="24330548"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 08 Jun 2022 14:49:32 +0200
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.136])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id C9FB6280073;
        Wed,  8 Jun 2022 14:49:31 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Lyude Paul <lyude@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 7/9] Input: synaptics-rmi4 - remove unneeded struct register_offset
Date:   Wed,  8 Jun 2022 14:48:06 +0200
Message-Id: <20220608124808.51402-8-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220608124808.51402-1-matthias.schiffer@ew.tq-group.com>
References: <20220608124808.51402-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All register offsets are fixed, and a number of places even read or
write multiple registers as a block, so there is no way to support
reordering them without move involved changes. Remove the unneeded level
of indirection in the register access.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/input/rmi4/rmi_f34.c   |  2 +-
 drivers/input/rmi4/rmi_f34.h   | 15 ---------------
 drivers/input/rmi4/rmi_f34v7.c | 35 ++++++++++++++--------------------
 3 files changed, 15 insertions(+), 37 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f34.c b/drivers/input/rmi4/rmi_f34.c
index b811706fb77b..30169b584573 100644
--- a/drivers/input/rmi4/rmi_f34.c
+++ b/drivers/input/rmi4/rmi_f34.c
@@ -115,7 +115,7 @@ static irqreturn_t rmi_f34_attention(int irq, void *ctx)
 	} else {
 		ret = rmi_read_block(f34->fn->rmi_dev,
 					f34->fn->fd.data_base_addr +
-						f34->v7.off.flash_cmd,
+						V7_COMMAND_OFFSET,
 					&status, sizeof(status));
 		rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev, "%s: cmd: %#02x, ret: %d\n",
 			__func__, status, ret);
diff --git a/drivers/input/rmi4/rmi_f34.h b/drivers/input/rmi4/rmi_f34.h
index 9495c8542824..cfa3039804fd 100644
--- a/drivers/input/rmi4/rmi_f34.h
+++ b/drivers/input/rmi4/rmi_f34.h
@@ -222,20 +222,6 @@ struct image_metadata {
 	struct physical_address phyaddr;
 };
 
-struct register_offset {
-	u8 properties;
-	u8 properties_2;
-	u8 block_size;
-	u8 block_count;
-	u8 gc_block_count;
-	u8 flash_status;
-	u8 partition_id;
-	u8 block_number;
-	u8 transfer_length;
-	u8 flash_cmd;
-	u8 payload;
-};
-
 struct rmi_f34_firmware {
 	__le32 checksum;
 	u8 pad1[3];
@@ -276,7 +262,6 @@ struct f34v7_data {
 	u8 partitions;
 	u16 partition_table_bytes;
 
-	struct register_offset off;
 	struct block_count blkcount;
 	struct physical_address phyaddr;
 	struct image_metadata img;
diff --git a/drivers/input/rmi4/rmi_f34v7.c b/drivers/input/rmi4/rmi_f34v7.c
index 9c1a73611761..5c22ad4bcc74 100644
--- a/drivers/input/rmi4/rmi_f34v7.c
+++ b/drivers/input/rmi4/rmi_f34v7.c
@@ -25,7 +25,7 @@ static int rmi_f34v7_read_flash_status(struct f34_data *f34)
 	int ret;
 
 	ret = rmi_read_block(f34->fn->rmi_dev,
-			f34->fn->fd.data_base_addr + f34->v7.off.flash_status,
+			f34->fn->fd.data_base_addr + V7_FLASH_STATUS_OFFSET,
 			&status,
 			sizeof(status));
 	if (ret < 0) {
@@ -43,7 +43,7 @@ static int rmi_f34v7_read_flash_status(struct f34_data *f34)
 	}
 
 	ret = rmi_read_block(f34->fn->rmi_dev,
-			f34->fn->fd.data_base_addr + f34->v7.off.flash_cmd,
+			f34->fn->fd.data_base_addr + V7_COMMAND_OFFSET,
 			&command,
 			sizeof(command));
 	if (ret < 0) {
@@ -140,7 +140,7 @@ static int rmi_f34v7_write_command_single_transaction(struct f34_data *f34,
 	data_1_5.payload[1] = f34->bootloader_id[1];
 
 	ret = rmi_write_block(f34->fn->rmi_dev,
-			base + f34->v7.off.partition_id,
+			base + V7_PARTITION_ID_OFFSET,
 			&data_1_5, sizeof(data_1_5));
 	if (ret < 0) {
 		dev_err(&f34->fn->dev,
@@ -213,7 +213,7 @@ static int rmi_f34v7_write_command(struct f34_data *f34, u8 cmd)
 		__func__, command);
 
 	ret = rmi_write_block(f34->fn->rmi_dev,
-			base + f34->v7.off.flash_cmd,
+			base + V7_COMMAND_OFFSET,
 			&command, sizeof(command));
 	if (ret < 0) {
 		dev_err(&f34->fn->dev, "%s: Failed to write flash command\n",
@@ -280,7 +280,7 @@ static int rmi_f34v7_write_partition_id(struct f34_data *f34, u8 cmd)
 	}
 
 	ret = rmi_write_block(f34->fn->rmi_dev,
-			base + f34->v7.off.partition_id,
+			base + V7_PARTITION_ID_OFFSET,
 			&partition, sizeof(partition));
 	if (ret < 0) {
 		dev_err(&f34->fn->dev, "%s: Failed to write partition ID\n",
@@ -308,7 +308,7 @@ static int rmi_f34v7_read_partition_table(struct f34_data *f34)
 		return ret;
 
 	ret = rmi_write_block(f34->fn->rmi_dev,
-			base + f34->v7.off.block_number,
+			base + V7_BLOCK_NUMBER_OFFSET,
 			&block_number, sizeof(block_number));
 	if (ret < 0) {
 		dev_err(&f34->fn->dev, "%s: Failed to write block number\n",
@@ -319,7 +319,7 @@ static int rmi_f34v7_read_partition_table(struct f34_data *f34)
 	put_unaligned_le16(f34->v7.flash_config_length, &length);
 
 	ret = rmi_write_block(f34->fn->rmi_dev,
-			base + f34->v7.off.transfer_length,
+			base + V7_TRANSFER_LENGTH_OFFSET,
 			&length, sizeof(length));
 	if (ret < 0) {
 		dev_err(&f34->fn->dev, "%s: Failed to write transfer length\n",
@@ -352,7 +352,7 @@ static int rmi_f34v7_read_partition_table(struct f34_data *f34)
 	}
 
 	ret = rmi_read_block(f34->fn->rmi_dev,
-			base + f34->v7.off.payload,
+			base + V7_PAYLOAD_OFFSET,
 			f34->v7.read_config_buf,
 			f34->v7.partition_table_bytes);
 	if (ret < 0) {
@@ -526,13 +526,6 @@ static int rmi_f34v7_read_queries(struct f34_data *f34)
 	rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev, "%s: f34->v7.block_size = %d\n",
 		 __func__, f34->v7.block_size);
 
-	f34->v7.off.flash_status = V7_FLASH_STATUS_OFFSET;
-	f34->v7.off.partition_id = V7_PARTITION_ID_OFFSET;
-	f34->v7.off.block_number = V7_BLOCK_NUMBER_OFFSET;
-	f34->v7.off.transfer_length = V7_TRANSFER_LENGTH_OFFSET;
-	f34->v7.off.flash_cmd = V7_COMMAND_OFFSET;
-	f34->v7.off.payload = V7_PAYLOAD_OFFSET;
-
 	f34->v7.has_display_cfg = query_1_7.partition_support[1] & HAS_DISP_CFG;
 	f34->v7.has_guest_code =
 			query_1_7.partition_support[1] & HAS_GUEST_CODE;
@@ -646,7 +639,7 @@ static int rmi_f34v7_read_blocks(struct f34_data *f34,
 		return ret;
 
 	ret = rmi_write_block(f34->fn->rmi_dev,
-			base + f34->v7.off.block_number,
+			base + V7_BLOCK_NUMBER_OFFSET,
 			&block_number, sizeof(block_number));
 	if (ret < 0) {
 		dev_err(&f34->fn->dev, "%s: Failed to write block number\n",
@@ -662,7 +655,7 @@ static int rmi_f34v7_read_blocks(struct f34_data *f34,
 		put_unaligned_le16(transfer, &length);
 
 		ret = rmi_write_block(f34->fn->rmi_dev,
-				base + f34->v7.off.transfer_length,
+				base + V7_TRANSFER_LENGTH_OFFSET,
 				&length, sizeof(length));
 		if (ret < 0) {
 			dev_err(&f34->fn->dev,
@@ -682,7 +675,7 @@ static int rmi_f34v7_read_blocks(struct f34_data *f34,
 			return ret;
 
 		ret = rmi_read_block(f34->fn->rmi_dev,
-				base + f34->v7.off.payload,
+				base + V7_PAYLOAD_OFFSET,
 				&f34->v7.read_config_buf[index],
 				transfer * f34->v7.block_size);
 		if (ret < 0) {
@@ -718,7 +711,7 @@ static int rmi_f34v7_write_f34v7_blocks(struct f34_data *f34,
 		return ret;
 
 	ret = rmi_write_block(f34->fn->rmi_dev,
-			base + f34->v7.off.block_number,
+			base + V7_BLOCK_NUMBER_OFFSET,
 			&block_number, sizeof(block_number));
 	if (ret < 0) {
 		dev_err(&f34->fn->dev, "%s: Failed to write block number\n",
@@ -738,7 +731,7 @@ static int rmi_f34v7_write_f34v7_blocks(struct f34_data *f34,
 		init_completion(&f34->v7.cmd_done);
 
 		ret = rmi_write_block(f34->fn->rmi_dev,
-				base + f34->v7.off.transfer_length,
+				base + V7_TRANSFER_LENGTH_OFFSET,
 				&length, sizeof(length));
 		if (ret < 0) {
 			dev_err(&f34->fn->dev,
@@ -752,7 +745,7 @@ static int rmi_f34v7_write_f34v7_blocks(struct f34_data *f34,
 			return ret;
 
 		ret = rmi_write_block(f34->fn->rmi_dev,
-				base + f34->v7.off.payload,
+				base + V7_PAYLOAD_OFFSET,
 				block_ptr, transfer * f34->v7.block_size);
 		if (ret < 0) {
 			dev_err(&f34->fn->dev,
-- 
2.25.1

