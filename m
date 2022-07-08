Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0679D56C44B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237073AbiGHWjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 18:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbiGHWjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 18:39:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE39813B463
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 15:39:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 861EF62168
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 22:39:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95642C341C0;
        Fri,  8 Jul 2022 22:39:08 +0000 (UTC)
Date:   Fri, 8 Jul 2022 18:39:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH RESEND] sched/core: Use try_cmpxchg in
 set_nr_{and_not,if}_polling
Message-ID: <20220708183906.345aae71@gandalf.local.home>
In-Reply-To: <20220629151552.6015-1-ubizjak@gmail.com>
References: <20220629151552.6015-1-ubizjak@gmail.com>
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

On Wed, 29 Jun 2022 17:15:52 +0200
Uros Bizjak <ubizjak@gmail.com> wrote:

> +++ b/kernel/sched/core.c
> @@ -873,15 +873,11 @@ static inline void hrtick_rq_init(struct rq *rq)
>  	({								\
>  		typeof(ptr) _ptr = (ptr);				\
>  		typeof(mask) _mask = (mask);				\
> -		typeof(*_ptr) _old, _val = *_ptr;			\
> +		typeof(*_ptr) _val = *_ptr;				\
>  									\
> -		for (;;) {						\
> -			_old = cmpxchg(_ptr, _val, _val | _mask);	\
> -			if (_old == _val)				\
> -				break;					\
> -			_val = _old;					\
> -		}							\
> -	_old;								\
> +		do {							\
> +		} while (!try_cmpxchg(_ptr, &_val, _val | _mask));	\

I'm curious to why use a do { } while() and not just:

		while (!try_cmpxchg(_ptr, &_val, _val | _mask))
			;

I see that this is Peter's recommended way from commit a9ebf306f52c75
("locking/atomic: Introduce atomic_try_cmpxchg()")

Peter, why the do { } while() ?

Does it generate better asm than while () ; ?

-- Steve

> +	_val;								\
>  })
