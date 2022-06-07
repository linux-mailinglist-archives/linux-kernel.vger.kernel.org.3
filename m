Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1456854016E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245529AbiFGObh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244427AbiFGObc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:31:32 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FB9D4A2C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 07:31:30 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1nyaEw-0008Ra-2f; Tue, 07 Jun 2022 16:31:26 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, mick@ics.forth.gr,
        samuel@sholland.org, cmuellner@linux.com, philipp.tomsich@vrull.eu,
        hch@lst.de, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 2/2] riscv: convert the t-head pbmt errata to use the __nops macro
Date:   Tue,  7 Jun 2022 16:30:59 +0200
Message-Id: <20220607143059.1054074-3-heiko@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220607143059.1054074-1-heiko@sntech.de>
References: <20220607143059.1054074-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of manually inserting the list of nops, use the recently
introduced __nops(n) macro to make everything more readable.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/riscv/include/asm/errata_list.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index 416ead0f9a65..398e351e7002 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -68,13 +68,7 @@ asm(ALTERNATIVE_2("li %0, 0\t\nnop",					\
  */
 #define ALT_THEAD_PMA(_val)						\
 asm volatile(ALTERNATIVE(						\
-	"nop\n\t"							\
-	"nop\n\t"							\
-	"nop\n\t"							\
-	"nop\n\t"							\
-	"nop\n\t"							\
-	"nop\n\t"							\
-	"nop",								\
+	__nops(7),							\
 	"li      t3, %1\n\t"						\
 	"slli    t3, t3, %3\n\t"					\
 	"and     t3, %0, t3\n\t"					\
-- 
2.35.1

