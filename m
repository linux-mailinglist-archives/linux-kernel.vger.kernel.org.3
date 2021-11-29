Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F3F462221
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 21:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbhK2U0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 15:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236302AbhK2UXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 15:23:46 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA4FC09CE5E
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 08:58:29 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id v19so12661623plo.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 08:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PrD8+WGr3pDFNXiBgnH3hHvbZSgiyGx1Ir6eXUXhhs0=;
        b=bqDWVnb1qUA/xmiMAypcj8Hm8FoGjvjA6qxikF3FuvchAqtLHOXB3HLJVoMBKTPu2x
         9vrV/+DC1WYIZ47AoO5tzojIKl54fqcSUXolJ5HhiNxQgP+4XD7W7LXvz39Xf3s3RwDh
         WadFQqwXEHtrLJ/rOU5f+jGIOB19G3u09+zau88R2+DrHOa96Q+FtfKsqnoYbPMf6VOt
         cWbiNxEmVLNyzejYBZyYcPOGDVsKWFcYohM6DHlKzO6hY5SHkjyLxQtLXclixY8VeU9O
         I+WDapka/hNsqSwGMWlWjEw/nDOqd7m/Wird7U1HVIHeI+MEAskTKOf1kCabaZZ/3nLP
         4MZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=PrD8+WGr3pDFNXiBgnH3hHvbZSgiyGx1Ir6eXUXhhs0=;
        b=1dmYUBQlfszHiJ4coOsCLr3udeA9D+8688G7KIcHML9UkO+7c7J744AU5+a8srv38W
         uLdKPpyKIH3ql1UsSQOp9Rpp6f35IEzbkdVtNTlSF0kLytzT1gyfvLecuh/oCQhQB1YB
         BwWQ3SxleUh+53FOUakz8TqJwO1DODrovespKg552d6keMW9bg5dvKs1LxjrA6UhJB1s
         6C0pSwcbBFvGfxrTK52mNFsK6whvpR2+b5ozkXWvtcV4KF8EV4VSRnFvz04do7XpiWQ1
         2ky8nIJyP+gurw+aBFEOhF9iU7gk9UfKvoowckaEne3e5GmLTMG867J364IzmIzXz1PH
         axcw==
X-Gm-Message-State: AOAM530XP9QumdM77rFjMLdh6bRV/Z9zwRvYdBEvyBRmL0HcRGXz0V2/
        5Ju1pddBVF8OJOw2i2tiA+g=
X-Google-Smtp-Source: ABdhPJy/jUthJb6QX52sf/ZBzMdPhvb2heLDiMfGFphD64O4Euekjy6d6w8+RIX78+41JmI+ALOZTA==
X-Received: by 2002:a17:902:bcc4:b0:141:bfc4:ada with SMTP id o4-20020a170902bcc400b00141bfc40adamr60570463pls.20.1638205108944;
        Mon, 29 Nov 2021 08:58:28 -0800 (PST)
Received: from google.com ([2620:15c:211:201:f6a7:5c28:289f:d0a])
        by smtp.gmail.com with ESMTPSA id h3sm19296905pfc.204.2021.11.29.08.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 08:58:27 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 29 Nov 2021 08:58:26 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernfs: switch global kernfs_rwsem lock to per-fs lock
Message-ID: <YaUGsn4opaiSO2H8@google.com>
References: <20211118230008.2679780-1-minchan@kernel.org>
 <CGME20211126115446eucas1p2e377cf7718c6da6bfe40a016bc0191a8@eucas1p2.samsung.com>
 <a7464856-486a-a76a-937c-35a426555507@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7464856-486a-a76a-937c-35a426555507@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 12:54:45PM +0100, Marek Szyprowski wrote:
> Hi,
> 
> On 19.11.2021 00:00, Minchan Kim wrote:
> > The kernfs implementation has big lock granularity(kernfs_rwsem) so
> > every kernfs-based(e.g., sysfs, cgroup) fs are able to compete the
> > lock. It makes trouble for some cases to wait the global lock
> > for a long time even though they are totally independent contexts
> > each other.
> >
> > A general example is process A goes under direct reclaim with holding
> > the lock when it accessed the file in sysfs and process B is waiting
> > the lock with exclusive mode and then process C is waiting the lock
> > until process B could finish the job after it gets the lock from
> > process A.
> >
> > This patch switches the global kernfs_rwsem to per-fs lock, which
> > put the rwsem into kernfs_root.
> >
> > Suggested-by: Tejun Heo <tj@kernel.org>
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> 
> This patch landed recently in linux-next (20211126) as commit 
> 393c3714081a ("kernfs: switch global kernfs_rwsem lock to per-fs lock"). 
> In my tests I've found that it causes the following warning during the 
> system reboot:
> 
>   =========================
>   WARNING: held lock freed!
>   5.16.0-rc2+ #10984 Not tainted
>   -------------------------
>   kworker/1:0/18 is freeing memory ffff00004034e200-ffff00004034e3ff, 
> with a lock still held there!
>   ffff00004034e348 (&root->kernfs_rwsem){++++}-{3:3}, at: 
> __kernfs_remove+0x310/0x37c
>   3 locks held by kworker/1:0/18:
>    #0: ffff000040107938 ((wq_completion)cgroup_destroy){+.+.}-{0:0}, at: 
> process_one_work+0x1f0/0x6f0
>    #1: ffff80000b55bdc0 
> ((work_completion)(&(&css->destroy_rwork)->work)){+.+.}-{0:0}, at: 
> process_one_work+0x1f0/0x6f0
>    #2: ffff00004034e348 (&root->kernfs_rwsem){++++}-{3:3}, at: 
> __kernfs_remove+0x310/0x37c
> 
>   stack backtrace:
>   CPU: 1 PID: 18 Comm: kworker/1:0 Not tainted 5.16.0-rc2+ #10984
>   Hardware name: Raspberry Pi 4 Model B (DT)
>   Workqueue: cgroup_destroy css_free_rwork_fn
>   Call trace:
>    dump_backtrace+0x0/0x1ac
>    show_stack+0x18/0x24
>    dump_stack_lvl+0x8c/0xb8
>    dump_stack+0x18/0x34
>    debug_check_no_locks_freed+0x124/0x140
>    kfree+0xf0/0x3a4
>    kernfs_put+0x1f8/0x224
>    __kernfs_remove+0x1b8/0x37c
>    kernfs_destroy_root+0x38/0x50
>    css_free_rwork_fn+0x288/0x3d4
>    process_one_work+0x288/0x6f0
>    worker_thread+0x74/0x470
>    kthread+0x188/0x194
>    ret_from_fork+0x10/0x20
> 
> Let me know if you need more information or help in reproducing this issue.

Hi Marek,

Thanks for the report. Could you try this one? 

From 68741aa598ffd4a407d6d5f6b58bc7e7281e6f81 Mon Sep 17 00:00:00 2001
From: Minchan Kim <minchan@kernel.org>
Date: Mon, 29 Nov 2021 08:40:15 -0800
Subject: [PATCH] kernfs: prevent early freeing of root node

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
2.34.0.rc2.393.gf8c9666880-goog

