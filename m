Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A0E563745
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 17:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiGAPy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 11:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiGAPy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 11:54:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89ED15FC7
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 08:54:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64CB5622F8
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 15:54:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC97C341C7;
        Fri,  1 Jul 2022 15:54:54 +0000 (UTC)
Date:   Fri, 1 Jul 2022 11:54:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: fix rq lock recursion issue
Message-ID: <20220701115453.259b17e6@gandalf.local.home>
In-Reply-To: <Yr4lkBjU6Dy6Wb57@home.goodmis.org>
References: <20220624074240.13108-1-quic_satyap@quicinc.com>
        <Yr4lkBjU6Dy6Wb57@home.goodmis.org>
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

On Thu, 30 Jun 2022 18:37:04 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > 
> > Fix the issue by switching to preempt_enable/disable() for non-RT
> > Kernels.
> > 
> > -010 |spin_bug(lock = ???, msg = ???)
> > -011 |debug_spin_lock_before(inline)
> > -011 |do_raw_spin_lock(lock = 0xFFFFFF89323BB600)
> > -012 |_raw_spin_lock(inline)
> > -012 |raw_spin_rq_lock_nested(inline)
> > -012 |raw_spin_rq_lock(inline)
> > -012 |task_rq_lock(p = 0xFFFFFF88CFF1DA00, rf = 0xFFFFFFC03707BBE8)
> > -013 |__set_cpus_allowed_ptr(inline)
> > -013 |migrate_enable()
> > -014 |trace_call_bpf(call = ?, ctx = 0xFFFFFFFDEF954600)
> > -015 |perf_trace_run_bpf_submit(inline)
> > -015 |perf_trace_sched_switch(__data = 0xFFFFFFE82CF0BCB8, preempt = FALSE, prev = ?, next = ?)
> > -016 |__traceiter_sched_switch(inline)
> > -016 |trace_sched_switch(inline)  
> 
> trace_sched_switch() disables preemption.
> 
> So how is this a fix?

Let me rephrase my question.

As trace_sched_switch() disables preemption, why is trace_call_bpf()
calling migrate_disable()?

Looks like you could modify the code to include a __bpf_prog_run_array()
that skips the migrate_disable(). You even have a "cant_sleep()" call in
trace_call_bpf().

-- Steve
