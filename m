Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7E05A8501
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbiHaSIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbiHaSIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:08:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB8FE1902;
        Wed, 31 Aug 2022 11:08:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D017161BF0;
        Wed, 31 Aug 2022 18:08:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F270C433B5;
        Wed, 31 Aug 2022 18:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969287;
        bh=TVPaGAMvm71KkeIDiWEUCZyNJ+spX0wF8WrKcuO37bg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PepPYCxiB3sPg2EwiI5jDe0jPLlsz2hApLeQU2kOk1kfjE+gXRui8Dqj/cTpxYt90
         nx4yRsEYmyKQp1tfiImfJDTSlY6zggmrFZLJSUR5qmY66OKApDI/V1djbYPdJpqRRY
         OQ2KhD1I2enuAFOj8UjxIHQzefNMIelwi6bcZj/8EMNJZlKcJotxdXnWDlwE3jf8yn
         O7kHkb5KykmB5s4rzF7gi5VvjX9ASqvyHBaIWVTXbQkiiCGJpSsU5RBlEVgFSgApaz
         T+XdBl2lnkYP2DYxUiAaqcZMlRTT3AJGYc4axSp50TlklMNXvgElwCCnAhwRKxQaGq
         9yNj6y+JSlWfw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F0BF15C0513; Wed, 31 Aug 2022 11:08:06 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Zqiang <qiang1.zhang@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 04/10] rcu: Make tiny RCU support leak callbacks for debug-object errors
Date:   Wed, 31 Aug 2022 11:07:59 -0700
Message-Id: <20220831180805.2693546-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831180759.GA2693289@paulmck-ThinkPad-P17-Gen-1>
References: <20220831180759.GA2693289@paulmck-ThinkPad-P17-Gen-1>
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

From: Zqiang <qiang1.zhang@intel.com>

Currently, only Tree RCU leaks callbacks setting when it detects a
duplicate call_rcu().  This commit causes Tiny RCU to also leak
callbacks in this situation.

Because this is Tiny RCU, kernel size is important:

1. CONFIG_TINY_RCU=y and CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
   (Production kernel)

    Original:
    text      data      bss       dec       hex     filename
    26290663  20159823  15212544  61663030  3ace736 vmlinux

    With this commit:
    text      data      bss       dec       hex     filename
    26290663  20159823  15212544  61663030  3ace736 vmlinux

2. CONFIG_TINY_RCU=y and CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
   (Debugging kernel)

    Original:
    text      data      bss       dec       hex     filename
    26291319  20160143  15212544  61664006  3aceb06 vmlinux

    With this commit:
    text      data      bss       dec       hex     filename
    26291319  20160431  15212544  61664294  3acec26 vmlinux

These results show that the kernel size is unchanged for production
kernels, as desired.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tiny.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index f0561ee16b9c2..943d431b908f6 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -158,6 +158,10 @@ void synchronize_rcu(void)
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu);
 
+static void tiny_rcu_leak_callback(struct rcu_head *rhp)
+{
+}
+
 /*
  * Post an RCU callback to be invoked after the end of an RCU grace
  * period.  But since we have but one CPU, that would be after any
@@ -165,9 +169,20 @@ EXPORT_SYMBOL_GPL(synchronize_rcu);
  */
 void call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
+	static atomic_t doublefrees;
 	unsigned long flags;
 
-	debug_rcu_head_queue(head);
+	if (debug_rcu_head_queue(head)) {
+		if (atomic_inc_return(&doublefrees) < 4) {
+			pr_err("%s(): Double-freed CB %p->%pS()!!!  ", __func__, head, head->func);
+			mem_dump_obj(head);
+		}
+
+		if (!__is_kvfree_rcu_offset((unsigned long)head->func))
+			WRITE_ONCE(head->func, tiny_rcu_leak_callback);
+		return;
+	}
+
 	head->func = func;
 	head->next = NULL;
 
-- 
2.31.1.189.g2e36527f23

