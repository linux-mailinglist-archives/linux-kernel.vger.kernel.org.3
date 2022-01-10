Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A5A48A323
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 23:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345504AbiAJWqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 17:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345152AbiAJWqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 17:46:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A03C06173F;
        Mon, 10 Jan 2022 14:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IqrXf599hGOUdTwDIzNVsJnNHGdPl4pFXwTBunJ4KxE=; b=dxZ5gAh0g6ikhnj6nyi661gwEE
        AOcWU5mtQsfyRt1W55kWBHxzvR6MPduGi/+z7ZEtDIs1oLkWKLrhk/gsH/Q30OG6Gp7N1008VHqjM
        EiYsh9UuFDtd6H7BB9G1Q9ULOQWnrafY8Ar9DaOxpLwRXJHfSBO3/9UAqScu68hQRtcQIi+LpUYQE
        PxKtkr054WZZhGn/fqg/acIDhvAS6OaskNoJIp4KAOlc5/aQ+mi556sgiNgH8bMxin8zo5heZwgYO
        lvRhJyTW76b3GcDEyvG3Q4x/qMI3oHDoMHEs6JaMDOjzh1NO6zkKJiX73naDYOrEHArzMrfjXFqtQ
        h4q5kcFA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n73Qh-002mHR-4C; Mon, 10 Jan 2022 22:46:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8F3903002A6;
        Mon, 10 Jan 2022 23:46:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1808B21BC46A7; Mon, 10 Jan 2022 23:46:15 +0100 (CET)
Date:   Mon, 10 Jan 2022 23:46:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, gustavoars@kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH -next, v2] sched: Use struct_size() helper in
 task_numa_group()
Message-ID: <Ydy3N577YD0JJr2N@hirez.programming.kicks-ass.net>
References: <20220110012354.144394-1-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110012354.144394-1-xiujianfeng@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 09:23:54AM +0800, Xiu Jianfeng wrote:
> Make use of struct_size() helper instead of an open-coded calculation.
> There is no functional change in this patch.
> 
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  kernel/sched/fair.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 095b0aa378df..af933a7f9e5d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -2437,9 +2437,8 @@ static void task_numa_group(struct task_struct *p, int cpupid, int flags,
>  	int i;
>  
>  	if (unlikely(!deref_curr_numa_group(p))) {
> -		unsigned int size = sizeof(struct numa_group) +
> -				    NR_NUMA_HINT_FAULT_STATS *
> -				    nr_node_ids * sizeof(unsigned long);
> +		unsigned int size = struct_size(grp, faults,
> +						NR_NUMA_HINT_FAULT_STATS * nr_node_ids);

Again, why?! The old code was perfectly readable, this, not so much.
