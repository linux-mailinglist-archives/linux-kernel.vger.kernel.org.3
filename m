Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B324E8FEA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 10:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239228AbiC1IRs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Mar 2022 04:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239230AbiC1IRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 04:17:45 -0400
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE36344E8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 01:16:01 -0700 (PDT)
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 0289A5F8ED;
        Mon, 28 Mar 2022 10:16:00 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     Vineet Gupta <vgupta@kernel.org>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arc: drop definitions of pgd_index() and pgd_offset{,_k}() entirely
Date:   Mon, 28 Mar 2022 10:15:58 +0200
Message-ID: <3749315.OSCKaROI16@mobilepool36.emlix.com>
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

They were in <asm/pgtables.h> and have been removed from there in
974b9b2c68f ("mm: consolidate pte_index() and pte_offset_*() definitions")
in favor of the generic version. But that missed that the same definitons
also existed in <asm/pgtable-levels.h>, where they were (inadvertently?)
introduced in fe6cb7b043b6 ("ARC: mm: disintegrate pgtable.h into levels
and flags").

Fixes: 974b9b2c68f ("mm: consolidate pte_index() and pte_offset_*() definitions")
Fixes: fe6cb7b043b6 ("ARC: mm: disintegrate pgtable.h into levels and flags")
Signed-off-by: Rolf Eike Beer <eb@emlix.com>
---
 arch/arc/include/asm/pgtable-levels.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arc/include/asm/pgtable-levels.h b/arch/arc/include/asm/pgtable-levels.h
index 7848348719b2..64ca25d199be 100644
--- a/arch/arc/include/asm/pgtable-levels.h
+++ b/arch/arc/include/asm/pgtable-levels.h
@@ -98,9 +98,6 @@
 /*
  * 1st level paging: pgd
  */
-#define pgd_index(addr)		((addr) >> PGDIR_SHIFT)
-#define pgd_offset(mm, addr)	(((mm)->pgd) + pgd_index(addr))
-#define pgd_offset_k(addr)	pgd_offset(&init_mm, addr)
 #define pgd_ERROR(e) \
 	pr_crit("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
 
-- 
2.35.1


-- 
Rolf Eike Beer, emlix GmbH, https://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 Göttingen, Germany
Sitz der Gesellschaft: Göttingen, Amtsgericht Göttingen HR B 3160
Geschäftsführung: Heike Jordan, Dr. Uwe Kracke – Ust-IdNr.: DE 205 198 055

emlix - smart embedded open source


