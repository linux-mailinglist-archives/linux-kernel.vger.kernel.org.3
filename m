Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E854774F4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 15:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237402AbhLPOuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 09:50:24 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38006 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhLPOuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 09:50:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D1CAB82472
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 14:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE927C36AE4;
        Thu, 16 Dec 2021 14:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639666221;
        bh=xZrauJh2IY5xIJLV7v4Oh13Pn/4wOk7aDxjuol394FA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f0EhaLiLO9pwAE824WWyk6TkZn3QX33GyOAyNLw8hI0dnMLbIW+9dbV4hpLoakXOr
         GLGvEC5qIFQnruP5oBZ+vR9IKm8JMQsJnh+5DXFLt6d5rwlIUMJGCmG0KfjuAxyXqB
         Nh7kzzzW5XoHLf3SYORytDxT1KutoiEPU6LTVgBicO0z9ff2wGCmTbZNa7XNgVSW3D
         4/Ds/5EidUT8q67kmxbqytzoJxJop8tTJhziZrDGjShfblrS5Tw8KckHg9w71EXX6F
         eS40Bj0v+5HdYl/ZJtrM2ENXrOwQQeMlZm2zOCiQV/MATgJ1bUPn1yg5/fESsCd3CP
         KX5yLtuCiz6dA==
Date:   Thu, 16 Dec 2021 23:50:17 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mingo@redhat.com,
        zanussi@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH v6 0/5] trace: Introduce objtrace trigger to trace
 the kernel object
Message-Id: <20211216235017.97f0769a63d2c478562d39a4@kernel.org>
In-Reply-To: <20211129164951.220511-1-xiehuan09@gmail.com>
References: <20211129164951.220511-1-xiehuan09@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On Tue, 30 Nov 2021 00:49:46 +0800
Jeff Xie <xiehuan09@gmail.com> wrote:

> Introduce a method based on function tracer to trace any object and get
> the value of the object dynamically. the object can be obtained from the
> dynamic event (kprobe_event/uprobe_event) or the static event(tracepoint).

Now you can remove [RFC] tag from this series, I think.
And can you also add a changelog (short description of the changes) from
the previous version, so that reviewers can find the difference
point easily? Unless that, I need to make a diff from your previous version. :(

Thank you,

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
> Jeff Xie (5):
>   trace: Add trace any kernel object
>   trace/objtrace: get the value of the object
>   trace/README: Document objtrace trigger syntax
>   trace/objtrace: Add testcases for objtrace
>   trace/objtrace: Add documentation for objtrace
> 
>  Documentation/trace/events.rst                | 114 +++
>  include/linux/trace_events.h                  |   1 +
>  kernel/trace/Kconfig                          |  10 +
>  kernel/trace/Makefile                         |   1 +
>  kernel/trace/trace.c                          |   3 +
>  kernel/trace/trace.h                          |   8 +
>  kernel/trace/trace_entries.h                  |  18 +
>  kernel/trace/trace_events_trigger.c           |   1 +
>  kernel/trace/trace_object.c                   | 660 ++++++++++++++++++
>  kernel/trace/trace_output.c                   |  40 ++
>  .../ftrace/test.d/trigger/trigger-objtrace.tc |  39 ++
>  11 files changed, 895 insertions(+)
>  create mode 100644 kernel/trace/trace_object.c
>  create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc
> 
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
