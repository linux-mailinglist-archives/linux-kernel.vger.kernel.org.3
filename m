Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13DA565D96
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 20:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbiGDSqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 14:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiGDSqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 14:46:07 -0400
Received: from smtp.smtpout.orange.fr (smtp05.smtpout.orange.fr [80.12.242.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFA7DEC3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 11:46:06 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 8R57ovKj1E80K8R58oOSoK; Mon, 04 Jul 2022 20:46:03 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Mon, 04 Jul 2022 20:46:03 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-mtd@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ubi: fastmap: Use the bitmap API to allocate bitmaps
Date:   Mon,  4 Jul 2022 20:46:00 +0200
Message-Id: <64cde893efca8f4dc381184cd7f6e5a54cd000f9.1656960335.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use bitmap_zalloc()/bitmap_free() instead of hand-writing them.

It is less verbose and it improves the semantic.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/mtd/ubi/fastmap.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/ubi/fastmap.c b/drivers/mtd/ubi/fastmap.c
index 6e95c4b1473e..ca2d9efe62c3 100644
--- a/drivers/mtd/ubi/fastmap.c
+++ b/drivers/mtd/ubi/fastmap.c
@@ -20,8 +20,7 @@ static inline unsigned long *init_seen(struct ubi_device *ubi)
 	if (!ubi_dbg_chk_fastmap(ubi))
 		return NULL;
 
-	ret = kcalloc(BITS_TO_LONGS(ubi->peb_count), sizeof(unsigned long),
-		      GFP_KERNEL);
+	ret = bitmap_zalloc(ubi->peb_count, GFP_KERNEL);
 	if (!ret)
 		return ERR_PTR(-ENOMEM);
 
@@ -34,7 +33,7 @@ static inline unsigned long *init_seen(struct ubi_device *ubi)
  */
 static inline void free_seen(unsigned long *seen)
 {
-	kfree(seen);
+	bitmap_free(seen);
 }
 
 /**
@@ -1108,8 +1107,7 @@ int ubi_fastmap_init_checkmap(struct ubi_volume *vol, int leb_count)
 	if (!ubi->fast_attach)
 		return 0;
 
-	vol->checkmap = kcalloc(BITS_TO_LONGS(leb_count), sizeof(unsigned long),
-				GFP_KERNEL);
+	vol->checkmap = bitmap_zalloc(leb_count, GFP_KERNEL);
 	if (!vol->checkmap)
 		return -ENOMEM;
 
@@ -1118,7 +1116,7 @@ int ubi_fastmap_init_checkmap(struct ubi_volume *vol, int leb_count)
 
 void ubi_fastmap_destroy_checkmap(struct ubi_volume *vol)
 {
-	kfree(vol->checkmap);
+	bitmap_free(vol->checkmap);
 }
 
 /**
-- 
2.34.1

