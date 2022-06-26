Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EF055AE99
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 06:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbiFZENd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 00:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiFZENc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 00:13:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE9A12AEF;
        Sat, 25 Jun 2022 21:13:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B3F66103B;
        Sun, 26 Jun 2022 04:13:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7685C34114;
        Sun, 26 Jun 2022 04:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656216807;
        bh=TZribGwFtqu37W7hVVmeZrYswqjJ4BhH296o5Lvsnh8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bQORvW24Pk0/zFZHpD8YLuwbJh70KsiwtFwjDQ+ylE09JF9bEeIYBrE9Xn2X+PwnW
         xUhXkj/adwjpHq1Y5YJmudOgzjvMXjxlG95HmxXp+9QCO6gT7avf5HXZqD7R5Ao48g
         Fb81e/WKnfB9Ot+lModn3SUPAKqi+WcBs2hpzsDx7ouCRXKMB9N0Sn9+KoTR028ODo
         w1KPrq2wuK11YDAEjCPI2OJYJJduay0w97blMN5kC4JBK8QUDA181B0MA+C9cax2ci
         64HVFvF6W0ym+q52mT2agUhx8RVbhDK/z1Y/wjm+hWunQeHPu42wIzqZ+/Pnoz54+d
         VuYsteMAdk33w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4668A5C0260; Sat, 25 Jun 2022 21:13:27 -0700 (PDT)
Date:   Sat, 25 Jun 2022 21:13:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org
Subject: Re: [PATCH v2 6/8] rcuscale: Add test for using call_rcu_lazy() to
 emulate kfree_rcu()
Message-ID: <20220626041327.GN1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220622225102.2112026-1-joel@joelfernandes.org>
 <20220622225102.2112026-8-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622225102.2112026-8-joel@joelfernandes.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 10:51:00PM +0000, Joel Fernandes (Google) wrote:
> Reuse the kfree_rcu() test in order to be able to compare the memory reclaiming
> properties of call_rcu_lazy() with kfree_rcu().
> 
> With this test, we find similar memory footprint and time call_rcu_lazy()
> free'ing takes compared to kfree_rcu(). Also we confirm that call_rcu_lazy()
> can survive OOM during extremely frequent calls.
> 
> If we really push it, i.e. boot system with low memory and compare
> kfree_rcu() with call_rcu_lazy(), I find that call_rcu_lazy() is more
> resilient and is much harder to produce OOM as compared to kfree_rcu().

Another approach would be to make rcutorture's forward-progress testing
able to use call_rcu_lazy().  This would test lazy callback flooding.

Yet another approach would be to keep one CPU idle other than a
kthread doing call_rcu_lazy().  Of course "idle" includes redirecting
those pesky interrupts.

It is almost certainly necessary for rcutorture to exercise the
call_rcu_lazy() path regularly.

							Thanx, Paul

> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/rcu.h       |  6 ++++
>  kernel/rcu/rcuscale.c  | 64 +++++++++++++++++++++++++++++++++++++++++-
>  kernel/rcu/tree_nocb.h | 17 ++++++++++-
>  3 files changed, 85 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index 71c0f45e70c3..436faf80a66b 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -473,6 +473,12 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
>  			       unsigned long c);
>  void rcu_gp_set_torture_wait(int duration);
>  void rcu_force_call_rcu_to_lazy(bool force);
> +
> +#if IS_ENABLED(CONFIG_RCU_SCALE_TEST)
> +unsigned long rcu_scale_get_jiffies_till_flush(void);
> +void rcu_scale_set_jiffies_till_flush(unsigned long j);
> +#endif
> +
>  #else
>  static inline void rcutorture_get_gp_data(enum rcutorture_type test_type,
>  					  int *flags, unsigned long *gp_seq)
> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> index 277a5bfb37d4..58ee5c2cb37b 100644
> --- a/kernel/rcu/rcuscale.c
> +++ b/kernel/rcu/rcuscale.c
> @@ -95,6 +95,7 @@ torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
>  torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable");
>  torture_param(int, kfree_rcu_test, 0, "Do we run a kfree_rcu() scale test?");
>  torture_param(int, kfree_mult, 1, "Multiple of kfree_obj size to allocate.");
> +torture_param(int, kfree_rcu_by_lazy, 0, "Use call_rcu_lazy() to emulate kfree_rcu()?");
>  
>  static char *scale_type = "rcu";
>  module_param(scale_type, charp, 0444);
> @@ -658,6 +659,13 @@ struct kfree_obj {
>  	struct rcu_head rh;
>  };
>  
> +/* Used if doing RCU-kfree'ing via call_rcu_lazy(). */
> +void kfree_rcu_lazy(struct rcu_head *rh)
> +{
> +	struct kfree_obj *obj = container_of(rh, struct kfree_obj, rh);
> +	kfree(obj);
> +}
> +
>  static int
>  kfree_scale_thread(void *arg)
>  {
> @@ -695,6 +703,11 @@ kfree_scale_thread(void *arg)
>  			if (!alloc_ptr)
>  				return -ENOMEM;
>  
> +			if (kfree_rcu_by_lazy) {
> +				call_rcu_lazy(&(alloc_ptr->rh), kfree_rcu_lazy);
> +				continue;
> +			}
> +
>  			// By default kfree_rcu_test_single and kfree_rcu_test_double are
>  			// initialized to false. If both have the same value (false or true)
>  			// both are randomly tested, otherwise only the one with value true
> @@ -737,6 +750,9 @@ kfree_scale_cleanup(void)
>  {
>  	int i;
>  
> +	if (kfree_rcu_by_lazy)
> +		rcu_force_call_rcu_to_lazy(false);
> +
>  	if (torture_cleanup_begin())
>  		return;
>  
> @@ -766,11 +782,55 @@ kfree_scale_shutdown(void *arg)
>  	return -EINVAL;
>  }
>  
> +// Used if doing RCU-kfree'ing via call_rcu_lazy().
> +unsigned long jiffies_at_lazy_cb;
> +struct rcu_head lazy_test1_rh;
> +int rcu_lazy_test1_cb_called;
> +void call_rcu_lazy_test1(struct rcu_head *rh)
> +{
> +	jiffies_at_lazy_cb = jiffies;
> +	WRITE_ONCE(rcu_lazy_test1_cb_called, 1);
> +}
> +
>  static int __init
>  kfree_scale_init(void)
>  {
>  	long i;
>  	int firsterr = 0;
> +	unsigned long orig_jif, jif_start;
> +
> +	// Force all call_rcu() to call_rcu_lazy() so that non-lazy CBs
> +	// do not remove laziness of the lazy ones (since the test tries
> +	// to stress call_rcu_lazy() for OOM).
> +	//
> +	// Also, do a quick self-test to ensure laziness is as much as
> +	// expected.
> +	if (kfree_rcu_by_lazy) {
> +		/* do a test to check the timeout. */
> +		orig_jif = rcu_scale_get_jiffies_till_flush();
> +
> +		rcu_force_call_rcu_to_lazy(true);
> +		rcu_scale_set_jiffies_till_flush(2 * HZ);
> +		rcu_barrier();
> +
> +		jif_start = jiffies;
> +		jiffies_at_lazy_cb = 0;
> +		call_rcu_lazy(&lazy_test1_rh, call_rcu_lazy_test1);
> +
> +		smp_cond_load_relaxed(&rcu_lazy_test1_cb_called, VAL == 1);
> +
> +		rcu_scale_set_jiffies_till_flush(orig_jif);
> +
> +		if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start < 2 * HZ)) {
> +			pr_alert("Lazy CBs are not being lazy as expected!\n");
> +			return -1;
> +		}
> +
> +		if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start > 3 * HZ)) {
> +			pr_alert("Lazy CBs are being too lazy!\n");
> +			return -1;
> +		}
> +	}
>  
>  	kfree_nrealthreads = compute_real(kfree_nthreads);
>  	/* Start up the kthreads. */
> @@ -783,7 +843,9 @@ kfree_scale_init(void)
>  		schedule_timeout_uninterruptible(1);
>  	}
>  
> -	pr_alert("kfree object size=%zu\n", kfree_mult * sizeof(struct kfree_obj));
> +	pr_alert("kfree object size=%zu, kfree_rcu_by_lazy=%d\n",
> +			kfree_mult * sizeof(struct kfree_obj),
> +			kfree_rcu_by_lazy);
>  
>  	kfree_reader_tasks = kcalloc(kfree_nrealthreads, sizeof(kfree_reader_tasks[0]),
>  			       GFP_KERNEL);
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index b481f1ea57c0..255f2945b0fc 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -257,6 +257,21 @@ static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
>  }
>  
>  #define LAZY_FLUSH_JIFFIES (10 * HZ)
> +unsigned long jiffies_till_flush = LAZY_FLUSH_JIFFIES;
> +
> +#ifdef CONFIG_RCU_SCALE_TEST
> +void rcu_scale_set_jiffies_till_flush(unsigned long jif)
> +{
> +	jiffies_till_flush = jif;
> +}
> +EXPORT_SYMBOL(rcu_scale_set_jiffies_till_flush);
> +
> +unsigned long rcu_scale_get_jiffies_till_flush(void)
> +{
> +	return jiffies_till_flush;
> +}
> +EXPORT_SYMBOL(rcu_scale_get_jiffies_till_flush);
> +#endif
>  
>  /*
>   * Arrange to wake the GP kthread for this NOCB group at some future
> @@ -275,7 +290,7 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
>  	 * of callback storm, no need to wake up too early.
>  	 */
>  	if (waketype == RCU_NOCB_WAKE_LAZY) {
> -		mod_timer(&rdp_gp->nocb_timer, jiffies + LAZY_FLUSH_JIFFIES);
> +		mod_timer(&rdp_gp->nocb_timer, jiffies + jiffies_till_flush);
>  		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
>  	} else if (waketype == RCU_NOCB_WAKE_BYPASS) {
>  		mod_timer(&rdp_gp->nocb_timer, jiffies + 2);
> -- 
> 2.37.0.rc0.104.g0611611a94-goog
> 
