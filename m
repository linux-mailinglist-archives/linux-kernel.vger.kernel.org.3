Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CD44DC589
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 13:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbiCQMJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 08:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbiCQMJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 08:09:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CD3DEAF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:08:18 -0700 (PDT)
Date:   Thu, 17 Mar 2022 13:08:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647518896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MepqDHztiF6xYCqoADcvfLMjE+02llNf194zsZ8IG8A=;
        b=PEuLm50mHnPHzU9aKsysMc+blrmD8kIyA5+Q8/dmX3l3C9L7SboXaVmC9hKAu5tKQISnUU
        ajY/F+wyB5PX9pkAlflzAylhAhbLQisK3iCV+UCw2O192dsQadEpq274AI4AmOhNGllmwL
        5fSrk3ouJ8w7YTTu+uEcOzSXAVDCpGK+UQhLVda+9NnRnBgLKNhDgXzJikmFJitKPSXApZ
        n2azRf+bJt0o4HI6iISRKoWMQXPZfR4e1EBXNrsbdmCZC6H/KANEWJF1yt/tfpJQpJrnn5
        n9QsH/HOs1uRmgTjiMutHPVZ3+De5Qx41Rf4EbjSVVZxuqa/Y5Pw5wIv1OF1rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647518896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MepqDHztiF6xYCqoADcvfLMjE+02llNf194zsZ8IG8A=;
        b=/ftT1ZppCKCnkXZUEjPVF6Coic+WPvlvbNB8zSxoyeUHTqfe+qcHhPo8SVtsTCO0LcJmyj
        ir9vdzS7fvR8+2Dw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: sched_core_balance() releasing interrupts with pi_lock held
Message-ID: <YjMkr4bE4Gws189a@linutronix.de>
References: <20220308161455.036e9933@gandalf.local.home>
 <20220315174606.02959816@gandalf.local.home>
 <20220316202734.GJ8939@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220316202734.GJ8939@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-16 21:27:34 [+0100], Peter Zijlstra wrote:
> Now, we only do queue_core_balance() from set_next_task_idle(), which
> *should* only happen from pick_next_task(), and as such the callback
> should only ever get called from finish_lock_switch() or the 'prev ==
> next' case in __schedule().
> 
> Neither of these two sites holds pi_lock.

I've been trying to reproduce it and didn't make it. I see only the
idle/scheduler path.

> This is about as far as I got explaining things, and it being late, it's
> about as far as I got looking at things.
> 
> Now that also makes conceptual sense, we only want to pull a core-cookie
> task when we're scheduling an idle task.
> 
> Now, clearly this gets triggered from the PI path, but that's not making
> immediate sense to me, it would mean we're boosting the idle task, which
> is wrong too.

Looking at the idle task, it shouldn't be possible for !RT due to lack
of boostable locks and I don't see anything sleeping locks here on RT
either. 

> So it would be useful for someone that can reproduce this to provide a
> trace of where queue_core_balance() gets called, because that *should*
> only be in __schedule().

I failed so far.

Sebastian
