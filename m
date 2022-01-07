Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C31F487895
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 14:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238901AbiAGNyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 08:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238992AbiAGNyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 08:54:33 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1420AC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 05:54:33 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id be32so8240415oib.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 05:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YGqOgKFnGJz28p+OQa8FIlCc2oy0neN/zp9RS60zfPI=;
        b=jWKSfBEn9ok2HZUeR+w6zEdF7KlqnV9ecDNZmFU56q9i6pZhqsiGI4wo9PAa8IkvLw
         l6/CxhreIEzcnz6RYIOsspnD09k+sWkh3IzXye80wspUZlMEXkYv/fLtcl+35oewdfub
         NAC3GNNUKd/F1dztRnWm8M+U0xATDpJzR9PJS3yjQDRPsbEg8Zu/zp/8ctP9v9izitsi
         FwBEAr3iKspMBkRw7Vqe9UWRomDM0GSYiMKquYnvuxiDaMW+6iFMfepnOCt3NSBecciJ
         tCm3ckCcsJSVaDBmmSwY9f3oCOzPcO8u6ym2jt6BlhpYfxETskpPSN66C2ho92iyjeuZ
         1dZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YGqOgKFnGJz28p+OQa8FIlCc2oy0neN/zp9RS60zfPI=;
        b=YPetBU+KR4Lhu132X3qf4vKZtNNeo77WwN2uAr8i2i+aXYGXST09nAQPmfvmuo62a4
         vmpJoUFbrk+j9yNCaNJvZ27nqCkoXpjgiIpIxBDGv6zQal1Bc3wF5DTE7whv5cfluBy1
         Tchw5zNZGipaZFUzfY0KozZzzEJV794H2Uz7TdxBUPuOufVCXVXbJX03VWxX+YwE+sx8
         S5CeeUsTvTQoqnh308XPbnD171hOqCcXY2M8G+UMQ3MYvkQwHSpMH6on/5ji5AuvOGgm
         CrRwOQWmtNhgH/HxqBgfeSyDrmhF5FB6AiKB5HpzzAsQ3F4tKszivji/y/+iffYOvpf2
         lBOw==
X-Gm-Message-State: AOAM532QBB5G7OZWY15NOlmVb8/EHpAqdAPrQ5kiXO7hhm2DK5ydYXNl
        a5k7/tLPlsqvDYKYLd2nFyqakawA6WVA/5ZmmrnW+w==
X-Google-Smtp-Source: ABdhPJwdSDeEyuNMn6xzl7TFHAJyAsBV1CxPZXt4r7CFmM/gxUg7EJ77kn/TFWbdL5Tz3o4LdT55DWBC21J/LQQlcM4=
X-Received: by 2002:aca:b843:: with SMTP id i64mr9973885oif.109.1641563672135;
 Fri, 07 Jan 2022 05:54:32 -0800 (PST)
MIME-Version: 1.0
References: <00000000000004591305d4bebf11@google.com> <20220105155036.1ee64ea3a4322085b6fbb431@linux-foundation.org>
In-Reply-To: <20220105155036.1ee64ea3a4322085b6fbb431@linux-foundation.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 7 Jan 2022 14:54:20 +0100
Message-ID: <CACT4Y+Z1RGApGaxnPEFPees5RUNfYzy0VgaRxddGCJbEpTm1Dw@mail.gmail.com>
Subject: Re: [syzbot] KMSAN: uninit-value in mpol_rebind_task (2)
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+217f792c92599518a2ab@syzkaller.appspotmail.com>,
        glider@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jan 2022 at 00:50, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 04 Jan 2022 02:03:17 -0800 syzbot <syzbot+217f792c92599518a2ab@syzkaller.appspotmail.com> wrote:
>
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    81c325bbf94e kmsan: hooks: do not check memory in kmsan_in..
> > git tree:       https://github.com/google/kmsan.git master
> > console output: https://syzkaller.appspot.com/x/log.txt?x=112b8f7db00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=2d8b9a11641dc9aa
> > dashboard link: https://syzkaller.appspot.com/bug?extid=217f792c92599518a2ab
> > compiler:       clang version 14.0.0 (/usr/local/google/src/llvm-git-monorepo 2b554920f11c8b763cd9ed9003f4e19b919b8e1f), GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13366ea5b00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14526cb3b00000
>
> Thanks.  I don't get it.
>
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+217f792c92599518a2ab@syzkaller.appspotmail.com
> >
> > =====================================================
> > BUG: KMSAN: uninit-value in mpol_rebind_policy mm/mempolicy.c:352 [inline]
> > BUG: KMSAN: uninit-value in mpol_rebind_task+0x2ac/0x2c0 mm/mempolicy.c:368
> >  mpol_rebind_policy mm/mempolicy.c:352 [inline]
>
> Appears to be
>
>         if (!mpol_store_user_nodemask(pol) &&
>
> But if so, why didn't it also report
>
>         mpol_store_user_nodemask mm/mempolicy.c:184 [inline]
>
> which is where the
>
>         return pol->flags & MPOL_MODE_FLAGS;
>
> actually happened?

Hi Andrew,

KMSAN doesn't just flag loads of non-stored to variables. It tracks
propagation of uninit values of memory and registers and flags only
"uses" of uninit values. Where uses are roughly when uninits affect
control flow, are part of dereferenced pointers or sink to user-space.
The problem is that real code tends to load, stores and even do
computations on uninit values (or partially uninit values) a lot.
Think of bitfields, alignment paddings, or just tricky structured
code.

That's why:
return pol->flags & MPOL_MODE_FLAGS;
is not yet flagged, it just marks the result as uninit.



> >  mpol_rebind_task+0x2ac/0x2c0 mm/mempolicy.c:368
> >  cpuset_change_task_nodemask kernel/cgroup/cpuset.c:1711 [inline]
> >  cpuset_attach+0x787/0x15e0 kernel/cgroup/cpuset.c:2278
> >  cgroup_migrate_execute+0x1023/0x1d20 kernel/cgroup/cgroup.c:2515
> >  cgroup_migrate kernel/cgroup/cgroup.c:2771 [inline]
> >  cgroup_attach_task+0x540/0x8b0 kernel/cgroup/cgroup.c:2804
> >  __cgroup1_procs_write+0x5cc/0x7a0 kernel/cgroup/cgroup-v1.c:520
> >  cgroup1_tasks_write+0x94/0xb0 kernel/cgroup/cgroup-v1.c:539
> >  cgroup_file_write+0x4c2/0x9e0 kernel/cgroup/cgroup.c:3852
> >  kernfs_fop_write_iter+0x66a/0x9f0 fs/kernfs/file.c:296
> >  call_write_iter include/linux/fs.h:2162 [inline]
> >  new_sync_write fs/read_write.c:503 [inline]
> >  vfs_write+0x1318/0x2030 fs/read_write.c:590
> >  ksys_write+0x28b/0x510 fs/read_write.c:643
> >  __do_sys_write fs/read_write.c:655 [inline]
> >  __se_sys_write fs/read_write.c:652 [inline]
> >  __x64_sys_write+0xdb/0x120 fs/read_write.c:652
> >  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
> >  do_syscall_64+0x54/0xd0 arch/x86/entry/common.c:82
> >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> >
> > Uninit was created at:
> >  slab_post_alloc_hook mm/slab.h:524 [inline]
> >  slab_alloc_node mm/slub.c:3251 [inline]
> >  slab_alloc mm/slub.c:3259 [inline]
> >  kmem_cache_alloc+0x902/0x11c0 mm/slub.c:3264
> >  mpol_new mm/mempolicy.c:293 [inline]
>
> But mpol_new() does
>
>         policy->flags = flags;

I suspect the tool points at nodes field (but line 352 rather than 353
because the && that produces the final uninit value used for control
flow in on 352).

Is it possible that flags contain MPOL_MODE_FLAGS, but mode is
MPOL_LOCAL so that nodes are not set or something along these lines?


> >  do_set_mempolicy+0x421/0xb70 mm/mempolicy.c:853
> >  kernel_set_mempolicy mm/mempolicy.c:1504 [inline]
> >  __do_sys_set_mempolicy mm/mempolicy.c:1510 [inline]
> >  __se_sys_set_mempolicy+0x44c/0xb60 mm/mempolicy.c:1507
> >  __x64_sys_set_mempolicy+0xd8/0x110 mm/mempolicy.c:1507
> >  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
> >  do_syscall_64+0x54/0xd0 arch/x86/entry/common.c:82
> >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> >
> > CPU: 1 PID: 3479 Comm: syz-executor124 Not tainted 5.16.0-rc5-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > =====================================================
