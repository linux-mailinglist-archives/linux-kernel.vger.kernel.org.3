Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A151157B1C3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 09:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239642AbiGTH3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 03:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiGTH26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 03:28:58 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1A754CAF;
        Wed, 20 Jul 2022 00:28:55 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id n4-20020a17090a73c400b001f1e87432c2so1313217pjk.3;
        Wed, 20 Jul 2022 00:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RFrHXTL8Q2FobO7rjUUAkyYxzxKSZ1yAWcrkdPU4Ak8=;
        b=ngcmrnB/DSWpG3Oqu0t39TGFQj2tURSijQLbs2mIiaW2gIuMxAAUMar2FDoNtpYXQF
         /sBzEKP6WamnRh2+GLpSW6dW1NMoAkuCp0+olpBunnzEttZ505b/eXfMS8E6T7r42S4b
         dGisVBPKLF0F60X+RmUW+o/6PFT+ZsfL9RjjI25fB5zkcsSfGgsjGkYVUYg6ZC8ODUkY
         /K8q6PdHZlRyNdsZw1vijIssNeQxph1NhIXq6lhV5d6nKAbZCR4z5FIUuDwQv/biG+9g
         NDgMra9Eb7BMIA6sKeptP0cQ+hDv+UrRN9QbfL9sECy9lOIcGd543qNyADGYZ/OeKMlS
         0oKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RFrHXTL8Q2FobO7rjUUAkyYxzxKSZ1yAWcrkdPU4Ak8=;
        b=NyJBNPcv9yEMIfM5SiL7u/HGWSyCKkn/XafYkBIBbOCdanGCvlwBUOy7JFXoa8e3bX
         mPflW0xexbGiQs842Sq01xysDqfes9x5obJwgbcNcXRySRjP9edoA7EB0CSyoTkFDdGj
         i9+pEqEBMqI4OfQ/CqmeBywQeQNhoEUa/9uUdJ1XF3CjfPtwFErW7vDdleKDof88GyvN
         Cj9zcRH9TDsiyP2KzJspD1iGo1GuwTibir1mU3e8RmU5qTqpXEpXgQIn+4gjJUIv+JuC
         T7sb5nE21F1htV77gPMYnefvzK7X43bKD/VjTuCcVTKCBaMAa6jgSyPmsKqmpywntU1/
         Tb1g==
X-Gm-Message-State: AJIora9IGtZykK4GFZhn1AAh4eLpsXNBrYZC5wZDvNwBeuQwaWzWS+fG
        UIt4I3m3DpEFYewPyQJVkDakg6jbrSIZ7g==
X-Google-Smtp-Source: AGRyM1uh9ttAT4ntu5MJ2NslnmzrqW5AtYrNwTs30U6mTfJ5yD0pMdfEPMDHTbqOMGxd6hzKhZB4LA==
X-Received: by 2002:a17:90b:3d85:b0:1f0:7355:734 with SMTP id pq5-20020a17090b3d8500b001f073550734mr3798860pjb.24.1658302134485;
        Wed, 20 Jul 2022 00:28:54 -0700 (PDT)
Received: from ubuntu.hobot.cc ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id y12-20020aa78f2c000000b00528c149fe97sm12834297pfr.89.2022.07.20.00.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 00:28:53 -0700 (PDT)
From:   "yuxin.ye" <yeyuxin0925@gmail.com>
To:     linux-rt-users@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, longman@redhat.com,
        boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, "yuxin.ye" <yeyuxin0925@gmail.com>
Subject: [PATCH RFC] rtmutex: Fix BUG_ON at kernel/locking/rtmutex.c:1331!
Date:   Wed, 20 Jul 2022 00:28:06 -0700
Message-Id: <20220720072806.43445-1-yeyuxin0925@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

before rt_mutex_adjust_prio_chain(),unlock lock->wait_lock will cause
BUG_ON at kernel/locking/rtmutex.c:1331:
[147800.420240] Call trace:
[147800.420243]  dump_backtrace+0x0/0x1cc
[147800.420260]  show_stack+0x18/0x24
[147800.420267]  dump_stack+0xcc/0x12c
[147800.420278]  nmi_cpu_backtrace+0xbc/0xc8
[147800.420287]  nmi_trigger_cpumask_backtrace+0xcc/0x1c0
[147800.420295]  arch_trigger_cpumask_backtrace+0x28/0x40
[147800.420304]  oops_enter+0x3c/0x48
[147800.420313]  die+0x54/0x228
[147800.420320]  bug_handler+0x44/0x6c
[147800.420327]  call_break_hook+0x40/0x74
[147800.420336]  brk_handler+0x1c/0x5c
[147800.420342]  do_debug_exception+0x88/0xc4
[147800.420350]  el1_dbg+0x38/0x54
[147800.420359]  el1_sync_handler+0xac/0xb8
[147800.420365]  el1_sync+0x88/0x140
[147800.420372]  task_blocks_on_rt_mutex+0x94/0x1b4
[147800.420383]  rt_spin_lock_slowlock_locked+0x90/0x1bc
[147800.420391]  rt_spin_lock_slowlock+0x5c/0x94
[147800.420399]  rt_spin_lock_fastlock.constprop.0+0x28/0x34
[147800.420408]  rt_spin_lock+0x10/0x24
[147800.420415]  local_lock_acquire+0x28/0xd0
[147800.420425]  free_unref_page+0x94/0x114
[147800.420432]  free_the_page+0x14/0x2c
[147800.420440]  __free_pages+0x30/0x78
[147800.420447]  __vunmap+0x188/0x1c8
[147800.420453]  __vfree+0x4c/0x50
[147800.420460]  vfree+0x30/0x40
[147800.420465]  free_thread_stack+0xd0/0x120
[147800.420472]  put_task_stack+0x60/0x6c
[147800.420479]  __put_task_struct+0x4c/0xd4
[147800.420485]  put_task_struct+0x44/0x78
[147800.420493]  rt_mutex_adjust_prio_chain+0x1a0/0x370
[147800.420502]  task_blocks_on_rt_mutex+0x188/0x1b4
[147800.420511]  rt_mutex_slowlock_locked+0xb0/0x170
[147800.420519]  rt_mutex_slowlock+0x7c/0xd4
[147800.420526]  __rt_mutex_lock_state+0x3c/0x50
[147800.420534]  _mutex_lock_blk_flush+0x5c/0x6c
[147800.420543]  _mutex_lock+0x14/0x20
[147800.420550]  ion_alloc+0x5f8/0x62c
[147800.420561]  ion_ioctl+0x18c/0x694
[147800.420569]  vfs_ioctl+0x28/0x48
[147800.420578]  __arm64_sys_ioctl+0x78/0xcc
[147800.420586]  el0_svc_common.constprop.0+0x148/0x1e8
[147800.420593]  do_el0_svc+0x50/0x80
[147800.420599]  el0_svc+0x14/0x20
[147800.420606]  el0_sync_handler+0xcc/0x154
[147800.420612]  el0_sync+0x180/0x1c0

A\B\C is task.
L1\L2 is lock.
adj: means rt_mutex_adjust_prio_chain()

key process:
    1. A owns L1,and blocked on L2.
    2. B blocked on L1,B execute mutex_lock or spinlock will adjust A's
       priority by execute adj func.
    3. before execute adj,it will unlock L1->wait_lock
    4. If at this point,C release L2.A owns L2,and finish the whole thread
       work very quickly,Finally the B thread exited.In this process,
       unlock L1 will assign 0x1 to L1->owner,what orign value is A
       task_struct.But in adj func,the parameter of task is still A's
       pointer.becaues of A already exited,put_task_struct will release
       task A.
    5. If local page.lock is locked,it will cause a BUG_ON,becaues one
       task A be blocked on two lock.

    ====A================B===============C================
        |                |               |->owns L2
        |->owns L1       |               |
        |->block on L2   |->lock L1.rawspin_wait_lock
        |                |->block on L1  |
        |                |               |->unlock L2
        |                |->get A task_truct
        |->owns L2       |->unlocked L1.rawspin_wait_lock
        |->lock L1.rawspin_wait_lock
        |->unlock L1     |               |
        |                |               |
        |->unlock L1.rawspin_wait_lock
        |->release L2    |               |
        |->A exit & not free
        |                |->put A task_struct
        |                |        ↓
                                 [5]

Signed-off-by: yuxin.ye <yeyuxin0925@gmail.com>
---
 kernel/locking/rtmutex.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 7779ee8ab..52e9cebc3 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1175,13 +1175,9 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
 	 */
 	get_task_struct(owner);
 
-	raw_spin_unlock_irq(&lock->wait_lock);
-
 	res = rt_mutex_adjust_prio_chain(owner, chwalk, lock,
 					 next_lock, waiter, task);
 
-	raw_spin_lock_irq(&lock->wait_lock);
-
 	return res;
 }
 
@@ -1461,12 +1457,8 @@ static void __sched remove_waiter(struct rt_mutex_base *lock,
 	/* gets dropped in rt_mutex_adjust_prio_chain()! */
 	get_task_struct(owner);
 
-	raw_spin_unlock_irq(&lock->wait_lock);
-
 	rt_mutex_adjust_prio_chain(owner, RT_MUTEX_MIN_CHAINWALK, lock,
 				   next_lock, NULL, current);
-
-	raw_spin_lock_irq(&lock->wait_lock);
 }
 
 /**
-- 
2.17.1

