Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAF94ECD10
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 21:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350687AbiC3TQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 15:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348194AbiC3TQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 15:16:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02DB739B84
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 12:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648667685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sQDyBNpGrMN7ywMTAlTALpF3WLkUS9v/wRG/zBzNFyU=;
        b=XH4y0MIAElzyFn8ZvVS5Mw5h1falOin0AFLOq6DXyz5TWm2UMa0dZbOX7sd7yiXChVx8j0
        GUcYnnuGZi8+2AHfbIvblR47heNe97HI5NuCoQ2Y//Htbibcnv0SC1pfNBsM7F+6KRdOer
        JSo3PzcdhiQRyGf7oIS1mTpQPC5nRkI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-_P0UcunzPlej2zvc1UgRTg-1; Wed, 30 Mar 2022 15:14:42 -0400
X-MC-Unique: _P0UcunzPlej2zvc1UgRTg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C8AC03804505;
        Wed, 30 Mar 2022 19:14:41 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F77E400E10D;
        Wed, 30 Mar 2022 19:14:41 +0000 (UTC)
Date:   Wed, 30 Mar 2022 15:14:40 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [External] Re: [PATCH] sched/fair: fix broken bandwidth control
 with nohz_full
Message-ID: <20220330191439.GC17246@pauld.bos.csb>
References: <20220328110751.39987-1-zhouchengming@bytedance.com>
 <20220328132047.GD8939@worktop.programming.kicks-ass.net>
 <c0465b27-328a-1288-fb50-d4c6321c8b4d@bytedance.com>
 <YkHRmv/OcABIB0wP@hirez.programming.kicks-ass.net>
 <6fc49cff-f8a1-8b09-5a25-a64e5d07d258@bytedance.com>
 <YkHal1m3pnxGoQ1Y@hirez.programming.kicks-ass.net>
 <20220328124454.08ab6126@gandalf.local.home>
 <20220330182327.GO8939@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330182327.GO8939@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Wed, Mar 30, 2022 at 08:23:27PM +0200 Peter Zijlstra wrote:
> On Mon, Mar 28, 2022 at 12:44:54PM -0400, Steven Rostedt wrote:
> > On Mon, 28 Mar 2022 17:56:07 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > > echo $$ > test/cgroup.procs
> > > > taskset -c 1 bash -c "while true; do let i++; done"  --> will be throttled  
> > > 
> > > Ofcourse.. I'm arguing that bandiwdth control and NOHZ_FULL are somewhat
> > > mutually exclusive, use-case wise. So I really don't get why you'd want
> > > them both.
> > 
> > Is it?
> > 
> > One use case I can see for having both is for having a deadline task that
> > needs to get something done in a tight deadline. NOHZ_FULL means "do not
> > interrupt this task when it is the top priority task on the CPU and is
> > running in user space".
> 
> This is absolute batshit.. It means no such thing. We'll happily wake
> another task to this CPU and re-enable the tick any instant.
> 
> Worse; the use-case at hand pertains to cfs bandwidth control, which
> pretty much guarantees there *will* be an interrupt.

The problem is (at least in some cases) that container orchestration userspace
code allocates a whole CPU by setting quota == period.  Or 3 cpus as 3*period etc.

In cases where an isolated task is expected to run uninterrupted (only task in 
the system affined to that cpu, nohz_full, nocbs etc) you can end up with it
getting throttled even though it theoritically has enough bandwidth for the full
cpu and therefore should never get throttled. 

There are radio network setups where the packet processing is isolated
like this but the system as a whole is managed by container orchestration so 
everything has cfs bandwidth quotas set.

I don't think generally the bandwidth controls in these cases are used for 
CPU sharing (quota < period). I agree that doesn't make much sense with NOHZ_FULL
and won't work right. 

It's doled out as full cpu(s) in these cases.

Thats not a VM case so is likely different from the one that started this thread
but I thought I should mention it.


Cheers,
Phil

> 
> > Why is it mutually exclusive to have a deadline task that does not want to
> > be interrupted by timer interrupts?
> 
> This has absolutely nothing to do with deadline tasks, nada, noppes.
> 
> > Just because the biggest pushers of NOHZ_FULL is for those that are running
> > RT tasks completely in user space and event want to fault if it ever goes
> > into the kernel, doesn't mean that's the only use case.
> 
> Because there's costs associated with the whole thing. system entry/exit
> get far more expensive. It just doesn't make much sense to use NOHZ_FULL
> if you're not absoultely limiting system entry.
> 
> > Chengming brought up VMs. That's a case to want to control the bandwidth,
> > but also not interrupt them with timer interrupts when they are running as
> > the top priority task on a CPU.
> 
> It's CFS, there is nothing top priority about that.
> 

-- 

