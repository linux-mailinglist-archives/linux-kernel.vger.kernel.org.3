Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910C348D4E7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 10:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiAMJTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 04:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiAMJT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 04:19:29 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE10C06173F;
        Thu, 13 Jan 2022 01:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r2/88PY3CELroJwlxZy5NPooVbIHDs4v124Txrn+jhs=; b=rbKQHhV+vic4k+qq7XvubgV/Yo
        feRrrWSc0daH5KbJS4IXfoqIyNGe/dFaiNtU0NomTRg5fdOX4q8qlQHUVTbiCpuYxaobBOQKiH2sV
        fgmrtTW0R7DpmpKDY8sYyl03ehyr1CpJP8yH68WdAg3YW8lYIgy3H0bfDQdvFDBeBaf3pPYLJl8og
        t6lIoxzinEp+hmDWLtwWZOLu9Uu4uGBLPG9e0zIV2YsGQjCmsr9qkMureuqKi7kDCTmiaqNeUR5yH
        TavCLk6sxDPCFCA+Rd/kQOlabAdVQJO0QK6unh/f65cqKug2G9LBrV0fc5OPykkTplaATTefI/9J5
        kZrBI+/w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7wG4-000wrA-PK; Thu, 13 Jan 2022 09:19:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 20E1D300222;
        Thu, 13 Jan 2022 10:18:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EC613264EE459; Thu, 13 Jan 2022 10:18:57 +0100 (CET)
Date:   Thu, 13 Jan 2022 10:18:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Xiu Jianfeng <xiujianfeng@huawei.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, gustavoars@kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH -next, v2] sched: Use struct_size() helper in
 task_numa_group()
Message-ID: <Yd/ugQ8kUmcceuex@hirez.programming.kicks-ass.net>
References: <20220110012354.144394-1-xiujianfeng@huawei.com>
 <Ydy3N577YD0JJr2N@hirez.programming.kicks-ass.net>
 <20220110193158.31e1eaea@gandalf.local.home>
 <Yd1qYsFcgcp/uHSa@hirez.programming.kicks-ass.net>
 <20220111101425.7c59de5b@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111101425.7c59de5b@rorschach.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 10:14:25AM -0500, Steven Rostedt wrote:
> On Tue, 11 Jan 2022 12:30:42 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > > >  	if (unlikely(!deref_curr_numa_group(p))) {
> > > > > -		unsigned int size = sizeof(struct numa_group) +
> > > > > -				    NR_NUMA_HINT_FAULT_STATS *
> > > > > -				    nr_node_ids * sizeof(unsigned long);
> > > > > +		unsigned int size = struct_size(grp, faults,
> > > > > +						NR_NUMA_HINT_FAULT_STATS * nr_node_ids);    
> > > > 
> > > > Again, why?! The old code was perfectly readable, this, not so much.  
> > > 
> > > Because it is unsafe,  
> > 
> > Unsafe how? Changelog doesn't mention anything, nor do you. In fact,
> > Changelog says there is no functional change, which makes me hate the
> > thing for obscuring something that was simple.
> 
> If for some reason faults changes in size, the original code must be
> updated whereas the new code is robust enough to not need changing.

Then I would still much prefer something like:

	unsigned int size = sizeof(*grp) +
			    NR_NUMA_HINT_FAULT_STATS * numa_node_ids * sizeof(gfp->faults);

Which is still far more readable than some obscure macro. But again, the
Changelog doesn't mention any actual benefit of the patch and makes the
code less clear.

> It's a C hack and far from trivial. Maybe to you as you are use to
> these hacks. But seriously, this is not something the average C coder
> is use to, as variable length structures are rather unique to the
> kernel.

That's just not true, I've used them in userspace too (even before I
started tinkering with the kernel). I've even used this pattern in other
languages.

It is a fairly useful and common pattern to have a small structure and
an array in the same memory allocation.

Think hash-tables, the structure contains the size of the table and some
other things, like for example a seed for the hash function or a lock,
and then the table itself as an array.

I can't, nor do I want to, remember all these stupid little macros. Esp.
not for trivial things like this.
