Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A625AA9B2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbiIBIPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235813AbiIBIOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:14:37 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A257EBD4F6;
        Fri,  2 Sep 2022 01:14:29 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MJrHw3CyKzKMx1;
        Fri,  2 Sep 2022 16:12:44 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgA3inNhuxFj2EgMAQ--.19S3;
        Fri, 02 Sep 2022 16:14:27 +0800 (CST)
Subject: Re: [PATCH -next 2/3] md/raid10: convert resync_lock to use seqlock
To:     Yu Kuai <yukuai1@huaweicloud.com>,
        Logan Gunthorpe <logang@deltatee.com>, song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20220829131502.165356-1-yukuai1@huaweicloud.com>
 <20220829131502.165356-3-yukuai1@huaweicloud.com>
 <04128618-962f-fd4e-64a9-09ecf7f83776@deltatee.com>
 <b87d0e03-ea92-4e79-f304-7d4c1cbf3fbf@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <3d07a8fd-3b5e-dc68-4c32-6c0dcd0c1264@huaweicloud.com>
Date:   Fri, 2 Sep 2022 16:14:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b87d0e03-ea92-4e79-f304-7d4c1cbf3fbf@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgA3inNhuxFj2EgMAQ--.19S3
X-Coremail-Antispam: 1UD129KBjvAXoWfGF47WryfGr43Ary5Ww17ZFb_yoW8WrW3Jo
        WY9w13Ar15XF4UKr18Jr1UJF15Jr1kGrnrtr1UGr13Ar1xJr15J34xJryUG3yUJrWrGr1U
        Ar17Jr1rZFyUArn7n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYw7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20xva
        j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
        x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
        Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
        xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CE
        bIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
        AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
        rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
        v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHU
        DUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Logan

在 2022/09/02 9:21, Yu Kuai 写道:
> Hi,
> 
> 在 2022/09/02 2:41, Logan Gunthorpe 写道:
>> Hi,
>>
>> On 2022-08-29 07:15, Yu Kuai wrote:
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> Currently, wait_barrier() will hold 'resync_lock' to read 
>>> 'conf->barrier',
>>> and io can't be dispatched until 'barrier' is dropped.
>>>
>>> Since holding the 'barrier' is not common, convert 'resync_lock' to use
>>> seqlock so that holding lock can be avoided in fast path.
>>>
>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>
>> I've found some lockdep issues starting with this patch in md-next while
>> running mdadm tests (specifically 00raid10 when run about 10 times in a
>> row).
>>
>> I've seen a couple different lock dep errors. The first seems to be
>> reproducible on this patch, then it possibly changes to the second on
>> subsequent patches. Not sure exactly.
>>
> 
> Thanks for the test,
> 
> I think this is false positive because of the special usage here,
> 
> for example, in raise_barrier():
> 
> write_seqlock_irq
>   spin_lock_irq();
>    lock_acquire
>   do_write_seqcount_begin
>    seqcount_acquire
> 
>   wait_event_lock_irq_cmd
>    spin_unlock_irq -> lock is released while seqcount is still hold
>               if other context hold the lock again, lockdep
>               will trigger warning.
>    ...
>    spin_lock_irq
> 
> write_sequnlock_irq
> 
> Functionality should be ok, I'll try to find a way to prevent such
> warning.

Can you try the following patch? I'm running mdadm tests myself and I
didn't see any problems yet.

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 2f7c8bef6dc2..317bd862f40a 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -940,16 +940,16 @@ static void raise_barrier(struct r10conf *conf, 
int force)
         BUG_ON(force && !conf->barrier);

         /* Wait until no block IO is waiting (unless 'force') */
-       wait_event_lock_irq(conf->wait_barrier, force || !conf->nr_waiting,
-                           conf->resync_lock.lock);
+       wait_event_seqlock_irq(conf->wait_barrier, force || 
!conf->nr_waiting,
+                              conf->resync_lock);

         /* block any new IO from starting */
         WRITE_ONCE(conf->barrier, conf->barrier + 1);

         /* Now wait for all pending IO to complete */
-       wait_event_lock_irq(conf->wait_barrier,
-                           !atomic_read(&conf->nr_pending) && 
conf->barrier < RESYNC_DEPTH,
-                           conf->resync_lock.lock);
+       wait_event_seqlock_irq(conf->wait_barrier,
+                              !atomic_read(&conf->nr_pending) &&
+                              conf->barrier < RESYNC_DEPTH, 
conf->resync_lock);

         write_sequnlock_irq(&conf->resync_lock);
  }
@@ -1007,7 +1007,7 @@ static bool wait_barrier(struct r10conf *conf, 
bool nowait)
                         ret = false;
                 } else {
                         raid10_log(conf->mddev, "wait barrier");
-                       wait_event_lock_irq(conf->wait_barrier,
+                       wait_event_seqlock_irq(conf->wait_barrier,
                                             !conf->barrier ||
 
(atomic_read(&conf->nr_pending) &&
                                              bio_list &&
@@ -1020,7 +1020,7 @@ static bool wait_barrier(struct r10conf *conf, 
bool nowait)
                                               test_bit(MD_RECOVERY_RUNNING,
 
&conf->mddev->recovery) &&
                                               conf->nr_queued > 0),
-                                           conf->resync_lock.lock);
+                                           conf->resync_lock);
                 }
                 conf->nr_waiting--;
                 if (!conf->nr_waiting)
@@ -1058,10 +1058,9 @@ static void freeze_array(struct r10conf *conf, 
int extra)
         conf->array_freeze_pending++;
         WRITE_ONCE(conf->barrier, conf->barrier + 1);
         conf->nr_waiting++;
-       wait_event_lock_irq_cmd(conf->wait_barrier,
+       wait_event_seqlock_irq_cmd(conf->wait_barrier,
                                 atomic_read(&conf->nr_pending) == 
conf->nr_queued+extra,
-                               conf->resync_lock.lock,
-                               flush_pending_writes(conf));
+                               conf->resync_lock, 
flush_pending_writes(conf));

         conf->array_freeze_pending--;
         write_sequnlock_irq(&conf->resync_lock);
diff --git a/include/linux/wait.h b/include/linux/wait.h
index 58cfbf81447c..97d6b378e40c 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -977,6 +977,13 @@ extern int do_wait_intr_irq(wait_queue_head_t *, 
wait_queue_entry_t *);
                             schedule(); 
         \
                             spin_lock_irq(&lock))

+#define __wait_event_seqlock_irq(wq_head, condition, lock, cmd) 
                \
+       (void)___wait_event(wq_head, condition, TASK_UNINTERRUPTIBLE, 0, 
0,     \
+                           write_sequnlock_irq(&lock); 
        \
+                           cmd; 
        \
+                           schedule(); 
        \
+                           write_seqlock_irq(&lock))
+
  /**
   * wait_event_lock_irq_cmd - sleep until a condition gets true. The
   *                          condition is checked under the lock. This
@@ -1007,6 +1014,13 @@ do { 
                                \
         __wait_event_lock_irq(wq_head, condition, lock, cmd); 
         \
  } while (0)

+#define wait_event_seqlock_irq_cmd(wq_head, condition, lock, cmd) 
        \
+do { 
        \
+       if (condition) 
        \
+               break; 
        \
+       __wait_event_seqlock_irq(wq_head, condition, lock, cmd); 
        \
+} while (0)
+
  /**
   * wait_event_lock_irq - sleep until a condition gets true. The
   *                      condition is checked under the lock. This
@@ -1034,6 +1048,12 @@ do { 
                                \
         __wait_event_lock_irq(wq_head, condition, lock, ); 
         \
  } while (0)

+#define wait_event_seqlock_irq(wq_head, condition, lock) 
        \
+do { 
        \
+       if (condition) 
        \
+               break; 
        \
+       __wait_event_seqlock_irq(wq_head, condition, lock, ); 
        \
+} while (0)

  #define __wait_event_interruptible_lock_irq(wq_head, condition, lock, 
cmd)     \
         ___wait_event(wq_head, condition, TASK_INTERRUPTIBLE, 0, 0, 
         \

> 
> Thanks,
> Kuai
>> I haven't dug into it too deeply, but hopefully it can be fixed easily.
>>
>> Logan
>>
>> -- 
>>
>>
>>      ================================
>>      WARNING: inconsistent lock state
>>      6.0.0-rc2-eid-vmlocalyes-dbg-00023-gfd68041d2fd2 #2604 Not tainted
>>      --------------------------------
>>      inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
>>      fsck.ext3/1695 [HC0[0]:SC0[0]:HE0:SE1] takes:
>>      ffff8881049b0120 (&____s->seqcount#10){+.?.}-{0:0}, at:
>> raid10_read_request+0x21f/0x760
>>         (raid10.c:1134)
>>
>>      {IN-SOFTIRQ-W} state was registered at:
>>        lock_acquire+0x183/0x440
>>        lower_barrier+0x5e/0xd0
>>        end_sync_request+0x178/0x180
>>        end_sync_write+0x193/0x380
>>        bio_endio+0x346/0x3a0
>>        blk_update_request+0x1eb/0x7c0
>>        blk_mq_end_request+0x30/0x50
>>        lo_complete_rq+0xb7/0x100
>>        blk_complete_reqs+0x77/0x90
>>        blk_done_softirq+0x38/0x40
>>        __do_softirq+0x10c/0x650
>>        run_ksoftirqd+0x48/0x80
>>        smpboot_thread_fn+0x302/0x400
>>        kthread+0x18c/0x1c0
>>        ret_from_fork+0x1f/0x30
>>
>>      irq event stamp: 8930
>>      hardirqs last  enabled at (8929): [<ffffffff96df8351>]
>> _raw_spin_unlock_irqrestore+0x31/0x60
>>      hardirqs last disabled at (8930): [<ffffffff96df7fc5>]
>> _raw_spin_lock_irq+0x75/0x90
>>      softirqs last  enabled at (6768): [<ffffffff9554970e>]
>> __irq_exit_rcu+0xfe/0x150
>>      softirqs last disabled at (6757): [<ffffffff9554970e>]
>> __irq_exit_rcu+0xfe/0x150
>>
>>      other info that might help us debug this:
>>       Possible unsafe locking scenario:
>>
>>             CPU0
>>             ----
>>        lock(&____s->seqcount#10);
>>        <Interrupt>
>>          lock(&____s->seqcount#10);
>>
>>       *** DEADLOCK ***
>>
>>      2 locks held by fsck.ext3/1695:
>>       #0: ffff8881007d0930 (mapping.invalidate_lock#2){++++}-{3:3}, at:
>> page_cache_ra_unbounded+0xaf/0x250
>>       #1: ffff8881049b0120 (&____s->seqcount#10){+.?.}-{0:0}, at:
>> raid10_read_request+0x21f/0x760
>>
>>      stack backtrace:
>>      CPU: 0 PID: 1695 Comm: fsck.ext3 Not tainted
>> 6.0.0-rc2-eid-vmlocalyes-dbg-00023-gfd68041d2fd2 #2604
>>      Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2
>> 04/01/2014
>>      Call Trace:
>>       <TASK>
>>       dump_stack_lvl+0x5a/0x74
>>       dump_stack+0x10/0x12
>>       print_usage_bug.part.0+0x233/0x246
>>       mark_lock.part.0.cold+0x73/0x14f
>>       mark_held_locks+0x71/0xa0
>>       lockdep_hardirqs_on_prepare+0x158/0x230
>>       trace_hardirqs_on+0x34/0x100
>>       _raw_spin_unlock_irq+0x28/0x60
>>       wait_barrier+0x4a6/0x720
>>           raid10.c:1004
>>       raid10_read_request+0x21f/0x760
>>       raid10_make_request+0x2d6/0x2160
>>       md_handle_request+0x3f3/0x5b0
>>       md_submit_bio+0xd9/0x120
>>       __submit_bio+0x9d/0x100
>>       submit_bio_noacct_nocheck+0x1fd/0x470
>>       submit_bio_noacct+0x4c2/0xbb0
>>       submit_bio+0x3f/0xf0
>>       mpage_readahead+0x323/0x3b0
>>       blkdev_readahead+0x15/0x20
>>       read_pages+0x136/0x7a0
>>       page_cache_ra_unbounded+0x18d/0x250
>>       page_cache_ra_order+0x2c9/0x400
>>       ondemand_readahead+0x320/0x730
>>       page_cache_sync_ra+0xa6/0xb0
>>       filemap_get_pages+0x1eb/0xc00
>>       filemap_read+0x1f1/0x770
>>       blkdev_read_iter+0x164/0x310
>>       vfs_read+0x467/0x5a0
>>       __x64_sys_pread64+0x122/0x160
>>       do_syscall_64+0x35/0x80
>>       entry_SYSCALL_64_after_hwframe+0x46/0xb0
>>
>> -- 
>>
>>      ======================================================
>>      WARNING: possible circular locking dependency detected
>>      6.0.0-rc2-eid-vmlocalyes-dbg-00027-gcd6aa5181bbb #2600 Not tainted
>>      ------------------------------------------------------
>>      systemd-udevd/292 is trying to acquire lock:
>>      ffff88817b644170 (&(&conf->resync_lock)->lock){....}-{2:2}, at:
>> wait_barrier+0x4fe/0x770
>>
>>      but task is already holding lock:
>>      ffff88817b644120 (&____s->seqcount#11){+.+.}-{0:0}, at:
>> raid10_read_request+0x21f/0x760
>>             raid10.c:1140  wait_barrier()
>>             raid10.c:1204  regular_request_wait()
>>
>>
>>
>>      which lock already depends on the new lock.
>>
>>
>>      the existing dependency chain (in reverse order) is:
>>
>>      -> #1 (&____s->seqcount#11){+.+.}-{0:0}:
>>             raise_barrier+0xe0/0x300
>>         raid10.c:940 write_seqlock_irq()
>>             raid10_sync_request+0x629/0x4750
>>         raid10.c:3689 raise_barrire()
>>             md_do_sync.cold+0x8ec/0x1491
>>             md_thread+0x19d/0x2d0
>>             kthread+0x18c/0x1c0
>>             ret_from_fork+0x1f/0x30
>>
>>      -> #0 (&(&conf->resync_lock)->lock){....}-{2:2}:
>>             __lock_acquire+0x1cb4/0x3170
>>             lock_acquire+0x183/0x440
>>             _raw_spin_lock_irq+0x4d/0x90
>>             wait_barrier+0x4fe/0x770
>>             raid10_read_request+0x21f/0x760
>>         raid10.c:1140  wait_barrier()
>>         raid10.c:1204  regular_request_wait()
>>             raid10_make_request+0x2d6/0x2190
>>             md_handle_request+0x3f3/0x5b0
>>             md_submit_bio+0xd9/0x120
>>             __submit_bio+0x9d/0x100
>>             submit_bio_noacct_nocheck+0x1fd/0x470
>>             submit_bio_noacct+0x4c2/0xbb0
>>             submit_bio+0x3f/0xf0
>>             submit_bh_wbc+0x270/0x2a0
>>             block_read_full_folio+0x37c/0x580
>>             blkdev_read_folio+0x18/0x20
>>             filemap_read_folio+0x3f/0x110
>>             do_read_cache_folio+0x13b/0x2c0
>>             read_cache_folio+0x42/0x50
>>             read_part_sector+0x74/0x1c0
>>             read_lba+0x176/0x2a0
>>             efi_partition+0x1ce/0xdd0
>>             bdev_disk_changed+0x2e7/0x6a0
>>             blkdev_get_whole+0xd2/0x140
>>             blkdev_get_by_dev.part.0+0x37f/0x570
>>             blkdev_get_by_dev+0x51/0x60
>>             disk_scan_partitions+0xad/0xf0
>>             blkdev_common_ioctl+0x3f3/0xdf0
>>             blkdev_ioctl+0x1e1/0x450
>>             __x64_sys_ioctl+0xc0/0x100
>>             do_syscall_64+0x35/0x80
>>             entry_SYSCALL_64_after_hwframe+0x46/0xb0
>>
>>      other info that might help us debug this:
>>
>>       Possible unsafe locking scenario:
>>
>>             CPU0                    CPU1
>>             ----                    ----
>>        lock(&____s->seqcount#11);
>>                                     lock(&(&conf->resync_lock)->lock);
>>                                     lock(&____s->seqcount#11);
>>        lock(&(&conf->resync_lock)->lock);
>>
>>       *** DEADLOCK ***
>>
>>      2 locks held by systemd-udevd/292:
>>       #0: ffff88817a532528 (&disk->open_mutex){+.+.}-{3:3}, at:
>> blkdev_get_by_dev.part.0+0x180/0x570
>>       #1: ffff88817b644120 (&____s->seqcount#11){+.+.}-{0:0}, at:
>> raid10_read_request+0x21f/0x760
>>
>>      stack backtrace:
>>      CPU: 3 PID: 292 Comm: systemd-udevd Not tainted
>> 6.0.0-rc2-eid-vmlocalyes-dbg-00027-gcd6aa5181bbb #2600
>>      Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2
>> 04/01/2014
>>      Call Trace:
>>       <TASK>
>>       dump_stack_lvl+0x5a/0x74
>>       dump_stack+0x10/0x12
>>       print_circular_bug.cold+0x146/0x14b
>>       check_noncircular+0x1ff/0x250
>>       __lock_acquire+0x1cb4/0x3170
>>       lock_acquire+0x183/0x440
>>       _raw_spin_lock_irq+0x4d/0x90
>>       wait_barrier+0x4fe/0x770
>>       raid10_read_request+0x21f/0x760
>>       raid10_make_request+0x2d6/0x2190
>>       md_handle_request+0x3f3/0x5b0
>>       md_submit_bio+0xd9/0x120
>>       __submit_bio+0x9d/0x100
>>       submit_bio_noacct_nocheck+0x1fd/0x470
>>       submit_bio_noacct+0x4c2/0xbb0
>>       submit_bio+0x3f/0xf0
>>       submit_bh_wbc+0x270/0x2a0
>>       block_read_full_folio+0x37c/0x580
>>       blkdev_read_folio+0x18/0x20
>>       filemap_read_folio+0x3f/0x110
>>       do_read_cache_folio+0x13b/0x2c0
>>       read_cache_folio+0x42/0x50
>>       read_part_sector+0x74/0x1c0
>>       read_lba+0x176/0x2a0
>>       efi_partition+0x1ce/0xdd0
>>       bdev_disk_changed+0x2e7/0x6a0
>>       blkdev_get_whole+0xd2/0x140
>>       blkdev_get_by_dev.part.0+0x37f/0x570
>>       blkdev_get_by_dev+0x51/0x60
>>       disk_scan_partitions+0xad/0xf0
>>       blkdev_common_ioctl+0x3f3/0xdf0
>>       blkdev_ioctl+0x1e1/0x450
>>       __x64_sys_ioctl+0xc0/0x100
>>       do_syscall_64+0x35/0x80
>> .
>>
> 
> .
> 

