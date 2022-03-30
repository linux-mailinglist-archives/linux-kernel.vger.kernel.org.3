Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B8F4ECD30
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 21:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236617AbiC3T1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 15:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241329AbiC3T1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 15:27:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDC713F67;
        Wed, 30 Mar 2022 12:25:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFA90B81D51;
        Wed, 30 Mar 2022 19:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E428C340EC;
        Wed, 30 Mar 2022 19:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648668314;
        bh=KfNiqBGllAj8YkXkT3+YnhFFib/aEjUEKtG8qND1PjM=;
        h=Date:From:To:Cc:Subject:From;
        b=srKuhEjxMJHsuKWyR6EutNhGaSLV0PhvrsjcrMMOaftbwXE8J5SvIY3X7H7Ntn83v
         7hUvksWsWzFszqAzB/F6LS55fDr7281g++7rUtbHXfjkHkZ7yILg+NJTPyHK9gnk+d
         4RGRE7UP0x1KZ0sengXeJ26xjcbBC5i2b6TgCoK1qKiQB+5ZNaC0NoKmUi+FHUWnf0
         Nh4hFRh+I6YbnHDCOwBfqYW7VqVn9xTGP6coQ6cx+s4hBCJXOQXtELv0aGA/6OMTZk
         znTrWkcUThhHpfDBlN7/EWW0SQk+GVTy9j8LTPOBqPN7jtrgFwb5AQ2ocbiPRJ6r3U
         dPjJ4aJIvkTFg==
Date:   Wed, 30 Mar 2022 14:33:52 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Nick Terrell <terrelln@fb.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] lib: zstd: Fix Wstringop-overflow warning
Message-ID: <20220330193352.GA119296@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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

Fix the following -Wstringop-overflow warning when building with GCC-11:

lib/zstd/decompress/huf_decompress.c: In function ‘HUF_readDTableX2_wksp’:
lib/zstd/decompress/huf_decompress.c:700:5: warning: ‘HUF_fillDTableX2.constprop’ accessing 624 bytes in a region of size 52 [-Wstringop-overflow=]
  700 |     HUF_fillDTableX2(dt, maxTableLog,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  701 |                    wksp->sortedSymbol, sizeOfSort,
      |                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  702 |                    wksp->rankStart0, wksp->rankVal, maxW,
      |                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  703 |                    tableLog+1,
      |                    ~~~~~~~~~~~
  704 |                    wksp->calleeWksp, sizeof(wksp->calleeWksp) / sizeof(U32));
      |                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/zstd/decompress/huf_decompress.c:700:5: note: referencing argument 6 of type ‘U32 (*)[13]’ {aka ‘unsigned int (*)[13]’}
lib/zstd/decompress/huf_decompress.c:571:13: note: in a call to function ‘HUF_fillDTableX2.constprop’
  571 | static void HUF_fillDTableX2(HUF_DEltX2* DTable, const U32 targetLog,
      |             ^~~~~~~~~~~~~~~~

by using pointer notation instead of array notation.

This helps with the ongoing efforts to globally enable
-Wstringop-overflow.

Link: https://github.com/KSPP/linux/issues/181
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 lib/zstd/decompress/huf_decompress.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/zstd/decompress/huf_decompress.c b/lib/zstd/decompress/huf_decompress.c
index 5105e59ac04a..0ea34621253a 100644
--- a/lib/zstd/decompress/huf_decompress.c
+++ b/lib/zstd/decompress/huf_decompress.c
@@ -570,7 +570,7 @@ static void HUF_fillDTableX2Level2(HUF_DEltX2* DTable, U32 sizeLog, const U32 co
 
 static void HUF_fillDTableX2(HUF_DEltX2* DTable, const U32 targetLog,
                            const sortedSymbol_t* sortedList, const U32 sortedListSize,
-                           const U32* rankStart, rankVal_t rankValOrigin, const U32 maxWeight,
+                           const U32* rankStart, const U32* rankValOrigin, const U32 maxWeight,
                            const U32 nbBitsBaseline, U32* wksp, size_t wkspSize)
 {
     U32* rankVal = wksp;
@@ -598,7 +598,7 @@ static void HUF_fillDTableX2(HUF_DEltX2* DTable, const U32 targetLog,
             if (minWeight < 1) minWeight = 1;
             sortedRank = rankStart[minWeight];
             HUF_fillDTableX2Level2(DTable+start, targetLog-nbBits, nbBits,
-                           rankValOrigin[nbBits], minWeight,
+                           rankValOrigin + nbBits, minWeight,
                            sortedList+sortedRank, sortedListSize-sortedRank,
                            nbBitsBaseline, symbol, wksp, wkspSize);
         } else {
@@ -699,7 +699,7 @@ size_t HUF_readDTableX2_wksp(HUF_DTable* DTable,
 
     HUF_fillDTableX2(dt, maxTableLog,
                    wksp->sortedSymbol, sizeOfSort,
-                   wksp->rankStart0, wksp->rankVal, maxW,
+                   wksp->rankStart0, (U32 *)wksp->rankVal, maxW,
                    tableLog+1,
                    wksp->calleeWksp, sizeof(wksp->calleeWksp) / sizeof(U32));
 
-- 
2.27.0

