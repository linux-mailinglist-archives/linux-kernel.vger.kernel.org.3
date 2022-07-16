Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520FF57725C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbiGPXSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbiGPXR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:17:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94B522B2E
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:17:42 -0700 (PDT)
Message-ID: <20220716230953.797450674@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658013461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Gd8NwNu0ThhW0QIu3FBYrL07cfGnrA/dNAI5sapg5h4=;
        b=0O24DsJodMkB5DrVniuZ4ogXsrq9F1bYco2YpjBQGKf+eecMM8rY85pVx1I/GadFtI62gr
        dTM8eMRJeDwEw7lwUNNrPzWOp7GYZ8jfEPKhNyZSSgN8jrekY2JSr60ANa2pakJL2EAT4e
        X2q824R+a5cANkpk9QvYidykE69ATDuY8zf9WI/ycMH4Z4hzInpgXan320MlWmMWmrzCou
        xexzhHemoJ5jtG7kn5Z/U7R/HNif/qplGITBm6aZ31YFp2l1Dm9GnwXAyrjW+2NkpZm9OH
        Wr/PWb3p9A5dzY+JzIAK0IKa5nxYp3qfNHTs3jY6ioajGrf5Ds1mmUsgDJXOaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658013461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Gd8NwNu0ThhW0QIu3FBYrL07cfGnrA/dNAI5sapg5h4=;
        b=gWxtHbQ2jxPqv72i7D8iswJsg0w+AneZOt2jcgCU3+AzgemDt1n5OCvA9fGElCshbOCGkr
        lplWgFJrplByDHAA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [patch 19/38] x86/module: Provide __module_alloc()
References: <20220716230344.239749011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 17 Jul 2022 01:17:40 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a function to allocate from module space with large TLBs. This is
required for callthunks as otherwise the ITLB pressure kills performance.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/module.h |    2 ++
 arch/x86/mm/module_alloc.c    |   10 ++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/module.h
+++ b/arch/x86/include/asm/module.h
@@ -13,4 +13,6 @@ struct mod_arch_specific {
 #endif
 };
 
+extern void *__module_alloc(unsigned long size, unsigned long vmflags);
+
 #endif /* _ASM_X86_MODULE_H */
--- a/arch/x86/mm/module_alloc.c
+++ b/arch/x86/mm/module_alloc.c
@@ -39,7 +39,7 @@ static unsigned long int get_module_load
 }
 #endif
 
-void *module_alloc(unsigned long size)
+void *__module_alloc(unsigned long size, unsigned long vmflags)
 {
 	gfp_t gfp_mask = GFP_KERNEL;
 	void *p;
@@ -47,10 +47,11 @@ void *module_alloc(unsigned long size)
 	if (PAGE_ALIGN(size) > MODULES_LEN)
 		return NULL;
 
+	vmflags |= VM_FLUSH_RESET_PERMS | VM_DEFER_KMEMLEAK;
 	p = __vmalloc_node_range(size, MODULE_ALIGN,
 				 MODULES_VADDR + get_module_load_offset(),
 				 MODULES_END, gfp_mask, PAGE_KERNEL,
-				 VM_FLUSH_RESET_PERMS | VM_DEFER_KMEMLEAK,
+				 vmflags,
 				 NUMA_NO_NODE, __builtin_return_address(0));
 
 	if (p && (kasan_alloc_module_shadow(p, size, gfp_mask) < 0)) {
@@ -60,3 +61,8 @@ void *module_alloc(unsigned long size)
 
 	return p;
 }
+
+void *module_alloc(unsigned long size)
+{
+	return __module_alloc(size, 0);
+}

