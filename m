Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B88548B886
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 21:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244059AbiAKUUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 15:20:37 -0500
Received: from mx1.uni-rostock.de ([139.30.22.71]:52507 "EHLO
        mx1.uni-rostock.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244023AbiAKUU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:20:29 -0500
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Jan 2022 15:20:28 EST
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1641931525; bh=OPxjOW0atC6RHt21qql+9YyX72sRWC3C1Nzom/FPpSo=; h=
 "Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id"; 
 a=ed25519-sha256; b=
 C11c3jvrnqumCY9TY5fTNp9fBhRxWXTZOW3D8LF34qGRJLV/1aFJici35/m/Vhe/r4fCQy2n00UASwO5ouJADQ==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1641931525; bh=OPxjOW0atC6RHt21qql+9YyX72sRWC3C1Nzom/FPpSo=; h=
 "Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id"; 
 a=rsa-sha256; b=
 clmn9Si3rAjVgELAWU1mm8CcTPSx6ox7DaXbe4p2q5GRReTrLTbq0b0jszlagu+EWZydTOeZ63JvwcbLpR9CqzjGRYuWbwTyYp+B0TN1ftj2k4TT3/9WV7iv+rjoic/pTm9VzzqYg2/0n41Rrd9roXohSwYKVH7xewP3pVUbkSc=
Received: from 139.30.22.81 by mx1.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Tue, 11 Jan 2022 20:05:25 GMT
Received: from meshdev.amd.e-technik.uni-rostock.de (139.30.202.104) by
 email1.uni-rostock.de (139.30.22.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 11 Jan 2022 21:05:24 +0100
From:   Benjamin Beichler <benjamin.beichler@uni-rostock.de>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
CC:     <johannes.berg@intel.com>,
        Benjamin Beichler <benjamin.beichler@uni-rostock.de>,
        <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] um: fix and optimize xor select template for CONFIG64 and timetravel mode
Date:   Tue, 11 Jan 2022 20:05:06 +0000
Message-ID: <20220111200507.1445489-1-benjamin.beichler@uni-rostock.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.30.202.104]
X-ClientProxiedBy: EMAIL2.uni-rostock.de (139.30.22.82) To
 email1.uni-rostock.de (139.30.22.81)
X-TM-SNTS-SMTP: F7625958A8522718A05E822E7765CDE00A0B621576FDF67F90765AF6225E06382002:8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to dropped inclusion of asm-generic/xor.h, xor_block_8regs symbol is
missing with CONFIG64 and break compilation, as the asm/xor_64.h also did
not include it. The patch recreate the logic from arch/x86, which check
whether AVX is available and add fallbacks for 32bit and 64bit config of
um.

A very minor additional "fix" is, the return of the macro parameter
instead of NULL, as this is the original intent of the macro, but
this does not change the actual behavior.

Fixes: c0ecca6604b8 ("um: enable the use of optimized xor routines in UML")
Signed-off-by: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
---
 arch/um/include/asm/xor.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/um/include/asm/xor.h b/arch/um/include/asm/xor.h
index f512704a9ec7..22b39de73c24 100644
--- a/arch/um/include/asm/xor.h
+++ b/arch/um/include/asm/xor.h
@@ -4,8 +4,10 @@
 
 #ifdef CONFIG_64BIT
 #undef CONFIG_X86_32
+#define TT_CPU_INF_XOR_DEFAULT (AVX_SELECT(&xor_block_sse_pf64))
 #else
 #define CONFIG_X86_32 1
+#define TT_CPU_INF_XOR_DEFAULT (AVX_SELECT(&xor_block_8regs))
 #endif
 
 #include <asm/cpufeature.h>
@@ -16,7 +18,7 @@
 #undef XOR_SELECT_TEMPLATE
 /* pick an arbitrary one - measuring isn't possible with inf-cpu */
 #define XOR_SELECT_TEMPLATE(x)	\
-	(time_travel_mode == TT_MODE_INFCPU ? &xor_block_8regs : NULL)
+	(time_travel_mode == TT_MODE_INFCPU ? TT_CPU_INF_XOR_DEFAULT : x))
 #endif
 
 #endif
-- 
2.25.1
