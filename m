Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3117516E07
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 12:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384453AbiEBKWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 06:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235855AbiEBKWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 06:22:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA0CD8A;
        Mon,  2 May 2022 03:18:33 -0700 (PDT)
Date:   Mon, 2 May 2022 12:18:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651486711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=njv8w62I6YaR6R9I+B/zv4adKDIlEkCZ/E2IlD+ACLw=;
        b=ADEiWHzKLRNuj8KFUocM8tJalgULCU+gvxgNN4Af40aHR9L7ntUAQnUCSuPlLMLbvQm0+F
        99XPvLo0xL9Mb2JP4YnBertfN1BnOCHeVAhePaHzBRVEve8/UvXrBn7bkcEbbNU0WysehQ
        zVEPjDJx/jseio8sFQVuaYaNzskFmnh3l8EsxDg5oOJd+RaoB6RpljpryOi+rT7esewioM
        SFH5Frq/16V/GEZNPquUyhHuBaNv/5I3MAWqhTFfNhmuLZhT+YV4aW2JkDLRSG4jqtTv9q
        OcrI/0YghI5Fak4aosZ9UtxuFahlpE6xQS5/vmWWAGxeAn5OKC4ga+QT2I5SbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651486711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=njv8w62I6YaR6R9I+B/zv4adKDIlEkCZ/E2IlD+ACLw=;
        b=TgSv28QweSqhFe5Q07tp4skOaB1hnFxdXVoAWEKyi8cGPJbx+V1Z2UlKMJwyhhaw+6Ox2r
        tKYZMOvdEd5oTyCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        Oleg Nesterov <oleg@redhat.com>, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org
Subject: Re: [PATCH v2 12/12] sched,signal,ptrace: Rework TASK_TRACED,
 TASK_STOPPED state
Message-ID: <Ym+v9VAf71oOlDLF@linutronix.de>
References: <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
 <20220429214837.386518-12-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220429214837.386518-12-ebiederm@xmission.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-29 16:48:37 [-0500], Eric W. Biederman wrote:

Needs
 From: Peter Zijlstra (Intel) <peterz@infradead.org>

at the top.

> Currently ptrace_stop() / do_signal_stop() rely on the special states
> TASK_TRACED and TASK_STOPPED resp. to keep unique state. That is, this
> state exists only in task->__state and nowhere else.
> 
> There's two spots of bother with this:
> 
>  - PREEMPT_RT has task->saved_state which complicates matters,
>    meaning task_is_{traced,stopped}() needs to check an additional
>    variable.
> 
>  - An alternative freezer implementation that itself relies on a
>    special TASK state would loose TASK_TRACED/TASK_STOPPED and will
>    result in misbehaviour.
> 
> As such, add additional state to task->jobctl to track this state
> outside of task->__state.
> 
> NOTE: this doesn't actually fix anything yet, just adds extra state.
> 
> --EWB
>   * didn't add a unnecessary newline in signal.h
>   * Update t->jobctl in signal_wake_up and ptrace_signal_wake_up
>     instead of in signal_wake_up_state.  This prevents the clearing
>     of TASK_STOPPED and TASK_TRACED from getting lost.
>   * Added warnings if JOBCTL_STOPPED or JOBCTL_TRACED are not cleared
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20220421150654.757693825@infradead.org
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

Sebastian
