Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C8D4B1F77
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 08:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347750AbiBKHmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 02:42:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245292AbiBKHmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 02:42:05 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7500BF4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 23:42:04 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Jw5DB4kwQz9sSM;
        Fri, 11 Feb 2022 08:42:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id f3MfhsYRsmZC; Fri, 11 Feb 2022 08:42:02 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Jw5DB40jXz9sSL;
        Fri, 11 Feb 2022 08:42:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7A7788B77D;
        Fri, 11 Feb 2022 08:42:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id tS9I9GRiyyjL; Fri, 11 Feb 2022 08:42:02 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.6.91])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4ED958B764;
        Fri, 11 Feb 2022 08:42:02 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21B7fqgC933807
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 11 Feb 2022 08:41:53 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21B7fo1l933805;
        Fri, 11 Feb 2022 08:41:50 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] Fixup for next-test 3a1a8f078670 ("powerpc/ftrace: Remove ftrace_32.S")
Date:   Fri, 11 Feb 2022 08:41:34 +0100
Message-Id: <ecc74ddaff69493aae92b8dc5455ec016d62fea8.1644565269.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <5e837fc190504c4ef834272e70d60ae33f175d49.1640017960.git.christophe.leroy@csgroup.eu>
References: <5e837fc190504c4ef834272e70d60ae33f175d49.1640017960.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1644565282; l=826; s=20211009; h=from:subject:message-id; bh=+tIw/1ka4XAJFmZDM6ZPSXA0iz5N+w6+7JiLlIEY+AU=; b=QcZ2P0PTWRH49N/AeL7czpfnH9wGhjS5TF+/Z8k5syrswOhdWXF8lziOPAx4Kh5Ihg+VQvh2XIQz HbibCoWIB8Yvw+MqqAcwdsBppnj0KvmcodKb4BBIKGDnPGVv3Fhx
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/trace/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/trace/Makefile b/arch/powerpc/kernel/trace/Makefile
index ac7d42a4e8d0..542aa7a8b2b4 100644
--- a/arch/powerpc/kernel/trace/Makefile
+++ b/arch/powerpc/kernel/trace/Makefile
@@ -14,8 +14,9 @@ obj64-$(CONFIG_FUNCTION_TRACER)		+= ftrace_mprofile.o
 else
 obj64-$(CONFIG_FUNCTION_TRACER)		+= ftrace_64_pg.o
 endif
+obj-$(CONFIG_FUNCTION_TRACER)		+= ftrace_low.o
 obj-$(CONFIG_DYNAMIC_FTRACE)		+= ftrace.o
-obj-$(CONFIG_FUNCTION_GRAPH_TRACER)	+= ftrace.o ftrace_low.o
+obj-$(CONFIG_FUNCTION_GRAPH_TRACER)	+= ftrace.o
 obj-$(CONFIG_FTRACE_SYSCALLS)		+= ftrace.o
 obj-$(CONFIG_TRACING)			+= trace_clock.o
 
-- 
2.34.1

