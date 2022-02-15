Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA454B7805
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239346AbiBOQwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:52:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbiBOQwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:52:33 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1CB3AA56
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:52:22 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1644943940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=x0WqM712H6kGeqw3TwDc06pcqFg5ecYp2OoNXB9nDtc=;
        b=hpIlGRiz9NewVc3tjwMSNma3ps7kUMWeWbHJGVVzUnmYckb+tYbEzRH9bRJHWP+gKCE8af
        0aRjRQR2Lza4OahDsRnPFNU8moxBt1CaQjK8Y24us21RgRbLSqKG/oJL3XV3R0hw+R4E4K
        k7+o60f3sUXhfhpDu9YuRYAjeczwhok=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm] fix for "kasan, fork: reset pointer tags of vmapped stacks"
Date:   Tue, 15 Feb 2022 17:52:17 +0100
Message-Id: <f50c5f96ef896d7936192c888b0c0a7674e33184.1644943792.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

That patch didn't update the case when a stack is retrived from
cached_stacks in alloc_thread_stack_node(). As cached_stacks stores
vm_structs and not stack pointers themselves, the pointer tag needs
to be reset there as well.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 kernel/fork.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 57d624f05182..5e3ad2e7a756 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -226,15 +226,17 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
 		if (!s)
 			continue;
 
-		/* Mark stack accessible for KASAN. */
+		/* Reset stack metadata. */
 		kasan_unpoison_range(s->addr, THREAD_SIZE);
 
+		stack = kasan_reset_tag(s->addr);
+
 		/* Clear stale pointers from reused stack. */
-		memset(s->addr, 0, THREAD_SIZE);
+		memset(stack, 0, THREAD_SIZE);
 
 		tsk->stack_vm_area = s;
-		tsk->stack = s->addr;
-		return s->addr;
+		tsk->stack = stack;
+		return stack;
 	}
 
 	/*
-- 
2.25.1

