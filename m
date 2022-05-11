Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653FA523D2C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244902AbiEKTKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238585AbiEKTKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:10:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1D86FA04
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 12:10:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79BEB6118A
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 19:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD786C340EE;
        Wed, 11 May 2022 19:10:20 +0000 (UTC)
Date:   Wed, 11 May 2022 15:10:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "qais.yousef@arm.com" <qais.yousef@arm.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "adharmap@quicinc.com" <adharmap@quicinc.com>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "ed.tsai@mediatek.com" <ed.tsai@mediatek.com>,
        "legion@kernel.org" <legion@kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v2] sched/tracing: append prev_state to tp args instead
Message-ID: <20220511151019.58e42cd2@gandalf.local.home>
In-Reply-To: <c8a6930dfdd58a4a5755fc01732675472979732b.camel@fb.com>
References: <20220510082940.GA100765@worktop.programming.kicks-ass.net>
        <c8a6930dfdd58a4a5755fc01732675472979732b.camel@fb.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2022 18:28:36 +0000
Delyan Kratunov <delyank@fb.com> wrote:

> Sorry about that Peter and thanks for taking it in, it's much appreciated! 
> 
>  include/trace/events/sched.h              | 6 +++---
>  kernel/sched/core.c                       | 2 +-
>  kernel/trace/fgraph.c                     | 4 ++--
>  kernel/trace/ftrace.c                     | 4 ++--
>  kernel/trace/trace_events.c               | 8 ++++----
>  kernel/trace/trace_osnoise.c              | 4 ++--
>  kernel/trace/trace_sched_switch.c         | 4 ++--
>  kernel/trace/trace_sched_wakeup.c         | 4 ++--
>  samples/trace_events/trace_custom_sched.h | 6 +++---
>  9 files changed, 21 insertions(+), 21 deletions(-)

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
