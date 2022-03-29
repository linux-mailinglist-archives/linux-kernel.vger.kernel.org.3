Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B0A4EB6AC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 01:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240144AbiC2XYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 19:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236546AbiC2XYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 19:24:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDED3185452;
        Tue, 29 Mar 2022 16:22:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76D5E60FA2;
        Tue, 29 Mar 2022 23:22:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CACDBC2BBE4;
        Tue, 29 Mar 2022 23:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648596176;
        bh=fyyI03YUsRLxwjzWMxbmnfhC7VJBY/raoIuviwH/S14=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kdEr5XTK7Pj+Oiu0mRYwSRc4hLAw215MubZByZjF+HqXi3ZIaPeSGIuOYv2k3NRjA
         rmjGm4qkjSpcBoURvYA0r60KX7c8pcqUqO+TPenafgVFXp0QOsugCphqAoY+9M+BNt
         t9F9oIZCjSG/HVuj+SQsC66yj5rpVsS48qsUUSaJQlwB6P7JqDcFqNBu1t1R8Q4oeM
         WAJBi6FM/a9crU2EuXjd5IvDgJIpJp8+6TxqlQ/TnfH/xO+L8oV5V0u0uDwUtPHjWp
         V/29RHEX8zXe2VcnR235DF2Me6ftO643lMaFWAHIMO8pVf657qYGIFHNS1RlFEE2jV
         nKbL4P2NdzxNA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 609815C0A0D; Tue, 29 Mar 2022 16:22:56 -0700 (PDT)
Date:   Tue, 29 Mar 2022 16:22:56 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     David Vernet <void@manifault.com>
Cc:     frederic@kernel.org, jiangshanlai@gmail.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
        quic_neeraju@quicinc.com, rcu@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH] rcu_sync: Fix comment to properly reflect
 rcu_sync_exit() behavior
Message-ID: <20220329232256.GE4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220329222612.1001586-1-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329222612.1001586-1-void@manifault.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 03:26:13PM -0700, David Vernet wrote:
> rcu_sync_enter() is an rcu_sync API used by updaters which forces RCU
> readers (e.g. percpu-rwsem) to take a slow-path during an update. It does
> this by setting the gp_state of the rcu_sync object to GP_ENTER (i.e. > 0).
> In this state, readers will take a "slow path", such as having percpu-rwsem
> readers wait on a semaphore rather than just incrementing a reader count.
> When the updater has completed their work, they must invoke rcu_sync_exit()
> to signal to readers that they may again take their fastpaths.
> 
> rcu_sync_enter() currently has a comment that stipulates that a later call
> to rcu_sync_exit() (by an updater) will re-enable reader "slowpaths". This
> patch corrects the comment to properly reflect that rcu_sync_exit()
> re-enables reader fastpaths.
> 
> Signed-off-by: David Vernet <void@manifault.com>

Good eyes, thank you!

As usual, I could not resist the urge to wordsmith.  Please take a look
at the following to see if I messed something up.

							Thanx, Paul

------------------------------------------------------------------------

commit b89e06a95c05009bcf31949814c42bc420f414a6
Author: David Vernet <void@manifault.com>
Date:   Tue Mar 29 15:26:13 2022 -0700

    rcu_sync: Fix comment to properly reflect rcu_sync_exit() behavior
    
    The rcu_sync_enter() function is used by updaters to force RCU readers
    (e.g. percpu-rwsem) to use their slow paths during an update.  This is
    accomplished by setting the ->gp_state of the rcu_sync structure to
    GP_ENTER.  In the case of percpu-rwsem, the readers' slow path waits on
    a semaphore instead of just incrementing a reader count.  Each updater
    invokes the rcu_sync_exit() function to signal to readers that they
    may again take their fastpaths.  The rcu_sync_exit() function sets the
    ->gp_state of the rcu_sync structure to GP_EXIT, and if all goes well,
    after a grace period the ->gp_state reverts back to GP_IDLE.
    
    Unfortunately, the rcu_sync_enter() function currently has a comment
    incorrectly stating that rcu_sync_exit() (by an updater) will re-enable
    reader "slowpaths".  This patch changes the comment to state that this
    function re-enables reader fastpaths.
    
    Signed-off-by: David Vernet <void@manifault.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/sync.c b/kernel/rcu/sync.c
index 33d896d85902..5cefc702158f 100644
--- a/kernel/rcu/sync.c
+++ b/kernel/rcu/sync.c
@@ -111,7 +111,7 @@ static void rcu_sync_func(struct rcu_head *rhp)
  * a slowpath during the update.  After this function returns, all
  * subsequent calls to rcu_sync_is_idle() will return false, which
  * tells readers to stay off their fastpaths.  A later call to
- * rcu_sync_exit() re-enables reader slowpaths.
+ * rcu_sync_exit() re-enables reader fastpaths.
  *
  * When called in isolation, rcu_sync_enter() must wait for a grace
  * period, however, closely spaced calls to rcu_sync_enter() can
