Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BB551EC98
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 11:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiEHJxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 05:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245166AbiEHJla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 05:41:30 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EEB5FDEC0;
        Sun,  8 May 2022 02:37:40 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 2489bFDd024592;
        Sun, 8 May 2022 11:37:15 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>,
        Minh Yuan <yuanmingbuaa@gmail.com>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 3/3] blk-mq: remove the error_count from struct request
Date:   Sun,  8 May 2022 11:37:09 +0200
Message-Id: <20220508093709.24548-3-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20220508093709.24548-1-w@1wt.eu>
References: <20220508093709.24548-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last two users were floppy.c and ataflop.c respectively, it was
verified that no other drivers makes use of this, so let's remove it.

Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Minh Yuan <yuanmingbuaa@gmail.com>
Cc: Denis Efremov <efremov@linux.com>,
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 include/linux/blk-mq.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 7aa5c54901a9..9f07061418db 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -163,7 +163,6 @@ struct request {
 		struct rb_node rb_node;	/* sort/lookup */
 		struct bio_vec special_vec;
 		void *completion_data;
-		int error_count; /* for legacy drivers, don't use */
 	};
 
 
-- 
2.17.5

