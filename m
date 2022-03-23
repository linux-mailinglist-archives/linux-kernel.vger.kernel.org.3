Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0064E4DDE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 09:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238591AbiCWIN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 04:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242490AbiCWINT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 04:13:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DD874DF2;
        Wed, 23 Mar 2022 01:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=zRHnqLvHx5916xPDy2fRbtdlFaJO9x65pxV63dHDKRg=; b=A4JixclgJO6tlDJ9blzjPMbh8y
        Kc52ZsJeTwWN32kOmdkWoHtbqszIqFHlSnFB9JJV72bdOMA0n42IbZGY1iXdIzvhsy3U6vuf7g/VB
        MhK3oKGwkyxYC1jAWg2KNRqzfjcyZ/o3VvJXTBzttCzxhyTe/2WLs6NHfLxJYN3hhGwph9FHRwALa
        YXuqmcedOqMiUyC0+w+zN8eZvwJjaVw1XZ4OTGtsGuiN4vl9BA+3J1HGJ14KKpOOQc4Tvlb6YY7wL
        TEyfW0Ik3UpEBwusxWnGHxadJ+wQtJwYcAg6SoQXj8IoECoTp1V/xPAQja3zBfT3LtUYmxDXZuDz5
        0u0n/xGg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWw5j-00CLjt-KJ; Wed, 23 Mar 2022 08:11:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E9B6830021B;
        Wed, 23 Mar 2022 09:11:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A128920C5903E; Wed, 23 Mar 2022 09:11:38 +0100 (CET)
Date:   Wed, 23 Mar 2022 09:11:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
Subject: Re: [External] Re: [PATCH v2 1/6] perf/core: Fix incosistency
 between cgroup sched_out and sched_in
Message-ID: <YjrWOrd4Ze3/6sl2@hirez.programming.kicks-ass.net>
References: <20220322120834.98637-1-zhouchengming@bytedance.com>
 <20220322120834.98637-2-zhouchengming@bytedance.com>
 <YjnIKCIRV+ePJVCN@hirez.programming.kicks-ass.net>
 <b55676c3-07da-f4f1-e4c8-252cd9d4fac2@bytedance.com>
 <YjnjHPuNjo8YTwiQ@hirez.programming.kicks-ass.net>
 <cdfb252e-9bfc-bee3-7ebe-b8ef401c85dd@bytedance.com>
 <1c9f2383-ec9f-f819-d7be-23aed2bf121a@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c9f2383-ec9f-f819-d7be-23aed2bf121a@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 11:28:41PM +0800, Chengming Zhou wrote:
> On 2022/3/22 11:16 下午, Chengming Zhou wrote:
> > Hi peter,
> > 
> > On 2022/3/22 10:54 下午, Peter Zijlstra wrote:
> >> On Tue, Mar 22, 2022 at 09:38:21PM +0800, Chengming Zhou wrote:
> >>> On 2022/3/22 8:59 下午, Peter Zijlstra wrote:
> >>>> On Tue, Mar 22, 2022 at 08:08:29PM +0800, Chengming Zhou wrote:
> >>>>> There is a race problem that can trigger WARN_ON_ONCE(cpuctx->cgrp)
> >>>>> in perf_cgroup_switch().
> >>>>>
> >>>>> CPU1					CPU2
> >>>>> (in context_switch)			(attach running task)
> >>>>> perf_cgroup_sched_out(prev, next)
> >>>>> 	cgrp1 == cgrp2 is True
> >>>>> 					next->cgroups = cgrp3
> >>>>> 					perf_cgroup_attach()
> >>>>> perf_cgroup_sched_in(prev, next)
> >>>>> 	cgrp1 == cgrp3 is False
> 
> I see, you must have been misled by my wrong drawing above ;-)
> I'm sorry, perf_cgroup_attach() on the right should be put at the bottom.
> 
> CPU1						CPU2
> (in context_switch)				(attach running task)
> perf_cgroup_sched_out(prev, next)
> 	cgrp1 == cgrp2 is True
> 						next->cgroups = cgrp3
> perf_cgroup_sched_in(prev, next)
> 	cgrp1 == cgrp3 is False
> 						__perf_cgroup_move()
> 

Ohhhh, you're taking about CPU2 running cgroup_migrate_execute()...
clear as mud this :/

I think I remember this race; in the scheduler we fixed it by not using
task_css to track the active cgroup and using the various cgroup_subsys
hooks to keep an internally consistent set of state.

But let me go look at what you did in this new light.
