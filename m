Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E43A51AEA7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357948AbiEDULs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiEDULq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:11:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC91220E9
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 13:08:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 099636156B
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 20:08:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35D0C385AE;
        Wed,  4 May 2022 20:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651694888;
        bh=hP6DONQx8HT3ciq95qC7cLt2aYlwi23SKeG+VbaD1mM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TF4t+dOV6Kb8lkG8GJVR1PoreKUgXBn1VlnhrosNyEUKEbZ2MTsmJ+gYBjVpiXxzU
         Co9ZOCrpB4hXv7plOP34gvW0o7zI+bFt5qo+Kskv+ZtZ6fDPkT4zuVAUoZ13hS2C8A
         daRPV2DIU6FPf6wqxyGgAuXWGDR38+AXruvoORNQ6F1E1CMLT3NgiKbG4grAT2zfe/
         vNue9Hrsixh9TsMHC5NUd7vzr6d5IbkDzfWWDDd7i2oWheN23VVKbNuHBrMRzFcGPQ
         f4+B9l3P20s2k7J2aADAwQ274Q1C3JV1HceRzSzR5qJkUSRgiB0yLf5fW9z9LhLAqu
         Ta725knLj9gDg==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org, willy@infradead.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH for mm-unstable 1/3] mm/vmscan: Use folio_test_transhuge() for THP check
Date:   Wed,  4 May 2022 20:07:56 +0000
Message-Id: <20220504200758.314478-2-sj@kernel.org>
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

Commit 22bf1b68e572 ("vmscan: remove remaining uses of page in
shrink_page_list") on 'mm-unstable' replaces 'PageTransHuge()' with
'folio_test_large()' instead of 'folio_test_transhuge()'.  This results
in below build error when 'CONFIG_TRANSPARENT_HUGEPAGE' is unset.

      CC      mm/vmscan.o
    In file included from <command-line>:
    In function ‘can_split_folio’,
        inlined from ‘shrink_page_list’ at .../linux/mm/vmscan.c:1719:11:
    .../linux/include/linux/compiler_types.h:352:38: error: call to ‘__compiletime_assert_178’ declared with attribute error: BUILD_BUG failed
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
    .../linux/include/linux/huge_mm.h:351:2: note: in expansion of macro ‘BUILD_BUG’
      351 |  BUILD_BUG();
          |  ^~~~~~~~~

This commit fixes the issue by replacing the check to use
'folio_test_transhuge()'.

Fixes: 22bf1b68e572 ("vmscan: remove remaining uses of page in shrink_page_list")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 40cda196d802..5a0f081a7be5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1714,7 +1714,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 					goto keep_locked;
 				if (folio_maybe_dma_pinned(folio))
 					goto keep_locked;
-				if (folio_test_large(folio)) {
+				if (folio_test_transhuge(folio)) {
 					/* cannot split folio, skip it */
 					if (!can_split_folio(folio, NULL))
 						goto activate_locked;
-- 
2.25.1

