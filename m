Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582CF5A561D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiH2V0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiH2V0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:26:15 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F3E6EF11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:25:52 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 92-20020a17090a09e500b001d917022847so3728626pjo.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=tMRmbcwOZDIFaTPxLY27tBFqvxpOSXiDeb2XTcL9iTc=;
        b=c5Ge838GLG1Fn9WCiifxSW0yY2J286Z3nb7CHVsgQeKl819oavnaneDjs0pHM1pBgc
         6/VXxA27srsSSYsH3q/5JQwqbG7gvhz/dxlqpfYYnChp/oSAOK1144eGZRxL5H4xfU4+
         gXjPirwbsBHls6abdkbd/Ru5neoY+5POLJLE67tmQyRoTq3+UExyJwB4xZoCc8lFIPHT
         1JLKkVoSr3hMYFs+x98zjjRcyw2xrS1rGfAXHEq+RyZfpGyhDpyGAbYsGbpBS3qHA7OY
         gUezPbUinXA9UrR8RhJyAbOsAhf2VqCoI/O3T8n1+HeqEuYCNoxrQ8z3jvR4TT/rnWyA
         atPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=tMRmbcwOZDIFaTPxLY27tBFqvxpOSXiDeb2XTcL9iTc=;
        b=WIUSLTwVEHYT0+Jviji8lyFug0u5mvHgjPSDqRHNXPXEfN+0/7ZqPLNXWJ5CAQX6NP
         2vGXH3lecPomVFQR+ObmUZFy9+vKvykol2eAVIa5r0o0A69vTkO3MHlWA+hMbC+qMmMw
         hXNX79bRrt7cG4njvWGkq8pf0jkO+A0+DVKQrwFE4lOWFYAJdBa7LXdn12Wc6+FymxGi
         JcYxUuuPSSKif8eDDY+g6S8XT+yqL3G8jPWWvHiWCvz0nhn5HbP+qTHd9BFQYz4BRu4o
         McahDhNKQen4b89UoVfco1mcW/fYtVNYBUygn6pKbRCEEsTmeApTvYQq8chqqgAkZ8Ke
         WmWg==
X-Gm-Message-State: ACgBeo0ZTkR5yWD+ZTR9YY+jKYDStAlOGEFerZGJwmHOvE/CK2xLJhj2
        YcVRAwioMFlCcbCFsbx2O9rXAdhD5iE=
X-Google-Smtp-Source: AA6agR6WFXWG6lBERn8fKgbng4pdY7+dFZ275Tti+4gL6MGpsob4z29fC0owAPSMM8vQ0mXhvHK4dQ+aJ1U=
X-Received: from surenb-spec.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e30])
 (user=surenb job=sendgmr) by 2002:a17:902:ab08:b0:173:320e:3316 with SMTP id
 ik8-20020a170902ab0800b00173320e3316mr17541232plb.38.1661808351535; Mon, 29
 Aug 2022 14:25:51 -0700 (PDT)
Date:   Mon, 29 Aug 2022 21:25:12 +0000
In-Reply-To: <20220829212531.3184856-1-surenb@google.com>
Mime-Version: 1.0
References: <20220829212531.3184856-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829212531.3184856-10-surenb@google.com>
Subject: [RFC PATCH 09/28] mm/mempolicy: mark VMA as locked when changing
 protection policy
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

Protect VMA from concurrent page fault handler while performing VMA
protection policy changes.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mempolicy.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index b73d3248d976..6be1e5c75556 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -383,8 +383,10 @@ void mpol_rebind_mm(struct mm_struct *mm, nodemask_t *new)
 	struct vm_area_struct *vma;
 
 	mmap_write_lock(mm);
-	for (vma = mm->mmap; vma; vma = vma->vm_next)
+	for (vma = mm->mmap; vma; vma = vma->vm_next) {
+		vma_mark_locked(vma);
 		mpol_rebind_policy(vma->vm_policy, new);
+	}
 	mmap_write_unlock(mm);
 }
 
@@ -632,6 +634,7 @@ unsigned long change_prot_numa(struct vm_area_struct *vma,
 	struct mmu_gather tlb;
 	int nr_updated;
 
+	vma_mark_locked(vma);
 	tlb_gather_mmu(&tlb, vma->vm_mm);
 
 	nr_updated = change_protection(&tlb, vma, addr, end, PAGE_NONE,
@@ -765,6 +768,7 @@ static int vma_replace_policy(struct vm_area_struct *vma,
 	if (IS_ERR(new))
 		return PTR_ERR(new);
 
+	vma_mark_locked(vma);
 	if (vma->vm_ops && vma->vm_ops->set_policy) {
 		err = vma->vm_ops->set_policy(vma, new);
 		if (err)
-- 
2.37.2.672.g94769d06f0-goog

