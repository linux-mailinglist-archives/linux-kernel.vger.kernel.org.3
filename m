Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BCC4B4D27
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350277AbiBNLIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:08:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350070AbiBNLHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:07:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5B471597;
        Mon, 14 Feb 2022 02:37:12 -0800 (PST)
Date:   Mon, 14 Feb 2022 10:37:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644835030;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vKt/WAuCNj+bvLGLjCVMNQYEW9Arn1l1s0yZ7NByIho=;
        b=mQ3+VkCAOBMmVBmVPkb8kmJ1kiaFbGPaBBPspJhSDgtdH9vyF7EmDXjEU6ZQ+MAbd+bGGg
        idRqoSdMHeKyBLkj+BaMOpntdMoOg/qZVpjRg5GQM+id7P9+RRT19cUxLEvLSLmkg0jPN2
        /quxfatO2PRNZg3ekyrjoVSQ+P4qOkTa3k+uAJSdbgmDWaNPazxsHg6fcq6iW/I6u5PLho
        EQk+fdISV+rvM2ubwAQISn39rnuPmS7EkvLW2p/PmuRitzBTSS4FnFBlvwaRE1DQYkjS40
        GUy+VmvkanAWJ4rSTZ4rueSgnPQ13ZPvtDqw4HpIDS+eHOgXVQhMj0X8SURkRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644835030;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vKt/WAuCNj+bvLGLjCVMNQYEW9Arn1l1s0yZ7NByIho=;
        b=HZNCu23M/2RopYGDQNcMZq0x4rSMIpXmNGmPfk6gpVw/NecOyhsWAD76qrUEmPc9qIFtXQ
        +tu2IVDCudEaudAg==
From:   "tip-bot2 for Cheng Jui Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] lockdep: Correct lock_classes index mapping
Cc:     Cheng Jui Wang <cheng-jui.wang@mediatek.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220210105011.21712-1-cheng-jui.wang@mediatek.com>
References: <20220210105011.21712-1-cheng-jui.wang@mediatek.com>
MIME-Version: 1.0
Message-ID: <164483502963.16921.13140671629073762108.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     28df029d53a2fd80c1b8674d47895648ad26dcfb
Gitweb:        https://git.kernel.org/tip/28df029d53a2fd80c1b8674d47895648ad26dcfb
Author:        Cheng Jui Wang <cheng-jui.wang@mediatek.com>
AuthorDate:    Thu, 10 Feb 2022 18:50:11 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 11 Feb 2022 23:30:02 +01:00

lockdep: Correct lock_classes index mapping

A kernel exception was hit when trying to dump /proc/lockdep_chains after
lockdep report "BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!":

Unable to handle kernel paging request at virtual address 00054005450e05c3
...
00054005450e05c3] address between user and kernel address ranges
...
pc : [0xffffffece769b3a8] string+0x50/0x10c
lr : [0xffffffece769ac88] vsnprintf+0x468/0x69c
...
 Call trace:
  string+0x50/0x10c
  vsnprintf+0x468/0x69c
  seq_printf+0x8c/0xd8
  print_name+0x64/0xf4
  lc_show+0xb8/0x128
  seq_read_iter+0x3cc/0x5fc
  proc_reg_read_iter+0xdc/0x1d4

The cause of the problem is the function lock_chain_get_class() will
shift lock_classes index by 1, but the index don't need to be shifted
anymore since commit 01bb6f0af992 ("locking/lockdep: Change the range
of class_idx in held_lock struct") already change the index to start
from 0.

The lock_classes[-1] located at chain_hlocks array. When printing
lock_classes[-1] after the chain_hlocks entries are modified, the
exception happened.

The output of lockdep_chains are incorrect due to this problem too.

Fixes: f611e8cf98ec ("lockdep: Take read/write status in consideration when generate chainkey")
Signed-off-by: Cheng Jui Wang <cheng-jui.wang@mediatek.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20220210105011.21712-1-cheng-jui.wang@mediatek.com
---
 kernel/locking/lockdep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 4a882f8..f8a0212 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3462,7 +3462,7 @@ struct lock_class *lock_chain_get_class(struct lock_chain *chain, int i)
 	u16 chain_hlock = chain_hlocks[chain->base + i];
 	unsigned int class_idx = chain_hlock_class_idx(chain_hlock);
 
-	return lock_classes + class_idx - 1;
+	return lock_classes + class_idx;
 }
 
 /*
@@ -3530,7 +3530,7 @@ static void print_chain_keys_chain(struct lock_chain *chain)
 		hlock_id = chain_hlocks[chain->base + i];
 		chain_key = print_chain_key_iteration(hlock_id, chain_key);
 
-		print_lock_name(lock_classes + chain_hlock_class_idx(hlock_id) - 1);
+		print_lock_name(lock_classes + chain_hlock_class_idx(hlock_id));
 		printk("\n");
 	}
 }
