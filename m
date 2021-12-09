Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB1646EB0F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236469AbhLIP0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:26:53 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36828 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235389AbhLIP0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:26:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37215B82076
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 15:23:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31DCC004DD;
        Thu,  9 Dec 2021 15:23:14 +0000 (UTC)
Date:   Thu, 9 Dec 2021 10:23:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/uclamp: potential dereference of null pointer
Message-ID: <20211209102313.1360b39b@gandalf.local.home>
In-Reply-To: <20211209033127.2051504-1-jiasheng@iscas.ac.cn>
References: <20211209033127.2051504-1-jiasheng@iscas.ac.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  9 Dec 2021 11:31:27 +0800
Jiasheng Jiang <jiasheng@iscas.ac.cn> wrote:

> The return value of kzalloc() needs to be checked.
> To avoid use of null pointer in case of the failure of alloc.
> 
> Fixes: 391e43da797a ("sched: Move all scheduler bits into kernel/sched/")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  kernel/sched/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index e5858999b54d..988a4a372e14 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8125,6 +8125,8 @@ void __init sched_init(void)
>  #endif
>  	if (ptr) {
>  		ptr = (unsigned long)kzalloc(ptr, GFP_NOWAIT);
> +		if (!ptr)
> +			return;

If this were to happen the system would crash immediately, with or without
the return.

If you are worried about not being able to allocate ptr, then the only
reasonable fix here is

		BUG_ON(!ptr);

That way you would know exactly why your system crashed. Because just
returning would crash for other reasons and make it less debuggable.

-- Steve


>  
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  		root_task_group.se = (struct sched_entity **)ptr;

