Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410CE56AB04
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236378AbiGGStu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235452AbiGGSts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:49:48 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087D7201A6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 11:49:47 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id ay25so1534341wmb.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 11:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=By3T6Z5JDK5VvmvI0n3THPKQqdtLxJBkH/DaezIVYE0=;
        b=UcJwhV8pPQf4CAMOaf2znH1HntdU1cBMU8tyt9pzArCbkZGGDwErnBt8m86tQK9dxa
         HcLrCVCOdiHht2vDiwCi4rzwEvLi5Cmu6JhEAmHMJvK2W1eODp6clKPUTA4El1iWyRQY
         6RXW5TWyrX9LsIxjY64M6+jfyEpylCJGLL3Ii2DxkW9GhJG4CtiXaB1YsrKPcnTfmvno
         Bg7chmUDKYbyao8BwLr4ICGm+tOc99ag/ZCBIvshf5C3c9gois6pyyQuiNsTbhC2LswA
         ZLJqpybLLTbFd5bYNrRA+1YcC1AQwEvEPq2PA5vjU57nBou97z3stLYQNuOO+lZspdfB
         FfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=By3T6Z5JDK5VvmvI0n3THPKQqdtLxJBkH/DaezIVYE0=;
        b=SqeAjO0vXlqmUrYuuD/SA+44DyRG89qNaVgWXjllw87Gu0JvXnd8YM+4nNoyhcfZ9q
         raP9rC4mvofE+Zpn5zzV/vm91z8uCkWLuqmx7yH+u1ZqzbIl7fNkPJMcPJWlUy4qzwhk
         fUvbCC4xnFo0fvb8LWz2XkfdKxhTlDbCum5lqgsojJZ/Qnjmv8nFryOyereoedcNGsU5
         gpxtfCxwltsjuuSq0+LYnnbTQmMX6mzTKkL/RhhHcceO3WQ7fY7Mxhn4CGXfLRPh3fWY
         KpgD3UAmxF83fKKUxHiT7JMf4G30lrM7CEOzALGnzH9fxgVb6FzFHyIX1wzYGTBMqtnb
         qszg==
X-Gm-Message-State: AJIora8xVnNPfTMg1gIMNKvVRgmBv8ASxMUHJFiL0DJB1kpeaUF0jcTz
        SuiC+D4cYBOgY3mbA64Sk9s=
X-Google-Smtp-Source: AGRyM1uvGngSRhvIh90pdnM0bN+cxnFl4K5RjbtOcM7uxxaM69tVEFlfF+Ip5tKu6NDKHKV07V4/9w==
X-Received: by 2002:a1c:19c3:0:b0:39c:6479:3ca with SMTP id 186-20020a1c19c3000000b0039c647903camr6037084wmz.27.1657219785494;
        Thu, 07 Jul 2022 11:49:45 -0700 (PDT)
Received: from localhost.localdomain (host-79-53-109-127.retail.telecomitalia.it. [79.53.109.127])
        by smtp.gmail.com with ESMTPSA id z5-20020adfe545000000b0021b81855c1csm47280088wrm.27.2022.07.07.11.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 11:49:43 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] kexec: Replace kmap() with kmap_local_page()
Date:   Thu,  7 Jul 2022 20:49:39 +0200
Message-Id: <20220707184939.6086-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.36.1
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

The use of kmap() and kmap_atomic() are being deprecated in favor of
kmap_local_page().

With kmap_local_page(), the mappings are per thread, CPU local and not
globally visible. Furthermore, the mappings can be acquired from any
context (including interrupts).

Therefore, use kmap_local_page() in aio.c because these mappings are per
thread, CPU local, and not globally visible.

Tested on a QEMU + KVM 32-bits VM booting a kernel with HIGHMEM64GB
enabled.

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 kernel/kexec_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 4d34c78334ce..6f98274765d4 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -814,7 +814,7 @@ static int kimage_load_normal_segment(struct kimage *image,
 		if (result < 0)
 			goto out;
 
-		ptr = kmap(page);
+		ptr = kmap_local_page(page);
 		/* Start with a clear page */
 		clear_page(ptr);
 		ptr += maddr & ~PAGE_MASK;
@@ -827,7 +827,7 @@ static int kimage_load_normal_segment(struct kimage *image,
 			memcpy(ptr, kbuf, uchunk);
 		else
 			result = copy_from_user(ptr, buf, uchunk);
-		kunmap(page);
+		kunmap_local(ptr);
 		if (result) {
 			result = -EFAULT;
 			goto out;
@@ -878,7 +878,7 @@ static int kimage_load_crash_segment(struct kimage *image,
 			goto out;
 		}
 		arch_kexec_post_alloc_pages(page_address(page), 1, 0);
-		ptr = kmap(page);
+		ptr = kmap_local_page(page);
 		ptr += maddr & ~PAGE_MASK;
 		mchunk = min_t(size_t, mbytes,
 				PAGE_SIZE - (maddr & ~PAGE_MASK));
@@ -894,7 +894,7 @@ static int kimage_load_crash_segment(struct kimage *image,
 		else
 			result = copy_from_user(ptr, buf, uchunk);
 		kexec_flush_icache_page(page);
-		kunmap(page);
+		kunmap_local(ptr);
 		arch_kexec_pre_free_pages(page_address(page), 1);
 		if (result) {
 			result = -EFAULT;
-- 
2.36.1

