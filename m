Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8FDF552741
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345269AbiFTWzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344902AbiFTWy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:54:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BD61EEF5;
        Mon, 20 Jun 2022 15:54:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E07D8B81654;
        Mon, 20 Jun 2022 22:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10ACC341D6;
        Mon, 20 Jun 2022 22:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765653;
        bh=hHE9JvKu9VS55Nz7bTG5L9GCXJZb+T3C+cXaNv6ZVjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DzikvvpWJLqRVW5IyOn8VYAUrKs47ozKDqGI97/0VyXMCt9A44/sMpaRjh9Ux9HLO
         qoXUWJefyEymQtfsXWP+VIFQrf2wRI5M9xCEoP1iaGr4obleAZkWTTYvLLXMJnBKPi
         rp2gfJCs/JsKmeh0Z2iCHL9om09HZ6IEKaL50vaJItgwtI45yJ0aUE+rNvJAe/DnP5
         XBo0jblkVb/O6F8saKdyoC8W5mgrvqixHXJ9JyPUt8jsN0vlU0iR/9RA7k5lrrh+LX
         +mfacdRftV7kAYevRgBeggdFBsvflKQOEeKzsP9MHzrlL7OnSs5b/6O6V1aLDBRRzD
         sbwCIt9TtaPYA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 449315C0E69; Mon, 20 Jun 2022 15:54:13 -0700 (PDT)
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
Subject: [PATCH rcu 15/32] rcu-tasks: Make RCU Tasks Trace stall warnings print full .b.need_qs field
Date:   Mon, 20 Jun 2022 15:53:54 -0700
Message-Id: <20220620225411.3842519-15-paulmck@kernel.org>
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

Currently, the RCU Tasks Trace CPU stall warning simply indicates
whether or not the .b.need_qs field is zero.  This commit shows the
three permitted values and flags other values with either "!" or "?".
This is a debugging aid.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: KP Singh <kpsingh@kernel.org>
---
 kernel/rcu/tasks.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 93096188d3631..5eefbab7f2edb 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1502,13 +1502,14 @@ static void show_stalled_task_trace(struct task_struct *t, bool *firstreport)
 			 ".I"[t->trc_ipi_to_cpu >= 0],
 			 ".i"[is_idle_tsk]);
 	else
-		pr_alert("P%d: %c%c%c nesting: %d%c cpu: %d%s\n",
+		pr_alert("P%d: %c%c%c nesting: %d%c%c cpu: %d%s\n",
 			 t->pid,
 			 ".I"[trc_rdr.ipi_to_cpu >= 0],
 			 ".i"[is_idle_tsk],
 			 ".N"[cpu >= 0 && tick_nohz_full_cpu(cpu)],
 			 trc_rdr.nesting,
-			 " N"[!!trc_rdr.needqs],
+			 " !CN"[trc_rdr.needqs & 0x3],
+			 " ?"[trc_rdr.needqs > 0x3],
 			 cpu, cpu_online(cpu) ? "" : "(offline)");
 	sched_show_task(t);
 }
-- 
2.31.1.189.g2e36527f23

