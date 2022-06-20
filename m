Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF6655273C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344746AbiFTWyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344329AbiFTWyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:54:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364431D329;
        Mon, 20 Jun 2022 15:54:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE9DE61452;
        Mon, 20 Jun 2022 22:54:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C509DC341D1;
        Mon, 20 Jun 2022 22:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765653;
        bh=4P0omvn7xZZml8ofD3+CGOIHHbsezEb7QZrLKu90OT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=orWnx4aeWOaEGSqtukrjM5xu3fUew/7lee51dA8xOS3m0UmQzyjCxsy+6TTEoYDVM
         6mXvmNEzAFgbsYsA5WN+tCTKh5SfSEhfdQUr1KDf04CUXuA5zEW06sQHT7lrNPPSRs
         xmeYB0zKkeVLTnihfHF4PNZkme+75uGPAMZaCTCYJ+iSVr5zdwPq7cJK5jK1sEMnh9
         nGmD1yVTV4uoyHItOmHDJB3KIydaRGwsmHrVHqVv6GFde0BG1rHrPXNmsVV1awDkVp
         lVniapfxxYtmEPotTpR+92sJLQ0WW47+SpdxeIXfpPGSdJm1k5iMO2Jk2qOsOMsF2v
         11aQNfZSFUMrg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 40F0F5C0E42; Mon, 20 Jun 2022 15:54:13 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Eric Dumazet <edumazet@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>
Subject: [PATCH rcu 13/32] rcu-tasks: Add slow-IPI indicator to RCU Tasks Trace stall warnings
Date:   Mon, 20 Jun 2022 15:53:52 -0700
Message-Id: <20220620225411.3842519-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620225402.GA3842369@paulmck-ThinkPad-P17-Gen-1>
References: <20220620225402.GA3842369@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a "I" indicator to the RCU Tasks Trace CPU stall
warning when an IPI directed to a task has thus far failed to arrive.
This serves as a debugging aid.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: KP Singh <kpsingh@kernel.org>
---
 kernel/rcu/tasks.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 6b44c69eeca88..1cfbebf2b5977 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1497,8 +1497,9 @@ static void show_stalled_task_trace(struct task_struct *t, bool *firstreport)
 	}
 	cpu = task_cpu(t);
 	if (!task_call_func(t, trc_check_slow_task, &trc_rdr))
-		pr_alert("P%d: %c\n",
+		pr_alert("P%d: %c%c\n",
 			 t->pid,
+			 ".I"[t->trc_ipi_to_cpu >= 0],
 			 ".i"[is_idle_tsk]);
 	else
 		pr_alert("P%d: %c%c%c nesting: %d%c cpu: %d\n",
-- 
2.31.1.189.g2e36527f23

