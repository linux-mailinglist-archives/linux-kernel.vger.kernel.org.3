Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D705690EB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 19:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbiGFRnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 13:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbiGFRnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 13:43:17 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1B02AC7B;
        Wed,  6 Jul 2022 10:43:09 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id g14so19280087qto.9;
        Wed, 06 Jul 2022 10:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yfeDuyRYNoVK5OuNHYtPJI0+qGNG77BF8q+9jUECqCA=;
        b=k+hw5BFlf7mL7dQoYsqsOVto8IsXSzSQEDJE/tC5hTf1lqeb3BMECvvjJCW6bwePV1
         ckL/HbfUQC5aWcsdRq9+Q49oKYYnRnxKhZvHOnI2vBvNzs1mcXZGcIe9/pY8KerEmTCE
         Cl3SwHrWiru7RFqlHB6bItSpCSENPIVaLiVrPMha3FjFswNagqp9KsYtv5Q7z57nlCHM
         Km4CpS4NBXzO4cGWIgxODzB3vaadiNCjFi7jBEHIV3XpOdlx2CtCrwUpn8ttbtT//C6l
         7Xw3+indiZaDKs3WYOy7bUugUGAuZodOL+uvzYv1DU8OYoClITXJPknBdYJOjfWMqv1J
         gybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yfeDuyRYNoVK5OuNHYtPJI0+qGNG77BF8q+9jUECqCA=;
        b=zeQqGn0jGSNZZLPOLKHEs61UzlEwK4RXXR2g6V4eIY86x31v5l2M79zvy/acXZ8DV4
         onMaHQDB+A8ZJgHQxTs+29N51oZkscDtVFbpzyH0lM9ehoNWGBiduxHfNcFOqjJ6xxMv
         //YCmsSyxhpkwHti5s8NCP+LHS9x+J3v4IpRCcA10vqzN2rGdJYOhqyYmBD4Ikd+1E5Q
         OmGdt83QlCr46cIMyH9FArk6JZHg2ErMIB/kreo5LqNZs+9NufR7X5RhugkCWvpjoGUL
         42q41hBTyrIYIU9GZ2LrNoe6Jpt6UQTRQTal/cRF1d1VbPS/Kyw1eY0yzLnxOubPerk3
         o+dA==
X-Gm-Message-State: AJIora8jPOldvlRlj3dqCzvb5LLZRBlzz4TYq4Iu9LG0NV/a6hakRG5d
        f7wBc10piZWPuQpJFRpgXtJTq2uACIOcxQ==
X-Google-Smtp-Source: AGRyM1seazjmesyL9M4iNmZaGp7i7fIpXiCBQjdNbxLsOqkRBXmMNAquyaefluz7IpklOU2eeireYw==
X-Received: by 2002:a05:622a:1983:b0:31b:f165:8538 with SMTP id u3-20020a05622a198300b0031bf1658538mr33409402qtc.358.1657129388361;
        Wed, 06 Jul 2022 10:43:08 -0700 (PDT)
Received: from localhost (c-69-254-185-160.hsd1.ar.comcast.net. [69.254.185.160])
        by smtp.gmail.com with ESMTPSA id v18-20020a05620a441200b006a701d8a43bsm24772765qkp.79.2022.07.06.10.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 10:43:08 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
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
Subject: [PATCH 10/10] lib/cpumask: move some one-line wrappers to header file
Date:   Wed,  6 Jul 2022 10:42:53 -0700
Message-Id: <20220706174253.4175492-11-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220706174253.4175492-1-yury.norov@gmail.com>
References: <20220706174253.4175492-1-yury.norov@gmail.com>
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
 include/linux/cpumask.h | 34 +++++++++++++++++++++++++++++++---
 lib/cpumask.c           | 28 ----------------------------
 2 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index ea3de2c2c180..80627362c774 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -12,6 +12,8 @@
 #include <linux/bitmap.h>
 #include <linux/atomic.h>
 #include <linux/bug.h>
+#include <linux/gfp_types.h>
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

