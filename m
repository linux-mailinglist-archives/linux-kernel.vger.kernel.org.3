Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4715A9E29
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbiIARhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbiIARgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:36:02 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF2685F89
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:35:51 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-340ae84fb7dso202788047b3.17
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 10:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=IUrOZBQLzZPUHaSf75EcaCRmzwc/1Uln8Bhr3CCRW40=;
        b=RqTxEDKmKz8lQ9e4qoEc4uYxV2l6ZaYMJyNDEM2PccdKcjIk6CnRCwBsEF2cj3JFvG
         j1vM9+I5MFJ8Y28kW9pfnzwXL/sLYGBlEyABKHcApM/RmMkSzapOCNpQMv7qth5lMe9Z
         r4q/GOZemPIxyE1pZ9TWp0QmyjLs2nHHEkPOAyS+5ktrUUhx4EO8hL8MjHB9ieBIjUIm
         Yg7XSf+rAL+v2NSP5NDXERvFs20Phv4/bhur7fMLyFA6L2AN5XBQFKbc4pQ3AuRWkJ+n
         hhBQmROSc08GaGFWWbM/WsNha74+z1T1INvujKYoiSdnjlDI7QzZLxl1fThOa82IPdUF
         4lpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=IUrOZBQLzZPUHaSf75EcaCRmzwc/1Uln8Bhr3CCRW40=;
        b=4SuKl4rV9Gh3ZTRZQaLRao/8FA/e97RULa5AOKfbfBUIpANlzIaYV9O6NaT53StVuK
         lvCUph7fR1cP0hBQ7Ob9LAjrYZRJFBL1ROV0tvtHXpmm15x5MHC3U2R+yd1nQQpMH+xo
         ZVwqVb/2LlQD0H+hX5IUliBJTLmG3P1nmsX6rvDhxJ2sLdawKIJkNSVH8nfW6qIV3oQi
         73nwBp61XYm0kP1ksNgNUEUtPULa/jjRVWAFNxTcgp33Am/f5twbAkiI8QzAXgycfCYK
         ZrSKVLjqk/bGGSPgVzXRhgXJaUQrlqro+dZBzQ314VKauMbJa0wEmFNo45PDt62NDk52
         y+fQ==
X-Gm-Message-State: ACgBeo04PrR3BI2Jml1aCX1sHSFie3A7dFA04SaP8zbXGqpX7ph94t92
        41QKm0IDYi+oDl6RXEWn4jLdSZ+gxTo=
X-Google-Smtp-Source: AA6agR7hyHeb8khg+/3ZoJp3oFVauMFyBSatbGnIGl1CpSfGDYZylUwLzf/LZXvggze+7Aght5uln8kJbB0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:1bfc:e7ee:6530:4449])
 (user=surenb job=sendgmr) by 2002:a0d:e083:0:b0:343:2928:867f with SMTP id
 j125-20020a0de083000000b003432928867fmr6902464ywe.467.1662053750534; Thu, 01
 Sep 2022 10:35:50 -0700 (PDT)
Date:   Thu,  1 Sep 2022 10:34:59 -0700
In-Reply-To: <20220901173516.702122-1-surenb@google.com>
Mime-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220901173516.702122-12-surenb@google.com>
Subject: [RFC PATCH RESEND 11/28] mm/mmap: mark VMAs as locked before merging
 or splitting them
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
2.37.2.789.g6183377224-goog

