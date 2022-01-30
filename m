Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F524A36D2
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 15:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355088AbiA3Oot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 09:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355079AbiA3Oor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 09:44:47 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6A1C061714
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 06:44:46 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id x11so10308423plg.6
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 06:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n3io5VKKGuFMBN4a01O3uaQQYYIRHnrz3fOPIAGRG8A=;
        b=DhPc1yBvjxa8pPJ7HPYrLqnl8WwLT/JiVhyz9PMwQebV6xjoWd+cx2P+nVbwMhdvQB
         o/qD8yh4DcQSroIZ2XKz5o5ngDq8UD6ggzNznv4EUt073r4zTlXKZYkp51SjWWPOPQ84
         Jk3e1tpJYyPDy0FMfKpDSpzlJOG3XBJPa8twebMK777r6qzeInf1ojQ2Sy5gxj5fNfFL
         EXxPVmjE2CTsnZnLlpriyfgP2sP+0NZrPKDyLVhRAkfitGBpzS8CAZHSxoV1mfBYqtqR
         XQQmaFHahaJzXZ1vovfd1F5PXJqssZLNi6wejYQck5nVguH1hiYhxioG1zPaLEUYnc4o
         LWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n3io5VKKGuFMBN4a01O3uaQQYYIRHnrz3fOPIAGRG8A=;
        b=kA2e0BozqmQiCz0lgFEGWAnmfCoxJbYT+r7/9jIFAyFykJNU+BUgY07qh5uyvgI2zH
         aXC8ZCYd9anBB2S0/x4T+YymzQUZY1wx07d0aaf87HcQILXfiQLD7Zshc4qxpwivr6w6
         7+SCvlODzEjw2CWJOGdYMcg1rCpFg4vgmkuErjgI2M3zfeaqGORjGY1hJzoSfnmqztIy
         IfFLchzGbL4LwhuvCJfLjqEilto25UILLefbvaeP/4+Uxf2KcfEoCn1NWZjAdmkqaUJ4
         LBwqGtRNV8fkxPC2dyVbgmO4QM2OJe/XT/q2w4raivI7lBYcAUwEkju3Xx8HTw9vrdtp
         LLug==
X-Gm-Message-State: AOAM531GwTmLgpF9Lw+u+2qEJScrfTCx0REUFPPlUK/q+dIFJkYZEyM4
        tMK2H9esKZeegBPYrGESjmjmm/3UCIo=
X-Google-Smtp-Source: ABdhPJwsIP+FWQ6zgc9vlBdrvS5tMna7qm8zDS+0G1xIuBXre0uvgffTNJWHYDzBf8YjsPkVgWed/w==
X-Received: by 2002:a17:902:d2c7:: with SMTP id n7mr16497828plc.35.1643553885662;
        Sun, 30 Jan 2022 06:44:45 -0800 (PST)
Received: from localhost.localdomain (li567-56.members.linode.com. [192.155.81.56])
        by smtp.gmail.com with ESMTPSA id w8sm10502126pfu.128.2022.01.30.06.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 06:44:44 -0800 (PST)
From:   Jeff Xie <xiehuan09@gmail.com>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, mingo@redhat.com, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, Jeff Xie <xiehuan09@gmail.com>
Subject: [PATCH v8 0/4] trace: Introduce objtrace trigger to trace the kernel object
Date:   Sun, 30 Jan 2022 22:44:26 +0800
Message-Id: <20220130144430.453221-1-xiehuan09@gmail.com>
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

# echo 'p bio_add_page arg1=$arg1' > ./kprobe_events

Secondly, we can get the value dynamically based on above object. 

find the offset of the bi_size in struct bio:
$ gdb vmlinux
(gdb) p &(((struct bio *)0)->bi_iter.bi_size)
$1 = (unsigned int *) 0x28

# echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/ \
	p_bio_add_page_0/trigger

# cd /sys/kernel/debug/tracing/
# echo 'p bio_add_page arg1=$arg1' > ./kprobe_events
# echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/p_bio_add_page_0/trigger

# du -sh /test.txt
12.0K   /test.txt

# cat  /test.txt > /dev/null
# cat ./trace
# tracer: nop
#
# entries-in-buffer/entries-written: 128/128   #P:4
#
#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
             cat-117     [002] ...1.     1.602243: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x0
             cat-117     [002] ...1.     1.602244: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x0
             cat-117     [002] ...2.     1.602244: bio_add_page <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x1000
             cat-117     [002] ...1.     1.602245: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x1000
             cat-117     [002] ...1.     1.602245: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x1000
             cat-117     [002] ...2.     1.602245: bio_add_page <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x2000
             cat-117     [002] ...1.     1.602245: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x2000
             cat-117     [002] ...1.     1.602245: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x2000
             cat-117     [002] ...1.     1.602245: submit_bio <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x3000
             cat-117     [002] ...1.     1.602245: submit_bio_noacct <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x3000
             cat-117     [002] ...1.     1.602246: __submit_bio <-submit_bio_noacct object:0xffff88811bee4000 value:0x3000
             cat-117     [002] ...1.     1.602246: submit_bio_checks <-__submit_bio object:0xffff88811bee4000 value:0x3000
             cat-117     [002] ...1.     1.602246: __cond_resched <-submit_bio_checks object:0xffff88811bee4000 value:0x3000
             cat-117     [002] ...1.     1.602246: should_fail_bio <-submit_bio_checks object:0xffff88811bee4000 value:0x3000
             cat-117     [002] ...1.     1.602246: blk_mq_submit_bio <-submit_bio_noacct object:0xffff88811bee4000 value:0x3000
             cat-117     [002] ...1.     1.602246: blk_attempt_plug_merge <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
             cat-117     [002] ...1.     1.602246: blk_mq_sched_bio_merge <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
             cat-117     [002] ...1.     1.602247: __rcu_read_lock <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
             cat-117     [002] ...1.     1.602247: __rcu_read_unlock <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
             cat-117     [002] ...1.     1.602247: __blk_mq_alloc_requests <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
          <idle>-0       [002] d..3.     1.602298: bio_endio <-blk_update_request object:0xffff88811bee4000 value:0x0
          <idle>-0       [002] d..3.     1.602298: mpage_end_io <-blk_update_request object:0xffff88811bee4000 value:0x0
          <idle>-0       [002] d..3.     1.602298: __read_end_io <-blk_update_request object:0xffff88811bee4000 value:0x0
          <idle>-0       [002] d..3.     1.602300: bio_put <-blk_update_request object:0xffff88811bee4000 value:0x0
          <idle>-0       [002] d..3.     1.602300: bio_free <-blk_update_request object:0xffff88811bee4000 value:0x0
          <idle>-0       [002] d..3.     1.602300: mempool_free <-blk_update_request object:0xffff88811bee4000 value:0x0
          <idle>-0       [002] d..3.     1.602300: mempool_free_slab <-blk_update_request object:0xffff88811bee4000 value:0x0
          <idle>-0       [002] d..3.     1.602300: kmem_cache_free <-blk_update_request object:0xffff88811bee4000 value:0x0
	  ...

Almost all changelogs were suggested by Masami(mhiramat@kernel.org)
and steve(rostedt@goodmis.org), thank you all so much.

v8:
- revert to use per-cpu recursion for the function trace_object_events_call
- recover the filter when getting the value of the object
- simplify the implementation for the function get_object_value
- fix the build error

v7:
- use fixed-size array for object pool instead of list structure
- use ftrace_test_recursion_trylock for function trace hook function
- fix trace_object_ref reference count in the init_trace_object
- invoke exit_trace_object no matter whether data->ops->free is null 
  in the unregister_object_trigger
- release private_data of event_trigger_data in the trace_object_trigger_free
- remove [RFC] tag

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

 Documentation/trace/events.rst                |  83 +++
 include/linux/trace_events.h                  |   1 +
 kernel/trace/Kconfig                          |  10 +
 kernel/trace/Makefile                         |   1 +
 kernel/trace/trace.c                          |   3 +
 kernel/trace/trace.h                          |   8 +
 kernel/trace/trace_entries.h                  |  18 +
 kernel/trace/trace_events_trigger.c           |   1 +
 kernel/trace/trace_object.c                   | 631 ++++++++++++++++++
 kernel/trace/trace_output.c                   |  40 ++
 .../ftrace/test.d/trigger/trigger-objtrace.tc |  39 ++
 11 files changed, 835 insertions(+)
 create mode 100644 kernel/trace/trace_object.c
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc

-- 
2.25.1

