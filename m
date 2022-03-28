Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A65A4E982D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 15:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243233AbiC1Nal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 09:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243213AbiC1Naf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 09:30:35 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11D3260B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 06:28:54 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id gb19so14065696pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 06:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OWWkThZzG6fg+LvXYQeO6VrIXNOo2Za760j3Jl9Casc=;
        b=YJ+SNrGdPbhG4Hdu+QgUc3szEdJT3mDr8DxEK55+jCssVQl5LAtgnqYl7dDc1hxx72
         E01D4AiZLzZjp8GCBW3fvMPVo0flIAsxQ/LH8AjMkw9afKRmTc5WhcMNdkNW7c5/sd8w
         BOWWAMUa0AFgyRoyUFLqveHBP0coEgUWNmOBkn5B2gmGQRrEu2Us0wH4BKWuv8nVrq6S
         5mX+2jjqLhUod3xvd9gE2n8ysUQNlUL7CHZTWe+hEyYCscxyojVix5wFhpp9MLV/4WfH
         2TebjWFsXuUYPDzXlT0BKuPF9e/dGp729BwpG1QBuVcNW6IfOd2EjChUbsyi+gvMsXv9
         dwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OWWkThZzG6fg+LvXYQeO6VrIXNOo2Za760j3Jl9Casc=;
        b=ylncudV9PDPaqX/k/mRdrAY3kkgcGphzsYn2ppkp54gLrAzlZthdI7wOVU+c81chR9
         d1TzBLT1eGnrjlUU2IE8riDmVRskKDrW/jmxmwQ+Yp06F90Vm32t8T9+FulEjrF4AeEd
         p7ZOQTpfjBr6xxHhiy3hfOocE3/ZNWjLrFIDcjUw6lO/uLpRLLO3THAN6tctOSPicP0y
         JK8D4M+GHupdUoCmu0wkI0p2XEBpPcabUecQx3cb3yNRB3vjCBNvtXrhXRfnuBKnFuwv
         fFHy7Vv0lz9BTbW6db1cDYy6ATeJdsVKyxiuP3S0QixHyzmXLwNvju8Pph6PFGWctyf2
         c9bg==
X-Gm-Message-State: AOAM533qRmf92pJKB+qMPDEg/+g+/qrjXe/66SLwN07yDwD4KQHNlWEf
        lo8Asg79N0DA0ObAacfQ2DDzlA==
X-Google-Smtp-Source: ABdhPJzAlGHI/Kia99wHVmm5tvWLa5lQ97WbqD5zyvwlynxzhx1bxi7GFshiphoDnCUj+TsAFpBliA==
X-Received: by 2002:a17:902:d48e:b0:154:b6a:9ff with SMTP id c14-20020a170902d48e00b001540b6a09ffmr26164352plg.2.1648474134256;
        Mon, 28 Mar 2022 06:28:54 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id m7-20020a056a00080700b004fb28fafc4csm9980936pfk.97.2022.03.28.06.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 06:28:54 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     glider@google.com, elver@google.com, dvyukov@google.com,
        akpm@linux-foundation.org
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2] mm: kfence: fix objcgs vector allocation
Date:   Mon, 28 Mar 2022 21:28:43 +0800
Message-Id: <20220328132843.16624-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the kfence object is allocated to be used for objects vector, then
this slot of the pool eventually being occupied permanently since
the vector is never freed.  The solutions could be 1) freeing vector
when the kfence object is freed or 2) allocating all vectors statically.
Since the memory consumption of object vectors is low, it is better to
chose 2) to fix the issue and it is also can reduce overhead of vectors
allocating in the future.

Fixes: d3fb45f370d9 ("mm, kfence: insert KFENCE hooks for SLAB")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
v2:
 - Fix compiler error reported by kernel test robot <lkp@intel.com>.

 mm/kfence/core.c   | 11 ++++++++++-
 mm/kfence/kfence.h |  3 +++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 13128fa13062..d4c7978cd75e 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -555,6 +555,8 @@ static bool __init kfence_init_pool(void)
 	 * enters __slab_free() slow-path.
 	 */
 	for (i = 0; i < KFENCE_POOL_SIZE / PAGE_SIZE; i++) {
+		struct slab *slab = page_slab(&pages[i]);
+
 		if (!i || (i % 2))
 			continue;
 
@@ -562,7 +564,11 @@ static bool __init kfence_init_pool(void)
 		if (WARN_ON(compound_head(&pages[i]) != &pages[i]))
 			goto err;
 
-		__SetPageSlab(&pages[i]);
+		__folio_set_slab(slab_folio(slab));
+#ifdef CONFIG_MEMCG
+		slab->memcg_data = (unsigned long)&kfence_metadata[i / 2 - 1].objcg |
+				   MEMCG_DATA_OBJCGS;
+#endif
 	}
 
 	/*
@@ -938,6 +944,9 @@ void __kfence_free(void *addr)
 {
 	struct kfence_metadata *meta = addr_to_metadata((unsigned long)addr);
 
+#ifdef CONFIG_MEMCG
+	KFENCE_WARN_ON(meta->objcg);
+#endif
 	/*
 	 * If the objects of the cache are SLAB_TYPESAFE_BY_RCU, defer freeing
 	 * the object, as the object page may be recycled for other-typed
diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
index 2a2d5de9d379..9a6c4b1b12a8 100644
--- a/mm/kfence/kfence.h
+++ b/mm/kfence/kfence.h
@@ -89,6 +89,9 @@ struct kfence_metadata {
 	struct kfence_track free_track;
 	/* For updating alloc_covered on frees. */
 	u32 alloc_stack_hash;
+#ifdef CONFIG_MEMCG
+	struct obj_cgroup *objcg;
+#endif
 };
 
 extern struct kfence_metadata kfence_metadata[CONFIG_KFENCE_NUM_OBJECTS];
-- 
2.11.0

