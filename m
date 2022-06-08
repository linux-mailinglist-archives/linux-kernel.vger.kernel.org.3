Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815155430B8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 14:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239716AbiFHMtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 08:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239635AbiFHMto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:49:44 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FBF19EC18;
        Wed,  8 Jun 2022 05:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1654692582; x=1686228582;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F3P0Nl1bHEgV6/EZwkcRfSNUKbVAu4VqbkAsh35Twng=;
  b=DLDoNZsj8nAVod7xTNeqWXDvX8UuY3wjalHq2MAeteXDoELlDWRA5xNB
   aTaLsvj0V4CcJzHUCtOVUcAc8aMtAruugGvFvwmzEzYATZBffvb8fe7MG
   mmUqdzIwMn3vcd+LkgSAOh6g9fjb3PSaK5Wqz6/8fQ6CJCAYi+kwv7Okz
   klPu1QdCj5iZW7/2nKKht6QgDvBN7T9j6TrOnVwGkJoTusFshrNFStBaq
   cM0qASUh5RYXu+1lWVs5JU3LkRbYUJwM6WrlzJO35sDkIjcqPgZy+4OYX
   C+5FzbqH9B51vsnnAhN7eCnvhEq3QH5w8AuRk5YJR/1mamFZtMRtp3UlB
   A==;
X-IronPort-AV: E=Sophos;i="5.91,286,1647298800"; 
   d="scan'208";a="24330542"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 08 Jun 2022 14:49:31 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 08 Jun 2022 14:49:31 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 08 Jun 2022 14:49:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1654692571; x=1686228571;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F3P0Nl1bHEgV6/EZwkcRfSNUKbVAu4VqbkAsh35Twng=;
  b=LKvo7NqnggFQaZW07XxZCYNFQPhDtPhZMDjpmHx7GBwjlI22rHaRr+Vb
   xb/mKznLPOmpQWWXJ2zAPfXxL1CqhYfJDAczInyNf5oDeujDGWa4bWSIi
   AYPweOXDcyAhNNuze3+9F9gS6BgTqTAOZnAKlggC7aJZk0AollSw27A8p
   wGTbuaUpyBhPkZRL1Bg/Rdr78LX5OIPI+tRx6B+38RYy9ZOqAuZBMbn6X
   k6vk3k3EdFtjJaoRwmbC7oBfqyWX00+vKu+BXMIeF+NVqY2dWMxZPDAbs
   EXK5qMQeT+8LLzt7qunFWXpEYsXROCiTVi8jZLwty4AD6XOWIifgmkBs1
   w==;
X-IronPort-AV: E=Sophos;i="5.91,286,1647298800"; 
   d="scan'208";a="24330541"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 08 Jun 2022 14:49:31 +0200
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.136])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 40370280072;
        Wed,  8 Jun 2022 14:49:31 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Lyude Paul <lyude@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 4/9] Input: synaptics-rmi4 - rewrite partition table unconditionally
Date:   Wed,  8 Jun 2022 14:48:03 +0200
Message-Id: <20220608124808.51402-5-matthias.schiffer@ew.tq-group.com>
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

Preparation for use of the "erase application" command, which is required
to recover from a bad partition table error condition. Rather than adding
complex fallback error paths for such errors, it seems more robust to do
the full erase unconditionally.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/input/rmi4/rmi_f34.h   |   2 -
 drivers/input/rmi4/rmi_f34v7.c | 153 +++------------------------------
 2 files changed, 13 insertions(+), 142 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f34.h b/drivers/input/rmi4/rmi_f34.h
index 99faa8c2269d..9495c8542824 100644
--- a/drivers/input/rmi4/rmi_f34.h
+++ b/drivers/input/rmi4/rmi_f34.h
@@ -262,7 +262,6 @@ struct f34v5_data {
 struct f34v7_data {
 	bool has_display_cfg;
 	bool has_guest_code;
-	bool force_update;
 	bool in_bl_mode;
 	u8 *read_config_buf;
 	size_t read_config_buf_size;
@@ -276,7 +275,6 @@ struct f34v7_data {
 	u16 payload_length;
 	u8 partitions;
 	u16 partition_table_bytes;
-	bool new_partition_table;
 
 	struct register_offset off;
 	struct block_count blkcount;
diff --git a/drivers/input/rmi4/rmi_f34v7.c b/drivers/input/rmi4/rmi_f34v7.c
index 9049acb3a994..19b94b1c1a33 100644
--- a/drivers/input/rmi4/rmi_f34v7.c
+++ b/drivers/input/rmi4/rmi_f34v7.c
@@ -593,68 +593,6 @@ static int rmi_f34v7_read_queries(struct f34_data *f34)
 	return 0;
 }
 
-static int rmi_f34v7_check_ui_firmware_size(struct f34_data *f34)
-{
-	u16 block_count;
-
-	block_count = f34->v7.img.ui_firmware.size / f34->v7.block_size;
-	f34->update_size += block_count;
-
-	if (block_count != f34->v7.blkcount.ui_firmware) {
-		dev_err(&f34->fn->dev,
-			"UI firmware size mismatch: %d != %d\n",
-			block_count, f34->v7.blkcount.ui_firmware);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int rmi_f34v7_check_ui_config_size(struct f34_data *f34)
-{
-	u16 block_count;
-
-	block_count = f34->v7.img.ui_config.size / f34->v7.block_size;
-	f34->update_size += block_count;
-
-	if (block_count != f34->v7.blkcount.ui_config) {
-		dev_err(&f34->fn->dev, "UI config size mismatch\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int rmi_f34v7_check_dp_config_size(struct f34_data *f34)
-{
-	u16 block_count;
-
-	block_count = f34->v7.img.dp_config.size / f34->v7.block_size;
-	f34->update_size += block_count;
-
-	if (block_count != f34->v7.blkcount.dp_config) {
-		dev_err(&f34->fn->dev, "Display config size mismatch\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int rmi_f34v7_check_guest_code_size(struct f34_data *f34)
-{
-	u16 block_count;
-
-	block_count = f34->v7.img.guest_code.size / f34->v7.block_size;
-	f34->update_size += block_count;
-
-	if (block_count != f34->v7.blkcount.guest_code) {
-		dev_err(&f34->fn->dev, "Guest code size mismatch\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int rmi_f34v7_check_bl_config_size(struct f34_data *f34)
 {
 	u16 block_count;
@@ -750,7 +688,7 @@ static int rmi_f34v7_erase_all(struct f34_data *f34)
 			return ret;
 	}
 
-	if (f34->v7.new_partition_table && f34->v7.has_guest_code) {
+	if (f34->v7.has_guest_code) {
 		ret = rmi_f34v7_erase_guest_code(f34);
 		if (ret < 0)
 			return ret;
@@ -1029,33 +967,6 @@ static int rmi_f34v7_write_firmware(struct f34_data *f34)
 					    blk_count, v7_CMD_WRITE_FW);
 }
 
-static void rmi_f34v7_compare_partition_tables(struct f34_data *f34)
-{
-	if (f34->v7.phyaddr.ui_firmware != f34->v7.img.phyaddr.ui_firmware) {
-		f34->v7.new_partition_table = true;
-		return;
-	}
-
-	if (f34->v7.phyaddr.ui_config != f34->v7.img.phyaddr.ui_config) {
-		f34->v7.new_partition_table = true;
-		return;
-	}
-
-	if (f34->v7.has_display_cfg &&
-	    f34->v7.phyaddr.dp_config != f34->v7.img.phyaddr.dp_config) {
-		f34->v7.new_partition_table = true;
-		return;
-	}
-
-	if (f34->v7.has_guest_code &&
-	    f34->v7.phyaddr.guest_code != f34->v7.img.phyaddr.guest_code) {
-		f34->v7.new_partition_table = true;
-		return;
-	}
-
-	f34->v7.new_partition_table = false;
-}
-
 static void rmi_f34v7_parse_img_header_10_bl_container(struct f34_data *f34,
 						       const void *image)
 {
@@ -1202,8 +1113,6 @@ static int rmi_f34v7_parse_image_info(struct f34_data *f34)
 	rmi_f34v7_parse_partition_table(f34, f34->v7.img.fl_config.data,
 			&f34->v7.img.blkcount, &f34->v7.img.phyaddr);
 
-	rmi_f34v7_compare_partition_tables(f34);
-
 	return 0;
 }
 
@@ -1224,44 +1133,18 @@ int rmi_f34v7_do_reflash(struct f34_data *f34, const struct firmware *fw)
 	if (ret < 0)
 		goto fail;
 
-	if (!f34->v7.new_partition_table) {
-		ret = rmi_f34v7_check_ui_firmware_size(f34);
-		if (ret < 0)
-			goto fail;
-
-		ret = rmi_f34v7_check_ui_config_size(f34);
-		if (ret < 0)
-			goto fail;
-
-		if (f34->v7.has_display_cfg &&
-		    f34->v7.img.contains_display_cfg) {
-			ret = rmi_f34v7_check_dp_config_size(f34);
-			if (ret < 0)
-				goto fail;
-		}
-
-		if (f34->v7.has_guest_code && f34->v7.img.contains_guest_code) {
-			ret = rmi_f34v7_check_guest_code_size(f34);
-			if (ret < 0)
-				goto fail;
-		}
-	} else {
-		ret = rmi_f34v7_check_bl_config_size(f34);
-		if (ret < 0)
-			goto fail;
-	}
+	ret = rmi_f34v7_check_bl_config_size(f34);
+	if (ret < 0)
+		goto fail;
 
 	ret = rmi_f34v7_erase_all(f34);
 	if (ret < 0)
 		goto fail;
 
-	if (f34->v7.new_partition_table) {
-		ret = rmi_f34v7_write_partition_table(f34);
-		if (ret < 0)
-			goto fail;
-		dev_info(&f34->fn->dev, "%s: Partition table programmed\n",
-			 __func__);
-	}
+	ret = rmi_f34v7_write_partition_table(f34);
+	if (ret < 0)
+		goto fail;
+	dev_info(&f34->fn->dev, "%s: Partition table programmed\n", __func__);
 
 	dev_info(&f34->fn->dev, "Writing firmware (%d bytes)...\n",
 		 f34->v7.img.ui_firmware.size);
@@ -1286,14 +1169,12 @@ int rmi_f34v7_do_reflash(struct f34_data *f34, const struct firmware *fw)
 			goto fail;
 	}
 
-	if (f34->v7.new_partition_table) {
-		if (f34->v7.has_guest_code && f34->v7.img.contains_guest_code) {
-			dev_info(&f34->fn->dev, "Writing guest code...\n");
+	if (f34->v7.has_guest_code && f34->v7.img.contains_guest_code) {
+		dev_info(&f34->fn->dev, "Writing guest code...\n");
 
-			ret = rmi_f34v7_write_guest_code(f34);
-			if (ret < 0)
-				goto fail;
-		}
+		ret = rmi_f34v7_write_guest_code(f34);
+		if (ret < 0)
+			goto fail;
 	}
 
 fail:
@@ -1339,13 +1220,6 @@ int rmi_f34v7_start_reflash(struct f34_data *f34, const struct firmware *fw)
 	if (ret < 0)
 		goto exit;
 
-	if (!f34->v7.force_update && f34->v7.new_partition_table) {
-		dev_err(&f34->fn->dev, "%s: Partition table mismatch\n",
-				__func__);
-		ret = -EINVAL;
-		goto exit;
-	}
-
 	dev_info(&f34->fn->dev, "Firmware image OK\n");
 
 	ret = rmi_f34v7_read_flash_status(f34);
@@ -1406,6 +1280,5 @@ int rmi_f34v7_probe(struct f34_data *f34)
 	if (ret < 0)
 		return ret;
 
-	f34->v7.force_update = true;
 	return 0;
 }
-- 
2.25.1

