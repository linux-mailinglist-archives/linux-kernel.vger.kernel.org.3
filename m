Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D56758A7EB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 10:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239984AbiHEITN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 04:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiHEITL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 04:19:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2CA74CE0
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 01:19:10 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 62F1C2024C;
        Fri,  5 Aug 2022 08:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659687549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xgtt9kzVWfZSVp0PoBg/cZ+kftEKip8e85AsU4Im3t0=;
        b=erdCUU2qN+3K03QyJvMCnfMy/rgIdAwdXf0V8P+lIjeWmBSbsxpkUVVbf8xFW/jc+5cqsK
        MzjEwqLl57RZtRuxSLSIjFXAmgmDiA6tz3xe9dX8Mn+DXwflHcUv9L2E3/tEvO9VgLmJWg
        LpXNZ5JkVbhdFC36zzRhQQIJIEgE+k0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659687549;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xgtt9kzVWfZSVp0PoBg/cZ+kftEKip8e85AsU4Im3t0=;
        b=euAtSjRQGCkgEKDL/BR+WsE16YLw3HZImAspNhQHbtUWykxTSwzUNaqY46fNU0OSrdeznr
        6P1SC+WbIvuz9hDQ==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7ADD62C141;
        Fri,  5 Aug 2022 08:19:07 +0000 (UTC)
Date:   Fri, 5 Aug 2022 09:19:04 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     "guanjing (D)" <guanjing6@huawei.com>
Cc:     srikar@linux.vnet.ibm.com, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: Question about how to fix numabalancing to work with
 isolated cpus?
Message-ID: <20220805081904.GJ3493@suse.de>
References: <ccd220cd-fbca-ad8a-c290-e812c4850e2f@huawei.com>
 <83e7d5ee-e5b7-9a71-7532-9d4d13aaf706@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <83e7d5ee-e5b7-9a71-7532-9d4d13aaf706@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 02:42:18PM +0800, guanjing (D) wrote:
> On 2022/6/25 14:33, guanjing (D) wrote:
> > Hi,
> >     I notice a problem that you guys discussed in the link below:
> > 
> >     https://lore.kernel.org/all/1491464210.4718.82.camel@gmx.de/T/
> >     "The isolated cpus are part of the cpus allowed list. In the above
> > case,
> >      numabalancing ends up scheduling some of these tasks on isolated
> > cpus. "
> > 
> >     I wonder if we're going to fix this eventually?
> > 

The last discussion did not reach a solid conclusion. Isolated CPUs
are avoided by the general CPU scheduler but if a task explicitly uses
sched_setaffinity() to include the isolated CPUs then by definition it's
allowed to use those CPUs and NUMA balancing will use allowed CPUs to
improve locality if possible. It's not clear that this is a bug at all
other than it may be surprising in some cases. Furthermore, a task that
is sensitive to latency probably should be using mempolicies to avoid NUMA
balancing entirely as it's a source of interference.

There needs to be a use case that describes exactly what the sematics should
be for a task using isolated CPUs and why. For example, if the task policy
only allowed isolated CPUs then NUMA balancing may never be able to select
a CPU with task_numa_find_cpu, is that expected? Should it be the case
that NUMA balancing avoids isolated CPUs but will select one if no other
local CPU is available? If so, why? If only isolated CPUs are available,
is it expected and desired that data will be migrated instead? If a task is
running on an isolated CPU, should NUMA balancing avoid moving the task off
the CPU? If so, why? Should the behaviour be that if a task is allowed to
run on isolated CPUs, should NUMA balancing simply be disabled? If so, why?
Whatever the result, the sematics should be mentioned under the isocpus=
parameter with an additional note under numa_balancing=.

If anything is to change here, it needs to be made clear why it's a bug
that NUMA balancing selects an allowed but isolated CPU and a description
of what the desired semantics should be.

-- 
Mel Gorman
SUSE Labs
