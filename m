Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72784D0C0D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 00:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244825AbiCGXbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 18:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiCGXbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 18:31:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01195D88
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 15:30:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8ED646122C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 23:30:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5E3C340E9;
        Mon,  7 Mar 2022 23:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646695843;
        bh=gnS+HQaRTi/xK2o9LzRxEwSPrAIH9GGA3mfRWpe+/Bo=;
        h=From:To:Cc:Subject:Date:From;
        b=KbCrH+erpc1AbUGB3+uRXWC2oCD7uOcjQIbjhWKRJ+tUffDVBFJVqJ+Y0bFYZnkSd
         edbTvdv55oywhlLjCQCSzjX9A4aHwkV1n58vX4H9XwFv7hCwb79LeagQqteqjAN4y2
         Nv45sjUrxHiOXMLUoEkB0iA4ysvlVrBuHCk6qMuLKUCwEjLIL+KvGC0rBxc2Dj/ywd
         5Zin7N9tanP2A6njZn47jhjW+HruyEFip3HkvcG/OWmWYqEr7msnIQkxx/cVBkOT7z
         o8N1h7L49K3K0iSKHQztpEzMKvaSPsGw1n45boyJ9aev2T9GcerLh5L4ATEhW12AgD
         0O0Ld0lmbB+BQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [GIT PULL] timers/tick updates
Date:   Tue,  8 Mar 2022 00:30:30 +0100
Message-Id: <20220307233034.34550-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas,

Please pull the timers/core branch that can be found at:

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	timers/core
	
HEAD: f96272a90d9eaea9933aaab704ddbd258feb3841

* One fix for rare jiffies update stall that were reported by Paul

* Tick side cleanups after RCU_FAST_NO_HZ removal

* Educate some more the warnings on softirqs pending on idle


Thanks,
	Frederic
---

Frederic Weisbecker (4):
      tick: Detect and fix jiffies update stall
      tick/rcu: Remove obsolete rcu_needs_cpu() parameters
      tick/rcu: Stop allowing RCU_SOFTIRQ in idle
      lib/irq_poll: Declare IRQ_POLL softirq vector as ksoftirqd-parking safe


 include/linux/interrupt.h | 11 ++++++-
 include/linux/rcutiny.h   |  3 +-
 include/linux/rcutree.h   |  2 +-
 kernel/rcu/tree.c         |  3 +-
 kernel/time/tick-sched.c  | 77 +++++++++++++++++++++++++++++++++++++----------
 kernel/time/tick-sched.h  |  4 +++
 6 files changed, 78 insertions(+), 22 deletions(-)
