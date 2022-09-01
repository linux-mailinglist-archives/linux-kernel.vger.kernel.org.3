Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5B05A9F3F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 20:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbiIASlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 14:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbiIASlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 14:41:35 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344254CA0D;
        Thu,  1 Sep 2022 11:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=oglcFn0hdV0/yo3QU8sIKV1dX0oJGho0Ceqj0HLZFCY=; b=AqpE/FoApdYXKWOuodgJlmFIKq
        nV+tnq5dClOMHtApTJ8DTyJT6HUac9y6xBxAJYQ4IGB584zHO49pNl3XV63sOMuxUw4qZ6HffUZsP
        jAS9YE8bOXkWVesK6P4xQnNiQD9K2VdoBgV+980W5AWwY8ywRXJWRFbUMuUeOBgoEy3lP9kcBjFEv
        dNqg93blALGUZoXCwVvc5g4xWw3PKHyMZVU33kNxESQE3HcG4maxzcphH64p/PfeMzd9jLTND6Xbv
        brKStr4RbNFBdRmOQ/ZCCOpLEs1fx4L07Q2CjNMhQj0JRA3rAvRpSlqJIlGlzjkGbo5fGET5NXbdK
        iASsmucg==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1oTp82-00DwDw-N3; Thu, 01 Sep 2022 12:41:28 -0600
Message-ID: <04128618-962f-fd4e-64a9-09ecf7f83776@deltatee.com>
Date:   Thu, 1 Sep 2022 12:41:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-CA
To:     Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
References: <20220829131502.165356-1-yukuai1@huaweicloud.com>
 <20220829131502.165356-3-yukuai1@huaweicloud.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20220829131502.165356-3-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: yukuai1@huaweicloud.com, song@kernel.org, linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH -next 2/3] md/raid10: convert resync_lock to use seqlock
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022-08-29 07:15, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Currently, wait_barrier() will hold 'resync_lock' to read 'conf->barrier',
> and io can't be dispatched until 'barrier' is dropped.
> 
> Since holding the 'barrier' is not common, convert 'resync_lock' to use
> seqlock so that holding lock can be avoided in fast path.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

I've found some lockdep issues starting with this patch in md-next while
running mdadm tests (specifically 00raid10 when run about 10 times in a
row).

I've seen a couple different lock dep errors. The first seems to be
reproducible on this patch, then it possibly changes to the second on
subsequent patches. Not sure exactly.

I haven't dug into it too deeply, but hopefully it can be fixed easily.

Logan

--


    ================================
    WARNING: inconsistent lock state
    6.0.0-rc2-eid-vmlocalyes-dbg-00023-gfd68041d2fd2 #2604 Not tainted
    --------------------------------
    inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
    fsck.ext3/1695 [HC0[0]:SC0[0]:HE0:SE1] takes:
    ffff8881049b0120 (&____s->seqcount#10){+.?.}-{0:0}, at:
raid10_read_request+0x21f/0x760
		(raid10.c:1134)

    {IN-SOFTIRQ-W} state was registered at:
      lock_acquire+0x183/0x440
      lower_barrier+0x5e/0xd0
      end_sync_request+0x178/0x180
      end_sync_write+0x193/0x380
      bio_endio+0x346/0x3a0
      blk_update_request+0x1eb/0x7c0
      blk_mq_end_request+0x30/0x50
      lo_complete_rq+0xb7/0x100
      blk_complete_reqs+0x77/0x90
      blk_done_softirq+0x38/0x40
      __do_softirq+0x10c/0x650
      run_ksoftirqd+0x48/0x80
      smpboot_thread_fn+0x302/0x400
      kthread+0x18c/0x1c0
      ret_from_fork+0x1f/0x30

    irq event stamp: 8930
    hardirqs last  enabled at (8929): [<ffffffff96df8351>]
_raw_spin_unlock_irqrestore+0x31/0x60
    hardirqs last disabled at (8930): [<ffffffff96df7fc5>]
_raw_spin_lock_irq+0x75/0x90
    softirqs last  enabled at (6768): [<ffffffff9554970e>]
__irq_exit_rcu+0xfe/0x150
    softirqs last disabled at (6757): [<ffffffff9554970e>]
__irq_exit_rcu+0xfe/0x150

    other info that might help us debug this:
     Possible unsafe locking scenario:

           CPU0
           ----
      lock(&____s->seqcount#10);
      <Interrupt>
        lock(&____s->seqcount#10);

     *** DEADLOCK ***

    2 locks held by fsck.ext3/1695:
     #0: ffff8881007d0930 (mapping.invalidate_lock#2){++++}-{3:3}, at:
page_cache_ra_unbounded+0xaf/0x250
     #1: ffff8881049b0120 (&____s->seqcount#10){+.?.}-{0:0}, at:
raid10_read_request+0x21f/0x760

    stack backtrace:
    CPU: 0 PID: 1695 Comm: fsck.ext3 Not tainted
6.0.0-rc2-eid-vmlocalyes-dbg-00023-gfd68041d2fd2 #2604
    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2
04/01/2014
    Call Trace:
     <TASK>
     dump_stack_lvl+0x5a/0x74
     dump_stack+0x10/0x12
     print_usage_bug.part.0+0x233/0x246
     mark_lock.part.0.cold+0x73/0x14f
     mark_held_locks+0x71/0xa0
     lockdep_hardirqs_on_prepare+0x158/0x230
     trace_hardirqs_on+0x34/0x100
     _raw_spin_unlock_irq+0x28/0x60
     wait_barrier+0x4a6/0x720
         raid10.c:1004
     raid10_read_request+0x21f/0x760
     raid10_make_request+0x2d6/0x2160
     md_handle_request+0x3f3/0x5b0
     md_submit_bio+0xd9/0x120
     __submit_bio+0x9d/0x100
     submit_bio_noacct_nocheck+0x1fd/0x470
     submit_bio_noacct+0x4c2/0xbb0
     submit_bio+0x3f/0xf0
     mpage_readahead+0x323/0x3b0
     blkdev_readahead+0x15/0x20
     read_pages+0x136/0x7a0
     page_cache_ra_unbounded+0x18d/0x250
     page_cache_ra_order+0x2c9/0x400
     ondemand_readahead+0x320/0x730
     page_cache_sync_ra+0xa6/0xb0
     filemap_get_pages+0x1eb/0xc00
     filemap_read+0x1f1/0x770
     blkdev_read_iter+0x164/0x310
     vfs_read+0x467/0x5a0
     __x64_sys_pread64+0x122/0x160
     do_syscall_64+0x35/0x80
     entry_SYSCALL_64_after_hwframe+0x46/0xb0

--

    ======================================================
    WARNING: possible circular locking dependency detected
    6.0.0-rc2-eid-vmlocalyes-dbg-00027-gcd6aa5181bbb #2600 Not tainted
    ------------------------------------------------------
    systemd-udevd/292 is trying to acquire lock:
    ffff88817b644170 (&(&conf->resync_lock)->lock){....}-{2:2}, at:
wait_barrier+0x4fe/0x770

    but task is already holding lock:
    ffff88817b644120 (&____s->seqcount#11){+.+.}-{0:0}, at:
raid10_read_request+0x21f/0x760
			raid10.c:1140  wait_barrier()
			raid10.c:1204  regular_request_wait()



    which lock already depends on the new lock.


    the existing dependency chain (in reverse order) is:

    -> #1 (&____s->seqcount#11){+.+.}-{0:0}:
           raise_barrier+0xe0/0x300
		raid10.c:940 write_seqlock_irq()
           raid10_sync_request+0x629/0x4750
		raid10.c:3689 raise_barrire()
           md_do_sync.cold+0x8ec/0x1491
           md_thread+0x19d/0x2d0
           kthread+0x18c/0x1c0
           ret_from_fork+0x1f/0x30

    -> #0 (&(&conf->resync_lock)->lock){....}-{2:2}:
           __lock_acquire+0x1cb4/0x3170
           lock_acquire+0x183/0x440
           _raw_spin_lock_irq+0x4d/0x90
           wait_barrier+0x4fe/0x770
           raid10_read_request+0x21f/0x760
		raid10.c:1140  wait_barrier()
		raid10.c:1204  regular_request_wait()
           raid10_make_request+0x2d6/0x2190
           md_handle_request+0x3f3/0x5b0
           md_submit_bio+0xd9/0x120
           __submit_bio+0x9d/0x100
           submit_bio_noacct_nocheck+0x1fd/0x470
           submit_bio_noacct+0x4c2/0xbb0
           submit_bio+0x3f/0xf0
           submit_bh_wbc+0x270/0x2a0
           block_read_full_folio+0x37c/0x580
           blkdev_read_folio+0x18/0x20
           filemap_read_folio+0x3f/0x110
           do_read_cache_folio+0x13b/0x2c0
           read_cache_folio+0x42/0x50
           read_part_sector+0x74/0x1c0
           read_lba+0x176/0x2a0
           efi_partition+0x1ce/0xdd0
           bdev_disk_changed+0x2e7/0x6a0
           blkdev_get_whole+0xd2/0x140
           blkdev_get_by_dev.part.0+0x37f/0x570
           blkdev_get_by_dev+0x51/0x60
           disk_scan_partitions+0xad/0xf0
           blkdev_common_ioctl+0x3f3/0xdf0
           blkdev_ioctl+0x1e1/0x450
           __x64_sys_ioctl+0xc0/0x100
           do_syscall_64+0x35/0x80
           entry_SYSCALL_64_after_hwframe+0x46/0xb0

    other info that might help us debug this:

     Possible unsafe locking scenario:

           CPU0                    CPU1
           ----                    ----
      lock(&____s->seqcount#11);
                                   lock(&(&conf->resync_lock)->lock);
                                   lock(&____s->seqcount#11);
      lock(&(&conf->resync_lock)->lock);

     *** DEADLOCK ***

    2 locks held by systemd-udevd/292:
     #0: ffff88817a532528 (&disk->open_mutex){+.+.}-{3:3}, at:
blkdev_get_by_dev.part.0+0x180/0x570
     #1: ffff88817b644120 (&____s->seqcount#11){+.+.}-{0:0}, at:
raid10_read_request+0x21f/0x760

    stack backtrace:
    CPU: 3 PID: 292 Comm: systemd-udevd Not tainted
6.0.0-rc2-eid-vmlocalyes-dbg-00027-gcd6aa5181bbb #2600
    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2
04/01/2014
    Call Trace:
     <TASK>
     dump_stack_lvl+0x5a/0x74
     dump_stack+0x10/0x12
     print_circular_bug.cold+0x146/0x14b
     check_noncircular+0x1ff/0x250
     __lock_acquire+0x1cb4/0x3170
     lock_acquire+0x183/0x440
     _raw_spin_lock_irq+0x4d/0x90
     wait_barrier+0x4fe/0x770
     raid10_read_request+0x21f/0x760
     raid10_make_request+0x2d6/0x2190
     md_handle_request+0x3f3/0x5b0
     md_submit_bio+0xd9/0x120
     __submit_bio+0x9d/0x100
     submit_bio_noacct_nocheck+0x1fd/0x470
     submit_bio_noacct+0x4c2/0xbb0
     submit_bio+0x3f/0xf0
     submit_bh_wbc+0x270/0x2a0
     block_read_full_folio+0x37c/0x580
     blkdev_read_folio+0x18/0x20
     filemap_read_folio+0x3f/0x110
     do_read_cache_folio+0x13b/0x2c0
     read_cache_folio+0x42/0x50
     read_part_sector+0x74/0x1c0
     read_lba+0x176/0x2a0
     efi_partition+0x1ce/0xdd0
     bdev_disk_changed+0x2e7/0x6a0
     blkdev_get_whole+0xd2/0x140
     blkdev_get_by_dev.part.0+0x37f/0x570
     blkdev_get_by_dev+0x51/0x60
     disk_scan_partitions+0xad/0xf0
     blkdev_common_ioctl+0x3f3/0xdf0
     blkdev_ioctl+0x1e1/0x450
     __x64_sys_ioctl+0xc0/0x100
     do_syscall_64+0x35/0x80
