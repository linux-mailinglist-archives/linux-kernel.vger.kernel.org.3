Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417DA59B787
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 04:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbiHVCQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 22:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbiHVCQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 22:16:28 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37EA222B4;
        Sun, 21 Aug 2022 19:16:18 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id l64so8204056pge.0;
        Sun, 21 Aug 2022 19:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=1Aq+TVGo9jWjEOz30MnnCagkM1BEYPOn6zoekJQrcT8=;
        b=Lz0gNtnR0Gx/blm6zrBVhXfF2MRVTbwlEL1W81C3w2unXlO+5HrmDF2WUIx+7vPA/p
         5h26+kDRmt6agXESmcH7W1XPsWzhNtF+Hhc5epkLkEqsC6lV5h80hUb5rumqD8Aat9+8
         az50QeOE3YFOGu168p8qC9UcWS0LT45eCLOdSKt7l0Ubh8sOX3hneZpi80j2XnHP0zkN
         BFD8wiPD/Pf37aSGTzr7XBIzsXaHRMSIMMmDbIpQSwhWQointOliw4mnNomAJGF3An4a
         dpxHHJ9T6yCioZ2u38tL9HbxZRzbu4NXg585fk/7At6WOx3mLm9cWD3MEGNwq2sEgGM/
         KbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=1Aq+TVGo9jWjEOz30MnnCagkM1BEYPOn6zoekJQrcT8=;
        b=gyZ+UsOboqXBFDc8qrQ6sXRBBJsx1qb1vCrrik2qH0k3YvkUr/OFgjSr0DTLxv2wnP
         TSiD8XVyg7QEBeXMAkd5MFARcbUB3XzK69GGm++pBdKLZnF6/X8v9HTvRuMEIrvPNpB+
         vtLuunQL5Zq5sTgWQHAL/COMZeKY9h5eGS9th2jmlbr6CDulG9zv3F6gqMC0fOajAi1G
         nlAKgZmI1yHKEmLSJnKgYeCudbfI+zlxHyLso2SE31TvFmQLOHVsX3MpTn8ic3h+NZ9a
         XchLc4aK/toRv78FV//J8JAnqnBGJcnUsxhWOTUm2MJROIj1Mn5K2IOJqZqJCRQyPFiq
         eK1w==
X-Gm-Message-State: ACgBeo10LfgMRJkTBsW19d96crsV7ulNS8xsdULrD5HbN5MUFP32V8wn
        suIxV2sqUstGjjWpP3rDoCVPNUDITA==
X-Google-Smtp-Source: AA6agR4D50rPJbn2tq2GNSeHmdvNBpKQlkNzme4yJlxq0DguP1NGJn/0sSXGbSX983tnXc0H9IKnEg==
X-Received: by 2002:a63:df13:0:b0:42a:b008:3d56 with SMTP id u19-20020a63df13000000b0042ab0083d56mr2751744pgg.425.1661134577330;
        Sun, 21 Aug 2022 19:16:17 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k3-20020aa79723000000b005321340753fsm7312139pfg.103.2022.08.21.19.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 19:16:16 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Price <steven.price@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [RFC 06/10] rcu/hotplug: Make rcutree_dead_cpu() parallel
Date:   Mon, 22 Aug 2022 10:15:16 +0800
Message-Id: <20220822021520.6996-7-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220822021520.6996-1-kernelfans@gmail.com>
References: <20220822021520.6996-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support parallel, rcu_state.n_online_cpus should be
atomic_dec()

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Steven Price <steven.price@arm.com>
Cc: "Peter Zijlstra
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: linux-kernel@vger.kernel.org
To: rcu@vger.kernel.org
---
 kernel/cpu.c      | 1 +
 kernel/rcu/tree.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 1261c3f3be51..90debbe28e85 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1872,6 +1872,7 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 		.name			= "RCU/tree:prepare",
 		.startup.single		= rcutree_prepare_cpu,
 		.teardown.single	= rcutree_dead_cpu,
+		.support_kexec_parallel	= true,
 	},
 	/*
 	 * On the tear-down path, timers_dead_cpu() must be invoked
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 79aea7df4345..07d31e16c65e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2168,7 +2168,8 @@ int rcutree_dead_cpu(unsigned int cpu)
 	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
 		return 0;
 
-	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
+	/* Hot remove path allows parallel, while Hot add races against remove on lock */
+	atomic_dec((atomic_t *)&rcu_state.n_online_cpus);
 	/* Adjust any no-longer-needed kthreads. */
 	rcu_boost_kthread_setaffinity(rnp, -1);
 	// Stop-machine done, so allow nohz_full to disable tick.
-- 
2.31.1

