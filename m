Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C0F5A8503
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbiHaSI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbiHaSIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:08:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF73BE3424;
        Wed, 31 Aug 2022 11:08:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B3DB61BF8;
        Wed, 31 Aug 2022 18:08:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963EDC43149;
        Wed, 31 Aug 2022 18:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969287;
        bh=wIElk+8Yjt/y58bEutr6XNPojpOeAx/3LFQtXQ/TtcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YaXY99Imw3oIa57i7HAurBomcTi31N1v/B+LkocyLOlrmS5hp9JVCoCM1hYVXHqSu
         pCoP7/ReVlSQGZum6AAfYDgXulJe1h8XkahlfHBj4YeRiXm1cDAoPOIBSrv/4bvO4T
         keD4INjNRnVP8Wn+VWi6Zcp0E/85LyGh4JEASvAK7RzR4GTfFkFTlqOBjB0WgnH9VD
         RrzGcGC0zYyFwtHwB2XhhMnd8SehizwVuB0LUFtgo+/FMpC54Gq/tgZDVC/Evx8oTb
         IYjZtxZsKPNLW8hpdES63CLxXNz8lww5fvAh/oo7UEhKQ1l6TikJD2SwFt9iQNo86f
         +bTaIBjHLJjkg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0814B5C0A6B; Wed, 31 Aug 2022 11:08:07 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 10/10] rcu: Exclude outgoing CPU when it is the last to leave
Date:   Wed, 31 Aug 2022 11:08:05 -0700
Message-Id: <20220831180805.2693546-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831180759.GA2693289@paulmck-ThinkPad-P17-Gen-1>
References: <20220831180759.GA2693289@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rcu_boost_kthread_setaffinity() function removes the outgoing CPU
from the set_cpus_allowed() mask for the corresponding leaf rcu_node
structure's rcub priority-boosting kthread.  Except that if the outgoing
CPU will leave that structure without any online CPUs, the mask is set
to the housekeeping CPU mask from housekeeping_cpumask().  Which is fine
unless the outgoing CPU happens to be a housekeeping CPU.

This commit therefore removes the outgoing CPU from the housekeeping mask.
This would of course be problematic if the outgoing CPU was the last
online housekeeping CPU, but in that case you are in a world of hurt
anyway.  If someone comes up with a valid use case for a system needing
all the housekeeping CPUs to be offline, further adjustments can be made.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 207617f69aa56..32b424b571bd9 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1243,8 +1243,11 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
 		    cpu != outgoingcpu)
 			cpumask_set_cpu(cpu, cm);
 	cpumask_and(cm, cm, housekeeping_cpumask(HK_TYPE_RCU));
-	if (cpumask_empty(cm))
+	if (cpumask_empty(cm)) {
 		cpumask_copy(cm, housekeeping_cpumask(HK_TYPE_RCU));
+		if (outgoingcpu >= 0)
+			cpumask_clear_cpu(outgoingcpu, cm);
+	}
 	set_cpus_allowed_ptr(t, cm);
 	mutex_unlock(&rnp->boost_kthread_mutex);
 	free_cpumask_var(cm);
-- 
2.31.1.189.g2e36527f23

