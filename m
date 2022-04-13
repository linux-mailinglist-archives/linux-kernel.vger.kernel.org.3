Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49F24FED54
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 05:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbiDMDGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 23:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbiDMDFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 23:05:45 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48FF54BE1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 20:03:21 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1neTHq-0006sN-Sv; Wed, 13 Apr 2022 05:03:18 +0200
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
Subject: [PATCH v9 06/12] riscv: prevent compressed instructions in alternatives
Date:   Wed, 13 Apr 2022 05:03:01 +0200
Message-Id: <20220413030307.133807-7-heiko@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220413030307.133807-1-heiko@sntech.de>
References: <20220413030307.133807-1-heiko@sntech.de>
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

Instructions are opportunistically compressed by the RISC-V assembler
when possible, but in alternatives-blocks both the old and new content
need to be the same size, so having the toolchain do somewhat random
optimizations will cause strange side-effects like
"attempt to move .org backwards" compile-time errors.

Already a simple "and" used in alternatives assembly will cause these
mismatched code sizes.

So prevent compressed instructions to be generated in alternatives-
code and use option-push and -pop to only limit this to the relevant
code blocks

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/include/asm/alternative-macros.h | 24 +++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/riscv/include/asm/alternative-macros.h b/arch/riscv/include/asm/alternative-macros.h
index 8c2bbc7bbe50..e13b1f6bb400 100644
--- a/arch/riscv/include/asm/alternative-macros.h
+++ b/arch/riscv/include/asm/alternative-macros.h
@@ -21,7 +21,11 @@
 	.popsection
 	.subsection 1
 888 :
+	.option push
+	.option norvc
+	.option norelax
 	\new_c
+	.option pop
 889 :
 	.previous
 	.org    . - (889b - 888b) + (887b - 886b)
@@ -31,7 +35,11 @@
 
 .macro __ALTERNATIVE_CFG old_c, new_c, vendor_id, errata_id, enable
 886 :
+	.option push
+	.option norvc
+	.option norelax
 	\old_c
+	.option pop
 887 :
 	ALT_NEW_CONTENT \vendor_id, \errata_id, \enable, \new_c
 .endm
@@ -42,7 +50,11 @@
 .macro __ALTERNATIVE_CFG_2 old_c, new_c_1, vendor_id_1, errata_id_1, enable_1, \
 				  new_c_2, vendor_id_2, errata_id_2, enable_2
 886 :
+	.option push
+	.option norvc
+	.option norelax
 	\old_c
+	.option pop
 887 :
 	ALT_NEW_CONTENT \vendor_id_1, \errata_id_1, \enable_1, \new_c_1
 	ALT_NEW_CONTENT \vendor_id_2, \errata_id_2, \enable_2, \new_c_2
@@ -76,7 +88,11 @@
 	".popsection\n"							\
 	".subsection 1\n"						\
 	"888 :\n"							\
+	".option push\n"						\
+	".option norvc\n"						\
+	".option norelax\n"						\
 	new_c "\n"							\
+	".option pop\n"							\
 	"889 :\n"							\
 	".previous\n"							\
 	".org	. - (887b - 886b) + (889b - 888b)\n"			\
@@ -85,7 +101,11 @@
 
 #define __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, enable)	\
 	"886 :\n"							\
+	".option push\n"						\
+	".option norvc\n"						\
+	".option norelax\n"						\
 	old_c "\n"							\
+	".option pop\n"							\
 	"887 :\n"							\
 	ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
 
@@ -97,7 +117,11 @@
 				   new_c_2, vendor_id_2, errata_id_2,	\
 					enable_2)			\
 	"886 :\n"							\
+	".option push\n"						\
+	".option norvc\n"						\
+	".option norelax\n"						\
 	old_c "\n"							\
+	".option pop\n"							\
 	"887 :\n"							\
 	ALT_NEW_CONTENT(vendor_id_1, errata_id_1, enable_1, new_c_1)	\
 	ALT_NEW_CONTENT(vendor_id_2, errata_id_2, enable_2, new_c_2)
-- 
2.35.1

