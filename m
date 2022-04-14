Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507BB500915
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240409AbiDNJBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241431AbiDNJBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:01:13 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2B96BDE1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:58:47 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id h15-20020a17090a054f00b001cb7cd2b11dso5048368pjf.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7gSbtqBRr2wSdYKirc6pWSRHibf6eUTgwDuPBAZwnl8=;
        b=d1aUNa4xAf9AFLk27JROnTj7gTMxi+QKNfpwzKujGplZaDWjcUHJbpmmyHUlxNQWWv
         up2SXBZ/CPbl36VLVAS6pP9Ll2Rm8ygAHJ548vam92dc7eGxOpgDCT1CCw/0Nc8WaUgy
         WM0WARRtqcLQfaHYHSUoRl1wWH0bPL/Oe/nQoHD1XbeEAnN0Zdx64Cb9lIxHowMa2bF+
         3nlolC3fzeGVtaGqAztkZhJiyoT3BRjQN32KkJnoa2vwiTJ0aOY4X/xgbXsLwD+kq7z7
         hQZXajkx77QNN/8G6PLQQ52NcVzmt1tSOD3484narV1c5YgHPL9lPDq2c+s+9DDIElQ0
         NE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7gSbtqBRr2wSdYKirc6pWSRHibf6eUTgwDuPBAZwnl8=;
        b=lYpzkGYIYRW1PvzCDFM1FWDfNlzRdRY1hIAl7kEMifX6tE5U6IwQW01NmEEaS90NpA
         CyMh1Ynuim8d8MbVcORVBUpqsu9u2N2hSrIVajeJ6dJ8vMDcnk9pWApNPag1J7SKjdf2
         WMpBZohYZ9tiOH42GoiuVxF610FgH9KAlXZBLO/ocXVWme6471XqP6PfeU2bvW+2n+Wq
         stw3a+UnVDxCrnq+t87CaVP9iAL5osDS5TVQnohUyyP7QYhRmWPGSMrxID0WDHcx5bzO
         Q+9dCuGby52StP1xBYA4MyBPBE8Ck2yMoM2RmR7ZjdRrBV8KZlWCC8BeqbaqUIOMF+M7
         ODWA==
X-Gm-Message-State: AOAM533twjkrzEepL0KMuk1RmI/ZPYqok0UmNejaUi502EJ4VfIr3wed
        4VsoJ7yOC8Ai6S81jrbuvog=
X-Google-Smtp-Source: ABdhPJzj3pUgRnAQ9AeoN1UcTJDOaBjCMDcKEporHnxQE//dhFhbfvsbYssdkFT4Us/0SBKGseAknQ==
X-Received: by 2002:a17:902:b495:b0:158:8318:4cf9 with SMTP id y21-20020a170902b49500b0015883184cf9mr13579160plr.33.1649926726962;
        Thu, 14 Apr 2022 01:58:46 -0700 (PDT)
Received: from hyeyoo.. ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id p9-20020aa79e89000000b00505fada20dfsm1403537pfq.117.2022.04.14.01.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 01:58:45 -0700 (PDT)
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
Subject: [PATCH v2 11/23] mm/slab_common: kmalloc_node: pass large requests to page allocator
Date:   Thu, 14 Apr 2022 17:57:15 +0900
Message-Id: <20220414085727.643099-12-42.hyeyoo@gmail.com>
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

Now that kmalloc_large_node() is in common code, pass large requests
to page allocator in kmalloc_node() using kmalloc_large_node().

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/slab.h | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 1b5bdcb0fd31..eb457f20f415 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -608,23 +608,35 @@ static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
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
-				kmalloc_caches[kmalloc_type(flags)][i],
+				kmalloc_caches[kmalloc_type(flags)][index],
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
2.32.0

