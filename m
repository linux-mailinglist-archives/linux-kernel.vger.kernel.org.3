Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2DD48D033
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 02:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbiAMBix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 20:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbiAMBis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 20:38:48 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874F2C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 17:38:48 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id l8so7281732plt.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 17:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TVOkc6C/HHWyW0SqNnXqUVaU6yrcsfE4Kj4zwpH+HYk=;
        b=AjCRb209//xjhpcSOY1r398v0O0Jim6WfUGgcYyXKRoOjO0VJ2YUjXWuOPAgqaf1iz
         92xGEvy3/Vzm7efIYKFMfaxeU0ZVosiGvv/8EFUduKBkoZWEGaPXlwhL+parHywrC2yL
         LCn4rWX7tsx8QPWAZoJYRw2s7LviIqvFrPeSWdT0t/NjepPrwYF+KwVsbKmSh/oV1aPb
         EPvvoZvAxTr6n5qLLTlnRczktwO8buZMOusduWjGVumLD4YnNAw3ooJOhF1EcBzhQGBv
         FHdyak3oj8D79V3H+MEBdfhMUa2hjmH47MQ6DQJntQYGt7fCoQzHr2wyYEHR8BBcbWx+
         t1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TVOkc6C/HHWyW0SqNnXqUVaU6yrcsfE4Kj4zwpH+HYk=;
        b=rx7AGvySdcxU2IAgvS2CfyZ87AfufMZus/ToWOEj6LgIOMs1wsZlWva7LK3SyvkNXj
         8w8oZP3nw30gOAo6TB9ajFzDNrR6LkDgWDQYFEAYw74fI/jwKkxKXaI33RhxDav15Y9v
         K4VYyKNqdokhAF2sGjCn8PMOjzgENaG4iwJK5QkCBZKw2XddIsGFszzWQMATwC8VRd2w
         7fNZiDE+SrhhfVFXCENzYU/LUTXwi2fBnnFeSpBG/5krnVFH8ImCI03W+nXn9daw4cYc
         +35rKU3nyAqwDNJBrnQbsVDMrP4Lx9cmIgozxuVV3BAC3ybQiFwJHp14/AKbJJjJlAK3
         qwZA==
X-Gm-Message-State: AOAM531Z0CM5kcjfWsKDM6LOnipviCw4qI1eEq0V0XNiVEqEzlQnt9AU
        fJtJZJsClzUcf67SocSof1w=
X-Google-Smtp-Source: ABdhPJwJjxZcc09y+UP6TVq68KNyrY2Sl/hSIE1zDuqaVKk6/bN6nmEEJ/dT5qnR0BUCFAqlocq1kA==
X-Received: by 2002:a05:6a00:a20:b0:4bb:95f6:93b3 with SMTP id p32-20020a056a000a2000b004bb95f693b3mr2068576pfh.77.1642037928066;
        Wed, 12 Jan 2022 17:38:48 -0800 (PST)
Received: from localhost.localdomain (li567-56.members.linode.com. [192.155.81.56])
        by smtp.gmail.com with ESMTPSA id b4sm799990pfl.101.2022.01.12.17.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 17:38:47 -0800 (PST)
From:   Jeff Xie <xiehuan09@gmail.com>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, mingo@redhat.com, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, Jeff Xie <xiehuan09@gmail.com>
Subject: [PATCH v7 0/4] trace: Introduce objtrace trigger to trace the kernel object
Date:   Thu, 13 Jan 2022 09:38:31 +0800
Message-Id: <20220113013835.503285-1-xiehuan09@gmail.com>
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

Almost all changelogs were suggested by Masami(mhiramat@kernel.org)
and steve(rostedt@goodmis.org), thank you all so much.

v7:
- use fixed-size array for object pool instead of list structure
- use ftrace_test_recursion_trylock for function trace hook function
- fix trace_object_ref reference count in the init_trace_object
- invoke exit_trace_object no matter whether data->ops->free is null 
  in the unregister_object_trigger
- release private_data of event_trigger_data in the trace_object_trigger_free
- remove [RFC] tag

Note: when change to use the ftrace_test_recursion_trylock, all the functions
will call the copy_from_kernel_nofault, I don't know where this is the problem now, 
maybe should fall back to the usage in v6. 

for example:

cat-118     [000] ...1.     1.458998: __bio_add_page <-bio_add_page object:0xffff88811a12e9e8 value:0x0
cat-118     [000] ...2.     1.458998: copy_from_kernel_nofault <-trace_object_events_call object:0xffff88811a12e9e8 value:0x1000
cat-118     [000] ...2.     1.458998: copy_from_kernel_nofault_allowed <-copy_from_kernel_nofault object:0xffff88811a12e9e8 value:0x1000
cat-118     [000] ...1.     1.458998: __rcu_read_lock <-xa_load object:0xffff88811a12e9e8 value:0x1000
cat-118     [000] ...2.     1.458998: copy_from_kernel_nofault <-trace_object_events_call object:0xffff88811a12e9e8 value:0x1000
cat-118     [000] ...2.     1.458998: copy_from_kernel_nofault_allowed <-copy_from_kernel_nofault object:0xffff88811a12e9e8 value:0x1000
cat-118     [000] ...1.     1.458998: __rcu_read_unlock <-xa_load object:0xffff88811a12e9e8 value:0x1000
cat-118     [000] ...3.     1.458998: copy_from_kernel_nofault <-trace_object_events_call object:0xffff88811a12e9e8 value:0x1000
cat-118     [000] ...3.     1.458998: copy_from_kernel_nofault_allowed <-copy_from_kernel_nofault object:0xffff88811a12e9e8 value:0x1000
....

v6:
- change the objtrace trigger syntax.
- add patchset description
- add <tracefs>/README

v5:
- add testcasts
- add check the field->size
- add lockless to search object
- describe the object trace more clearly in Kconfig

v4:
- please ignore the v4 which is the same as v3

v3:
- change the objfilter to objtrace
- add a command to the objfilter syntax
- change to get the value of the object
- use trace_find_event_field to find the field instead of using argN
- get data from @rec in the event trigger callback funciton

v2:
- adding a "objfilter" trigger to update object

Jeff Xie (4):
  trace: Add trace any kernel object
  trace/objtrace: get the value of the object
  trace/objtrace: Add testcases for objtrace
  trace/objtrace: Add documentation for objtrace

 Documentation/trace/events.rst                | 114 ++++
 include/linux/trace_events.h                  |   1 +
 kernel/trace/Kconfig                          |  10 +
 kernel/trace/Makefile                         |   1 +
 kernel/trace/trace.c                          |   3 +
 kernel/trace/trace.h                          |   8 +
 kernel/trace/trace_entries.h                  |  18 +
 kernel/trace/trace_events_trigger.c           |   1 +
 kernel/trace/trace_object.c                   | 594 ++++++++++++++++++
 kernel/trace/trace_output.c                   |  40 ++
 .../ftrace/test.d/trigger/trigger-objtrace.tc |  39 ++
 11 files changed, 829 insertions(+)
 create mode 100644 kernel/trace/trace_object.c
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc

-- 
2.25.1

