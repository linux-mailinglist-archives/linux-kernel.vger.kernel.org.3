Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8AF551AEAA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377840AbiEDULz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358149AbiEDULt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:11:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B73220D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 13:08:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E62ACB828A5
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 20:08:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4141BC385B1;
        Wed,  4 May 2022 20:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651694889;
        bh=CGUidupZKZlTBIzgz45tkTfw8MnXPRqOctPSPdF1FH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q6z3UyTfDkC0XihPAQhouzs84LPDo5VJkIKLL9wAS7RfOiAy30FofvfXKz9I5Mmp7
         BGVfTInSZnNjpRLyzN0TFlDMBWwY4c9sLXDYYAeBQLit32p8Yw+HYE1lMcr6cD09P2
         +wUT5K992LOlny6psv6sqsvFo99x2kdBVHw9W3BpA89ahM2CWw3cWQ7bSAL8CC/Ww7
         maMrMISYQT5NdfGmui/vYh1AIsYwr6lTRFG/HvsAu3GUJZpTdFy46YU2Es4hR5hcXh
         9bFKeYbiaGQpLepoqbDH4+Yh1DsbGOX3L8ovHCvGfHhvsMhDC8AtN41XKhXPb9na/N
         NWLiV1aJk/4fg==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org, willy@infradead.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH for mm-unstable 3/3] mm/shmem: Use folio_test_transhuge() for THP check
Date:   Wed,  4 May 2022 20:07:58 +0000
Message-Id: <20220504200758.314478-4-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220504200758.314478-1-sj@kernel.org>
References: <20220504200758.314478-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 94cdf3e8c0bf ("mm/shmem: convert shmem_getpage_gfp to use a
folio") on 'mm-unstable' replaces 'PageTransHuge()' with
'folio_test_large()' instead of 'folio_test_transhuge()'.  This results
in below build error when 'CONFIG_TRANSPARENT_HUGEPAGE' is unset.

      CC      mm/shmem.o
    In file included from .../linux/include/linux/kernel.h:25,
                     from .../linux/arch/x86/include/asm/percpu.h:27,
                     from .../linux/arch/x86/include/asm/preempt.h:6,
                     from .../linux/include/linux/preempt.h:78,
                     from .../linux/include/linux/spinlock.h:55,
                     from .../linux/include/linux/wait.h:9,
                     from .../linux/include/linux/wait_bit.h:8,
                     from .../linux/include/linux/fs.h:6,
                     from .../linux/mm/shmem.c:24:
    .../linux/mm/shmem.c: In function ‘shmem_getpage_gfp.isra.0’:
    .../linux/include/linux/compiler_types.h:352:38: error: call to ‘__compiletime_assert_252’ declared with attribute error: BUILD_BUG failed
      352 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
          |                                      ^
    .../linux/include/linux/math.h:15:46: note: in definition of macro ‘__round_mask’
       15 | #define __round_mask(x, y) ((__typeof__(x))((y)-1))
          |                                              ^
    .../linux/mm/shmem.c:1900:12: note: in expansion of macro ‘round_down’
     1900 |   hindex = round_down(index, HPAGE_PMD_NR);
          |            ^~~~~~~~~~
    .../linux/include/linux/compiler_types.h:340:2: note: in expansion of macro ‘__compiletime_assert’
      340 |  __compiletime_assert(condition, msg, prefix, suffix)
          |  ^~~~~~~~~~~~~~~~~~~~
    .../linux/include/linux/compiler_types.h:352:2: note: in expansion of macro ‘_compiletime_assert’
      352 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
          |  ^~~~~~~~~~~~~~~~~~~
    .../linux/include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
          |                                     ^~~~~~~~~~~~~~~~~~
    .../linux/include/linux/build_bug.h:59:21: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
       59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
          |                     ^~~~~~~~~~~~~~~~
    .../linux/include/linux/huge_mm.h:307:28: note: in expansion of macro ‘BUILD_BUG’
      307 | #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
          |                            ^~~~~~~~~
    .../linux/include/linux/huge_mm.h:105:26: note: in expansion of macro ‘HPAGE_PMD_SHIFT’
      105 | #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
          |                          ^~~~~~~~~~~~~~~
    .../linux/include/linux/huge_mm.h:106:26: note: in expansion of macro ‘HPAGE_PMD_ORDER’
      106 | #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
          |                          ^~~~~~~~~~~~~~~
    .../linux/mm/shmem.c:1900:30: note: in expansion of macro ‘HPAGE_PMD_NR’
     1900 |   hindex = round_down(index, HPAGE_PMD_NR);
          |                              ^~~~~~~~~~~~
    In file included from <command-line>:
    .../linux/include/linux/compiler_types.h:352:38: error: call to ‘__compiletime_assert_253’ declared with attribute error: BUILD_BUG failed
      352 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
          |                                      ^
    .../linux/include/linux/compiler_types.h:333:4: note: in definition of macro ‘__compiletime_assert’
      333 |    prefix ## suffix();    \
          |    ^~~~~~
    .../linux/include/linux/compiler_types.h:352:2: note: in expansion of macro ‘_compiletime_assert’
      352 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
          |  ^~~~~~~~~~~~~~~~~~~
    .../linux/include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
          |                                     ^~~~~~~~~~~~~~~~~~
    .../linux/include/linux/build_bug.h:59:21: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
       59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
          |                     ^~~~~~~~~~~~~~~~
    .../linux/include/linux/huge_mm.h:307:28: note: in expansion of macro ‘BUILD_BUG’
      307 | #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
          |                            ^~~~~~~~~
    .../linux/include/linux/huge_mm.h:105:26: note: in expansion of macro ‘HPAGE_PMD_SHIFT’
      105 | #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
          |                          ^~~~~~~~~~~~~~~
    .../linux/include/linux/huge_mm.h:106:26: note: in expansion of macro ‘HPAGE_PMD_ORDER’
      106 | #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
          |                          ^~~~~~~~~~~~~~~
    .../linux/mm/shmem.c:1923:13: note: in expansion of macro ‘HPAGE_PMD_NR’
     1923 |    hindex + HPAGE_PMD_NR - 1) {
          |             ^~~~~~~~~~~~

Fixes: 94cdf3e8c0bf ("mm/shmem: convert shmem_getpage_gfp to use a folio")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/shmem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 3dc34a5a7923..c51d3532c962 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1888,7 +1888,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 		goto unlock;
 	}
 
-	if (folio_test_large(folio))
+	if (folio_test_transhuge(folio))
 		hindex = round_down(index, HPAGE_PMD_NR);
 	else
 		hindex = index;
@@ -1910,7 +1910,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 	spin_unlock_irq(&info->lock);
 	alloced = true;
 
-	if (folio_test_large(folio) &&
+	if (folio_test_transhuge(folio) &&
 	    DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE) <
 			hindex + HPAGE_PMD_NR - 1) {
 		/*
@@ -1973,7 +1973,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 unacct:
 	shmem_inode_unacct_blocks(inode, folio_nr_pages(folio));
 
-	if (folio_test_large(folio)) {
+	if (folio_test_transhuge(folio)) {
 		folio_unlock(folio);
 		folio_put(folio);
 		goto alloc_nohuge;
-- 
2.25.1

