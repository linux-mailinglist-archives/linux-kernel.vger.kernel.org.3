Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0718F513B2A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350697AbiD1SFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245205AbiD1SE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:04:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD7C972A7;
        Thu, 28 Apr 2022 11:01:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7CD5EB82EF7;
        Thu, 28 Apr 2022 18:01:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FFB5C385A9;
        Thu, 28 Apr 2022 18:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651168900;
        bh=j73iXb7HRmYNvs62beHpaMLechgWJdFxikbQ4RJV4Ew=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=arTulElWhcwZNgmeTTmFxCr7czn03uLlxgEQVPEn9CVlcEMbvRrkd4EJXHmvbSMZ2
         grajzT44dJmJGlUT/YtAZhPXTpfeZusEKVKFW3/nfS38asp70m0VXe/Z73TEuudCDo
         nofjhlUGxzjz1ejBATWeP3SkBaj5wKU+xX9MwShHeu9kQPPLq8+h+XNSPEztkpnBln
         sO70Pg4FknvIyzw48FwKXHlQLXZi7HYEx4BkVzP8bLM3uM/jzJLuwclqY26sstWLDV
         vGuqfjf1UffYh8B83NMMeGrxHcB8ZaOOxpiIwErDYTq/s4tb3MGaFfi0/xhmlp/LcZ
         HyIFJ+wpIFAPw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D38FA5C0387; Thu, 28 Apr 2022 11:01:39 -0700 (PDT)
Date:   Thu, 28 Apr 2022 11:01:39 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Fix kmemleak in rcu_test_debug_objects()
Message-ID: <20220428180139.GK1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220427071520.2239030-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427071520.2239030-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 03:15:20PM +0800, Zqiang wrote:
> The kmemleak kthread scan to the following:
> 
> unreferenced object 0xffff95d941135b50 (size 16):
>   comm "swapper/0", pid 1, jiffies 4294667610 (age 1367.451s)
>   hex dump (first 16 bytes):
>     f0 c6 c2 bd d9 95 ff ff 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000bc81d9b1>] kmem_cache_alloc_trace+0x2f6/0x500
>     [<00000000d28be229>] rcu_torture_init+0x1235/0x1354
>     [<0000000032c3acd9>] do_one_initcall+0x51/0x210
>     [<000000003c117727>] kernel_init_freeable+0x205/0x259
>     [<000000003961f965>] kernel_init+0x1a/0x120
>     [<000000001998f890>] ret_from_fork+0x22/0x30
> 
> the rhp object is not released after use, so call kfree() to
> release it.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Good catch, thank you!

I queued this for v5.20 with the wordsmithed commit log shown below.

							Thanx, Paul

------------------------------------------------------------------------

commit 1a2df31f4026dbc8dc4db17a4c2ed01e67f45c92
Author: Zqiang <qiang1.zhang@intel.com>
Date:   Wed Apr 27 15:15:20 2022 +0800

    rcutorture: Fix memory leak in rcu_test_debug_objects()
    
    The kernel memory leak detector located the following:
    
    unreferenced object 0xffff95d941135b50 (size 16):
      comm "swapper/0", pid 1, jiffies 4294667610 (age 1367.451s)
      hex dump (first 16 bytes):
        f0 c6 c2 bd d9 95 ff ff 00 00 00 00 00 00 00 00  ................
      backtrace:
        [<00000000bc81d9b1>] kmem_cache_alloc_trace+0x2f6/0x500
        [<00000000d28be229>] rcu_torture_init+0x1235/0x1354
        [<0000000032c3acd9>] do_one_initcall+0x51/0x210
        [<000000003c117727>] kernel_init_freeable+0x205/0x259
        [<000000003961f965>] kernel_init+0x1a/0x120
        [<000000001998f890>] ret_from_fork+0x22/0x30
    
    This is caused by the rcu_test_debug_objects() function allocating an
    rcu_head structure, then failing to free it.  This commit therefore adds
    the needed kfree() after the last use of this structure.
    
    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index bb2e1610d0add..faf6b4c7a7572 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -3176,6 +3176,7 @@ static void rcu_test_debug_objects(void)
 	pr_alert("%s: WARN: Duplicate call_rcu() test complete.\n", KBUILD_MODNAME);
 	destroy_rcu_head_on_stack(&rh1);
 	destroy_rcu_head_on_stack(&rh2);
+	kfree(rhp);
 #else /* #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD */
 	pr_alert("%s: !CONFIG_DEBUG_OBJECTS_RCU_HEAD, not testing duplicate call_rcu()\n", KBUILD_MODNAME);
 #endif /* #else #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD */
