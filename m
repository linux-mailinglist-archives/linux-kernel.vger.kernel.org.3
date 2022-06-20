Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5D755275E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 01:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346443AbiFTXAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 19:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346004AbiFTW7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:59:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5382319C05;
        Mon, 20 Jun 2022 15:58:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B956DB81647;
        Mon, 20 Jun 2022 22:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C05C341D2;
        Mon, 20 Jun 2022 22:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765900;
        bh=6+3iMWSppedO1jRXS9dt0Th+Hfq5H3+RDDhYWxtDlrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LNJkwZ2lpWAx9wvbrHujDxkaywKCOunJa97NeNuzpq+nAu6v6fCh5AvkqOQeXlj9q
         T+RArij0jQ6468unKZRDV0ayHljYSGbD+1BLSay6ok6ldeenfxgRwmWu+pPq/u8eQ7
         DUibju7MeGHwj2P5UujgD6eNfR/KXXPiIFBtsK9r+FqHZMWPAItZH4HWK7oms7vU2F
         ypbxnq/NKA+Ef8TqbMKEoeT+ddm61JN/FopzYiwBxhV95iU1tRb1d0v3fIEMaSyfCj
         7tTVbrgod4HJmeTaCIV9l+j2I1Jw3Q+EIfCrE949hBN7Ny3ppwWSM77Gm7eRomWDW4
         LkEbNjX3/eeNg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9F8BA5C0B06; Mon, 20 Jun 2022 15:58:19 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 06/12] rcutorture: Make failure indication note reader-batch overflow
Date:   Mon, 20 Jun 2022 15:58:11 -0700
Message-Id: <20220620225817.3843106-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620225814.GA3842995@paulmck-ThinkPad-P17-Gen-1>
References: <20220620225814.GA3842995@paulmck-ThinkPad-P17-Gen-1>
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

The loop scanning the pipesummary[] array currently skips the last
element, which means that the diagnostics ignore those rarest of
situations, namely where some readers persist across more than ten
grace periods, but all other readers avoid spanning a full grace period.
This commit therefore adjusts the scan to include the last element of
this array.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 613711b8242b9..64ad5305829b6 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1869,7 +1869,7 @@ rcu_torture_stats_print(void)
 			batchsummary[i] += READ_ONCE(per_cpu(rcu_torture_batch, cpu)[i]);
 		}
 	}
-	for (i = RCU_TORTURE_PIPE_LEN - 1; i >= 0; i--) {
+	for (i = RCU_TORTURE_PIPE_LEN; i >= 0; i--) {
 		if (pipesummary[i] != 0)
 			break;
 	}
-- 
2.31.1.189.g2e36527f23

