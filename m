Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA385A9E33
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbiIARg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbiIARfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:35:53 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74522550A0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:35:49 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k13-20020a056902024d00b0066fa7f50b97so4871347ybs.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 10:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=DiVLSVAVO410fRJcvWWuX+r6LjGy2i2DyacaHp6fzuc=;
        b=kNx38Jhqjx9XlmKxOVsRKukj17KeQAoUkvOgezSjJcI7qDa8s6siy6+ZCSn18LnVHi
         n4QLcTPTYnWQedOp2NOA065emr+I7/FhDV/20btA2UJprNGZCfJvY2fzU6JS3rffkIEf
         2FurYAnF0+QmVLyL1XlOy/6eS9/B08Rzb+EHT4ihXLuAM0YGViLuLR9Pls5xzIb0RA++
         peqVg5K5+yJOyniQSXXLxLw8N9e7jk4WJ8bD01w4ADM9IUXJZsw/A2NPWpCJiNE61osh
         1/9xE4X1j0QNkz0GiHjK4YBUmosqgJkbBEuUlP/cGGRjR6eOLhrxcNhT+yoJZX8wCM9W
         ZvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=DiVLSVAVO410fRJcvWWuX+r6LjGy2i2DyacaHp6fzuc=;
        b=7ekAz4mLnVAxKR2v3dmk1xNqJd3ISd8IlXp8J+sWBYpVxT2qulxTYsJHDL4r1pwM0V
         5K0hypH/tyk8WjpE1XGMWWInlwCsJGjCijN4++FbQGV97y2ZnV73gtSTvVhd+5fIguwk
         VAKjSb52OY9bXjzsG2yggmyYY0tJnyeBmhKp9Q+eD97I3PfpeozZiSG7atCtMfGAlWHO
         FefUHhYtmWHG4DWsuuKf1ww0E+hRDVdJ06xX5LIWJ/QkH8WcSeSUoj+SY3nz42UagfJa
         dqxRjO26KjlPPU/v2NJiCFnZCIqtsn/tpP81sc93zk9vrBu13XDZH046hFx0G79yYUF9
         QZVQ==
X-Gm-Message-State: ACgBeo1KkLlxnaqOP9JObHF1CA5v7AynNkF36tw4ENlm8d+p8MgzqWqg
        rIVraZT80p4AXkKTCE+nJVkh9bN31YM=
X-Google-Smtp-Source: AA6agR4qMG/7UuuiqhHhvohWNal3nFjDJKXC1X/Q7rlLCDCvl4ZyXaMMKRMmizmDLQF7LDsGfEt+/G6N4D4=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:1bfc:e7ee:6530:4449])
 (user=surenb job=sendgmr) by 2002:a25:bf92:0:b0:695:8d8f:2af4 with SMTP id
 l18-20020a25bf92000000b006958d8f2af4mr20427159ybk.200.1662053748060; Thu, 01
 Sep 2022 10:35:48 -0700 (PDT)
Date:   Thu,  1 Sep 2022 10:34:58 -0700
In-Reply-To: <20220901173516.702122-1-surenb@google.com>
Mime-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220901173516.702122-11-surenb@google.com>
Subject: [RFC PATCH RESEND 10/28] mm/mmap: mark VMAs as locked in vma_adjust
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

vma_adjust modifies a VMA and possibly its neighbors. Mark them as locked
before making the modifications.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mmap.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index f89c9b058105..ed58cf0689b2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -710,6 +710,10 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 	long adjust_next = 0;
 	int remove_next = 0;
 
+	vma_mark_locked(vma);
+	if (next)
+		vma_mark_locked(next);
+
 	if (next && !insert) {
 		struct vm_area_struct *exporter = NULL, *importer = NULL;
 
@@ -754,8 +758,11 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 			 * If next doesn't have anon_vma, import from vma after
 			 * next, if the vma overlaps with it.
 			 */
-			if (remove_next == 2 && !next->anon_vma)
+			if (remove_next == 2 && !next->anon_vma) {
 				exporter = next->vm_next;
+				if (exporter)
+					vma_mark_locked(exporter);
+			}
 
 		} else if (end > next->vm_start) {
 			/*
@@ -931,6 +938,8 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 			 * "vma->vm_next" gap must be updated.
 			 */
 			next = vma->vm_next;
+			if (next)
+				vma_mark_locked(next);
 		} else {
 			/*
 			 * For the scope of the comment "next" and
-- 
2.37.2.789.g6183377224-goog

