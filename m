Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CEF4B318D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 00:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354283AbiBKXzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 18:55:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345542AbiBKXzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 18:55:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674F0D62;
        Fri, 11 Feb 2022 15:55:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06BB961991;
        Fri, 11 Feb 2022 23:55:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B92C340E9;
        Fri, 11 Feb 2022 23:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644623703;
        bh=rR5ZkKx0Xpu8arnGBP1p4my2GJbjV7RXt9OYTAfkjXA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Rx3yNctuEW9GXddbvrWg8KiLYm8wej4EtyQzOkUmTK7/RaUBry3/e5faZF8cq2Jyb
         ab/IGE/9fTmIvd2HD4GExHI6uRBbQZc77U60D6/o8C9fm5bInPqFWW4sBeXsqrMOzE
         0MWYCQa8o6bsGRvxJPo1sRVdpE+OodqNxvHTPfd3xjDniwbHkOQkZMuZEA655n2fAM
         lgezQoDgrSjBO/CIauSI8jhC9sEJbqBNolsObsnfiQDqqR/1vrDEALiZuD5UMw9BfM
         +M3KSucWBmic/kadPMVb8Z7KQkV2RwfXeKWKVhDa9UEdcso/6V7aEItSHROELaNVIg
         f1e7r39lsDWcw==
Message-ID: <00f9c7a6-2d1d-f871-e9bc-00e2217f40f9@kernel.org>
Date:   Fri, 11 Feb 2022 15:55:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 7/8] kernel/fork: Only cache the VMAP stack in
 finish_task_switch().
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Cc:     Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20220125152652.1963111-1-bigeasy@linutronix.de>
 <20220125152652.1963111-8-bigeasy@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <20220125152652.1963111-8-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/22 07:26, Sebastian Andrzej Siewior wrote:
> The task stack could be deallocated later in delayed_put_task_struct().
> For fork()/exec() kind of workloads (say a shell script executing
> several commands) it is important that the stack is released in
> finish_task_switch() so that in VMAP_STACK case it can be cached and
> reused in the new task.
> If the free/ caching is RCU-delayed then a new stack has to be allocated
> because the cache is filled in batches of which only two stacks, out of
> many, are recycled.
> 
> For PREEMPT_RT it would be good if the wake-up in vfree_atomic() could
> be avoided in the scheduling path. Far worse are the other
> free_thread_stack() implementations which invoke __free_pages()/
> kmem_cache_free() with disabled preemption.
> 
> Introduce put_task_stack_sched() which is invoked from the
> finish_task_switch() and only caches the VMAP stack. If the cache is
> full or !CONFIG_VMAP_STACK is used than the stack is freed from
> delayed_put_task_struct(). In the VMAP case this is another opportunity
> to fill the cache.
> 
> The stack is finally released in delayed_put_task_struct() which means
> that a valid stack reference can be held during its invocation. As such
> there can be made no assumption whether the task_struct::stack pointer
> can be freed if non-NULL.
> Set the lowest bit of task_struct::stack if the stack was released via
> put_task_stack_sched() and needs a final free in
> delayed_put_task_struct(). If the bit is missing then a reference is
> held and put_task_stack() will release it.

I don't understand what this bit is for or why the logic needs to be 
this complicated.  Can you set ->stack to NULL if and only if you freed 
it early?

> +static void free_thread_stack(struct task_struct *tsk, bool cache_only)

This is messy.  Please clean it up for real:

static bool try_release_thread_stack_to_cache(struct vm_struct *vm)
{
   for (...) try to put it in this slot;
}

And the callers can do things like:

if (try_release_thread_stack_to_cache(...))
   return;

/* need to free for real */
free it or delayed-free it.

--Andy
