Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E533455396C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 20:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347123AbiFUSNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 14:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbiFUSNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 14:13:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A918F25E9B;
        Tue, 21 Jun 2022 11:13:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 464976168E;
        Tue, 21 Jun 2022 18:13:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8A1C3411C;
        Tue, 21 Jun 2022 18:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655835215;
        bh=w3hO8uNJl2abZZ9TebD5S70Nf2iJmX+64Che02GHZaA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LY6YU9+2pUZqHa3k0O7duT+EXS1Q8OiL+DzeRsfRCqxNBx0CZh+sUJQgdl1RlpvHd
         KJU/x/boZ/BxKKbJFgBn2aHJZVefvLFnD+OMyrKEMgXeHR3B/Jr9NMdOSmmYv7yiBy
         7q5kmyVZetIllhFJ+JMb3hRcQZU2SmmYinpKW60ipClV6TYCrxyCp/k6lCQ8C6+/os
         i/cSUvOUIxU6F6YzVEzhRlASTfOxcMJ67XxYf9s4ygIcklnHUO42qeOs2LQ8s+inC7
         LIy8ci9BlFKq+3j94ITyBSQRdAAazz/UnYEJ4RF1XCWbnU5D3DstTiGRqkrf9uZKCi
         7VOLPXpqtrvAg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 371355C0399; Tue, 21 Jun 2022 11:13:35 -0700 (PDT)
Date:   Tue, 21 Jun 2022 11:13:35 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org
Subject: Re: [PATCH rcu 11/12] torture: Flush printk() buffers before
 powering off
Message-ID: <20220621181335.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220620225814.GA3842995@paulmck-ThinkPad-P17-Gen-1>
 <20220620225817.3843106-11-paulmck@kernel.org>
 <8735fyc42v.fsf@jogness.linutronix.de>
 <20220620232838.GZ1790663@paulmck-ThinkPad-P17-Gen-1>
 <87v8suphdy.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8suphdy.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 10:15:29AM +0206, John Ogness wrote:
> On 2022-06-20, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > But given Petr's and your recent changes that are now in mainline, is
> > this still really needed?  (Tests now pass without it, though tests can
> > of course be misleading.)
> 
> If all you are interested is if your rcutorture testing was successful,
> then I would keep this change. Then, no matter what the kernel does
> afterwards, you have your test results.
> 
> However, the kernel should correctly shutdown and it should flush the
> kernel buffers on shutdown or crash. (It is a kernel bug otherwise.) So
> if you also want to implicitly test this (non-rcutorture) functionality,
> then you should not use this patch.

Why not both?  ;-)

The patch below will cause rcutorture to implicitly test this
functionality, unless told otherwise, for example, by using the
--bootargs "torture.printk_shutdown_bug_workaround" kvm.sh
argument.

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

commit 204bf1e2a5a2fb68c15b4b64793ad0896db6f705
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Tue Jun 21 11:02:25 2022 -0700

    torture: Optionally flush printk() buffers before powering off
    
    The rcutorture test suite produces quite a bit of console output at
    the end of a test.  This means that the new-in-2022 printk() kthreads
    are likely to be in the process of flushing output at the time of the
    torture_shutdown() function's call to kernel_power_off().  Normally,
    rcutorture relies on printk() to flush any pending output upon shutdown,
    the better to detect bugs in this area, for example, the one introduced
    by 8e274732115f ("printk: extend console_lock for per-console locking").
    However, once such a bug is detected and reported, it is necessary to
    test the rest of the system, without noise from the already-reported bug.
    
    This commit therefore adds a torture.printk_shutdown_bug_workaround
    kernel parameter, which causes torture_shutdown() to invoke pr_flush(),
    and print an informative message on the console, immediately before
    invoking kernel_power_off().  When this kernel parameter is not specified,
    it is up to printk() to flush its own buffers.
    
    Suggested-by: John Ogness <john.ogness@linutronix.de>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index d8de18d8f8875..652f49c4e5990 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6045,6 +6045,12 @@
 			are running concurrently, especially on systems
 			with rotating-rust storage.
 
+	torture.printk_shutdown_bug_workaround= [KNL]
+			Execute pr_flush(1000, true) just before invoking
+			kernel_power_off() to work around any bugs that
+			might prevent printk() from flushing its buffers
+			at shutdown time.
+
 	torture.verbose_sleep_frequency= [KNL]
 			Specifies how many verbose printk()s should be
 			emitted between each sleep.  The default of zero
diff --git a/kernel/torture.c b/kernel/torture.c
index 789aeb0e1159c..7cd2016b02076 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -48,6 +48,9 @@ module_param(disable_onoff_at_boot, bool, 0444);
 static bool ftrace_dump_at_shutdown;
 module_param(ftrace_dump_at_shutdown, bool, 0444);
 
+static bool printk_shutdown_bug_workaround;
+module_param(printk_shutdown_bug_workaround, bool, 0444);
+
 static int verbose_sleep_frequency;
 module_param(verbose_sleep_frequency, int, 0444);
 
@@ -651,6 +654,10 @@ static int torture_shutdown(void *arg)
 		VERBOSE_TOROUT_STRING("No torture_shutdown_hook(), skipping.");
 	if (ftrace_dump_at_shutdown)
 		rcu_ftrace_dump(DUMP_ALL);
+	if (printk_shutdown_bug_workaround) {
+		pr_info("%s: Flushing printk() buffers at power-down time.\n", __func__);
+		pr_flush(1000, true);
+	}
 	kernel_power_off();	/* Shut down the system. */
 	return 0;
 }
