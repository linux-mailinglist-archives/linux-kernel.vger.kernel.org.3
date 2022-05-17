Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0628052ADA9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 23:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiEQVtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 17:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiEQVtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 17:49:17 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1567D52B28
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 14:49:17 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id q18so8024pln.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 14:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4//2wcKUjm7wVE+xXDVk0cokK7GAjJzcAndozpK7d/8=;
        b=RJWTaG1dDrGlVlN9KIiw3fChhdkiehjq8Tb+cv7yMQ+vNtYUf4id+SS2yYctoOlqda
         /r1Y6KvHFG5W/EVhz6KsZtQYc33sdqliL9JbXe0jlnetB7tk1wtQqvzTZUQv3flxF8mF
         2192vx5iJRL7mHaHaw+4VXDke6dA2keORShjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4//2wcKUjm7wVE+xXDVk0cokK7GAjJzcAndozpK7d/8=;
        b=QGXlJS321jlxKDjct2JpbQi2/E6RcUsloyoQVKAUQeqdf4JPhkzkXeHnMQr+QlB1wo
         PtRekqvQVOT3iiXy8jIHL497meqAVlPEkwaRTB46oVpL91X621Ec6Pf6b86O7Vj4Oaki
         RImWFDZNa76V73l6R3FlWpMmt/XZGvGc9RfZ13GfV7OQYLhmPkzyPPeKtt1551F8A+fO
         kGWhPF9nYqzQSOaeGTVW3HkxlEqGXl6KN+jj+Pig11hNwWX1x/v6yqpFgYdSSazZbnHz
         T5LP13kgIKutEeh1K6FleYCAvA8qml9+qehd0OTbKcv0x9+Ziwz8VIPp/LWK+1nqXzkG
         52EA==
X-Gm-Message-State: AOAM530W6Ck9VfwqzzgKnpSVwbvOg2E2ZMepVnk8yTvoXT4y4EGU0H7M
        M5O1QwUypjWfNlAXOJirJ4uM3A==
X-Google-Smtp-Source: ABdhPJziHuyE0QeOGD0VhJ/kDrr6NCR/uSL8rCaLKSTsf+QpH+6n6R7Y91lQDLvs7/tddWZZ89iPeA==
X-Received: by 2002:a17:903:248:b0:155:e8c6:8770 with SMTP id j8-20020a170903024800b00155e8c68770mr23351128plh.129.1652824156579;
        Tue, 17 May 2022 14:49:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id kt11-20020a17090b214b00b001df2f8f0a45sm100414pjb.1.2022.05.17.14.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 14:49:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] lkdtm/usercopy: Check vmalloc and >0-order folios
Date:   Tue, 17 May 2022 14:49:14 -0700
Message-Id: <20220517214914.878350-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3494; h=from:subject; bh=KIxGg/ioZZNsqgLwDtXiGSi0ZEwDVlEBciuJk08W4UA=; b=owEBbAKT/ZANAwAKAYly9N/cbcAmAcsmYgBihBha9G04FHWcCTd7MhyLQxr78bdbNBU4rSYVFYNi MZ8LJdKJAjIEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYoQYWgAKCRCJcvTf3G3AJobcD/ YuB5UwDN5hpVQpV0PSSQClKJvq9bVnYGBcfPtsge25S7v3naqnBsgagAlaEPG7OWlTm9mECiDY2Zhi Ql2IMvxjxzvZgh2Vt0rvt3kSrQg9QExkghVnLo9FpBppfu0Mf0M5CgR2J7OomYA9/q5PRPVLkAZ04h kC7BhVpVF5wBrXzlKnYgM0ilie7FceNgigXtpv6qtOal5uuOCT0Z7hAQeSB7rF5Ga5ORYxsZmjsGHR SOFohvY7SelzSTpb34ZPsaQtHHhyK1pzDSoL3EXjGGR2TmyPnvmnGlHBGoCExY/bQProc1YB+NTOm/ Pr/E99jOQwx+o9p+0uWtdqfXqdrr2js1XcMLsliSFcc3dR97DvnGM9hGm9bQVnMnIOTXDH3nzxsNRX 3DPJAKx3zexH8ehWyOAIUdW6Bzv2cdzT+zXs5BnaXODtIosKAvIyw7nN4nlWkuwPW5z0cFh48wzvyX gTMPO1UAcYY/k7Ci5C7ABY/4l0IFMIRXIiHe3eFGaUGNDhQMRzGqUIa0P/LsdSVHakUK/bjWRNUdSI fpEjcYrOO0I6cW88DjQT8lETwJZFk0vIbS0isIWVhD+CFaZozqaAVRX+1WX4PGuIqqCKVr9wFTbrgU rqKiYBERWpFgLHmuldb91pXRDot9nI0FCJZkdmJxnXWt05cL1kQvhAWxdb
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add coverage for the recently added usercopy checks for vmalloc and
folios, via USERCOPY_VMALLOC and USERCOPY_FOLIO respectively.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/usercopy.c | 83 +++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/drivers/misc/lkdtm/usercopy.c b/drivers/misc/lkdtm/usercopy.c
index 945806db2a13..6215ec995cd3 100644
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
@@ -341,6 +342,86 @@ static void lkdtm_USERCOPY_KERNEL(void)
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
+	if (copy_to_user((void __user *)uaddr, kaddr, unconst + PAGE_SIZE)) {
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
+	addr = folio_address(folio);
+	if (addr)
+		do_usercopy_page_span("folio", addr + PAGE_SIZE);
+	else
+		pr_err("folio_address() failed?!\n");
+	folio_put(folio);
+}
+
 void __init lkdtm_usercopy_init(void)
 {
 	/* Prepare cache that lacks SLAB_USERCOPY flag. */
@@ -365,6 +446,8 @@ static struct crashtype crashtypes[] = {
 	CRASHTYPE(USERCOPY_STACK_FRAME_TO),
 	CRASHTYPE(USERCOPY_STACK_FRAME_FROM),
 	CRASHTYPE(USERCOPY_STACK_BEYOND),
+	CRASHTYPE(USERCOPY_VMALLOC),
+	CRASHTYPE(USERCOPY_FOLIO),
 	CRASHTYPE(USERCOPY_KERNEL),
 };
 
-- 
2.32.0

