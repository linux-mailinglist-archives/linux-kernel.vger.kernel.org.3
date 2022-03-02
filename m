Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233EC4CA8DA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 16:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243408AbiCBPOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 10:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243393AbiCBPOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 10:14:24 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1D479C63
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 07:13:40 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646234017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yvhkHe8ffV7l7JQy8kWEX/L6d0v7GNlMNTEjcsXtnAI=;
        b=pf//kUiq5UreQmNoe4O7ZsvF78erL2mztEQ2l5rSDlszRje9RmOReAttOq4tgQdKAT0DLl
        VJwX4JW6HEzyj28mIrTJsP4nryvL+dEeHxdk7CC3Rcy2Azt/Q/zoIAlvtBPdHAEyo+QJA+
        YvKCnSEN8ESN95bQJppuNyQ4S6XcJZY=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm 1/2] fix for "kasan, vmalloc: only tag normal vmalloc allocations"
Date:   Wed,  2 Mar 2022 16:13:30 +0100
Message-Id: <9230ca3d3e40ffca041c133a524191fd71969a8d.1646233925.git.andreyknvl@google.com>
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

Pass KASAN_VMALLOC_PROT_NORMAL to kasan_unpoison_vmalloc() in the custom
KASAN instrumentation for Shadow Call Stack, as Shadow Call Stack mappings
are not executable and thus can be poisoned.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 kernel/scs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/scs.c b/kernel/scs.c
index b83bc9251f99..1033a76a3284 100644
--- a/kernel/scs.c
+++ b/kernel/scs.c
@@ -32,7 +32,8 @@ static void *__scs_alloc(int node)
 	for (i = 0; i < NR_CACHED_SCS; i++) {
 		s = this_cpu_xchg(scs_cache[i], NULL);
 		if (s) {
-			kasan_unpoison_vmalloc(s, SCS_SIZE, KASAN_VMALLOC_NONE);
+			kasan_unpoison_vmalloc(s, SCS_SIZE,
+					       KASAN_VMALLOC_PROT_NORMAL);
 			memset(s, 0, SCS_SIZE);
 			return s;
 		}
@@ -78,7 +79,7 @@ void scs_free(void *s)
 		if (this_cpu_cmpxchg(scs_cache[i], 0, s) == NULL)
 			return;
 
-	kasan_unpoison_vmalloc(s, SCS_SIZE, KASAN_VMALLOC_NONE);
+	kasan_unpoison_vmalloc(s, SCS_SIZE, KASAN_VMALLOC_PROT_NORMAL);
 	vfree_atomic(s);
 }
 
-- 
2.25.1

