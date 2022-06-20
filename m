Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1412B552739
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344972AbiFTWyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344250AbiFTWyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:54:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F0C1758D;
        Mon, 20 Jun 2022 15:54:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AD086145B;
        Mon, 20 Jun 2022 22:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F69BC3411B;
        Mon, 20 Jun 2022 22:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765654;
        bh=iKfNUfpjpEOpHuhFW9AXk+ufdaEjcx76eM4XIzz407c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mGvrRQuxOa3S6YpCPEIbowVDWDEVY3VgKP/yjtbfXY6XSlwXxPkZC1vnPO2vZekE0
         RnDYu59vuMTjUTMq3KvUyuIfnaKmOsCi5DPIrFLXBuGbuOE2In+SrWHVtDTO/EZtcV
         TTHs3TC3ay7e3GjffeMOVKBX3ukyALolNPDCKNRROpuL+9SqSphPpEVGg7XiiNIZdr
         raZxLjYTxRsD+JrvfzIinVZql0MIAWvhcH3ZixcWsU+ARWp4sBExQPkr9DwD39JlYK
         X+J2PtQKpdnZT8a1AsbbLKFW/XfZdDeO4gorWxpyfgf5FcED12Cf4J3vAKlZerMJ6M
         Wf/YwFJb263yw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4E7EC5C11DC; Mon, 20 Jun 2022 15:54:13 -0700 (PDT)
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
Subject: [PATCH rcu 20/32] rcu-tasks: Add blocked-task indicator to RCU Tasks Trace stall warnings
Date:   Mon, 20 Jun 2022 15:53:59 -0700
Message-Id: <20220620225411.3842519-20-paulmck@kernel.org>
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

This commit adds a "B" indicator to the RCU Tasks Trace CPU stall warning
when the task has blocked within its current read-side critical section.
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
index eb87a759ef0b0..6f4b89f9517ef 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1536,11 +1536,12 @@ static void show_stalled_task_trace(struct task_struct *t, bool *firstreport)
 			 ".I"[t->trc_ipi_to_cpu >= 0],
 			 ".i"[is_idle_tsk]);
 	else
-		pr_alert("P%d: %c%c%c nesting: %d%c%c cpu: %d%s\n",
+		pr_alert("P%d: %c%c%c%c nesting: %d%c%c cpu: %d%s\n",
 			 t->pid,
 			 ".I"[trc_rdr.ipi_to_cpu >= 0],
 			 ".i"[is_idle_tsk],
 			 ".N"[cpu >= 0 && tick_nohz_full_cpu(cpu)],
+			 ".B"[!!data_race(t->trc_reader_special.b.blocked)],
 			 trc_rdr.nesting,
 			 " !CN"[trc_rdr.needqs & 0x3],
 			 " ?"[trc_rdr.needqs > 0x3],
-- 
2.31.1.189.g2e36527f23

