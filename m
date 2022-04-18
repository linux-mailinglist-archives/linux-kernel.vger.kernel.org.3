Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1610505FFF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 00:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbiDRW5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 18:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbiDRW4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 18:56:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623EE2CE1E;
        Mon, 18 Apr 2022 15:54:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5E41611B5;
        Mon, 18 Apr 2022 22:54:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990FBC385BA;
        Mon, 18 Apr 2022 22:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650322441;
        bh=WEGp4fOqBZnoeWztmlY6PE4IqXgAbDfyysxBTX/6wbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fg2xfCuAmR1sRRz+Pj12/Rcv6uPeWFMc5UnRQJHmkOZTcwwJG/nv3YNbQDdr05tJ4
         G4LJocC9/sACEapywezo9jleoZqAcWWPm1OV+iXeUZwyvVlf09wGsKl1RuTp8JdXZe
         fovK5sB8Fq23Zd8Akd2IpIdMVnZWCylr0Z3LNyEUjb3PjeXD7CgMzTfhYOJp1bTda+
         4nxIS+s58ykBRt1HIjS0PSpKk1Jlwpn8iJuuXWMobxT7JpG9QGgvFFEb88lNPQyaj6
         e4c/6stCPBA5Pz8LG+RXLuhfCy5g57mcSwnlvLmDTFKNI3s7/8gwyC27cy6prfQjI9
         TnSI9RARm5gmw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F04905C1308; Mon, 18 Apr 2022 15:54:00 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, David Vernet <void@manifault.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 10/11] rcu_sync: Fix comment to properly reflect rcu_sync_exit() behavior
Date:   Mon, 18 Apr 2022 15:53:58 -0700
Message-Id: <20220418225359.3945217-10-paulmck@kernel.org>
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

From: David Vernet <void@manifault.com>

The rcu_sync_enter() function is used by updaters to force RCU readers
(e.g. percpu-rwsem) to use their slow paths during an update.  This is
accomplished by setting the ->gp_state of the rcu_sync structure to
GP_ENTER.  In the case of percpu-rwsem, the readers' slow path waits on
a semaphore instead of just incrementing a reader count.  Each updater
invokes the rcu_sync_exit() function to signal to readers that they
may again take their fastpaths.  The rcu_sync_exit() function sets the
->gp_state of the rcu_sync structure to GP_EXIT, and if all goes well,
after a grace period the ->gp_state reverts back to GP_IDLE.

Unfortunately, the rcu_sync_enter() function currently has a comment
incorrectly stating that rcu_sync_exit() (by an updater) will re-enable
reader "slowpaths".  This patch changes the comment to state that this
function re-enables reader fastpaths.

Signed-off-by: David Vernet <void@manifault.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/sync.c b/kernel/rcu/sync.c
index 33d896d85902..5cefc702158f 100644
--- a/kernel/rcu/sync.c
+++ b/kernel/rcu/sync.c
@@ -111,7 +111,7 @@ static void rcu_sync_func(struct rcu_head *rhp)
  * a slowpath during the update.  After this function returns, all
  * subsequent calls to rcu_sync_is_idle() will return false, which
  * tells readers to stay off their fastpaths.  A later call to
- * rcu_sync_exit() re-enables reader slowpaths.
+ * rcu_sync_exit() re-enables reader fastpaths.
  *
  * When called in isolation, rcu_sync_enter() must wait for a grace
  * period, however, closely spaced calls to rcu_sync_enter() can
-- 
2.31.1.189.g2e36527f23

