Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E8B4FED56
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 05:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbiDMDFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 23:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiDMDFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 23:05:43 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42D450B30
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 20:03:21 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1neTHp-0006sN-9D; Wed, 13 Apr 2022 05:03:17 +0200
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
Subject: [PATCH v9 04/12] riscv: implement ALTERNATIVE_2 macro
Date:   Wed, 13 Apr 2022 05:02:59 +0200
Message-Id: <20220413030307.133807-5-heiko@sntech.de>
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

When the alternatives were added the commit already provided a template
on how to implement 2 different alternatives for one piece of code.

Make this usable.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/riscv/include/asm/alternative-macros.h | 78 +++++++++++++++------
 1 file changed, 58 insertions(+), 20 deletions(-)

diff --git a/arch/riscv/include/asm/alternative-macros.h b/arch/riscv/include/asm/alternative-macros.h
index 5dd8d03a13da..9e04cd53afc8 100644
--- a/arch/riscv/include/asm/alternative-macros.h
+++ b/arch/riscv/include/asm/alternative-macros.h
@@ -39,6 +39,24 @@
 #define _ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, CONFIG_k) \
 	__ALTERNATIVE_CFG old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k)
 
+.macro __ALTERNATIVE_CFG_2 old_c, new_c_1, vendor_id_1, errata_id_1, enable_1, \
+				  new_c_2, vendor_id_2, errata_id_2, enable_2
+886 :
+	\old_c
+887 :
+	ALT_NEW_CONTENT \vendor_id_1, \errata_id_1, \enable_1, \new_c_1
+	ALT_NEW_CONTENT \vendor_id_2, \errata_id_2, \enable_2, \new_c_2
+.endm
+
+#define _ALTERNATIVE_CFG_2(old_c, new_c_1, vendor_id_1, errata_id_1,	\
+					CONFIG_k_1,			\
+				  new_c_2, vendor_id_2, errata_id_2,	\
+					CONFIG_k_2)			\
+	__ALTERNATIVE_CFG_2 old_c, new_c_1, vendor_id_1, errata_id_1,	\
+					IS_ENABLED(CONFIG_k_1),		\
+				   new_c_2, vendor_id_2, errata_id_2,	\
+					IS_ENABLED(CONFIG_k_2)
+
 #else /* !__ASSEMBLY__ */
 
 #include <asm/asm.h>
@@ -74,6 +92,25 @@
 #define _ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, CONFIG_k)	\
 	__ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
 
+#define __ALTERNATIVE_CFG_2(old_c, new_c_1, vendor_id_1, errata_id_1,	\
+					enable_1,			\
+				   new_c_2, vendor_id_2, errata_id_2,	\
+					enable_2)			\
+	"886 :\n"							\
+	old_c "\n"							\
+	"887 :\n"							\
+	ALT_NEW_CONTENT(vendor_id_1, errata_id_1, enable_1, new_c_1)	\
+	ALT_NEW_CONTENT(vendor_id_2, errata_id_2, enable_2, new_c_2)
+
+#define _ALTERNATIVE_CFG_2(old_c, new_c_1, vendor_id_1, errata_id_1,	\
+					CONFIG_k_1,			\
+				  new_c_2, vendor_id_2, errata_id_2,	\
+					CONFIG_k_2)			\
+	__ALTERNATIVE_CFG_2(old_c, new_c_1, vendor_id_1, errata_id_1,	\
+					IS_ENABLED(CONFIG_k_1),		\
+				   new_c_2, vendor_id_2, errata_id_2,	\
+					IS_ENABLED(CONFIG_k_2))
+
 #endif /* __ASSEMBLY__ */
 
 #else /* CONFIG_RISCV_ALTERNATIVE */
@@ -86,6 +123,12 @@
 #define _ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, CONFIG_k) \
 	__ALTERNATIVE_CFG old_c
 
+#define _ALTERNATIVE_CFG_2(old_c, new_c_1, vendor_id_1, errata_id_1,	\
+					CONFIG_k_1,			\
+				  new_c_2, vendor_id_2, errata_id_2,	\
+					CONFIG_k_2)			\
+       __ALTERNATIVE_CFG old_c
+
 #else /* !__ASSEMBLY__ */
 
 #define __ALTERNATIVE_CFG(old_c)  \
@@ -94,6 +137,12 @@
 #define _ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, CONFIG_k) \
 	__ALTERNATIVE_CFG(old_c)
 
+#define _ALTERNATIVE_CFG_2(old_c, new_c_1, vendor_id_1, errata_id_1,	\
+					CONFIG_k_1,			\
+				  new_c_2, vendor_id_2, errata_id_2,	\
+					CONFIG_k_2) \
+       __ALTERNATIVE_CFG(old_c)
+
 #endif /* __ASSEMBLY__ */
 #endif /* CONFIG_RISCV_ALTERNATIVE */
 
@@ -119,25 +168,14 @@
  * this case, this vendor can create a new macro ALTERNATIVE_2() based
  * on the following sample code and then replace ALTERNATIVE() with
  * ALTERNATIVE_2() to append its customized content.
- *
- * .macro __ALTERNATIVE_CFG_2 old_c, new_c_1, vendor_id_1, errata_id_1, enable_1, \
- *                                   new_c_2, vendor_id_2, errata_id_2, enable_2
- * 886 :
- *      \old_c
- * 887 :
- *      ALT_NEW_CONTENT \vendor_id_1, \errata_id_1, \enable_1, \new_c_1
- *      ALT_NEW_CONTENT \vendor_id_2, \errata_id_2, \enable_2, \new_c_2
- * .endm
- *
- * #define _ALTERNATIVE_CFG_2(old_c, new_c_1, vendor_id_1, errata_id_1, CONFIG_k_1, \
- *                                   new_c_2, vendor_id_2, errata_id_2, CONFIG_k_2) \
- *        __ALTERNATIVE_CFG_2 old_c, new_c_1, vendor_id_1, errata_id_1, IS_ENABLED(CONFIG_k_1), \
- *                                   new_c_2, vendor_id_2, errata_id_2, IS_ENABLED(CONFIG_k_2) \
- *
- * #define ALTERNATIVE_2(old_content, new_content_1, vendor_id_1, errata_id_1, CONFIG_k_1, \
- *                                    new_content_2, vendor_id_2, errata_id_2, CONFIG_k_2) \
- *         _ALTERNATIVE_CFG_2(old_content, new_content_1, vendor_id_1, errata_id_1, CONFIG_k_1, \
- *                                         new_content_2, vendor_id_2, errata_id_2, CONFIG_k_2)
- *
  */
+#define ALTERNATIVE_2(old_content, new_content_1, vendor_id_1,		\
+					errata_id_1, CONFIG_k_1,	\
+				   new_content_2, vendor_id_2,		\
+					errata_id_2, CONFIG_k_2)	\
+	_ALTERNATIVE_CFG_2(old_content, new_content_1, vendor_id_1,	\
+					    errata_id_1, CONFIG_k_1,	\
+					new_content_2, vendor_id_2,	\
+					    errata_id_2, CONFIG_k_2)
+
 #endif
-- 
2.35.1

