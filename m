Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19D65A4F4C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 16:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiH2OcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 10:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiH2OcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:32:12 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E4D8FD64
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 07:32:11 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id n65-20020a17090a5ac700b001fbb4fad865so8769523pji.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 07:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=OFwhHEGLumljaGedgUfodOQy4osJq+5CQC+cBVTf1a4=;
        b=IyANSXDIAVHdIMw1AI5TuvYNtfpaV67Jl260Y8+xMVdhjfSQFLTpLP4MgpOHqiy9SK
         9UxJgUWjEjQAlh+KPBKpprPGSX21a88KTE3kn277BqYoVa6PgOUU6ReEZuIVulrm6bxV
         vZQbzD0Pa0jmvB4i8qDW4eYpd+LIPrBGTmfp+Tr6/1YfO4EOhzJSiEGnodgLaHizmu/e
         ZXK013ge40Yel978YJferBVAGCxaaVgpoFrXoVmdrIq7bb7vgL4oJeU3UOkfoMFNiVwY
         Rr90j8t2/o/Ns13DeCGEmlygJOc8ppDUKb61SG5SjFjEQ/rIjAk0va7BnB4cvxfLmW3u
         Thow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=OFwhHEGLumljaGedgUfodOQy4osJq+5CQC+cBVTf1a4=;
        b=X3p6nBqZ5v54CFMy0ZFvm6k0UfxIf07Vod7AMbyA5mqGlhW5cPtHjnF38MKDv7AGuM
         5fDLLFVr4c1ef4OUn4lZECC8YyXoQdlV6+sW59qCZN4z4XrBJNYpS0pyB8W9wtIfmIiR
         wV03QfdsMGFd7SXaHGPBnwABgOALkgrXWVVyQu9+ktZxmhhx5Zn1mGO5ryXtabFPatok
         umK1xDCwX+SHk73TeFu2UlHqYEsnXUHj+OgqlA/DUr13T9jH9XaxZrXCJFG/wPR5M0DU
         g8lIspE7+JH+0olMZEZ1KzE5yL04ripLlyTybC/uJSGkaU9j5PNiGGwOso8K94xayNLj
         ivDA==
X-Gm-Message-State: ACgBeo22I+L1+SJHx4GvjBjB0NG/civlUq/k9nL7BkuM1ArymtPC7rMn
        uTNM+bwCRzJJS0ahwJmYwRk18Q==
X-Google-Smtp-Source: AA6agR4kA8oyWWsZADmLylrRqrO+nQc/O3q31TITs1nYQy2t9TZrz7GEy7Vh87+LW0Y0vsMXeeg9sg==
X-Received: by 2002:a17:902:7087:b0:173:2a01:9ddb with SMTP id z7-20020a170902708700b001732a019ddbmr16425709plk.109.1661783531249;
        Mon, 29 Aug 2022 07:32:11 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id x128-20020a626386000000b0052d200c8040sm7259327pfb.211.2022.08.29.07.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 07:32:10 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, willy@infradead.org, vbabka@suse.cz,
        hannes@cmpxchg.org, minchan@kernel.org, rppt@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 1/7] mm: introduce common struct mm_slot
Date:   Mon, 29 Aug 2022 22:30:49 +0800
Message-Id: <20220829143055.41201-2-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220829143055.41201-1-zhengqi.arch@bytedance.com>
References: <20220829143055.41201-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At present, both THP and KSM module have similar structures
mm_slot for organizing and recording the information required
for scanning mm, and each defines the following exactly the
same operation functions:

 - alloc_mm_slot
 - free_mm_slot
 - get_mm_slot
 - insert_to_mm_slots_hash

In order to de-duplicate these codes, this patch introduces a
common struct mm_slot, and subsequent patches will let THP and
KSM to use it.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/mm_slot.h | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 mm/mm_slot.h

diff --git a/mm/mm_slot.h b/mm/mm_slot.h
new file mode 100644
index 000000000000..c8f0d26ef7b0
--- /dev/null
+++ b/mm/mm_slot.h
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef _LINUX_MM_SLOT_H
+#define _LINUX_MM_SLOT_H
+
+#include <linux/hashtable.h>
+#include <linux/slab.h>
+
+/*
+ * struct mm_slot - hash lookup from mm to mm_slot
+ * @hash: link to the mm_slots hash list
+ * @mm_node: link into the mm_slots list
+ * @mm: the mm that this information is valid for
+ */
+struct mm_slot {
+	struct hlist_node hash;
+	struct list_head mm_node;
+	struct mm_struct *mm;
+};
+
+#define mm_slot_entry(ptr, type, member) \
+	container_of(ptr, type, member)
+
+static inline void *alloc_mm_slot(struct kmem_cache *cache)
+{
+	if (!cache)	/* initialization failed */
+		return NULL;
+	return kmem_cache_zalloc(cache, GFP_KERNEL);
+}
+
+static inline void free_mm_slot(struct kmem_cache *cache, void *objp)
+{
+	kmem_cache_free(cache, objp);
+}
+
+#define get_mm_slot(_hashtable, _mm)					       \
+({									       \
+	struct mm_slot *tmp_slot, *mm_slot = NULL;			       \
+									       \
+	hash_for_each_possible(_hashtable, tmp_slot, hash, (unsigned long)_mm) \
+		if (_mm == tmp_slot->mm) {				       \
+			mm_slot = tmp_slot;				       \
+			break;						       \
+		}							       \
+									       \
+	mm_slot;							       \
+})
+
+#define insert_to_mm_slots_hash(_hashtable, _mm, _mm_slot)		       \
+({									       \
+	_mm_slot->mm = _mm;						       \
+	hash_add(_hashtable, &_mm_slot->hash, (unsigned long)_mm);	       \
+})
+
+#endif /* _LINUX_MM_SLOT_H */
-- 
2.20.1

