Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F2C5A230F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 10:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343589AbiHZIcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 04:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343630AbiHZIcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:32:02 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3CDD4775
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 01:32:00 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id t129so921063pfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 01:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=HGwS3OwkfwDxERtuzQGvNMSPhF82bFpGx5C7eTjqwZo=;
        b=EPsyWypD33QcVW4SCyLjAm9PAiP16Aj8PplboIwAG/F66l5bvFtyXub0S7WHdAx3EH
         N9PCD+XOwb/KBcvxL1uy4doXAtRsIDC7ueYEzzMtjBcXDUuHksCdFVskFESSOvWsgpWt
         vCs/zq0HAtll3C4ovMN8CXWmai49o6E6h+sZLygFGpeKpuWEVP2AMUjBiMMqeT4Yssoo
         68zWlRK3v3lAg9jc5xGgIZQ7YA3sE4ctnU34tTk7TS5PDC3IbOo1Hw/R1nj8PthFLidU
         RdLRci6dShTBBs+h3TWCGOr3Dwl2af/URPZbiP0bg7mewFQ557XGTouLcE27U/3NE7XH
         jyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=HGwS3OwkfwDxERtuzQGvNMSPhF82bFpGx5C7eTjqwZo=;
        b=I2sMV2KyKfR8bZFIE3Poti639lEUi0dqNeWFlP/q0l/9YWY3wIimXYCX+bn/Ju54Xe
         YMZzqkSz6PJFOcuBc1XaAPy79SyDT5elAsbnnbz8dYEUWTUU/qRxOwFDFtLZ0QUiSQE9
         v5S4ACjP7l7t4qfOGNPjgTGr3jyF07A+NGw0Xz4YYwCoFkvWaGGhhIq1bo7g5ccU0t7F
         UcA8sRRhKJGuYv+zpeSlCaVlciDY0Z2TexBa8gJDWRT2wC3K1l+AXKeEleHpZbKCtgW5
         nwSt1kGkEU0cNRmFYcnS0WrBRgmG1akER1qufxdM0zQGf9kISTQ0RF0k1yLJDq68QYaz
         B8Pg==
X-Gm-Message-State: ACgBeo3JWBXqF3++QFyNoTZsDoy6RqlzZAa1M5Dzu4086IVwVsRyFSow
        ZxeCrE4e4ydijgeIXyk27A==
X-Google-Smtp-Source: AA6agR5e26Dd4o1ct1Xh53Ya1Lc3TsdTH+bpgF9eqipht0V/Vb1I+zPgvR7uzY7+6zK5KFDxUqDtfQ==
X-Received: by 2002:a63:1e1b:0:b0:42b:5561:529e with SMTP id e27-20020a631e1b000000b0042b5561529emr2435166pge.514.1661502720074;
        Fri, 26 Aug 2022 01:32:00 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902714200b0016f1ef2cd44sm934953plm.154.2022.08.26.01.31.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Aug 2022 01:31:59 -0700 (PDT)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH 2/2] mm/damon/vaddr: remove comparison between mm and last_mm when checking region accesses
Date:   Fri, 26 Aug 2022 16:31:18 +0800
Message-Id: <1661502678-19336-3-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1661502678-19336-1-git-send-email-kaixuxia@tencent.com>
References: <1661502678-19336-1-git-send-email-kaixuxia@tencent.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

The damon regions that belong to the same damon target have the same
'struct mm_struct *mm', so it's unnecessary to compare the mm and last_mm
objects among the damon regions in one damon target when checking accesses.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 mm/damon/vaddr.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index c8c2f306bb6d..db9d0ab37a52 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -534,14 +534,13 @@ static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
  */
 static void __damon_va_check_access(struct mm_struct *mm, struct damon_region *r)
 {
-	static struct mm_struct *last_mm;
 	static unsigned long last_addr;
 	static unsigned long last_page_sz = PAGE_SIZE;
 	static bool last_accessed;
 
 	/* If the region is in the last checked page, reuse the result */
-	if (mm == last_mm && (ALIGN_DOWN(last_addr, last_page_sz) ==
-				ALIGN_DOWN(r->sampling_addr, last_page_sz))) {
+	if (ALIGN_DOWN(last_addr, last_page_sz) ==
+				ALIGN_DOWN(r->sampling_addr, last_page_sz)) {
 		if (last_accessed)
 			r->nr_accesses++;
 		return;
@@ -551,7 +550,6 @@ static void __damon_va_check_access(struct mm_struct *mm, struct damon_region *r
 	if (last_accessed)
 		r->nr_accesses++;
 
-	last_mm = mm;
 	last_addr = r->sampling_addr;
 }
 
-- 
2.27.0

