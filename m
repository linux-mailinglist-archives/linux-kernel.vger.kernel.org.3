Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C6E46E865
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 13:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbhLIM0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 07:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhLIM0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 07:26:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D50C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 04:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0AEM8YCdAubIqHCC9HMcwa+P9VvF+mNHxUTg1P/Jr4w=; b=Bk9tHodv/XmChGw36kLCffMN+p
        z+/LJOxTFYml6MEkEv/nF745hADNoKF9eYnfZk7YapgtZMQPhLcbhDgOqIBLNkerold8ZF0PBholW
        Eqp1u0YDtc4A6v9LXpjNP3MJNIi6K/n5rLxpXeZ+IjxL12PckvZ/GmSmI8WZWQPg4uvDpXbLK3pdo
        2PPWsY/11Z0KfOaYHhpPEZknk3bVd5wj5WrQiDhfFpMZ6g8KF2RsQq7F4mfWWwsiAo/NF+mIejVvZ
        sm0qL+a5QcFFyaVeqprAuUr/UVHfEL2haxy2uh0HzXZDOBrQ1WJokbVRTaeNaifq15g+h+f3ojEfb
        b4anKv4Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvIR7-009Kxo-2K; Thu, 09 Dec 2021 12:22:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 720193002DB;
        Thu,  9 Dec 2021 13:22:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1A0CF2BB99CBA; Thu,  9 Dec 2021 13:22:08 +0100 (CET)
Date:   Thu, 9 Dec 2021 13:22:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Honglei Wang <wanghonglei@didichuxing.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org,
        Huaixin Chang <changhuaixin@linux.alibaba.com>,
        Honglei Wang <jameshongleiwang@126.com>
Subject: Re: [PATCH v2 1/3] sched/fair: avoid burst statistic if it's not set
Message-ID: <YbH08Nw3WpyxElE9@hirez.programming.kicks-ass.net>
References: <20211208145018.64657-1-wanghonglei@didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208145018.64657-1-wanghonglei@didichuxing.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 10:50:18PM +0800, Honglei Wang wrote:
> It's not necessary to do burst associated statistic and calculation for
> runtime if the burst feature is not set at all. Just return at the very
> start point if so.
> 
> Signed-off-by: Honglei Wang <wanghonglei@didichuxing.com>
> ---
>  kernel/sched/fair.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6e476f6d9435..2cd626c22912 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4640,6 +4640,11 @@ void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
>  	if (unlikely(cfs_b->quota == RUNTIME_INF))
>  		return;
>  
> +	if (cfs_b->burst == 0 && cfs_b->runtime_snap == cfs_b->quota) {
> +		cfs_b->runtime = cfs_b->quota;
> +		return;
> +	}
> +
>  	cfs_b->runtime += cfs_b->quota;
>  	runtime = cfs_b->runtime_snap - cfs_b->runtime;
>  	if (runtime > 0) {

What actual purpose does this patch serve, other than to increase the
line-count?
