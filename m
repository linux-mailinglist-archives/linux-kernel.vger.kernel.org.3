Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE99654A2EA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 01:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbiFMXr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 19:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiFMXrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 19:47:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F85326EE;
        Mon, 13 Jun 2022 16:47:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF37B614C2;
        Mon, 13 Jun 2022 23:47:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B92C34114;
        Mon, 13 Jun 2022 23:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655164073;
        bh=5yF9QhQ4vupDYJDrsb4LKrVEEhEOsB8IRWAY1UxEZWA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ILbgpOy13nDDak7Lrna/R70a3H6ippqe2kRaGvA+m5KL0+jDHo99ikreSmx0POhv0
         UONVHG2mxkMxs1XkWckhtVhKg+H71NcHCpXR5ENL7TwTwlWTN5j+JNsQ4Q7Ts86P8l
         IooymKlhbo3VDW5YJNiuRrEpndIn6Cfc00f6jRjfa8P0QSSUhcTeS+23Qpph0/T0uo
         Ko/C2/ULjscjW+buqIrv6O/87kmL2fN9lw1jYv+cuqfUIwZ10gdn6Yt33k4w1wJdaK
         P1U7YkCUVmT7yPlxqRsVQnTJr6Cwq7iujZIjCxF5b6AvDxaiVWUMKm39halM5BlZmL
         +YV97oW7vsmzw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F3CE65C02F9; Mon, 13 Jun 2022 16:47:52 -0700 (PDT)
Date:   Mon, 13 Jun 2022 16:47:52 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Li Qiong <liqiong@nfschina.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        hukun@nfschina.com, qixu@nfschina.com, yuzhe@nfschina.com,
        renyu@nfschina.com
Subject: Re: [PATCH v2] rcu: Handle failure of memory allocation functions
Message-ID: <20220613234752.GL1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220611093055.1473-1-liqiong@nfschina.com>
 <20220612064825.32273-1-liqiong@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220612064825.32273-1-liqiong@nfschina.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2022 at 02:48:25PM +0800, Li Qiong wrote:
> Add warning when these functions (eg:kmalloc,vmalloc) fail, handle the
> failure.
> 
> Signed-off-by: Li Qiong <liqiong@nfschina.com>

Queued for review and testing with a bit of wordsmithing, thank you!

Please see below to check whether I messed something up.

							Thanx, Paul

------------------------------------------------------------------------

commit 19deffcffe66991c9a9e435ae90b16b97b83e4c1
Author: Li Qiong <liqiong@nfschina.com>
Date:   Sun Jun 12 14:48:25 2022 +0800

    rcu: Handle failure of memory allocation functions
    
    This commit adds warnings and ends the mem_dump_obj() test when allocation
    functions (kmalloc(), vmalloc(), ...) fail.
    
    Signed-off-by: Li Qiong <liqiong@nfschina.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 21470ebb15eb4..ccc1af23dc1f2 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2051,7 +2051,13 @@ static void rcu_torture_mem_dump_obj(void)
 	static int z;
 
 	kcp = kmem_cache_create("rcuscale", 136, 8, SLAB_STORE_USER, NULL);
+	if (WARN_ON_ONCE(!kcp))
+		return;
 	rhp = kmem_cache_alloc(kcp, GFP_KERNEL);
+	if (WARN_ON_ONCE(!rhp)) {
+		kmem_cache_destroy(kcp);
+		return;
+	}
 	pr_alert("mem_dump_obj() slab test: rcu_torture_stats = %px, &rhp = %px, rhp = %px, &z = %px\n", stats_task, &rhp, rhp, &z);
 	pr_alert("mem_dump_obj(ZERO_SIZE_PTR):");
 	mem_dump_obj(ZERO_SIZE_PTR);
@@ -2068,6 +2074,8 @@ static void rcu_torture_mem_dump_obj(void)
 	kmem_cache_free(kcp, rhp);
 	kmem_cache_destroy(kcp);
 	rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
+	if (WARN_ON_ONCE(!rhp))
+		return;
 	pr_alert("mem_dump_obj() kmalloc test: rcu_torture_stats = %px, &rhp = %px, rhp = %px\n", stats_task, &rhp, rhp);
 	pr_alert("mem_dump_obj(kmalloc %px):", rhp);
 	mem_dump_obj(rhp);
@@ -2075,6 +2083,8 @@ static void rcu_torture_mem_dump_obj(void)
 	mem_dump_obj(&rhp->func);
 	kfree(rhp);
 	rhp = vmalloc(4096);
+	if (WARN_ON_ONCE(!rhp))
+		return;
 	pr_alert("mem_dump_obj() vmalloc test: rcu_torture_stats = %px, &rhp = %px, rhp = %px\n", stats_task, &rhp, rhp);
 	pr_alert("mem_dump_obj(vmalloc %px):", rhp);
 	mem_dump_obj(rhp);
