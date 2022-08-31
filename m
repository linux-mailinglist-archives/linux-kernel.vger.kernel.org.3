Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADAC5A8549
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbiHaSPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbiHaSOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:14:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F542EEC41;
        Wed, 31 Aug 2022 11:12:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2F2461CB7;
        Wed, 31 Aug 2022 18:12:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B53DC4315F;
        Wed, 31 Aug 2022 18:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969532;
        bh=mKMLfJJ5PQglYt2nL/q4Ztr/omrySwsHvF1ZvrLRD10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VHv47LAX5Wr9Q7Yx+XlI3B3yGgOV/EOia7cA5nD5QwTLMDD89QvNcd+XxHPfTxCaJ
         3qcI3XfNPtzey3oOEVt1o9JX6nmu7B7egu6vOXxR47xGMSYXpQPKYbmWMLT3FWCwiN
         +3vPBft8K219znLLUtEobhQ6sLyJB1LMrBO21qFAtT6gxUBJcPqVE9ovllxYZWneWP
         5d+V3+XBbWA9NFROJQIem4GReDZB/aaa+QoVRwRytWQBs2UiHxOaPeRz/Jc3/CkdaK
         EnTxHKv0eHXSy69c1CcPW1XSntUfx09pE+KMRBTcCQrRP0K4C6De/C9eywLRddIqFG
         pFDaUqrRzxSMw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7F27B5C0EC0; Wed, 31 Aug 2022 11:12:11 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 22/25] rcutorture: Use 1-suffixed variable in rcu_torture_write_types() check
Date:   Wed, 31 Aug 2022 11:12:07 -0700
Message-Id: <20220831181210.2695080-22-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831181207.GA2694717@paulmck-ThinkPad-P17-Gen-1>
References: <20220831181207.GA2694717@paulmck-ThinkPad-P17-Gen-1>
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

This commit changes the use of gp_poll_exp to gp_poll_exp1 in the first
check in rcu_torture_write_types().  No functional effect, but consistency
is a good thing.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 029de67a9da91..71d1af9c060e1 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1196,7 +1196,7 @@ static void rcu_torture_write_types(void)
 
 	/* Initialize synctype[] array.  If none set, take default. */
 	if (!gp_cond1 && !gp_cond_exp1 && !gp_cond_full1 && !gp_cond_exp_full1 && !gp_exp1 &&
-	    !gp_poll_exp && !gp_poll_exp_full1 && !gp_normal1 && !gp_poll1 && !gp_poll_full1 &&
+	    !gp_poll_exp1 && !gp_poll_exp_full1 && !gp_normal1 && !gp_poll1 && !gp_poll_full1 &&
 	    !gp_sync1)
 		gp_cond1 = gp_cond_exp1 = gp_cond_full1 = gp_cond_exp_full1 = gp_exp1 =
 			   gp_poll_exp1 = gp_poll_exp_full1 = gp_normal1 = gp_poll1 =
-- 
2.31.1.189.g2e36527f23

