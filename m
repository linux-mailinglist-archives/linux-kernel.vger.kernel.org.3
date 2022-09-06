Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8034C5AEDBE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242168AbiIFOly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbiIFOjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:39:23 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7B29AF86
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:01:13 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 135-20020a63018d000000b00430673f7922so5777828pgb.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 07:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=S43B5VbJjHS0PJ6EeGXWAwhqAvbS5qlJaZ4GjrbF1RI=;
        b=Mh+eOLxHEbPlHpqMHmSaSX+6tf08G5GDTFan3UWIXZI26qQBFhyZgTFmobOIIGfoqC
         Brwe+9slcD3mlkOADE4mKXhhWLv/sAUIxzWY4dCEBmvOuekgpiashVSXYjdZyJoh0LGO
         F5slXer4q+y4RuHr4wwIJOIMb3n7+S125xBNkKZIaVgsSd3ozDtFol0COxXrjLdXd0Dm
         wq4GvFPK6O4mHYxv8vkSBggFyL2K9XQtJxbK0sTVm5NbUkkjUfGIwRRtG2OEa0ZNrpJy
         zb/bsruHsaWfa8qHHjs7lObbF68svhTIJjlrfDH5+Mi86JJYY/ch0ji5CDDbHqF9GGm3
         udeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=S43B5VbJjHS0PJ6EeGXWAwhqAvbS5qlJaZ4GjrbF1RI=;
        b=BjcaRnrpDjDCjz0iz576IMjCLO8k1pQ5gj5D/j/H2CXBix0t/2ObTS5oWqCR4hBp36
         T/irWi0FFt4od8BwyO6lXL5dnyonIXS+DVrwLPdJ5wGxIuszCir6L9z7xJphyc0r0Jti
         zDjUySGweIl0vm4c2z/dZKaj+FHW51PQead9TA1fD1ex/zCh8oFpGPpx7FKMlJWkXu4i
         xdgDIg0ok3RwK2lajrbp5Myh/cVtqk4pXzmrKY5Qe+zdQScWZNO1ugcq4L51OAZAvB6c
         ALuqClj3HkBY0/efsFj/wikXRroRTBRMvgIsFlH3/IMTwURDZxv6uuzTE8NOemjpY+v9
         e8Sw==
X-Gm-Message-State: ACgBeo3iMCpckp/ctGJOKs9i1TUeaX4nX+lwijhphvR777DjqHy/WBnl
        2D9JqkAYs7+mlt9J613D5x4umeCuju/5pw==
X-Google-Smtp-Source: AA6agR5vfEfLq3l6S4beFN19ULDG8aLCXXCylZ07vBlYwDu8QgN41nH8864JlMEgvO+w2gygCBWbiz6wVNawew==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:90b:10a:b0:200:2849:235f with SMTP id
 p10-20020a17090b010a00b002002849235fmr1125261pjz.1.1662472801461; Tue, 06 Sep
 2022 07:00:01 -0700 (PDT)
Date:   Tue,  6 Sep 2022 13:59:46 +0000
In-Reply-To: <20220906135948.3048225-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20220906135948.3048225-1-cmllamas@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220906135948.3048225-3-cmllamas@google.com>
Subject: [PATCH RESEND 2/3] binder: remove binder_alloc_set_vma()
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
2.37.2.789.g6183377224-goog

