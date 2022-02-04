Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93B74A92E0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 04:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352716AbiBDD5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 22:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiBDD5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 22:57:04 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC92C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 19:57:03 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id z10-20020a17090acb0a00b001b520826011so11910065pjt.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 19:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nIMDDo/oOFoOIbgCEqXpinHzuSPgUIKl5Ah6XHjbPFQ=;
        b=mC0hLA8d31wdtv0crmhi2xzvBKJws7yuOuG5clkQI8GiWknOeGBt99aDTV3lD5yijG
         irBvHag7zGmn6+e0epJ+UnBFCss557Q6Hs76Fftlmr/3gyrFONlppSlF/S+4NKrZh2aP
         un00PU/7KVeMGtuczB+5WJOU4SvMa1SGMqx5GgYwwo00RYU0gXaLhgNscNjgdqsKu4mg
         VGUwy0Bg8aDCWI5rfM9ld0LM58LS5tN6D0GrwklRmYZ4FublwcD2iJZFPjnN8cBuO0V2
         +44K19jh+MlJEU0LF5MFC3zZrYJdOB1e4NGat3MWTeA9lW+cHJae/cUiVt0/OWrcxWk0
         iXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nIMDDo/oOFoOIbgCEqXpinHzuSPgUIKl5Ah6XHjbPFQ=;
        b=iOzht3OAIdiN8UeFjN3tP2J9U7siSoNNHYOW0UVEvQ6S0CjdDcthp3vFdBIVRZST+4
         d65/FxeIHPqpaPttu6eYThJDQLmm2FL16l/SxL4V8sZKO7W+xSgp4J/XezwnFpu4xtmM
         tQ7eA1i/6MvG89tnHcOWYyzPJvrLfbNIdCpVZ1/0EDjraqMjFTpBajnfpRqKYEyiJaHv
         dWUN8XrMgEnyrrVXjCl852UoMJCEcDFlwSCAg5KMAKCjjNhFAMobU0HXyplcV6/Y0RdG
         JC7kaet0TcuBmBZxa9GcOEgauOLlxH7qBinvd1w3kKUfvU8TnL7ShC5y4R/AONrdTWge
         nGfg==
X-Gm-Message-State: AOAM533xGYJbTm6bRNqGSyq/CRosaDq12v7CNF9mzTot5U0aMDRWgGc1
        Z2GIyeXHvK5ZvSw/PFtzQT0=
X-Google-Smtp-Source: ABdhPJzJvjqywMyzrt7vT8mC06rfgQnjgL9MPES/PKn0Vbb385MjFnfHcUOiBWppXMj/wk8Z6QH62w==
X-Received: by 2002:a17:902:e5c7:: with SMTP id u7mr1143461plf.156.1643947023155;
        Thu, 03 Feb 2022 19:57:03 -0800 (PST)
Received: from localhost.localdomain (li567-56.members.linode.com. [192.155.81.56])
        by smtp.gmail.com with ESMTPSA id 204sm506229pfu.91.2022.02.03.19.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 19:57:01 -0800 (PST)
From:   Jeff Xie <xiehuan09@gmail.com>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, mingo@redhat.com, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, Jeff Xie <xiehuan09@gmail.com>
Subject: [PATCH v9 0/4] trace: Introduce objtrace trigger to trace the kernel object
Date:   Fri,  4 Feb 2022 11:56:40 +0800
Message-Id: <20220204035644.734878-1-xiehuan09@gmail.com>
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
 kernel/trace/trace_object.c                   | 676 ++++++++++++++++++
 kernel/trace/trace_output.c                   |  40 ++
 .../ftrace/test.d/trigger/trigger-objtrace.tc |  41 ++
 11 files changed, 882 insertions(+)
 create mode 100644 kernel/trace/trace_object.c
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc

-- 
2.25.1

