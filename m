Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6590F519DA9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 13:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348575AbiEDLM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 07:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbiEDLM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 07:12:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400ED24584
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 04:09:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6153B822B7
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 11:09:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20658C385A5;
        Wed,  4 May 2022 11:09:19 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="SuY9kwWJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651662557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Wv+QAKoXYa5FdarxsSFuATIydt8Bd7pDfEI2EBNpl4w=;
        b=SuY9kwWJM1EIf1QWdAd/lGEHlbhD2ZeYQZEj3eVFlGzs13BK+GhoAvnS+nGEi8pFHhGleV
        L2S5UugRxXXBOF9OnI0Snou2KsnSIPPEtSqSR6YhCdCVNeba1lW7EC1Iwb2WY7w4T8bUHI
        AvCkCWnRYZWvz5KAGEDsD/ZpMdmwqPQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2558d3b2 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 4 May 2022 11:09:17 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     openrisc@lists.librecores.org, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Stafford Horne <shorne@gmail.com>
Subject: [PATCH] openrisc: remove bogus nops and shutdowns
Date:   Wed,  4 May 2022 13:09:11 +0200
Message-Id: <20220504110911.283525-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nop 42 is some leftover debugging thing by the looks of it. Nop 1 will
shut down the simulator, which isn't what we want, since it makes it
possible to handle errors.

Cc: Stafford Horne <shorne@gmail.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/openrisc/mm/fault.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c
index 80bb66ad42f6..860da58d7509 100644
--- a/arch/openrisc/mm/fault.c
+++ b/arch/openrisc/mm/fault.c
@@ -223,8 +223,6 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 	{
 		const struct exception_table_entry *entry;
 
-		__asm__ __volatile__("l.nop 42");
-
 		if ((entry = search_exception_tables(regs->pc)) != NULL) {
 			/* Adjust the instruction pointer in the stackframe */
 			regs->pc = entry->fixup;
@@ -252,9 +250,6 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 	 */
 
 out_of_memory:
-	__asm__ __volatile__("l.nop 42");
-	__asm__ __volatile__("l.nop 1");
-
 	mmap_read_unlock(mm);
 	if (!user_mode(regs))
 		goto no_context;
-- 
2.35.1

