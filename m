Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54AD45A7A85
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiHaJsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiHaJsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:48:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEA2CE469
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 02:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Cf9TnC387IwylnNLFGlULWkgPWH/rPct++G8BVlv86g=; b=n1LtHZnGkloKyDttaheg6s8LlQ
        EFm0uswU6Dlgx2QtbcwuSJUAQqRNDAq/qt+tQte1ZyZ0cAbQYQt1m7BsSTp2Rvv9G19wnW/O1zJsA
        gwfr7Dr7L+8jLco0d9Kg9TO5YBD2ZVgWhxVh9vI2pKUjSqqFAPN4QhJThNLgXrvRJC1ngw9mPbTrB
        jQz/zfdkrEWwCyWOettyc46Kw5PWtAschgjEQXlrH8bG5OhTl7U2qZBo9LFEabsCnqAKuuY+vDau4
        jMgM2leoCwq7Swxrb5dWGOwjGaJf7mv2wRztBsAieVd0d5Udi/aW5+tLjzoHCfzz1ZB3GZcMEHr74
        HORX1eVw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTKKE-004yjN-Bn; Wed, 31 Aug 2022 09:47:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DF2803002AF;
        Wed, 31 Aug 2022 11:47:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BBBA62B846314; Wed, 31 Aug 2022 11:47:55 +0200 (CEST)
Date:   Wed, 31 Aug 2022 11:47:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v6 4/5] sched: Handle set_cpus_allowed_ptr() &
 sched_setaffinity() race
Message-ID: <Yw8uS0Ibavb/5s4D@hirez.programming.kicks-ass.net>
References: <20220826010119.1265764-1-longman@redhat.com>
 <20220826010119.1265764-5-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826010119.1265764-5-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 09:01:18PM -0400, Waiman Long wrote:
> @@ -2722,6 +2734,7 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
>  			complete = true;
>  		}
>  
> +		swap_user_cpus_ptr(p, puser_mask);
>  		task_rq_unlock(rq, p, rf);
>  
>  		if (push_task) {
> @@ -2793,6 +2806,7 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
>  		if (flags & SCA_MIGRATE_ENABLE)
>  			p->migration_flags &= ~MDF_PUSH;
>  
> +		swap_user_cpus_ptr(p, puser_mask);
>  		task_rq_unlock(rq, p, rf);
>  
>  		if (!stop_pending) {
> @@ -2813,6 +2827,8 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
>  				complete = true;
>  			}
>  		}
> +
> +		swap_user_cpus_ptr(p, puser_mask);
>  		task_rq_unlock(rq, p, rf);
>  
>  		if (complete)

I'm not at all sure about those.

Would it not be much simpler to keep the update of cpus_mask and
cpus_user_mask together, always ensuring that cpus_user_mask is a strict
superset of cpus_mask ? That is, set_cpus_allowed_common() seems like
the right place to me.

I'm thinking this also means blowing away user_mask when we do a full
reset of the cpus_mask when we do an affnity break.
