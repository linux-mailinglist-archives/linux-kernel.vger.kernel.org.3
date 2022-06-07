Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD1B53F9E7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239663AbiFGJfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239639AbiFGJfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:35:06 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0E7E64DC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 02:35:04 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id u26so26655248lfd.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 02:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1imnAi5xz7HqCapEhh8k4KqTLfM1rDshD69OorDTV3Q=;
        b=FUe9hoC2gjsIGPJVEps761z94HHtbSP1LOQ6MOwoWAKATBaoen37ggvBdmhCO/1Dum
         bbL9wrYkQmZn5AFVSvqe7rIa4w9PVKkiXXig9eo+xADy33IXOFhyk8i7zMef75DgfAtF
         jWLLcPerKOjLVHT/t3gqLFTldCmrOvYRPaBzZMiNcUGk5R+FRdJy1YwX/KhRUom+U2/A
         DsIG8C52yvsQbR5nK0UpenU11Tf/PharFyrCbvu2QYv3HpGWk6uE6m5Ofoq1vk+hAz1a
         TsH4UPB9OMAyuBrQXofmV+miPQHfnsjtpErZBJ/kZrFD7q3l26g8RK0tKkPYDTKpM0px
         U2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1imnAi5xz7HqCapEhh8k4KqTLfM1rDshD69OorDTV3Q=;
        b=tBfkwYozdhQNbrP7hjiCVg9JiBXQQYG63ukq8GR2WVrbj20/XQhwlN5LkrRwgQdUjT
         XwmqejEorz/7Pp/0Nx7XZpnHbpQTtJjx2p1iI3pUA0qXO1jcz5XT8Z+pMy/LRsYEaxxg
         wGlSLSYEZfCLRuDG1iyT6TIlhOaeCr4zcMcSXCRf/V7CwcTPc5q874zvBKMO60BYIfDP
         mYRQK4wvVYlqsYeVofFpu8f8lJvzWlSWXYqxEtTNixnzBZktv2w2k34RNfYn2OIioixH
         IBb8N4oVvjmT7FY8zCEhgczUyVQR1D1MjhAVPKkIm6zC3eLqpSieEGUm1WcVvhH4X13s
         scvw==
X-Gm-Message-State: AOAM531w5E0zeExC/IB9zXKAbTl4k6RIwLK1a5SdM98MHmfnaBpCF1OZ
        qtXKeB3ufoOC1mHaWGv/EFc=
X-Google-Smtp-Source: ABdhPJwUtUjYWUsi2A0Gz+SKLSqewTZ8rOUEGsOboyqIoXV8szQIuSCZZkSiPZcSm6rDEt2nEkryUQ==
X-Received: by 2002:a05:6512:2351:b0:479:6c3b:5d4 with SMTP id p17-20020a056512235100b004796c3b05d4mr526524lfu.87.1654594503595;
        Tue, 07 Jun 2022 02:35:03 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id r27-20020a2e575b000000b002554a4ebf5fsm2748043ljd.74.2022.06.07.02.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 02:35:03 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 4/5] mm/vmalloc: Extend __find_vmap_area() with one more argument
Date:   Tue,  7 Jun 2022 11:34:48 +0200
Message-Id: <20220607093449.3100-5-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220607093449.3100-1-urezki@gmail.com>
References: <20220607093449.3100-1-urezki@gmail.com>
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

__find_vmap_area() finds a "vmap_area" based on passed address.
It scan the specific "vmap_area_root" rb-tree. Extend the function
with one extra argument, so any tree can be specified where the
search has to be done.

There is no functional change as a result of this patch.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 82771e555273..b60385101897 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -814,9 +814,9 @@ static struct vmap_area *find_vmap_area_exceed_addr(unsigned long addr)
 	return va;
 }
 
-static struct vmap_area *__find_vmap_area(unsigned long addr)
+static struct vmap_area *__find_vmap_area(unsigned long addr, struct rb_root *root)
 {
-	struct rb_node *n = vmap_area_root.rb_node;
+	struct rb_node *n = root->rb_node;
 
 	addr = (unsigned long)kasan_reset_tag((void *)addr);
 
@@ -1840,7 +1840,7 @@ static struct vmap_area *find_vmap_area(unsigned long addr)
 	struct vmap_area *va;
 
 	spin_lock(&vmap_area_lock);
-	va = __find_vmap_area(addr);
+	va = __find_vmap_area(addr, &vmap_area_root);
 	spin_unlock(&vmap_area_lock);
 
 	return va;
@@ -2582,7 +2582,7 @@ struct vm_struct *remove_vm_area(const void *addr)
 	might_sleep();
 
 	spin_lock(&vmap_area_lock);
-	va = __find_vmap_area((unsigned long)addr);
+	va = __find_vmap_area((unsigned long)addr, &vmap_area_root);
 	if (va && va->vm) {
 		struct vm_struct *vm = va->vm;
 
-- 
2.30.2

