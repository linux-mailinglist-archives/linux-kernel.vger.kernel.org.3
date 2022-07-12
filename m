Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D8F571B83
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbiGLNlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbiGLNkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:40:25 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6160B850F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:40:23 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id l12so7258562plk.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hkTIlokXdXZHx70dj4cBcCaT2BPOKJtfpJSDSwc0fHU=;
        b=gXwpav1cs46JY9auUHpcAwYHPt6lSXcC2SSzBTo4UXju5/zqc9fbvLJYuVlpXdlK+x
         ILUw3UDcuQM6XR0DYIOaLLq7PiFw1DelSfNhpH8fwrMOMcUZKBsnicw8LHwhwYTZZy9f
         V9yVjlGvi0UjRoM7uKFypklMHjTy5TGtAM389Mbcd/lY4jpm/sC7Nn4xgO2TvpAzLFDO
         kGQ2/qx9+4o3tsfwPKUPPFOueOag7i1feT+gRgghI/bdCfLwnHTCpw9HeHb2t//988sg
         c6NWB4HtEj7qA4n2UDfd8bO5eiuCpQHi/pkHoGQi6pX0nDw24mta8uLyX/kz+rzZnmC+
         QGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hkTIlokXdXZHx70dj4cBcCaT2BPOKJtfpJSDSwc0fHU=;
        b=eZofZ5bz7h4DdZmxjkAGPrreTFfJ3yNxMK9U3IkRO/dqqpjg4KAasw96bEPj9PCtEJ
         v9o9CTBzWX/Te99kdb6TwdOAJnDs3B2r1htwrvj1HixgtqP8rky16a83ugKfodLrOeqi
         3npO0f72JIleWayHaVqy3dOhjyTdnGc/dr9jLCxGze7InbX8+F6m7PhMFNLm0nut6m4k
         fjoAEwoYGYKsO4Qe/k10q1D5pRuEgLdPROT8DNERkn9v4BjXg3kHwsEgZDOWPiyXzGDX
         CaCNSJTpBkYGQdSfABMlrXT3qW4hiKaGkTL+hRB2rhrS+WOvwTTvRJ9ivcbP+w68489Q
         6OuA==
X-Gm-Message-State: AJIora+Gy+ZbD373nqV6jD5hiwEPh0W1RGKWbUxkPnan4zdhIX4vrzMr
        qH8/0YUWaRw+vd4ieYPt2Co=
X-Google-Smtp-Source: AGRyM1t9qjh7ww8HOoIZEKNFWLT+QYRkxOqJ5JGxw1Mo5b4zwMonNKL/Oyevq1mySzRn8kSkxIFfEg==
X-Received: by 2002:a17:90b:3807:b0:1f0:a86:6875 with SMTP id mq7-20020a17090b380700b001f00a866875mr4428239pjb.103.1657633223420;
        Tue, 12 Jul 2022 06:40:23 -0700 (PDT)
Received: from ip-172-31-24-42.ap-northeast-1.compute.internal (ec2-35-75-15-180.ap-northeast-1.compute.amazonaws.com. [35.75.15.180])
        by smtp.gmail.com with ESMTPSA id r6-20020aa79886000000b0052ae3bcb807sm1947178pfl.188.2022.07.12.06.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 06:40:22 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Joe Perches <joe@perches.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        Matthew WilCox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v3 09/15] mm/slab_common: cleanup kmalloc_large()
Date:   Tue, 12 Jul 2022 13:39:39 +0000
Message-Id: <20220712133946.307181-10-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220712133946.307181-1-42.hyeyoo@gmail.com>
References: <20220712133946.307181-1-42.hyeyoo@gmail.com>
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
make kmalloc_large() wrapper of __kmalloc_large_node_notrace().

In the meantime, add missing flag fix code in
__kmalloc_large_node_notrace().

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/slab_common.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index dc872e0ef0fc..9c46e2f9589f 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -932,29 +932,6 @@ gfp_t kmalloc_fix_flags(gfp_t flags)
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
-	flags |= __GFP_COMP;
-	page = alloc_pages(flags, order);
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
 
 static __always_inline
 void *__kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
@@ -963,6 +940,9 @@ void *__kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
 	void *ptr = NULL;
 	unsigned int order = get_order(size);
 
+	if (unlikely(flags & GFP_SLAB_BUG_MASK))
+		flags = kmalloc_fix_flags(flags);
+
 	flags |= __GFP_COMP;
 	page = alloc_pages_node(node, flags, order);
 	if (page) {
@@ -978,6 +958,16 @@ void *__kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
 	return ptr;
 }
 
+void *kmalloc_large(size_t size, gfp_t flags)
+{
+	void *ret = __kmalloc_large_node_notrace(size, flags, NUMA_NO_NODE);
+
+	trace_kmalloc(_RET_IP_, ret, NULL, size,
+		      PAGE_SIZE << get_order(size), flags);
+	return ret;
+}
+EXPORT_SYMBOL(kmalloc_large);
+
 void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
 {
 	return __kmalloc_large_node_notrace(size, flags, node);
-- 
2.34.1

