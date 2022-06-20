Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FF055275D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 01:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346459AbiFTXA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 19:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345994AbiFTW7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:59:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E625C193F7;
        Mon, 20 Jun 2022 15:58:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 407FBB81649;
        Mon, 20 Jun 2022 22:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9DF1C341C4;
        Mon, 20 Jun 2022 22:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765899;
        bh=W6kG3hpmkYco8VzH89bxd88TU98qz+QQY538iEjM9F4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AzwE355p7egz1mBjAAA04X4sCrzdl8xW2Sm/0hFWPYXzSyltLiqhwwgU1/2XeI327
         NQ0xmmGmLPC5C/5acAeK1YGhTK8NUCtw4a1HLkXN98jRtEsydb60mTQrWplkDX0xCz
         jvd0aw3aRfiErxTeR9ECLJbt6802pk9dJbccNI4aFIZl+qmRMBoAjbKLMFjdZa2dXb
         Rt5jvWydWvsYmDG4nFXt/bzmpJ4U/+39IssL+sQd6XqubjbxNVDYK/k/PL7Rcz+NGt
         dcp90ceuHn/T9rz9UAnuCple4tZLLjMfjPkX4V8ltkvBHtAZdFzv0bCPJC0e6oRu6j
         ts9lund7bmmLg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9B87C5C0A33; Mon, 20 Jun 2022 15:58:19 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Zqiang <qiang1.zhang@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 04/12] rcutorture: Fix memory leak in rcu_test_debug_objects()
Date:   Mon, 20 Jun 2022 15:58:09 -0700
Message-Id: <20220620225817.3843106-4-paulmck@kernel.org>
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

From: Zqiang <qiang1.zhang@intel.com>

The kernel memory leak detector located the following:

unreferenced object 0xffff95d941135b50 (size 16):
  comm "swapper/0", pid 1, jiffies 4294667610 (age 1367.451s)
  hex dump (first 16 bytes):
    f0 c6 c2 bd d9 95 ff ff 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000bc81d9b1>] kmem_cache_alloc_trace+0x2f6/0x500
    [<00000000d28be229>] rcu_torture_init+0x1235/0x1354
    [<0000000032c3acd9>] do_one_initcall+0x51/0x210
    [<000000003c117727>] kernel_init_freeable+0x205/0x259
    [<000000003961f965>] kernel_init+0x1a/0x120
    [<000000001998f890>] ret_from_fork+0x22/0x30

This is caused by the rcu_test_debug_objects() function allocating an
rcu_head structure, then failing to free it.  This commit therefore adds
the needed kfree() after the last use of this structure.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 9273264772b88..613711b8242b9 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -3116,6 +3116,7 @@ static void rcu_test_debug_objects(void)
 	pr_alert("%s: WARN: Duplicate call_rcu() test complete.\n", KBUILD_MODNAME);
 	destroy_rcu_head_on_stack(&rh1);
 	destroy_rcu_head_on_stack(&rh2);
+	kfree(rhp);
 #else /* #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD */
 	pr_alert("%s: !CONFIG_DEBUG_OBJECTS_RCU_HEAD, not testing duplicate call_rcu()\n", KBUILD_MODNAME);
 #endif /* #else #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD */
-- 
2.31.1.189.g2e36527f23

