Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F14500929
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241407AbiDNJEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241451AbiDNJCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:02:08 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A379420189
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:59:43 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id r10so413202pfh.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ua/uZ6qm2oTljPWsofJREnrVaB3Pp7mzKI9GmIJ+zVs=;
        b=i3xDvTW0KEoA3rocpb/ts6nvQdVhG/gwVA+cxvSoNic20GYFjH31pocaxRa1Gh3LSl
         er7pUR2X7EB5Vpam3pnIaxCJPc7HKG+SK0tY+SL9qwUloa6IpB4carU16P+0BFvn3Ve3
         jMkpgb5ur0o/LiQ/geHPuBcqAqAgRsG1xpZ6VuxtGZr0tQNMW4a/+DkO7kqid05uJmDJ
         TdPyWjSiO5qVsRdFro8/swAA20IXRPTZP1pL6Th05qXGgxX8S96uowdqPh5hqZryplAZ
         vdMoTau5uN6f9RxjzOV24KJMBPuK9PUWe89dsCl0SryZyVROw90wYX9LkpQxtN8NpZIS
         bZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ua/uZ6qm2oTljPWsofJREnrVaB3Pp7mzKI9GmIJ+zVs=;
        b=G+uVtnRWLF+XDDP7cRyt7pw8ok8FxMxkky4Uzp7nS8Az+UKEc4flgB4gBC7p8f7CSw
         zUi9JgEOA/PH3fTRlJ2b6GG0P3b2/PCdk4LQR1nFnC2aHpp1p7O+2EmNiLCi/lEpn/aU
         //D3+U0BHNdg+IA+w37IWn2UE9ueOPQWlpU0llEoDuhOLbW2D5kVgVIJaQINYxUFPmC9
         L0IaO4ib0RGRsZtKR1wLioQvKnXXr6VSy4+AVQA19B946NUnFEdXrIEv1jG5fX4tLQyj
         ljQVHeUxt6J3EZWialLSdMGj9hWYqTJZ9upoaMPDe86Pqdih8x7LBIDGI5xUXPe04Pve
         YjJQ==
X-Gm-Message-State: AOAM531tePwc9QA8udaAnBTSNlyfJ1vkvEx7nUdHB4inBceCyt9Jtiv2
        XYYw1bm0GEzMPXR3lDksGnk=
X-Google-Smtp-Source: ABdhPJx/Hd0A3GzOSvel1BxHOz4/B46nvZGT//rxRVflVuYWERDTpthd5Fup1TuuwYMwwTBDcmCmiw==
X-Received: by 2002:a63:a804:0:b0:398:e7d7:29ab with SMTP id o4-20020a63a804000000b00398e7d729abmr1454997pgf.138.1649926783121;
        Thu, 14 Apr 2022 01:59:43 -0700 (PDT)
Received: from hyeyoo.. ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id p9-20020aa79e89000000b00505fada20dfsm1403537pfq.117.2022.04.14.01.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 01:59:41 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 20/23] mm/slab_common: factor out __do_kmalloc_node()
Date:   Thu, 14 Apr 2022 17:57:24 +0900
Message-Id: <20220414085727.643099-21-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220414085727.643099-1-42.hyeyoo@gmail.com>
References: <20220414085727.643099-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out common code into __do_kmalloc_node().

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/slab_common.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 6abe7f61c197..af563e64e8aa 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -919,7 +919,9 @@ void free_large_kmalloc(struct folio *folio, void *object)
 	__free_pages(folio_page(folio, 0), order);
 }
 
-void *__kmalloc_node(size_t size, gfp_t flags, int node)
+static __always_inline
+void *__do_kmalloc_node(size_t size, gfp_t flags, int node,
+			unsigned long caller __maybe_unused)
 {
 	struct kmem_cache *s;
 	void *ret;
@@ -932,31 +934,22 @@ void *__kmalloc_node(size_t size, gfp_t flags, int node)
 	if (unlikely(ZERO_OR_NULL_PTR(s)))
 		return s;
 
-	ret = __kmem_cache_alloc_node(s, NULL, flags, node, _RET_IP_);
+	ret = __kmem_cache_alloc_node(s, NULL, flags, node, caller);
 	ret = kasan_kmalloc(s, ret, size, flags);
 
 	return ret;
 }
+
+void *__kmalloc_node(size_t size, gfp_t flags, int node)
+{
+	return __do_kmalloc_node(size, flags, node, _RET_IP_);
+}
 EXPORT_SYMBOL(__kmalloc_node);
 
 void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
 					int node, unsigned long caller)
 {
-	struct kmem_cache *s;
-	void *ret;
-
-	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
-		return kmalloc_large_node(size, gfpflags, node);
-
-	s = kmalloc_slab(size, gfpflags);
-
-	if (unlikely(ZERO_OR_NULL_PTR(s)))
-		return s;
-
-	ret = __kmem_cache_alloc_node(s, NULL, gfpflags, node, caller);
-	ret = kasan_kmalloc(s, ret, size, gfpflags);
-
-	return ret;
+	return __do_kmalloc_node(size, flags, node, caller);
 }
 EXPORT_SYMBOL(__kmalloc_node_track_caller);
 
-- 
2.32.0

