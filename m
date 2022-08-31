Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A9D5A8529
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbiHaSNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbiHaSMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:12:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92071E3961;
        Wed, 31 Aug 2022 11:11:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEEDC61BF0;
        Wed, 31 Aug 2022 18:10:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC2FC433D6;
        Wed, 31 Aug 2022 18:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969446;
        bh=RzA/0h68ZhBe7KOWBZY3n3Aj4fMOY0YIfHq1RWU0ov4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AhLOP54ZWRohzBkh5yFGWcRdlrY5IQ7hBScdDCNCfQFaKOWaV/OVPWBdHYwQ6H1Fx
         fuyyZcMC+Nfpkn377Bu3xN/SzZMyvq4VhqLR6y0c6x0dj5RM3R7moXPfFlfYYInYsT
         s+uFqkEu2cTP9aPp2wmJ5sLwD7jIpMiBuWRprTXEQaJ0E0jSyk1HpA3OYmr/i2uqDv
         ndgZNpZiZyUNLWyY5OslicLNgrGj8tAu3xJxgN/HHeNrCWSRwo9kXBHzTwMzfp1L58
         NpIKnMIYrDTGcfhjY+Pz38Qlnnkzj5dNcb9A8XkWZMB1nRKpLNisB+q1ya8yEl0ECT
         cTvRMz0NX5LsA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0AA015C019C; Wed, 31 Aug 2022 11:10:46 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH rcu 2/3] rcu/nocb: Add CPU number to CPU-{,de}offload failure messages
Date:   Wed, 31 Aug 2022 11:10:43 -0700
Message-Id: <20220831181044.2694488-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831181040.GA2694278@paulmck-ThinkPad-P17-Gen-1>
References: <20220831181040.GA2694278@paulmck-ThinkPad-P17-Gen-1>
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

Offline CPUs cannot be offloaded or deoffloaded.  Any attempt to offload
or deoffload an offline CPU causes a message to be printed on the console,
which is good, but this message does not contain the CPU number, which
is bad.  Such a CPU number can be helpful when debugging, as it gives a
clear indication that the CPU in question is in fact offline.  This commit
therefore adds the CPU number to the CPU-{,de}offload failure messages.

Cc: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_nocb.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index f20aec4f4394b..0a5f0ef414845 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1111,7 +1111,7 @@ int rcu_nocb_cpu_deoffload(int cpu)
 			if (!ret)
 				cpumask_clear_cpu(cpu, rcu_nocb_mask);
 		} else {
-			pr_info("NOCB: Can't CB-deoffload an offline CPU\n");
+			pr_info("NOCB: Cannot CB-deoffload offline CPU %d\n", rdp->cpu);
 			ret = -EINVAL;
 		}
 	}
@@ -1196,7 +1196,7 @@ int rcu_nocb_cpu_offload(int cpu)
 			if (!ret)
 				cpumask_set_cpu(cpu, rcu_nocb_mask);
 		} else {
-			pr_info("NOCB: Can't CB-offload an offline CPU\n");
+			pr_info("NOCB: Cannot CB-offload offline CPU %d\n", rdp->cpu);
 			ret = -EINVAL;
 		}
 	}
-- 
2.31.1.189.g2e36527f23

