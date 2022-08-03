Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CC5588FF4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 18:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237785AbiHCQA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 12:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238423AbiHCQAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 12:00:48 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22311054B
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 09:00:46 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id j4-20020a05600c1c0400b003a4f287418bso1079544wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 09:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QzJ33F4bJ7lwM5+m7mFsAcHdJMltjNvGnkKDEEt7hbs=;
        b=GPH5p6d1RDaRq+0Zommh1vpqc/rVqUPvZhgldr8qZLtuDtE+SjR13i2nnWrfSbH75X
         qH5TcRiDQCDkmHTRELxZKGL/gFt67o+6ViJ+oDt9+KG1Lwic6XzFNMun+N8rPczXN8W4
         MTDKYbO2iyKrdEidEOrGgAiFv4c/E4OYYPnl+cs+s62wkPZkf3e5TOXU+l/Z0JyESNA7
         NsIzQl7NiZdXhG+lljjL0B+6CtN9qZkrY72e6LOe5lCyspAg2xuxetRXFIBHg5s0VnJ0
         V23kNJBsAeweX1hyiYcF36v1+dLZFqZ7JgEOqKBihdHIUGBen9+3IkYt51PmcNaaTJVB
         WT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QzJ33F4bJ7lwM5+m7mFsAcHdJMltjNvGnkKDEEt7hbs=;
        b=aBMgDo4RdEH/Po8cS9M1577TbCuv7wKXx/BTZUazWRcEHimk2Um7esFCNPvbFuctLI
         cDTgFq0LpTTvN7DFlypybQMk6z4OrvPQqmpV2FXZs78k3cCoprxU5FmoA5dr44nlNYgF
         xdXuDWQ1Xc878BGwP9rCR6JSXWrV5VNcWWkft8KE9gSVBpVRzf066Qf4Z6ukyWRD6QqC
         OPtZvaRo4SEfdFN0btYXo8IWV4McM5Ejwh+hpl3Yt5eriSk49QzLoMjqg5W8IYcG4oA+
         l1o8aFPrnTSlXLhIE+/KjXX7ZnyJ2xTCBd3Z6gGqUa+v8RePcrmz99jKUDBxWznYAkgi
         DKrw==
X-Gm-Message-State: ACgBeo3dPtPnB7jaajGW00VZYiUKTF2UZ3DKCmzJwS3bX3B8GGezI+D2
        1GlHYzvTKCVvsbvRw3a31aU=
X-Google-Smtp-Source: AA6agR7gh74XwmyAbfY14lbZQdG53vZykNPX0zVuHCQF2W2ATYMiBkU9yNmH2ufnF7yDHKBOcRrXaQ==
X-Received: by 2002:a05:600c:35c6:b0:3a3:4217:f06e with SMTP id r6-20020a05600c35c600b003a34217f06emr3167664wmq.95.1659542445094;
        Wed, 03 Aug 2022 09:00:45 -0700 (PDT)
Received: from localhost.localdomain (host-79-27-108-198.retail.telecomitalia.it. [79.27.108.198])
        by smtp.gmail.com with ESMTPSA id u11-20020a05600c19cb00b003a302fb9df7sm3240896wmq.21.2022.08.03.09.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 09:00:43 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v3] kexec: Replace kmap() with kmap_local_page()
Date:   Wed,  3 Aug 2022 18:00:38 +0200
Message-Id: <20220803160038.22322-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Acked-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

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

