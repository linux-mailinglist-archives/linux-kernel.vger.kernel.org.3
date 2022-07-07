Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899D75698DE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 05:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234995AbiGGDmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 23:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiGGDmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 23:42:02 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C1C2B625
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 20:42:01 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id n12so16872741pfq.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 20:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XANUYl1Borcsk9t8vW9KSV5bpVG0+amH7/nGFUEPepk=;
        b=2GetizZARbsyb0LeA/H0CFHJ5ZDSX05z7Fj0Rdv0FAoXA0zqK/ef/rLVRAprYh+w7M
         onjjGilLM6c2NLNaHB8kat/u5YYc9QNxShdExZMmggnbdox681JojrmXkQ4cuZzVRDtc
         k47Xc2f3GfHYx3OqjhT9H0wYEcOrxVdHspUVwNG4lZa9CF8FlOr4RK0yjSVS8gx+IgZt
         XSITF9+Q/tiHaUa1vY0TeKj0tX4FyUnjkwqGqztQHTlVV9XDqPlV0ERr4kPWa79K24PU
         cBhW72Qeuq6DN/UfMHiv0wUgjLWpHlxmdM4LSs03mAmu1x4YFPLBfEo+hHYS0kiLWBhD
         XUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XANUYl1Borcsk9t8vW9KSV5bpVG0+amH7/nGFUEPepk=;
        b=h6wcD02v+Z+1rUYvdJFwfKH91vH6ztyd3tO550rFc+MgDkPi8XqZN2DdCuFZc0y4mc
         VHPB+8Y79MJt0ife92i0FmttdGwnbS0lWRswF71c2EtMpppPzyD93lkRw4+5K8iWp3/A
         z2smo4u7T7YokDk4h2n2Sd1qq8gixHZLZ+FiURagPpjd7V0CgmzsFrlWUlwcuiy+Ng4g
         mx8r0dLoFI4v3Eo6FiTU8ypPx0df9s6+DaLQV61bc4PMRcGgZyB6K1ztJS8ed3lmBxf2
         b+LJOVoB8JIX8rTzPk1J0qHohn4FNeJA6rf0Z0x2yfOetEWEF98rEKRAAYJjnLLavTfA
         7nBA==
X-Gm-Message-State: AJIora/XYOkUgdjvvEZGXN7DZgcgrMR5G1D9biztJUpHhCNVODGAfI8l
        hOf+t1d3R8EFwDHZ8yNYBLlaQg==
X-Google-Smtp-Source: AGRyM1sR3M9hLSIGaOgLa30wuyO7cUvljtD/zzLIjrU9aWT23lVeaSlGiB5k5S2NVFCCAJVUR0J8kg==
X-Received: by 2002:a17:902:e541:b0:16b:8f8a:3363 with SMTP id n1-20020a170902e54100b0016b8f8a3363mr49923352plf.66.1657165320712;
        Wed, 06 Jul 2022 20:42:00 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id x3-20020a170902a38300b0016be4d78792sm7357707pla.257.2022.07.06.20.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 20:42:00 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH] sched/fair: Remove unused parameter idle of _nohz_idle_balance()
Date:   Thu,  7 Jul 2022 11:41:43 +0800
Message-Id: <20220707034143.37991-1-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 7a82e5f52a35 ("sched/fair: Merge for each idle cpu
loop of ILB") was merged. The parameter idle of _nohz_idle_balance()
is not used anymore so we can remove it.

Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
---
 kernel/sched/fair.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 77b2048a9326..8d4be2a95e37 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10682,8 +10682,7 @@ static bool update_nohz_stats(struct rq *rq)
  * can be a simple update of blocked load or a complete load balance with
  * tasks movement depending of flags.
  */
-static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
-			       enum cpu_idle_type idle)
+static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags)
 {
 	/* Earliest time when we have to do rebalance again */
 	unsigned long now = jiffies;
@@ -10798,7 +10797,7 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
 	if (idle != CPU_IDLE)
 		return false;
 
-	_nohz_idle_balance(this_rq, flags, idle);
+	_nohz_idle_balance(this_rq, flags);
 
 	return true;
 }
@@ -10818,7 +10817,7 @@ void nohz_run_idle_balance(int cpu)
 	 * (ie NOHZ_STATS_KICK set) and will do the same.
 	 */
 	if ((flags == NOHZ_NEWILB_KICK) && !need_resched())
-		_nohz_idle_balance(cpu_rq(cpu), NOHZ_STATS_KICK, CPU_IDLE);
+		_nohz_idle_balance(cpu_rq(cpu), NOHZ_STATS_KICK);
 }
 
 static void nohz_newidle_balance(struct rq *this_rq)
-- 
2.32.0

