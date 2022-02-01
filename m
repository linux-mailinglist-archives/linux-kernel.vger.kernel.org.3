Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E2B4A595B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 10:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbiBAJjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 04:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234230AbiBAJjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 04:39:39 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D8FC061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 01:39:38 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id o1-20020a1c4d01000000b0034d95625e1fso1397035wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 01:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jC+MMKqg2pjTS0g7yCPjEZpzdCcj2hULqGjeeMav5N4=;
        b=XHPgnnMfc6EQLMJTYv4xh/2PMPoT1+JK1YWqHrkkT0saPPIjLrYtnLmUIkWirZS5UR
         8/aaSn5l6OsSfcWE62e1PK5ALV6aTMgh/GJDJGSDZrNy9VkOWevCtBApsMiXiEitCItF
         jjwVKq/En/DHQIG3oikiHW2JpBveYtIahIdiJVKBZADFsXME1H3ZGd+s/es6oYPhTf+Z
         yXY0i/D+I43c/poLzwP1j+BHvcwWSxyOLZJFMcC0Of3Lg4Z7bJk3rnRBVxv5PFPF0Zhx
         QzqTj5EtBp6b6lfzjq/V8X0D/Eyp2JTfjJ3qd9LIfhfhp07WmQ7HZA1S6G2/JOT6JBLj
         7skw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jC+MMKqg2pjTS0g7yCPjEZpzdCcj2hULqGjeeMav5N4=;
        b=FUzGssWYMdAClHZ0vY+gQosGkLj6RwIbipdZvJ0SBYdZFMTSn3N2JeVgxjze6tSIC/
         7ScIrfGOQvB7BrJo7aiNm5R/+C48Sgfq3fglmIhNdU1QccPwYoetZ3y8Wm6GZtoME02V
         EdxcPaam/tf1cQYS3SLWLJA88fMH3yJBlAWHFskeUCkTOGhUotc8KdsysLtupoC78LcB
         cZUQWteyD1/B2iJksV6iVqTgN5p4l0rEnfCavdAkT+M6ssTUqhVPaywPYY/uLlAUmwPb
         xGJoCGOj2YzMoXM6QELZM3ETmN47AEmnHWGJ1j8NwndBuiKhEP1044QSmmh/9i5yMZv2
         nlSg==
X-Gm-Message-State: AOAM532LWs7ov5FW+MNJnG/waAZdhotPsdFKHB3maKW+yt5bmvfqdaUQ
        gUJKeIiDhdVNaoHq2xuXRIxfIxvP2WNFwXitYsL2nUNXrHg=
X-Google-Smtp-Source: ABdhPJxe6lLgLigaGGbHJEEOG8R00MtC7UJhR7Y6y/porcr2PE7blzHZfBzaXmCAqcNZDH1fSw/E+jKBD6Gd2uec3b8=
X-Received: by 2002:a7b:cb9a:: with SMTP id m26mr1025713wmi.18.1643708377205;
 Tue, 01 Feb 2022 01:39:37 -0800 (PST)
MIME-Version: 1.0
References: <20220130144430.453221-1-xiehuan09@gmail.com> <20220131200247.4c49cc9a6056cc28afa1cd13@kernel.org>
In-Reply-To: <20220131200247.4c49cc9a6056cc28afa1cd13@kernel.org>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Tue, 1 Feb 2022 17:39:26 +0800
Message-ID: <CAEr6+EDBoCPwVEmAW8fqyZPp_VjAgfLXKOVvVNUOdJh+-X84QA@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] trace: Introduce objtrace trigger to trace the
 kernel object
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Mon, Jan 31, 2022 at 7:02 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi Jeff,
>
> Thank you for updating the series, I'm testing the series and found some
> issues. See below;
>
> On Sun, 30 Jan 2022 22:44:26 +0800
> Jeff Xie <xiehuan09@gmail.com> wrote:
>
> > Introduce a method based on function tracer to trace any object and get
> > the value of the object dynamically. the object can be obtained from the
> > dynamic event (kprobe_event/uprobe_event) or the static event(tracepoint).
> >
> > Usage:
> > When using the kprobe event, only need to set the objtrace(a new trigger),
> > we can get the value of the object. The object is from the setting of the
> > kprobe event.
> >
> > For example:
> > For the function bio_add_page():
> >
> > int bio_add_page(struct bio *bio, struct page *page,
> >       unsigned int len, unsigned int offset)
> >
> > Firstly, we can set the base of the object, thus the first string "arg1"
> > stands for the value of the first parameter of this function bio_add_gage(),
> >
> > # echo 'p bio_add_page arg1=$arg1' > ./kprobe_events
> >
> > Secondly, we can get the value dynamically based on above object.
> >
> > find the offset of the bi_size in struct bio:
> > $ gdb vmlinux
> > (gdb) p &(((struct bio *)0)->bi_iter.bi_size)
> > $1 = (unsigned int *) 0x28
> >
> > # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/ \
> >       p_bio_add_page_0/trigger
> >
> > # cd /sys/kernel/debug/tracing/
> > # echo 'p bio_add_page arg1=$arg1' > ./kprobe_events
> > # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/p_bio_add_page_0/trigger
>
> So doing after this command, I dumped the trigger file.
>
> # cat events/kprobes/p_bio_add_page_0/trigger
> objtrace:count=1 if comm == "cat"
>
> This is not correct. All the parameters are dropped. Thus I can not
> remove the trigger without knowing the original command.
>
> # echo '!objtrace:count=1 if comm == "cat"' >> ./events/kprobes/p_bio_add_page_0/trigger
> sh: write error: Invalid argument
>
> And there are another minor issue is here;
>
>  # cd /sys/kernel/debug/tracing/
>  # echo 'p bio_add_page $arg1 $arg2' > ./kprobe_events
>  # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/p_bio_add_page_0/trigger
>  # echo '!objtrace:add:arg2' >> events/kprobes/p_bio_add_page_0/trigger
>
> Here, if I passed the "!objtrace:add:<a-field-exists-on-event>" then the objtrace
> trigger was removed. But as you can see, the parameter is different.
> Anyway, this is a minor issue, since we don't support multiple objtrace trigger
> on the same event.
>
> Could you fix these issues (and update the test case to check this?)

Thanks for finding these issues, I will fix them.

> Thank you,
>
> >
> > # du -sh /test.txt
> > 12.0K   /test.txt
> >
> > # cat  /test.txt > /dev/null
> > # cat ./trace
> > # tracer: nop
> > #
> > # entries-in-buffer/entries-written: 128/128   #P:4
> > #
> > #                                _-----=> irqs-off/BH-disabled
> > #                               / _----=> need-resched
> > #                              | / _---=> hardirq/softirq
> > #                              || / _--=> preempt-depth
> > #                              ||| / _-=> migrate-disable
> > #                              |||| /     delay
> > #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> > #              | |         |   |||||     |         |
> >              cat-117     [002] ...1.     1.602243: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x0
> >              cat-117     [002] ...1.     1.602244: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x0
> >              cat-117     [002] ...2.     1.602244: bio_add_page <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x1000
> >              cat-117     [002] ...1.     1.602245: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x1000
> >              cat-117     [002] ...1.     1.602245: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x1000
> >              cat-117     [002] ...2.     1.602245: bio_add_page <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x2000
> >              cat-117     [002] ...1.     1.602245: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x2000
> >              cat-117     [002] ...1.     1.602245: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x2000
> >              cat-117     [002] ...1.     1.602245: submit_bio <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x3000
> >              cat-117     [002] ...1.     1.602245: submit_bio_noacct <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x3000
> >              cat-117     [002] ...1.     1.602246: __submit_bio <-submit_bio_noacct object:0xffff88811bee4000 value:0x3000
> >              cat-117     [002] ...1.     1.602246: submit_bio_checks <-__submit_bio object:0xffff88811bee4000 value:0x3000
> >              cat-117     [002] ...1.     1.602246: __cond_resched <-submit_bio_checks object:0xffff88811bee4000 value:0x3000
> >              cat-117     [002] ...1.     1.602246: should_fail_bio <-submit_bio_checks object:0xffff88811bee4000 value:0x3000
> >              cat-117     [002] ...1.     1.602246: blk_mq_submit_bio <-submit_bio_noacct object:0xffff88811bee4000 value:0x3000
> >              cat-117     [002] ...1.     1.602246: blk_attempt_plug_merge <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> >              cat-117     [002] ...1.     1.602246: blk_mq_sched_bio_merge <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> >              cat-117     [002] ...1.     1.602247: __rcu_read_lock <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> >              cat-117     [002] ...1.     1.602247: __rcu_read_unlock <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> >              cat-117     [002] ...1.     1.602247: __blk_mq_alloc_requests <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> >           <idle>-0       [002] d..3.     1.602298: bio_endio <-blk_update_request object:0xffff88811bee4000 value:0x0
> >           <idle>-0       [002] d..3.     1.602298: mpage_end_io <-blk_update_request object:0xffff88811bee4000 value:0x0
> >           <idle>-0       [002] d..3.     1.602298: __read_end_io <-blk_update_request object:0xffff88811bee4000 value:0x0
> >           <idle>-0       [002] d..3.     1.602300: bio_put <-blk_update_request object:0xffff88811bee4000 value:0x0
> >           <idle>-0       [002] d..3.     1.602300: bio_free <-blk_update_request object:0xffff88811bee4000 value:0x0
> >           <idle>-0       [002] d..3.     1.602300: mempool_free <-blk_update_request object:0xffff88811bee4000 value:0x0
> >           <idle>-0       [002] d..3.     1.602300: mempool_free_slab <-blk_update_request object:0xffff88811bee4000 value:0x0
> >           <idle>-0       [002] d..3.     1.602300: kmem_cache_free <-blk_update_request object:0xffff88811bee4000 value:0x0
> >         ...
> >
> > Almost all changelogs were suggested by Masami(mhiramat@kernel.org)
> > and steve(rostedt@goodmis.org), thank you all so much.
> >
> > v8:
> > - revert to use per-cpu recursion for the function trace_object_events_call
> > - recover the filter when getting the value of the object
> > - simplify the implementation for the function get_object_value
> > - fix the build error
> >
> > v7:
> > - use fixed-size array for object pool instead of list structure
> > - use ftrace_test_recursion_trylock for function trace hook function
> > - fix trace_object_ref reference count in the init_trace_object
> > - invoke exit_trace_object no matter whether data->ops->free is null
> >   in the unregister_object_trigger
> > - release private_data of event_trigger_data in the trace_object_trigger_free
> > - remove [RFC] tag
> >
> > v6:
> > - change the objtrace trigger syntax.
> > - add patchset description
> > - add <tracefs>/README
> >
> > v5:
> > - add testcasts
> > - add check the field->size
> > - add lockless to search object
> > - describe the object trace more clearly in Kconfig
> >
> > v4:
> > - please ignore the v4 which is the same as v3
> >
> > v3:
> > - change the objfilter to objtrace
> > - add a command to the objfilter syntax
> > - change to get the value of the object
> > - use trace_find_event_field to find the field instead of using argN
> > - get data from @rec in the event trigger callback funciton
> >
> > v2:
> > - adding a "objfilter" trigger to update object
> >
> >
> > Jeff Xie (4):
> >   trace: Add trace any kernel object
> >   trace/objtrace: get the value of the object
> >   trace/objtrace: Add testcases for objtrace
> >   trace/objtrace: Add documentation for objtrace
> >
> >  Documentation/trace/events.rst                |  83 +++
> >  include/linux/trace_events.h                  |   1 +
> >  kernel/trace/Kconfig                          |  10 +
> >  kernel/trace/Makefile                         |   1 +
> >  kernel/trace/trace.c                          |   3 +
> >  kernel/trace/trace.h                          |   8 +
> >  kernel/trace/trace_entries.h                  |  18 +
> >  kernel/trace/trace_events_trigger.c           |   1 +
> >  kernel/trace/trace_object.c                   | 631 ++++++++++++++++++
> >  kernel/trace/trace_output.c                   |  40 ++
> >  .../ftrace/test.d/trigger/trigger-objtrace.tc |  39 ++
> >  11 files changed, 835 insertions(+)
> >  create mode 100644 kernel/trace/trace_object.c
> >  create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc
> >
> > --
> > 2.25.1
> >
>
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>
---
JeffXie
