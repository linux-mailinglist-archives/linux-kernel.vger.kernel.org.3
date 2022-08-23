Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8507B59EBCD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbiHWTHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiHWTHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:07:13 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5291322F8;
        Tue, 23 Aug 2022 10:45:14 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id a14-20020a0568300b8e00b0061c4e3eb52aso10274026otv.3;
        Tue, 23 Aug 2022 10:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=NuaAcP1qTlqPeXefw8MkbiuCy78EOKqoCb/M7Mlw4gY=;
        b=2erlFligm5zHeKWnNtaGUjKMKCeFj5mP56eNXsr/MYIXmXNxmSTRPPX+NQ+UrE4MLU
         luiEvm6NwbTWHaPm8aWU/4TJmiSBbYO/6apMi1yXphl3S/mGM/0tfeUDAjGR7vlIL++V
         qIFXnuKfv3IdDTp0wUaFWvqAXPq4Ej9g9wcNR8LI6ZaA0x5+rKaQpcQF8KugEgGVbql5
         VP2tlNm4jdAdEk/oHOh2QBHcytvnZ5Yu5kmJHKGQc3CvlXwavhKXBSbgZn4Eu0DQDkBJ
         tiSLC5Nq2heV7eJO26TUkc2yS7ds0GY9r9I27G0RmYF1O18CPxJ1H1NAzEuSRvAcG92B
         YgNg==
X-Gm-Message-State: ACgBeo2e62tuGGoxdvJwGJnPR8Yao+2XorP0i4eOsdz8mhCiukwAMAwa
        AizLVtP2waaHtHRY68zxXcJarh5NsHIswBI9QsXpxEI6
X-Google-Smtp-Source: AA6agR65oPPvx3WCxH8CnmgpKal4capxYkGC0hZz3k+ad8P1bvEvKdnC4E9e+wcyalVfqTy67rF/6iR4mQTCy8G5SDc=
X-Received: by 2002:a25:8d84:0:b0:695:836a:fcaf with SMTP id
 o4-20020a258d84000000b00695836afcafmr14424963ybl.633.1661275964352; Tue, 23
 Aug 2022 10:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220822111816.760285417@infradead.org> <20220822114648.922711674@infradead.org>
In-Reply-To: <20220822114648.922711674@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 Aug 2022 19:32:33 +0200
Message-ID: <CAJZ5v0i=+jXz71DBx=Hr9_6bxOx7yFF_xZJc4tXB0j4kSW0Q_g@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] sched/completion: Add wait_for_completion_state()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 1:48 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Allows waiting with a custom @state.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/completion.h |    1 +
>  kernel/sched/completion.c  |    9 +++++++++
>  2 files changed, 10 insertions(+)
>
> --- a/include/linux/completion.h
> +++ b/include/linux/completion.h
> @@ -103,6 +103,7 @@ extern void wait_for_completion(struct c
>  extern void wait_for_completion_io(struct completion *);
>  extern int wait_for_completion_interruptible(struct completion *x);
>  extern int wait_for_completion_killable(struct completion *x);
> +extern int wait_for_completion_state(struct completion *x, unsigned int state);
>  extern unsigned long wait_for_completion_timeout(struct completion *x,
>                                                    unsigned long timeout);
>  extern unsigned long wait_for_completion_io_timeout(struct completion *x,
> --- a/kernel/sched/completion.c
> +++ b/kernel/sched/completion.c
> @@ -247,6 +247,15 @@ int __sched wait_for_completion_killable
>  }
>  EXPORT_SYMBOL(wait_for_completion_killable);
>
> +int __sched wait_for_completion_state(struct completion *x, unsigned int state)
> +{
> +       long t = wait_for_common(x, MAX_SCHEDULE_TIMEOUT, state);
> +       if (t == -ERESTARTSYS)
> +               return t;
> +       return 0;
> +}
> +EXPORT_SYMBOL(wait_for_completion_state);

Why not EXPORT_SYMBOL_GPL?  I guess to match the above?

> +
>  /**
>   * wait_for_completion_killable_timeout: - waits for completion of a task (w/(to,killable))
>   * @x:  holds the state of this particular completion
>
>
