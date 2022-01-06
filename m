Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F564867C8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 17:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241344AbiAFQjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 11:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241313AbiAFQjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 11:39:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B757C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 08:39:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CC4761D18
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 16:39:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C3BC36AEB;
        Thu,  6 Jan 2022 16:39:12 +0000 (UTC)
Date:   Thu, 6 Jan 2022 11:39:11 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <bsegall@google.com>,
        <mgorman@suse.de>, <bristot@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] sched: Use struct_size() helper in
 task_numa_group()
Message-ID: <20220106113911.6ffb7fd0@gandalf.local.home>
In-Reply-To: <20211221132138.49464-1-xiujianfeng@huawei.com>
References: <20211221132138.49464-1-xiujianfeng@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2021 21:21:38 +0800
Xiu Jianfeng <xiujianfeng@huawei.com> wrote:

> Make use of struct_size() helper instead of an open-coded calculation.
> There is no functional change in this patch.

I'm all for this clean up, but...

> 
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  kernel/sched/fair.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 095b0aa378df..265e37be0c92 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -2437,11 +2437,8 @@ static void task_numa_group(struct task_struct *p, int cpupid, int flags,
>  	int i;
>  
>  	if (unlikely(!deref_curr_numa_group(p))) {
> -		unsigned int size = sizeof(struct numa_group) +
> -				    NR_NUMA_HINT_FAULT_STATS *
> -				    nr_node_ids * sizeof(unsigned long);
> -
> -		grp = kzalloc(size, GFP_KERNEL | __GFP_NOWARN);
> +		grp = kzalloc(struct_size(grp, faults, NR_NUMA_HINT_FAULT_STATS * nr_node_ids),
> +			      GFP_KERNEL | __GFP_NOWARN);

Ug, the above is so ugly. Why remove the size variable?

		unsigned int size  = struct_size(grp, faults,
					         NR_NUMA_HINT_FAULT_STATS * nr_node_ids);

-- Steve


>  		if (!grp)
>  			return;
>  

