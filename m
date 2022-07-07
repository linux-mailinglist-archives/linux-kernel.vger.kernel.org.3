Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F6556AEE5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 01:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236729AbiGGXQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 19:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236556AbiGGXP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 19:15:57 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F7327FD5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 16:15:56 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z12so18695048wrq.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 16:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=izEW/QlWsYwAv1ZochY3FjaPww57C5kdq40cLp75WW8=;
        b=bN/UI+7lQeB65atynzKqp9nMLADS1qCkhGg5AFy7k9JTlnDD+Zfmk48B2FRQd+hC0Z
         U4CKu5nG4vjGJCXcV2zhrMRVj5UyORVGZ0Wvcq6fki/MJbwmIrZUPJ6dJ5thhHkq+45r
         trErrsYkpiZKrv56HldNIjMgl5ylRyWM2frA870ii9xsEWsxGBxvQw9GZER8kL4TcltL
         A9S9IZChyrVI1WMBCy00qnuXGolCRiTd3a6aLoa4W8Ximf+e2l9LEQ0uIXtbfAokdAId
         ANb1ZhVUMrfkHBXJMCKs8voDoToWbTf2WtwrcXSUQTDgagsSYKsBMdxLfxtkqPy6PGSe
         /AOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=izEW/QlWsYwAv1ZochY3FjaPww57C5kdq40cLp75WW8=;
        b=ABf0PpGHGyqHjfTa2D2zQp/7jHpqf757bJ2TchFm/V6ecRWLHP60WGbzzKaddgtuuS
         14j8ZfnAbjN6QF0F2n7EBPCSjz6qrOGJ4wu8bLwySXHQ5up4V7DHfjpjf39V0kBxNP/8
         X7KdTm7nV3ReMYwpfcaIBfMCnf5VjrVh5SY+D/pb4ulblvJUAfzNPVkMGO5e4aeRidQx
         T5PQe+aczUZaDWSrejF4RDG2it4jmWFOyE6dWAcM/8tf0316rV8poghXGNccf8Ku1lGw
         MXpC8VbpA3wExhAkpM1vWgn43C8HwDfpKUTsUqI4HnaYa81WHY84emVwxInNIlCNfKe9
         7dfQ==
X-Gm-Message-State: AJIora9vy+Ht5D+99fYBhHCqVevMsIA8bZX4v+UTdcznRZOkV/3Dfbiw
        EPjjBlFq2PV9Fr6JR7uzR+g=
X-Google-Smtp-Source: AGRyM1vb1t9Pd03LkoGzBnp8Qn8oJ174NaaaEi0Rd2+luP9y+glv1E3K+ONHUCDrq6cJFue2klElbQ==
X-Received: by 2002:adf:f9c9:0:b0:21d:2cec:63e9 with SMTP id w9-20020adff9c9000000b0021d2cec63e9mr276271wrr.301.1657235755382;
        Thu, 07 Jul 2022 16:15:55 -0700 (PDT)
Received: from localhost.localdomain (host-79-53-109-127.retail.telecomitalia.it. [79.53.109.127])
        by smtp.gmail.com with ESMTPSA id r129-20020a1c4487000000b003a0499df21asm229785wma.25.2022.07.07.16.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 16:15:54 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v2] kexec: Replace kmap() with kmap_local_page()
Date:   Fri,  8 Jul 2022 01:15:50 +0200
Message-Id: <20220707231550.1484-1-fmdefrancesco@gmail.com>
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

Therefore, use kmap_local_page() in kexec_core.c because these mappings are
per thread, CPU local, and not globally visible.

Tested on a QEMU + KVM 32-bits VM booting a kernel with HIGHMEM64GB
enabled.

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v1->v2: A sentence of the commit message contained an error due to a
mistake in copy-pasting from a previous patch. Replace "aio.c" with
"kexec_core.c".

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

