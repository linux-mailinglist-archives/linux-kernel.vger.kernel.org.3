Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C422505FFE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 00:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbiDRW5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 18:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbiDRW4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 18:56:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCDE2CE3B;
        Mon, 18 Apr 2022 15:54:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17885B81148;
        Mon, 18 Apr 2022 22:54:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E70AC385B6;
        Mon, 18 Apr 2022 22:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650322441;
        bh=7YceAtQ4xCGuX9O3QcLmd4DKQm9RucoBz1BbPwEutSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZmMN9xvPQderK9vVByZh5rBt/vyyHCPUQuUl6ftiTHVZ/2t43QFA+9TIRY5gm7jQX
         CPayMZBHu5nKUzvMsIwSiEwjHqMlCDjWX1u37LzOpm9cw8vAl57hZ81tFiTA01+ZrD
         Yo0fSZnkM+YE4fp04aoqH2qaY+PBW1Q3AMuxE+nu2cgIgikUJZwNgunlyqr0LnUUn9
         rG2Mg8O7ChLolIdsuAwmhTjPXCm/4xwbytAmGXwmrdYhII1kadckulN//W1IQ/vwYm
         STPglXypdkND0e9CillyEdx7/yUbs2bkaGajISr/Hfs1JUe1QoTOBccNGqON6w507o
         XhsWqF3iozXMw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id ECC905C121E; Mon, 18 Apr 2022 15:54:00 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 08/11] srcu: Drop needless initialization of sdp in srcu_gp_start()
Date:   Mon, 18 Apr 2022 15:53:56 -0700
Message-Id: <20220418225359.3945217-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220418225345.GA3945110@paulmck-ThinkPad-P17-Gen-1>
References: <20220418225345.GA3945110@paulmck-ThinkPad-P17-Gen-1>
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

From: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Commit 9c7ef4c30f12 ("srcu: Make Tree SRCU able to operate without
snp_node array") initializes the local variable sdp differently depending
on the srcu's state in srcu_gp_start().  Either way, this initialization
overwrites the value used when sdp is defined.

This commit therefore drops this pointless definition-time initialization.
Although there is no functional change, compiler code generation may
be affected.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 6833d8887181..e0ef018612a2 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -434,7 +434,7 @@ EXPORT_SYMBOL_GPL(__srcu_read_unlock);
  */
 static void srcu_gp_start(struct srcu_struct *ssp)
 {
-	struct srcu_data *sdp = this_cpu_ptr(ssp->sda);
+	struct srcu_data *sdp;
 	int state;
 
 	lockdep_assert_held(&ACCESS_PRIVATE(ssp, lock));
-- 
2.31.1.189.g2e36527f23

