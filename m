Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D66E4827FB
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 17:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbiAAQoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 11:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiAAQoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 11:44:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6257C061574
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jan 2022 08:44:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FFB4B807E9
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jan 2022 16:44:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F63C36AE9;
        Sat,  1 Jan 2022 16:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641055466;
        bh=lOg7m0dU2EJNstUfBQfbMNCM+ukm7aA/Uw/Dfk4KDcY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LF/mYistu25kM2NaIwdOLzYz0EnCVo0DZ0TsuaEiftYXkNISXns5raWrspK+bnl5q
         76K20bPLZObvSt1o6sBd7tHskdZIwvdfIVovgW6a+YyfEFg3CfqP5HiwXq8BfE8lFX
         mI24tC7QKrfzYkfiGDfzAI8XD9dx2iTYNTHaoPRfUH6J4sQEYSknnzEPc2leHHRrj6
         j08SNS3A+RycoUh2IfLbXUzvQUH4nv0hhNUtLxVvu3yk6wHl3m0H5MCafFOiFYHfJz
         vV3CiRMsbcLdhHiDJ6L1Muvy2WMPMFPtvNBFGrIGrR8hbaX/Gze/81E07WmSd/7I+1
         7sgQtwD47Xi0Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8C87A5C1A43; Sat,  1 Jan 2022 08:44:26 -0800 (PST)
Date:   Sat, 1 Jan 2022 08:44:26 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de
Subject: Re: [PATCH] rcu: per-cpu rcuc kthread are created only when
 rcutree.use_softirq=0
Message-ID: <20220101164426.GA2408833@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211228160510.2893362-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211228160510.2893362-1-qiang1.zhang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 12:05:10AM +0800, Zqiang wrote:
> In non-RT kernel, if the RCU_BOOST is enabled, the per-cpu rcuc
> kthread will be created, however under the rcutree.use_softirq=1,
> the RCU core processing only in softirq context, the rcuc kthread
> doesn't do anything, so remove RCU_BOOST interference.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Looks sane to me, but adding Sebastian on CC for his thoughts.

							Thanx, Paul

> ---
>  kernel/rcu/tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 9b58bae0527a..ed64b4fcb8a0 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2902,7 +2902,7 @@ static int __init rcu_spawn_core_kthreads(void)
>  
>  	for_each_possible_cpu(cpu)
>  		per_cpu(rcu_data.rcu_cpu_has_work, cpu) = 0;
> -	if (!IS_ENABLED(CONFIG_RCU_BOOST) && use_softirq)
> +	if (use_softirq)
>  		return 0;
>  	WARN_ONCE(smpboot_register_percpu_thread(&rcu_cpu_thread_spec),
>  		  "%s: Could not start rcuc kthread, OOM is now expected behavior\n", __func__);
> -- 
> 2.25.1
> 
