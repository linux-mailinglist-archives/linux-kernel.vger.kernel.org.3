Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925494BE6A8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355933AbiBULRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 06:17:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355932AbiBULPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 06:15:18 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D5E301
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 02:53:59 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id ci24-20020a17090afc9800b001bc3071f921so2639478pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 02:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aA5sKZP46Br2IXGSlOJ6tqSDR6UxBlE/5/p8sTxFW2A=;
        b=TWXXfAQAoJokZM5wJBrVvEyYs+WaUxvPz/zifG36IeQ28CHce0CzCreiT2Lh78cklx
         tSBjiq3VySZhLEMOmAiUqrEKlLPMUhTQX9D01txRno+rzAJ0/PBum81r1/qFAR9BcYhf
         c7Y0wlGCn6ZCvmuSZbEre5JidSb/Lfd+0fr+oGqCQyahOo57+LHcEQbLb8SwYvsRUK+k
         mHcYuRl/BAu6IeHexEL4G32rL5+GNPosCx3ZHoyit0PBwyt50XLsZ8idVJt9bFbB2UTx
         M3RS4IIG1m3c3yIwATCQV4lDOaRg+enMG+GvFJRnfe9k6PjfS0dslpHqmztoZhSv4IRs
         0m6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aA5sKZP46Br2IXGSlOJ6tqSDR6UxBlE/5/p8sTxFW2A=;
        b=zWKv1bG4Kth0xrvnEu8kBjuBX3i4Uk+72eb/DnCF/+FT9cfGqF1qehkY3J7qSrVdJS
         pftl3rWu351z+zrfd3ZbsEvYs3E2w9n8f69Fm18yJrA3eahfhg5yEkCmZ++EEpAsrE9d
         qdHnYxcnQ+csThWpYX7Q4YI+7E0oBO1Qtp0Y1uOpSK/Acogtww89zlFCYUReWgDDyoie
         JcSxl6gHf9vIcQH83W8ad+yXkKvO2UvtXMJCCPwu7M09+QtmP7xJZx6jBLdDtFO2s4iZ
         iWNZDg2PFw6EfOto90iPrnEMDHidjiOG6gwUQ3HfpiTTUUqZSUV3JHL54/ZL0u/KPAKW
         FsaQ==
X-Gm-Message-State: AOAM531KVcqa6CtXSl/d/9jI2UYgU9Yne4TFcRYv4y7W7+1SXoH8OReW
        q3GNbdPVqyW3bwg7zHEn0Ms=
X-Google-Smtp-Source: ABdhPJzkBcA6oUH/qAaVd478izfxy2f+MQeMcLSeJRQBVr6AW6QXp3xyg6hHzj0PclNb0Z1q3auSqQ==
X-Received: by 2002:a17:90b:240f:b0:1b8:e0b1:9667 with SMTP id nr15-20020a17090b240f00b001b8e0b19667mr25349719pjb.244.1645440838606;
        Mon, 21 Feb 2022 02:53:58 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id u6sm2214725pfk.203.2022.02.21.02.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 02:53:58 -0800 (PST)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     linux-mm@kvack.org
Cc:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [PATCH 1/5] mm/sl[au]b: Unify __ksize()
Date:   Mon, 21 Feb 2022 10:53:32 +0000
Message-Id: <20220221105336.522086-2-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220221105336.522086-1-42.hyeyoo@gmail.com>
References: <20220221105336.522086-1-42.hyeyoo@gmail.com>
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

Only SLOB need to implement __ksize() separately because SLOB records
size in object header for kmalloc objects. Unify SLAB/SLUB's __ksize().

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/slab.c        | 23 -----------------------
 mm/slab_common.c | 29 +++++++++++++++++++++++++++++
 mm/slub.c        | 16 ----------------
 3 files changed, 29 insertions(+), 39 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index ddf5737c63d9..eb73d2499480 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -4199,27 +4199,4 @@ void __check_heap_object(const void *ptr, unsigned long n,
 }
 #endif /* CONFIG_HARDENED_USERCOPY */
 
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
-	size_t size;
 
-	BUG_ON(!objp);
-	if (unlikely(objp == ZERO_SIZE_PTR))
-		return 0;
-
-	c = virt_to_cache(objp);
-	size = c ? c->object_size : 0;
-
-	return size;
-}
-EXPORT_SYMBOL(__ksize);
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 23f2ab0713b7..488997db0d97 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1245,6 +1245,35 @@ void kfree_sensitive(const void *p)
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
+#ifdef CONFIG_SLUB
+	if (unlikely(!folio_test_slab(folio)))
+		return folio_size(folio);
+#endif
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
index 261474092e43..3a4458976ab7 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4526,22 +4526,6 @@ void __check_heap_object(const void *ptr, unsigned long n,
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

