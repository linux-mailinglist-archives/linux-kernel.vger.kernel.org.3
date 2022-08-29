Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75FB5A5626
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiH2V11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiH2V0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:26:48 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BC49E2D7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:26:12 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id q14-20020a6557ce000000b0041da9c3c244so4589013pgr.22
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=KQbM9RENeAKpMamE0B+V4MUsqhzbhGXDlXXjmQQUA6A=;
        b=B9JYMkX5xydBJOgcGzuYw+brQarCWmRWS+0/Aqinb/OY26MbR1xT5axtOfpYrKlmA6
         qGVi7LP6LaJMDcQJmEECw3J6IqaSMiez5M7VUbq2lZEZKkVSQHjZtuqy9g7s10YpHljB
         L9LJY/vXV43u8aIw7/j+LcG51+Bdx5jgIt7f2hLczg1JgYzlwTyYBe/lmm+nmwMuVZWc
         thodE+2BI084oTXFC0MD73T0ggmHuAL+ik6FuitgxrIkPY+yM+/axTrbJYGoWGabXb1/
         atpqGKZe5bOiVGcNY/fR8gQx2/9qiwRjzQjgpRwLojxFdTcGDVT+d94c/I/T/XPhcGEF
         rEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=KQbM9RENeAKpMamE0B+V4MUsqhzbhGXDlXXjmQQUA6A=;
        b=RfwsNpyC3LqPhSXyAshMhZDi4oprDbnC90X+B8ciWreFBIwzFr+0vElvtUBl0la/9o
         BjiFSdQc5ti8mt1NbmMa9XyctMt3zlh+6iUOnJfkNcGDkrnizi6xhtiVCErRk6pqEcao
         wX0JcYTSHTi4Ihk+sQPfK9L59UPshNUA2BIcXfpU7kZpkA2hiNfccJn4OboZHHfEzmhQ
         eh8h4GcokCImGl53P8gl0ESl0rVcnTHfv3Yn3l/yqIstz63M3yTIdN9pNiE9mN8PBP+W
         yhbb8yg9Z8sN/bctryQ6uNxvKnRxFVPkvhGuD5TbILnuRcEhtLSecPy77+v12txyPwB3
         QE+Q==
X-Gm-Message-State: ACgBeo28Gq0uxKLao158logo/5iAqadwRQy2l4rb9dCepQkq9qwvAu3k
        jc0dfOELacaKs9+7cVTwJDgpJdIS1NY=
X-Google-Smtp-Source: AA6agR7f4s+E2TUUdzlInwBIWNCTTjaS2dHpmImL6O3kfzXJ6rCAm5H+xn8nFf0AEemGeSJLYPdhv1d/+n8=
X-Received: from surenb-spec.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e30])
 (user=surenb job=sendgmr) by 2002:a05:6a00:b8a:b0:537:f81:203a with SMTP id
 g10-20020a056a000b8a00b005370f81203amr18341111pfj.80.1661808363176; Mon, 29
 Aug 2022 14:26:03 -0700 (PDT)
Date:   Mon, 29 Aug 2022 21:25:18 +0000
In-Reply-To: <20220829212531.3184856-1-surenb@google.com>
Mime-Version: 1.0
References: <20220829212531.3184856-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829212531.3184856-16-surenb@google.com>
Subject: [RFC PATCH 15/28] mm/mmap: mark adjacent VMAs as locked if they can
 grow into unmapped area
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, riel@surriel.com,
        luto@kernel.org, songliubraving@fb.com, peterx@redhat.com,
        david@redhat.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        rientjes@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, surenb@google.com, kernel-team@android.com,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
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
2.37.2.672.g94769d06f0-goog

