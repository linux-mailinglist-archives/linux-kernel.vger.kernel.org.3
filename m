Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC2648EF33
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 18:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243863AbiANRXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 12:23:32 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:58480 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiANRXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 12:23:31 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 719E41F391;
        Fri, 14 Jan 2022 17:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642181010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pTMvDArA1QuQNf/iPgI4b1zDpsnCzjWlg/GccAsAQEM=;
        b=Tw2Op4JbaVvaup0WMmPopOuyZqFM/lrk03gnIX0bk/utvvZGMOK73+Aanl6rAO7TJcSgnf
        EtvXWEM4GPdEvDFr2+Q2D2mAbP+W0je72//m96bP+DmN9DmUyL/JrwqGUJRCryrIJFxbDI
        wblEzPv5YYgtcNW8VGmj6CI8ayNWe54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642181010;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pTMvDArA1QuQNf/iPgI4b1zDpsnCzjWlg/GccAsAQEM=;
        b=boNKyX7a0o9yucVXIRG3gUy+2B8H56h29l7Kz9jl4jU/n+fHn0umzQ7tZhVMEWu0mebzhO
        gkfjNGBBLY4Nq2Aw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5CCD5A3B87;
        Fri, 14 Jan 2022 17:23:30 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E072AA05DB; Fri, 14 Jan 2022 18:23:29 +0100 (CET)
Date:   Fri, 14 Jan 2022 18:23:29 +0100
From:   Jan Kara <jack@suse.cz>
To:     butt3rflyh4ck <butterflyhuangxx@gmail.com>
Cc:     jack@suse.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: A null-ptr-deref bug be triggered when write to an ICB inode
Message-ID: <20220114172329.ygzry5rlz64ua2nr@quack3.lan>
References: <CAFcO6XOHm6wx5f1OCA5DOUhSUpJpzL6i0h+MhQtMagD191q38Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFcO6XOHm6wx5f1OCA5DOUhSUpJpzL6i0h+MhQtMagD191q38Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 13-01-22 18:57:28, butt3rflyh4ck wrote:
> Hi, there is a null pointer dereference bug that would be triggered
> when writing something to an ICB inode, I reproduce in the latest
> kernel.
> 
> First mount a malicious udf image, secondly create a dir named
> "./file0", then create a file named "file1" in the file0 directory.
> Then write something to "./file0/file1", then invoke
> udf_file_write_iter function.
> 
> the udf_file_write_iter code:
> ```
> static ssize_t udf_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
> {
> ssize_t retval;
> struct file *file = iocb->ki_filp;
> struct inode *inode = file_inode(file);
> struct udf_inode_info *iinfo = UDF_I(inode);
> int err;
> 
> inode_lock(inode);
> 
> retval = generic_write_checks(iocb, from);
> if (retval <= 0)
> goto out;
> 
> down_write(&iinfo->i_data_sem);
> if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {   ///[1 ]
> loff_t end = iocb->ki_pos + iov_iter_count(from);   ///[2] end =
> iocb->ki_pos + i->count = iocb->ki_pos + user_write_size
> 
> if (inode->i_sb->s_blocksize <
> (udf_file_entry_alloc_offset(inode) + end)) {  /// [3]
> err = udf_expand_file_adinicb(inode);
> 
> ....
> 
> }
> ```
> [1] if the inode is ICBTAG_FLAG_AD_IN_ICB type, [2] then get a end,
> [3] compare blocksize and end, if blocksize is smaller then invoke
> udf_expand_file_adinicb to modify inode.
> Next, in the process of expanding the block, trigger the bug.
> 
> the crash log:
> ```
> [   82.827914][ T6441] loop0: detected capacity change from 0 to 5656
> [   82.830192][ T6441] UDF-fs: warning (device loop0): udf_load_vrs:
> No anchor found
> [   82.831014][ T6441] UDF-fs: Scanning with blocksize 512 failed
> [   82.833515][ T6441] UDF-fs: INFO Mounting volume 'LinuxUDF',
> timestamp 2020/09/19 18:44 (1000)
> [   82.835323][ T6441] general protection fault, probably for
> non-canonical address 0xdffffc0000000015: 0000 [#1] PREEMPT SMP KASAN
> [   82.836556][ T6441] KASAN: null-ptr-deref in range
> [0x00000000000000a8-0x00000000000000af]
> [   82.837437][ T6441] CPU: 0 PID: 6441 Comm: percpu_counter_ Not
> tainted 5.16.0+ #34
> [   82.838242][ T6441] Hardware name: QEMU Standard PC (i440FX + PIIX,
> 1996), BIOS 1.13.0-1ubuntu1 04/01/2014
> [   82.838885][   T26] audit: type=1800 audit(1642070781.843:2):
> pid=6441 uid=0 auid=0 ses=1 subj==unconfined op=collect_data
> cause=failed(directio) comm="percpu_count0
> [   82.843723][ T6441] RIP: 0010:percpu_counter_add_batch+0x3e/0x130
> [   82.843757][ T6441] Code: 53 48 63 da e8 73 44 b4 fd 4c 8d 7d 20 48
> c7 c7 40 0d dd 88 e8 c3 63 94 04 4c 89 fa 48 b8 00 00 00 00 00 fc ff
> df 48 c1 ea 03 <80> 3c 02 0d
> [   82.843760][ T6441] RSP: 0018:ffffc9000634f9e8 EFLAGS: 00010012
> [   82.843765][ T6441] RAX: dffffc0000000000 RBX: 0000000000000010
> RCX: 1ffffffff1a443f8
> [   82.843768][ T6441] RDX: 0000000000000015 RSI: ffffffff88dd0d40
> RDI: ffffffff88dac160
> [   82.843769][ T6441] RBP: 0000000000000088 R08: 0000000000000004
> R09: fffff940000bb9b9
> [   82.843771][ T6441] R10: ffffea00005dcdc7 R11: fffff940000bb9b8
> R12: 0000000000000000
> [   82.843772][ T6441] R13: 0000000000000001 R14: 0000000000000001
> R15: 00000000000000a8
> [   82.843776][ T6441] FS:  00000000014e5880(0000)
> GS:ffff88802d400000(0000) knlGS:0000000000000000
> [   82.843780][ T6441] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   82.843785][ T6441] CR2: 0000000020000000 CR3: 00000000185a2000
> CR4: 00000000000006f0
> [   82.843791][ T6441] Call Trace:
> [   82.843795][ T6441]  <TASK>
> [   82.843799][ T6441]  __folio_start_writeback+0x64f/0x7b0
> [   82.843805][ T6441]  ? domain_dirty_limits+0x350/0x350
> [   82.843808][ T6441]  ? udf_get_block+0x208/0x4d0
> [   82.843813][ T6441]  ? errseq_set+0x7b/0xe0
> [   82.843817][ T6441]  __block_write_full_page+0x9b0/0xdc0
> [   82.843822][ T6441]  ? udf_block_map+0x250/0x250
> [   82.843824][ T6441]  ? end_buffer_write_sync+0xb0/0xb0
> [   82.843827][ T6441]  udf_expand_file_adinicb+0x3bc/0xcc0
> [   82.843830][ T6441]  ? udf_update_inode+0x3370/0x3370
> [   82.843833][ T6441]  udf_file_write_iter+0x298/0x440
> [   82.843835][ T6441]  ? _raw_spin_lock+0x88/0x110
> [   82.843844][ T6441]  new_sync_write+0x37f/0x620
> [   82.843848][ T6441]  ? new_sync_read+0x610/0x610
> [   82.843850][ T6441]  ? common_file_perm+0x196/0x5f0
> [   82.843855][ T6441]  ? apparmor_path_rmdir+0x20/0x20
> [   82.843857][ T6441]  ? kmem_cache_free+0x9a/0x490
> [   82.843860][ T6441]  ? security_file_permission+0x49/0x570
> [   82.843864][ T6441]  vfs_write+0x41d/0x7b0
> [   82.892153][ T6441]  ksys_write+0xe8/0x1c0
> [   82.894156][ T6441]  ? __ia32_sys_read+0xa0/0xa0
> [   82.895079][ T6441]  do_syscall_64+0x35/0xb0
> [   82.895830][ T6441]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [   82.896810][ T6441] RIP: 0033:0x44eafd
> [   82.897449][ T6441] Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3
> 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b
> 4c 24 08 0f 05 <48> 3d 01 f8
> [   82.900627][ T6441] RSP: 002b:00007ffec490a868 EFLAGS: 00000246
> ORIG_RAX: 0000000000000001
> [   82.901996][ T6441] RAX: ffffffffffffffda RBX: 0000000000400530
> RCX: 000000000044eafd
> [   82.903311][ T6441] RDX: 000000000000fdef RSI: 0000000020000080
> RDI: 0000000000000004
> [   82.904625][ T6441] RBP: 00007ffec490a880 R08: 0000000000000000
> R09: 0000000000000000
> [   82.905919][ T6441] R10: 0000000000000000 R11: 0000000000000246
> R12: 0000000000403b00
> [   82.907212][ T6441] R13: 0000000000000000 R14: 00000000004c6018
> R15: 0000000000000000
> [   82.908522][ T6441]  </TASK>
> [   82.909026][ T6441] Modules linked in:
> [   82.909671][ T6441] ---[ end trace 99ae3d17814cae89 ]---
> [   82.910556][ T6441] RIP: 0010:percpu_counter_add_batch+0x3e/0x130
> [   82.911627][ T6441] Code: 53 48 63 da e8 73 44 b4 fd 4c 8d 7d 20 48
> c7 c7 40 0d dd 88 e8 c3 63 94 04 4c 89 fa 48 b8 00 00 00 00 00 fc ff
> df 48 c1 ea 03 <80> 3c 02 0d
> [   82.914533][ T6441] RSP: 0018:ffffc9000634f9e8 EFLAGS: 00010012
> [   82.915482][ T6441] RAX: dffffc0000000000 RBX: 0000000000000010
> RCX: 1ffffffff1a443f8
> [   82.916677][ T6441] RDX: 0000000000000015 RSI: ffffffff88dd0d40
> RDI: ffffffff88dac160
> [   82.917868][ T6441] RBP: 0000000000000088 R08: 0000000000000004
> R09: fffff940000bb9b9
> [   82.919086][ T6441] R10: ffffea00005dcdc7 R11: fffff940000bb9b8
> R12: 0000000000000000
> [   82.920262][ T6441] R13: 0000000000000001 R14: 0000000000000001
> R15: 00000000000000a8
> [   82.921457][ T6441] FS:  00000000014e5880(0000)
> GS:ffff88802d400000(0000) knlGS:0000000000000000
> [   82.922825][ T6441] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   82.923845][ T6441] CR2: 0000000020000000 CR3: 00000000185a2000
> CR4: 00000000000006f0
> [   82.925080][ T6441] Kernel panic - not syncing: Fatal exception
> [   82.926163][ T6441] Kernel Offset: disabled
> [   82.926853][ T6441] Rebooting in 86400 seconds..
> 
> ```
> The attachment is a reproduce.

Thanks for report. Do you have a source code for the reproducer? Or the
corrupted UDF image to share?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
