Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69974E9017
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 10:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239317AbiC1I0h convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Mar 2022 04:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiC1I0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 04:26:35 -0400
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A75DDEA8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 01:24:54 -0700 (PDT)
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id B58C35F8EA;
        Mon, 28 Mar 2022 10:24:52 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: mm: use mmap_assert_write_locked() instead of open coding it
Date:   Mon, 28 Mar 2022 10:24:51 +0200
Message-ID: <5827758.TJ1SttVevJ@mobilepool36.emlix.com>
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

In case the lock is actually not held at this point this also avoids a
stale lock reference if built with NDEBUG.

Signed-off-by: Rolf Eike Beer <eb@emlix.com>
---
 mm/mmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 3aa839f81e63..d62598dc2fdd 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3561,7 +3561,7 @@ int mm_take_all_locks(struct mm_struct *mm)
 	struct vm_area_struct *vma;
 	struct anon_vma_chain *avc;
 
-	BUG_ON(mmap_read_trylock(mm));
+	mmap_assert_write_locked(mm);
 
 	mutex_lock(&mm_all_locks_mutex);
 
@@ -3641,7 +3641,7 @@ void mm_drop_all_locks(struct mm_struct *mm)
 	struct vm_area_struct *vma;
 	struct anon_vma_chain *avc;
 
-	BUG_ON(mmap_read_trylock(mm));
+	mmap_assert_write_locked(mm);
 	BUG_ON(!mutex_is_locked(&mm_all_locks_mutex));
 
 	for (vma = mm->mmap; vma; vma = vma->vm_next) {
-- 
2.35.1


-- 
Rolf Eike Beer, emlix GmbH, https://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 Göttingen, Germany
Sitz der Gesellschaft: Göttingen, Amtsgericht Göttingen HR B 3160
Geschäftsführung: Heike Jordan, Dr. Uwe Kracke – Ust-IdNr.: DE 205 198 055

emlix - smart embedded open source


