Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7CB4659AE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 00:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245568AbhLAXUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 18:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244913AbhLAXUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 18:20:13 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DE4C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 15:16:52 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso998158pji.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 15:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wHlHQToZmiO0i6u4i1bLeLSpUgaElXvkCKc4R2mhwPc=;
        b=DR2I6jE6isjgr4bNcGZ8zelIELuYF/LTwcQv+GUbpoEbR88UMi834W1X5itXxSSmuS
         elJLqXgRNWARmFwZw3D5wRDMdZOnn4UyL9jPKBB+pKHGiStvWUDzG6j9TnLhrZPZoCMX
         CFz2heQ3iNfrkQ8BFoRravuVywYwoePQNPY6i8GyXNgHpnKF4Y8TVMkFsHPFverUiNI3
         bQfGYqNdSpTrZ/s+6UV3mC1E/Ak8dWZAWhC2bSOKfGv3CZQ3I6WE6FExBykREh8I4v/7
         1BYnbYYkrYBrqtGQaEnEwmx1lkmApb9MRcV9ZuX/Pq7omXaXbAXl4LiaXIvNsg/Q7L17
         wZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=wHlHQToZmiO0i6u4i1bLeLSpUgaElXvkCKc4R2mhwPc=;
        b=PbeVEajcjt1WDAfgiZ98ETdbD27PQ7rB9jGV9UcpB5nfRCpP5GNvq+n6Oed2TgzLw+
         mdoVY2+zaHUoa0TbsqNiT6+1DSMTgZswHqOBp0ErNJ5/k3iSahQn9bl0hNDLTOtDcwoQ
         f32EK6wm6QbUVF3dff01XCzFGGkt9LqZnmsA+77BtP6eCPtmFxXxzj2ntXFH9rxzhn1u
         oxdxj4V9KOiXIJaiErtYnG8MazZPFahdtcpgj2HnzzWIC9p0HH3lLLNoG1Kjq29eZF7q
         H3c/5vsyFu5Glw0VIWW2Hm92LJ/J6hnutBSwkMqV+0dZN4ZrwS2SyQAGUJAnB/6SO5rs
         zzIQ==
X-Gm-Message-State: AOAM5320f3syLZ6s9XaT5WWyTMXQYwkdxmZKM6QaIIXCiz12lV2q6FEX
        njTxIYXahkqpJtL6woDoD2fVVtm6TKQ=
X-Google-Smtp-Source: ABdhPJxI83+sq/El9LyAOT67n8MtHfBQnNOfq2n88kZcyf+vKB9Q9vcSr5ombR+QmZfmyx5B6AdeeA==
X-Received: by 2002:a17:90a:e00f:: with SMTP id u15mr1544811pjy.123.1638400611603;
        Wed, 01 Dec 2021 15:16:51 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:e4a9:945b:9a3c:8231])
        by smtp.gmail.com with ESMTPSA id k6sm338021pjt.14.2021.12.01.15.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 15:16:51 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] kernfs: prevent early freeing of root node
Date:   Wed,  1 Dec 2021 15:16:48 -0800
Message-Id: <20211201231648.1027165-1-minchan@kernel.org>
X-Mailer: git-send-email 2.34.0.384.gca35af8252-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marek reported the warning below.

  =========================
  WARNING: held lock freed!
  5.16.0-rc2+ #10984 Not tainted
  -------------------------
  kworker/1:0/18 is freeing memory ffff00004034e200-ffff00004034e3ff,
with a lock still held there!
  ffff00004034e348 (&root->kernfs_rwsem){++++}-{3:3}, at:
__kernfs_remove+0x310/0x37c
  3 locks held by kworker/1:0/18:
   #0: ffff000040107938 ((wq_completion)cgroup_destroy){+.+.}-{0:0}, at:
process_one_work+0x1f0/0x6f0
   #1: ffff80000b55bdc0
((work_completion)(&(&css->destroy_rwork)->work)){+.+.}-{0:0}, at:
process_one_work+0x1f0/0x6f0
   #2: ffff00004034e348 (&root->kernfs_rwsem){++++}-{3:3}, at:
__kernfs_remove+0x310/0x37c

  stack backtrace:
  CPU: 1 PID: 18 Comm: kworker/1:0 Not tainted 5.16.0-rc2+ #10984
  Hardware name: Raspberry Pi 4 Model B (DT)
  Workqueue: cgroup_destroy css_free_rwork_fn
  Call trace:
   dump_backtrace+0x0/0x1ac
   show_stack+0x18/0x24
   dump_stack_lvl+0x8c/0xb8
   dump_stack+0x18/0x34
   debug_check_no_locks_freed+0x124/0x140
   kfree+0xf0/0x3a4
   kernfs_put+0x1f8/0x224
   __kernfs_remove+0x1b8/0x37c
   kernfs_destroy_root+0x38/0x50
   css_free_rwork_fn+0x288/0x3d4
   process_one_work+0x288/0x6f0
   worker_thread+0x74/0x470
   kthread+0x188/0x194
   ret_from_fork+0x10/0x20

Since kernfs moves the kernfs_rwsem lock into root, it couldn't hold
the lock when the root node is tearing down. Thus, get the refcount
of root node.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 fs/kernfs/dir.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 13cae0ccce74..e6d9772ddb4c 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -961,7 +961,13 @@ struct kernfs_root *kernfs_create_root(struct kernfs_syscall_ops *scops,
  */
 void kernfs_destroy_root(struct kernfs_root *root)
 {
-	kernfs_remove(root->kn);	/* will also free @root */
+	/*
+	 *  kernfs_remove holds kernfs_rwsem from the root so the root
+	 *  shouldn't be freed during the operation.
+	 */
+	kernfs_get(root->kn);
+	kernfs_remove(root->kn);
+	kernfs_put(root->kn); /* will also free @root */
 }
 
 /**
-- 
2.34.0.384.gca35af8252-goog

