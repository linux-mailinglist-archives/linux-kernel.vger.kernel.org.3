Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E14511214
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358615AbiD0HO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242219AbiD0HOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:14:24 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412D938BC5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:11:14 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id f14so559563qtq.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qwksdRpUlSuuWw1pxLBKhXiKlPkBnGHl88zbVVW36PY=;
        b=bsJROiROPQI0CsqMnAU6Zn7PpVxK7aTUo+iIBZoUNDEIFoqqMoAIb+ro5u2z39wvn+
         ZpnnaPrlsPavmtXobVUPXO7DinfDMHRXTYhe1D7GPwqq1Iiue7gYtYrfmgyBNzqlFYcQ
         52iWjNSjM9V9cjATe8QeqZs9VyFE1KaXI7ItMzVouBWAdWHU3FEtLFzMveTBPP2tlmFY
         VGd+s0jj+Os3pyDguKVysA/u8eytIqIFuM+3iBIKmCfAFAnHRaZ7UtcJmyWRI5ZjofjS
         /Ge00AoCsaES6hu+sPktSVptY3wMwIRjcZu7WtwtPOvcY7AlqzsOySbXPALHoLlfkjXG
         VoeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qwksdRpUlSuuWw1pxLBKhXiKlPkBnGHl88zbVVW36PY=;
        b=2N92Ojwxrkbedzb6LjdOsfneBSz9nMeYUJzbNhXQ91TgOSclAtefYBfsMJhwH2YccP
         1Z55MCKzV5umzLj3FpduA+sVvvyGGhbqFqeCHthaOMcTpIcdi1La/+fRSn9MooYMqINR
         lJRDfT1SAy9A3ICSNZ64BfMJ2N3aK5YP2suUi42b0EKGTs6emc7yMf4VzRB9lvSU5SLC
         Cm8zZ6zC/otRgsxchaqWfQVnVgaszlA1fxVyIAELui/4PqjyxJGZD2dut/yW/g2qrVe8
         WA7haVkDgc+7iLgJPgqz7308Qz6LT2tUTV6vSIe72HgF6H1WMCYIIqQPkWHAckAeu44F
         +MJQ==
X-Gm-Message-State: AOAM532H6sJQ5qog5BahTOUCCoGPBjIti76OYljPx+kNm6hysDc0qZoX
        mT5o4knVvmYNAj9wkDZuPCs=
X-Google-Smtp-Source: ABdhPJxMpMlJ7xIUpezGsO2arZ+rxxRuzF/61noOP3FbtioWh6NWIyWd83VIO3CWtZOF3/zVxLlemw==
X-Received: by 2002:a05:622a:58e:b0:2f3:81c7:cc59 with SMTP id c14-20020a05622a058e00b002f381c7cc59mr2565899qtb.614.1651043473412;
        Wed, 27 Apr 2022 00:11:13 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y13-20020a05622a164d00b002f1ff52c518sm9238002qtj.28.2022.04.27.00.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 00:11:12 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     glider@google.com, elver@google.com, akpm@linux-foundation.org
Cc:     dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xu xin <xu.xin16@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] mm/kfence: fix a potential NULL pointer dereference
Date:   Wed, 27 Apr 2022 07:11:00 +0000
Message-Id: <20220427071100.3844081-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

In __kfence_free(), the returned 'meta' from addr_to_metadata()
might be NULL just as the implementation of addr_to_metadata()
shows.

Let's add a check of the pointer 'meta' to avoid NULL pointer
dereference. The patch brings three changes:

1. Add checks in both kfence_free() and __kfence_free();
2. kfence_free is not inline function any longer and new inline
   function '__try_free_kfence_meta' is introduced.
3. The check of is_kfence_address() is not required for
__kfence_free() now because __kfence_free has done the check in
addr_to_metadata();

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 include/linux/kfence.h | 10 ++--------
 mm/kfence/core.c       | 30 +++++++++++++++++++++++++++---
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/include/linux/kfence.h b/include/linux/kfence.h
index 726857a4b680..fbf6391ab53c 100644
--- a/include/linux/kfence.h
+++ b/include/linux/kfence.h
@@ -160,7 +160,7 @@ void *kfence_object_start(const void *addr);
  * __kfence_free() - release a KFENCE heap object to KFENCE pool
  * @addr: object to be freed
  *
- * Requires: is_kfence_address(addr)
+ * Requires: is_kfence_address(addr), but now it's unnecessary
  *
  * Release a KFENCE object and mark it as freed.
  */
@@ -179,13 +179,7 @@ void __kfence_free(void *addr);
  * allocator's free codepath. The allocator must check the return value to
  * determine if it was a KFENCE object or not.
  */
-static __always_inline __must_check bool kfence_free(void *addr)
-{
-	if (!is_kfence_address(addr))
-		return false;
-	__kfence_free(addr);
-	return true;
-}
+bool __must_check kfence_free(void *addr);
 
 /**
  * kfence_handle_page_fault() - perform page fault handling for KFENCE pages
diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 6e69986c3f0d..1405585369b3 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -1048,10 +1048,10 @@ void *kfence_object_start(const void *addr)
 	return meta ? (void *)meta->addr : NULL;
 }
 
-void __kfence_free(void *addr)
-{
-	struct kfence_metadata *meta = addr_to_metadata((unsigned long)addr);
 
+/* Require: meta is not NULL*/
+static __always_inline void __try_free_kfence_meta(struct kfence_metadata *meta)
+{
 #ifdef CONFIG_MEMCG
 	KFENCE_WARN_ON(meta->objcg);
 #endif
@@ -1067,6 +1067,30 @@ void __kfence_free(void *addr)
 		kfence_guarded_free(addr, meta, false);
 }
 
+void __kfence_free(void *addr)
+{
+	struct kfence_metadata *meta = addr_to_metadata((unsigned long)addr);
+
+	if (!meta) {
+		kfence_report_error(addr, false, NULL, NULL, KFENCE_ERROR_INVALID);
+		return;
+	}
+
+	__try_free_kfence_meta(meta);
+}
+
+bool __must_check kfence_free(void *addr)
+{
+	struct kfence_metadata *meta = addr_to_metadata((unsigned long)addr);
+
+	if (!meta)
+		return false;
+
+	__try_free_kfence_meta(meta);
+
+	return true;
+}
+
 bool kfence_handle_page_fault(unsigned long addr, bool is_write, struct pt_regs *regs)
 {
 	const int page_index = (addr - (unsigned long)__kfence_pool) / PAGE_SIZE;
-- 
2.25.1

