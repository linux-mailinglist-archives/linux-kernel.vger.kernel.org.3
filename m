Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EB4565DA6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 20:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbiGDS47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 14:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiGDS46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 14:56:58 -0400
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr [80.12.242.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF65DF0F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 11:56:56 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 8RFdoQHoiIaWO8RFeo2rr9; Mon, 04 Jul 2022 20:56:54 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Mon, 04 Jul 2022 20:56:54 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-mips@vger.kernel.org
Subject: [PATCH] MIPS: math-emu: Use the bitmap API to allocate bitmaps
Date:   Mon,  4 Jul 2022 20:56:52 +0200
Message-Id: <dd954ccb2472019c64da0dd3a90d7b39a2fadc98.1656960999.git.christophe.jaillet@wanadoo.fr>
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

Use bitmap_zalloc()/bitmap_free() instead of hand-writing them.

It is less verbose and it improves the semantic.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/mips/math-emu/dsemul.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/mips/math-emu/dsemul.c b/arch/mips/math-emu/dsemul.c
index e2d46cb93ca9..e02bd20b60a6 100644
--- a/arch/mips/math-emu/dsemul.c
+++ b/arch/mips/math-emu/dsemul.c
@@ -82,11 +82,8 @@ static int alloc_emuframe(void)
 
 	/* Ensure we have an allocation bitmap */
 	if (!mm_ctx->bd_emupage_allocmap) {
-		mm_ctx->bd_emupage_allocmap =
-			kcalloc(BITS_TO_LONGS(emupage_frame_count),
-					      sizeof(unsigned long),
-				GFP_ATOMIC);
-
+		mm_ctx->bd_emupage_allocmap = bitmap_zalloc(emupage_frame_count,
+							    GFP_ATOMIC);
 		if (!mm_ctx->bd_emupage_allocmap) {
 			idx = BD_EMUFRAME_NONE;
 			goto out_unlock;
@@ -206,7 +203,7 @@ void dsemul_mm_cleanup(struct mm_struct *mm)
 {
 	mm_context_t *mm_ctx = &mm->context;
 
-	kfree(mm_ctx->bd_emupage_allocmap);
+	bitmap_free(mm_ctx->bd_emupage_allocmap);
 }
 
 int mips_dsemul(struct pt_regs *regs, mips_instruction ir,
-- 
2.34.1

