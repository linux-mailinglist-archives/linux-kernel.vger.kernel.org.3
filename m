Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930AF53C378
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 05:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237485AbiFCDyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 23:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235311AbiFCDy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 23:54:28 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20E5313AE
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 20:54:26 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id z17so6301941pff.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 20:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AE33Ihqv1t9aLq7UPLG/US1ju2jh1U/6t4mE/T1uzCg=;
        b=O+PNjUduciX7Xx08NHo//9gZ1MAEWBk7QW4BZVAqte9EfoplTolcAt+C4rlOHX5Y7s
         XpVXx6r7vudrBQucENUyiRG9cLbeMhQSpAdY9AgLB0F5sPYCGcLVM4Y/wLLz8rAZWtXi
         9HjRYy00A3RgYoP6Pe3jIAc4UOWe9+8jDWcFlPjrf8P0OZQOdcx/Bq2Sm1lb1xfnPRDw
         CxkUOpF30dsuRuMIerewZZj3TdikR2r1SdQqI6DBsY1ogN5ZJIlQO2QRdpehdy1M+9f3
         iHYnrtfvugrsRyx1qI0D+fnq3WYXzcDJ0Im55sARe2ngvOex1lZ9ciCymoWdgrvHRCaK
         hQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AE33Ihqv1t9aLq7UPLG/US1ju2jh1U/6t4mE/T1uzCg=;
        b=XcSHhyeVMteJKbqX3fnFYY5VRX7lLz4vF07WOrW9k4pLFOuDscdnEVIYacm3Vlxd8f
         TcryVsPJhAwTI41hJKaPt9FT+AiHszqgKcvBg5UkSp73s2+5gHiI7ULDx/YuUem/TKO9
         G/Fw7rAIOdHJGKaxxKjALHMS5Zv8PafGPfr3F4g7A+46LXr3lREpj7Limq7CcnQnK4Wx
         m9pkeTL7JwwBgwZ8/UNO04b2w95XuZlJKd6nC3fAHw4rMgxfsVvtTf/s/pUuNmazHoIr
         OSvsUi4J2aiP0ZxTDZVo+NqmaeJYCxHSFo4lKJgC+SaRsmh7i62ztEg4/z3DKgDkIIhY
         SDRA==
X-Gm-Message-State: AOAM530+OWYdEgj8VvqHknM8Rwd+aCP87HJytWy0pEXRge86nmV4lEst
        Ovc1mUApZUDftjkFD5/BOU8=
X-Google-Smtp-Source: ABdhPJzWnPOllcltScI/t1jtuBfhDPeuf9KuowCerL9DyIRZH7cGHTf3p+2+jOgVwDd3tiwi8WffoQ==
X-Received: by 2002:a62:7cca:0:b0:4fd:e594:fac0 with SMTP id x193-20020a627cca000000b004fde594fac0mr8389022pfc.79.1654228466183;
        Thu, 02 Jun 2022 20:54:26 -0700 (PDT)
Received: from localhost ([101.86.206.159])
        by smtp.gmail.com with ESMTPSA id 4-20020a631744000000b003fbdf7cc750sm4069329pgx.89.2022.06.02.20.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 20:54:25 -0700 (PDT)
From:   Patrick Wang <patrick.wang.shcn@gmail.com>
To:     catalin.marinas@arm.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yee.lee@mediatek.com, patrick.wang.shcn@gmail.com
Subject: [PATCH v2 1/4] mm: kmemleak: add OBJECT_PHYS flag for objects allocated with physical address
Date:   Fri,  3 Jun 2022 11:54:12 +0800
Message-Id: <20220603035415.1243913-2-patrick.wang.shcn@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220603035415.1243913-1-patrick.wang.shcn@gmail.com>
References: <20220603035415.1243913-1-patrick.wang.shcn@gmail.com>
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

Add OBJECT_PHYS flag for object. This flag is used
to identify the objects allocated with physical
address.The create_object() function is added an
argument to set that flag.

Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Patrick Wang <patrick.wang.shcn@gmail.com>
---
 mm/kmemleak.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index a182f5ddaf68..1e9e0aa93ae5 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -172,6 +172,8 @@ struct kmemleak_object {
 #define OBJECT_NO_SCAN		(1 << 2)
 /* flag set to fully scan the object when scan_area allocation failed */
 #define OBJECT_FULL_SCAN	(1 << 3)
+/* flag set for object allocated with physical address */
+#define OBJECT_PHYS		(1 << 4)
 
 #define HEX_PREFIX		"    "
 /* number of bytes to print per line; must be 16 or 32 */
@@ -575,7 +577,8 @@ static int __save_stack_trace(unsigned long *trace)
  * memory block and add it to the object_list and object_tree_root.
  */
 static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
-					     int min_count, gfp_t gfp)
+					     int min_count, gfp_t gfp,
+					     bool is_phys)
 {
 	unsigned long flags;
 	struct kmemleak_object *object, *parent;
@@ -595,7 +598,7 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
 	INIT_HLIST_HEAD(&object->area_list);
 	raw_spin_lock_init(&object->lock);
 	atomic_set(&object->use_count, 1);
-	object->flags = OBJECT_ALLOCATED;
+	object->flags = OBJECT_ALLOCATED | (is_phys ? OBJECT_PHYS : 0);
 	object->pointer = ptr;
 	object->size = kfence_ksize((void *)ptr) ?: size;
 	object->excess_ref = 0;
@@ -729,10 +732,10 @@ static void delete_object_part(unsigned long ptr, size_t size)
 	end = object->pointer + object->size;
 	if (ptr > start)
 		create_object(start, ptr - start, object->min_count,
-			      GFP_KERNEL);
+			      GFP_KERNEL, object->flags & OBJECT_PHYS);
 	if (ptr + size < end)
 		create_object(ptr + size, end - ptr - size, object->min_count,
-			      GFP_KERNEL);
+			      GFP_KERNEL, object->flags & OBJECT_PHYS);
 
 	__delete_object(object);
 }
@@ -904,7 +907,7 @@ void __ref kmemleak_alloc(const void *ptr, size_t size, int min_count,
 	pr_debug("%s(0x%p, %zu, %d)\n", __func__, ptr, size, min_count);
 
 	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
-		create_object((unsigned long)ptr, size, min_count, gfp);
+		create_object((unsigned long)ptr, size, min_count, gfp, false);
 }
 EXPORT_SYMBOL_GPL(kmemleak_alloc);
 
@@ -931,7 +934,7 @@ void __ref kmemleak_alloc_percpu(const void __percpu *ptr, size_t size,
 	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
 		for_each_possible_cpu(cpu)
 			create_object((unsigned long)per_cpu_ptr(ptr, cpu),
-				      size, 0, gfp);
+				      size, 0, gfp, false);
 }
 EXPORT_SYMBOL_GPL(kmemleak_alloc_percpu);
 
@@ -953,7 +956,7 @@ void __ref kmemleak_vmalloc(const struct vm_struct *area, size_t size, gfp_t gfp
 	 * the virtual address of the vmalloc'ed block.
 	 */
 	if (kmemleak_enabled) {
-		create_object((unsigned long)area->addr, size, 2, gfp);
+		create_object((unsigned long)area->addr, size, 2, gfp, false);
 		object_set_excess_ref((unsigned long)area,
 				      (unsigned long)area->addr);
 	}
@@ -1966,14 +1969,14 @@ void __init kmemleak_init(void)
 
 	/* register the data/bss sections */
 	create_object((unsigned long)_sdata, _edata - _sdata,
-		      KMEMLEAK_GREY, GFP_ATOMIC);
+		      KMEMLEAK_GREY, GFP_ATOMIC, false);
 	create_object((unsigned long)__bss_start, __bss_stop - __bss_start,
-		      KMEMLEAK_GREY, GFP_ATOMIC);
+		      KMEMLEAK_GREY, GFP_ATOMIC, false);
 	/* only register .data..ro_after_init if not within .data */
 	if (&__start_ro_after_init < &_sdata || &__end_ro_after_init > &_edata)
 		create_object((unsigned long)__start_ro_after_init,
 			      __end_ro_after_init - __start_ro_after_init,
-			      KMEMLEAK_GREY, GFP_ATOMIC);
+			      KMEMLEAK_GREY, GFP_ATOMIC, false);
 }
 
 /*
-- 
2.25.1

