Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00755156BF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 23:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237826AbiD2V0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 17:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236993AbiD2V0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 17:26:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A4D53B54
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fq0OOJPCMavBT+EhrhU7rTo/wq7ZnPOHuT6uKwhzCBs=; b=WssMZGSrGMbWgJ5GxspxEKISec
        dpJIGdZzLUxusmk2snNNTSBjuVQOfCcmfm4lfzLodCCq0Rt16xnANmtw7lV5v12x/iiQUNYJee69H
        6FU9hFFPmoom004Q3RqWOBxRTMl9dVUlmqyemnnVZaBJR3OkfOpEOKYFHo/8/ER0U3ff9zsLxa6WF
        dalzKtPvYELQnsQDqvksOCp3WkqOkK5e30NngL4kdiaYMISpNPCcPi2fJoWbjLPBwXhENQc0V8Nym
        ZTOg68g+ommUgIyHii98aKO5g9YsPwxFuKFCDTPZd+5sX3NwLQKScHExbChmcHyKqo+tvv0HqRwN2
        omLRSXwg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkY4S-00CoKv-3Q; Fri, 29 Apr 2022 21:22:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AF188300385;
        Fri, 29 Apr 2022 23:22:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 966A220295B20; Fri, 29 Apr 2022 23:22:35 +0200 (CEST)
Date:   Fri, 29 Apr 2022 23:22:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] objtool: Fix STACK_FRAME_NON_STANDARD reloc type
Message-ID: <YmxXG3Teg0gJ5PVh@hirez.programming.kicks-ass.net>
References: <20220429092024.GT2731@worktop.programming.kicks-ass.net>
 <20220429201325.d5kifdezdru2i3lp@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429201325.d5kifdezdru2i3lp@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 01:13:25PM -0700, Josh Poimboeuf wrote:
> Can use _ASM_PTR here, and objtool.h needs synced to tools.

Here goes..

---
Subject: objtool: Fix STACK_FRAME_NON_STANDARD reloc type
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue Apr 26 17:08:53 CEST 2022

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
 include/linux/objtool.h       |    2 +-
 tools/include/linux/objtool.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -137,7 +137,7 @@ struct unwind_hint {
 
 .macro STACK_FRAME_NON_STANDARD func:req
 	.pushsection .discard.func_stack_frame_non_standard, "aw"
-		.long \func - .
+	_ASM_PTR \func
 	.popsection
 .endm
 
--- a/tools/include/linux/objtool.h
+++ b/tools/include/linux/objtool.h
@@ -137,7 +137,7 @@ struct unwind_hint {
 
 .macro STACK_FRAME_NON_STANDARD func:req
 	.pushsection .discard.func_stack_frame_non_standard, "aw"
-		.long \func - .
+	_ASM_PTR \func
 	.popsection
 .endm
 
