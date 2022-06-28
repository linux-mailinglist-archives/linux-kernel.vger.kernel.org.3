Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B3C55E79D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347510AbiF1O4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 10:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347507AbiF1O42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:56:28 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C3231904
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 07:56:26 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 68so12436537pgb.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 07:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dWIzlpWwWGnY09oDVpwv77o8URPKI5G4En6owqepYpY=;
        b=Xhy77KMLmnuHFDEF23wu5eXlLZCpQYFKOXoO2FhXYEnQMBlFQC53CVVM3eKpxNNZ88
         /Egph1yEfnJgo+a+PbEGS0PnYP/ZyQuIl3JWd35xSTJdDoNNjdpulegud+VMDd/lSnzO
         hCAt/wRkJx7UTZW0duoY06LqyCXCaJBmMjr87E2wGr5RjBjxmUTqeqe/57ifa7RS3twx
         1oQLCn1ZesF1It4cmzC0mlUImWbwyCTngxjhVW+Dq9q9X4U7bTjIOT5n/MAWreE8xi92
         KWEQDeNd0pMjbjmaYUmxzSzowSa+nTL3+FwQ4P2sG41/B9kKwlahYUw1zTAtBOPNdt9x
         fTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dWIzlpWwWGnY09oDVpwv77o8URPKI5G4En6owqepYpY=;
        b=XaqCYPDW7LICfBeUP6MuxaeJXcNaNBIJ19E40+gMVcfs/foPTcr+8+6xX61Mnueve4
         Gl09HfvAfrO6Jip3KpBkRGQJbRUVNWXtDYF42xklFJxRYFgZmraNr38zz+CppW2FCBKk
         IMRbeCqsR+2+UGUsdTZEHhysqSljEyWNGiKcwlCAcdGqHfyF8GeSq2tNtwOJbIMVasXR
         cmh3TJwEO1igun9yiO2l8JUyp2qyP1F+v9fJxchpLx3GSfsNVZQtZg/i+sIraqbyxmk4
         Z5HGyKlnEG6DSes5vbJZynG4pwA0jib1oyaYDBJU8aszYyEuB9jjQVZMphB14q0lckW5
         68ig==
X-Gm-Message-State: AJIora8n03sw5R/6G0wOGp6GhZQIbYdNyc4V20nSYurYPqhu8HM3JvRh
        ZX/+eeBhqjsCYYXlug2IXtGi86z+GlDFuw==
X-Google-Smtp-Source: AGRyM1tXSYwa3mLh4mCJFaQc4Rz8b6Ta4mZVr6W7bwHtrBvxo915WwOHKOOY1w36a9yB/Rkm9PAh0A==
X-Received: by 2002:aa7:8b51:0:b0:525:5132:8a84 with SMTP id i17-20020aa78b51000000b0052551328a84mr4091005pfd.45.1656428186050;
        Tue, 28 Jun 2022 07:56:26 -0700 (PDT)
Received: from localhost.localdomain (li567-56.members.linode.com. [192.155.81.56])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090341d100b0016909678e2csm9502549ple.292.2022.06.28.07.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 07:56:25 -0700 (PDT)
From:   Jeff Xie <xiehuan09@gmail.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, mhiramat@kernel.org, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, chensong_2000@189.cn,
        Jeff Xie <xiehuan09@gmail.com>
Subject: [PATCH v14 0/4] trace: Introduce objtrace trigger to trace the kernel object
Date:   Tue, 28 Jun 2022 22:55:48 +0800
Message-Id: <20220628145552.349839-1-xiehuan09@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

v14:
- make documentation more readable and fix literal code block by Bagas Sanjaya

v13:
- remove the 's' type, since the objtrace event doesn't show the value with sign
- change the [3/4] tag with 'selftests/ftrace' instead of 'trace/objtrace'
- add 'Documentation:' tag for [4/4]

v12:
- use the %zu to print the sizeof
  Reported-by: kernel test robot <lkp@intel.com>
  Suggested-by: Nathan Chancellor <nathan@kernel.org>

v11:
- remove useless atomic counting methods for num_traced_obj
- make array objtrace_fetch_types null terminated
- add raw_spin_lock_init for obj_data_lock

v10:
- support ftrace instances
- use trace_buffer_lock_reserve instead of trace_event_buffer_lock_reserve
- a lot of cleanup work has been done mainly for event_object_trigger_parse

v9:
- fix objtrace trigger output was incomplete
- fix the objtrace trigger was removed when using the existed parameter on
  event.
- add testcase for the second fix above.

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
  trace/objtrace: Get the value of the object
  selftests/ftrace: Add testcases for objtrace
  Documentation: trace/objtrace: Add documentation for objtrace

 Documentation/trace/events.rst                |  87 +++
 include/linux/trace_events.h                  |   1 +
 kernel/trace/Kconfig                          |  10 +
 kernel/trace/Makefile                         |   1 +
 kernel/trace/trace.c                          |  11 +
 kernel/trace/trace.h                          |  21 +
 kernel/trace/trace_entries.h                  |  18 +
 kernel/trace/trace_events_trigger.c           |   5 +-
 kernel/trace/trace_object.c                   | 611 ++++++++++++++++++
 kernel/trace/trace_output.c                   |  40 ++
 .../ftrace/test.d/trigger/trigger-objtrace.tc |  41 ++
 11 files changed, 844 insertions(+), 2 deletions(-)
 create mode 100644 kernel/trace/trace_object.c
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc


base-commit: 408d26e261b089596c0837e71d2fb4a80ea04ef3
-- 
2.25.1

