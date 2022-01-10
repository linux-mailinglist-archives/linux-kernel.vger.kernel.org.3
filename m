Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5400489BF7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236064AbiAJPO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:14:59 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36776 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236065AbiAJPO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:14:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBD3061304;
        Mon, 10 Jan 2022 15:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C0CC36AFF;
        Mon, 10 Jan 2022 15:14:55 +0000 (UTC)
Date:   Mon, 10 Jan 2022 10:14:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <bsegall@google.com>,
        <mgorman@suse.de>, <bristot@redhat.com>, <gustavoars@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH -next, v2] sched: Use struct_size() helper in
 task_numa_group()
Message-ID: <20220110101454.2d46f11e@gandalf.local.home>
In-Reply-To: <20220110012354.144394-1-xiujianfeng@huawei.com>
References: <20220110012354.144394-1-xiujianfeng@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2022 09:23:54 +0800
Xiu Jianfeng <xiujianfeng@huawei.com> wrote:

> Make use of struct_size() helper instead of an open-coded calculation.
> There is no functional change in this patch.

Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve

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
>  
>  		grp = kzalloc(size, GFP_KERNEL | __GFP_NOWARN);
>  		if (!grp)

