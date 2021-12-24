Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D61547EDAA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 10:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352188AbhLXJRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 04:17:19 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:55264 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352181AbhLXJRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 04:17:18 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id 0ghPnOKPDBazo0ghPnX2P5; Fri, 24 Dec 2021 10:17:16 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 24 Dec 2021 10:17:16 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     lukas.bulwahn@gmail.com, dhowells@redhat.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] watch_queue: Use the bitmap API when applicable
Date:   Fri, 24 Dec 2021 10:17:14 +0100
Message-Id: <58a5271107adaa8dc8df32bd8e6b97145caf3b04.1640337380.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use bitmap_alloc() to simplify code, improve the semantic and reduce some
open-coded arithmetic in allocator arguments.

Also change a memset(0xff) into an equivalent bitmap_fill() to keep
consistency.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
---
 kernel/watch_queue.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 9c9eb20dd2c5..41ea30948c57 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -219,7 +219,6 @@ long watch_queue_set_size(struct pipe_inode_info *pipe, unsigned int nr_notes)
 	struct page **pages;
 	unsigned long *bitmap;
 	unsigned long user_bufs;
-	unsigned int bmsize;
 	int ret, i, nr_pages;
 
 	if (!wqueue)
@@ -258,13 +257,11 @@ long watch_queue_set_size(struct pipe_inode_info *pipe, unsigned int nr_notes)
 		pages[i]->index = i * WATCH_QUEUE_NOTES_PER_PAGE;
 	}
 
-	bmsize = (nr_notes + BITS_PER_LONG - 1) / BITS_PER_LONG;
-	bmsize *= sizeof(unsigned long);
-	bitmap = kmalloc(bmsize, GFP_KERNEL);
+	bitmap = bitmap_alloc(nr_notes, GFP_KERNEL);
 	if (!bitmap)
 		goto error_p;
 
-	memset(bitmap, 0xff, bmsize);
+	bitmap_fill(bitmap, nr_notes);
 	wqueue->notes = pages;
 	wqueue->notes_bitmap = bitmap;
 	wqueue->nr_pages = nr_pages;
-- 
2.32.0

