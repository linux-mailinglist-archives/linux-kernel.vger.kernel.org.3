Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86EC659B602
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 20:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbiHUSZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 14:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbiHUSZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 14:25:28 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFE112608
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 11:25:26 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id vw19so3759179ejb.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 11:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=5U5zU5oXxguyJCAtCcE2r9M+BIs+bxw2F5L0kHaD1EY=;
        b=DT1Y3xdSeXplcTETEuE4uhCY4yUkNa1Ix0OXL9y1tJwp2UpBWzBB/wo3tVvCD91XX3
         FsNWz+IRlziNNl+yLYRcjlMoqPET4PyWkxSVkkSX/zyRW5ft8oN9UqdyxiPtksrBa6q0
         hSiK5tnye6ypgISwXYS6j44z1HsasSpF4YzMjZ2oP/XjP8jPTMYblbvTaarOZc4Utryj
         /j6/q7mZ4a7frLW4gaqV3kP3Mj97uPoyHD8Du3Pw2PXwt/xULxvQA0iJD42+8DHcbrp0
         MNC0aBNSo2OBQFFNXOysKEUn1rR4jQfyndFXohH3NNad9EvEV3mzCzkPOgZBljQRUqUM
         pULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=5U5zU5oXxguyJCAtCcE2r9M+BIs+bxw2F5L0kHaD1EY=;
        b=I2wIMLWKZey56t/1y+QgmrxQVhwi2BXnEd8BK/Nu8hytfQsEVMQPzuQzz4YeNTALkv
         m5aqgyr8ealdVR7HuP5rbNXE1IQuByXdrIn7OQ4AX+y9cvq5PJLbI31Ivolj+P0XoMK4
         h+FlN7N9ZeYhntSEUeumkESQhDd3ehySheyPw7fPvYPMAjhbf1wsJ9IIMu2H2cZkDYGf
         Pe5U3UGhUThJKUBNQ3IT6VrV46Kr5/d4b+Rf5tQy6tfYiRjLICzhyrF2o0BXgSs9BGVQ
         SlmHpNQsavST46qTfrgvAnltBk5Tm6zzVNW06udPPc2YYBnmHDhorTdl9d6jNGIER1kg
         5smQ==
X-Gm-Message-State: ACgBeo0y4tuDs1fewYBlBkLYOnn+LvyRJPBLnv5dXF3GAw6TgvYa5VXk
        cTQSF18T8Qji6y5e9lnxHD8=
X-Google-Smtp-Source: AA6agR485P1k1WGO2X5KEiAkTAS+u9iUbOXwucVHeLUconht5K9JPTkt+NFXwbtYQsQkp6Wx7JbIOg==
X-Received: by 2002:a17:907:c10:b0:731:58aa:7783 with SMTP id ga16-20020a1709070c1000b0073158aa7783mr11187802ejc.19.1661106325105;
        Sun, 21 Aug 2022 11:25:25 -0700 (PDT)
Received: from localhost.localdomain (host-87-17-106-94.retail.telecomitalia.it. [87.17.106.94])
        by smtp.gmail.com with ESMTPSA id ft8-20020a170907800800b0073d68d2fc29sm2097482ejc.218.2022.08.21.11.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 11:25:23 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>, Baoquan He <bhe@redhat.com>
Subject: [RESEND PATCH v3] kexec: Replace kmap() with kmap_local_page()
Date:   Sun, 21 Aug 2022 20:25:19 +0200
Message-Id: <20220821182519.9483-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

kmap() is being deprecated in favor of kmap_local_page().

There are two main problems with kmap(): (1) It comes with an overhead as
mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when the
kmap’s pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).
It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
the tasks can be preempted and, when they are scheduled to run again, the
kernel virtual addresses are restored and are still valid.

Since its use in kexec_core.c is safe everywhere, it should be preferred.

Therefore, replace kmap() with kmap_local_page() in kexec_core.c.

Tested on a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel with
HIGHMEM64GB enabled.

Cc: Andrew Morton <akpm@linux-foundation.org>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Acked-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

Few days ago, I've been requested by Andrew to resend this (and other
patches) and, this time, to not forget to Cc him :-)

v2->v3: Add more information in the commit message as requested by Baoquan
He and forward two tags, respectively from Ira Weiny and Baoquan He (many
thanks to them two!).

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
2.37.1

