Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A599A506073
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236739AbiDSADk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236195AbiDSAC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:02:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8492B11145;
        Mon, 18 Apr 2022 17:00:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27747B81141;
        Tue, 19 Apr 2022 00:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F09C385B7;
        Tue, 19 Apr 2022 00:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650326416;
        bh=4EFYBPM+fGUTWUUGcdM/Li8/8Rj9SLDD6se7yA60e4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J99x+TkUhjHDOZsEQ0dz7mFkh00X4WYXNS3ZJ6SD5xAMIOFF8DlJbaDR8N7xzy+7P
         RRhB6UUmJzwcWAO/0BqkWQw9CO6m5fCmW4EOFcMy0TC9AK9K+ZcxigVsQqicd4aLdn
         dY+shGly3v0HR7R4flST8Cpps60IA6ys1V2CLBG516vM8KtTVgOgJTJ2DT4eqxgjvV
         C4FZPbVgp027G20MH8VF0RiHkREB5IcZMIHGtseZ9ddKN/3ALnWmOvO133u0RP4U56
         whDggywIOBgHlv1d+bA3EDTbd3Pn6pjcKXIZCP033DXcqx2MMcuIg37YHstBiiH0u3
         AnV6hcqxRUajA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E6AB25C12AB; Mon, 18 Apr 2022 17:00:15 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH rcu 9/9] rcu-tasks: Handle sparse cpu_possible_mask in rcu_tasks_invoke_cbs()
Date:   Mon, 18 Apr 2022 17:00:14 -0700
Message-Id: <20220419000014.3948512-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419000007.GA3945818@paulmck-ThinkPad-P17-Gen-1>
References: <20220419000007.GA3945818@paulmck-ThinkPad-P17-Gen-1>
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

If the cpu_possible_mask is sparse (for example, if bits are set only for
CPUs 0, 4, 8, ...), then rcu_tasks_invoke_cbs() will access per-CPU data
for a CPU not in cpu_possible_mask.  It makes these accesses while doing
a workqueue-based binary search for non-empty callback lists.  Although
this search must pass through CPUs not represented in cpu_possible_mask,
it has no need to check the callback list for such CPUs.

This commit therefore changes the rcu_tasks_invoke_cbs() function's
binary search so as to only check callback lists for CPUs present in
cpu_possible_mask.

Reported-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index fd70d86eb7cd..3925e32159b5 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -468,7 +468,7 @@ static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tasks_percpu
 		}
 	}
 
-	if (rcu_segcblist_empty(&rtpcp->cblist))
+	if (rcu_segcblist_empty(&rtpcp->cblist) || !cpu_possible(cpu))
 		return;
 	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
 	rcu_segcblist_advance(&rtpcp->cblist, rcu_seq_current(&rtp->tasks_gp_seq));
-- 
2.31.1.189.g2e36527f23

