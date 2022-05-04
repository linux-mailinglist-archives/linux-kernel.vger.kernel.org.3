Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D9A5196AE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 06:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbiEDFAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 01:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237376AbiEDFAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 01:00:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F80E2D1E0
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 21:57:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1132B82280
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 04:57:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F49C385A4;
        Wed,  4 May 2022 04:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651640228;
        bh=Ra0JCiuxWndPnvcreZb9EXKE6gp8u/jrYNK0AnIc3iY=;
        h=From:To:Cc:Subject:Date:From;
        b=egta3cRzvh6HRsQFORg0Nd5GutCLf5F2+mjBTg+O55ToxXPHeXLi0n4i1rRr/4Nxu
         rrcVHvyk1EXuk2nXHaBxF/1pyucJyucjBMcw9lAfNlvk4F/2doZA7spoZYXumRYQYG
         Mgi0Dm4JhuYx3QMiVWd2al6SEosTFuMC05qy728TeIcS6NXNg6rRVL6oeKUK70E+xC
         eLIT3AdZgtperToGmsJmFSaqfttD/3ycgCrXteHpPUUZzIMOXBaFqfzsF+hNIIdeXi
         PrHS+GVGsPps3d1Y2mvnBu0H14RYo0STqrBMqdBxX4o2yda81KU1jEX+PdRNC3buzK
         mkZNfVLsXBZfQ==
From:   SeongJae Park <sj@kernel.org>
To:     willy@infradead.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH] mm/shmem/shmem_swapin_folio(): Fix uninitialized use of folio
Date:   Wed,  4 May 2022 04:57:04 +0000
Message-Id: <20220504045704.105803-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
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

Commit 2b58b3f33ba2 ("mm/shmem: convert shmem_swapin_page() to
shmem_swapin_folio()") in 'mm-unstable' tree introduces uninitialized
variable access as below when 'shmem_swapin_folio()' goes to 'failed'
path early.  This commit fixes it.

    linux/mm/shmem.c: In function ‘shmem_swapin_folio.isra.0’:
    linux/mm/shmem.c:1761:5: warning: ‘folio’ is used
    uninitialized in this function [-Wuninitialized]
     1761 |  if (folio) {
          |     ^

Fixes: 2b58b3f33ba2 ("mm/shmem: convert shmem_swapin_page() to shmem_swapin_folio()")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 820fde6c2ef6..6a18641a90ff 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1682,7 +1682,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct mm_struct *charge_mm = vma ? vma->vm_mm : NULL;
 	struct page *page;
-	struct folio *folio;
+	struct folio *folio = NULL;
 	swp_entry_t swap;
 	int error;
 
-- 
2.25.1

