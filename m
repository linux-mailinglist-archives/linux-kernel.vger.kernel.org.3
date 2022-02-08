Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9044ADEF7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 18:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383745AbiBHRK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 12:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244646AbiBHRKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 12:10:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82717C061576;
        Tue,  8 Feb 2022 09:10:22 -0800 (PST)
Date:   Tue, 8 Feb 2022 18:10:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644340221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pVIJUQJ0Ki8jKxcVnu+JXzo7n2t1fOshvCE90L4+HCA=;
        b=fMBTllFbi5CRsMKdL3deJDoNDCfPPbH3eUL+Y2farcA0uT6jdIqGXaeKgNLsgeuP44PrzK
        yJ2INt2H36mQlOu9yeiBxvSY30N07QM/wa521X32ueZA95FcqlMthcy7qv7ZRJ1KMDehao
        yqR9M9tVyoH7bwbT8OfDlkEGl+YPrI4bWEUeSvgXhnOBXE4dyA96yobaT2A3Nmx7b2QJdH
        +WIxpstG23uxLa5AgVCNEDB5K70AHkbJqfwyOwJPiKqRnUg9t5PBmAMvTjza5T1vF4Tc9b
        TXtGTXdhbYFlZB3T0e+8PoX39Osg2K4VrTI2HXkrI6dmvtNAZ2vQLNaCWHgDbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644340221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pVIJUQJ0Ki8jKxcVnu+JXzo7n2t1fOshvCE90L4+HCA=;
        b=OUZleW8SVui/wDg8abv+0fBP7W8jblNX0+mj1AqKnxF/2Tr19Z58pkEFB/x2VkDjxM49Q3
        QX1QiPFUyYqqfoAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>, Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH REPOST 0/8] kernel/fork: Move thread stack free otu of
 the scheduler path.
Message-ID: <YgKj+363/qsJHRGA@linutronix.de>
References: <20220125152652.1963111-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220125152652.1963111-1-bigeasy@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-25 16:26:44 [+0100], To linux-kernel@vger.kernel.org wrote:
> [ This is a repost of https://lkml.kernel.org/r/20211118143452.136421-1-bigeasy@linutronix.de ]
> 
> This is a follup-up on the patch
>     sched: Delay task stack freeing on RT 
>     https://lkml.kernel.org/r/20210928122411.593486363@linutronix.de
> 
> It addresses the review feedback:
> - Decouple stack accounting from its free invocation. The accounting
>   happens in do_exit(), the final free call happens later.
> 
> - Add put_task_stack_sched() to finish_task_switch(). Here the VMAP
>   stack is cached only. If it fails, or in the !VMAP case then the final
>   free happens in delayed_put_task_struct(). This is also an oportunity
>   to cache the stack.
> 
> >From testing I observe the following:
> 
> |            bash-1715    [006] .....   124.901510: copy_process: allocC ffffc90007e70000
> |      sh-cmds.sh-1746    [007] .....   124.907389: copy_process: allocC ffffc90007dc4000
> |          <idle>-0       [019] ...1.   124.918126: free_thread_stack: cache ffffc90007dc4000
> |      sh-cmds.sh-1746    [007] .....   124.918279: copy_process: allocC ffffc90007de8000
> |          <idle>-0       [004] ...1.   124.920121: free_thread_stack: delay ffffc90007de8001
> |          <idle>-0       [007] ...1.   124.920299: free_thread_stack: cache ffffc90007e70000
> |          <idle>-0       [007] ..s1.   124.945433: free_thread_stack: cache ffffc90007de8000
> 
> TS 124.901510, bash started sh-cmds.sh, obtained stack from cache.
> TS 124.907389, script invokes its first command, obtained stacak from
> cache. As you can see bash was running on CPU6 but its child was moved
> CPU7. 
> TS 124.918126, the first command is done, stack is ached on CPU19.
> TS 124.918279, script's second command, ache from stack.
> TS 124.920121, the command is done. The stack cache on CPU4 is full.
> TS 124.920299, the script is done, caches stack on CPU7.
> TS 124.945433, the RCU-callback of last command is now happening. On
> CPU7, which is where the command was invoked (but not running). Instead
> of freeing the stack, it was cached since CPU7 had an empty slot.
> 
> If I pin the script to CPU5 and run it with multiple commands then it
> works as expected:
> 
> |            bash-1799    [005] .....   993.608131: copy_process: allocC ffffc90007fa0000
> |      sh-cmds.sh-1827    [005] .....   993.608888: copy_process: allocC ffffc90007fa8000
> |      sh-cmds.sh-1827    [005] .....   993.610734: copy_process: allocV ffffc90007ff4000
> |      sh-cmds.sh-1829    [005] ...1.   993.610757: free_thread_stack: cache ffffc90007fa8000
> |      sh-cmds.sh-1827    [005] .....   993.612401: copy_process: allocC ffffc90007fa8000
> |           <...>-1830    [005] ...1.   993.612416: free_thread_stack: cache ffffc90007ff4000
> |      sh-cmds.sh-1827    [005] .....   993.613707: copy_process: allocC ffffc90007ff4000
> |      sh-cmds.sh-1831    [005] ...1.   993.613723: free_thread_stack: cache ffffc90007fa8000
> |      sh-cmds.sh-1827    [005] .....   993.615024: copy_process: allocC ffffc90007fa8000
> |           <...>-1832    [005] ...1.   993.615040: free_thread_stack: cache ffffc90007ff4000
> |      sh-cmds.sh-1827    [005] .....   993.616380: copy_process: allocC ffffc90007ff4000
> |           <...>-1833    [005] ...1.   993.616397: free_thread_stack: cache ffffc90007fa8000
> |            bash-1799    [005] ...1.   993.617759: free_thread_stack: cache ffffc90007fa0000
> |          <idle>-0       [005] ...1.   993.617871: free_thread_stack: delay ffffc90007ff4001
> |          <idle>-0       [005] ..s1.   993.638311: free_thread_stack: free ffffc90007ff4000
> 
> and no new is allocated during its runtime and a cached stack is used.

ping

Sebastian
