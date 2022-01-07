Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA06B48791A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 15:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239210AbiAGOgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 09:36:23 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39232 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbiAGOgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 09:36:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDC73B82657;
        Fri,  7 Jan 2022 14:36:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE0CC36AE0;
        Fri,  7 Jan 2022 14:36:19 +0000 (UTC)
Date:   Fri, 7 Jan 2022 09:36:17 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <bsegall@google.com>,
        <mgorman@suse.de>, <bristot@redhat.com>, <gustavoars@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH -next] sched: Use struct_size() helper in
 task_numa_group()
Message-ID: <20220107093617.56e218dc@gandalf.local.home>
In-Reply-To: <20220107025212.177040-1-xiujianfeng@huawei.com>
References: <20220107025212.177040-1-xiujianfeng@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jan 2022 10:52:12 +0800
Xiu Jianfeng <xiujianfeng@huawei.com> wrote:

> Make use of struct_size() helper instead of an open-coded calculation.
> There is no functional change in this patch.
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

I just replied yesterday. Keep the size variable. The above is too much for
a kzalloc().

-- Steve




>  		if (!grp)
>  			return;
>  

