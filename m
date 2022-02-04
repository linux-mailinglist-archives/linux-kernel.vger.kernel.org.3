Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51004AA403
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377939AbiBDXIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:08:21 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53366 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377900AbiBDXIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:08:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6230FB83967;
        Fri,  4 Feb 2022 23:08:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C6EC340F1;
        Fri,  4 Feb 2022 23:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644016087;
        bh=F0tWzgWyTYIaOE59H/lt7xyxwXQQkMt7UW6k3PjcRfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KwMVc5kHGt9LR4D9VYGVwl6A0quOy2YKoBtx1/u+nLM9XeDt3jyxmRqfu2bo4niXn
         w+WPAwrBt9D6gcQwGgUyMjLorhqF0sym7cctQiIA3VHSbWHB9j3AWCbVORY9FCDc1S
         O4uthPcIySi1ixNzcltPZvye5kP3m/Yu/OuWZDlTUZ7TxpI3w1ReRy24yNS0zEq8MV
         Awyj4r/rUMTRyetyWqeYjaIN39BYEnyvlRrHjV3bukPm58ZqiPAyjhlvTfatDlq/Ap
         O2WDPi46M2UZH12XJR2/25ymYx9bPCC2BZxdQwO74nP17mr4O32JfgGcGgqYe/T0nm
         +cIqXasP51y0A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9E9F05C0992; Fri,  4 Feb 2022 15:08:06 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Zqiang <qiang1.zhang@intel.com>,
        Marco Elver <elver@google.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 5/9] kasan: Record work creation stack trace with interrupts enabled
Date:   Fri,  4 Feb 2022 15:08:01 -0800
Message-Id: <20220204230805.4193767-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204230751.GA4193671@paulmck-ThinkPad-P17-Gen-1>
References: <20220204230751.GA4193671@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang1.zhang@intel.com>

Recording the work creation stack trace for KASAN reports in
call_rcu() is expensive, due to unwinding the stack, but also
due to acquiring depot_lock inside stackdepot (which may be contended).
Because calling kasan_record_aux_stack_noalloc() does not require
interrupts to already be disabled, this may unnecessarily extend
the time with interrupts disabled.

Therefore, move calling kasan_record_aux_stack() before the section
with interrupts disabled.

Acked-by: Marco Elver <elver@google.com>
Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f1bb7ccc00847..ca8d7dd026eeb 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3060,8 +3060,8 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
 	}
 	head->func = func;
 	head->next = NULL;
-	local_irq_save(flags);
 	kasan_record_aux_stack_noalloc(head);
+	local_irq_save(flags);
 	rdp = this_cpu_ptr(&rcu_data);
 
 	/* Add the callback to our list. */
-- 
2.31.1.189.g2e36527f23

