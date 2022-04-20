Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01D9507DBD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 02:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358640AbiDTAqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 20:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358624AbiDTAqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 20:46:19 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF5C34BAC;
        Tue, 19 Apr 2022 17:43:28 -0700 (PDT)
Received: (Authenticated sender: joao@overdrivepizza.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B0F141BF206;
        Wed, 20 Apr 2022 00:43:21 +0000 (UTC)
From:   joao@overdrivepizza.com
To:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc:     joao@overdrivepizza.com, peterz@infradead.org, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com, hjl.tools@gmail.com,
        alyssa.milburn@linux.intel.com, ndesaulniers@google.com,
        gabriel.gomes@linux.intel.com, rick.p.edgecombe@intel.com
Subject: [RFC PATCH 06/11] x86/bpf: Support FineIBT
Date:   Tue, 19 Apr 2022 17:42:36 -0700
Message-Id: <20220420004241.2093-7-joao@overdrivepizza.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420004241.2093-1-joao@overdrivepizza.com>
References: <20220420004241.2093-1-joao@overdrivepizza.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joao Moreira <joao@overdrivepizza.com>

BPF jitted code calls helper functions that are in the core and contain a
FineIBT hash check sequence in their prologue. Make BPF jit capable of
identifying FineIBT sequences when emitting calls and properly sum the
offset to bypass it when emitting calls.

Signed-off-by: Joao Moreira <joao@overdrivepizza.com>
Tinkered-from-patches-by: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/net/bpf_jit_comp.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 16b6efacf7c6..e0c82174a075 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -330,13 +330,44 @@ static int emit_patch(u8 **pprog, void *func, void *ip, u8 opcode)
 	return 0;
 }
 
+static inline bool skip_fineibt_sequence(void *func)
+{
+	const void *addr = (void *) func;
+	union text_poke_insn text;
+	u32 insn;
+
+	if ((get_kernel_nofault(insn, addr)) ||
+			(!is_endbr(insn)))
+		return false;
+
+	if ((get_kernel_nofault(text, addr+4)) ||
+			(text.opcode != SUB_INSN_OPCODE))
+		return false;
+
+	if ((get_kernel_nofault(text, addr+11)) ||
+			(text.opcode != JE_INSN_OPCODE))
+		return false;
+
+	if ((get_kernel_nofault(text, addr+13)) ||
+			(text.opcode != CALL_INSN_OPCODE))
+		return false;
+
+	return true;
+}
+
 static int emit_call(u8 **pprog, void *func, void *ip)
 {
+#ifdef CONFIG_X86_KERNEL_FINEIBT
+	if(skip_fineibt_sequence(func)) func = func + FINEIBT_FIXUP;
+#endif
 	return emit_patch(pprog, func, ip, 0xE8);
 }
 
 static int emit_jump(u8 **pprog, void *func, void *ip)
 {
+#ifdef CONFIG_X86_KERNEL_FINEIBT
+	if(skip_fineibt_sequence(func)) func = func + FINEIBT_FIXUP;
+#endif
 	return emit_patch(pprog, func, ip, 0xE9);
 }
 
-- 
2.35.1

