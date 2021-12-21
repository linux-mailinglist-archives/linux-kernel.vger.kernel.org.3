Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54E647C079
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 14:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbhLUNJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 08:09:44 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49494 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhLUNJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 08:09:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81BEBB816A7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 13:09:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6E5C36AE2;
        Tue, 21 Dec 2021 13:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640092181;
        bh=WDj7Vrm6eFos1wObBBHfJhDW1MHaJV2gA1VBjCUNvsw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S89CQo5UjteTqTmwyvyjP/c+N+wqfKZ9QyLkosuL/xS93oqWnPyz9fgVzf+ipspg/
         IdeyaJEVy+dSsTADRHdOKssmm68/vdk97OuitF5Ils8c14GubYyZy5+kW3c9qDAf0z
         npQsEE6u3zXc7TVt23LbLX2Rbz4eWQIKGKhvamsAa44ZienfKMByorOnBGh1pNdlzs
         yfQzidiS9nqsihHZjEJNIPYxDWpiwFku7biWlTIOJd/jsMswFAVzdLWE7Oditu072v
         My+8GoGxs0hovjOKVb1BlKVI8JqnsII9VVaeUveVEzO+yBhuyOgm+a396tMn0sN7Kj
         bFM17H0duv9HA==
Date:   Tue, 21 Dec 2021 14:09:37 +0100
From:   Alexey Gladkov <legion@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Qian Cai <quic_qiancai@quicinc.com>, Yu Zhao <yuzhao@google.com>,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: BUG: KASAN: use-after-free in dec_rlimit_ucounts
Message-ID: <20211221130937.yokn25stgjpzax7n@example.org>
References: <YZV7Z+yXbsx9p3JN@fixkernel.com>
 <875ysptfgi.fsf@email.froward.int.ebiederm.org>
 <YZa4YbcOyjtD3+pL@fixkernel.com>
 <87k0h5rxle.fsf@email.froward.int.ebiederm.org>
 <YZ6zXEZf9qHLFyIp@fixkernel.com>
 <YaBxzDGyWxU/836N@fixkernel.com>
 <8735mnakby.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735mnakby.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 19, 2021 at 11:58:41PM -0600, Eric W. Biederman wrote:
> Qian Cai <quic_qiancai@quicinc.com> writes:
> 
> > On Wed, Nov 24, 2021 at 04:49:19PM -0500, Qian Cai wrote:
> >> Hmm, I don't know if that or it is just this platfrom is lucky to trigger
> >> the race condition quickly, but I can't reproduce it on x86 so far. I am
> >> Cc'ing a few arm64 people to see if they have spot anything I might be
> >> missing. The original bug report is here:
> >> 
> >> https://lore.kernel.org/lkml/YZV7Z+yXbsx9p3JN@fixkernel.com/
> >
> > Okay, I am finally able to reproduce this on x86_64 with the latest
> > mainline as well by setting CONFIG_USER_NS and KASAN on the top of
> > defconfig (I did not realize it did not select CONFIG_USER_NS in the first
> > place). Anyway, it still took less than 5-minute by running:
> >
> > $ trinity -C 48
> 
> It took me a while to get to the point of reproducing this but I can
> confirm I see this with 2 core VM, running 5.16.0-rc4.
> 
> Running trinity 2019.06 packaged in debian 11.

I still can't reproduce :(

> I didn't watch so I don't know if it was 5 minutes but I do know it took
> less than an hour.

--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -209,6 +209,7 @@ void put_ucounts(struct ucounts *ucounts)

        if (atomic_dec_and_lock_irqsave(&ucounts->count, &ucounts_lock, flags)) {
                hlist_del_init(&ucounts->node);
+               ucounts->ns = NULL;
                spin_unlock_irqrestore(&ucounts_lock, flags);
                kfree(ucounts);
        }

Does the previous hack increase the likelihood of an error being
triggered?

> Now I am puzzled why there are not other reports of problems.
> 
> Now to start drilling down to figure out why the user namespace was
> freed early.
> ----
> 
> The failure I got looked like:
> > BUG: KASAN: use-after-free in dec_rlimit_ucounts+0x7b/0xb0
> > Read of size 8 at addr ffff88800b7dd018 by task trinity-c3/67982
> > 
> > CPU: 1 PID: 67982 Comm: trinity-c3 Tainted: G  O 5.16.0-rc4 #1
> > Hardware name: Xen HVM domU, BIOS 4.8.5-35.fc25 08/25/2021
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0x48/0x5e
> >  print_address_descrtion.constprop.0+0x1f/0x140
> >  ? dec_rlimit_ucounts+0x7b/0xb0
> >  ? dec_rlimit_ucounts+0x7b/0xb0
> >  kasan_report.cold+0x7f/0xe0
> >  ? _raw_spin_lock+0x7f/0x11b
> >  ? dec_rlimit_ucounts+0x7b/0xb0
> >  dec_rlimit_ucounts+0x7b/0xb0
> >  mqueue_evict_inode+0x417/0x590
> >  ? perf_trace_global_dirty_state+0x350/0x350
> >  ? __x64_sys_mq_unlink+0x250/0x250
> >  ? _raw_spin_lock_bh+0xe0/0xe0
> >  ? _raw_spin_lock_bh+0xe0/0xe0
> >  evict+0x155/0x2a0
> >  __x64_sys_mq_unlink+0x1a7/0x250
> >  do_syscall_64+0x3b/0x90
> >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > RIP: 0033:0x7f0505ebc9b9
> > Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 00 0f 1f 44 00 00 48 89 ....
> > 
> > Allocated by task 67717
> > Freed by task 6027
> > 
> > The buggy address belongs to the object at ffff88800b7dce38
> >  which belongs to the cache user_namespace of size 600
> > The buggy address is located 480 bytes inside of
> >  600-byte region [ffff88800b7dce38, ffff88800b7dd090]
> > The buggy address belongs to the page:
> > 
> > trinity: Detected kernel tainting. Last seed was 1891442794
> 
> Eric
> 

-- 
Rgrds, legion

