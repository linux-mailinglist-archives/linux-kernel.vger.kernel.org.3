Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B18485C73
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 00:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245541AbiAEXut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 18:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245498AbiAEXuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 18:50:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0180C061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 15:50:39 -0800 (PST)
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D7A061849
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 23:50:39 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4DA8060E53;
        Wed,  5 Jan 2022 23:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1641426638;
        bh=ECuVqa+UfngjSq+bE2+WEGaQuS3rZerBbiEQ21q0ux0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L0Medc595gwxt1HZvx4ptWpcX+QEo0C3RplWIMUxCL9cB9hJWFf6FbkNIIcr9nRaj
         NXfDom/EJLv3fuVQX2OJi53MWPoIoD2OtTdC8XURV7jmwT+d5NYXrQqP7MGNatjW73
         b47LYy8ykXLUKvDWjN1/C63rHz/R8MZlc7MdRcGE=
Date:   Wed, 5 Jan 2022 15:50:36 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+217f792c92599518a2ab@syzkaller.appspotmail.com>
Cc:     glider@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KMSAN: uninit-value in mpol_rebind_task (2)
Message-Id: <20220105155036.1ee64ea3a4322085b6fbb431@linux-foundation.org>
In-Reply-To: <00000000000004591305d4bebf11@google.com>
References: <00000000000004591305d4bebf11@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Jan 2022 02:03:17 -0800 syzbot <syzbot+217f792c92599518a2ab@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    81c325bbf94e kmsan: hooks: do not check memory in kmsan_in..
> git tree:       https://github.com/google/kmsan.git master
> console output: https://syzkaller.appspot.com/x/log.txt?x=112b8f7db00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2d8b9a11641dc9aa
> dashboard link: https://syzkaller.appspot.com/bug?extid=217f792c92599518a2ab
> compiler:       clang version 14.0.0 (/usr/local/google/src/llvm-git-monorepo 2b554920f11c8b763cd9ed9003f4e19b919b8e1f), GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13366ea5b00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14526cb3b00000

Thanks.  I don't get it.

> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+217f792c92599518a2ab@syzkaller.appspotmail.com
> 
> =====================================================
> BUG: KMSAN: uninit-value in mpol_rebind_policy mm/mempolicy.c:352 [inline]
> BUG: KMSAN: uninit-value in mpol_rebind_task+0x2ac/0x2c0 mm/mempolicy.c:368
>  mpol_rebind_policy mm/mempolicy.c:352 [inline]

Appears to be

	if (!mpol_store_user_nodemask(pol) &&

But if so, why didn't it also report

	mpol_store_user_nodemask mm/mempolicy.c:184 [inline]

which is where the 

	return pol->flags & MPOL_MODE_FLAGS;

actually happened?

>  mpol_rebind_task+0x2ac/0x2c0 mm/mempolicy.c:368
>  cpuset_change_task_nodemask kernel/cgroup/cpuset.c:1711 [inline]
>  cpuset_attach+0x787/0x15e0 kernel/cgroup/cpuset.c:2278
>  cgroup_migrate_execute+0x1023/0x1d20 kernel/cgroup/cgroup.c:2515
>  cgroup_migrate kernel/cgroup/cgroup.c:2771 [inline]
>  cgroup_attach_task+0x540/0x8b0 kernel/cgroup/cgroup.c:2804
>  __cgroup1_procs_write+0x5cc/0x7a0 kernel/cgroup/cgroup-v1.c:520
>  cgroup1_tasks_write+0x94/0xb0 kernel/cgroup/cgroup-v1.c:539
>  cgroup_file_write+0x4c2/0x9e0 kernel/cgroup/cgroup.c:3852
>  kernfs_fop_write_iter+0x66a/0x9f0 fs/kernfs/file.c:296
>  call_write_iter include/linux/fs.h:2162 [inline]
>  new_sync_write fs/read_write.c:503 [inline]
>  vfs_write+0x1318/0x2030 fs/read_write.c:590
>  ksys_write+0x28b/0x510 fs/read_write.c:643
>  __do_sys_write fs/read_write.c:655 [inline]
>  __se_sys_write fs/read_write.c:652 [inline]
>  __x64_sys_write+0xdb/0x120 fs/read_write.c:652
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x54/0xd0 arch/x86/entry/common.c:82
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Uninit was created at:
>  slab_post_alloc_hook mm/slab.h:524 [inline]
>  slab_alloc_node mm/slub.c:3251 [inline]
>  slab_alloc mm/slub.c:3259 [inline]
>  kmem_cache_alloc+0x902/0x11c0 mm/slub.c:3264
>  mpol_new mm/mempolicy.c:293 [inline]

But mpol_new() does

	policy->flags = flags;


>  do_set_mempolicy+0x421/0xb70 mm/mempolicy.c:853
>  kernel_set_mempolicy mm/mempolicy.c:1504 [inline]
>  __do_sys_set_mempolicy mm/mempolicy.c:1510 [inline]
>  __se_sys_set_mempolicy+0x44c/0xb60 mm/mempolicy.c:1507
>  __x64_sys_set_mempolicy+0xd8/0x110 mm/mempolicy.c:1507
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x54/0xd0 arch/x86/entry/common.c:82
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> CPU: 1 PID: 3479 Comm: syz-executor124 Not tainted 5.16.0-rc5-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> =====================================================

