Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A3648F9CC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 00:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbiAOXRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 18:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbiAOXRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 18:17:04 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AC4C061574
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 15:17:04 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id j27so6118206pgj.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 15:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sdOdPHO13ELbYkVKga0qbkuFCOM80w2sjWMdUsNelzI=;
        b=HG5JfIt4nloEMLlZ50FdwxUckJJ8iy7ZPM6gLlXFKzC2Io0iFXqatAZ0mXsz95a953
         bwabUdT/UYDXVyo1MMaGKSdl3dpwPQB5vJgYCQjVkc6d6jI8J8ZAG7j3+wHbXBodVpBP
         f/6NPR8h5JO4QK0HHY98iPgKf2MVuNH3Pz5TIRR+CdnOYcyJXevHFatggXpnDeKZQAWI
         fBOWH5Cw0VejCEROr7nRKr9S5PH1Z3lC/XoTSrnIxL9CSgs2/GxzU6+5NFVCws+N4CVv
         +jwKzHMv1AYZ0gGCRDghsazU98csRWSttZTnAzJ4w2HBYtBoW3b9lZ0CJpRUeSJpJ36F
         6FTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=sdOdPHO13ELbYkVKga0qbkuFCOM80w2sjWMdUsNelzI=;
        b=e54DyfxE+o8eHgnLG68499wznlojnA9BM+GD7Fkfr19prx4TJ2w7Ek49N+dcpmNLLm
         dbQuYpxs+6i0PUeQZNtW3d/leB2VOXHxOLqmsC5dQG/mLU0WZuhqclNhVVXEFuvhbPdc
         Uw2OLpAgDiUPQjbtcNdGoIbB7P5ZtzeTb1AbIov/Dtna4Q5OlHmu6/N0PaaOcDSd9arV
         lLSRXOc9/G26azhX4NQPsSbXgratBD6G/6GsEJ2krXy4lCyn3UCQEGLoebUJSbIbcJQ7
         aIjNXHWic5DiBAMnRU9nLlHXHHBvLimXdJQvyx0f5KTrsPjBt0ew4dp7wmiuykeYj5+R
         cIYA==
X-Gm-Message-State: AOAM531HB5nJNi9eJ5dwuvTru48guZPxLXQFPHVRK4tqFoE7vcLLKDk1
        b7TSLJUjvcvCjC92TYzlkRXYN0VT3Cg=
X-Google-Smtp-Source: ABdhPJzGYQZtvYzEXbO5jB+oMm7DZ7FoBOt2wklAeNS+Z15RquTld9i427Mns6SoTKomA9AcWyP03A==
X-Received: by 2002:a63:6687:: with SMTP id a129mr13053286pgc.477.1642288623494;
        Sat, 15 Jan 2022 15:17:03 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:8f5b:e301:1a36:bbbb])
        by smtp.gmail.com with ESMTPSA id s22sm3139529pje.1.2022.01.15.15.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jan 2022 15:17:02 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Tim Murray <timmurray@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH] locking: add missing __sched attributes
Date:   Sat, 15 Jan 2022 15:16:57 -0800
Message-Id: <20220115231657.84828-1-minchan@kernel.org>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds __sched attributes to a few missing places
to show blocked function rather than locking function
in get_wchan.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 kernel/locking/percpu-rwsem.c | 5 +++--
 kernel/locking/rwsem.c        | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index 70a32a576f3f..c9fdae94e098 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -7,6 +7,7 @@
 #include <linux/rcupdate.h>
 #include <linux/sched.h>
 #include <linux/sched/task.h>
+#include <linux/sched/debug.h>
 #include <linux/errno.h>
 
 int __percpu_init_rwsem(struct percpu_rw_semaphore *sem,
@@ -162,7 +163,7 @@ static void percpu_rwsem_wait(struct percpu_rw_semaphore *sem, bool reader)
 	__set_current_state(TASK_RUNNING);
 }
 
-bool __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
+bool __sched __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
 {
 	if (__percpu_down_read_trylock(sem))
 		return true;
@@ -211,7 +212,7 @@ static bool readers_active_check(struct percpu_rw_semaphore *sem)
 	return true;
 }
 
-void percpu_down_write(struct percpu_rw_semaphore *sem)
+void __sched percpu_down_write(struct percpu_rw_semaphore *sem)
 {
 	might_sleep();
 	rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 69aba4abe104..acde5d6f1254 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1048,7 +1048,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 /*
  * Wait until we successfully acquire the write lock
  */
-static struct rw_semaphore *
+static struct rw_semaphore __sched *
 rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 {
 	long count;
-- 
2.34.1.703.g22d0c6ccf7-goog

