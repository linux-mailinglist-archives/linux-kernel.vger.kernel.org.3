Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C0759F849
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 13:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236724AbiHXLAU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 Aug 2022 07:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236041AbiHXLAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 07:00:18 -0400
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1EC2ED59
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 04:00:14 -0700 (PDT)
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id E35F85FB51;
        Wed, 24 Aug 2022 13:00:12 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 7/6] mm: pagewalk: add back missing variable initializations
Date:   Wed, 24 Aug 2022 13:00:11 +0200
Message-ID: <2123960.ggj6I0NvhH@mobilepool36.emlix.com>
In-Reply-To: <3200642.44csPzL39Z@devpool047>
References: <3200642.44csPzL39Z@devpool047>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These initializations accidentially got lost during refactoring.

The first one can't actually be used without initialization, because
walk_p4d_range() is only called when one of the 4 callbacks is set, but relying
on this seems fragile.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Rolf Eike Beer <eb@emlix.com>
---
 mm/pagewalk.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Looks like my testing had just the right callbacks set so I never hit this. In 
case you want to have this squashed into the original one just drop me a note 
and I'll redo the whole series.

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index d8be8a30b272..22e4bcca9bee 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -223,7 +223,7 @@ static int walk_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
 
 	p4d = p4d_offset(pgd, addr);
 	do {
-		int err;
+		int err = 0;
 
 		next = p4d_addr_end(addr, end);
 		if (p4d_none_or_clear_bad(p4d)) {
@@ -262,7 +262,7 @@ static int walk_pgd_range(unsigned long addr, unsigned long end,
 	else
 		pgd = pgd_offset(walk->mm, addr);
 	do {
-		int err;
+		int err = 0;
 
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(pgd)) {
@@ -308,7 +308,7 @@ static int walk_hugetlb_range(unsigned long addr, unsigned long end,
 	const struct mm_walk_ops *ops = walk->ops;
 
 	for (; addr < end; addr = next) {
-		int err;
+		int err = 0;
 		pte_t *pte = huge_pte_offset(walk->mm, addr & hmask, sz);
 
 		next = hugetlb_entry_end(h, addr, end);
-- 
2.37.2

-- 
Rolf Eike Beer, emlix GmbH, https://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 Göttingen, Germany
Sitz der Gesellschaft: Göttingen, Amtsgericht Göttingen HR B 3160
Geschäftsführung: Heike Jordan, Dr. Uwe Kracke – Ust-IdNr.: DE 205 198 055

emlix - smart embedded open source


