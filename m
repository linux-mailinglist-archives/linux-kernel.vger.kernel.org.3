Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B2F4CCDDB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 07:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238516AbiCDGg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 01:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238497AbiCDGgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 01:36:15 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3F518DAAD
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 22:34:47 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id g1so6862322pfv.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 22:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sl+tnBHk3Om3exFNoQL1k9gm+o8msiRC3imZlWXFCFQ=;
        b=RqVWgGr9J9yOyOmhf/M7Rf5rVoQmBacywljxXUt7owe+MoiBcPp5It1tMurj0PjnXd
         Ouqe/V6NBZrcvo6w7ZMuEdxfbsjAkSoFES01WeJvCt6D3HdrZvRJXFnMbIvexDn/FyhD
         iBQzMeqSvC0nBRzJ88nbEK9TTmcnpWFpAxvynTA7kLxRKnDcYMzhsuN3zD9VWmGIrmOM
         vhEzX4e6v7tTBdZfWd55w0xwJa+3Yup/4gmOEjWsj/dO0PJNxiG4madqTytAua4HdpvS
         04mkkhHJhosVGbv66Ql6zJ2KJ/C0GcJtbwewtqAQtFtaP+l7OfjN6qUJehTr+x3SRHe9
         UhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sl+tnBHk3Om3exFNoQL1k9gm+o8msiRC3imZlWXFCFQ=;
        b=g9Pd08BtkrnkKkvselJ0RqlOR8gfLmktibbFUn8VOdoLgtZEQk4ySts6Gc0a+26akt
         3OeVnda8yVni7SG6yNFSdb4ETS/y3zxjTHDNMOqxkg5Bra6y6uSUQlvV41zQGAzLpitW
         4ZILNqMrtpfvgKPXbS8Ye9OROZe5ND3zdG3kg2LyPeyDZbTQ1BPLywJp6qfTd0lhc2F2
         77P00LIlaYzTildqD6gtRsLuwkRYE/ICQAdi0uFv89Bn3lfgtemfqZ81GU5BxGbqN4aL
         qpToaxpGXWAV8rBu9Nu2BYgWuqFlPZA7XU7wpSgbrU2seMdPA7YOldl/sTgWGSbYV3k/
         k0Rg==
X-Gm-Message-State: AOAM533GzZSMiPqr4W55b2stKTDqewPmmqxYe31CCFo9YG8bJGiC5uR0
        ElElTJl6iXsD4CT/uhlpSr61LAtbyeeGCw==
X-Google-Smtp-Source: ABdhPJxAx/kaLkY9NudzLA8xsz3v1HTz5vDFFp5IWgY5okd3A/kN+0kX2WWhmiiBZ7RvUzsi5ADCrg==
X-Received: by 2002:a63:cd02:0:b0:378:9b24:4a9 with SMTP id i2-20020a63cd02000000b003789b2404a9mr20323397pgg.327.1646375687212;
        Thu, 03 Mar 2022 22:34:47 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id v10-20020a056a00148a00b004e0f420dd90sm4900007pfu.40.2022.03.03.22.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 22:34:47 -0800 (PST)
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
Subject: [PATCH v2 2/5] mm/sl[au]b: unify __ksize()
Date:   Fri,  4 Mar 2022 06:34:24 +0000
Message-Id: <20220304063427.372145-3-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220304063427.372145-1-42.hyeyoo@gmail.com>
References: <20220304063427.372145-1-42.hyeyoo@gmail.com>
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

Now that SLAB passes large requests to page allocator like SLUB,
Unify __ksize(). Only SLOB need to implement own version of __ksize()
because it stores size in object header for kmalloc objects.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/slab.c        | 30 ------------------------------
 mm/slab_common.c | 27 +++++++++++++++++++++++++++
 mm/slub.c        | 16 ----------------
 3 files changed, 27 insertions(+), 46 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 570af6dc3478..3ddf2181d8e4 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -4216,33 +4216,3 @@ void __check_heap_object(const void *ptr, unsigned long n,
 	usercopy_abort("SLAB object", cachep->name, to_user, offset, n);
 }
 #endif /* CONFIG_HARDENED_USERCOPY */
-
-/**
- * __ksize -- Uninstrumented ksize.
- * @objp: pointer to the object
- *
- * Unlike ksize(), __ksize() is uninstrumented, and does not provide the same
- * safety checks as ksize() with KASAN instrumentation enabled.
- *
- * Return: size of the actual memory used by @objp in bytes
- */
-size_t __ksize(const void *objp)
-{
-	struct kmem_cache *c;
-	struct folio *folio;
-	size_t size;
-
-	BUG_ON(!objp);
-	if (unlikely(objp == ZERO_SIZE_PTR))
-		return 0;
-
-	folio = virt_to_folio(objp);
-	if (!folio_test_slab(folio))
-		return folio_size(folio);
-
-	c = virt_to_cache(objp);
-	size = c ? c->object_size : 0;
-
-	return size;
-}
-EXPORT_SYMBOL(__ksize);
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 23f2ab0713b7..1d2f92e871d2 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1245,6 +1245,33 @@ void kfree_sensitive(const void *p)
 }
 EXPORT_SYMBOL(kfree_sensitive);
 
+#ifndef CONFIG_SLOB
+/**
+ * __ksize -- Uninstrumented ksize.
+ * @objp: pointer to the object
+ *
+ * Unlike ksize(), __ksize() is uninstrumented, and does not provide the same
+ * safety checks as ksize() with KASAN instrumentation enabled.
+ *
+ * Return: size of the actual memory used by @objp in bytes
+ */
+size_t __ksize(const void *object)
+{
+	struct folio *folio;
+
+	if (unlikely(object == ZERO_SIZE_PTR))
+		return 0;
+
+	folio = virt_to_folio(object);
+
+	if (unlikely(!folio_test_slab(folio)))
+		return folio_size(folio);
+
+	return slab_ksize(folio_slab(folio)->slab_cache);
+}
+EXPORT_SYMBOL(__ksize);
+#endif
+
 /**
  * ksize - get the actual amount of memory allocated for a given object
  * @objp: Pointer to the object
diff --git a/mm/slub.c b/mm/slub.c
index 04fd084f4709..6f0ebadd8f30 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4507,22 +4507,6 @@ void __check_heap_object(const void *ptr, unsigned long n,
 }
 #endif /* CONFIG_HARDENED_USERCOPY */
 
-size_t __ksize(const void *object)
-{
-	struct folio *folio;
-
-	if (unlikely(object == ZERO_SIZE_PTR))
-		return 0;
-
-	folio = virt_to_folio(object);
-
-	if (unlikely(!folio_test_slab(folio)))
-		return folio_size(folio);
-
-	return slab_ksize(folio_slab(folio)->slab_cache);
-}
-EXPORT_SYMBOL(__ksize);
-
 void kfree(const void *x)
 {
 	struct folio *folio;
-- 
2.33.1

