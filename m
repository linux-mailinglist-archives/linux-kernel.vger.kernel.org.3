Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7335633CA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 14:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiGAMzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 08:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236227AbiGAMyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 08:54:43 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D493AA79;
        Fri,  1 Jul 2022 05:54:42 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 2so4111705qvc.0;
        Fri, 01 Jul 2022 05:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Gf0HCV+B4rZrfJAP5Zzmb/SkEYLt2rvf4yUabNLaBM=;
        b=m3gzMyaX9F96et1o8wS9j16V2SjRTjHJI5dhb2wg/ahdsdNWOvWCjNETS07Atq8YSZ
         NCEMufsi5CUvVxRdlOBBHoBsJ+AclOhKsErjlEIbR0thodZH+OTFFxsLate0HeHdmUy9
         OXvJjC27aukUSgFVM4vv/MwcxF3jVfgbHAAgEOq9hjI+XeygOokAGfg4pSoA+lHmzVSm
         noCvYgAWh2RfNQxyTN049m7pZE5GQGDVmU+0vL0yVl3lETfS8kJbvSsMVsXd5j9dWUJ1
         Sxnake72rCg2Icjcrtq4sdayDe9wTuDv6bTLViCCmwLNo7VQiPeo7yeryEV6tTk+WRP8
         6Vmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Gf0HCV+B4rZrfJAP5Zzmb/SkEYLt2rvf4yUabNLaBM=;
        b=XsdMYDn3SrvmQD6NN+kwRUia8CTK8c7CBsGM9Nu8kgBoUTovjexbzmFrfBiUOzUihW
         kmvr/0eU7OF/O99lS9c/iqx9hnZcL7s3/7dF/c5K1lphHX7u/4XlkCjhS5Sej9qZ0Mj5
         NuRDzOLBDpHEuaK5MTgHvhuqoRtrMlACkkFQeNfPbifsDYPlKYmZM982KANod8Te2r6M
         jRdD4VLy5YMY6nPp/S4dOq93ZFJBOJholN396YPshUr7SjQ00DXc+LVwIDAAlwjT/S6s
         PxR0LhWN3GUvjvNYMURYH6QJ2f94+KHL04sFb2IYWkuikpO9NRCzJ1SFk/j+qp1XrHrm
         GRCQ==
X-Gm-Message-State: AJIora8IgWYWce6WIP2FLMYVvBhFNsnSUP39V0a8JCQcyoStnLSHwiDG
        2MWmFwr7RQ6lOITPv/c1mAGmi85r1N0=
X-Google-Smtp-Source: AGRyM1ssrxAWIQQigtyIX+ADjOkwuYwaxPAK62qYcGGaz4u/H2t0ROYqO9PWoZpEzilBKv8ddLPPIg==
X-Received: by 2002:a0c:c68a:0:b0:46b:8e6b:306 with SMTP id d10-20020a0cc68a000000b0046b8e6b0306mr17084010qvj.7.1656680082228;
        Fri, 01 Jul 2022 05:54:42 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:f902:9816:653f:2f66])
        by smtp.gmail.com with ESMTPSA id t18-20020ac86a12000000b00304bbcc1b8asm14228141qtr.28.2022.07.01.05.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 05:54:41 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        NeilBrown <neilb@suse.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Russell King <linux@armlinux.org.uk>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 8/8] lib/cpumask: move some one-line wrappers to header file
Date:   Fri,  1 Jul 2022 05:54:30 -0700
Message-Id: <20220701125430.2907638-9-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220701125430.2907638-1-yury.norov@gmail.com>
References: <20220701125430.2907638-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After moving gfp flags to a separate header, it's possible to move some
cpumask allocators into headers, and avoid creating real functions.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---

After this patch, only alloc/free functions are still in c-file, because
moving them causes multiple circular dependencies between mm and
cpumask. I'll get back later to it.

 include/linux/cpumask.h | 34 +++++++++++++++++++++++++++++++---
 lib/cpumask.c           | 28 ----------------------------
 2 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index ea3de2c2c180..0738a6c9be40 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -12,6 +12,8 @@
 #include <linux/bitmap.h>
 #include <linux/atomic.h>
 #include <linux/bug.h>
+#include <linux/gfp_flags.h>
+#include <linux/numa.h>
 
 /* Don't assign or return these: may not be this big! */
 typedef struct cpumask { DECLARE_BITMAP(bits, NR_CPUS); } cpumask_t;
@@ -794,9 +796,35 @@ typedef struct cpumask *cpumask_var_t;
 #define __cpumask_var_read_mostly	__read_mostly
 
 bool alloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags, int node);
-bool alloc_cpumask_var(cpumask_var_t *mask, gfp_t flags);
-bool zalloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags, int node);
-bool zalloc_cpumask_var(cpumask_var_t *mask, gfp_t flags);
+
+static inline
+bool zalloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags, int node)
+{
+	return alloc_cpumask_var_node(mask, flags | __GFP_ZERO, node);
+}
+
+/**
+ * alloc_cpumask_var - allocate a struct cpumask
+ * @mask: pointer to cpumask_var_t where the cpumask is returned
+ * @flags: GFP_ flags
+ *
+ * Only defined when CONFIG_CPUMASK_OFFSTACK=y, otherwise is
+ * a nop returning a constant 1 (in <linux/cpumask.h>).
+ *
+ * See alloc_cpumask_var_node.
+ */
+static inline
+bool alloc_cpumask_var(cpumask_var_t *mask, gfp_t flags)
+{
+	return alloc_cpumask_var_node(mask, flags, NUMA_NO_NODE);
+}
+
+static inline
+bool zalloc_cpumask_var(cpumask_var_t *mask, gfp_t flags)
+{
+	return alloc_cpumask_var(mask, flags | __GFP_ZERO);
+}
+
 void alloc_bootmem_cpumask_var(cpumask_var_t *mask);
 void free_cpumask_var(cpumask_var_t mask);
 void free_bootmem_cpumask_var(cpumask_var_t mask);
diff --git a/lib/cpumask.c b/lib/cpumask.c
index cb7262ff8633..f0ae119be8c4 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -70,34 +70,6 @@ bool alloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags, int node)
 }
 EXPORT_SYMBOL(alloc_cpumask_var_node);
 
-bool zalloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags, int node)
-{
-	return alloc_cpumask_var_node(mask, flags | __GFP_ZERO, node);
-}
-EXPORT_SYMBOL(zalloc_cpumask_var_node);
-
-/**
- * alloc_cpumask_var - allocate a struct cpumask
- * @mask: pointer to cpumask_var_t where the cpumask is returned
- * @flags: GFP_ flags
- *
- * Only defined when CONFIG_CPUMASK_OFFSTACK=y, otherwise is
- * a nop returning a constant 1 (in <linux/cpumask.h>).
- *
- * See alloc_cpumask_var_node.
- */
-bool alloc_cpumask_var(cpumask_var_t *mask, gfp_t flags)
-{
-	return alloc_cpumask_var_node(mask, flags, NUMA_NO_NODE);
-}
-EXPORT_SYMBOL(alloc_cpumask_var);
-
-bool zalloc_cpumask_var(cpumask_var_t *mask, gfp_t flags)
-{
-	return alloc_cpumask_var(mask, flags | __GFP_ZERO);
-}
-EXPORT_SYMBOL(zalloc_cpumask_var);
-
 /**
  * alloc_bootmem_cpumask_var - allocate a struct cpumask from the bootmem arena.
  * @mask: pointer to cpumask_var_t where the cpumask is returned
-- 
2.34.1

