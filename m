Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4BA5A853D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbiHaSOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbiHaSNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:13:49 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085DDF14CB;
        Wed, 31 Aug 2022 11:12:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C591BCE205F;
        Wed, 31 Aug 2022 18:12:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A6EC4315A;
        Wed, 31 Aug 2022 18:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969532;
        bh=3hit05VM9H5Pv/TaHqZN5KHI+BLHnN72k5omzSbGN8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dU1hK/lZj2+BkLaTtGTPGvKQvOFvM6D7CCvjwuYo6kUuQGsu7bXEIAq2Ev4iAuXNQ
         g76f0dZ2iIE2dnix6KRuDJDgY3ovicziybEC8MrSfXuklwONX9+Zp3fEgMBghYmSed
         XfzSRzAnNQz7QUKSsuWzynH+bafZMaMRLF8nWmkb8169KxRIgvIhqsJTaaiFnFmF13
         bznhd+KCPlyccNgxCWIKPo7Cow/nLuzg/24Y5DfVy9i/0x0p7X2iVjs0pmsXJJSYBq
         N6xPChZ9C2DZrmSOLqRZP7yrgrh5TYM78rEML4aN+aEeTSQpM826022lOM6YmzORHz
         9oBZ73+2+zeCQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 80E075C0ED4; Wed, 31 Aug 2022 11:12:11 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 23/25] rcutorture: Expand rcu_torture_write_types() first "if" statement
Date:   Wed, 31 Aug 2022 11:12:08 -0700
Message-Id: <20220831181210.2695080-23-paulmck@kernel.org>
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

This commit expands the rcu_torture_write_types() function's first "if"
condition and body, placing one element per line, in order to make the
compiler's error messages more helpful.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 71d1af9c060e1..fe1836aad6466 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1195,12 +1195,29 @@ static void rcu_torture_write_types(void)
 	bool gp_poll_full1 = gp_poll_full, gp_sync1 = gp_sync;
 
 	/* Initialize synctype[] array.  If none set, take default. */
-	if (!gp_cond1 && !gp_cond_exp1 && !gp_cond_full1 && !gp_cond_exp_full1 && !gp_exp1 &&
-	    !gp_poll_exp1 && !gp_poll_exp_full1 && !gp_normal1 && !gp_poll1 && !gp_poll_full1 &&
-	    !gp_sync1)
-		gp_cond1 = gp_cond_exp1 = gp_cond_full1 = gp_cond_exp_full1 = gp_exp1 =
-			   gp_poll_exp1 = gp_poll_exp_full1 = gp_normal1 = gp_poll1 =
-			   gp_poll_full1 = gp_sync1 = true;
+	if (!gp_cond1 &&
+	    !gp_cond_exp1 &&
+	    !gp_cond_full1 &&
+	    !gp_cond_exp_full1 &&
+	    !gp_exp1 &&
+	    !gp_poll_exp1 &&
+	    !gp_poll_exp_full1 &&
+	    !gp_normal1 &&
+	    !gp_poll1 &&
+	    !gp_poll_full1 &&
+	    !gp_sync1) {
+		gp_cond1 = true;
+		gp_cond_exp1 = true;
+		gp_cond_full1 = true;
+		gp_cond_exp_full1 = true;
+		gp_exp1 = true;
+		gp_poll_exp1 = true;
+		gp_poll_exp_full1 = true;
+		gp_normal1 = true;
+		gp_poll1 = true;
+		gp_poll_full1 = true;
+		gp_sync1 = true;
+	}
 	if (gp_cond1 && cur_ops->get_gp_state && cur_ops->cond_sync) {
 		synctype[nsynctypes++] = RTWS_COND_GET;
 		pr_info("%s: Testing conditional GPs.\n", __func__);
-- 
2.31.1.189.g2e36527f23

