Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6637F55274B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345487AbiFTWzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245052AbiFTWyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:54:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D997A1E3CA;
        Mon, 20 Jun 2022 15:54:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB7FF61455;
        Mon, 20 Jun 2022 22:54:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFB3C341EE;
        Mon, 20 Jun 2022 22:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765654;
        bh=HFaTI2uv18t0CoFl3K1WrNG4ncXPaejGY0+7rFtEW7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vPcLembESrX4MJ/X9MQjrjtz/Vn5LiMn4IEqVqI3HzF9OlC9/MRlg9NzVnDtGalmu
         +lh36EMlD/sPDgALEFDP6/lROyDikHyOtjbR9dHtHTblSOA1rRnmEkXfbEf+u1MRMF
         4o9W6ZdQmEFayn+z4jBbPjLqeMAULVIczK0vvaAMRWl6OLcf3Z7qZsQqiuzJDBON/7
         Ty/Rf2V1H2q6772fVFd1hCRY+QlUy9vMayemQajSoHhBrT8yTuz4H7rLp4+/XSHNmI
         nBf76c4YE2IvG500/xI1vZ+GEPTFzgE22RsXAWsxX80tnreLJKI6oN1SdJfitu8KJE
         7bTU5j8uJniTg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 46B0B5C0FCA; Mon, 20 Jun 2022 15:54:13 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Eric Dumazet <edumazet@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>
Subject: [PATCH rcu 16/32] rcu-tasks: Make RCU Tasks Trace stall warning handle idle offline tasks
Date:   Mon, 20 Jun 2022 15:53:55 -0700
Message-Id: <20220620225411.3842519-16-paulmck@kernel.org>
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

When a CPU is offline, its idle task can appear to be running, but it
cannot be doing anything while CPU-hotplug operations are excluded.
This commit takes advantage of that fact by making trc_check_slow_task()
check for task_curr(t) && cpu_online(task_cpu(t)), and recording
full information in that case.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: KP Singh <kpsingh@kernel.org>
---
 kernel/rcu/tasks.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 5eefbab7f2edb..64eb4d7b142e3 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1476,7 +1476,7 @@ static int trc_check_slow_task(struct task_struct *t, void *arg)
 {
 	struct trc_stall_chk_rdr *trc_rdrp = arg;
 
-	if (task_curr(t))
+	if (task_curr(t) && cpu_online(task_cpu(t)))
 		return false; // It is running, so decline to inspect it.
 	trc_rdrp->nesting = READ_ONCE(t->trc_reader_nesting);
 	trc_rdrp->ipi_to_cpu = READ_ONCE(t->trc_ipi_to_cpu);
-- 
2.31.1.189.g2e36527f23

