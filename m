Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5824CA8DC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 16:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243413AbiCBPO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 10:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243406AbiCBPOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 10:14:25 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D24279C79
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 07:13:42 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646234019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j3qLOT6ZMaAmt2b0mGfPQFqvAJBBG++PkHqA3Cl101c=;
        b=CSGzfx3omDRUovLYXrhVK8m9urx3lpO3DcOk9bq+9xGjlT+cQYnASWoP6YbsvHSRFuNMRW
        smrOixVneQODj8G11tW7sOlh84DaazE0fumZw7INvWjG13xijjvbp8/+viKkJ+emwI5Hkk
        epQ9S8WDLJVnFFr2Nu9SQGAzTTa9xuY=
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
Subject: [PATCH mm 2/2] kasan, scs: support tagged vmalloc mappings
Date:   Wed,  2 Mar 2022 16:13:31 +0100
Message-Id: <2f6605e3a358cf64d73a05710cb3da356886ad29.1646233925.git.andreyknvl@google.com>
In-Reply-To: <9230ca3d3e40ffca041c133a524191fd71969a8d.1646233925.git.andreyknvl@google.com>
References: <9230ca3d3e40ffca041c133a524191fd71969a8d.1646233925.git.andreyknvl@google.com>
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

Fix up the custom KASAN instrumentation for Shadow Call Stack to support
vmalloc() mappings and pointers being tagged.

- Use the tagged pointer returned by kasan_unpoison_vmalloc() in
  __scs_alloc() when calling memset() to avoid false-positives.

- Do not return a tagged Shadow Call Stack pointer from __scs_alloc(),
  as this might lead to conflicts with the instrumentation.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Andrew, please put this patch after
"kasan, vmalloc: only tag normal vmalloc allocations".
---
 kernel/scs.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/scs.c b/kernel/scs.c
index 1033a76a3284..b7e1b096d906 100644
--- a/kernel/scs.c
+++ b/kernel/scs.c
@@ -32,16 +32,19 @@ static void *__scs_alloc(int node)
 	for (i = 0; i < NR_CACHED_SCS; i++) {
 		s = this_cpu_xchg(scs_cache[i], NULL);
 		if (s) {
-			kasan_unpoison_vmalloc(s, SCS_SIZE,
-					       KASAN_VMALLOC_PROT_NORMAL);
+			s = kasan_unpoison_vmalloc(s, SCS_SIZE,
+						   KASAN_VMALLOC_PROT_NORMAL);
 			memset(s, 0, SCS_SIZE);
-			return s;
+			goto out;
 		}
 	}
 
-	return __vmalloc_node_range(SCS_SIZE, 1, VMALLOC_START, VMALLOC_END,
+	s = __vmalloc_node_range(SCS_SIZE, 1, VMALLOC_START, VMALLOC_END,
 				    GFP_SCS, PAGE_KERNEL, 0, node,
 				    __builtin_return_address(0));
+
+out:
+	return kasan_reset_tag(s);
 }
 
 void *scs_alloc(int node)
-- 
2.25.1

