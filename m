Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6C8502F30
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 21:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349138AbiDOTWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 15:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240222AbiDOTWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 15:22:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E193E5F2;
        Fri, 15 Apr 2022 12:19:52 -0700 (PDT)
Message-ID: <20220415161206.419880163@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650050390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=7jYVnFbvS1wwhh/xx/6Po12K0RSM7iGrhAKv7OZOS5Y=;
        b=ibn5CEoItB13fo1TcH5WhfU42+e2Hv5azziNbxi3BJLqgRMgXTUfaxkrIDyi7VxobycJ95
        yhY+NjHwSBhn0nbKSN7UqLsM2UPHKcN12SZEGbPGrPBaZkflkaBx1jEHxOuTcE9EcZg6k5
        9yEFPSr+4hZns3aIghYzqDXDK3j2jCDfnHWxVa8Hn9BnArKxdX4agbF/RtDtkrSkxskjU0
        U7O6KqclwS/PJg6lEIDEB5iyKgzAb+gEEVXgoiSMBNnBApYvKW8wZ1vMNRFTcyp83Wxvt0
        DqX6lrrCnMT1DPW6+SpHjfGBJonoWci049BZHKLYL6XS082qhKrLuUNphH2wUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650050390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=7jYVnFbvS1wwhh/xx/6Po12K0RSM7iGrhAKv7OZOS5Y=;
        b=J+OlnM5CPKWmBhZNPQx401r0dC9MlMfnI44nxQy0clF2y+zEZeX+iWc0sDj82hsDNw4g1u
        Gl8cYQfpED9qenBQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-pm@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [patch 01/10] x86/aperfmperf: Dont wake idle CPUs in arch_freq_get_on_cpu()
References: <20220415133356.179706384@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 15 Apr 2022 21:19:50 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aperfmperf_get_khz() already excludes idle CPUs from APERF/MPERF sampling
and that's a reasonable decision. There is no point in sending up to two
IPIs to an idle CPU just because someone reads a sysfs file.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/aperfmperf.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -139,6 +139,9 @@ unsigned int arch_freq_get_on_cpu(int cp
 	if (!housekeeping_cpu(cpu, HK_TYPE_MISC))
 		return 0;
 
+	if (rcu_is_idle_cpu(cpu))
+		return 0;
+
 	if (aperfmperf_snapshot_cpu(cpu, ktime_get(), true))
 		return per_cpu(samples.khz, cpu);
 

