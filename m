Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523195A5568
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 22:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiH2UNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 16:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiH2UNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 16:13:11 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3636B9A6A8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:13:08 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id g11-20020a17090a4b0b00b001fb5f1e195fso3795658pjh.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=aDagGx3LmgoyG54CwPD56b1ruBMwrXgt45EyqcA5Eq4=;
        b=cZsOAAQHSrP7c9yogJRusVGdA0QfV2bAHT91gNt+0Ijqx8OJepa8sgaM+ONgUtH3e/
         StdWYnFhQc8yqin6KxBUlGWlqtf29vrvcEfzu7wXboVDFDB26wiwTGdQdykJCZFWrgcu
         AhDZ4gBxcDDPxvh7ocrfenboYT58uNHQKRJnynlPemFgPOiF9wBPP28AL3NLDin+q27c
         vS9HV2VlERv3grfCGa5nJ2Olh92ZTCWfKLCs0mElHkV3ZVmIBVA3hYWX6HrCwJAO2Oo+
         jLSIyauYFfFwtrdriGOHAuBvt2zN6JPHZDxRww/BojS7sd45CJDszez+mRXjH1jL5arp
         PxiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=aDagGx3LmgoyG54CwPD56b1ruBMwrXgt45EyqcA5Eq4=;
        b=cu1sAyAFG1j3gZlgp6RUKEDdgynIIzmgZuuAG8iJEMKUfmtVnlh7CqKC2vwrGBk5oG
         qfv/4K+ft2NBRMEhl1tmmfc1Q2MXI+9dCpX0rA6rpGMTCR25ypHzp6x4GTYC6iIp2Tnq
         UG6hPJg1DyIBTN93yRNuvr1EORb+hcPuzTwtaVCfhVvlu04OyCSFxPhj2c/uZgRpN3X1
         BwprpXIKmCwEiLJ8qEiMMFH34YHgXlNJJ9wRHlq1Mgs6H4jbm1sKLepFjDg4nGI7jgaJ
         8oBD7+c/vHDDjQYZKimUoE/hMpNKqnWJVKeS4w0Hhjq8yHJondOWdSMWZ8KLoIIISFfV
         eOQQ==
X-Gm-Message-State: ACgBeo12c/qr1Seneq+0p9tH+/d/EfTEBmh4i3rUKY5Squ8I/HQFh/QA
        LBk6UwsyAUq0rICSxCjZ5Bl+MOrcndolLw==
X-Google-Smtp-Source: AA6agR6bYY/0Ms9Rm2K4zTlKiliLNrKMEJWP57mEgt9uJpP9xCFzGry+154uC9ica0AD+Xk5Bg5dFMdO8a17lQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:90a:249:b0:1e0:a8a3:3c6c with SMTP id
 t9-20020a17090a024900b001e0a8a33c6cmr4718pje.0.1661803987114; Mon, 29 Aug
 2022 13:13:07 -0700 (PDT)
Date:   Mon, 29 Aug 2022 20:12:51 +0000
In-Reply-To: <20220829201254.1814484-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20220829201254.1814484-1-cmllamas@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829201254.1814484-5-cmllamas@google.com>
Subject: [PATCH 4/7] binder: remove binder_alloc_set_vma()
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     kernel-team@android.com,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mmap_locked asserts here are not needed since this is only called
back from the mmap stack in ->mmap() and ->close() which always acquire
the lock first. Remove these asserts along with binder_alloc_set_vma()
altogether since it's trivial enough to be consumed by callers.

Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 25 ++-----------------------
 1 file changed, 2 insertions(+), 23 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 749a4cd30a83..1c39cfce32fa 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -309,27 +309,6 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 	return vma ? -ENOMEM : -ESRCH;
 }
 
-
-static inline void binder_alloc_set_vma(struct binder_alloc *alloc,
-		struct vm_area_struct *vma)
-{
-	unsigned long vm_start = 0;
-
-	/*
-	 * Allow clearing the vma with holding just the read lock to allow
-	 * munmapping downgrade of the write lock before freeing and closing the
-	 * file using binder_alloc_vma_close().
-	 */
-	if (vma) {
-		vm_start = vma->vm_start;
-		mmap_assert_write_locked(alloc->mm);
-	} else {
-		mmap_assert_locked(alloc->mm);
-	}
-
-	alloc->vma_addr = vm_start;
-}
-
 static inline struct vm_area_struct *binder_alloc_get_vma(
 		struct binder_alloc *alloc)
 {
@@ -793,7 +772,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 	buffer->free = 1;
 	binder_insert_free_buffer(alloc, buffer);
 	alloc->free_async_space = alloc->buffer_size / 2;
-	binder_alloc_set_vma(alloc, vma);
+	alloc->vma_addr = vma->vm_start;
 
 	return 0;
 
@@ -983,7 +962,7 @@ int binder_alloc_get_allocated_count(struct binder_alloc *alloc)
  */
 void binder_alloc_vma_close(struct binder_alloc *alloc)
 {
-	binder_alloc_set_vma(alloc, NULL);
+	alloc->vma_addr = 0;
 }
 
 /**
-- 
2.37.2.672.g94769d06f0-goog

