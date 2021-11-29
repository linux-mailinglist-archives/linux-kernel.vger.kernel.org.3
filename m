Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3C54615C3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 14:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377517AbhK2NHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 08:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354489AbhK2NFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:05:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADF4C08EB4C
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 03:47:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01AF661290
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 11:47:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F90DC004E1;
        Mon, 29 Nov 2021 11:47:16 +0000 (UTC)
Date:   Mon, 29 Nov 2021 12:47:13 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     syzbot <syzbot+dfac92a50024b54acaa4@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, cxfcosmos@gmail.com,
        ebiederm@xmission.com, glider@google.com, legion@kernel.org,
        linux-kernel@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KMSAN: uninit-value in from_kuid
Message-ID: <20211129114713.at2mo64hgnlmkx3x@wittgenstein>
References: <000000000000a0d53f05d1c72a4c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000a0d53f05d1c72a4c@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 27, 2021 at 07:50:27AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    425295055ce6 kmsan: core: address comments to kmsan-checks.h
> git tree:       https://github.com/google/kmsan.git master
> console output: https://syzkaller.appspot.com/x/log.txt?x=1640209ab00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2d142cdf4204061
> dashboard link: https://syzkaller.appspot.com/bug?extid=dfac92a50024b54acaa4
> compiler:       clang version 14.0.0 (git@github.com:llvm/llvm-project.git 0996585c8e3b3d409494eb5f1cad714b9e1f7fb5), GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+dfac92a50024b54acaa4@syzkaller.appspotmail.com
> 
> =====================================================
> BUG: KMSAN: uninit-value in map_id_up_base kernel/user_namespace.c:335 [inline]
> BUG: KMSAN: uninit-value in map_id_up kernel/user_namespace.c:365 [inline]
> BUG: KMSAN: uninit-value in from_kuid+0x51d/0xbd0 kernel/user_namespace.c:413
>  map_id_up_base kernel/user_namespace.c:335 [inline]
>  map_id_up kernel/user_namespace.c:365 [inline]
>  from_kuid+0x51d/0xbd0 kernel/user_namespace.c:413
>  p9pdu_vwritef+0x15ab/0x5120 net/9p/protocol.c:398
>  p9pdu_writef+0x23a/0x280 net/9p/protocol.c:539
>  p9pdu_vwritef+0x21f0/0x5120 net/9p/protocol.c:490
>  p9_client_prepare_req+0xa4b/0xff0 net/9p/client.c:709
>  p9_client_rpc+0x278/0x1410 net/9p/client.c:740
>  p9_client_setattr+0x115/0x2c0 net/9p/client.c:1899
>  v9fs_vfs_setattr_dotl+0x7e2/0xd70 fs/9p/vfs_inode_dotl.c:590
>  notify_change+0x1fe3/0x2170 fs/attr.c:410
>  vfs_utimes+0x8aa/0xc70 fs/utimes.c:65
>  do_utimes_path fs/utimes.c:98 [inline]
>  do_utimes fs/utimes.c:144 [inline]
>  __do_sys_utime32 fs/utimes.c:247 [inline]
>  __se_sys_utime32+0x386/0x520 fs/utimes.c:235
>  __ia32_sys_utime32+0x91/0xc0 fs/utimes.c:235
>  do_syscall_32_irqs_on arch/x86/entry/common.c:114 [inline]
>  __do_fast_syscall_32+0x96/0xf0 arch/x86/entry/common.c:180
>  do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
>  do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
>  entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
> 
> Uninit was stored to memory at:
>  v9fs_vfs_setattr_dotl+0x58a/0xd70 fs/9p/vfs_inode_dotl.c:567

That's a bug in the 9P2000.L implementation of .setattr.
It copies struct iattr values without checking ia_valid. That's causing
uninitalized memory to be copied. I sent a fix to 9p for this.

Christian
