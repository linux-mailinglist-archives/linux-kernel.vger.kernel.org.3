Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5D3480333
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 19:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbhL0SJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 13:09:24 -0500
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:60959 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhL0SJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 13:09:23 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id 1uQynxe1xMNzv1uQznw2pp; Mon, 27 Dec 2021 19:09:22 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Mon, 27 Dec 2021 19:09:22 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     hubcap@omnibond.com, martin@omnibond.com, viro@zeniv.linux.org.uk
Cc:     devel@lists.orangefs.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] orangefs: Fix the size of a memory allocation in orangefs_bufmap_alloc()
Date:   Mon, 27 Dec 2021 19:09:18 +0100
Message-Id: <dd7d2a1dc70886787487452a50b1079ec8de5bc8.1640628556.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'buffer_index_array' really looks like a bitmap. So it should be allocated
as such.
When kzalloc is called, a number of bytes is expected, but a number of
longs is passed instead.

In get(), if not enough memory is allocated, un-allocated memory may be
read or written.

So use bitmap_zalloc() to safely allocate the correct memory size and
avoid un-expected behavior.

While at it, change the corresponding kfree() into bitmap_free() to keep
the semantic.

Fixes: ea2c9c9f6574 ("orangefs: bufmap rewrite")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
If the above is correct, I guess that cc stable should be added.
---
 fs/orangefs/orangefs-bufmap.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/orangefs/orangefs-bufmap.c b/fs/orangefs/orangefs-bufmap.c
index 538e839590ef..b501dc07f922 100644
--- a/fs/orangefs/orangefs-bufmap.c
+++ b/fs/orangefs/orangefs-bufmap.c
@@ -176,7 +176,7 @@ orangefs_bufmap_free(struct orangefs_bufmap *bufmap)
 {
 	kfree(bufmap->page_array);
 	kfree(bufmap->desc_array);
-	kfree(bufmap->buffer_index_array);
+	bitmap_free(bufmap->buffer_index_array);
 	kfree(bufmap);
 }
 
@@ -226,8 +226,7 @@ orangefs_bufmap_alloc(struct ORANGEFS_dev_map_desc *user_desc)
 	bufmap->desc_size = user_desc->size;
 	bufmap->desc_shift = ilog2(bufmap->desc_size);
 
-	bufmap->buffer_index_array =
-		kzalloc(DIV_ROUND_UP(bufmap->desc_count, BITS_PER_LONG), GFP_KERNEL);
+	bufmap->buffer_index_array = bitmap_zalloc(bufmap->desc_count, GFP_KERNEL);
 	if (!bufmap->buffer_index_array)
 		goto out_free_bufmap;
 
@@ -250,7 +249,7 @@ orangefs_bufmap_alloc(struct ORANGEFS_dev_map_desc *user_desc)
 out_free_desc_array:
 	kfree(bufmap->desc_array);
 out_free_index_array:
-	kfree(bufmap->buffer_index_array);
+	bitmap_free(bufmap->buffer_index_array);
 out_free_bufmap:
 	kfree(bufmap);
 out:
-- 
2.32.0

