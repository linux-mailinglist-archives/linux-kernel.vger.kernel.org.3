Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602F951AEA9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377841AbiEDULx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358047AbiEDULt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:11:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CBE220DA
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 13:08:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6976FB828AB
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 20:08:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9264DC385A5;
        Wed,  4 May 2022 20:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651694889;
        bh=l7eT0YCpeIyaiOA8tAoT/I7aBBJZd/puxtWaxE/qRdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=acTZ0r0HmQrBpAl4JiIkr/1JwQysIT7dA0imdRA0R7z6Dkh2rR/at6yJGFZQqGTFO
         c7d+q3coF/bfQc8WSQKuUOk6s74cW23NR7bdC36gvxcuqvwL231KtPjgyN67wBkTp7
         200vDKxID6Y2z72M4lV1Gk7r6JPVkYZ8SRyzRSgfsdDSAG+eCmkHW4JCXTZ0QPShF/
         pbY7jqGrmfDDl6ERfoPW2D10ZFRQ/uu7tDkAZQdUEqP0dkuK6bcSL1GaaMbKY/uKV6
         cl6v8ufVOt/8Tieip+Yn703U8wBcnLz7LNPyhd+M0MNcznvsNta/8bx5iFOsOD1sf8
         JvBLhJx8HQ/0w==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org, willy@infradead.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH for mm-unstable 2/3] mm/shmem: Use folio_test_transhuge() for THP check
Date:   Wed,  4 May 2022 20:07:57 +0000
Message-Id: <20220504200758.314478-3-sj@kernel.org>
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

Commit 9a44f3462edc ("mm/shmem: convert shmem_add_to_page_cache to take
a folio") on 'mm-unstable' replaces 'PageTransHuge()' with
'folio_test_large()' instead of 'folio_test_transhuge()'.  This results
in below build error when 'CONFIG_TRANSPARENT_HUGEPAGE' is unset.

      CC      mm/shmem.o
    In file included from <command-line>:
    In function ‘shmem_add_to_page_cache’,
        inlined from ‘shmem_getpage_gfp.isra.0’ at .../linux/mm/shmem.c:1912:10:
    .../linux/include/linux/compiler_types.h:352:38: error: call to ‘__compiletime_assert_244’ declared with attribute error: BUILD_BUG failed
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
    .../linux/include/linux/vm_event_item.h:147:27: note: in expansion of macro ‘BUILD_BUG’
      147 | #define THP_FILE_ALLOC ({ BUILD_BUG(); 0; })
          |                           ^~~~~~~~~
    .../linux/mm/shmem.c:743:19: note: in expansion of macro ‘THP_FILE_ALLOC’
      743 |    count_vm_event(THP_FILE_ALLOC);
          |                   ^~~~~~~~~~~~~~

This commit fixes the issue by replacing the check to use
'folio_test_transhuge()'.

Fixes: 9a44f3462edc ("mm/shmem: convert shmem_add_to_page_cache to take a folio")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 6a18641a90ff..3dc34a5a7923 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -739,7 +739,7 @@ static int shmem_add_to_page_cache(struct folio *folio,
 		xas_store(&xas, folio);
 		if (xas_error(&xas))
 			goto unlock;
-		if (folio_test_large(folio)) {
+		if (folio_test_transhuge(folio)) {
 			count_vm_event(THP_FILE_ALLOC);
 			__lruvec_stat_mod_folio(folio, NR_SHMEM_THPS, nr);
 		}
-- 
2.25.1

