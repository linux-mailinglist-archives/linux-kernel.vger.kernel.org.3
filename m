Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8287250BA82
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448865AbiDVOrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237708AbiDVOrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:47:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2DD5C34B;
        Fri, 22 Apr 2022 07:44:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 642FE60E08;
        Fri, 22 Apr 2022 14:44:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C535CC385A8;
        Fri, 22 Apr 2022 14:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650638661;
        bh=31wPn4L1S1z5C6cWC6u0dIySUFUsq0alWQMCX0bcBA8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Kv48hkl4EhooNQASdUF4zixEu2xOxKLNFdTTUd4mOIUqwyp4OfF/2ZC1Q8iVbVar6
         xCx3QwSvjhgRn2UqHmxlChmo0itI8Y9NHHdGkiEUb9Ito//jETQYpNc8Jzfcw2Grz2
         7Ch54TzqAd4tdKkvwNIjTSO/gn0MGq9vK5HMaLGQ7o2z9qmyNwoDLn1kXJ86iBtC/J
         ElY6SKygkfgeO91i6d2V20uR/9aunoeb+56BPwLPfHLD3zreb3yJzT0SIM4995rtLy
         WiIWHDOZuUPQt1QhwT18qqOrWYXpfWaYMWZUM3h6xIiQxzDPaTa+AXOHWaqrRGtW0F
         lBVrr0P4pnZyQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6988F5C0460; Fri, 22 Apr 2022 07:44:21 -0700 (PDT)
Date:   Fri, 22 Apr 2022 07:44:21 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Put panic_on_rcu_stall() after expedited RCU CPU
 stall warnings
Message-ID: <20220422144421.GX4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220422131518.3090060-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422131518.3090060-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 09:15:18PM +0800, Zqiang wrote:
> When the expedited RCU CPU stall warning is treated as panic, if
> it's triggered, the stall info should be printed first and tell us
> reason, rather than directly panic.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Good eyes, thank you!

Queued for v5.20, with the wordsmithing shown below.  Please let me
know if I messed anything up.

							Thanx, Paul

------------------------------------------------------------------------

commit e5215598af9bdf5509c7e7c6f896f50df0cdaf4b
Author: Zqiang <qiang1.zhang@intel.com>
Date:   Fri Apr 22 21:15:18 2022 +0800

    rcu: Put panic_on_rcu_stall() after expedited RCU CPU stall warnings
    
    When a normal RCU CPU stall warning is encountered with the
    panic_on_rcu_stall sysfs variable is set, the system panics only after
    the stall warning is printed.  But when an expedited RCU CPU stall
    warning is encountered with the panic_on_rcu_stall sysfs variable is
    set, the system panics first, thus never printing the stall warning.
    This commit therefore brings the expedited stall warning into line with
    the normal stall warning by printing first and panicking afterwards.
    
    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 571b0a700cce..f05a15b11fa0 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -623,7 +623,6 @@ static void synchronize_rcu_expedited_wait(void)
 			return;
 		if (rcu_stall_is_suppressed())
 			continue;
-		panic_on_rcu_stall();
 		trace_rcu_stall_warning(rcu_state.name, TPS("ExpeditedStall"));
 		pr_err("INFO: %s detected expedited stalls on CPUs/tasks: {",
 		       rcu_state.name);
@@ -671,6 +670,7 @@ static void synchronize_rcu_expedited_wait(void)
 			}
 		}
 		jiffies_stall = 3 * rcu_exp_jiffies_till_stall_check() + 3;
+		panic_on_rcu_stall();
 	}
 }
 
