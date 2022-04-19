Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379705060AC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238234AbiDSAKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237940AbiDSAKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:10:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A654663D6;
        Mon, 18 Apr 2022 17:07:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58FE8B8113A;
        Tue, 19 Apr 2022 00:07:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF473C385B7;
        Tue, 19 Apr 2022 00:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650326869;
        bh=He2ZUlSMEvn9zM0ylx3h/dbdQFC19ze5vEZT/mXl27Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k2uS3++JmOpIsaj7TfjHXB6rdC7h/XHLbGy02RGZRGoVq0PoIr4L+wJep0WcVl0Rg
         /YMkRUSTVWgW3b8b2O9tZvpcaZwDMRtfAoXAtFd48B3Y47HmGV1R4T43gmascbD1Yw
         kNOHK096PPfWOVb4Mt7qmUEJBMVOp74O6s5bCX12D/7vyyYa3jonshy9d8e4MKgsvL
         eCyYGf/9UpT0b3mWTMhdVndOrtBjn69nJTiLhrUWGTiMG+mzrXxOsXEbfBVILvRBG2
         RjpiyrsqXQag3e2UhfwK/gI3x4DzCuY6WS5xn8zMMX3TMgMkQ1DAVrpCOiahsgPV6J
         9ojJ+q+/n/ODw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2A6A05C0B86; Mon, 18 Apr 2022 17:07:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 6/6] rcutorture: Call preempt_schedule() through static call/key
Date:   Mon, 18 Apr 2022 17:07:46 -0700
Message-Id: <20220419000746.3949667-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419000541.GA3949109@paulmck-ThinkPad-P17-Gen-1>
References: <20220419000541.GA3949109@paulmck-ThinkPad-P17-Gen-1>
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

From: Frederic Weisbecker <frederic@kernel.org>

The rcutorture test suite sometimess triggers a random scheduler
preemption call while simulating a read delay.  Unfortunately, its
direct call to preempt_schedule() bypasses the static call/key filter
used by CONFIG_PREEMPT_DYNAMIC.  This breaks the no-preempt assumption
when the dynamic preemption mode is "none".

For example, rcu_blocking_is_gp() is fooled and abbreviates grace periods
when the CPU runs in no-preempt UP mode.

Fix this by making torture_preempt_schedule() call __preempt_schedule(),
which uses the static call/key.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/torture.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/torture.h b/include/linux/torture.h
index 63fa4196e51c..7038104463e4 100644
--- a/include/linux/torture.h
+++ b/include/linux/torture.h
@@ -118,7 +118,7 @@ void _torture_stop_kthread(char *m, struct task_struct **tp);
 	_torture_stop_kthread("Stopping " #n " task", &(tp))
 
 #ifdef CONFIG_PREEMPTION
-#define torture_preempt_schedule() preempt_schedule()
+#define torture_preempt_schedule() __preempt_schedule()
 #else
 #define torture_preempt_schedule()	do { } while (0)
 #endif
-- 
2.31.1.189.g2e36527f23

