Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACD14D1675
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346638AbiCHLoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346555AbiCHLnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:43:42 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F35FFA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 03:42:40 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id k92so7800439pjh.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 03:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dRBTUQACiQlx0LwCs+gvgSw5DzRBjLDB/xFsjZpjfn8=;
        b=eKhM8L1Q6v+MAnYmglapfX6kG3lc2plE0eACiYKlqVnXpgx6WVSGv+Lqf/5cDPEDP4
         gZ+5uvrqB+Xqokx85qkhqLFzX0sgrCqmtk4511gissRzPIjOlt0zU1ZdG18sJp0iaLvk
         dG/RkxfbD4qUOGLzPuwQEuRcLFom7ajyiwfQ4gci/VBV3tV35Q2aEzhWb1efes/Dr+4c
         c5HyIVkQ50Ma/cEs0oXvFtYuVzYmY4Xo1KYScGZ2PNGP4NMB8k7wxOB4dHTuzUQiXPZE
         P8apwja9zdytSWgXOoIxtsKuiYTDApaTg3muHU4KoHFmZNWmvyAgrEoTAlbw2AtgduRq
         PuhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dRBTUQACiQlx0LwCs+gvgSw5DzRBjLDB/xFsjZpjfn8=;
        b=PFlPeV/xTQdgLyHSNuEaN7kEGZ1U7i7X3WR2Vzilwj/D0/AwwS4qObvL/O/zMP+N/7
         T+RwMrAVJP+lbL+DNIuktvkuqUHxT8yN+05RgnFxxYt4irP1cAKEjZZwDAqltQrn2vQy
         6veFs3aXuBHOl/uC+cn7w9RG8Zf7a5gWHJ8Af/EqAXQYLOWGgn22KgdGLnxzO5oYUkNa
         GqOs/tDysDbmh4vxC5IHFSAGAcDuf4CpPcO9GjLP1+fLBLkhdhu33B8IrAuanvADYsJc
         qfp5dCBOLQX8xmDeyoHkWwMdQTgX81s5rO0csBTuALUrsohAfYYm6dLIbAUGQM8acNW3
         sPWA==
X-Gm-Message-State: AOAM530W2Kxgrx1/c95E4+gwj/Crzwph4P3JN5ULIkpJTFCyx3CfVCEb
        cx18t2dPHr3M9boZXXRBX2A=
X-Google-Smtp-Source: ABdhPJxPvhmUGL9XnU9afnShPr0BQ2rnu562TEMPr2BvMh14WzqH80Eyl1ZH6ljIydlfk5YeOt4KAQ==
X-Received: by 2002:a17:90b:4b4f:b0:1bf:2381:b247 with SMTP id mi15-20020a17090b4b4f00b001bf2381b247mr4163411pjb.75.1646739759779;
        Tue, 08 Mar 2022 03:42:39 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id i2-20020a17090ac40200b001bd0e552d27sm2578285pjt.11.2022.03.08.03.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 03:42:39 -0800 (PST)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     linux-mm@kvack.org
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org, 42.hyeyoo@gmail.com
Subject: [RFC PATCH v1 07/15] mm/sl[au]b: kmalloc_node: pass large requests to page allocator
Date:   Tue,  8 Mar 2022 11:41:34 +0000
Message-Id: <20220308114142.1744229-8-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220308114142.1744229-1-42.hyeyoo@gmail.com>
References: <20220308114142.1744229-1-42.hyeyoo@gmail.com>
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

Now that kmalloc_large_node() is in common code, pass large requests
to page allocator in kmalloc_node() using kmalloc_large_node().

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 include/linux/slab.h | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 8840b2d55567..33d4260bce8b 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -551,23 +551,35 @@ static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
 	return __kmalloc(size, flags);
 }
 
+#ifndef CONFIG_SLOB
 static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
 {
-#ifndef CONFIG_SLOB
-	if (__builtin_constant_p(size) &&
-		size <= KMALLOC_MAX_CACHE_SIZE) {
-		unsigned int i = kmalloc_index(size);
+	if (__builtin_constant_p(size)) {
+		unsigned int index;
 
-		if (!i)
+		if (size > KMALLOC_MAX_CACHE_SIZE)
+			return kmalloc_large_node(size, flags, node);
+
+		index = kmalloc_index(size);
+
+		if (!index)
 			return ZERO_SIZE_PTR;
 
 		return kmem_cache_alloc_node_trace(
 				kmalloc_caches[kmalloc_type(flags)][i],
 						flags, node, size);
 	}
-#endif
 	return __kmalloc_node(size, flags, node);
 }
+#else
+static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
+{
+	if (__builtin_constant_p(size) && size > KMALLOC_MAX_CACHE_SIZE)
+		return kmalloc_large_node(size, flags, node);
+
+	return __kmalloc_node(size, flags, node);
+}
+#endif
 
 /**
  * kmalloc_array - allocate memory for an array.
-- 
2.33.1

