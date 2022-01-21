Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977D74962F6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 17:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378553AbiAUQhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 11:37:33 -0500
Received: from gloria.sntech.de ([185.11.138.130]:35338 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349385AbiAUQhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 11:37:06 -0500
Received: from p508fcef5.dip0.t-ipconnect.de ([80.143.206.245] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nAwuL-0008GA-T2; Fri, 21 Jan 2022 17:37:01 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, wefu@redhat.com,
        liush@allwinnertech.com, guoren@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, drew@beagleboard.org, hch@lst.de,
        arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        dlustig@nvidia.com, gfavor@ventanamicro.com,
        andrea.mondelli@huawei.com, behrensj@mit.edu, xinhaoqu@huawei.com,
        huffman@cadence.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com, samuel@sholland.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v5 07/14] riscv: prevent compressed instructions in alternatives
Date:   Fri, 21 Jan 2022 17:36:11 +0100
Message-Id: <20220121163618.351934-8-heiko@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220121163618.351934-1-heiko@sntech.de>
References: <20220121163618.351934-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
code and use option-push and -pop to limit this to the relevant
code blocks

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/riscv/include/asm/alternative-macros.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/riscv/include/asm/alternative-macros.h b/arch/riscv/include/asm/alternative-macros.h
index c0fb11fad631..3a52884bf23d 100644
--- a/arch/riscv/include/asm/alternative-macros.h
+++ b/arch/riscv/include/asm/alternative-macros.h
@@ -19,7 +19,10 @@
 	.popsection
 	.subsection 1
 888 :
+	.option push
+	.option norvc
 	\new_c
+	.option pop
 889 :
 	.previous
 	.org    . - (889b - 888b) + (887b - 886b)
@@ -29,7 +32,10 @@
 
 .macro __ALTERNATIVE_CFG old_c, new_c, vendor_id, errata_id, enable
 886 :
+	.option push
+	.option norvc
 	\old_c
+	.option pop
 887 :
 	ALT_NEW_CONTENT \vendor_id, \errata_id, \enable, \new_c
 .endm
@@ -40,7 +46,10 @@
 .macro __ALTERNATIVE_CFG_2 old_c, new_c_1, vendor_id_1, errata_id_1, enable_1, \
 				  new_c_2, vendor_id_2, errata_id_2, enable_2
 886 :
+	.option push
+	.option norvc
 	\old_c
+	.option pop
 887 :
 	ALT_NEW_CONTENT \vendor_id_1, \errata_id_1, \enable_1, \new_c_1
 	ALT_NEW_CONTENT \vendor_id_2, \errata_id_2, \enable_2, \new_c_2
@@ -70,7 +79,10 @@
 	".popsection\n"							\
 	".subsection 1\n"						\
 	"888 :\n"							\
+	".option push\n"						\
+	".option norvc\n"						\
 	new_c "\n"							\
+	".option pop\n"							\
 	"889 :\n"							\
 	".previous\n"							\
 	".org	. - (887b - 886b) + (889b - 888b)\n"			\
@@ -79,7 +91,10 @@
 
 #define __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, enable)	\
 	"886 :\n"							\
+	".option push\n"						\
+	".option norvc\n"						\
 	old_c "\n"							\
+	".option pop\n"							\
 	"887 :\n"							\
 	ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
 
@@ -89,7 +104,10 @@
 #define __ALTERNATIVE_CFG_2(old_c, new_c_1, vendor_id_1, errata_id_1, enable_1, \
 				  new_c_2, vendor_id_2, errata_id_2, enable_2) \
 	"886 :\n"							\
+	".option push\n"						\
+	".option norvc\n"						\
 	old_c "\n"							\
+	".option pop\n"							\
 	"887 :\n"							\
 	ALT_NEW_CONTENT(vendor_id_1, errata_id_1, enable_1, new_c_1)	\
 	ALT_NEW_CONTENT(vendor_id_2, errata_id_2, enable_2, new_c_2)
-- 
2.30.2

