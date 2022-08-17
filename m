Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59D3596CBB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 12:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239023AbiHQKTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 06:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238912AbiHQKT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 06:19:26 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A32760E4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:19:20 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id w11-20020a17090a380b00b001f73f75a1feso1406044pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=yob3/+IwNeWgOZVqPDUGNXwyBAO5sJAn+qw3hk8rQbE=;
        b=Tna2JkyXzqn5qE47zwCxnPqMJBvOs2MucxtFWhJJ0c/lzCw9K5Z32HPbeuTEFcnaXm
         euh69XaJIiwNQsXoFXICFSU+/Oca1A0aBr+VKjaQwRsqZn0ImCwMvZM0N8OAtELq5gWO
         8FFxXGzMld8SE/bklMsCfmz8zmuRhUc1KMMSce/NCBQ/LcnIuDs1AfKmri8IhYcblm+V
         rrNNS4fF5tsR5jmnvk57xPPvLXbTFJrN6HyWLycKFPInDB+wHEqRePYu7yjFgNU3vP5E
         BG+0gLROd9cISMZo+XFOB9NN0yZR8ajSr+tMCE72foa4xqmEUVSggTGPNNWEhj7k62Sa
         xqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=yob3/+IwNeWgOZVqPDUGNXwyBAO5sJAn+qw3hk8rQbE=;
        b=pGMAw46cA3d8i/2O9hzv6vd6NEx6p0clBvpFT7hq2jGfdaV1fcUIb8Y/9Ll+EoVqCJ
         94Rz2L0UtNh7xu3PKA69vMR0/R9MHaesYuxSST/eeXGOkTfve9XBhuA/aQCQy3qPxWpW
         fysEbkzMrbw9Fk91DRA+9hL71iJ4J0ggu9wZM6S3Dry8LU9ar2UqM7SanIh6E5kafS3r
         VQyB0aB9QNibwZJmwKxu/rVcOnjkvsUt9NUslS1Pm2mbMYh3EgvLTe7Lvgi5gTRkoe0i
         8RhAJTdQZsK860+iFlDZJknvhAzLd1Cqzu5r0eWEouBxujsSDGVRaVj5mOVnz5d51rQc
         st/w==
X-Gm-Message-State: ACgBeo1K0mOhwUcdzEEHeVUxWYmj1O8Wsq+t7wAP84/NbQDdh0F1nnZ1
        kyhg2EVeRmvjH1Na4OvVtvs=
X-Google-Smtp-Source: AA6agR4US9kp+7qbu6CM869/bm31zI3vqMNat3pYfqBfuj2fagq4H+iDwarnNS8c/JYltDYP+XKAMw==
X-Received: by 2002:a17:90b:48c3:b0:1fa:7ade:384a with SMTP id li3-20020a17090b48c300b001fa7ade384amr3021105pjb.106.1660731559586;
        Wed, 17 Aug 2022 03:19:19 -0700 (PDT)
Received: from hyeyoo.. ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id d8-20020a170903230800b00172633fc236sm1071318plh.174.2022.08.17.03.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 03:19:18 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/17] mm/slab_common: cleanup kmalloc_large()
Date:   Wed, 17 Aug 2022 19:18:18 +0900
Message-Id: <20220817101826.236819-10-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220817101826.236819-1-42.hyeyoo@gmail.com>
References: <20220817101826.236819-1-42.hyeyoo@gmail.com>
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

Now that kmalloc_large() and kmalloc_large_node() do mostly same job,
make kmalloc_large() wrapper of kmalloc_large_node_notrace().

In the meantime, add missing flag fix code in
kmalloc_large_node_notrace().

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab_common.c | 35 +++++++++++++----------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 7a0942d54424..51ccd0545816 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -905,28 +905,6 @@ gfp_t kmalloc_fix_flags(gfp_t flags)
  * directly to the page allocator. We use __GFP_COMP, because we will need to
  * know the allocation order to free the pages properly in kfree.
  */
-void *kmalloc_large(size_t size, gfp_t flags)
-{
-	void *ret = NULL;
-	struct page *page;
-	unsigned int order = get_order(size);
-
-	if (unlikely(flags & GFP_SLAB_BUG_MASK))
-		flags = kmalloc_fix_flags(flags);
-
-	page = alloc_pages(flags | __GFP_COMP, order);
-	if (likely(page)) {
-		ret = page_address(page);
-		mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B,
-				      PAGE_SIZE << order);
-	}
-	ret = kasan_kmalloc_large(ret, size, flags);
-	/* As ret might get tagged, call kmemleak hook after KASAN. */
-	kmemleak_alloc(ret, size, 1, flags);
-	trace_kmalloc(_RET_IP_, ret, NULL, size, PAGE_SIZE << order, flags);
-	return ret;
-}
-EXPORT_SYMBOL(kmalloc_large);
 
 void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
 {
@@ -934,6 +912,9 @@ void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
 	void *ptr = NULL;
 	unsigned int order = get_order(size);
 
+	if (unlikely(flags & GFP_SLAB_BUG_MASK))
+		flags = kmalloc_fix_flags(flags);
+
 	flags |= __GFP_COMP;
 	page = alloc_pages_node(node, flags, order);
 	if (page) {
@@ -949,6 +930,16 @@ void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
 	return ptr;
 }
 
+void *kmalloc_large(size_t size, gfp_t flags)
+{
+	void *ret = kmalloc_large_node_notrace(size, flags, NUMA_NO_NODE);
+
+	trace_kmalloc(_RET_IP_, ret, NULL, size,
+		      PAGE_SIZE << get_order(size), flags);
+	return ret;
+}
+EXPORT_SYMBOL(kmalloc_large);
+
 void *kmalloc_large_node(size_t size, gfp_t flags, int node)
 {
 	void *ret = kmalloc_large_node_notrace(size, flags, node);
-- 
2.32.0

