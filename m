Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4053E5254FA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 20:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357778AbiELSgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 14:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357733AbiELSgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 14:36:21 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD496973F
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 11:36:17 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id x52so5560050pfu.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 11:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fmzD9rNsECSReNQ5PrX3joY4B7VTF62mQ/BHRo7HwuU=;
        b=N49+Dheimvina9OkQYZAVLkd9Q3lwiCjCh9sNuFHhqrLreJ6tlSo97fTk8fAnVBi1h
         vxhemUFg0vioU9jONE5wueJGvxXGa07iS1pR/lny5tD5sU+MpcxGx/ywzUiboxdnvweM
         t0nLLbHACIWKEXEDinlxTqo5dWSXjITrhkYow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fmzD9rNsECSReNQ5PrX3joY4B7VTF62mQ/BHRo7HwuU=;
        b=6UiB0kMNXsRDgtQU1AhC1yZ8XyCUvPzJsBEdNjrJfteCww8zi95NrWu9rHne7ZKOuv
         M2FBwkEIfMFo5x0Kwhdwc/R8S1zWqSEtdBz1005qQ23rBLfdSsGj5GTFqJXiKg0KMMIP
         rIqV7uoj7Hu10PV3gnZ5fKOURvCXQk5gKB3Izagt5g8h2YyYRgiX89YMnkK0vbCK3mXf
         jvOim5NXIzCzukZE+2X9h1fCWA7un1ODgNx6mjxpsLy/PEXDV9S01LM57DGYw23/BcLf
         fJVat9DYlDb997TFkC6jeHYFZjOZ6wwZ894uVomd//izBEtggh2MFOVOgmHXCLmNmOSD
         xi5Q==
X-Gm-Message-State: AOAM530mwmUHgf+gmvJqgQi6xmtNptd+nQNAlCBwk7wlEV3apnuuLnHl
        a+FEEED7rb5WePtbed0KN+Juw2MSKAT7bw==
X-Google-Smtp-Source: ABdhPJwQs8f0+Tlghx0styILjotSwjlFz4Ulfnsvrgj0+wEnl9O0MbW/zC+b8ijhKT7PqZW+frim+g==
X-Received: by 2002:a63:e218:0:b0:3c6:7449:15a2 with SMTP id q24-20020a63e218000000b003c6744915a2mr740941pgh.515.1652380577330;
        Thu, 12 May 2022 11:36:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 16-20020a621610000000b0050dc76281a7sm153076pfw.129.2022.05.12.11.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 11:36:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [RFC][PATCH] lkdtm/usercopy: Add tests for other memory types
Date:   Thu, 12 May 2022 11:36:13 -0700
Message-Id: <20220512183613.1069697-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4054; h=from:subject; bh=d/WHu6d3wldPfChuAXknC/QD9Uq1559cFGHibNpURL8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBifVOdEMza0XMDYVrnEzmFV5A91gOAs4JnXuF20cjf +9cNusmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYn1TnQAKCRCJcvTf3G3AJlHWEA CDs2DWMYK2GxdiM6GVRzOvgg71voEFbmx+GYgdPlJ0IZYzAIuaw43olfhV7Y09XkaPAAdjD0cQF/VU sEx90P8GzXQSQ4ffHwBJuJX2CPKXBoI9RZ5YQ7skvlh5EnDet++uggnNIcPBmm5GXeL9Gf97ndpQGC UsO0V7CXeOx4pYGabqM5681lXr9JmZJPjo5vnXFQ4j8IoD02Hly2kYA0LLkWOXX78NGgU6z60rJHTf oFA4Ov2T8bAi1VIvVT+WLSuNx/LdGpjPrEaVPWAEzAS2E1tZhSfa9VPZsKN6KewWwmmWDqBlLH+9u/ e4LP2hOfC+eMJ6nHh9/NEz9y/CBzw8ZbuHL62PFxgg/we4YbHaA0IMC4cckWQn/UtcC5uMx8MIWZ5q drkQ3ulQPjEYAAaiEXuPj1F1T9HyOQ7VDwCBPj5+GRvXKydiTZ4xw+q7n2tQUjJtjZI9GIi9O4hDTw hfn2yU9Yvp0Y8txOn3xEcTAUKml1/2VcNeBNYmFzWnkQRlaEG7NegyXE1byGSza9G3eZnxX9pnxWDm 8TTTWN2CDnhzImKGxFapXhnF480voTx8q7ltMBMMETMV5qBaFlTKcK+GdhBE5rTw/NnMWCqAg1vSJ2 ZMZ5dqBPDjyaBB+Wg7pq2kBaF7UTm6OGeFKBgWAT7c9C3EEDvyKzgM808QKw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add coverage for the recently added usercopy checks for vmap, kmap, and
folios.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Hi,

So, this kmap test fails the "good" copy step... Is copy_to_user()
limited somewhere else to not touch kmap'd pages? I can't find it...

Also, is my use of folios correct here?

-Kees
---
 drivers/misc/lkdtm/usercopy.c | 104 ++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/drivers/misc/lkdtm/usercopy.c b/drivers/misc/lkdtm/usercopy.c
index 945806db2a13..d1c585bb7a8d 100644
--- a/drivers/misc/lkdtm/usercopy.c
+++ b/drivers/misc/lkdtm/usercopy.c
@@ -5,6 +5,7 @@
  */
 #include "lkdtm.h"
 #include <linux/slab.h>
+#include <linux/highmem.h>
 #include <linux/vmalloc.h>
 #include <linux/sched/task_stack.h>
 #include <linux/mman.h>
@@ -341,6 +342,106 @@ static void lkdtm_USERCOPY_KERNEL(void)
 	vm_munmap(user_addr, PAGE_SIZE);
 }
 
+/*
+ * This expects "kaddr" to point to a PAGE_SIZE allocation, which means
+ * a more complete test that would include copy_from_user() would risk
+ * memory corruption. Just test copy_to_user() here, as that exercises
+ * almost exactly the same code paths.
+ */
+static void do_usercopy_page_span(const char *name, void *kaddr)
+{
+	unsigned long uaddr;
+
+	uaddr = vm_mmap(NULL, 0, PAGE_SIZE, PROT_READ | PROT_WRITE,
+			MAP_ANONYMOUS | MAP_PRIVATE, 0);
+	if (uaddr >= TASK_SIZE) {
+		pr_warn("Failed to allocate user memory\n");
+		return;
+	}
+
+	/* Initialize contents. */
+	memset(kaddr, 0xAA, PAGE_SIZE);
+
+	/* Bump the kaddr forward to detect a page-spanning overflow. */
+	kaddr += PAGE_SIZE / 2;
+
+	pr_info("attempting good copy_to_user() from kernel %s: %px\n",
+		name, kaddr);
+	if (copy_to_user((void __user *)uaddr, kaddr,
+			 unconst + (PAGE_SIZE / 2))) {
+		pr_err("copy_to_user() failed unexpectedly?!\n");
+		goto free_user;
+	}
+
+	pr_info("attempting bad copy_to_user() from kernel %s: %px\n",
+		name, kaddr);
+	if (copy_to_user((void __user *)uaddr, kaddr,
+			 unconst + PAGE_SIZE)) {
+		pr_warn("Good, copy_to_user() failed, but lacked Oops(?!)\n");
+		goto free_user;
+	}
+
+	pr_err("FAIL: bad copy_to_user() not detected!\n");
+	pr_expected_config_param(CONFIG_HARDENED_USERCOPY, "hardened_usercopy");
+
+free_user:
+	vm_munmap(uaddr, PAGE_SIZE);
+}
+
+static void lkdtm_USERCOPY_VMALLOC(void)
+{
+	void *addr;
+
+	addr = vmalloc(PAGE_SIZE);
+	if (!addr) {
+		pr_err("vmalloc() failed!?\n");
+		return;
+	}
+	do_usercopy_page_span("vmalloc", addr);
+	vfree(addr);
+}
+
+static void lkdtm_USERCOPY_KMAP(void)
+{
+	struct page *page;
+	void *addr;
+
+	page = alloc_pages(GFP_KERNEL | __GFP_ZERO, 0);
+	if (!page) {
+		pr_err("alloc_pages() failed!?\n");
+		return;
+	}
+	addr = kmap_atomic(page);
+	if (addr) {
+		do_usercopy_page_span("kmap", addr);
+		kunmap_atomic(addr);
+	} else {
+		pr_err("kmap_atomic() failed!?\n");
+	}
+	__free_pages(page, 0);
+}
+
+static void lkdtm_USERCOPY_FOLIO(void)
+{
+	struct folio *folio;
+	void *addr;
+
+	/*
+	 * FIXME: Folio checking currently misses 0-order allocations, so
+	 * allocate and bump forward to the last page.
+	 */
+	folio = folio_alloc(GFP_KERNEL | __GFP_ZERO, 1);
+	if (!folio) {
+		pr_err("folio_alloc() failed!?\n");
+		return;
+	}
+	addr = page_address(&folio->page);
+	if (addr) {
+		do_usercopy_page_span("folio", addr + PAGE_SIZE);
+	}
+	folio_put(folio);
+}
+
 void __init lkdtm_usercopy_init(void)
 {
 	/* Prepare cache that lacks SLAB_USERCOPY flag. */
@@ -365,6 +466,9 @@ static struct crashtype crashtypes[] = {
 	CRASHTYPE(USERCOPY_STACK_FRAME_TO),
 	CRASHTYPE(USERCOPY_STACK_FRAME_FROM),
 	CRASHTYPE(USERCOPY_STACK_BEYOND),
+	CRASHTYPE(USERCOPY_VMALLOC),
+	CRASHTYPE(USERCOPY_KMAP),
+	CRASHTYPE(USERCOPY_FOLIO),
 	CRASHTYPE(USERCOPY_KERNEL),
 };
 
-- 
2.32.0

