Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABD259C0B3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbiHVNjF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 22 Aug 2022 09:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbiHVNjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:39:03 -0400
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2523A95BA
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 06:39:00 -0700 (PDT)
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 5DDBD601AF;
        Mon, 22 Aug 2022 15:04:37 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] mm: pagewalk: fix documentation of PTE hole handling
Date:   Mon, 22 Aug 2022 15:01:32 +0200
Message-ID: <3695521.kQq0lBPeGt@devpool047>
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

Empty PTEs are passed to the pte_entry callback, not to pte_hole.

Signed-off-by: Rolf Eike Beer <eb@emlix.com>
---
 include/linux/pagewalk.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index ac7b38ad5903..f3fafb731ffd 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -15,12 +15,12 @@ struct mm_walk;
  *			this handler is required to be able to handle
  *			pmd_trans_huge() pmds.  They may simply choose to
  *			split_huge_page() instead of handling it explicitly.
- * @pte_entry:		if set, called for each non-empty PTE (lowest-level)
- *			entry
+ * @pte_entry:		if set, called for each PTE (lowest-level) entry,
+ *			including empty ones
  * @pte_hole:		if set, called for each hole at all levels,
- *			depth is -1 if not known, 0:PGD, 1:P4D, 2:PUD, 3:PMD
- *			4:PTE. Any folded depths (where PTRS_PER_P?D is equal
- *			to 1) are skipped.
+ *			depth is -1 if not known, 0:PGD, 1:P4D, 2:PUD, 3:PMD.
+ *			Any folded depths (where PTRS_PER_P?D is equal to 1)
+ *			are skipped.
  * @hugetlb_entry:	if set, called for each hugetlb entry
  * @test_walk:		caller specific callback function to determine whether
  *			we walk over the current vma or not. Returning 0 means
-- 
2.37.2

-- 
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 Göttingen, Germany
Sitz der Gesellschaft: Göttingen, Amtsgericht Göttingen HR B 3160
Geschäftsführung: Heike Jordan, Dr. Uwe Kracke – Ust-IdNr.: DE 205 198 055

emlix - smart embedded open source



