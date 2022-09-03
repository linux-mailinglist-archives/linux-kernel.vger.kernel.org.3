Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11AD35AC123
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 21:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbiICTcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 15:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiICTch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 15:32:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A2148EA8
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 12:32:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BFB660D36
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 19:32:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA5DC433D6;
        Sat,  3 Sep 2022 19:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662233555;
        bh=mh3N+GmFc5Rx9AiBTB6cAzvRqaNHLVykgec3apa4ju4=;
        h=From:To:Cc:Subject:Date:From;
        b=CnKY2yCIHdBupTV/FW5lzQ1TBLjhnFNFWKZuiUAGkMH1z9TpnXoKy5fhfSms3ASQp
         qyHwz1a+tmBKOgLl/GYPmgGcmSrEhekuy9HJ16wesiJbrzKEc+xkETylWGhHQg0gwv
         p7V4tu1lBldxMmp6OztkTzdwi5n9oxFq7X3OH6lFk92MQn1G4wyhHSRofVtgdn0pwo
         5rqrLlbdXIstgskZHtNqWGgF0ogTx9JpIwMMSGWXnKh82X2+Z6o7yu3GJXtHSrnp3J
         tKWYHsVQby5o/D8uOiXmiagULOpFi3wiMZ5FNWqLTGpwugeZ8PBkm6YErgNeXlkGxa
         5y2IDik60CSgQ==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH for-mm-unstable] mm/swap.h: Define swap_cache_get_folio() for !CONFIG_SWAP
Date:   Sat,  3 Sep 2022 19:32:28 +0000
Message-Id: <20220903193228.172238-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4d3cb611e6df ("swap: add swap_cache_get_folio()") in mm-unstable
tree defines 'swap_cache_get_folio()' for CONFIG_SWAP only, and as a
result build fails on !CONFIG_SWAP as below, after following commits
using the function under !CONFIG_SWAP is applied.

    mm/shmem.c: In function ‘shmem_swapin_folio’:
    mm/shmem.c:1738:10: error: implicit declaration of function ‘swap_cache_get_folio’; did you mean ‘read_cache_folio’? [-Werror=implicit-function-declaration]
     1738 |  folio = swap_cache_get_folio(swap, NULL, 0);
          |          ^~~~~~~~~~~~~~~~~~~~
          |          read_cache_folio
    mm/shmem.c:1738:8: warning: assignment to ‘struct folio *’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
     1738 |  folio = swap_cache_get_folio(swap, NULL, 0);
          |        ^
    cc1: some warnings being treated as errors

This commit fixes the issue by defining the function for !CONFIG_SWAP
case.

Fixes:4d3cb611e6df ("swap: add swap_cache_get_folio()") in mm-unstable (1e6b789996e7)
Signed-off-by: SeongJae Park <sj@kernel.org>
---

Note: This patch does not cleanly applicable on top of the mm-unstable
but the fixing commit.

 mm/swap.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/swap.h b/mm/swap.h
index 2d6fe6c44ad9..ccd8d9a9ad36 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -101,6 +101,12 @@ static inline int swap_writepage(struct page *p, struct writeback_control *wbc)
 	return 0;
 }
 
+static inline struct folio *swap_cache_get_folio(swp_entry_t entry,
+		struct vm_area_struct *vma, unsigned long addr)
+{
+	return NULL;
+}
+
 static inline struct page *lookup_swap_cache(swp_entry_t swp,
 					     struct vm_area_struct *vma,
 					     unsigned long addr)
-- 
2.25.1

