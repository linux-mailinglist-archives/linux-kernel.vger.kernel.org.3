Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4D5546EE4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 22:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348550AbiFJU6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 16:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346491AbiFJU6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 16:58:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DC83A79F7;
        Fri, 10 Jun 2022 13:58:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 062A261719;
        Fri, 10 Jun 2022 20:58:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65931C34114;
        Fri, 10 Jun 2022 20:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654894694;
        bh=EGmrWeV3cG/YF0aNeoJH2Jag7C5HhEhgf8ghD/0kBGE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=OmGaezuQeK2QoimtndXrD883DQW29TKAcKkm/GH0URwTR/lciwJkXyuTUaMkMzlf7
         76cXkBY2nbGNOAwjbdbFyvSkQ/KglU2b1S0qMkZyy41ZpF6NfUptDIlmggqR4s2XbL
         FN51oZsk8Uv97WqQWJXUJcGjZCVj5MxygzErJcE0WxYgOn3XiSjyrtBAEjEQnaZMLG
         2BzZLLU6F6hplozRNJjeJLPfb3iNgGG0QwchSXjWX5j7XrqGWy5tTHh571RQ1AUDbR
         Uw9OAJX7gepUeubYSuh0BmHTSvTDVOCe9uML/dzHyOzoy8kM9Mh384fkU/jJG1EYo3
         b7pXqA/nhdLWQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 05A645C05ED; Fri, 10 Jun 2022 13:58:14 -0700 (PDT)
Date:   Fri, 10 Jun 2022 13:58:14 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH] rcu-tasks: Delay rcu_tasks_verify_self_tests() to avoid
 missed callbacks
Message-ID: <20220610205814.GK1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220610184212.822113-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610184212.822113-1-longman@redhat.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 02:42:12PM -0400, Waiman Long wrote:
> Even though rcu_tasks selftest is initiated early in the boot process,
> the verification done at late initcall time may not be late enough to
> catch all the callbacks especially on systems with just a few cpus and
> small memory.
> 
> After 12 bootup's On a s390x system, 1 of them had failed rcu_tasks
> verification test.
> 
> [    8.183013] call_rcu_tasks() has been failed.
> [    8.183041] WARNING: CPU: 0 PID: 1 at kernel/rcu/tasks.h:1696 rcu_tasks_verify_self_tests+0x64/0xd0
> [    8.203246] Callback from call_rcu_tasks() invoked.
> 
> In this particular case, the callback missed the check by about
> 20ms. Similar rcu_tasks selftest failures are also seen in ppc64le
> systems.
> 
> [    0.313391] call_rcu_tasks() has been failed.
> [    0.313407] WARNING: CPU: 0 PID: 1 at kernel/rcu/tasks.h:1696 rcu_tasks_verify_self_tests+0x5c/0xa0
> [    0.335569] Callback from call_rcu_tasks() invoked.
> 
> Avoid this missed callback by delaying the verification using
> delayed_work. The delay is set to be about 0.1s which hopefully will
> be long enough to catch all the callbacks on systems with few cpus and
> small memory.
> 
> Fixes: bfba7ed084f8 ("rcu-tasks: Add RCU-tasks self tests")
> Signed-off-by: Waiman Long <longman@redhat.com>

Good catch, thank you!

A few days ago, I queued this:

2585014188d5 ("rcu-tasks: Be more patient for RCU Tasks boot-time testing")

This is shown in full at the end of this email.  Does this fix this
problem for you?

							Thanx, Paul

> ---
>  kernel/rcu/tasks.h | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 3925e32159b5..25f964a671ba 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -1735,7 +1735,7 @@ static void rcu_tasks_initiate_self_tests(void)
>  #endif
>  }
>  
> -static int rcu_tasks_verify_self_tests(void)
> +static void rcu_tasks_verify_self_tests(struct work_struct *work __maybe_unused)
>  {
>  	int ret = 0;
>  	int i;
> @@ -1749,10 +1749,23 @@ static int rcu_tasks_verify_self_tests(void)
>  
>  	if (ret)
>  		WARN_ON(1);
> +}
> +
> +static struct delayed_work rcu_tasks_verify_work;
>  
> -	return ret;
> +/*
> + * The rcu_tasks verification is done indirectly via the work queue to
> + * introduce an additional 0.1s delay to catch all the callbacks before
> + * the verification is done as late_initcall time may not be late enough
> + * to have all the callbacks fired.
> + */
> +static int rcu_tasks_verify_schedule_work(void)
> +{
> +	INIT_DELAYED_WORK(&rcu_tasks_verify_work, rcu_tasks_verify_self_tests);
> +	schedule_delayed_work(&rcu_tasks_verify_work, HZ/10);
> +	return 0;
>  }
> -late_initcall(rcu_tasks_verify_self_tests);
> +late_initcall(rcu_tasks_verify_schedule_work);
>  #else /* #ifdef CONFIG_PROVE_RCU */
>  static void rcu_tasks_initiate_self_tests(void) { }
>  #endif /* #else #ifdef CONFIG_PROVE_RCU */
> -- 
> 2.31.1

------------------------------------------------------------------------

commit 2585014188d5e66052b4226b42602b6f3d921389
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Tue Jun 7 15:23:52 2022 -0700

    rcu-tasks: Be more patient for RCU Tasks boot-time testing
    
    The RCU-Tasks family of grace-period primitives can take some time to
    complete, and the amount of time can depend on the exact hardware and
    software configuration.  Some configurations boot up fast enough that the
    RCU-Tasks verification process gets false-positive failures.  This commit
    therefore allows up to 30 seconds for the grace periods to complete, with
    this value adjustable downwards using the rcupdate.rcu_task_stall_timeout
    kernel boot parameter.
    
    Reported-by: Matthew Wilcox <willy@infradead.org>
    Reported-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
    Tested-by: Zhouyi Zhou <zhouzhouyi@gmail.com>

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index df6b2cb2f205d..fcbd0ec33c866 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -145,6 +145,7 @@ static int rcu_task_ipi_delay __read_mostly = RCU_TASK_IPI_DELAY;
 module_param(rcu_task_ipi_delay, int, 0644);
 
 /* Control stall timeouts.  Disable with <= 0, otherwise jiffies till stall. */
+#define RCU_TASK_BOOT_STALL_TIMEOUT (HZ * 30)
 #define RCU_TASK_STALL_TIMEOUT (HZ * 60 * 10)
 static int rcu_task_stall_timeout __read_mostly = RCU_TASK_STALL_TIMEOUT;
 module_param(rcu_task_stall_timeout, int, 0644);
@@ -1776,23 +1777,24 @@ struct rcu_tasks_test_desc {
 	struct rcu_head rh;
 	const char *name;
 	bool notrun;
+	unsigned long runstart;
 };
 
 static struct rcu_tasks_test_desc tests[] = {
 	{
 		.name = "call_rcu_tasks()",
 		/* If not defined, the test is skipped. */
-		.notrun = !IS_ENABLED(CONFIG_TASKS_RCU),
+		.notrun = IS_ENABLED(CONFIG_TASKS_RCU),
 	},
 	{
 		.name = "call_rcu_tasks_rude()",
 		/* If not defined, the test is skipped. */
-		.notrun = !IS_ENABLED(CONFIG_TASKS_RUDE_RCU),
+		.notrun = IS_ENABLED(CONFIG_TASKS_RUDE_RCU),
 	},
 	{
 		.name = "call_rcu_tasks_trace()",
 		/* If not defined, the test is skipped. */
-		.notrun = !IS_ENABLED(CONFIG_TASKS_TRACE_RCU)
+		.notrun = IS_ENABLED(CONFIG_TASKS_TRACE_RCU)
 	}
 };
 
@@ -1803,23 +1805,28 @@ static void test_rcu_tasks_callback(struct rcu_head *rhp)
 
 	pr_info("Callback from %s invoked.\n", rttd->name);
 
-	rttd->notrun = true;
+	rttd->notrun = false;
 }
 
 static void rcu_tasks_initiate_self_tests(void)
 {
+	unsigned long j = jiffies;
+
 	pr_info("Running RCU-tasks wait API self tests\n");
 #ifdef CONFIG_TASKS_RCU
+	tests[0].runstart = j;
 	synchronize_rcu_tasks();
 	call_rcu_tasks(&tests[0].rh, test_rcu_tasks_callback);
 #endif
 
 #ifdef CONFIG_TASKS_RUDE_RCU
+	tests[1].runstart = j;
 	synchronize_rcu_tasks_rude();
 	call_rcu_tasks_rude(&tests[1].rh, test_rcu_tasks_callback);
 #endif
 
 #ifdef CONFIG_TASKS_TRACE_RCU
+	tests[2].runstart = j;
 	synchronize_rcu_tasks_trace();
 	call_rcu_tasks_trace(&tests[2].rh, test_rcu_tasks_callback);
 #endif
@@ -1829,11 +1836,18 @@ static int rcu_tasks_verify_self_tests(void)
 {
 	int ret = 0;
 	int i;
+	unsigned long bst = rcu_task_stall_timeout;
 
+	if (bst <= 0 || bst > RCU_TASK_BOOT_STALL_TIMEOUT)
+		bst = RCU_TASK_BOOT_STALL_TIMEOUT;
 	for (i = 0; i < ARRAY_SIZE(tests); i++) {
-		if (!tests[i].notrun) {		// still hanging.
-			pr_err("%s has been failed.\n", tests[i].name);
-			ret = -1;
+		while (tests[i].notrun) {		// still hanging.
+			if (time_after(jiffies, tests[i].runstart + bst)) {
+				pr_err("%s has failed boot-time tests.\n", tests[i].name);
+				ret = -1;
+				break;
+			}
+			schedule_timeout_uninterruptible(1);
 		}
 	}
 
