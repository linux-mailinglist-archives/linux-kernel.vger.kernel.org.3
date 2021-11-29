Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F294621FA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 21:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbhK2UTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 15:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbhK2UQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 15:16:22 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40780C06FD4B
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 08:50:13 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id k4so12644694plx.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 08:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6FNTZ5hAlPiemTuXVFkR5v0W6Kq15WxJz69Z0MwRIcY=;
        b=U9MH0RALNuAt4C5WvRiUyCaU7CzaO7riVDL0APVDqewnb7Drk8o8bEbRnsSyLfPfFE
         URBG0kWd47n2FcKiyKyzQN6U9RSSw6zytqBBENGck0vK1eXxS/JQQ1HOBRUocurG5Oej
         25Uw7C0jIRhnpXgK6p7V3Iw/WOPIPlgUY/ej02Hbf2oavIu3YGYcu0pPZnx6lWuCDXRR
         pqrq0XA1gAh0VqFIFivJrJG4r5LHM3UZMKuo6f55Cu1/ctSuD4Di7IFXv6R82I5Waqk1
         Tc/CAtx9OvKZG6Y/OXOEnJcFMph5v5gsfsTnOnyWFvXAps6f2CQ4HU61QTzwA8vBwWTW
         hNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6FNTZ5hAlPiemTuXVFkR5v0W6Kq15WxJz69Z0MwRIcY=;
        b=cHS8ac8yhVUj76BhQt5QcPO18aTtTukkQBJJmZwiGIF6KhQbPdSjk7M6BuDMjF7gg2
         gz9kmRPId6V0Wrmq2RApYDa0T/DqgDh4tfvneHcUAGRvW8iE3cvko47jAZQFhLy8b2li
         R5bo1Jd2IIX+kdcQ8FAdSQujfY9tOzdp5tEO3j6FKpCOJEbQlU/7y5Zwg5yQj6tBGQdR
         DuzwYPHkJZvKNmPH+1s01XAyX8/Of1+6b0lh1AI4nx46JmKuSI2N9bhmKR6UAcBhHQyO
         exsRioCY5JC/TJBga9gC6jrcMHBJNMCIuIGer7lrbFpwPrhxcoAFe3NDjD6RcdOoTdlO
         VQiw==
X-Gm-Message-State: AOAM533fkfK2YD5nflcTDaTimiDiQ3wvGcOo+gHBivWfD476l9ETJfZ6
        kelKQ8EeGTFTmpn79yerPD0=
X-Google-Smtp-Source: ABdhPJz9/rqi8O99294BJ5nCdPPMofrB0o4aLXEZm/jL/ysM59oUEVEG/9eCJP/Gg2T5JoQup9TH7g==
X-Received: by 2002:a17:902:6506:b0:143:84c4:6555 with SMTP id b6-20020a170902650600b0014384c46555mr61835738plk.8.1638204612773;
        Mon, 29 Nov 2021 08:50:12 -0800 (PST)
Received: from localhost.localdomain (li567-56.members.linode.com. [192.155.81.56])
        by smtp.gmail.com with ESMTPSA id mr2sm14044211pjb.25.2021.11.29.08.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 08:50:12 -0800 (PST)
From:   Jeff Xie <xiehuan09@gmail.com>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, mingo@redhat.com, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, Jeff Xie <xiehuan09@gmail.com>
Subject: [RFC][PATCH v6 0/5] trace: Introduce objtrace trigger to trace the kernel object
Date:   Tue, 30 Nov 2021 00:49:46 +0800
Message-Id: <20211129164951.220511-1-xiehuan09@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a method based on function tracer to trace any object and get
the value of the object dynamically. the object can be obtained from the
dynamic event (kprobe_event/uprobe_event) or the static event(tracepoint).

Usage:
When using the kprobe event, only need to set the objtrace(a new trigger),
we can get the value of the object. The object is from the setting of the 
kprobe event.

For example:
For the function bio_add_page():

int bio_add_page(struct bio *bio, struct page *page,
	unsigned int len, unsigned int offset)

Firstly, we can set the base of the object, thus the first string "arg1"
stands for the value of the first parameter of this function bio_add_gage(),

# echo 'p bio_add_page arg1=$arg1' >> ./kprobe_events

Secondly, we can get the value dynamically base the above object. 

find the offset of the bi_size in struct bio:
$ gdb vmlinux
(gdb) p &(((struct bio *)0)->bi_iter.bi_size)
$1 = (unsigned int *) 0x28

# echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/ \
	p_bio_add_page_0/trigger

The best way to use this is that we can set the entrance event and exit
event, for example, the following example is to set the read_papes as
the entrance event, and set the __blk_account_io_start as the exit event.

# cd /sys/kernel/debug/tracing/
# echo 0 > ./tracing_on
# echo 'p read_pages' >> ./kprobe_events
# echo 'p __blk_account_io_start' >> ./kprobe_events
# echo 'traceon if comm == "cat"' > ./events/kprobes/p_read_pages_0/trigger
# echo 'traceoff if comm == "cat"' > ./events/kprobes/p___blk_account_io_start_0/trigger
# echo 'p bio_add_page arg1=$arg1' >> ./kprobe_events
# echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/p_bio_add_page_0/trigger

# du -sh /test.txt
12.0K   /test.txt

# cat  /test.txt > /dev/null
# cat ./trace

# tracer: nop
#
# entries-in-buffer/entries-written: 50/50   #P:1
#
#                                _-----=> irqs-off
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
             cat-95      [000] .....     1.412065: _raw_spin_unlock_irqrestore <-event_triggers_call object:0xffff888108af6328 value:0x0
             cat-95      [000] .....     1.412066: __bio_try_merge_page <-bio_add_page object:0xffff888108af6328 value:0x0
             cat-95      [000] .....     1.412066: __bio_add_page <-bio_add_page object:0xffff888108af6328 value:0x0
             cat-95      [000] .....     1.412066: rcu_read_unlock_strict <-xa_load object:0xffff888108af6328 value:0x1000
             cat-95      [000] .....     1.412066: bio_add_page <-ext4_mpage_readpages object:0xffff888108af6328 value:0x1000
             cat-95      [000] .....     1.412066: kprobe_ftrace_handler <-ftrace_ops_list_func object:0xffff888108af6328 value:0x1000
             cat-95      [000] .....     1.412067: get_kprobe <-kprobe_ftrace_handler object:0xffff888108af6328 value:0x1000
             cat-95      [000] .....     1.412067: __bio_try_merge_page <-bio_add_page object:0xffff888108af6328 value:0x1000
             cat-95      [000] .....     1.412067: __bio_add_page <-bio_add_page object:0xffff888108af6328 value:0x1000
             cat-95      [000] .....     1.412067: rcu_read_unlock_strict <-xa_load object:0xffff888108af6328 value:0x2000
             cat-95      [000] .....     1.412067: bio_add_page <-ext4_mpage_readpages object:0xffff888108af6328 value:0x2000
             cat-95      [000] .....     1.412067: kprobe_ftrace_handler <-ftrace_ops_list_func object:0xffff888108af6328 value:0x2000
             cat-95      [000] .....     1.412067: get_kprobe <-kprobe_ftrace_handler object:0xffff888108af6328 value:0x2000
             cat-95      [000] .....     1.412067: __bio_try_merge_page <-bio_add_page object:0xffff888108af6328 value:0x2000
             cat-95      [000] .....     1.412068: submit_bio <-ext4_mpage_readpages object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412068: submit_bio_noacct <-ext4_mpage_readpages object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412068: __submit_bio <-submit_bio_noacct object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412068: blk_try_enter_queue <-__submit_bio object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412068: rcu_read_unlock_strict <-blk_try_enter_queue object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412068: rcu_read_unlock_strict <-blk_try_enter_queue object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412068: submit_bio_checks <-__submit_bio object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412068: __cond_resched <-submit_bio_checks object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412068: rcu_all_qs <-__cond_resched object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412068: should_fail_bio <-submit_bio_checks object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412069: create_task_io_context <-submit_bio_checks object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412069: kmem_cache_alloc_node <-create_task_io_context object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412069: should_failslab <-kmem_cache_alloc_node object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412069: _raw_spin_lock <-create_task_io_context object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412069: blk_mq_submit_bio <-__submit_bio object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412069: __blk_queue_split <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412069: bvec_split_segs <-__blk_queue_split object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412069: blk_attempt_plug_merge <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412070: __blk_mq_sched_bio_merge <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412070: dd_bio_merge <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412070: _raw_spin_lock <-dd_bio_merge object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412070: blk_mq_sched_try_merge <-dd_bio_merge object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412070: elv_merge <-blk_mq_sched_try_merge object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412070: elv_rqhash_find <-elv_merge object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412070: dd_request_merge <-blk_mq_sched_try_merge object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412070: elv_rb_find <-dd_request_merge object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412070: __blk_mq_alloc_request <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412071: dd_limit_depth <-__blk_mq_alloc_request object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412071: blk_mq_get_tag <-__blk_mq_alloc_request object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412071: __blk_mq_get_tag <-blk_mq_get_tag object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412071: blk_mq_rq_ctx_init.isra.0 <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412071: ktime_get <-blk_mq_rq_ctx_init.isra.0 object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412071: dd_prepare_request <-blk_mq_rq_ctx_init.isra.0 object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412071: __blk_account_io_start <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412071: kprobe_ftrace_handler <-ftrace_ops_list_func object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412071: get_kprobe <-kprobe_ftrace_handler object:0xffff888108af6328 value:0x3000

Jeff Xie (5):
  trace: Add trace any kernel object
  trace/objtrace: get the value of the object
  trace/README: Document objtrace trigger syntax
  trace/objtrace: Add testcases for objtrace
  trace/objtrace: Add documentation for objtrace

 Documentation/trace/events.rst                | 114 +++
 include/linux/trace_events.h                  |   1 +
 kernel/trace/Kconfig                          |  10 +
 kernel/trace/Makefile                         |   1 +
 kernel/trace/trace.c                          |   3 +
 kernel/trace/trace.h                          |   8 +
 kernel/trace/trace_entries.h                  |  18 +
 kernel/trace/trace_events_trigger.c           |   1 +
 kernel/trace/trace_object.c                   | 660 ++++++++++++++++++
 kernel/trace/trace_output.c                   |  40 ++
 .../ftrace/test.d/trigger/trigger-objtrace.tc |  39 ++
 11 files changed, 895 insertions(+)
 create mode 100644 kernel/trace/trace_object.c
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc

-- 
2.25.1

