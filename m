Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB2253C375
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 05:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238517AbiFCDy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 23:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236612AbiFCDyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 23:54:39 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C354E31DD6
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 20:54:35 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id q12-20020a17090a304c00b001e2d4fb0eb4so11133778pjl.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 20:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gDxq5rt5EfBvQEGX/JbF39Xsu3MLwHYHF4domviF5Aw=;
        b=ZcAWiVl5MNXHqF9gqoBMhVMeSBj8YV7gkiqwngFfitNG69DQnL05R75t16nEkhz4EG
         Qf5CF1hphATAOuY2icg7qLXEdZ1jq64mvXSbGdqtF2l1Zk9Xfe/lrOvmgA+i4d9RC8ba
         m+zdi3W3znACUwxWTUhycqt5Jcl0SO3JvTBq/F08392xPXx29tUknHvi/AC0bvpCVDZ5
         zRuCBlExCz83+x29q8fnoTokJShnTZbCUVYjdO7/SgFwlZKawpOP7bcDiQ6R/8qwX9Zo
         Qr6EyW7MdBZj+2wK0qqxR3ZGmJNc604K8EqLHvXLztZk+PYSx3SWFkbr5Sjy6XMMu7sT
         ehfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gDxq5rt5EfBvQEGX/JbF39Xsu3MLwHYHF4domviF5Aw=;
        b=EbDl2bl2lSJw8WYaxhVEbO7C1SZWgMgMQXWOC5RzmHRfE34zHkkrV3WhGXV4Nrv9j8
         qAHR+P1/HiA7l8kQc8+yWUqi/E8qXKDUyYf19RbKBRvzgPgu7Nqs7kwk4+xsCd5J5sR1
         cekJfP3hqmCTlc45BAW9o5Pqvv+a05eavBT5ZqHsxyUOlE9vTK0qwq1jwfya89WfBVHq
         CRnUbF+Af6Qbw/fmsKQ6ybpAkr4ah+veB+5cd2ZodQeFXLewa9NcKxoY26In1AbOZbxM
         0JBWuiYhDw1mnW0A+eNfAqglKTZTegWHMUAumwK5AnG7UqCSla+9xt8TA//ZVZCLiJoh
         bzgA==
X-Gm-Message-State: AOAM5303xJbDm9Ns6dvZRyd/l8VACAEyp5/nn1kwxariNZ+3zWnnVeEb
        pjNOEIAvZ8xR+AhQlpsYYus=
X-Google-Smtp-Source: ABdhPJyakeYteI7Y7hTx45KhYNBoAbLV1IEg+M8GI7pdT6/wyhfrtWQm941y/qg3ytvpVGlkGNVsTw==
X-Received: by 2002:a17:903:120f:b0:15f:99f:9597 with SMTP id l15-20020a170903120f00b0015f099f9597mr8133275plh.45.1654228475075;
        Thu, 02 Jun 2022 20:54:35 -0700 (PDT)
Received: from localhost ([101.86.206.159])
        by smtp.gmail.com with ESMTPSA id a4-20020a1709027e4400b00163ac8673edsm4274072pln.35.2022.06.02.20.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 20:54:34 -0700 (PDT)
From:   Patrick Wang <patrick.wang.shcn@gmail.com>
To:     catalin.marinas@arm.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yee.lee@mediatek.com, patrick.wang.shcn@gmail.com
Subject: [PATCH v2 4/4] mm: kmemleak: kmemleak_*_phys() set address type and check PA when scan
Date:   Fri,  3 Jun 2022 11:54:15 +0800
Message-Id: <20220603035415.1243913-5-patrick.wang.shcn@gmail.com>
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

The kmemleak_*_phys() functions call next level interface
by setting address type to physical. And the physical address
of objects will be checked for its boundary when scan instead
of in kmemleak_*_phys().

Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Patrick Wang <patrick.wang.shcn@gmail.com>
---
 mm/kmemleak.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 246a70b7218f..62d1ad8f8a44 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1156,8 +1156,12 @@ EXPORT_SYMBOL(kmemleak_no_scan);
 void __ref kmemleak_alloc_phys(phys_addr_t phys, size_t size, int min_count,
 			       gfp_t gfp)
 {
-	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
-		kmemleak_alloc(__va(phys), size, min_count, gfp);
+	pr_debug("%s(0x%pa, %zu, %d)\n", __func__, &phys, size, min_count);
+
+	if (kmemleak_enabled && !min_count)
+		/* create object with OBJECT_PHYS flag */
+		create_object((unsigned long)phys, size, min_count,
+			      gfp, true);
 }
 EXPORT_SYMBOL(kmemleak_alloc_phys);
 
@@ -1170,8 +1174,10 @@ EXPORT_SYMBOL(kmemleak_alloc_phys);
  */
 void __ref kmemleak_free_part_phys(phys_addr_t phys, size_t size)
 {
-	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
-		kmemleak_free_part(__va(phys), size);
+	pr_debug("%s(0x%pa)\n", __func__, &phys);
+
+	if (kmemleak_enabled)
+		delete_object_part((unsigned long)phys, size, true);
 }
 EXPORT_SYMBOL(kmemleak_free_part_phys);
 
@@ -1182,8 +1188,10 @@ EXPORT_SYMBOL(kmemleak_free_part_phys);
  */
 void __ref kmemleak_not_leak_phys(phys_addr_t phys)
 {
-	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
-		kmemleak_not_leak(__va(phys));
+	pr_debug("%s(0x%pa)\n", __func__, &phys);
+
+	if (kmemleak_enabled)
+		make_gray_object((unsigned long)phys, true);
 }
 EXPORT_SYMBOL(kmemleak_not_leak_phys);
 
@@ -1194,8 +1202,10 @@ EXPORT_SYMBOL(kmemleak_not_leak_phys);
  */
 void __ref kmemleak_ignore_phys(phys_addr_t phys)
 {
-	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
-		kmemleak_ignore(__va(phys));
+	pr_debug("%s(0x%pa)\n", __func__, &phys);
+
+	if (kmemleak_enabled)
+		make_black_object((unsigned long)phys, true);
 }
 EXPORT_SYMBOL(kmemleak_ignore_phys);
 
@@ -1468,6 +1478,17 @@ static void kmemleak_scan(void)
 			dump_object_info(object);
 		}
 #endif
+
+		/* ignore objects outside lowmem (paint them black) */
+		if ((object->flags & OBJECT_PHYS) &&
+		   !(object->flags & OBJECT_NO_SCAN)) {
+			unsigned long phys = object->pointer;
+
+			if (PHYS_PFN(phys) < min_low_pfn ||
+			    PHYS_PFN(phys + object->size) >= max_low_pfn)
+				__paint_it(object, KMEMLEAK_BLACK);
+		}
+
 		/* reset the reference count (whiten the object) */
 		object->count = 0;
 		if (color_gray(object) && get_object(object))
-- 
2.25.1

