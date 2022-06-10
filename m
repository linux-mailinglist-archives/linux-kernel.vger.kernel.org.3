Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10456546C73
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 20:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350360AbiFJSg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 14:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350352AbiFJSgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 14:36:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759603F33D;
        Fri, 10 Jun 2022 11:35:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E634F621D5;
        Fri, 10 Jun 2022 18:35:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0AAC34114;
        Fri, 10 Jun 2022 18:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654886144;
        bh=m3CSPgnSkRLqgebnknIX+DA92vhoLZ73QX/ht0dUq3w=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XJ60D+TAZBxmDkDmk6GNtHdCkxGxLWNCqmsNdbSBe/oqFSqn6qXsCNFHOQhJDiv7a
         vPvLtUwqoKWxJIHo+lzA2fqgV5q1iSPwQ7XZ+aK9u91brHi++8/OW4D2ieqKFKTk6L
         EmN9SmK6CtU/cYzFdhwSy8FZRK16GcC4x5uf3vEzxnuyHi5tiFL+f7NDR131A65VAd
         hAK6kJNGDOG/XjPq692CGpyEkE0GTHS+B2j6gWaJkMLgLldeKFpRfwXI+LTq9bxCro
         B1cWlCnEk4zplu8izczmoppoOxc21VfHUiPHKmW/97iAVNOmricmGBw2DF6N7iWMDe
         BbvUYgH1K1rAQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E713A5C05ED; Fri, 10 Jun 2022 11:35:43 -0700 (PDT)
Date:   Fri, 10 Jun 2022 11:35:43 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu-tasks: Remove unused trc_wait and holdouts
Message-ID: <20220610183543.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220610062228.2185104-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610062228.2185104-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 02:22:28PM +0800, Zqiang wrote:
> Remove unused trc_wait waitqueue and local holdouts list.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Good eyes, thank you!  I will fold this into the original commit
with attribution.

							Thanx, Paul

> ---
>  kernel/rcu/tasks.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 55e76db8b0d3..fcbd0ec33c86 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -1190,8 +1190,6 @@ EXPORT_SYMBOL_GPL(rcu_trace_lock_map);
>  
>  #ifdef CONFIG_TASKS_TRACE_RCU
>  
> -static DECLARE_WAIT_QUEUE_HEAD(trc_wait);	// List of holdout tasks.
> -
>  // Record outstanding IPIs to each CPU.  No point in sending two...
>  static DEFINE_PER_CPU(bool, trc_ipi_to_cpu);
>  
> @@ -1641,7 +1639,6 @@ static void rcu_tasks_trace_empty_fn(void *unused)
>  static void rcu_tasks_trace_postgp(struct rcu_tasks *rtp)
>  {
>  	int cpu;
> -	LIST_HEAD(holdouts);
>  
>  	// Wait for any lingering IPI handlers to complete.  Note that
>  	// if a CPU has gone offline or transitioned to userspace in the
> -- 
> 2.25.1
> 
