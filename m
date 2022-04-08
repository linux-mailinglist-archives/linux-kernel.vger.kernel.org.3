Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49154F9608
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 14:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbiDHMrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 08:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235915AbiDHMrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:47:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54809ED90F;
        Fri,  8 Apr 2022 05:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yatnqMfFaCYyGLYezkZaTYyAOSonLgPUJNM6A5BO7DM=; b=Bpxqvys6a823O3QpLW+DnlOzu/
        FyT1pzKFz3+oiPbRzlCkR+jMtxdA++K+1xjeu1AUAq2SuadWhaxZTc8G45TQe5q+kJqxez/lzyrgy
        ktnTfsP5bIueHYcfAwYz3KjxXyRoKv5TBc7b5W/7JcVh1NQVSQ3hLKE9M9TOE/H+XhYNjIhJ/RNKL
        g7HIb/chNo/P6mvJtp2M5RR+LDBVZlUIbI0HJ7IFPrp9aU3GhkY8T91r/ms5CSC4SdkQqhIhPWFuA
        KLkJQ4swQRYe1SOMhsW193khOPtBxRexKq9dupojrTgk0Jyt9m9W2JTo03uOaYXnwMKXG09AvIMcn
        Oo8GDnBQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncnzb-009p4y-Gr; Fri, 08 Apr 2022 12:45:35 +0000
Date:   Fri, 8 Apr 2022 13:45:35 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "brookxu.cn" <brookxu.cn@gmail.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH] docs/scheduler: Change unit of cpu_time and rq_time to
 nanoseconds
Message-ID: <YlAub2NXBPeNcyAS@casper.infradead.org>
References: <1649410266-32360-1-git-send-email-brookxu.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649410266-32360-1-git-send-email-brookxu.cn@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 05:31:06PM +0800, brookxu.cn wrote:
> From: Chunguang Xu <brookxu@tencent.com>
> 
> In the current implementation, cpu_time and rq_time should be
> in nanoseconds, so this document needs to be modified.

I agree that this is wrong, but we shouldn't be changing the units
of measurement reported to userspace without changing the schedstats
version.  I suspect this was an inadvertent change, and we should be
converting from sched_clock() time (~= ns) to jiffies in show_schedstat().
Adding scheduler experts.

> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> ---
>  Documentation/scheduler/sched-stats.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/scheduler/sched-stats.rst b/Documentation/scheduler/sched-stats.rst
> index dd9b99a..9078a27 100644
> --- a/Documentation/scheduler/sched-stats.rst
> +++ b/Documentation/scheduler/sched-stats.rst
> @@ -56,9 +56,9 @@ Next two are try_to_wake_up() statistics:
>  
>  Next three are statistics describing scheduling latency:
>  
> -     7) sum of all time spent running by tasks on this processor (in jiffies)
> +     7) sum of all time spent running by tasks on this processor (in nanoseconds)
>       8) sum of all time spent waiting to run by tasks on this processor (in
> -        jiffies)
> +        nanoseconds)
>       9) # of timeslices run on this cpu
>  
>  
> -- 
> 1.8.3.1
> 
