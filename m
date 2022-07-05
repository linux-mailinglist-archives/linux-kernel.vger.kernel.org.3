Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B4D5678FF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 22:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbiGEU60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 16:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbiGEU5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 16:57:08 -0400
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A500515A1A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 13:57:02 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 8pbPoGbFuNUm18pbPooK5u; Tue, 05 Jul 2022 22:57:00 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Tue, 05 Jul 2022 22:57:00 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-mips@vger.kernel.org
Subject: [PATCH v2] MIPS: mm: Use the bitmap API to allocate bitmaps
Date:   Tue,  5 Jul 2022 22:56:51 +0200
Message-Id: <4b64934fe14f1c2d30193df01e67a52022703b95.1656961396.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use bitmap_zalloc() instead of hand-writing them.

It is less verbose and it improves the semantic.

While at it, turn a bitmap_clear() into an equivalent bitmap_zero(). It is
also less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v1 --> v2: don't speak about bitmap_free() in the log message (Sergey Shtylyov)
---
 arch/mips/mm/context.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/mips/mm/context.c b/arch/mips/mm/context.c
index b25564090939..966f40066f03 100644
--- a/arch/mips/mm/context.c
+++ b/arch/mips/mm/context.c
@@ -67,7 +67,7 @@ static void flush_context(void)
 	int cpu;
 
 	/* Update the list of reserved MMIDs and the MMID bitmap */
-	bitmap_clear(mmid_map, 0, num_mmids);
+	bitmap_zero(mmid_map, num_mmids);
 
 	/* Reserve an MMID for kmap/wired entries */
 	__set_bit(MMID_KERNEL_WIRED, mmid_map);
@@ -277,8 +277,7 @@ static int mmid_init(void)
 	WARN_ON(num_mmids <= num_possible_cpus());
 
 	atomic64_set(&mmid_version, asid_first_version(0));
-	mmid_map = kcalloc(BITS_TO_LONGS(num_mmids), sizeof(*mmid_map),
-			   GFP_KERNEL);
+	mmid_map = bitmap_zalloc(num_mmids, GFP_KERNEL);
 	if (!mmid_map)
 		panic("Failed to allocate bitmap for %u MMIDs\n", num_mmids);
 
-- 
2.34.1

