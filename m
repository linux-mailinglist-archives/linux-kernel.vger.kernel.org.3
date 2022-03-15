Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BD04D9F58
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 16:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237833AbiCOPxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 11:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349874AbiCOPxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 11:53:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A38B55BD7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 08:52:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42FDC6134E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 15:52:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19281C340ED;
        Tue, 15 Mar 2022 15:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647359549;
        bh=zjDOtndMSP12811nc1wYenpXv0yI+HChpWPOg9L3V4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eObWNAZfYH1Ruq+q76YTgA+6fMA1ki9pMImj9pPbmw54sj/hhV9uEy+A/Ud9FebQc
         jgevnmxaNXaYHKalS/Osr9qvV6Eh0+b6boP8ujbBXX8gjzmzscqFFwIDZEJ5iprmxX
         TXk4BLtxZa+MtoeKY7pbmaV3V7EnzmEoT1s+xIpFYwhn7tfDwOZdUXLm62nMpwTJQB
         EAaEIB3mtmA1gTPcpgLbHj742X4WXuMEvj0J3rmgohPxUm9aq8NqoPWq/2wN4/Z+n4
         dD2FLlnumIHwRaJtUs8PWIfC1zY2eyC1t9b7Hpakm8qWJ3a0WpGEn/6Uk75jyNr5BG
         grYKyM+lm10WQ==
Date:   Tue, 15 Mar 2022 16:52:26 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 0/3] rcu: synchronize_rcu[_expedited]() related fixes
Message-ID: <20220315155226.GC274290@lothringen>
References: <20220314133738.269522-1-frederic@kernel.org>
 <20220314202610.GW4285@paulmck-ThinkPad-P17-Gen-1>
 <20220314223504.GA1150279@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220314223504.GA1150279@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 03:35:04PM -0700, Paul E. McKenney wrote:
> On Mon, Mar 14, 2022 at 01:26:10PM -0700, Paul E. McKenney wrote:
> > On Mon, Mar 14, 2022 at 02:37:35PM +0100, Frederic Weisbecker wrote:
> > > 
> > > A few fixes especially for expedited GP polling causing a stall on TREE07,
> > > as reported by Paul.
> > > 
> > > We may still want to optimize start_poll_synchronize_rcu_expedited() on
> > > UP-no-preempt but I think Paul may be implying this while doing other
> > > fixes.
> > > 
> > > git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> > > 	rcu/dev
> > > 
> > > HEAD: 6e5fd7e614fd5c8f0fffeaa140b7ea697bfeb096
> > > 
> > > Thanks,
> > > 	Frederic
> > 
> > I have pulled these in for review and testing, thank you!!!  I have
> > started a ~90-minute test and will let you know how that goes.
> 
> And TREE05 doesn't like this much.  I get too-short grace periods.
> TREE05 is unusual in being the one with the kernel build with
> CONFIG_PREEMPT_NONE=y but also with CONFIG_PREEMPT_DYNAMIC=n.
> 
> Running tests of the commits individually.

Ouch, please test the following:

---
From f180dd5809d2c3a6343cbd13f244b7b7f110a506 Mon Sep 17 00:00:00 2001
From: Frederic Weisbecker <frederic@kernel.org>
Date: Tue, 15 Mar 2022 16:33:38 +0100
Subject: [PATCH] rcutorture: Call preempt_schedule() through static call/key

rcutorture sometimes want to trigger a random scheduler preemption call
while simulating a read delay. However a direct call to
preempt_schedule() is not desirable because it bypasses the static
call/key filter used by CONFIG_PREEMPT_DYNAMIC. This breaks the
no-preempt assumption in case the dynamic preemption mode is "none".

For example rcu_blocking_is_gp() is fooled and abbreviates grace periods
when the CPU runs in no-preempt UP mode.

Fix this with making torture_preempt_schedule() to call through
preempt dynamic static call/key.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/torture.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/torture.h b/include/linux/torture.h
index 63fa4196e51c..7038104463e4 100644
--- a/include/linux/torture.h
+++ b/include/linux/torture.h
@@ -118,7 +118,7 @@ void _torture_stop_kthread(char *m, struct task_struct **tp);
 	_torture_stop_kthread("Stopping " #n " task", &(tp))
 
 #ifdef CONFIG_PREEMPTION
-#define torture_preempt_schedule() preempt_schedule()
+#define torture_preempt_schedule() __preempt_schedule()
 #else
 #define torture_preempt_schedule()	do { } while (0)
 #endif
-- 
2.25.1

