Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78179481711
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 22:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbhL2V37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 16:29:59 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59880 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231322AbhL2V36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 16:29:58 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1BTLTXpr015065
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Dec 2021 16:29:34 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id BFDD915C33A3; Wed, 29 Dec 2021 16:29:33 -0500 (EST)
Date:   Wed, 29 Dec 2021 16:29:33 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Waiman Long <longman@redhat.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+03464269af631f4a4bdf@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] INFO: rcu detected stall in ext4_file_write_iter (4)
Message-ID: <YczTPYx0L7y8TgIE@mit.edu>
References: <000000000000ef8cbb05d3bf84cd@google.com>
 <20211225005253.1962-1-hdanton@sina.com>
 <6396f046-b292-1a73-8339-d32b611d9b7f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6396f046-b292-1a73-8339-d32b611d9b7f@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2021 at 10:14:23PM -0500, Waiman Long wrote:
> 
> The test was running on a CONFIG_PREEMPT kernel. So if the syzkaller kthread
> is running at a higher priority than the rcu_preempt kthread, it is possible
> for the rcu_preempt kthread to be starved of cpu time. The rwsem optimistic
> spinning code will relinquish the cpu if there is a higher priority thread
> running. Since rcu_preempt kthread did not seem to be able to get the cpu, I
> suspect that it is probably caused by the syzkaller thread having a higher
> priority.

It's even worse than that.  The Syzkaller reproducer is calling
sched_setattr():

  *(uint32_t*)0x20000080 = 0x38;    // sched_attr.sched_size
  *(uint32_t*)0x20000084 = 1;       // sched_attr.sched_policy == SCHED_FIFO
  *(uint64_t*)0x20000088 = 0;       // sched_attr.sched_flags
  *(uint32_t*)0x20000090 = 0;       // sched_attr.sched_nice
  *(uint32_t*)0x20000094 = 1;       // sched_attr.sched_priority
  *(uint64_t*)0x20000098 = 0;       // ...
  *(uint64_t*)0x200000a0 = 0;
  *(uint64_t*)0x200000a8 = 0;
  *(uint32_t*)0x200000b0 = 0;
  *(uint32_t*)0x200000b4 = 0;
  syscall(__NR_sched_setattr, 0, 0x20000080ul, 0ul);

So one or more of the syzkaller threads is SCHED_FIFO, and SCHED_FIFO
threads will *never* relinquish the CPU in favor of SCHED_OTHER
threads (which in practice will include all kernel threads unless
special measures are taken by someone who knows what they are doing)
so long as it they are runable.

See the discussion at:

    https://lore.kernel.org/all/Yb5RMWRsJl5TMk8H@casper.infradead.org/

I recommend that kernel developers simply ignore any syzkaller report
that relates to tasks being hung or rcu detected and where the
reproducer is trying to set a real-time priority (e.g., sched_policy
of SCHED_FIFO or SCHED_RR), since the number of ways that
sched_setattr can be used as a foot-gun are near infinite....

Syzkaller reports that include sched_setattr are great for inflating
the OMG!  There are tons of unhandled syzkaller reports, "companies
need to fund more engineering headcount to fix syzkaller bugs" slide
decks.  But IMHO, they are not good for much else.

	      	     	       		    - Ted
