Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8776B48EB98
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 15:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbiANOXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 09:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiANOXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 09:23:19 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E662C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 06:23:19 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id c2so711830qvw.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 06:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qUKuxAJ4vvXBnCZ5Cp++Kv0NqUtoyv7zDYvbU0ZGaLw=;
        b=RDWJf9flKRrinMxBPIFfoLLbdVo46nSdNeQ+UEzh3IvceAnpuhHQvInGStZr+FcAvI
         J4niq/Pp4MkhCgcMgb6gMI7OzEYN1kPwTpI4R5XvinhYJejIjBdsDKjiRZwPDz5s+RNR
         UNfHZTG1LthFn3Be7tFyYi5R2L6LVsrj9OHkTLV9EmQWh72vBOdkn8nzo9s0x4EbdkGl
         jLlLnkNCgOV4/FgYwwrcWDVqcAVmJM2zvRIf1XOdY/eNMyAuUhbIWbEXG9vKyGuo+fAJ
         gxjsQWQb4nfl6amJ3F2rk2h24VDsqFqyPM/tYUFUe+zsDk40J5GMp5Odvv72jI/Jwc2n
         fwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qUKuxAJ4vvXBnCZ5Cp++Kv0NqUtoyv7zDYvbU0ZGaLw=;
        b=ofQ4eorlJRHwt/sw4sBccRa5PjxZWkQ4A5p7s5pbbdR/HPtxQpM9WPuEJGuRk3QuBI
         +Y9r/pP94IyoO0R4Jv65VpoV4ww/Ks4JlUZ7jMOmJLomeDUGao5syyUNWOIlF5Do73TU
         mHoSJLVYrqFvXuv/UCqDp1rpwCSJGn9eyvoOJkNNZBinJy8yLZ8OWSGTZwwtMN31YnA3
         dDFB3vaF3/NfsEuZolxN5Sv3pK8+MHup4Zc526Rz4oecvxmKVtTTSbi19+sf/9PJua3R
         SSEQtW4iiQsTZklh1sXEp4oYCxwiciZ9tpElXbt++hXwCpOfzMpr7ROmRXmcTwaT0ard
         Hqfw==
X-Gm-Message-State: AOAM531kEq1f15lQIdO1xxHoasL1XXNvAWMR+I33iImxAjKmw2wO2Z79
        YjGCpP0Bbh5x5y3peqXSEzn9FESq7Coing==
X-Google-Smtp-Source: ABdhPJx4uwU/lSnmRMoxFtg9xl0TNm2N+VOsVuU2zK1e5nlMJ4J56l/MKaiUPzmFAp+bw0FrF0Ohrg==
X-Received: by 2002:ad4:5f4b:: with SMTP id p11mr8402085qvg.46.1642170197973;
        Fri, 14 Jan 2022 06:23:17 -0800 (PST)
Received: from wsfd-netdev15.ntdv.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id y16sm3337315qki.41.2022.01.14.06.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 06:23:17 -0800 (PST)
From:   Xin Long <lucien.xin@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Antoine Tenart <atenart@kernel.org>
Subject: [PATCH] mm: slub: fix a deadlock warning in kmem_cache_destroy
Date:   Fri, 14 Jan 2022 09:23:16 -0500
Message-Id: <388098b2c03fbf0a732834fc01b2d875c335bc49.1642170196.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpus_read_lock() is introduced into kmem_cache_destroy() by
commit 5a836bf6b09f ("mm: slub: move flush_cpu_slab() invocations
__free_slab() invocations out of IRQ context"), and it could cause
a deadlock.

As Antoine pointed out, when one thread calls kmem_cache_destroy(), it is
blocking until kn->active becomes 0 in kernfs_drain() after holding
cpu_hotplug_lock. While in another thread, when calling kernfs_fop_write(),
it may try to hold cpu_hotplug_lock after incrementing kn->active by
calling kernfs_get_active():

        CPU0                        CPU1
        ----                        ----
  cpus_read_lock()
                                   kn->active++
                                   cpus_read_lock() [a]
  wait until kn->active == 0

Although cpu_hotplug_lock is a RWSEM, [a] will not block in there. But as
lockdep annotations are added for cpu_hotplug_lock, a deadlock warning
would be detected:

  ======================================================
  WARNING: possible circular locking dependency detected
  ------------------------------------------------------
  dmsetup/1832 is trying to acquire lock:
  ffff986f5a0f9f20 (kn->count#144){++++}-{0:0}, at: kernfs_remove+0x1d/0x30

  but task is already holding lock:
  ffffffffa43817c0 (slab_mutex){+.+.}-{3:3}, at: kmem_cache_destroy+0x2a/0x120

  which lock already depends on the new lock.

  the existing dependency chain (in reverse order) is:

  -> #2 (slab_mutex){+.+.}-{3:3}:
         lock_acquire+0xe8/0x470
         mutex_lock_nested+0x47/0x80
         kmem_cache_destroy+0x2a/0x120
         bioset_exit+0xb5/0x100
         cleanup_mapped_device+0x26/0xf0 [dm_mod]
         free_dev+0x43/0xb0 [dm_mod]
         __dm_destroy+0x153/0x1b0 [dm_mod]
         dev_remove+0xe4/0x1a0 [dm_mod]
         ctl_ioctl+0x1af/0x3f0 [dm_mod]
         dm_ctl_ioctl+0xa/0x10 [dm_mod]
         do_vfs_ioctl+0xa5/0x760
         ksys_ioctl+0x60/0x90
         __x64_sys_ioctl+0x16/0x20
         do_syscall_64+0x8c/0x240
         entry_SYSCALL_64_after_hwframe+0x6a/0xdf

  -> #1 (cpu_hotplug_lock){++++}-{0:0}:
         lock_acquire+0xe8/0x470
         cpus_read_lock+0x39/0x100
         cpu_partial_store+0x44/0x80
         slab_attr_store+0x20/0x30
         kernfs_fop_write+0x101/0x1b0
         vfs_write+0xd4/0x1e0
         ksys_write+0x52/0xc0
         do_syscall_64+0x8c/0x240
         entry_SYSCALL_64_after_hwframe+0x6a/0xdf

  -> #0 (kn->count#144){++++}-{0:0}:
         check_prevs_add+0x185/0xb80
         __lock_acquire+0xd8f/0xe90
         lock_acquire+0xe8/0x470
         __kernfs_remove+0x25e/0x320
         kernfs_remove+0x1d/0x30
         kobject_del+0x28/0x60
         kmem_cache_destroy+0xf1/0x120
         bioset_exit+0xb5/0x100
         cleanup_mapped_device+0x26/0xf0 [dm_mod]
         free_dev+0x43/0xb0 [dm_mod]
         __dm_destroy+0x153/0x1b0 [dm_mod]
         dev_remove+0xe4/0x1a0 [dm_mod]
         ctl_ioctl+0x1af/0x3f0 [dm_mod]
         dm_ctl_ioctl+0xa/0x10 [dm_mod]
         do_vfs_ioctl+0xa5/0x760
         ksys_ioctl+0x60/0x90
         __x64_sys_ioctl+0x16/0x20
         do_syscall_64+0x8c/0x240
         entry_SYSCALL_64_after_hwframe+0x6a/0xdf

  other info that might help us debug this:

  Chain exists of:
    kn->count#144 --> cpu_hotplug_lock --> slab_mutex

   Possible unsafe locking scenario:

         CPU0                    CPU1
         ----                    ----
    lock(slab_mutex);
                                 lock(cpu_hotplug_lock);
                                 lock(slab_mutex);
    lock(kn->count#144);

   *** DEADLOCK ***

  3 locks held by dmsetup/1832:
   #0: ffffffffa43fe5c0 (bio_slab_lock){+.+.}-{3:3}, at: bioset_exit+0x62/0x100
   #1: ffffffffa3e87c20 (cpu_hotplug_lock){++++}-{0:0}, at: kmem_cache_destroy+0x1c/0x120
   #2: ffffffffa43817c0 (slab_mutex){+.+.}-{3:3}, at: kmem_cache_destroy+0x2a/0x120

  stack backtrace:
  Call Trace:
   dump_stack+0x5c/0x80
   check_noncircular+0xff/0x120
   check_prevs_add+0x185/0xb80
   __lock_acquire+0xd8f/0xe90
   lock_acquire+0xe8/0x470
   __kernfs_remove+0x25e/0x320
   kernfs_remove+0x1d/0x30
   kobject_del+0x28/0x60
   kmem_cache_destroy+0xf1/0x120
   bioset_exit+0xb5/0x100
   cleanup_mapped_device+0x26/0xf0 [dm_mod]
   free_dev+0x43/0xb0 [dm_mod]
   __dm_destroy+0x153/0x1b0 [dm_mod]
   dev_remove+0xe4/0x1a0 [dm_mod]
   ctl_ioctl+0x1af/0x3f0 [dm_mod]
   dm_ctl_ioctl+0xa/0x10 [dm_mod]
   do_vfs_ioctl+0xa5/0x760
   ksys_ioctl+0x60/0x90
   __x64_sys_ioctl+0x16/0x20
   do_syscall_64+0x8c/0x240
   entry_SYSCALL_64_after_hwframe+0x6a/0xdf

Since cpus_read_lock() is supposed to protect the cpu related data, it
makes sense to fix this issue by moving cpus_read_lock() from
kmem_cache_destroy() to __kmem_cache_shutdown(). While at it,
add the missing cpus_read_lock() in slab_mem_going_offline_callback().

Fixes: 5a836bf6b09f ("mm: slub: move flush_cpu_slab() invocations __free_slab() invocations out of IRQ context")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 mm/slab_common.c | 2 --
 mm/slub.c        | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index e5d080a93009..06ec3fa585e6 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -494,7 +494,6 @@ void kmem_cache_destroy(struct kmem_cache *s)
 	if (unlikely(!s))
 		return;
 
-	cpus_read_lock();
 	mutex_lock(&slab_mutex);
 
 	s->refcount--;
@@ -509,7 +508,6 @@ void kmem_cache_destroy(struct kmem_cache *s)
 	}
 out_unlock:
 	mutex_unlock(&slab_mutex);
-	cpus_read_unlock();
 }
 EXPORT_SYMBOL(kmem_cache_destroy);
 
diff --git a/mm/slub.c b/mm/slub.c
index abe7db581d68..754f020235ee 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4311,7 +4311,7 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
 	int node;
 	struct kmem_cache_node *n;
 
-	flush_all_cpus_locked(s);
+	flush_all(s);
 	/* Attempt to free all objects */
 	for_each_kmem_cache_node(s, node, n) {
 		free_partial(s, n);
@@ -4646,7 +4646,7 @@ static int slab_mem_going_offline_callback(void *arg)
 
 	mutex_lock(&slab_mutex);
 	list_for_each_entry(s, &slab_caches, list) {
-		flush_all_cpus_locked(s);
+		flush_all(s);
 		__kmem_cache_do_shrink(s);
 	}
 	mutex_unlock(&slab_mutex);
-- 
2.27.0

