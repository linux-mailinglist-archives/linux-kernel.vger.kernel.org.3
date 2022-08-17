Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB50596F75
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239923AbiHQNQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239629AbiHQNP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:15:58 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59C85926E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:15:31 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-3246910dac3so229586267b3.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=4x9/R2mHqDBSBsINZoYzu53n4+/x9xPXewr5G0XEr34=;
        b=Ta7vQAWfgNwLeo8X+pcdJ6JyCnUcaqj1Ews44KLWjJGhgXZv20jGydY8asVvhmMfNz
         b5Fzq6C/S2NXkgfMPJzpJcfXtNp/XsSJDaSorCNhL1D/nzqkMFU7Du+YXm0LpKulY9IK
         /76nM6mT8xUUP8UaTC1eN5M2TkbrsohpqC0/E8YxXYpbdWBeaceJ/x8g5odhImXtyrc1
         qOyIpz90N1Ejyl+l9w55WOS+8npqTm4TRnzX3bA4a2avvsii63eJWYfy6fWyxSZaHQWM
         Qo0/XLJ6ZGGdQy6n6h+9ZeH4bseaOSQZpSngSXr1oW9GbmtitbnwZya8r8OT9qqDsOW5
         Pddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=4x9/R2mHqDBSBsINZoYzu53n4+/x9xPXewr5G0XEr34=;
        b=MWu4Ma9WPAqJbsXwV9DGM9u+I2qtWql3tCfiGfhurkhE8IT9ohaZDdrvg7yrHrJPe4
         /ta8XYlFt+bc9sMf9X7fPVm5LWJV5uZh611XAPgdrBr7OU0AwybA/pfCp/P7lldppnXJ
         4T3UHmNeccJZKlDIbVa/qASr8cc8yndFr16/9x1JdKWGzavGXGXgNtzOEsQCVVbGM0M4
         ZQWwPxcE9czdchMQiNqZasUzOLiT75VZWWqzUTk0RmykVeOZbvS6XzWUXjqbV6SIEqXn
         NLfm82fWwOSCDs4Y2k8AEpew/EpwKxWZQvLBuHGU7Om74ilGjaE5+WEyy83S8ggq7sxN
         fPgA==
X-Gm-Message-State: ACgBeo3G1RbwsiEOWC7guC3IjchN40CKoeuZ55/7lO1IW31ZCFnCO3Lz
        vL1VxwkXBl7QViKKVaL7lkmV5h/vVhzFrXNmDHJvRQ==
X-Google-Smtp-Source: AA6agR4J3cyIT0SWBYaiCeztXduj+LhF+ocuDdNtn7hGLnqyHtxrllFHNLPRhY47QfH++sCFFlwAFNLyvGB5+UaJKNI=
X-Received: by 2002:a5b:c8b:0:b0:688:ebe9:3d05 with SMTP id
 i11-20020a5b0c8b000000b00688ebe93d05mr12303544ybq.553.1660742130329; Wed, 17
 Aug 2022 06:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220704150514.48816-1-elver@google.com> <20220704150514.48816-12-elver@google.com>
 <YvznKYgRKjDRSMkT@worktop.programming.kicks-ass.net>
In-Reply-To: <YvznKYgRKjDRSMkT@worktop.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Wed, 17 Aug 2022 15:14:54 +0200
Message-ID: <CANpmjNN1vv9oDpm1_c99tQKgWVVtXza++u1xcBVeb5mhx5eUHw@mail.gmail.com>
Subject: Re: [PATCH v3 11/14] perf/hw_breakpoint: Reduce contention with large
 number of tasks
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Aug 2022 at 15:03, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jul 04, 2022 at 05:05:11PM +0200, Marco Elver wrote:
> > +static bool bp_constraints_is_locked(struct perf_event *bp)
> > +{
> > +     struct mutex *tsk_mtx = get_task_bps_mutex(bp);
> > +
> > +     return percpu_is_write_locked(&bp_cpuinfo_sem) ||
> > +            (tsk_mtx ? mutex_is_locked(tsk_mtx) :
> > +                       percpu_is_read_locked(&bp_cpuinfo_sem));
> > +}
>
> > @@ -426,18 +521,28 @@ static int modify_bp_slot(struct perf_event *bp, u64 old_type, u64 new_type)
> >   */
> >  int dbg_reserve_bp_slot(struct perf_event *bp)
> >  {
> > -     if (mutex_is_locked(&nr_bp_mutex))
> > +     int ret;
> > +
> > +     if (bp_constraints_is_locked(bp))
> >               return -1;
> >
> > -     return __reserve_bp_slot(bp, bp->attr.bp_type);
> > +     /* Locks aren't held; disable lockdep assert checking. */
> > +     lockdep_off();
> > +     ret = __reserve_bp_slot(bp, bp->attr.bp_type);
> > +     lockdep_on();
> > +
> > +     return ret;
> >  }
> >
> >  int dbg_release_bp_slot(struct perf_event *bp)
> >  {
> > -     if (mutex_is_locked(&nr_bp_mutex))
> > +     if (bp_constraints_is_locked(bp))
> >               return -1;
> >
> > +     /* Locks aren't held; disable lockdep assert checking. */
> > +     lockdep_off();
> >       __release_bp_slot(bp, bp->attr.bp_type);
> > +     lockdep_on();
> >
> >       return 0;
> >  }
>
> Urggghhhh... this is horrible crap. That is, the current code is that
> and this makes it worse :/

Heh, yes and when I looked at it I really wanted to see if it can
change. But from what I can tell, when the kernel debugger is being
attached, the kernel does stop everything it does and we need the
horrible thing above to not deadlock. And these dbg_ functions are not
normally used, so I decided to leave it as-is. Suggestions?
