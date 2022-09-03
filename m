Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857625AC181
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 00:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbiICWAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 18:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbiICWAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 18:00:33 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAB84B0F9
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 15:00:31 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id m5so4238707qkk.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Sep 2022 15:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=u+kxf3Mk8+FQgloXjB0j6r4XiunuDU8cUK2uuImDHew=;
        b=WRk8qIaK1KlK/bMR9yB/rnuP0D7C4gkK1fxXvaCOHkpQOPOqzW/y3ua4Dso1vEvS3Y
         Mqk88gd9/98GwbFwUECnlBiszMnRMM6BVTetZLzbOi2phpVx1ua4OanmomNHitknNLvV
         vEsEZ2LfuxjFoc5YKlUKKVr42rFFWBFY92owY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=u+kxf3Mk8+FQgloXjB0j6r4XiunuDU8cUK2uuImDHew=;
        b=BSsJX2udu96jKz3Bevxwergf7iwRpe/0Kv+L/r6LfT6SM7c3+gHWH0VMgawjorAirF
         MrOyaDdjvWZes2EGwZyjKStcwmrbiFe5UkOxlTBld4Agl5bu0V3KA+UoVMOjz2roOtcw
         CgifF8lvAszXqD/a3Yc78Bd6UKUB4XChFWmvwMIFZLxzX34kw4eOE16NdsETr3UbSz+g
         hQLMQyRMRzINRyVEjW/BuK4Prg84Ff9h/QPYQQOph9sGAJ6ePa0jdLEOAMY9xdrltXnM
         MMVDCB+XNae2leCL4WXZZ/uL1MSZZF4A8D8gZzPQKhsOE15j8EyK16BGeL8G/7Q9YODg
         8NYw==
X-Gm-Message-State: ACgBeo2MtEWKhbh8kHyGneLB8264DzCyTOKaC8btFkFGncZq78Nze+I8
        +lkHHYy9hMINzlcEIKLafIIxIQ==
X-Google-Smtp-Source: AA6agR5ekOGLODSeUofP+ecxaHtu90UOsouL28dyBxK9YtL/I6e0BeBlxPnij3XHIxSr85XcSeGzTA==
X-Received: by 2002:a05:620a:4155:b0:6bb:2061:1167 with SMTP id k21-20020a05620a415500b006bb20611167mr28395464qko.623.1662242430206;
        Sat, 03 Sep 2022 15:00:30 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id bm15-20020a05620a198f00b006bb9125363fsm4576297qkb.121.2022.09.03.15.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 15:00:29 -0700 (PDT)
Date:   Sat, 3 Sep 2022 22:00:29 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org, boqun.feng@gmail.com
Subject: Re: [PATCH v5 06/18] rcu: Introduce call_rcu_lazy() API
 implementation
Message-ID: <YxPOfVMzRWEa7xqf@google.com>
References: <20220901221720.1105021-1-joel@joelfernandes.org>
 <20220901221720.1105021-7-joel@joelfernandes.org>
 <20220902152132.GA115525@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902152132.GA115525@lothringen>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 05:21:32PM +0200, Frederic Weisbecker wrote:
[..] 
> > +
> >  	raw_spin_unlock_irqrestore(&rdp_gp->nocb_gp_lock, flags);
> >  
> >  	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, reason);
> [...]
> > @@ -705,12 +816,21 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
> >  	my_rdp->nocb_gp_gp = needwait_gp;
> >  	my_rdp->nocb_gp_seq = needwait_gp ? wait_gp_seq : 0;
> >  
> > -	if (bypass && !rcu_nocb_poll) {
> > -		// At least one child with non-empty ->nocb_bypass, so set
> > -		// timer in order to avoid stranding its callbacks.
> > -		wake_nocb_gp_defer(my_rdp, RCU_NOCB_WAKE_BYPASS,
> > -				   TPS("WakeBypassIsDeferred"));
> > +	// At least one child with non-empty ->nocb_bypass, so set
> > +	// timer in order to avoid stranding its callbacks.
> > +	if (!rcu_nocb_poll) {
> > +		// If bypass list only has lazy CBs. Add a deferred
> > +		// lazy wake up.
> > +		if (lazy && !bypass) {
> > +			wake_nocb_gp_defer(my_rdp, RCU_NOCB_WAKE_LAZY,
> > +					TPS("WakeLazyIsDeferred"));
> 
> What if:
> 
> 1) rdp(1) has lazy callbacks
> 2) all other rdp's have no callback at all
> 3) nocb_gp_wait() runs through all rdp's, everything is handled, except for
>    these lazy callbacks
> 4) It reaches the above path, ready to arm the RCU_NOCB_WAKE_LAZY timer,
>    but it hasn't yet called wake_nocb_gp_defer()
> 5) Oh but rdp(2) queues a non-lazy callback. interrupts are disabled so it defers
>    the wake up to nocb_gp_wait() with arming the timer in RCU_NOCB_WAKE.
> 6) nocb_gp_wait() finally calls wake_nocb_gp_defer() and override the timeout
>    to several seconds ahead.
> 7) No more callbacks queued, the non-lazy callback will have to wait several
>    seconds to complete.
> 
> Or did I miss something? Note that the race exists with RCU_NOCB_WAKE_BYPASS
> but it's only about one jiffy delay, not seconds.
> 

So I think the below patch should fix that. But I have not tested it at all
and it could very well have issues. In particular, there is a likelihood of a
wake up while holding a lock which I'm not sure is safe due to scheduler
locks. I'll test it next week. Let me know any thoughts though.

---8<-----------------------

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH] rcu: Fix race where wake_nocb_gp_defer() lazy wake can
 overwrite a non-lazy wake

Fix by holding nocb_gp_lock when observing the state of all rdps. If any
rdp queued a non-lazy CB, we would do a wake up of the main gp thread.

This should address the race Frederick reported (which could effect both
non-lazy CBs using the bypass list, and lazy CBs, though lazy CBs much
more noticeably).

Quoting from Frederic's email:

1) rdp(1) has lazy callbacks
2) all other rdp's have no callback at all
3) nocb_gp_wait() runs through all rdp's, everything is handled, except for
   these lazy callbacks
4) It reaches the above path, ready to arm the RCU_NOCB_WAKE_LAZY timer,
   but it hasn't yet called wake_nocb_gp_defer()
5) Oh but rdp(2) queues a non-lazy callback. interrupts are disabled so it defers
   the wake up to nocb_gp_wait() with arming the timer in RCU_NOCB_WAKE.
6) nocb_gp_wait() finally calls wake_nocb_gp_defer() and override the timeout
   to several seconds ahead.
7) No more callbacks queued, the non-lazy callback will have to wait several
   seconds to complete.

Here, the nocb gp lock is held when #4 happens. So the deferred wakeup
on #5 has to wait till #4 finishes.

Reported-by: Frederic Weisbecker <fweisbec@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree_nocb.h | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 8b46442e4473..6690ece8fe20 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -285,14 +285,15 @@ EXPORT_SYMBOL(rcu_lazy_get_jiffies_till_flush);
  * Arrange to wake the GP kthread for this NOCB group at some future
  * time when it is safe to do so.
  */
-static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
-			       const char *reason)
+static void __wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
+			       const char *reason, bool locked)
 {
 	unsigned long flags;
 	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
 	unsigned long mod_jif = 0;
 
-	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
+	if (!locked)
+		raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
 
 	/*
 	 * Bypass and lazy wakeup overrides previous deferments. In case of
@@ -323,11 +324,23 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
 	if (rdp_gp->nocb_defer_wakeup < waketype)
 		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
 
-	raw_spin_unlock_irqrestore(&rdp_gp->nocb_gp_lock, flags);
+	if (!locked)
+		raw_spin_unlock_irqrestore(&rdp_gp->nocb_gp_lock, flags);
 
 	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, reason);
 }
 
+static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
+		const char *reason) {
+	__wake_nocb_gp_defer(rdp, waketype, reason, false);
+}
+
+
+static void wake_nocb_gp_defer_locked(struct rcu_data *rdp, int waketype,
+		const char *reason) {
+	__wake_nocb_gp_defer(rdp, waketype, reason, true);

+
 /*
  * Flush the ->nocb_bypass queue into ->cblist, enqueuing rhp if non-NULL.
  * However, if there is a callback to be enqueued and if ->nocb_bypass
@@ -754,6 +767,8 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 	 * is added to the list, so the skipped-over rcu_data structures
 	 * won't be ignored for long.
 	 */
+
+	raw_spin_lock_irqsave(&my_rdp->nocb_gp_lock, flags);
 	list_for_each_entry_rcu(rdp, &my_rdp->nocb_head_rdp, nocb_entry_rdp, 1) {
 		bool needwake_state = false;
 		bool flush_bypass = false;
@@ -855,14 +870,15 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		// If bypass list only has lazy CBs. Add a deferred
 		// lazy wake up.
 		if (lazy && !bypass) {
-			wake_nocb_gp_defer(my_rdp, RCU_NOCB_WAKE_LAZY,
+			wake_nocb_gp_defer_locked(my_rdp, RCU_NOCB_WAKE_LAZY,
 					TPS("WakeLazyIsDeferred"));
 		// Otherwise add a deferred bypass wake up.
 		} else if (bypass) {
-			wake_nocb_gp_defer(my_rdp, RCU_NOCB_WAKE_BYPASS,
+			wake_nocb_gp_defer_locked(my_rdp, RCU_NOCB_WAKE_BYPASS,
 					TPS("WakeBypassIsDeferred"));
 		}
 	}
+	raw_spin_unlock_irqrestore(&my_rdp->nocb_gp_lock, flags);
 
 	if (rcu_nocb_poll) {
 		/* Polling, so trace if first poll in the series. */
-- 
2.37.2.789.g6183377224-goog

