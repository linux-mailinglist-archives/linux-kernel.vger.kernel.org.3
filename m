Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C15057725A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbiGPXR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbiGPXRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:17:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903FE1EC43
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:17:18 -0700 (PDT)
Message-ID: <20220716230952.904222100@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658013436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Cm9gDiq7932M5/ZYpz8elqQRxbwWGV28kDDII2hlkOA=;
        b=v3v7Iw3vOR9bmz6pVjlYRxB+3YnO8YAarmwol4Wh6T3AkL3tpO25bazr3/zogptxF4eeJw
        tgdBjyzpiB0Abquly1hFkOIrycKZ48No12716IgNfaae4Ogj8u5Nz21+akZwDdBeuIXhbL
        7I5iH9g/KAnEsdkbPC7AxEFQA20oib7MjdBCLr55Qcb1aXRYjhyvuzfdZBfePR+SbTD9OE
        hXFR7dVJQbPrLkbJVgckBT1S2bQB3i3u+uHQQqEQoa/uVKgEYea05mIV/OdI8wnq9BPmpC
        gHTNTBHSCUdWkRGMXoyp4y6H8BaNAZ2caITxPbay0T2r7ArLbuLwUPnOZ3xDFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658013436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Cm9gDiq7932M5/ZYpz8elqQRxbwWGV28kDDII2hlkOA=;
        b=z2fuZfBwMoJ6mfiZO1n1hzfp2JSG/rkToGzN33KttWWE8YWi/yalHppY+yHtv00FKH7T47
        ICY5IoQ4zPp+0JCg==
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
Subject: [patch 04/38] x86/vdso: Ensure all kernel code is seen by objtool
References: <20220716230344.239749011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 17 Jul 2022 01:17:16 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

extable.c is kernel code and not part of the VDSO

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/vdso/Makefile |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -30,11 +30,12 @@ vobjs32-y += vdso32/vclock_gettime.o
 vobjs-$(CONFIG_X86_SGX)	+= vsgx.o
 
 # files to link into kernel
-obj-y				+= vma.o extable.o
-KASAN_SANITIZE_vma.o		:= y
-UBSAN_SANITIZE_vma.o		:= y
-KCSAN_SANITIZE_vma.o		:= y
-OBJECT_FILES_NON_STANDARD_vma.o	:= n
+obj-y					+= vma.o extable.o
+KASAN_SANITIZE_vma.o			:= y
+UBSAN_SANITIZE_vma.o			:= y
+KCSAN_SANITIZE_vma.o			:= y
+OBJECT_FILES_NON_STANDARD_vma.o		:= n
+OBJECT_FILES_NON_STANDARD_extable.o	:= n
 
 # vDSO images to build
 vdso_img-$(VDSO64-y)		+= 64

