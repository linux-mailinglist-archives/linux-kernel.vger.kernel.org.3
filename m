Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BA44E35C2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 01:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbiCVAs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 20:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbiCVAsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 20:48:25 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9453BBBC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 17:46:59 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id v4so14393359pjh.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 17:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4NCbf0eeD/oob7o3dgsHdsdJCZNRMgaAgRTMAe2jS9M=;
        b=KhroE2nIoxYwbVeo47PY/NpMVvm96BuAJ8nJ09HH4bF59VJACQrho/0EHFqKOn6T6n
         zTgJV1UtLcA8Kynyl7uSjkxi+QUjIOPvB1SmfOt0MbCwH+tCx6uHLqEtRZHfhA94guA0
         P3kH4NUD+A4WmWSOqpGTEVtNSkuWxtPRw4R3gCfSwzbPpxgi8cpD9leJZfBHSBJ6DCwZ
         ayaMSkA5PioBmOwS7HkZ/ays40t6psZDCyBPrJdrhZhJaAFxHeeRZxMiGg26Loyyl2uQ
         j4UceoY+vg2GwsOvbJIa7mry1txOTAtSqKXzkDVgSPbseipI8SqeeXwzzxvJ6nMENX3f
         eo+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4NCbf0eeD/oob7o3dgsHdsdJCZNRMgaAgRTMAe2jS9M=;
        b=KjOxnbshYlgCsG9ufEDalgSxuIYHKnw2rJ7K3r1Xkj6uxkA6MBwdRdD2N0ynw3xqcn
         2CWB6LpYYdk8Nzli1eXyELuayxg8bc2qE+MIHdyvi71buiOOjYSRQCmz9ZGIhLtomXtC
         9TikZjaHS8maIRP1FdZR3FVvYn/imowuuy+x0Rz4BTdXvGYkB+mNb/mOXVbjAZs+vCDc
         OWnYhOjkt9PueLVQ7QR6MOa3LOlrae/I0YSfqMVSOQyWCUWv+3jnzpEx237xzN43IYEO
         FbK5O7Xc2zstIrXZHwoJdh68+lNjjhpGYpwqm5R3r4fhzwgxR2oPtqUvgnbNgZC5ZJJG
         1gHw==
X-Gm-Message-State: AOAM530BbFOQG3NoYgLtPLBAvDZ7JfwSTASapXa0Uk/OGZvIliqLESR0
        IWDTXoQsLC9N2/xjdzdNNtM=
X-Google-Smtp-Source: ABdhPJyP/14F3Q68+marHzk4wdinpQzFCPFYXqnlihLvjr2Cfr5wt4oyd1mOF+VKBkH12D7SRAiW8A==
X-Received: by 2002:a17:90b:4a12:b0:1c7:5aa4:2a72 with SMTP id kk18-20020a17090b4a1200b001c75aa42a72mr766905pjb.201.1647910018999;
        Mon, 21 Mar 2022 17:46:58 -0700 (PDT)
Received: from edumazet1.svl.corp.google.com ([2620:15c:2c4:201:c6c2:7860:be83:7d4f])
        by smtp.gmail.com with ESMTPSA id z14-20020aa7888e000000b004f79f59827asm20950127pfe.139.2022.03.21.17.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 17:46:58 -0700 (PDT)
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzkaller@googlegroups.com>, Jann Horn <jannh@google.com>
Subject: [PATCH] watch_queue: Free the page array when watch_queue is dismantled
Date:   Mon, 21 Mar 2022 17:46:54 -0700
Message-Id: <20220322004654.618274-1-eric.dumazet@gmail.com>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Reported-by: syzbot <syzkaller@googlegroups.com>
Fixes: c73be61cede5 ("pipe: Add general notification queue support")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jann Horn <jannh@google.com>
---
 kernel/watch_queue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 00703444a21948deaa8b7ac8b57b73528badff0d..58fe68664eb1b0001cb00c8d046e108462df4836 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -370,6 +370,7 @@ static void __put_watch_queue(struct kref *kref)
 
 	for (i = 0; i < wqueue->nr_pages; i++)
 		__free_page(wqueue->notes[i]);
+	kfree(wqueue->notes);
 	bitmap_free(wqueue->notes_bitmap);
 
 	wfilter = rcu_access_pointer(wqueue->filter);
-- 
2.35.1.894.gb6a874cedc-goog

