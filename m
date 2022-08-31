Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF555A79F9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbiHaJTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbiHaJS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:18:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC2CCC32F
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 02:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FJBQUniwgWSASvXreg4vLlVkMxLkErd8CubArxprFvg=; b=Oqu5JbzpdfnrOcdqYhOu//IDa6
        M+2AokEK9Wjavi4nT9GB9ZsyQVo53TgrBJ9+k2pF8ALzuKaXzrQLyKP34ePJahT+q3BW1nk9eoOyu
        ZNquuKudoE5xK2zvJlx1rFKQ5AcGPiYg44WulolR3ekyOxPjLL1F5219xYe1WZL+QZuclVnEBYIpm
        Ft4pnrBsP02Roo/Z1GmPY+XWLeG0PO8rfwXJEi1ADFoIbq/4Raas+9cLRnHWln4IU/ohMJOLbEggW
        T0ThoZE5P+pwWAPIyCML6L+4S3clqJzaDLPYS9WmvMNcv1t63Zg9JkuY9ertUEh4jJ8m/SelU5grf
        B2bBJfcA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTJrb-0087Lu-3y; Wed, 31 Aug 2022 09:18:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8090A3002A3;
        Wed, 31 Aug 2022 11:18:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6863C20A3C659; Wed, 31 Aug 2022 11:18:22 +0200 (CEST)
Date:   Wed, 31 Aug 2022 11:18:22 +0200
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
Subject: Re: [PATCH v6 3/5] sched: Enforce user requested affinity
Message-ID: <Yw8nXttOnNjK/1y4@hirez.programming.kicks-ass.net>
References: <20220826010119.1265764-1-longman@redhat.com>
 <20220826010119.1265764-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826010119.1265764-4-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 09:01:17PM -0400, Waiman Long wrote:

> @@ -9352,6 +9381,11 @@ int sched_cpu_activate(unsigned int cpu)
>  		sched_update_numa(cpu, true);
>  		sched_domains_numa_masks_set(cpu);
>  		cpuset_cpu_active();
> +		/*
> +		 * Preallocated scratch cpumask
> +		 */
> +		if (!rq->scratch_mask)
> +			rq->scratch_mask = kmalloc(cpumask_size(), GFP_KERNEL);
>  	}

this is too late; I think you'll have to add a sched_cpu_prepare() and
simply fail the cpu-up when the allocation fails.
