Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4890F59C077
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbiHVNYO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 22 Aug 2022 09:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234669AbiHVNYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:24:10 -0400
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE2827CED
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 06:24:09 -0700 (PDT)
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 413A15FCA6;
        Mon, 22 Aug 2022 15:04:37 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] mm: pagewalk: allow walk_page_range_novma() without mm
Date:   Mon, 22 Aug 2022 15:03:29 +0200
Message-ID: <5760214.MhkbZ0Pkbq@devpool047>
Organization: emlix GmbH
In-Reply-To: <3200642.44csPzL39Z@devpool047>
References: <3200642.44csPzL39Z@devpool047>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since e47690d756a7 ("x86: mm: avoid allocating struct mm_struct on the
stack") a pgd can be passed to walk_page_range_novma(). In case it is set
no place in the pagewalk code use the walk.mm anymore, so permit to pass a
NULL mm instead. It is up to the caller to ensure proper locking on the pgd
in this case.

Signed-off-by: Rolf Eike Beer <eb@emlix.com>
---
 mm/pagewalk.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index dc3c850cd148..f816f86588be 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -506,6 +506,8 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
  * not backed by VMAs. Because 'unusual' entries may be walked this function
  * will also not lock the PTEs for the pte_entry() callback. This is useful for
  * walking the kernel pages tables or page tables for firmware.
+ *
+ * Either mm or pgd may be NULL, but not both.
  */
 int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
 			  unsigned long end, const struct mm_walk_ops *ops,
@@ -520,10 +522,11 @@ int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
 		.no_vma		= true
 	};
 
-	if (start >= end || !walk.mm)
+	if (start >= end || (!walk.mm && !walk.pgd))
 		return -EINVAL;
 
-	mmap_assert_locked(walk.mm);
+	if (walk.mm)
+		mmap_assert_locked(walk.mm);
 
 	return walk_pgd_range(start, end, &walk);
 }
-- 
2.37.2

-- 
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 Göttingen, Germany
Sitz der Gesellschaft: Göttingen, Amtsgericht Göttingen HR B 3160
Geschäftsführung: Heike Jordan, Dr. Uwe Kracke – Ust-IdNr.: DE 205 198 055

emlix - smart embedded open source



