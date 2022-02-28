Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854AD4C62E5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 07:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbiB1G2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 01:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbiB1G2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 01:28:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D870B2E696;
        Sun, 27 Feb 2022 22:28:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 772AD60F9F;
        Mon, 28 Feb 2022 06:28:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66496C340E7;
        Mon, 28 Feb 2022 06:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646029680;
        bh=WB20vFYaLU6bYQhQkOLvqs5MfMhsF3mVGRRLJYFvQ/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xzr0cDGnpkEq0C1zubOzlvoRgdbVY8qcGUyoUaaEUriG/iZxbD2QVaJj+avwqKXBJ
         75UKSNRrmGDnCfDeMyIAA2E7IzBUcok4ur9ebwbAHm6Em8WcCcp4ukf+UuksqyUdVH
         /vlz+4JMejN6Cpd553yJbklZGWUz92z2YejTsBh4=
Date:   Mon, 28 Feb 2022 07:27:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, rostedt@goodmis.org, mingo@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH v2] blktrace: fix use after free for struct blk_trace
Message-ID: <YhxraSEYgywOaxQZ@kroah.com>
References: <20220228034354.4047385-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228034354.4047385-1-yukuai3@huawei.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 11:43:54AM +0800, Yu Kuai wrote:
> When tracing the whole disk, 'dropped' and 'msg' will be created
> under 'q->debugfs_dir' and 'bt->dir' is NULL, thus blk_trace_free()
> won't remove those files. What's worse, the following UAF can be
> triggered because of accessing stale 'dropped' and 'msg':
> 
> ==================================================================
> BUG: KASAN: use-after-free in blk_dropped_read+0x89/0x100
> Read of size 4 at addr ffff88816912f3d8 by task blktrace/1188
> 
> CPU: 27 PID: 1188 Comm: blktrace Not tainted 5.17.0-rc4-next-20220217+ #469
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20190727_073836-4
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x34/0x44
>  print_address_description.constprop.0.cold+0xab/0x381
>  ? blk_dropped_read+0x89/0x100
>  ? blk_dropped_read+0x89/0x100
>  kasan_report.cold+0x83/0xdf
>  ? blk_dropped_read+0x89/0x100
>  kasan_check_range+0x140/0x1b0
>  blk_dropped_read+0x89/0x100
>  ? blk_create_buf_file_callback+0x20/0x20
>  ? kmem_cache_free+0xa1/0x500
>  ? do_sys_openat2+0x258/0x460
>  full_proxy_read+0x8f/0xc0
>  vfs_read+0xc6/0x260
>  ksys_read+0xb9/0x150
>  ? vfs_write+0x3d0/0x3d0
>  ? fpregs_assert_state_consistent+0x55/0x60
>  ? exit_to_user_mode_prepare+0x39/0x1e0
>  do_syscall_64+0x35/0x80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7fbc080d92fd
> Code: ce 20 00 00 75 10 b8 00 00 00 00 0f 05 48 3d 01 f0 ff ff 73 31 c3 48 83 1
> RSP: 002b:00007fbb95ff9cb0 EFLAGS: 00000293 ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 00007fbb95ff9dc0 RCX: 00007fbc080d92fd
> RDX: 0000000000000100 RSI: 00007fbb95ff9cc0 RDI: 0000000000000045
> RBP: 0000000000000045 R08: 0000000000406299 R09: 00000000fffffffd
> R10: 000000000153afa0 R11: 0000000000000293 R12: 00007fbb780008c0
> R13: 00007fbb78000938 R14: 0000000000608b30 R15: 00007fbb780029c8
>  </TASK>
> 
> Allocated by task 1050:
>  kasan_save_stack+0x1e/0x40
>  __kasan_kmalloc+0x81/0xa0
>  do_blk_trace_setup+0xcb/0x410
>  __blk_trace_setup+0xac/0x130
>  blk_trace_ioctl+0xe9/0x1c0
>  blkdev_ioctl+0xf1/0x390
>  __x64_sys_ioctl+0xa5/0xe0
>  do_syscall_64+0x35/0x80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Freed by task 1050:
>  kasan_save_stack+0x1e/0x40
>  kasan_set_track+0x21/0x30
>  kasan_set_free_info+0x20/0x30
>  __kasan_slab_free+0x103/0x180
>  kfree+0x9a/0x4c0
>  __blk_trace_remove+0x53/0x70
>  blk_trace_ioctl+0x199/0x1c0
>  blkdev_common_ioctl+0x5e9/0xb30
>  blkdev_ioctl+0x1a5/0x390
>  __x64_sys_ioctl+0xa5/0xe0
>  do_syscall_64+0x35/0x80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> The buggy address belongs to the object at ffff88816912f380
>  which belongs to the cache kmalloc-96 of size 96
> The buggy address is located 88 bytes inside of
>  96-byte region [ffff88816912f380, ffff88816912f3e0)
> The buggy address belongs to the page:
> page:000000009a1b4e7c refcount:1 mapcount:0 mapping:0000000000000000 index:0x0f
> flags: 0x17ffffc0000200(slab|node=0|zone=2|lastcpupid=0x1fffff)
> raw: 0017ffffc0000200 ffffea00044f1100 dead000000000002 ffff88810004c780
> raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff88816912f280: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>  ffff88816912f300: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> >ffff88816912f380: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>                                                     ^
>  ffff88816912f400: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>  ffff88816912f480: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> ==================================================================
> 
> Fixes: c0ea57608b69 ("blktrace: remove debugfs file dentries from struct blk_trace")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
