Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372EB521D81
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345560AbiEJPJu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 10 May 2022 11:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345886AbiEJPGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:06:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4492944BC
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 07:32:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38A90B81DC3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 14:31:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C07C385C2;
        Tue, 10 May 2022 14:31:53 +0000 (UTC)
Date:   Tue, 10 May 2022 10:31:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Delyan Kratunov <delyank@fb.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "legion@kernel.org" <legion@kernel.org>,
        "adharmap@quicinc.com" <adharmap@quicinc.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "ed.tsai@mediatek.com" <ed.tsai@mediatek.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>
Subject: Re: [PATCH] sched/tracing: append prev_state to tp args instead
Message-ID: <20220510103152.68b8b66d@gandalf.local.home>
In-Reply-To: <20220510082940.GA100765@worktop.programming.kicks-ass.net>
References: <056e9bb0d0e3fc20572d42db7386face1d0665d6.camel@fb.com>
        <CAADnVQKsah4aka-LJ+X+5XHHESKbbw36D8fXTLqcYp2io3PN_w@mail.gmail.com>
        <YmflVPQlwpiBuxRc@hirez.programming.kicks-ass.net>
        <20220426140959.op6u5m7id57aq7yc@wubuntu>
        <CAEf4BzaoL5HVc8U16kz7m--RiPhBwuLt8ZGZppwfxV85AXXrcw@mail.gmail.com>
        <20220427103458.ecnqtaj3af63625h@wubuntu>
        <CAEf4BzYc3f2-9hvuGL_mTO8qNxZjdQn8AabEb-N6Q7XjmEQQ1A@mail.gmail.com>
        <20220428100235.sqoxunbylqk2surk@wubuntu>
        <CAEf4BzaEo+dxSRJZHQiXYrj-a3_B-eODZUxGh3HrnPjquMYFXQ@mail.gmail.com>
        <20220510070122.GJ76023@worktop.programming.kicks-ass.net>
        <20220510082940.GA100765@worktop.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 May 2022 10:29:40 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, May 10, 2022 at 09:01:22AM +0200, Peter Zijlstra wrote:
> > On Mon, May 09, 2022 at 12:32:31PM -0700, Andrii Nakryiko wrote:  
> > > So can this patch be applied, please, or it's a hard no?  
> > 
> > Sorry; I got distracted with other work. I'll grudingly apply the patch.  
> 
>   gcc-11-i386-allmodconfig [15:35]  FAILED
>   | In file included from ../include/trace/define_custom_trace.h:55,
>   |                  from ../samples/trace_events/trace_custom_sched.h:96,
>   |                  from ../samples/trace_events/trace_custom_sched.c:24:
>   | ../samples/trace_events/./trace_custom_sched.h: In function ‘ftrace_test_custom_probe_sched_switch’:
>   | ../include/trace/trace_custom_events.h:178:42: error: passing argument 1 of ‘check_trace_callback_type_sched_switch’ from incompatible pointer type [-Werror=incompatible-pointer-types]
>   |   178 |         check_trace_callback_type_##call(trace_custom_event_raw_event_##template); \
>   |       |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   |       |                                          |
>   |       |                                          void (*)(void *, bool,  unsigned int,  struct task_struct *, struct task_struct *) {aka void (*)(void *, _Bool,  unsigned int,  struct task_struct *, struct task_struct *)}
>   | ../include/trace/trace_custom_events.h:34:9: note: in expansion of macro ‘DEFINE_CUSTOM_EVENT’
>   |    34 |         DEFINE_CUSTOM_EVENT(name, name, PARAMS(proto), PARAMS(args));


Yes, the custom tracepoint sample code uses the sched_switch tracepoint as
an example. That sample code needs to be updated:

In samples/trace_events/trace_custom_sched.h:

TRACE_CUSTOM_EVENT(sched_switch,

        /*
         * The TP_PROTO() and TP_ARGS must match the trace event
         * that the custom event is using.
         */
        TP_PROTO(bool preempt,
                 unsigned int prev_state,
                 struct task_struct *prev,
                 struct task_struct *next),

        TP_ARGS(preempt, prev_state, prev, next),



The arguments need to be updated.

-- Steve
