Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FACC5A561C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiH2V0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiH2V0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:26:13 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE5874B96
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:25:51 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id 125-20020a621483000000b0053814ac4b8bso1875870pfu.16
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=ooNZAin4dExMhxnzVFEqRWXW+87JR2sLE0fevcXKZcM=;
        b=I4AROHhc91xv1qcH3nCi9ZpRLfIZ0YYOknUuCx0UCVegrJDEOhp2xXx6sXe9aCLn1C
         FzO21jqONtvqpljlp8Pb4Y+CdSx9zRBCbsYcOU1CMA6tT/zAnvmRorbY0bmK2T02uMkI
         Atv+IFZLAVnvs+tVzbF09RqlClFEsd0HUKtTSkQ+YRbpf3d4jB4ZfuXvxVp5TLyaLLyx
         AxdLnxV0cUJcHwzUd+Lxky4P92oXj4Xhl4or9fJrlsG5GoIvzarsCtdrQ2b29IJKR80y
         NIBWQdZUPTZNVXZAtYrsTzYsNpAhtyZg3hqM9pNuOBs9nY5UdbnMfXBZJ7yLdA5TAp1d
         MxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=ooNZAin4dExMhxnzVFEqRWXW+87JR2sLE0fevcXKZcM=;
        b=nRixvNdDUbgvxI/59c0ksaZZh8aXERwYbz4uRgcusa62rZxma/LuKlReAZGUE1XjvJ
         GGdvVFvt+eMmmDqDyEoVJSzpq4Bni8A9DcwwTZCS2Vm31hb4jH2YaiTQJECwFR2DW00U
         h3VY5i0yP2znJQJ+95nqM8MuQw25KBzGj2Rmfn6wV9rJfShWHV7OKYNEjX7Vw9NUI9yH
         kaIk8CHU04RBBFBhUHd8NmPbhd2ewrj9g0eCISL1ugNn6UZFsx0Dsa/AxzQ8iKKoVT2h
         J7nS9oDRte4Cf5W//WAZuGNrFUMhutPsTYuMjwFWKKAWGvdGRb/T5ihDVoeN7jeshJb1
         XAzg==
X-Gm-Message-State: ACgBeo3TzOsfZIwUjsbnSt9vnMOJecOyYdr1cZAT9VrP7IvDNKlQzAsJ
        iZjoocg6wsDydyc92BRPsRnnbHE30lM=
X-Google-Smtp-Source: AA6agR6Ch+8H2P4ZiI/nyVX9BprKXIg4wSUP+mENwsodRVHrGORNiLr4bLOGgyZYxzbEnnQphTeE0ezRPcY=
X-Received: from surenb-spec.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e30])
 (user=surenb job=sendgmr) by 2002:a17:90a:4607:b0:1fa:f794:2c0d with SMTP id
 w7-20020a17090a460700b001faf7942c0dmr20939608pjg.24.1661808349897; Mon, 29
 Aug 2022 14:25:49 -0700 (PDT)
Date:   Mon, 29 Aug 2022 21:25:11 +0000
In-Reply-To: <20220829212531.3184856-1-surenb@google.com>
Mime-Version: 1.0
References: <20220829212531.3184856-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829212531.3184856-9-surenb@google.com>
Subject: [RFC PATCH 08/28] mm/khugepaged: mark VMA as locked while collapsing
 a hugepage
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

Protect VMA from concurrent page fault handler while modifying it in
collapse_huge_page.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/khugepaged.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 01f71786d530..030680633989 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1072,6 +1072,7 @@ static void collapse_huge_page(struct mm_struct *mm,
 	if (mm_find_pmd(mm, address) != pmd)
 		goto out_up_write;
 
+	vma_mark_locked(vma);
 	anon_vma_lock_write(vma->anon_vma);
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, NULL, mm,
-- 
2.37.2.672.g94769d06f0-goog

