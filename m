Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C028A46590C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 23:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353569AbhLAWXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 17:23:12 -0500
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:64158 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353540AbhLAWXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 17:23:06 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id sXx0ml9sL65jHsXx0mTXPr; Wed, 01 Dec 2021 23:19:43 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 01 Dec 2021 23:19:43 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     sakari.ailus@linux.intel.com, laurent.pinchart@ideasonboard.com,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] media: mc: mc-entity.c: Use bitmap_zalloc() when applicable
Date:   Wed,  1 Dec 2021 23:19:40 +0100
Message-Id: <b11f646dda189f490c06bf671f64a2cc0af4d45c.1638397089.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'ent_enum->bmap' is a bitmap. So use 'bitmap_zalloc()' to simplify
code, improve the semantic and avoid some open-coded arithmetic in
allocator arguments.

Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
consistency.

While at it, remove a useless 'bitmap_zero()'.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/media/mc/mc-entity.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/mc/mc-entity.c b/drivers/media/mc/mc-entity.c
index c02340698ad6..b411f9796191 100644
--- a/drivers/media/mc/mc-entity.c
+++ b/drivers/media/mc/mc-entity.c
@@ -48,12 +48,10 @@ __must_check int __media_entity_enum_init(struct media_entity_enum *ent_enum,
 					  int idx_max)
 {
 	idx_max = ALIGN(idx_max, BITS_PER_LONG);
-	ent_enum->bmap = kcalloc(idx_max / BITS_PER_LONG, sizeof(long),
-				 GFP_KERNEL);
+	ent_enum->bmap = bitmap_zalloc(idx_max, GFP_KERNEL);
 	if (!ent_enum->bmap)
 		return -ENOMEM;
 
-	bitmap_zero(ent_enum->bmap, idx_max);
 	ent_enum->idx_max = idx_max;
 
 	return 0;
@@ -62,7 +60,7 @@ EXPORT_SYMBOL_GPL(__media_entity_enum_init);
 
 void media_entity_enum_cleanup(struct media_entity_enum *ent_enum)
 {
-	kfree(ent_enum->bmap);
+	bitmap_free(ent_enum->bmap);
 }
 EXPORT_SYMBOL_GPL(media_entity_enum_cleanup);
 
-- 
2.30.2

