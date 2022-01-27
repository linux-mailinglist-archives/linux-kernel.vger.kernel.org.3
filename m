Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E9E49D8B9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 03:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiA0C66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 21:58:58 -0500
Received: from out1.migadu.com ([91.121.223.63]:29752 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229668AbiA0C65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 21:58:57 -0500
Date:   Thu, 27 Jan 2022 11:58:45 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1643252334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FYICBKJujxWP66P35sZcJvIBTEiFJq2KDSX6diI/+IM=;
        b=Az1ZEbyCScboKvqlrja6XAt8KbS4xYUnzgksop8d1SJJjy8xueCPX/CkVH/Yr5b6xtHJ3N
        2YNb6FUAZwZWDWaLldBwuoSMmCRv4P8AeOKIM6A9m1oyaCCGEINfRT4gTWtI1r8NmgMLj3
        /nvobiR9Rqz8iZyDslounBWAXn6FltQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 1/3] mm: enable MADV_DONTNEED for hugetlb mappings
Message-ID: <20220127025845.GA3401059@u2004>
References: <20220113180308.15610-1-mike.kravetz@oracle.com>
 <20220113180308.15610-2-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220113180308.15610-2-mike.kravetz@oracle.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 10:03:06AM -0800, Mike Kravetz wrote:
> MADV_DONTNEED is currently disabled for hugetlb mappings.  This
> certainly makes sense in shared file mappings as the pagecache maintains
> a reference to the page and it will never be freed.  However, it could
> be useful to unmap and free pages in private mappings.
> 
> The only thing preventing MADV_DONTNEED (and MADV_FREE) from working on
> hugetlb mappings is a check in can_madv_lru_vma().  To allow support for
> hugetlb mappings create and use a new routine madvise_dontneed_valid_vma()
> that will allow hugetlb mappings.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

I briefly tested the patch and it seems that when calling madvise(MADV_DONTNEED)
with the range unaligned to hugepage size (like 4kB) triggered the following crash.
Could you double check around the address range issue?

[  220.915316] ------------[ cut here ]------------
[  220.916792] kernel BUG at mm/hugetlb.c:4946!
[  220.918519] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[  220.920344] CPU: 2 PID: 1665 Comm: a.out Tainted: G            E     5.17.0-rc1-220126-1543+ #31
[  220.930536] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1.fc35 04/01/2014
[  220.934484] RIP: 0010:__unmap_hugepage_range+0x4d6/0x580
[  220.936443] Code: ff ff 49 c7 44 24 10 ff ff ff ff 41 80 64 24 20 83 e9 34 fd ff ff 0f 0b 49 8b 47 30 48 f7 d0 4c 85 c8 0f 84 93 fb ff ff 0f 0b <0f> 0b 48 8d 7c 24 48 83 4c 24 68 01 e8 69 b9 00 00 4c 8b 4c 24 08
[  220.943818] RSP: 0018:ffffabe9019dfc98 EFLAGS: 00010206
[  220.945454] RAX: 000000000000a000 RBX: ffff8a0e02253ed8 RCX: 0000000000000009
[  220.947661] RDX: 00007f1c08000000 RSI: ffff8a0e02253ed8 RDI: ffffabe9019dfdb8
[  220.949677] RBP: 0000000000200000 R08: 0000000000000000 R09: 00007f1c08000000
[  220.951902] R10: 0000000000000000 R11: 0000000000000000 R12: ffffabe9019dfdb8
[  220.954040] R13: ffffabe9019dfdb8 R14: 00007f1c08000000 R15: ffffffff9420f960
[  220.955990] FS:  00007f1c08480540(0000) GS:ffff8a0efbc00000(0000) knlGS:0000000000000000
[  220.958034] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  220.959517] CR2: 00007f1c0849aff8 CR3: 0000000146a52000 CR4: 00000000001506e0
[  220.961321] Call Trace:
[  220.961945]  <TASK>
[  220.962535]  ? __slab_free+0xba/0x370
[  220.963468]  ? update_load_avg+0x7e/0x5f0
[  220.964427]  ? __cgroup_account_cputime+0x4c/0x70
[  220.965596]  ? page_counter_uncharge+0x1d/0x30
[  220.966733]  __unmap_hugepage_range_final+0xe/0x20
[  220.967861]  unmap_single_vma+0xc7/0xf0
[  220.968795]  zap_page_range+0xcc/0x130
[  220.969619]  ? find_vma+0x73/0x80
[  220.970378]  do_madvise.part.0+0xb65/0xea0
[  220.971279]  ? do_sigaction+0x111/0x240
[  220.972081]  __x64_sys_madvise+0x56/0x70
[  220.972969]  do_syscall_64+0x3b/0x90
[  220.973779]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  220.974883] RIP: 0033:0x7f1c083b24eb
[  220.975632] Code: c3 48 8b 15 9f 59 0c 00 f7 d8 64 89 02 b8 ff ff ff ff eb c2 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 1c 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 6d 59 0c 00 f7 d8 64 89 01 48
[  220.979331] RSP: 002b:00007ffe7f9bc038 EFLAGS: 00000202 ORIG_RAX: 000000000000001c
[  220.980791] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1c083b24eb
[  220.982162] RDX: 0000000000000004 RSI: 000000000000a000 RDI: 00007f1c08000000
[  220.983550] RBP: 00007ffe7f9bc070 R08: 0000000000000000 R09: 0000000000000000
[  220.984997] R10: 000000000040049c R11: 0000000000000202 R12: 00000000004010d0
[  220.986399] R13: 00007ffe7f9bc150 R14: 0000000000000000 R15: 0000000000000000
[  220.987765]  </TASK>


Thanks,
Naoya Horiguchi
