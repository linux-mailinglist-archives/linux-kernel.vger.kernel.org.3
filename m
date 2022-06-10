Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE3654681B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 16:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242644AbiFJOQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 10:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237558AbiFJOQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 10:16:17 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058592FB417
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 07:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i1pnObH4yVjp/HDD+qUYdQC4t9fZeEPPJelx98SigEY=; b=p7egrZvMS2Y9KrzjOHbLmnjgp9
        tf6Db/wOt7Fz/BoPt073vUPix7G0Cp8Iwr1h3+E86yZbrG9Mv68K5t40aseJTLV3A39anwSitGs+b
        J6zbsCkiP5YUNgvSFkoau4C49IzlsvNUKpgeeRBDd88hBB1kH+VMxmM0eN+A7CDTKPJjfV9tndihp
        OIitbWLfyr30AtEEqKH/DXj0GuuSd1zV8cCmFPrmK0i67rGx0cYXMJiQvr//9L53//6do5PQHo918
        n9eIcmEx6NwIxPXDkWEfMkYJjq2LrxzvaGActy6ks7cN/fqCzP7DC3qLwWzeyubQyvsmdZe2iafV5
        O71I+2hg==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nzfQB-006gPG-0X; Fri, 10 Jun 2022 14:15:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 156FD300237;
        Fri, 10 Jun 2022 16:15:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ED8D32666E9E0; Fri, 10 Jun 2022 16:15:23 +0200 (CEST)
Date:   Fri, 10 Jun 2022 16:15:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     K Prateek Nayak <kprateek.nayak@amd.com>,
        aubrey.li@linux.intel.com, efault@gmx.de, gautham.shenoy@amd.com,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        mingo@kernel.org, song.bao.hua@hisilicon.com,
        srikar@linux.vnet.ibm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org
Subject: Re: [PATCH v7] sched/fair: Consider cpu affinity when allowing NUMA
 imbalance in find_idlest_group
Message-ID: <YqNR+y5I/3UeVa/g@hirez.programming.kicks-ass.net>
References: <20220407111222.22649-1-kprateek.nayak@amd.com>
 <YqHfdn9O81Ir1+bI@worktop.programming.kicks-ass.net>
 <xhsmhr13w7pp2.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhr13w7pp2.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 11:55:37AM +0100, Valentin Schneider wrote:
> On 09/06/22 13:54, Peter Zijlstra wrote:
> > Now, I can (and have) fixed up the conflict, but it did make me look at
> > this in a little more detail; and the thing I noticed is that your:
> >
> >   'p->nr_cpus_allowed != num_online_cpus()'
> >
> > test makes no sense. That's basically 'true'. The thing is,
> > nr_cpus_allowed is initialized to NR_CPUS, and unless someone somewhere
> > did set_cpus_allowed() on it, it'll still be NR_CPUS.
> >
> > Also, CPU hotplug doesn't change nr_cpus_allowed, so num_online_cpus()
> > is just plain wrong.
> >
> > Now, something that might work is:
> >
> >   'p->nr_cpus_allowed < num_online_cpus()'
> >
> > And even that is no guarantee. You can construct a situation where this
> > is still false even though you actually have a constrained set.
> > Consider a machine with 8 CPUs. Then set the mask to: 0x55, which has 4
> > CPUs set. Then offline the last 4 so that the online mask becomes 0x0f.
> >
> > Then the effective mask is 0x05, and the number we're looking for above
> > is 2, but the suggested test would still be false, because
> > nr_cpus_allowed would be 4, as would num_online_cpus().
> >
> 
> IIUC we want to pay special attention when the task isn't allowed to run on
> all online CPUs, wouldn't the below do that?
> 
>   !cpumask_subset(cpu_online_mask, p->cpus_ptr)

At that point we might just as well do the whole cpumask_and() thing,
no? There's not much cost difference between these two operations.

> The task affinity can be a superset of the online mask, obvious case is
> init_task's CPU_MASK_ALL, and the above test is still false if both masks
> are equal.
> 
> (Additionnaly we could add a step in sched_init() to "properly" initialize
> the init_task mask and remove the NR_CPUS faff).

I'm confused, NR_CPUS is the right value for CPU_MASK_ALL.
