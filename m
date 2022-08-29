Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150B45A5620
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiH2V0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiH2V03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:26:29 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCD8870A0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:25:58 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id e11-20020a17090a630b00b001f8b2deb88dso10114750pjj.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=iuFA+HN3YQAhGF4lKe/pszwBtaIFpTgsToRqXaNjG7k=;
        b=OQFmY5p6Pe2rtWh8HoOtibHP8P5GG7l2q0OSc7HNXnd2wSmQX9hqgXeo/WRhgSbde1
         3GOMVRznNWUQpWpM6oRymYxlQgfSmhokZzxHMaOud6hAHMI7hRSvRQgnpTP2D9VCRijV
         tvYOdRbm6MoDu4UgOmxt7sejA6CQywedGjOTRBl30ijbrDgQETYn5oZOqnGCtaAYcPZu
         MjsJRXAG04ApiH5Z6mU8Nc2C+hXCaIEB6zH7hUa5Up7nSwAgqcd3I/44d6H2f140ISuN
         zqINoaSTwBSBF/Nj+3hF7XpzbCbRiSR9QvteChaGaDG9beNmWGZas127F5+VFT8rM/v5
         R54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=iuFA+HN3YQAhGF4lKe/pszwBtaIFpTgsToRqXaNjG7k=;
        b=u/uylYtf8O8l9e2tYsxOIICBD831cj0Mr+VuPREElkRd5WgHSt4F8SYUk43taoUBqm
         0vSTrpSZhC9Bc4PxN78WIAz8MH3Y9qzpfpfV2c+oJ/2sdpmkgIEELxqzO4n2xCkOG4Kt
         f9pX/2h1/Olm45DVhet9v+r6PqxYNM26I/iByF+giiGixYkANadeaM5ZC7k/SvLFAS1s
         4NNTlg9kg854xFrfc0Bx/OInt7QxNjl+SEzmkWETKCaWgVpJrdlxSl25VRLYYCw7d5P3
         gubfo2DPo0bfcJH9lI70wFdTZcKMaM39+GRZuxlFcUeJZOvOP/HZ5ufd1TV4Jmsr272h
         N70Q==
X-Gm-Message-State: ACgBeo0NILJutH+bdlTPj5U2pY1QBtiq0Cjd19jWeyhQrheZ1mCA6xyu
        hDKOwckSaMozu31SdJ1T0q6NgsQAx4g=
X-Google-Smtp-Source: AA6agR67llFT6eQ0+3Cyyc4Z2yCAV5KwAp4HusV+mlw9qyUeJ6m9H2aBfcEzix7gu6JpzsX42cg/TQ27QPw=
X-Received: from surenb-spec.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e30])
 (user=surenb job=sendgmr) by 2002:a17:90a:e558:b0:1fb:c4b7:1a24 with SMTP id
 ei24-20020a17090ae55800b001fbc4b71a24mr21023pjb.1.1661808355887; Mon, 29 Aug
 2022 14:25:55 -0700 (PDT)
Date:   Mon, 29 Aug 2022 21:25:14 +0000
In-Reply-To: <20220829212531.3184856-1-surenb@google.com>
Mime-Version: 1.0
References: <20220829212531.3184856-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829212531.3184856-12-surenb@google.com>
Subject: [RFC PATCH 11/28] mm/mmap: mark VMAs as locked before merging or
 splitting them
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

Decisions about whether VMAs can be merged or split must be made while
VMAs are protected from the changes which can affect that decision.
For example, merge_vma uses vma->anon_vma in its decision whether the
VMA can be merged. Meanwhile, page fault handler changes vma->anon_vma
during COW operation.
Mark all VMAs which might be affected by a merge or split operation as
locked before making decision how such operations should be performed.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mmap.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index ed58cf0689b2..ade3909c89b4 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1147,10 +1147,17 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
 	if (vm_flags & VM_SPECIAL)
 		return NULL;
 
+	if (prev)
+		vma_mark_locked(prev);
 	next = vma_next(mm, prev);
 	area = next;
-	if (area && area->vm_end == end)		/* cases 6, 7, 8 */
+	if (area)
+		vma_mark_locked(area);
+	if (area && area->vm_end == end) {		/* cases 6, 7, 8 */
 		next = next->vm_next;
+		if (next)
+			vma_mark_locked(next);
+	}
 
 	/* verify some invariant that must be enforced by the caller */
 	VM_WARN_ON(prev && addr <= prev->vm_start);
@@ -2687,6 +2694,7 @@ int __split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
 	struct vm_area_struct *new;
 	int err;
 
+	vma_mark_locked(vma);
 	if (vma->vm_ops && vma->vm_ops->may_split) {
 		err = vma->vm_ops->may_split(vma, addr);
 		if (err)
-- 
2.37.2.672.g94769d06f0-goog

