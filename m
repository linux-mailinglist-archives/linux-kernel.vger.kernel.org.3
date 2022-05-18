Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15C852B571
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbiERI7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 04:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbiERI7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 04:59:32 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6F1BC0
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 01:59:29 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id m6so1733683ljb.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 01:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1y20d2CkjJ3jV4BDulmfhtq8qKaxqCZFrmrXAIB+XD0=;
        b=lYs8a06s5W6554IOwemmktHw2Qj5CfAUIZhIT2E+OE44gBV/5786+YtkRATyQQ4mYr
         /kiVrZYhZNpLIUcsGWBzrF7ChPr8bq3YKOSiIyumqo+o1KsdhtTw8qKlnyS5TT/U0DlG
         0I2Hl0g9Q0TR1p6vbpcy0EuFU8eRSRCO564r6uKReY6sOUNE0kAHyQD5gq9u14h/gPwl
         VLIvDW4iXZChyLXnV5iujtTQsHK9rouvU5xGiXsY3AV4LjPD6T+zeseDMww4pzzXEaYO
         2VOJHZzyE8YYgU1+PMy4raxst2SEd3O3qlBVfcEE3WYQOM4zT/GY+W19LAG4nESx+pP/
         WuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1y20d2CkjJ3jV4BDulmfhtq8qKaxqCZFrmrXAIB+XD0=;
        b=vRA2u3AMtQRYiE4xGWjm8Lot8BWKcuffUKpdttV1EQpROq5q5JiNXA8KWYh50Xzi+y
         i55MKgDm7NIW6souyjQZ5AiWOWfAh6hzmTxm+eWqmpaUJyfPbW6SImvPtnPYGob9RS+/
         MGXgE6z13KCc/2JihH8oV17RJlOmPcD7cQ8GXgjYyspmP0gjFXyDQ6KHAsLo7yriLiAA
         ZsIAFH0+Gw8EfzYkAPQfYJnWYrkK1ZKZeqXBjQsLXv2iGqDeivuM9yhMQSLNIIcytEiT
         MEXOc+oygFl23RZ7Zke0CTmFmCDyxz9D3PaoZI3YUmNNGID2JyaDeIdk7vkVvjymb7Yx
         eGqg==
X-Gm-Message-State: AOAM5337NU/8k00Pqqi3ESb5t6FylItcTtmnhL2l0kPFZ0kOh+LojdzR
        Pb+8LAQA1RtRjbHvDX+McX/uDRi4qVNWKvaNaw6S6Q==
X-Google-Smtp-Source: ABdhPJxXjb3v2/Ccvr3eOeS8iH8Knna0ewodJR+LkWEtAXj3IdH+Ge/0l35WxMLukpO8wXjS/aRMIAXGWhOvIBXO2t4=
X-Received: by 2002:a2e:8603:0:b0:250:cf53:7f46 with SMTP id
 a3-20020a2e8603000000b00250cf537f46mr16307079lji.47.1652864366092; Wed, 18
 May 2022 01:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220517210532.1506591-1-liu3101@purdue.edu> <CACT4Y+Z+HtUttrd+btEWLj5Nut4Gv++gzCOL3aDjvRTNtMDEvg@mail.gmail.com>
In-Reply-To: <CACT4Y+Z+HtUttrd+btEWLj5Nut4Gv++gzCOL3aDjvRTNtMDEvg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 18 May 2022 10:59:14 +0200
Message-ID: <CACT4Y+bAGVLU5QEUeQEHth6SZDOSzy0CRKEJQioC0oKHSPaAbA@mail.gmail.com>
Subject: Re: [PATCH] kcov: fix race caused by unblocked interrupt
To:     Congyu Liu <liu3101@purdue.edu>
Cc:     andreyknvl@gmail.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2022 at 10:56, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Tue, 17 May 2022 at 23:05, Congyu Liu <liu3101@purdue.edu> wrote:
> >
> > Some code runs in interrupts cannot be blocked by `in_task()` check.
> > In some unfortunate interleavings, such interrupt is raised during
> > serializing trace data and the incoming nested trace functionn could
> > lead to loss of previous trace data. For instance, in
> > `__sanitizer_cov_trace_pc`, if such interrupt is raised between
> > `area[pos] = ip;` and `WRITE_ONCE(area[0], pos);`, then trace data in
> > `area[pos]` could be replaced.
> >
> > The fix is done by adding a flag indicating if the trace buffer is being
> > updated. No modification to trace buffer is allowed when the flag is set.
>
> Hi Congyu,
>
> What is that interrupt code? What interrupts PCs do you see in the trace.
> I would assume such early interrupt code should be in asm and/or not
> instrumented. The presence of instrumented traced interrupt code is
> problematic for other reasons (add random stray coverage to the
> trace). So if we make it not traced, it would resolve both problems at
> once and without the fast path overhead that this change adds.

Also thinking if reordering `area[pos] = ip;` and `WRITE_ONCE(area[0], pos);`
will resolve the problem without adding fast path overhead.
However, not instrumenting early interrupt code still looks more preferable.


 > Signed-off-by: Congyu Liu <liu3101@purdue.edu>
> > ---
> >  include/linux/sched.h |  3 +++
> >  kernel/kcov.c         | 16 ++++++++++++++++
> >  2 files changed, 19 insertions(+)
> >
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index a8911b1f35aa..d06cedd9595f 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1408,6 +1408,9 @@ struct task_struct {
> >
> >         /* Collect coverage from softirq context: */
> >         unsigned int                    kcov_softirq;
> > +
> > +       /* Flag of if KCOV area is being written: */
> > +       bool                            kcov_writing;
> >  #endif
> >
> >  #ifdef CONFIG_MEMCG
> > diff --git a/kernel/kcov.c b/kernel/kcov.c
> > index b3732b210593..a595a8ad5d8a 100644
> > --- a/kernel/kcov.c
> > +++ b/kernel/kcov.c
> > @@ -165,6 +165,8 @@ static notrace bool check_kcov_mode(enum kcov_mode needed_mode, struct task_stru
> >          */
> >         if (!in_task() && !(in_serving_softirq() && t->kcov_softirq))
> >                 return false;
> > +       if (READ_ONCE(t->kcov_writing))
> > +               return false;
> >         mode = READ_ONCE(t->kcov_mode);
> >         /*
> >          * There is some code that runs in interrupts but for which
> > @@ -201,12 +203,19 @@ void notrace __sanitizer_cov_trace_pc(void)
> >                 return;
> >
> >         area = t->kcov_area;
> > +
> > +       /* Prevent race from unblocked interrupt. */
> > +       WRITE_ONCE(t->kcov_writing, true);
> > +       barrier();
> > +
> >         /* The first 64-bit word is the number of subsequent PCs. */
> >         pos = READ_ONCE(area[0]) + 1;
> >         if (likely(pos < t->kcov_size)) {
> >                 area[pos] = ip;
> >                 WRITE_ONCE(area[0], pos);
> >         }
> > +       barrier();
> > +       WRITE_ONCE(t->kcov_writing, false);
> >  }
> >  EXPORT_SYMBOL(__sanitizer_cov_trace_pc);
> >
> > @@ -230,6 +239,10 @@ static void notrace write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
> >         area = (u64 *)t->kcov_area;
> >         max_pos = t->kcov_size * sizeof(unsigned long);
> >
> > +       /* Prevent race from unblocked interrupt. */
> > +       WRITE_ONCE(t->kcov_writing, true);
> > +       barrier();
> > +
> >         count = READ_ONCE(area[0]);
> >
> >         /* Every record is KCOV_WORDS_PER_CMP 64-bit words. */
> > @@ -242,6 +255,8 @@ static void notrace write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
> >                 area[start_index + 3] = ip;
> >                 WRITE_ONCE(area[0], count + 1);
> >         }
> > +       barrier();
> > +       WRITE_ONCE(t->kcov_writing, false);
> >  }
> >
> >  void notrace __sanitizer_cov_trace_cmp1(u8 arg1, u8 arg2)
> > @@ -335,6 +350,7 @@ static void kcov_start(struct task_struct *t, struct kcov *kcov,
> >         t->kcov_size = size;
> >         t->kcov_area = area;
> >         t->kcov_sequence = sequence;
> > +       t->kcov_writing = false;
> >         /* See comment in check_kcov_mode(). */
> >         barrier();
> >         WRITE_ONCE(t->kcov_mode, mode);
> > --
> > 2.34.1
> >
