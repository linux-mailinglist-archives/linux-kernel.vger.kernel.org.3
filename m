Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6169A531F1F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 01:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiEWXJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 19:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiEWXJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 19:09:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1428D70369;
        Mon, 23 May 2022 16:09:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A301E6156C;
        Mon, 23 May 2022 23:09:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7B6C385AA;
        Mon, 23 May 2022 23:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653347361;
        bh=yOoMYHJ+lZpOBFkfuhqaQQmv3ej6+jMUsBvs1jyRRVo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PiBbmGDBY2uySOT3YH++Qq0COpTcPptclkj2+PYOTSoPFjPTVw5tUqu2qrUcT26MJ
         JD0W4XCinFYng5fKm9UqGUzrXIIM7pekYaXUmHBuVVGzJG4doA3B7R9asg0/xBBCET
         sUVbec+h+8Ag4pwdNBdIyBu1RX2zsh0JGbXVFO2IChvQl/a3M3WNSoTbH1u5NMH0Eg
         6QYgtZS7iVcc/23mft9gP4tgKZAK+ZNUmakf6bTFOWvfjJmLQUMFISvwGkhdejFYla
         wD8pKailN/NZL1uXpZs5f7xSRWkLfZ033xX6QW+XxFWB4dgR4vWraIoSGML5VYqSp+
         enm7uDh5VKNHg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8A35A5C032C; Mon, 23 May 2022 16:09:20 -0700 (PDT)
Date:   Mon, 23 May 2022 16:09:20 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] rcu-tasks: Stop RCU Tasks scanning tasks which record
 on dyntick-idle entry
Message-ID: <20220523230920.GG1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220520084155.1745726-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520084155.1745726-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 04:41:55PM +0800, Zqiang wrote:
> When the RCU Tasks scanning on-rq tasks, there is no need to scanning
> tasks which record on dyntick-idle entry, at this time, these tasks are
> not remain within an RCU Tasks read-side critical section.
> 
> This commit skip scanning tasks which record on dyntick-idle entry in
> rcu_tasks_pertask().
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

You lost me with this one.  Doesn't the rcu_tasks_pertask() function
already exclude the idle tasks that might possibly be running in
dyntick-idle state in non-CONFIG_NO_HZ_FULL systems?

What am I missing here?

							Thanx, Paul

> ---
>  v1->v2:
>  fix build test ERROR due to CONFIG_TASKS_RCU=n
> 
>  kernel/rcu/tasks.h | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index f6459343e4b6..7cb0f922478e 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -809,10 +809,17 @@ static void rcu_tasks_pregp_step(struct list_head *hop)
>  	synchronize_rcu();
>  }
>  
> +static bool task_is_on_dyntick_idle(struct task_struct *t)
> +{
> +	return IS_ENABLED(CONFIG_NO_HZ_FULL) && !is_idle_task(t) &&
> +				t->rcu_tasks_idle_cpu >= 0;
> +}
> +
>  /* Per-task initial processing. */
>  static void rcu_tasks_pertask(struct task_struct *t, struct list_head *hop)
>  {
> -	if (t != current && READ_ONCE(t->on_rq) && !is_idle_task(t)) {
> +	if (t != current && READ_ONCE(t->on_rq) && !is_idle_task(t) &&
> +				!task_is_on_dyntick_idle(t)) {
>  		get_task_struct(t);
>  		t->rcu_tasks_nvcsw = READ_ONCE(t->nvcsw);
>  		WRITE_ONCE(t->rcu_tasks_holdout, true);
> @@ -842,8 +849,7 @@ static void check_holdout_task(struct task_struct *t,
>  	if (!READ_ONCE(t->rcu_tasks_holdout) ||
>  	    t->rcu_tasks_nvcsw != READ_ONCE(t->nvcsw) ||
>  	    !READ_ONCE(t->on_rq) ||
> -	    (IS_ENABLED(CONFIG_NO_HZ_FULL) &&
> -	     !is_idle_task(t) && t->rcu_tasks_idle_cpu >= 0)) {
> +	    task_is_on_dyntick_idle(t)) {
>  		WRITE_ONCE(t->rcu_tasks_holdout, false);
>  		list_del_init(&t->rcu_tasks_holdout_list);
>  		put_task_struct(t);
> -- 
> 2.25.1
> 
