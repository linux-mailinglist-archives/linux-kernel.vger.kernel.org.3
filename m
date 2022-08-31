Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EE35A7A30
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbiHaJ05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbiHaJ0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:26:32 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930185C96C
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 02:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dGrzA//sBi0/D6XL3BsdXVXuGk+Ooo5/HEM/2r0Rp00=; b=Ey9XAE4JEGiGxwh3wKGyaveis0
        efzfXesZfkkq6DfA0KdLzxBDZq4Zd+imS2bc4E2BTX6r/BMbGivyfxG/HtIs+xM8eLuee/euUifMQ
        Sa6/oxNX8sMQgIbdOaxBp4aM2qqc4uXIlxxvuQBFwmxaIfahEXO0TshUNwKr4b816HHl1RK6ZkZtE
        Od4P3drKc4mMJbmmLEs2s1qC0y7A8HNcjsQetGwUVdSmA/UDOyk2oZkSH3be38rr65ORci0YFe1c6
        vlP5GAC6tC6tkad22ITMn7v3Rb4RMacYYD0jQHXhkmI74LVBXzgxL8nhHFQ7Kz4+T5vLFYE4woK3J
        ES1lUsUg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTJzG-0087TE-2s; Wed, 31 Aug 2022 09:26:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 530B83002AF;
        Wed, 31 Aug 2022 11:26:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1326F2B848083; Wed, 31 Aug 2022 11:26:17 +0200 (CEST)
Date:   Wed, 31 Aug 2022 11:26:17 +0200
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
Message-ID: <Yw8pOVhOV9XVe9nq@hirez.programming.kicks-ass.net>
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
> Racing is possible between set_cpus_allowed_ptr() and sched_setaffinity()
> or between multiple sched_setaffinity() calls from different CPUs. To
> resolve these race conditions, we need to update both user_cpus_ptr
> and cpus_mask in a single lock critical section instead of separated
> ones. This requires moving the user_cpus_ptr update to
> affine_move_task() before doing task_rq_unlock().
> 
> A new argument puser_mask is added to affine_move_task(),
> __set_cpus_allowed_ptr_locked() and __set_cpus_allowed_ptr() to do that.
> 
> Ideally, user_cpus_ptr should only be updated if the sched_setaffinity()
> is successful. However, this patch will update user_cpus_ptr when the
> first call to __set_cpus_allowed_ptr() is successful. However, if there
> is racing between sched_setaffinity() and cpuset update, the subsequent
> calls to __set_cpus_allowed_ptr() may fail but the user_cpus_ptr will
> still be updated in this corner case.

Urgh, this is a bit weird, to have a fix for a patch in the same series.


