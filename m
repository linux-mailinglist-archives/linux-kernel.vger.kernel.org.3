Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20D2465030
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351003AbhLAOof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350689AbhLAOmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:42:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05F8C061396;
        Wed,  1 Dec 2021 06:37:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B35A9B81FE1;
        Wed,  1 Dec 2021 14:37:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B47FC53FCC;
        Wed,  1 Dec 2021 14:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638369455;
        bh=8tI1ueqtoUGBHxIn0DIOwwe7EpQvXK0zlIGQBD3fb9c=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PHiMNFYCwyGnWE8n56PQo0IO8rkI2Bu88RWUIVQb//+aCZsL/0KgrQbx7U4r9XKsN
         GqkTbMLWZIX2poQ0ZDJEPiqZe9W/c587gEv9gA3syh0FIZnB6kgVIbz4t3RHWvgt8V
         Foadylp3qypcQOaP89z97ZUrux1OouGmigGTUs3CrYnWJ+zShY0IpES7m2g0iVN9xm
         Bt9eZ63w4Q7bB2RSvHJ+DFRNlYEj69dvx0hmtIFilwKpvUlT7dKkAvdpoUg7J/ZVhF
         gv1w5S3kq/Wwdbs1FHX1A5ywYI8WeBpOGxJsNBp42sphx6yhmyj2s1SX0dpMYD85+D
         6E/xQFPSCaHHg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3508C5C0668; Wed,  1 Dec 2021 06:37:35 -0800 (PST)
Date:   Wed, 1 Dec 2021 06:37:35 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] rcu: Fix description of kvfree_rcu()
Message-ID: <20211201143735.GE641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211201092053.2000-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201092053.2000-1-urezki@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 10:20:53AM +0100, Uladzislau Rezki (Sony) wrote:
> The passed "ptr" parameter might be wrongly interpreted
> therefore rephrase it to prevent people from being confused.
> 
> Reported-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Thank you both!  Queued with wordsmithed commit log as shown below,
so please check to see if I messed anything up.

							Thanx, Paul

------------------------------------------------------------------------

commit 59ef229194204b023bb7bde95ce769d4e94a4b62
Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
Date:   Wed Dec 1 10:20:53 2021 +0100

    rcu: Fix description of kvfree_rcu()
    
    The kvfree_rcu() header comment's description of the "ptr" parameter
    is unclear, therefore rephrase it to make it clear that it is a pointer
    to the memory to eventually be passed to kvfree().
    
    Reported-by: Steven Rostedt <rostedt@goodmis.org>
    Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 88b42eb464068..9d7df8d36af07 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -924,7 +924,7 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
  *
  *     kvfree_rcu(ptr);
  *
- * where @ptr is a pointer to kvfree().
+ * where @ptr is the pointer to be freed by kvfree().
  *
  * Please note, head-less way of freeing is permitted to
  * use from a context that has to follow might_sleep()
