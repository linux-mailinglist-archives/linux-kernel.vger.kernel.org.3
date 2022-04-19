Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659F3507AB5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357644AbiDSUMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357213AbiDSUL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:11:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FF63B578;
        Tue, 19 Apr 2022 13:08:45 -0700 (PDT)
Date:   Tue, 19 Apr 2022 20:08:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650398924;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yls/9B9Yczz+xBHu/VTOozK/UB3dXNmhLBxQDqdIcrM=;
        b=y8ShKEENQJhyj6mQRCgwHbOQue49O757A77IOrWb08KUyo3gZkgQHRZ/aw+x6cVAJfbh9G
        oQGqgXk4ohhz1ziLwAELI05r0lrxuxB4rO/DV9Xuyd/X0GVgUemYmcHkC8NmYkIYJjJ5zR
        wGA/x9Qpn1Eev5c4K0dx2LCcjl2ql/I7bOcMfBcz6DzqAWpb1TDeGU06OxE1glKdLAYDJM
        eJJ739LXiPWt/Eetz6b7FTXkcbdRcj5PJGSqj4tbktlGMtMt1V4jwVEUn57VcKDkakOTA3
        lp5G8Sg3VwQc3ZOqdgcTicNah5Eh55YNLGHILCYNechbL0q0DLtRcQcHG6uhiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650398924;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yls/9B9Yczz+xBHu/VTOozK/UB3dXNmhLBxQDqdIcrM=;
        b=4Mjzj03VvGC2DHMHWa90HxJ/7UcvRdLTKbmNy2p4iQPU8GJP0s37I2j5WQYKgEFLzewH9i
        7mc5qothklMARpAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86,xen,objtool: Add UNWIND hint
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220408094718.321246297@infradead.org>
References: <20220408094718.321246297@infradead.org>
MIME-Version: 1.0
Message-ID: <165039892316.4207.7405922361985895288.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     2730d3c14a85617c177337f2e2af2108bf82c4ca
Gitweb:        https://git.kernel.org/tip/2730d3c14a85617c177337f2e2af2108bf82c4ca
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 08 Apr 2022 11:45:54 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 19 Apr 2022 21:58:47 +02:00

x86,xen,objtool: Add UNWIND hint

SYM_CODE_START*() doesn't get auto-validated and needs an UNWIND hint
to get checked, add one.

  vmlinux.o: warning: objtool: pvh_start_xen()+0x0: unreachable

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Reported-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220408094718.321246297@infradead.org
---
 arch/x86/platform/pvh/head.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index 72c1e42..7fe564e 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -50,6 +50,7 @@
 #define PVH_DS_SEL		(PVH_GDT_ENTRY_DS * 8)
 
 SYM_CODE_START_LOCAL(pvh_start_xen)
+	UNWIND_HINT_EMPTY
 	cld
 
 	lgdt (_pa(gdt))
