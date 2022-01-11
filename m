Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2CD48B091
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 16:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245716AbiAKPOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 10:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244952AbiAKPOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 10:14:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A282C06173F;
        Tue, 11 Jan 2022 07:14:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6B81615E8;
        Tue, 11 Jan 2022 15:14:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A05C36AE3;
        Tue, 11 Jan 2022 15:14:26 +0000 (UTC)
Date:   Tue, 11 Jan 2022 10:14:25 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Xiu Jianfeng <xiujianfeng@huawei.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, gustavoars@kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH -next, v2] sched: Use struct_size() helper in
 task_numa_group()
Message-ID: <20220111101425.7c59de5b@rorschach.local.home>
In-Reply-To: <Yd1qYsFcgcp/uHSa@hirez.programming.kicks-ass.net>
References: <20220110012354.144394-1-xiujianfeng@huawei.com>
        <Ydy3N577YD0JJr2N@hirez.programming.kicks-ass.net>
        <20220110193158.31e1eaea@gandalf.local.home>
        <Yd1qYsFcgcp/uHSa@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 12:30:42 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> > > >  	if (unlikely(!deref_curr_numa_group(p))) {
> > > > -		unsigned int size = sizeof(struct numa_group) +
> > > > -				    NR_NUMA_HINT_FAULT_STATS *
> > > > -				    nr_node_ids * sizeof(unsigned long);
> > > > +		unsigned int size = struct_size(grp, faults,
> > > > +						NR_NUMA_HINT_FAULT_STATS * nr_node_ids);    
> > > 
> > > Again, why?! The old code was perfectly readable, this, not so much.  
> > 
> > Because it is unsafe,  
> 
> Unsafe how? Changelog doesn't mention anything, nor do you. In fact,
> Changelog says there is no functional change, which makes me hate the
> thing for obscuring something that was simple.

If for some reason faults changes in size, the original code must be
updated whereas the new code is robust enough to not need changing.

> 
> > And to be honest, the new change is a lot easier to read than the original
> > code.  
> 
> I find it the other way around, because now I need to find and untangle
> the unholy mess that is struct_size(), whereas currently it is trivial
> C.

It's a C hack and far from trivial. Maybe to you as you are use to
these hacks. But seriously, this is not something the average C coder
is use to, as variable length structures are rather unique to the
kernel.

Note that struct_size() is commonly used in the kernel. Better start
getting use to it ;-)

-- Steve

