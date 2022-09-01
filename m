Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF4C5A9E27
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235036AbiIARhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbiIARgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:36:09 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAF52DCB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:36:01 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id b9-20020a170902d50900b0016f0342a417so12321847plg.21
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 10:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=jyHdLFPHMbjXGLnwUzIxKnvlA/GbLLDhxKEqR7mLfqg=;
        b=TCOmQuZ0ealmr2rj6cwh5S5dr2tHdE6kJbl5yIAByz1pqanqNTRiefLGtYBY7Bfwis
         HCiC64ttZOFWEgwG30yQXn+Yd1NgQ1aDGCJSNFZhazZq9lt7mplm3W+aibX2RLK/lLN0
         uAX/ZCVxAoOvxpbxeS81kOPFHzixGFCJRTo1WJXrfNWNtHfKZEdnfDSt0EcuBcHbmrUl
         KJFv/JkMarGz2fGZyZ6GmZqZcaDNiv8ls/HHTwoDoMD28NmijZHaa+6d5o2vJqrlXSFO
         lKUsBOqEBkv1O0j454aqLOLj6gi+Hg3Qlj1nIC3dhAGDngGkgQrOdGW8W2dVGnwocfag
         do3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=jyHdLFPHMbjXGLnwUzIxKnvlA/GbLLDhxKEqR7mLfqg=;
        b=ACVzFgQdbS82B2lk2MClx0SeeyuVhgY5ITdk6526f2Y0MRdhrG/dlyVmfck8Y1sEsP
         rxcttEfDO9szcxoagc8JpZEaUegsTj2XJ32IWPGLiRANeSozycXFZLqWHMMXMFZuw8ot
         AXA4M6nMtO8M7oSrYkiZY9EYC29N609zupwJUhTsORlwYCeqF0f0PF5WBh3Qkot86ZSe
         X1xrWbiCs/Fyq/Crcv/reJHaNfYoELrG81bCt533cUcyiYTGxRQ4DKz3x4hOkJ4ovVeR
         i6EGPczWL6o6KDJyNDETi+ZacFNyj+xC0u2DCFN/8pgcoCOkRs9+CixuJJZsz4ENWe6l
         up6w==
X-Gm-Message-State: ACgBeo0+VQ75ZOIDp+nvjNR5MioQ5JAeMqJ7i1aPhlMPYUrH1AMeEHEV
        v7cU+4knJIVhXxdnzxkiC/KK0PMI4O0=
X-Google-Smtp-Source: AA6agR4mIrBI+VqdmK9XxquJrzUivZu8ctMQy2Mh5DPiMdzbr+5VMUvdiKSOqW1XRdAe5w+IQuXOVrbXRFY=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:1bfc:e7ee:6530:4449])
 (user=surenb job=sendgmr) by 2002:a63:2cc2:0:b0:41c:681d:60d2 with SMTP id
 s185-20020a632cc2000000b0041c681d60d2mr26204273pgs.502.1662053761168; Thu, 01
 Sep 2022 10:36:01 -0700 (PDT)
Date:   Thu,  1 Sep 2022 10:35:03 -0700
In-Reply-To: <20220901173516.702122-1-surenb@google.com>
Mime-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220901173516.702122-16-surenb@google.com>
Subject: [RFC PATCH RESEND 15/28] mm/mmap: mark adjacent VMAs as locked if
 they can grow into unmapped area
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        surenb@google.com, kernel-team@android.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
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

While unmapping VMAs, adjacent VMAs might be able to grow into the area
being unmapped. In such cases mark adjacent VMAs as locked to prevent
this growth.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mmap.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index b0d78bdc0de0..b31cc97c2803 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2680,10 +2680,14 @@ detach_vmas_to_be_unmapped(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * VM_GROWSUP VMA. Such VMAs can change their size under
 	 * down_read(mmap_lock) and collide with the VMA we are about to unmap.
 	 */
-	if (vma && (vma->vm_flags & VM_GROWSDOWN))
+	if (vma && (vma->vm_flags & VM_GROWSDOWN)) {
+		vma_mark_locked(vma);
 		return false;
-	if (prev && (prev->vm_flags & VM_GROWSUP))
+	}
+	if (prev && (prev->vm_flags & VM_GROWSUP)) {
+		vma_mark_locked(prev);
 		return false;
+	}
 	return true;
 }
 
-- 
2.37.2.789.g6183377224-goog

