Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026334E9D09
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 19:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244197AbiC1RIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 13:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbiC1RIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 13:08:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28F38289B6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 10:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648487228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=IeYACTmmO7H2Tu8Q856CNWAzkMVAmNYvrP7zKnjNYOw=;
        b=h7laMUW+AODwYiu52YzAk2zHzk66ay/CSR4KTg2xEcPc9IRxisnP4Te6pQCS7RkObwJSfY
        9ya5cdPHvYU+a7odsOlyTFU/63f6GOLLbpWvJa7qrKC3F1nviqSscuN48o7cLPskeyIknR
        SYSTSCaR8NOo5/IT3V59cC7hGfnrsOs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-t-R9vqa-Md-_MAgN78NIyA-1; Mon, 28 Mar 2022 13:07:06 -0400
X-MC-Unique: t-R9vqa-Md-_MAgN78NIyA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 03C0C3803902;
        Mon, 28 Mar 2022 17:07:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E9C1441E2D;
        Mon, 28 Mar 2022 17:07:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] watch_queue: Free the page array when watch_queue is
 dismantled
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     syzbot+25ea042ae28f3888727a@syzkaller.appspotmail.com,
        Eric Dumazet <edumazet@google.com>,
        Jann Horn <jannh@google.com>, dhowells@redhat.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 28 Mar 2022 18:07:04 +0100
Message-ID: <164848722432.2645691.7772718304671310430.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

Commit 7ea1a0124b6d ("watch_queue: Free the alloc bitmap
when the watch_queue is torn down") took care of the bitmap,
but not the page array.

BUG: memory leak
unreferenced object 0xffff88810d9bc140 (size 32):
  comm "syz-executor335", pid 3603, jiffies 4294946994 (age 12.840s)
  hex dump (first 32 bytes):
    40 a7 40 04 00 ea ff ff 00 00 00 00 00 00 00 00  @.@.............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81459bff>] kmalloc_array include/linux/slab.h:621 [inline]
    [<ffffffff81459bff>] kcalloc include/linux/slab.h:652 [inline]
    [<ffffffff81459bff>] watch_queue_set_size+0x12f/0x2e0 kernel/watch_queue.c:251
    [<ffffffff8159fcf2>] pipe_ioctl+0x82/0x140 fs/pipe.c:632
    [<ffffffff815b601c>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff815b601c>] __do_sys_ioctl fs/ioctl.c:874 [inline]
    [<ffffffff815b601c>] __se_sys_ioctl fs/ioctl.c:860 [inline]
    [<ffffffff815b601c>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:860
    [<ffffffff84493a05>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84493a05>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

Reported-by: syzbot+25ea042ae28f3888727a@syzkaller.appspotmail.com
Fixes: c73be61cede5 ("pipe: Add general notification queue support")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Cc: Jann Horn <jannh@google.com>
Link: https://lore.kernel.org/r/20220322004654.618274-1-eric.dumazet@gmail.com/
---

 kernel/watch_queue.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 3990e4df3d7b..230038d4f908 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -370,6 +370,7 @@ static void __put_watch_queue(struct kref *kref)
 
 	for (i = 0; i < wqueue->nr_pages; i++)
 		__free_page(wqueue->notes[i]);
+	kfree(wqueue->notes);
 	bitmap_free(wqueue->notes_bitmap);
 
 	wfilter = rcu_access_pointer(wqueue->filter);


