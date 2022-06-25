Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9B155AA25
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 14:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbiFYMzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 08:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbiFYMzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 08:55:31 -0400
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr [80.12.242.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8C8140CC
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 05:55:30 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 55Jvo2dUOIaWO55JvobFO3; Sat, 25 Jun 2022 14:55:28 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 25 Jun 2022 14:55:28 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-mmc@vger.kernel.org
Subject: [PATCH 1/3] memstick/ms_block: Fix some incorrect memory allocation
Date:   Sat, 25 Jun 2022 14:55:25 +0200
Message-Id: <dbf633c48c24ae6d95f852557e8d8b3bbdef65fe.1656155715.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1656155715.git.christophe.jaillet@wanadoo.fr>
References: <cover.1656155715.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some functions of the bitmap API take advantage of the fact that a bitmap
is an array of long.

So, to make sure this assertion is correct, allocate bitmaps with
bitmap_zalloc() instead of kzalloc()+hand-computed number of bytes.

While at it, also use bitmap_free() instead of kfree() to keep the
semantic.

Fixes: 0ab30494bc4f ("memstick: add support for legacy memorysticks")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
I guess that it is not an issue in RL because memory allocation is
certainly "rounding" to keep memory alignment.
---
 drivers/memstick/core/ms_block.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index 3993bdd4b519..f8f151163667 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -1341,17 +1341,17 @@ static int msb_ftl_initialize(struct msb_data *msb)
 	msb->zone_count = msb->block_count / MS_BLOCKS_IN_ZONE;
 	msb->logical_block_count = msb->zone_count * 496 - 2;
 
-	msb->used_blocks_bitmap = kzalloc(msb->block_count / 8, GFP_KERNEL);
-	msb->erased_blocks_bitmap = kzalloc(msb->block_count / 8, GFP_KERNEL);
+	msb->used_blocks_bitmap = bitmap_zalloc(msb->block_count, GFP_KERNEL);
+	msb->erased_blocks_bitmap = bitmap_zalloc(msb->block_count, GFP_KERNEL);
 	msb->lba_to_pba_table =
 		kmalloc_array(msb->logical_block_count, sizeof(u16),
 			      GFP_KERNEL);
 
 	if (!msb->used_blocks_bitmap || !msb->lba_to_pba_table ||
 						!msb->erased_blocks_bitmap) {
-		kfree(msb->used_blocks_bitmap);
+		bitmap_free(msb->used_blocks_bitmap);
+		bitmap_free(msb->erased_blocks_bitmap);
 		kfree(msb->lba_to_pba_table);
-		kfree(msb->erased_blocks_bitmap);
 		return -ENOMEM;
 	}
 
@@ -1946,7 +1946,7 @@ static DEFINE_MUTEX(msb_disk_lock); /* protects against races in open/release */
 static void msb_data_clear(struct msb_data *msb)
 {
 	kfree(msb->boot_page);
-	kfree(msb->used_blocks_bitmap);
+	bitmap_free(msb->used_blocks_bitmap);
 	kfree(msb->lba_to_pba_table);
 	kfree(msb->cache);
 	msb->card = NULL;
-- 
2.34.1

