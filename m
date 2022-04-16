Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FD0503434
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiDPE2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 00:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiDPE2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 00:28:36 -0400
Received: from ha.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3F8D3EBBE
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 21:26:05 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by ha.nfschina.com (Postfix) with ESMTP id B49BA1E80BE4;
        Sat, 16 Apr 2022 12:24:19 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from ha.nfschina.com ([127.0.0.1])
        by localhost (ha.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GyS6eT-Qc_Kv; Sat, 16 Apr 2022 12:24:17 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: liqiong@nfschina.com)
        by ha.nfschina.com (Postfix) with ESMTPA id 872691E80BE1;
        Sat, 16 Apr 2022 12:24:16 +0800 (CST)
From:   liqiong <liqiong@nfschina.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marco Elver <elver@google.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        liqiong <liqiong@nfschina.com>
Cc:     linux-kernel@vger.kernel.org, yuzhe@nfschina.com,
        renyu@nfschina.com
Subject: [PATCH] init: force (struct __rcu *) pointer casting in init_task()
Date:   Sat, 16 Apr 2022 12:25:38 +0800
Message-Id: <20220416042538.472667-1-liqiong@nfschina.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When assign (struct *) pointer to (struct __rcu *) variable,
Sparse warns:
    "incorrect type in initializer (different address spaces)".

Force casting to (struct __ruc *) pointer to fix it.

Signed-off-by: liqiong <liqiong@nfschina.com>
---
 init/init_task.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/init/init_task.c b/init/init_task.c
index 73cc8f03511a..ba8ff3051cd2 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -104,8 +104,8 @@ struct task_struct init_task
 #endif
 	.ptraced	= LIST_HEAD_INIT(init_task.ptraced),
 	.ptrace_entry	= LIST_HEAD_INIT(init_task.ptrace_entry),
-	.real_parent	= &init_task,
-	.parent		= &init_task,
+	.real_parent	= (struct task_struct __rcu *)&init_task,
+	.parent		= (struct task_struct __rcu *)&init_task,
 	.children	= LIST_HEAD_INIT(init_task.children),
 	.sibling	= LIST_HEAD_INIT(init_task.sibling),
 	.group_leader	= &init_task,
@@ -119,7 +119,7 @@ struct task_struct init_task
 	.io_uring	= NULL,
 #endif
 	.signal		= &init_signals,
-	.sighand	= &init_sighand,
+	.sighand	= (struct sighand_struct __rcu *)&init_sighand,
 	.nsproxy	= &init_nsproxy,
 	.pending	= {
 		.list = LIST_HEAD_INIT(init_task.pending.list),
-- 
2.25.1

