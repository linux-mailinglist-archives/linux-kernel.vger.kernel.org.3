Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84C45A7468
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 05:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiHaDVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 23:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbiHaDUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 23:20:30 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9D41DA4F
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 20:20:13 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id c66so2947407pfc.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 20:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=im3YqRL2Rng/LKklgBeywc8L3p9g3oy/mXuP77cK8zU=;
        b=RD4nDOqLlkuwwB2t022lPA2anuLlf/CAS8a53Uv3i/r5QGL9l4YCtb8ZIiMBG7hbJC
         guoomosMxuYuN8jO6yVhowNvNsVavr98McnRWRcR5PVm8BYcH/KDGlV03enHRsETKqdN
         RXQKdUc/lvnulb44PzME6KYSESUO3mj/jRRKKZ+hOecySABPTqTrzlN6ah9eCr7yRUbS
         rjjh7Pmwpe0t+OMAT8XqcZDkDWbhDpmfXa2MFKhcLexZBRe76Jmz51AIvWELchSaNWUV
         LVgK/Y0PlNXGer69Rht7WgMzdbG9dlBLhwiFMBj/HMyH7wQN3BH5WnmbOS4U1Ucpon68
         uxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=im3YqRL2Rng/LKklgBeywc8L3p9g3oy/mXuP77cK8zU=;
        b=t9Wp1QLVcCz4dD3MHcEcRwyD8y1CIAB8HZKfWpaGWt3wSbjVmG9u2BTbcWOJ68I1v5
         Ez5OLYezrrOZ8aT9rwb1FL5pLk8aAuUUj6dVsjEgcPaSudz4HMAik/7jPz6chPh7HRqU
         ogjV/h4/9qvYQjATRJBEOEZ7QJNPx0qPEXb9nGPAKxLecfocN64h5N9dERKe9lb0O2Cw
         qydnURSInx46D+IzBjgviPDgE0pjvhs9+iBcqdsrDNNZQd0GrjvwIASwBJswRh4+Ua7l
         kV6nH3gFA7L2L4xbXRGuXEJwNo8DEZf/HH7ygynGv7+gyrvusIWqB0ZGrpyR8mufn1J9
         SP+g==
X-Gm-Message-State: ACgBeo3pwHVmurdXFo5TH/Hs94F9hR2WqGA/Anc53jxtgr+31ouxGsuA
        zaf3dwBngW7pmfLjGbRmxcVMUA==
X-Google-Smtp-Source: AA6agR6oR5JRUz8+cD5CEEtVrrOhgd1Fo8O/zVTIvVDMVu9FdFzHaITegImRSaKYL7R1u+K2Ofk0/A==
X-Received: by 2002:a65:6417:0:b0:42b:2f13:8477 with SMTP id a23-20020a656417000000b0042b2f138477mr20270294pgv.329.1661916012858;
        Tue, 30 Aug 2022 20:20:12 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id i13-20020a170902c94d00b0015e8d4eb1d5sm8633535pla.31.2022.08.30.20.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 20:20:12 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, shy828301@gmail.com,
        willy@infradead.org, vbabka@suse.cz, hannes@cmpxchg.org,
        minchan@kernel.org, rppt@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 1/7] mm: introduce common struct mm_slot
Date:   Wed, 31 Aug 2022 11:19:45 +0800
Message-Id: <20220831031951.43152-2-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220831031951.43152-1-zhengqi.arch@bytedance.com>
References: <20220831031951.43152-1-zhengqi.arch@bytedance.com>
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
index 000000000000..83f18ed1c4bd
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
+static inline void *mm_slot_alloc(struct kmem_cache *cache)
+{
+	if (!cache)	/* initialization failed */
+		return NULL;
+	return kmem_cache_zalloc(cache, GFP_KERNEL);
+}
+
+static inline void mm_slot_free(struct kmem_cache *cache, void *objp)
+{
+	kmem_cache_free(cache, objp);
+}
+
+#define mm_slot_lookup(_hashtable, _mm) 				       \
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
+#define mm_slot_insert(_hashtable, _mm, _mm_slot)			       \
+({									       \
+	_mm_slot->mm = _mm;						       \
+	hash_add(_hashtable, &_mm_slot->hash, (unsigned long)_mm);	       \
+})
+
+#endif /* _LINUX_MM_SLOT_H */
-- 
2.20.1

