Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADE7523D6B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346877AbiEKT34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241016AbiEKT3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:29:47 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52B2F29EC
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 12:29:44 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nos1h-0004fe-Mg; Wed, 11 May 2022 21:29:37 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, liush@allwinnertech.com, guoren@kernel.org,
        atishp@atishpatra.org, anup@brainfault.org, drew@beagleboard.org,
        hch@lst.de, arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        gfavor@ventanamicro.com, andrea.mondelli@huawei.com,
        behrensj@mit.edu, xinhaoqu@huawei.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com, samuel@sholland.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 05/12] riscv: extend concatenated alternatives-lines to the same length
Date:   Wed, 11 May 2022 21:29:14 +0200
Message-Id: <20220511192921.2223629-6-heiko@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220511192921.2223629-1-heiko@sntech.de>
References: <20220511192921.2223629-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ALT_NEW_CONTENT already uses same-length assembler lines, so
extend this to the other elements as well.

This makes it more readable when these elements need to be extended
in the future.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Philipp Tomsich <philipp.tomsich@vrull.eu>
---
 arch/riscv/include/asm/alternative-macros.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/include/asm/alternative-macros.h b/arch/riscv/include/asm/alternative-macros.h
index 9e04cd53afc8..8c2bbc7bbe50 100644
--- a/arch/riscv/include/asm/alternative-macros.h
+++ b/arch/riscv/include/asm/alternative-macros.h
@@ -62,14 +62,14 @@
 #include <asm/asm.h>
 #include <linux/stringify.h>
 
-#define ALT_ENTRY(oldptr, newptr, vendor_id, errata_id, newlen) \
-	RISCV_PTR " " oldptr "\n" \
-	RISCV_PTR " " newptr "\n" \
-	REG_ASM " " vendor_id "\n" \
-	REG_ASM " " newlen "\n" \
+#define ALT_ENTRY(oldptr, newptr, vendor_id, errata_id, newlen)		\
+	RISCV_PTR " " oldptr "\n"					\
+	RISCV_PTR " " newptr "\n"					\
+	REG_ASM " " vendor_id "\n"					\
+	REG_ASM " " newlen "\n"						\
 	".word " errata_id "\n"
 
-#define ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c) \
+#define ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)		\
 	".if " __stringify(enable) " == 1\n"				\
 	".pushsection .alternative, \"a\"\n"				\
 	ALT_ENTRY("886b", "888f", __stringify(vendor_id), __stringify(errata_id), "889f - 888f") \
@@ -83,10 +83,10 @@
 	".org	. - (889b - 888b) + (887b - 886b)\n"			\
 	".endif\n"
 
-#define __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, enable) \
-	"886 :\n"	\
-	old_c "\n"	\
-	"887 :\n"	\
+#define __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, enable)	\
+	"886 :\n"							\
+	old_c "\n"							\
+	"887 :\n"							\
 	ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
 
 #define _ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, CONFIG_k)	\
-- 
2.35.1

