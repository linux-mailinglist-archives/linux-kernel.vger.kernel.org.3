Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FA64DA07D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 17:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350265AbiCOQxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 12:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350247AbiCOQxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:53:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0198B574BA;
        Tue, 15 Mar 2022 09:52:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D493B81802;
        Tue, 15 Mar 2022 16:52:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442E7C340EE;
        Tue, 15 Mar 2022 16:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647363149;
        bh=4xawDY+vF1YG/9BciGapYWDCeCa+R8zSAyRtVN4lguE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=vLhPvFgoiULE5T7ZQwxqbckZN/xFvIGh/NoINDMZMUCO3wCu0fJFWRPE8X6XgNNXS
         8X55HwxXR94yf22GQqLVguhEcxC53OKgcnW0xrtyDcKEjALeUaHEdHgW+aGvUsfwj4
         nUQiUfrjOLFL8DgahVFdtGrS16bs5rn59A7+KCtkWMUcrNOLBvfP3auvmyF4EzHCQN
         H8cbJxrprGjS30u+fXTLGXdX/64EW0iFjNpG7jJoEF0UEWMYPpgxaHoGBbH80RCjge
         hVHR0zFfpBzYh3HVMBjqN6X2y25537Ps8+K+ISnjlp+tkrusL2FvCLGt420SoJKMO/
         xct1OdFRQ4PdQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DDC275C051B; Tue, 15 Mar 2022 09:52:28 -0700 (PDT)
Date:   Tue, 15 Mar 2022 09:52:28 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     rcu@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] srcu: drop the needless initialization in srcu_gp_start()
Message-ID: <20220315165228.GD4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220315085549.22033-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315085549.22033-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 09:55:49AM +0100, Lukas Bulwahn wrote:
> Commit 9c7ef4c30f12 ("srcu: Make Tree SRCU able to operate without snp_node
> array") initializes the local variable sdp differently depending on the
> srcu's state in srcu_gp_start().
> 
> Hence, the initialization of sdp with the variable definition is not used
> before its second initialization.
> 
> Drop the needless initialization in srcu_gp_start() to have clear code.
> 
> No functional change. Some changes in the resulting object code due to
> various rearrangements by the compiler.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Paul, please pick this minor non-urgent clean-up patch.

Good eyes, thank you!

I have pulled this in for testing and review.  If things go will,
I expect to push it into the v5.19 merge window (that is, not the one
that will likely open next week, but the one after that).

As usual, I could not resist wordsmithing the commit log.  Could you
please check out the wordsmithed version below to make sure that I did
not mess something up?

							Thanx, Paul

------------------------------------------------------------------------

commit a0c59d99e87c52d6832e1ad39421b4a4386cdfd6
Author: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue Mar 15 09:55:49 2022 +0100

    srcu: Drop needless initialization of sdp in srcu_gp_start()
    
    Commit 9c7ef4c30f12 ("srcu: Make Tree SRCU able to operate without
    snp_node array") initializes the local variable sdp differently depending
    on the srcu's state in srcu_gp_start().  Either way, this initialization
    overwrites the value used when sdp is defined.
    
    This commit therefore drops this pointless definition-time initialization.
    Although there is no functional change, compiler code generation may
    be affected.
    
    Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index e78b1c7929d6..3bc8267c5d0b 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -609,7 +609,7 @@ EXPORT_SYMBOL_GPL(__srcu_read_unlock);
  */
 static void srcu_gp_start(struct srcu_struct *ssp)
 {
-	struct srcu_data *sdp = this_cpu_ptr(ssp->sda);
+	struct srcu_data *sdp;
 	int state;
 
 	if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
