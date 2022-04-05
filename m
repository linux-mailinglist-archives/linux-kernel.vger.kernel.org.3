Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A064F4B34
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573964AbiDEWxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573640AbiDET1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:27:47 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C55EBD7C6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 12:25:48 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id 14so286478ily.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 12:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u+T3NU6QNFkOQKHYYcZy7EJ0pKJCkBa9x+ezT/MG77s=;
        b=fHGI43HnzKEaZ07fIjKBZkHadZt8X8koXagtbSwmRMHFHmPgl9iQmJnTwHdQkVFRcO
         GU46qvE9L5+uBxPExQk4gtIc5KvuEeUYhLhWLcZ36mJgUc5Fk0FlnOoPz0BKzSuT+nJl
         64Qeom+Zf9OtQ1GOxzg8pQLZywcy1w3SwLtIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u+T3NU6QNFkOQKHYYcZy7EJ0pKJCkBa9x+ezT/MG77s=;
        b=bSU3Y4CniODsyE6YmvJujSIh/gbBrtODerkqrxEm4DWsZ68HVHW65iMQ9hDsIr4jF4
         UfWO7F8brW9LdiSpNSNrvxvDBiQuFw883U1KghuLZGQaevRrU79/qyebAAkrs3Tz9Pv1
         B20OMzx8IkG+Xmc3nW7ZboLNqIbw/Wrb3WncsxPDhHb6MiZd4gVme41kBslf/LNWfmsV
         1eGh/DRUpNn3JxhtMa/97r05YiqEKzVUNqsWsGbyuPNMucQhGeZ3QRQCzGXJHld5AJOv
         BpndhdgnFqVniRWN0hgIxoQvjxSeWFZpnMLI5d9M6aZF8yIj94m84Elhyvmg0cPLCuXo
         PTaw==
X-Gm-Message-State: AOAM531kUXb5KM8uYxak39q5oTVvnD2YXXqyNtsTGO+AC3VK2fANfyJ9
        BPY00Xr0xj8cpsAGchh2n0SqYJxVjYKZMSVJ8kWu3Q==
X-Google-Smtp-Source: ABdhPJxTgVZ2jFFHgxN7D/AtvnXeF5uqH4Yvnf+QwwOB4lFId32budFznnvimZWza/nh+PWTqsX5Q6prwTm7+Xq/tXk=
X-Received: by 2002:a92:cac4:0:b0:2c8:1095:b352 with SMTP id
 m4-20020a92cac4000000b002c81095b352mr2384844ilq.103.1649186747658; Tue, 05
 Apr 2022 12:25:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220330160535.GN8939@worktop.programming.kicks-ass.net>
 <CAEXW_YQNi42gahbSJ1skadh_8D+Ry6ZOmMqSU5BdidfCbmOtRg@mail.gmail.com> <YkbmCr6ojXYiWzkP@hirez.programming.kicks-ass.net>
In-Reply-To: <YkbmCr6ojXYiWzkP@hirez.programming.kicks-ass.net>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 5 Apr 2022 15:25:36 -0400
Message-ID: <CAEXW_YSHVUgqc_Uvx6dyiC2ynYTi2YLTuX87KkrAJDpm6D0EzQ@mail.gmail.com>
Subject: Re: [PATCH] sched/core: Fix forceidle balancing
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 1, 2022 at 7:46 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Mar 31, 2022 at 03:00:40PM -0400, Joel Fernandes wrote:
> > Hi,
> >
> > By the way, might be slightly related - we still see crashes with
> > pick_task_fair() in our kernel even with this change:
> > https://lkml.org/lkml/2020/11/17/2137
>
> Please as to not use lkml.org. Please use something with a MsgID in like
> lore.

Yep, will do.

> > Is it possible that when doing pick_task_fair() especially on a remote
> > CPU, both the "cfs_rq->curr" and the rbtree's "left" be NULL with core
> > scheduling? In this case, se will be NULL and can cause crashes right?
> > I think the code assumes this can never happen.
> >
> > +Guenter Roeck  kindly debugged pick_task_fair() in a crash as
> > follows. Copying some details he mentioned in a bug report:
> >
> > Assembler/source:
> >
> >   25:   e8 4f 11 00 00          call   0x1179             ; se =
> > pick_next_entity(cfs_rq, curr);
> >   2a:*  48 8b 98 60 01 00 00    mov    0x160(%rax),%rbx   ; trapping
> > instruction [cfs_rq = group_cfs_rq(se);]
> >   31:   48 85 db                test   %rbx,%rbx
> >   34:   75 d1                   jne    0x7
> >   36:   48 89 c7                mov    %rax,%rdi
> >
> > At 2a: RAX = se == NULL after pick_next_entity(). Looking closely into
> > pick_next_entity(), it can indeed return NULL if curr is NULL and if
> > left in pick_next_entity() is NULL. Per line 7:, curr is in %r14 and
> > indeed 0.
> >
> > Thoughts?
>
> It is possible for ->curr and ->leftmost to be NULL, but then we should
> also be having ->nr_running == 0 and not call pick in the first place.
> Because picking a task from no tasks doesn't make much sense.

Indeed the code checks for nr_running so it is really bizarre. My
guess is this is kernel memory corruption due to an unrelated bug or
something, it is also not easy to trigger.

Thanks,

 - Joel
