Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D641A4904AD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 10:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbiAQJUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 04:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233695AbiAQJUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 04:20:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067A4C061574;
        Mon, 17 Jan 2022 01:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FxsJjdfKuu5bMpXR0hew/7OYz/lzco51HZJYdo8kNlI=; b=UUjoeWidKnxmT0H8VFs6CIVpR2
        1+Bu5gzqg+I9eL+G+KtR+IHQ2bIy+s8dn4Q2aV2B+H1iAfF5i1jlGPjhBX5Au0Hd0V/Uc/C1NZS3l
        ZSK2QHgJRH9R59nPcLm6P+Y5bHyuAtQ19JVYFq07+gzN4HrTPAtJ5PPhVxUZlZ1+jGl7aLFHQQZBr
        mGsSVGfbjjfgGxYyFGxtJfmciMtstDSqb9FYSEtOBrEZnmenlMFwzdYe8dtzPtB9CcdCC/bNjpS1y
        mA4autKfmCFWgs49z1PqRD2cd3avmn3DSfE8aPcSJvWKnVNzEJm6N2v+VTUi5WP+VOxZp1Sg2M1ur
        tRoUWEhw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9OAj-007zug-Bm; Mon, 17 Jan 2022 09:19:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0FE09300222;
        Mon, 17 Jan 2022 10:19:26 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8F4B82C707D18; Mon, 17 Jan 2022 10:19:26 +0100 (CET)
Date:   Mon, 17 Jan 2022 10:19:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@google.com>
Cc:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, avagin@google.com, jannh@google.com,
        tdelisle@uwaterloo.ca, posk@posk.io
Subject: Re: [RFC PATCH v2 4/5] sched: UMCG: add a blocked worker list
Message-ID: <YeU0nr6DfBCaH6UF@hirez.programming.kicks-ass.net>
References: <20220113233940.3608440-1-posk@google.com>
 <20220113233940.3608440-5-posk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113233940.3608440-5-posk@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 03:39:39PM -0800, Peter Oskolkov wrote:
> The original idea of a UMCG server was that it was used as a proxy
> for a CPU, so if a worker associated with the server is RUNNING,
> the server itself is never ever was allowed to be RUNNING as well;
> when umcg_wait() returned for a server, it meant that its worker
> became BLOCKED.
> 
> In the new (old?) "per server runqueues" model implemented in
> the previous patch in this patchset, servers are woken when
> a previously blocked worker on their runqueue finishes its blocking
> operation, even if the currently RUNNING worker continues running.
> 
> As now a server may run while a worker assigned to it is running,
> the original idea of having at most a single worker RUNNING per
> server, as a means to control the number of running workers, is
> not really enforced, and the server, woken by a worker
> doing BLOCKED=>RUNNABLE transition, may then call sys_umcg_wait()
> with a second/third/etc. worker to run.
> 
> Support this scenario by adding a blocked worker list:
> when a worker transitions RUNNING=>BLOCKED, not only its server
> is woken, but the worker is also added to the blocked worker list
> of its server.
> 
> This change introduces the following benefits:
> - block detection how behaves similarly to wake detection;
>   without this patch worker wakeups added wakees to the list
>   and woke the server, while worker blocks only woke the server
>   without adding blocked workers to a list, forcing servers
>   to explicitly check worker's state;
> - if the blocked worker woke sufficiently quickly, the server
>   woken on the block event would observe its worker now as
>   RUNNABLE, so the block event had to be inferred rather than
>   explicitly signalled by the worker being added to the blocked
>   worker list;
> - it is now possible for a single server to control several
>   RUNNING workers, which makes writing userspace schedulers
>   simpler for smaller processes that do not need to scale beyond
>   one "server";
> - if the userspace wants to keep at most a single RUNNING worker
>   per server, and have multiple servers with their own runqueues,
>   this model is also naturally supported here.
> 
> So this change basically decouples block/wake detection from
> M:N threading in the sense that the number of servers is now
> does not have to be M or N, but is more driven by the scalability
> needs of the userspace application.

So I don't object to having this blocking list, we had that early on in
the discussions.

*However*, combined with WF_CURRENT_CPU this 1:N userspace model doesn't
really make sense, also combined with Proxy-Exec (if we ever get that
sorted) it will fundamentally not work.

More consideration is needed I think...
