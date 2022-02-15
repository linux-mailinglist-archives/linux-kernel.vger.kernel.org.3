Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590084B777D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243094AbiBOScQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 13:32:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241463AbiBOScO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 13:32:14 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A911D319
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 10:32:04 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4JyqSC0spkz9sS8;
        Tue, 15 Feb 2022 19:31:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZBL1cRfOBO0b; Tue, 15 Feb 2022 19:31:55 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4JyqSB1RvHz9sS9;
        Tue, 15 Feb 2022 19:31:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1572A8B77D;
        Tue, 15 Feb 2022 19:31:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id BPH8QzsaA4IC; Tue, 15 Feb 2022 19:31:54 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.6.174])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BFE568B77A;
        Tue, 15 Feb 2022 19:31:53 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21FIVi7o146772
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 19:31:44 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21FIVihx146771;
        Tue, 15 Feb 2022 19:31:44 +0100
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
Subject: [PATCH v1 2/4] powerpc/ftrace: Add recursion protection in prepare_ftrace_return()
Date:   Tue, 15 Feb 2022 19:31:23 +0100
Message-Id: <74edf2ff0a60e66b0d9225a137100a86a0557032.1644949750.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ff535e86d3a69376a6d89168511d4e403835f18b.1644949750.git.christophe.leroy@csgroup.eu>
References: <ff535e86d3a69376a6d89168511d4e403835f18b.1644949750.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1644949837; l=1454; s=20211009; h=from:subject:message-id; bh=xZYWjYWqiSAg8pwgNQX7t/kBFhRU9zZkBGIvI52V/4s=; b=hoACMMUc0kMQo/AciROzjGF96l3iIcRLywnffI+iD3rs2+WduVQB8T3Nl7EojuxAL+Z9/Eiu3ZT/ 12Rb7DtCAtnRYLbhYvL181l1plYLd51uQeT/qNFSkSKiv7up1H4a
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

The function_graph_enter() does not provide any recursion protection.

Add a protection in prepare_ftrace_return() in case
function_graph_enter() calls something that gets
function graph traced.

Reported-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Fixes: 830213786c49 ("powerpc/ftrace: directly call of function graph tracer by ftrace caller")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/trace/ftrace.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index 74a176e394ef..f21b8fbd418e 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -944,6 +944,7 @@ unsigned long prepare_ftrace_return(unsigned long parent, unsigned long ip,
 						unsigned long sp)
 {
 	unsigned long return_hooker;
+	int bit;
 
 	if (unlikely(ftrace_graph_is_dead()))
 		goto out;
@@ -951,10 +952,16 @@ unsigned long prepare_ftrace_return(unsigned long parent, unsigned long ip,
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
 		goto out;
 
+	bit = ftrace_test_recursion_trylock(ip, parent);
+	if (bit < 0)
+		goto out;
+
 	return_hooker = ppc_function_entry(return_to_handler);
 
 	if (!function_graph_enter(parent, ip, 0, (unsigned long *)sp))
 		parent = return_hooker;
+
+	ftrace_test_recursion_unlock(bit);
 out:
 	return parent;
 }
-- 
2.34.1

