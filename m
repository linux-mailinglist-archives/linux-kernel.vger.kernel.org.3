Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2381F4C2F56
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236007AbiBXPS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235964AbiBXPS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:18:28 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B631E141FDA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Yj19WDVgOEiJ0u+eDY2fpBdavc72lJgYztZwSidBut8=; b=huSxBs5/4Cw6YNoG7UFgt3t7Ns
        8JTYhzjzZxMXNZPcxsVqdc5ldJU1s8lxQHnkQgl915iccJtGVP2ntyVayz+YDtwKo3c6KIGEqEaqy
        a5edumCOltibzxLR4fYCktPvMWshH8ZUVY64O6Isj7MbvcD7/9QZbQUwnUugKjSJehkPoPeUoCuE6
        4HNbXcjzFTedgxPuutn9CJCcrNNS4HN2LpTgoXkLbelKoqKNaOltnPOsF/GoLqQXDcXDhSYoLY0AQ
        yuXdeOqq8LyZpPjxrTTXMgcZwR4yy41PgDLIWEXZFrjsV2tZY6JEEWk+BWgkz9V6l6FilVmn97BC0
        AuDEAZpQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNFs2-00CeLW-JQ; Thu, 24 Feb 2022 15:17:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 66687300727;
        Thu, 24 Feb 2022 16:17:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 24EFD29E75E4D; Thu, 24 Feb 2022 16:17:28 +0100 (CET)
Message-ID: <20220224151322.190822141@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Feb 2022 15:51:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v2 03/39] x86/module: Fix the paravirt vs alternative order
References: <20220224145138.952963315@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ever since commit 4e6292114c741 ("x86/paravirt: Add new features for
paravirt patching") there is an ordering dependency between patching
paravirt ops and patching alternatives, the module loader still
violates this.

Fixes: 4e6292114c741 ("x86/paravirt: Add new features for paravirt patching")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/module.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -273,6 +273,14 @@ int module_finalize(const Elf_Ehdr *hdr,
 			retpolines = s;
 	}
 
+	/*
+	 * See alternative_instructions() for the ordering rules between the
+	 * various patching types.
+	 */
+	if (para) {
+		void *pseg = (void *)para->sh_addr;
+		apply_paravirt(pseg, pseg + para->sh_size);
+	}
 	if (retpolines) {
 		void *rseg = (void *)retpolines->sh_addr;
 		apply_retpolines(rseg, rseg + retpolines->sh_size);
@@ -290,11 +298,6 @@ int module_finalize(const Elf_Ehdr *hdr,
 					    tseg, tseg + text->sh_size);
 	}
 
-	if (para) {
-		void *pseg = (void *)para->sh_addr;
-		apply_paravirt(pseg, pseg + para->sh_size);
-	}
-
 	/* make jump label nops */
 	jump_label_apply_nops(me);
 


