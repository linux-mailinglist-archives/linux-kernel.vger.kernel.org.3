Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D18C4AEEC7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 11:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbiBIJ7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 04:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbiBIJ6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 04:58:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0B9E04F313
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 01:58:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4DBF2B81FC2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 09:42:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4EA0C340E7;
        Wed,  9 Feb 2022 09:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644399736;
        bh=T+mYubC4DgSvWYTBn4SckuteBDQWitfpW4vxCFz9Xd8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t17a+03WpPX5fsyUkiVTqQQb7z0JMhqNvZlsnI+WEPj7FkoPewMVPVXjflLcg9EE9
         GsHvy14RTTWBaoF2mawz3tHmklfaoojB+PysLINwOETeXVm84mCSMlG1FAA3H1snEd
         nugn54oDNGmkwczq7cQREbfICXYt2kEMFIPGXxp7oCH1Guz/yDneb7XqNTO6Uafq7e
         rNE8DkCmHqu+OtgKl/G87Riq5oSpyI+VbyTr90CKlW6dcJ5nASv8Z9sBw9M6xPPmIu
         PCEcpl30FDfNoqir6Up3C785j80M0mbJwjo+50juCR7xJouMdlDWZlZnHOCcJAgyjq
         hq4lCIIWCdeIw==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>, hughd@google.com
Subject: [PATCH for-mm 1/2] mm/internal: Implement no-op mlock_page_drain() for !CONFIG_MMU
Date:   Wed,  9 Feb 2022 09:41:57 +0000
Message-Id: <20220209094158.21941-2-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220209094158.21941-1-sj@kernel.org>
References: <20220209094158.21941-1-sj@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4b3b8bd6c8287 ("mm/munlock: mlock_page() munlock_page() batch by
pagevec") in -mm tree[1] implements 'mlock_page_drain()' under
CONFIG_MMU only, but the function is used by 'lru_add_drain_cpu()',
which defined outside of CONFIG_MMU.  As a result, below build error
occurs.

    /linux/mm/swap.c: In function 'lru_add_drain_cpu':
    /linux/mm/swap.c:637:2: error: implicit declaration of function 'mlock_page_drain' [-Werror=implicit-function-declaration]
      637 |  mlock_page_drain(cpu);
          |  ^~~~~~~~~~~~~~~~
    cc1: some warnings being treated as errors
    /linux/scripts/Makefile.build:289: recipe for target 'mm/swap.o' failed

This commit fixes it by implementing no-op 'mlock_page_drain()' for
!CONFIG_MMU case, similar to 'mlock_new_page()'.

[1] https://www.ozlabs.org/~akpm/mmotm/broken-out/mm-munlock-mlock_page-munlock_page-batch-by-pagevec.patch

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/internal.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/internal.h b/mm/internal.h
index 0d240e876831..248224369b34 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -508,6 +508,7 @@ static inline void mlock_vma_page(struct page *page,
 static inline void munlock_vma_page(struct page *page,
 			struct vm_area_struct *vma, bool compound) { }
 static inline void mlock_new_page(struct page *page) { }
+static inline void mlock_page_drain(int cpu) { }
 static inline void vunmap_range_noflush(unsigned long start, unsigned long end)
 {
 }
-- 
2.17.1

