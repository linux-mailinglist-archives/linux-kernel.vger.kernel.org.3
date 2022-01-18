Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 518BE492852
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 15:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245315AbiAROYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 09:24:54 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42936 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242241AbiAROYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 09:24:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29400614D0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 14:24:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38A9C00446;
        Tue, 18 Jan 2022 14:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642515892;
        bh=qfhBRI96dPWOb1VgMeO1zge4Anqb8GOqRNqOVR/c9vg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Bebpkah9Niyt6HMIT6RmDpRW9gyMlob2AEs9mGu0soYOi5uC6kMDNK8EVaGa29oKA
         8Bj9Nt0K66ZoA7kiBOGYxVZTRvEf3Q4c7DKVOpi0732gJRlHRwYpp+YkeWGY+F5One
         wqHk/UJDPGrplLZKRpHRqRWTA+5d0EVAOa0bvuSs654RDajvcoNS0f7N4lku9iUhB3
         tX3O1F4G5X8SC1iD9pEPa9QHpH5GS9Nyadt43lS/TMzYuOqiHKmpNU/IKEkfXJx8uU
         SS5nxfCWsZ70LyOn4+eFUivz/LOC1fs0Acp0r80THDtXW/kJwW6Hobm5NVrrlFAFDb
         dp0yAolgp2D9g==
Date:   Tue, 18 Jan 2022 23:24:48 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mingo@redhat.com,
        zanussi@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/4] trace: Introduce objtrace trigger to trace the
 kernel object
Message-Id: <20220118232448.891fbf550b50193e0155b59c@kernel.org>
In-Reply-To: <20220113013835.503285-1-xiehuan09@gmail.com>
References: <20220113013835.503285-1-xiehuan09@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2022 09:38:31 +0800
Jeff Xie <xiehuan09@gmail.com> wrote:

> Introduce a method based on function tracer to trace any object and get
> the value of the object dynamically. the object can be obtained from the
> dynamic event (kprobe_event/uprobe_event) or the static event(tracepoint).
> 
> Usage:
> When using the kprobe event, only need to set the objtrace(a new trigger),
> we can get the value of the object. The object is from the setting of the 
> kprobe event.
> 
> For example:
> For the function bio_add_page():
> 
> int bio_add_page(struct bio *bio, struct page *page,
> 	unsigned int len, unsigned int offset)
> 
> Firstly, we can set the base of the object, thus the first string "arg1"
> stands for the value of the first parameter of this function bio_add_gage(),
> 
> # echo 'p bio_add_page arg1=$arg1' >> ./kprobe_events
> 
> Secondly, we can get the value dynamically base the above object. 
> 
> find the offset of the bi_size in struct bio:
> $ gdb vmlinux
> (gdb) p &(((struct bio *)0)->bi_iter.bi_size)
> $1 = (unsigned int *) 0x28
> 
> # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/ \
> 	p_bio_add_page_0/trigger
> 
> The best way to use this is that we can set the entrance event and exit
> event, for example, the following example is to set the read_papes as
> the entrance event, and set the __blk_account_io_start as the exit event.
> 
> # cd /sys/kernel/debug/tracing/
> # echo 0 > ./tracing_on
> # echo 'p read_pages' >> ./kprobe_events
> # echo 'p __blk_account_io_start' >> ./kprobe_events
> # echo 'traceon if comm == "cat"' > ./events/kprobes/p_read_pages_0/trigger
> # echo 'traceoff if comm == "cat"' > ./events/kprobes/p___blk_account_io_start_0/trigger
> # echo 'p bio_add_page arg1=$arg1' >> ./kprobe_events
> # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/p_bio_add_page_0/trigger
> 
> # du -sh /test.txt
> 12.0K   /test.txt
> 
> # cat  /test.txt > /dev/null
> # cat ./trace
> 
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 50/50   #P:1
> #
> #                                _-----=> irqs-off
> #                               / _----=> need-resched
> #                              | / _---=> hardirq/softirq
> #                              || / _--=> preempt-depth
> #                              ||| / _-=> migrate-disable
> #                              |||| /     delay
> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> #              | |         |   |||||     |         |
>              cat-95      [000] .....     1.412065: _raw_spin_unlock_irqrestore <-event_triggers_call object:0xffff888108af6328 value:0x0
>              cat-95      [000] .....     1.412066: __bio_try_merge_page <-bio_add_page object:0xffff888108af6328 value:0x0
>              cat-95      [000] .....     1.412066: __bio_add_page <-bio_add_page object:0xffff888108af6328 value:0x0
>              cat-95      [000] .....     1.412066: rcu_read_unlock_strict <-xa_load object:0xffff888108af6328 value:0x1000
>              cat-95      [000] .....     1.412066: bio_add_page <-ext4_mpage_readpages object:0xffff888108af6328 value:0x1000
>              cat-95      [000] .....     1.412066: kprobe_ftrace_handler <-ftrace_ops_list_func object:0xffff888108af6328 value:0x1000
>              cat-95      [000] .....     1.412067: get_kprobe <-kprobe_ftrace_handler object:0xffff888108af6328 value:0x1000
>              cat-95      [000] .....     1.412067: __bio_try_merge_page <-bio_add_page object:0xffff888108af6328 value:0x1000
>              cat-95      [000] .....     1.412067: __bio_add_page <-bio_add_page object:0xffff888108af6328 value:0x1000
>              cat-95      [000] .....     1.412067: rcu_read_unlock_strict <-xa_load object:0xffff888108af6328 value:0x2000
>              cat-95      [000] .....     1.412067: bio_add_page <-ext4_mpage_readpages object:0xffff888108af6328 value:0x2000
>              cat-95      [000] .....     1.412067: kprobe_ftrace_handler <-ftrace_ops_list_func object:0xffff888108af6328 value:0x2000
>              cat-95      [000] .....     1.412067: get_kprobe <-kprobe_ftrace_handler object:0xffff888108af6328 value:0x2000
>              cat-95      [000] .....     1.412067: __bio_try_merge_page <-bio_add_page object:0xffff888108af6328 value:0x2000
>              cat-95      [000] .....     1.412068: submit_bio <-ext4_mpage_readpages object:0xffff888108af6328 value:0x3000
>              cat-95      [000] .....     1.412068: submit_bio_noacct <-ext4_mpage_readpages object:0xffff888108af6328 value:0x3000
>              cat-95      [000] .....     1.412068: __submit_bio <-submit_bio_noacct object:0xffff888108af6328 value:0x3000
>              cat-95      [000] .....     1.412068: blk_try_enter_queue <-__submit_bio object:0xffff888108af6328 value:0x3000
>              cat-95      [000] .....     1.412068: rcu_read_unlock_strict <-blk_try_enter_queue object:0xffff888108af6328 value:0x3000
>              cat-95      [000] .....     1.412068: rcu_read_unlock_strict <-blk_try_enter_queue object:0xffff888108af6328 value:0x3000
>              cat-95      [000] .....     1.412068: submit_bio_checks <-__submit_bio object:0xffff888108af6328 value:0x3000
>              cat-95      [000] .....     1.412068: __cond_resched <-submit_bio_checks object:0xffff888108af6328 value:0x3000
>              cat-95      [000] .....     1.412068: rcu_all_qs <-__cond_resched object:0xffff888108af6328 value:0x3000
>              cat-95      [000] .....     1.412068: should_fail_bio <-submit_bio_checks object:0xffff888108af6328 value:0x3000
>              cat-95      [000] .....     1.412069: create_task_io_context <-submit_bio_checks object:0xffff888108af6328 value:0x3000
>              cat-95      [000] .....     1.412069: kmem_cache_alloc_node <-create_task_io_context object:0xffff888108af6328 value:0x3000
>              cat-95      [000] .....     1.412069: should_failslab <-kmem_cache_alloc_node object:0xffff888108af6328 value:0x3000
>              cat-95      [000] .....     1.412069: _raw_spin_lock <-create_task_io_context object:0xffff888108af6328 value:0x3000
>              cat-95      [000] .....     1.412069: blk_mq_submit_bio <-__submit_bio object:0xffff888108af6328 value:0x3000
>              cat-95      [000] .....     1.412069: __blk_queue_split <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
>              cat-95      [000] .....     1.412069: bvec_split_segs <-__blk_queue_split object:0xffff888108af6328 value:0x3000
>              cat-95      [000] .....     1.412069: blk_attempt_plug_merge <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
>              cat-95      [000] .....     1.412070: __blk_mq_sched_bio_merge <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
>              cat-95      [000] .....     1.412070: dd_bio_merge <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
>              cat-95      [000] .....     1.412070: _raw_spin_lock <-dd_bio_merge object:0xffff888108af6328 value:0x3000
>              cat-95      [000] .....     1.412070: blk_mq_sched_try_merge <-dd_bio_merge object:0xffff888108af6328 value:0x3000
>              cat-95      [000] .....     1.412070: elv_merge <-blk_mq_sched_try_merge object:0xffff888108af6328 value:0x3000
>              cat-95      [000] .....     1.412070: elv_rqhash_find <-elv_merge object:0xffff888108af6328 value:0x3000
>              cat-95      [000] .....     1.412070: dd_request_merge <-blk_mq_sched_try_merge object:0xffff888108af6328 value:0x3000
>              cat-95      [000] .....     1.412070: elv_rb_find <-dd_request_merge object:0xffff888108af6328 value:0x3000
>              cat-95      [000] .....     1.412070: __blk_mq_alloc_request <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
>              cat-95      [000] .....     1.412071: dd_limit_depth <-__blk_mq_alloc_request object:0xffff888108af6328 value:0x3000
>              cat-95      [000] .....     1.412071: blk_mq_get_tag <-__blk_mq_alloc_request object:0xffff888108af6328 value:0x3000
>              cat-95      [000] .....     1.412071: __blk_mq_get_tag <-blk_mq_get_tag object:0xffff888108af6328 value:0x3000
>              cat-95      [000] .....     1.412071: blk_mq_rq_ctx_init.isra.0 <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
>              cat-95      [000] .....     1.412071: ktime_get <-blk_mq_rq_ctx_init.isra.0 object:0xffff888108af6328 value:0x3000
>              cat-95      [000] .....     1.412071: dd_prepare_request <-blk_mq_rq_ctx_init.isra.0 object:0xffff888108af6328 value:0x3000
>              cat-95      [000] .....     1.412071: __blk_account_io_start <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
>              cat-95      [000] .....     1.412071: kprobe_ftrace_handler <-ftrace_ops_list_func object:0xffff888108af6328 value:0x3000
>              cat-95      [000] .....     1.412071: get_kprobe <-kprobe_ftrace_handler object:0xffff888108af6328 value:0x3000
> 
> Almost all changelogs were suggested by Masami(mhiramat@kernel.org)
> and steve(rostedt@goodmis.org), thank you all so much.
> 
> v7:
> - use fixed-size array for object pool instead of list structure
> - use ftrace_test_recursion_trylock for function trace hook function
> - fix trace_object_ref reference count in the init_trace_object
> - invoke exit_trace_object no matter whether data->ops->free is null 
>   in the unregister_object_trigger
> - release private_data of event_trigger_data in the trace_object_trigger_free
> - remove [RFC] tag
> 
> Note: when change to use the ftrace_test_recursion_trylock, all the functions
> will call the copy_from_kernel_nofault, I don't know where this is the problem now, 
> maybe should fall back to the usage in v6. 
> 
> for example:
> 
> cat-118     [000] ...1.     1.458998: __bio_add_page <-bio_add_page object:0xffff88811a12e9e8 value:0x0
> cat-118     [000] ...2.     1.458998: copy_from_kernel_nofault <-trace_object_events_call object:0xffff88811a12e9e8 value:0x1000
> cat-118     [000] ...2.     1.458998: copy_from_kernel_nofault_allowed <-copy_from_kernel_nofault object:0xffff88811a12e9e8 value:0x1000
> cat-118     [000] ...1.     1.458998: __rcu_read_lock <-xa_load object:0xffff88811a12e9e8 value:0x1000
> cat-118     [000] ...2.     1.458998: copy_from_kernel_nofault <-trace_object_events_call object:0xffff88811a12e9e8 value:0x1000
> cat-118     [000] ...2.     1.458998: copy_from_kernel_nofault_allowed <-copy_from_kernel_nofault object:0xffff88811a12e9e8 value:0x1000
> cat-118     [000] ...1.     1.458998: __rcu_read_unlock <-xa_load object:0xffff88811a12e9e8 value:0x1000
> cat-118     [000] ...3.     1.458998: copy_from_kernel_nofault <-trace_object_events_call object:0xffff88811a12e9e8 value:0x1000
> cat-118     [000] ...3.     1.458998: copy_from_kernel_nofault_allowed <-copy_from_kernel_nofault object:0xffff88811a12e9e8 value:0x1000
> ....

Hmm, this is strange, but I got it is the expected behavior, since the
ftrace_test_recursion_trylock() accepts one stage recursion for the
first event in the interrupt as transition event.
Steve, any good way to limit probing this transition events?


BTW, I tried your series on the 
git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git ftrace/core
and got below build errors.

linux/kernel/trace/trace_object.c:266:3: error: ‘struct event_trigger_ops’ has no member named ‘func’
  266 |  .func   = trace_object_trigger,
      |   ^~~~
linux/kernel/trace/trace_object.c:273:3: error: ‘struct event_trigger_ops’ has no member named ‘func’
  273 |  .func   = trace_object_count_trigger,
      |   ^~~~
linux/kernel/trace/trace_object.c:535:3: error: ‘struct event_command’ has no member named ‘func’
  535 |  .func   = event_object_trigger_callback,
      |   ^~~~
  CC      net/ipv6/sysctl_net_ipv6.o

This is because commit 7d28e1e7d4fa ("tracing: Change event_trigger_ops func() to trigger()")
and commit 4dfe5dff80a4 ("tracing: Change event_command func() to parse()") changed the field
names. Please update it.


Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
