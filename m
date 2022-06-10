Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059AF5468F3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 17:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241784AbiFJPCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 11:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235359AbiFJPCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 11:02:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A516F5591
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 08:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MMamMozSU0lt71fkNRztUcrBMIG6otrozeRODZjN/s0=; b=uXUTphWIWUHFgZ00Lf0D6gsBVa
        F4ft7HmGxaJLbbJqrvnK3bTxSfPFdec+4lXAQNwCJli3ce9I9iuwgXgQ9VKVGCZmKWGDkUHk75r5i
        pRGz6TOydJLzkmc3q9KonKfNsSmmiIYWhESq9qWA1H9SKa7jC8VB4u7dHhTlZQyO5CJ4PgYEdUkB6
        Ux7tVh9sCtCGmXpc0zTkXy5Eat0FlZZstKYBL4aqhA6NV59znZXVyFMTmeSjDlnBAF6ttSapRkB48
        hRvfMGJJkzyou/HxVQbceE8UWoMeUUpcLR7XB1IgxA3L8PWorjqJdlvnr9dhppRtIQ5XToApBiaTU
        Y5xv/6sg==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nzg8g-00EXCC-Ri; Fri, 10 Jun 2022 15:01:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EBD8530008D;
        Fri, 10 Jun 2022 17:01:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DCACB2845F219; Fri, 10 Jun 2022 17:01:27 +0200 (CEST)
Date:   Fri, 10 Jun 2022 17:01:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Valentin Schneider <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        aubrey.li@linux.intel.com, efault@gmx.de, gautham.shenoy@amd.com,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        mingo@kernel.org, song.bao.hua@hisilicon.com,
        srikar@linux.vnet.ibm.com, valentin.schneider@arm.com
Subject: Re: [PATCH v7] sched/fair: Consider cpu affinity when allowing NUMA
 imbalance in find_idlest_group
Message-ID: <YqNcx34HzVEnJmCf@hirez.programming.kicks-ass.net>
References: <20220407111222.22649-1-kprateek.nayak@amd.com>
 <YqHfdn9O81Ir1+bI@worktop.programming.kicks-ass.net>
 <xhsmhr13w7pp2.mognet@vschneid.remote.csb>
 <YqNR+y5I/3UeVa/g@hirez.programming.kicks-ass.net>
 <CAKfTPtBDqgpjR2tkgQ6hwYnZ2b1azMX0EKQL1cbuUVbK48MnHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBDqgpjR2tkgQ6hwYnZ2b1azMX0EKQL1cbuUVbK48MnHA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 04:42:05PM +0200, Vincent Guittot wrote:

> The test was there to not do the computation with cpumask_and() if the
> task's affinity has not been modified so maybe it would be enough to
> test (p->nr_cpus_allowed != NR_CPUS) to check if the task's affinity
> has been modified and we have we do the cpumask_and()  and
> cpumask_weight()

Yeah, I suppose that's the best we can do. I was thinking that perhaps
some cgroup/cpuset thing is common these days, in which case pretty much
all tasks will have their affinity set through the cpuset muck, but
alas, nothing really do be done about that.


