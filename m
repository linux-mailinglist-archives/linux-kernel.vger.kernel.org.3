Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 030DA4A5088
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 21:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359681AbiAaUvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 15:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355850AbiAaUvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 15:51:32 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB09C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:51:32 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id j2so31188045ybu.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SxexTTPgvwh2G+/AnLnwJxqpiBkQWgHLJdtikmt6ddY=;
        b=bWkEnkcPWD5kjM15sJp8GiGxxRY7y3ZoYvb5v88UMOiWkrOWKNkZWaGGR8vwZQQ/W3
         J+x4agOu67jyCqNCWPMZwheikNGfedFbducOk8NwOZK626/+fnwZh3KYG75m2jBEUtFD
         wmT1orfp5pj/F45m85sxOWORpABeOZRtvZ93+yqH3yesAAv+i/rikdMra7AWNy2gRVzs
         coKMVffxUw3+nEpAYUrByaCsOaTmfvTR70sgXJQoxZRnASyyKS1TGo2rfs4xXm2/QFsX
         fmZv/JlHW7fo5e35s5jKuYayx1XNdBSjFOFvEj+9ZpkvZS0JtxOeOcsYid6LwnNwKlpg
         zSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SxexTTPgvwh2G+/AnLnwJxqpiBkQWgHLJdtikmt6ddY=;
        b=f/HUdbglcj8MczCL3Jm4nRNOCiDWyebOXyBwiHBCuGLyaSXwrvM0IIeGpSvyj418YY
         7y0vpFZ48Rt+d9Ce2N5x60i+bDHf5I7KAiD5fsJFmVm0jDq7xAxrUgiDIN2JHdm/bcxP
         nWpUWr1cc62ld7iPiPaq3ZCIRqBKJGbdMJOn6F8zG3gC9+WxbPHnEOMs5iR5+lXWp2fp
         mA5cot6QQVYQ+5oECPODc73FWJOmxQyOwwClacNmmnFRiqaBOsaMU+27eATdHmxoXQcu
         /zf/3/UOXG9WwKawZUTnCv82IAOxvhXtSqO8OX5vKKfsw1ne5lYa/njK9AQkt66y5h4f
         yZzQ==
X-Gm-Message-State: AOAM531tMom0Vz9IpWUZBUBmvrhl/S3CTIBgdrdRTF4/XFNXKxXJ40hu
        inAHmmoZsRY92ExyaxC1gxVIy9uVN4yyDwzjsZPrtg==
X-Google-Smtp-Source: ABdhPJzuDfQknF6eqOrfpBfQxiD4fu5SyTaFjR2P2ZXsO4Rrzn8HrcZNaY9PHVx/Do6uTrKyGroSdY5ibwB/5OXJlmY=
X-Received: by 2002:a25:d2cb:: with SMTP id j194mr31659864ybg.277.1643662291429;
 Mon, 31 Jan 2022 12:51:31 -0800 (PST)
MIME-Version: 1.0
References: <00000000000027db6705d6e6e88a@google.com>
In-Reply-To: <00000000000027db6705d6e6e88a@google.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 31 Jan 2022 12:51:20 -0800
Message-ID: <CANn89i+nSa8KwCOyMFxC5saBdhZxowTKRf0GVw-QahhrNh_k8Q@mail.gmail.com>
Subject: Re: [syzbot] possible deadlock in ___neigh_create
To:     syzbot <syzbot+5239d0e1778a500d477a@syzkaller.appspotmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, Roopa Prabhu <roopa@nvidia.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 12:48 PM syzbot
<syzbot+5239d0e1778a500d477a@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    6449520391df net: stmmac: properly handle with runtime pm ..
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=111187e0700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a6620d0aab7dd315
> dashboard link: https://syzkaller.appspot.com/bug?extid=5239d0e1778a500d477a
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+5239d0e1778a500d477a@syzkaller.appspotmail.com
>
> ============================================
> WARNING: possible recursive locking detected
> 5.17.0-rc1-syzkaller-00210-g6449520391df #0 Not tainted
> --------------------------------------------
> kworker/0:16/14617 is trying to acquire lock:
> ffffffff8d4dd370 (&tbl->lock){++-.}-{2:2}, at: ___neigh_create+0x9e1/0x2990 net/core/neighbour.c:652
>
> but task is already holding lock:
> ffffffff8d4dd370 (&tbl->lock){++-.}-{2:2}, at: neigh_managed_work+0x35/0x250 net/core/neighbour.c:1572
>
> other info that might help us debug this:
>  Possible unsafe locking scenario:
>
>        CPU0
>        ----
>   lock(&tbl->lock);
>   lock(&tbl->lock);
>
>  *** DEADLOCK ***
>
>  May be due to missing lock nesting notation
>
> 5 locks held by kworker/0:16/14617:
>  #0: ffff888010c65d38 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
>  #0: ffff888010c65d38 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
>  #0: ffff888010c65d38 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
>  #0: ffff888010c65d38 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:631 [inline]
>  #0: ffff888010c65d38 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:658 [inline]
>  #0: ffff888010c65d38 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_one_work+0x890/0x1650 kernel/workqueue.c:2278
>  #1: ffffc9000293fdb8 ((work_completion)(&(&tbl->managed_work)->work)){+.+.}-{0:0}, at: process_one_work+0x8c4/0x1650 kernel/workqueue.c:2282
>  #2: ffffffff8d4dd370 (&tbl->lock){++-.}-{2:2}, at: neigh_managed_work+0x35/0x250 net/core/neighbour.c:1572
>  #3: ffffffff8bb83ae0 (rcu_read_lock){....}-{1:2}, at: ip6_nd_hdr net/ipv6/ndisc.c:466 [inline]
>  #3: ffffffff8bb83ae0 (rcu_read_lock){....}-{1:2}, at: ndisc_send_skb+0x84b/0x17f0 net/ipv6/ndisc.c:502
>  #4: ffffffff8bb83a80 (rcu_read_lock_bh){....}-{1:2}, at: lwtunnel_xmit_redirect include/net/lwtunnel.h:95 [inline]
>  #4: ffffffff8bb83a80 (rcu_read_lock_bh){....}-{1:2}, at: ip6_finish_output2+0x2ad/0x14f0 net/ipv6/ip6_output.c:112
>
> stack backtrace:
> CPU: 0 PID: 14617 Comm: kworker/0:16 Not tainted 5.17.0-rc1-syzkaller-00210-g6449520391df #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Workqueue: events_power_efficient neigh_managed_work
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  print_deadlock_bug kernel/locking/lockdep.c:2956 [inline]
>  check_deadlock kernel/locking/lockdep.c:2999 [inline]
>  validate_chain kernel/locking/lockdep.c:3788 [inline]
>  __lock_acquire.cold+0x149/0x3ab kernel/locking/lockdep.c:5027
>  lock_acquire kernel/locking/lockdep.c:5639 [inline]
>  lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
>  __raw_write_lock_bh include/linux/rwlock_api_smp.h:202 [inline]
>  _raw_write_lock_bh+0x2f/0x40 kernel/locking/spinlock.c:334
>  ___neigh_create+0x9e1/0x2990 net/core/neighbour.c:652
>  ip6_finish_output2+0x1070/0x14f0 net/ipv6/ip6_output.c:123
>  __ip6_finish_output net/ipv6/ip6_output.c:191 [inline]
>  __ip6_finish_output+0x61e/0xe90 net/ipv6/ip6_output.c:170
>  ip6_finish_output+0x32/0x200 net/ipv6/ip6_output.c:201
>  NF_HOOK_COND include/linux/netfilter.h:296 [inline]
>  ip6_output+0x1e4/0x530 net/ipv6/ip6_output.c:224
>  dst_output include/net/dst.h:451 [inline]
>  NF_HOOK include/linux/netfilter.h:307 [inline]
>  ndisc_send_skb+0xa99/0x17f0 net/ipv6/ndisc.c:508
>  ndisc_send_ns+0x3a9/0x840 net/ipv6/ndisc.c:650
>  ndisc_solicit+0x2cd/0x4f0 net/ipv6/ndisc.c:742
>  neigh_probe+0xc2/0x110 net/core/neighbour.c:1040
>  __neigh_event_send+0x37d/0x1570 net/core/neighbour.c:1201
>  neigh_event_send include/net/neighbour.h:470 [inline]
>  neigh_managed_work+0x162/0x250 net/core/neighbour.c:1574
>  process_one_work+0x9ac/0x1650 kernel/workqueue.c:2307
>  worker_thread+0x657/0x1110 kernel/workqueue.c:2454
>  kthread+0x2e9/0x3a0 kernel/kthread.c:377
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
>  </TASK>
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.


Probably caused by
commit 7482e3841d520a368426ac196720601687e2dc47    net, neigh: Add
NTF_MANAGED flag for managed neighbor entries



+static void neigh_managed_work(struct work_struct *work)
+{
+       struct neigh_table *tbl = container_of(work, struct neigh_table,
+                                              managed_work.work);
+       struct neighbour *neigh;
+
+       write_lock_bh(&tbl->lock);
+       list_for_each_entry(neigh, &tbl->managed_list, managed_list)
+               neigh_event_send(neigh, NULL);    // HERE

neigh_event_send() can need to lock tbl->lock, leading to a deadlock

+       queue_delayed_work(system_power_efficient_wq, &tbl->managed_work,
+                          NEIGH_VAR(&tbl->parms, DELAY_PROBE_TIME));
+       write_unlock_bh(&tbl->lock);
+}
+
