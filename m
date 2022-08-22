Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D613B59C0A4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbiHVNeK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 22 Aug 2022 09:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbiHVNeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:34:02 -0400
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F1E15A0C
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 06:34:00 -0700 (PDT)
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 575EF601A4;
        Mon, 22 Aug 2022 15:04:37 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] mm: pagewalk: don't check vma in walk_page_range_novma()
Date:   Mon, 22 Aug 2022 15:00:47 +0200
Message-ID: <21585888.EfDdHjke4D@devpool047>
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

Directly call walk_pgd_range() as that is everything that will actually
happen in __walk_page_range() besides checking if the vma is set.

Signed-off-by: Rolf Eike Beer <eb@emlix.com>
---
 mm/pagewalk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index c67b2532db8f..a06eb100fe4e 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -517,7 +517,7 @@ int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
 
 	mmap_assert_locked(walk.mm);
 
-	return __walk_page_range(start, end, &walk);
+	return walk_pgd_range(start, end, &walk);
 }
 
 int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
-- 
2.37.2


-- 
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 Göttingen, Germany
Sitz der Gesellschaft: Göttingen, Amtsgericht Göttingen HR B 3160
Geschäftsführung: Heike Jordan, Dr. Uwe Kracke – Ust-IdNr.: DE 205 198 055

emlix - smart embedded open source



