Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0034EEC85
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 13:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345577AbiDALs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 07:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbiDALs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 07:48:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562DF105AAE
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 04:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OZFs7F262Q8FQ0CV6Jac14Udq9DNIeDRc8Lf3Vk/b6g=; b=s8F+bYxxN4swSiGTmh1gY6FZRh
        azmBXlsL5bv1zKEOPbljlegcsa3hcQnx5N/X9OS5a2dS0Bh6NjpJ7Mm2MC1Si87WNHUm78HWS+XWk
        XeJUZxoW/80bZEGek1z9R1qNRKqaI2zJeWuMKMgE9P2ofZCyAXHZH+0fYYeIoibN6i+K3h09jCHmY
        CzFgfQz4prznBRuK9iaPjMZdg85dsxh8NZAp5nMWDghUJ4fnhIZd+PHp5sPim+wWYE8Do3ZchcsSJ
        eIPokJeBGJa3mZROqlcjbbBzr2QqOx1LrMp4DWZfWS4Ezo0igrMM+t0J7pwlklJGl8mm+Of/KeM73
        StS/poHw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1naFjP-00398p-TR; Fri, 01 Apr 2022 11:46:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4AF5D300212;
        Fri,  1 Apr 2022 13:46:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 33AB12007DF3D; Fri,  1 Apr 2022 13:46:18 +0200 (CEST)
Date:   Fri, 1 Apr 2022 13:46:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH] sched/core: Fix forceidle balancing
Message-ID: <YkbmCr6ojXYiWzkP@hirez.programming.kicks-ass.net>
References: <20220330160535.GN8939@worktop.programming.kicks-ass.net>
 <CAEXW_YQNi42gahbSJ1skadh_8D+Ry6ZOmMqSU5BdidfCbmOtRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YQNi42gahbSJ1skadh_8D+Ry6ZOmMqSU5BdidfCbmOtRg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 03:00:40PM -0400, Joel Fernandes wrote:
> Hi,
> 
> By the way, might be slightly related - we still see crashes with
> pick_task_fair() in our kernel even with this change:
> https://lkml.org/lkml/2020/11/17/2137

Please as to not use lkml.org. Please use something with a MsgID in like
lore.

> Is it possible that when doing pick_task_fair() especially on a remote
> CPU, both the "cfs_rq->curr" and the rbtree's "left" be NULL with core
> scheduling? In this case, se will be NULL and can cause crashes right?
> I think the code assumes this can never happen.
> 
> +Guenter Roeck  kindly debugged pick_task_fair() in a crash as
> follows. Copying some details he mentioned in a bug report:
> 
> Assembler/source:
> 
>   25:   e8 4f 11 00 00          call   0x1179             ; se =
> pick_next_entity(cfs_rq, curr);
>   2a:*  48 8b 98 60 01 00 00    mov    0x160(%rax),%rbx   ; trapping
> instruction [cfs_rq = group_cfs_rq(se);]
>   31:   48 85 db                test   %rbx,%rbx
>   34:   75 d1                   jne    0x7
>   36:   48 89 c7                mov    %rax,%rdi
> 
> At 2a: RAX = se == NULL after pick_next_entity(). Looking closely into
> pick_next_entity(), it can indeed return NULL if curr is NULL and if
> left in pick_next_entity() is NULL. Per line 7:, curr is in %r14 and
> indeed 0.
> 
> Thoughts?

It is possible for ->curr and ->leftmost to be NULL, but then we should
also be having ->nr_running == 0 and not call pick in the first place.
Because picking a task from no tasks doesn't make much sense.
