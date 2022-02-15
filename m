Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C314B7837
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243086AbiBOScN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 13:32:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241463AbiBOScL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 13:32:11 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFC81C904
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 10:31:55 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4JyqSB2KLhz9sSH;
        Tue, 15 Feb 2022 19:31:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vEPz7MoYcChe; Tue, 15 Feb 2022 19:31:54 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4JyqSB1NMXz9sS8;
        Tue, 15 Feb 2022 19:31:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 13C8D8B77C;
        Tue, 15 Feb 2022 19:31:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Hukjm0T6YJMZ; Tue, 15 Feb 2022 19:31:54 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.6.174])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B91368B763;
        Tue, 15 Feb 2022 19:31:53 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21FIVibp146768
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 19:31:44 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21FIVekA146765;
        Tue, 15 Feb 2022 19:31:40 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: [PATCH v1 1/4] powerpc/ftrace: Also save r1 in ftrace_caller()
Date:   Tue, 15 Feb 2022 19:31:22 +0100
Message-Id: <ff535e86d3a69376a6d89168511d4e403835f18b.1644949750.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1644949837; l=958; s=20211009; h=from:subject:message-id; bh=+OAg1QzN1NMzv44Zc4NhQPMtO25ighAEmulpyJpzi0c=; b=Kh1iOWwIhYp3Z2Get6F5yyQrTLYSQ2xMN5f0BMD83MYtCy5UVrelHZPaV059aJhmeYRcZKc+o7aT TiwQEc3WA20xbgX+qBkm2EHwfRONuIg6jjKhPnZiQLc1qUHZtG2P
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

Also save r1 in ftrace_caller()

r1 is needed during unwinding when the function_graph tracer
is active.

Reported-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Fixes: 830213786c49 ("powerpc/ftrace: directly call of function graph tracer by ftrace caller")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/trace/ftrace_mprofile.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/trace/ftrace_mprofile.S b/arch/powerpc/kernel/trace/ftrace_mprofile.S
index 56da60e98327..8443902d5a05 100644
--- a/arch/powerpc/kernel/trace/ftrace_mprofile.S
+++ b/arch/powerpc/kernel/trace/ftrace_mprofile.S
@@ -173,6 +173,10 @@ _GLOBAL(ftrace_caller)
 	beq	ftrace_no_trace
 #endif
 
+	/* Save previous stack pointer (r1) */
+	addi	r8, r1, SWITCH_FRAME_SIZE
+	PPC_STL	r8, GPR1(r1)
+
 	/* Get the _mcount() call site out of LR */
 	mflr	r7
 	PPC_STL     r7, _NIP(r1)
-- 
2.34.1

