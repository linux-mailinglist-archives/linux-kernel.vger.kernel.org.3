Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D17951D778
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 14:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391743AbiEFMYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 08:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234150AbiEFMYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 08:24:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0705618E3A
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 05:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=mFmzTI5Jo03LraXZTYkocBmZeHsWILnBwKFw/f1K7rw=; b=pt4LB9+M5XKlyUtn4fETy686Wd
        KxEK/BBAFxufij8k8IEjUUTnBXmzG1/um+FUQr5bt1u2TLgBA9oACNnTOqCYsV17t7IsL45bfolWC
        q4oo9iA0X34NoDaBKcBK6vnw4w/ZI1JmpxOzW01AOc2HTtCDN3IFreOvCGprRSBr10iW+/9kdXeAU
        UK5x2NSxhnLhh7devnMvLKD8WvGCJieU4xi6c6wiVHiNgJcQgoJ9Rfq/ZlNBLjb/PxRMuWKDIJ/hL
        zTlyIMwoYy9mWe1fk1j6pJ/cYLUeHwIwzm+0Z3dNvkAYIYfXyhHSQTobcZyEjd8BwqumE/9eEwYlP
        cQXH6oRw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmwwU-00BfTX-Ab; Fri, 06 May 2022 12:20:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 428BA3007E8;
        Fri,  6 May 2022 14:20:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 03D7E2026BB48; Fri,  6 May 2022 14:20:16 +0200 (CEST)
Message-ID: <20220506121631.508692613@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 06 May 2022 14:14:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, brgerst@gmail.com, jiangshanlai@gmail.com,
        Andrew.Cooper3@citrix.com, mark.rutland@arm.com
Subject: [PATCH 6/6] objtool: Fix STACK_FRAME_NON_STANDARD reloc type
References: <20220506121431.563656641@infradead.org>
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

STACK_FRAME_NON_STANDARD results in inconsistent relocation types
depending on .c or .S usage:

  Relocation section '.rela.discard.func_stack_frame_non_standard' at offset 0x3c01090 contains 5 entries:
  Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
  0000000000000000  00020c2200000002 R_X86_64_PC32          0000000000047b40 do_suspend_lowlevel + 0
  0000000000000008  0002461e00000001 R_X86_64_64            00000000000480a0 machine_real_restart + 0
  0000000000000010  0000001400000001 R_X86_64_64            0000000000000000 .rodata + b3d4
  0000000000000018  0002444600000002 R_X86_64_PC32          00000000000678a0 __efi64_thunk + 0
  0000000000000020  0002659d00000001 R_X86_64_64            0000000000113160 __crash_kexec + 0

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/objtool.h       |    4 +++-
 tools/include/linux/objtool.h |    4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_OBJTOOL_H
 #define _LINUX_OBJTOOL_H
 
+#include <asm/asm.h>
+
 #ifndef __ASSEMBLY__
 
 #include <linux/types.h>
@@ -137,7 +139,7 @@ struct unwind_hint {
 
 .macro STACK_FRAME_NON_STANDARD func:req
 	.pushsection .discard.func_stack_frame_non_standard, "aw"
-		.long \func - .
+	_ASM_PTR \func
 	.popsection
 .endm
 
--- a/tools/include/linux/objtool.h
+++ b/tools/include/linux/objtool.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_OBJTOOL_H
 #define _LINUX_OBJTOOL_H
 
+#include <asm/asm.h>
+
 #ifndef __ASSEMBLY__
 
 #include <linux/types.h>
@@ -137,7 +139,7 @@ struct unwind_hint {
 
 .macro STACK_FRAME_NON_STANDARD func:req
 	.pushsection .discard.func_stack_frame_non_standard, "aw"
-		.long \func - .
+	_ASM_PTR \func
 	.popsection
 .endm
 


