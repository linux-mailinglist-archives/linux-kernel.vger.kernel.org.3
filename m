Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DB24AB112
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 18:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345268AbiBFRvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 12:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239745AbiBFRvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 12:51:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F3CC043184
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 09:51:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DE4B608D5
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 17:51:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E8EC340E9;
        Sun,  6 Feb 2022 17:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644169901;
        bh=PgP3XA+R87hLDRANpjuRku4aVM76Q9vxTvvDIf8+XYU=;
        h=From:To:Cc:Subject:Date:From;
        b=MvdOGZ/muD3iuxKGNPy5RTPuuwrBO1mMdpCUkVaEYwiLfAFhHGcQD69qu4WCWSpgR
         cgWyLcZObA1dIVF41cqV8UOV1m4j/d+PzaV68pqMSFbLqbJZtpp1UQPpjHTdt7oupt
         pP96cn6nV93W/UX84tMlFLntO75wBzWXNrTumm4GOtsZiMo/AH6NLU2qfZAxhkoIAF
         w8e7YfpRC5H0nCj5F2C4Bb+QZmnXhgZl5hFebuKax+FJHqPrBDI6kMPryVpc2z2IKq
         Y2T/L1ikQBCvpFRSpP2j9vE2LVLLbpfEmcTtVpkQZY8fLvZl+jJzud6cafnpZYfEkf
         WltLtSivvaxMw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] riscv: reduce THREAD_SIZE from 16KB to 8KB for RV64
Date:   Mon,  7 Feb 2022 01:43:59 +0800
Message-Id: <20220206174359.2986-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

After irq stack is supported, it's possible to use small THREAD_SIZE.
In fact, I tested this patch on a Lichee RV board, looks good so far.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/include/asm/thread_info.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index 67387a8bcb34..fdbf3890a1ab 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -12,11 +12,7 @@
 #include <linux/const.h>
 
 /* thread information allocation */
-#ifdef CONFIG_64BIT
-#define THREAD_SIZE_ORDER	(2)
-#else
 #define THREAD_SIZE_ORDER	(1)
-#endif
 #define THREAD_SIZE		(PAGE_SIZE << THREAD_SIZE_ORDER)
 
 #define IRQ_STACK_SIZE		THREAD_SIZE
-- 
2.34.1

