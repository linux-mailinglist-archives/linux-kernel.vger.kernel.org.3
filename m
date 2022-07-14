Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C45574625
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 09:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237700AbiGNHw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 03:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237666AbiGNHwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 03:52:04 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE094357CE
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 00:49:20 -0700 (PDT)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DEBCE3FD77
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1657784957;
        bh=ru92NeW5g35ZFxOqI1Jb++780ZQeradGocVi2TLd6GE=;
        h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type;
        b=g13IB5JXyA6usMn+yicdbwvdKqAV8utUuASTGnea4z5SfBTJeDxEU5QFWVu1dg+sa
         /LO2GlIPSGyzr8aq6KOPp/hyLUMdi8disAhLOr/bDp5kDF9W0chlC6y+5uBkCK1wK3
         +GHNhc317wHryPqDzbQYpqBBWTXIe01p/DcnzN3gfG8JhyTkHcyO7AZR/jjx4A1ihb
         U1s/9ZrQ3bEOMJc/R719W2VntQI+jhLRmjBiOb09KeoHsH2CAfy3UnbNMKN3I2oLNF
         sibPXSBGRXQqErdeaYTPuoqLILXn53PIOdkinflw1W/yQxnwPugjNgaySNy1mSBB/e
         eEA79pnie+hag==
Received: by mail-ej1-f71.google.com with SMTP id qw8-20020a1709066a0800b0072abb95c0caso424085ejc.15
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 00:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ru92NeW5g35ZFxOqI1Jb++780ZQeradGocVi2TLd6GE=;
        b=FKxVlkA2YlqNhCU2O4hpZ7D3aNvrpl99TjuLIT14JX3CiKvMROZ8xhpGgk4+ANpbx1
         jA94WXPknqHfsZ+lMbWLyoC4c3hfeUD0BsLNRKa/IAnnCsdIzUCTPx9iWOeb5+U1cmtj
         5hC1x2EC6P6p0unn8sb771hapwigAh2Wtnet+GkRqfwwy2b1l+vYU2svB1gsKXrDy/xc
         Gmp2qixirYa76wcARrguM98DOD2f/lMW2mkaLEsPlXW2rQ0eTo989Ql/3n3foSBAhz/F
         SqzadP9sltSlSORVWN1QBma11fXZUSifD6fiBUj1Ci9RmVIV/U8/06oovB8Fg9MqsAG0
         zhsw==
X-Gm-Message-State: AJIora9tkW6ReAhWzxGVk02+mSxM4fRGvdndRbJLesLW+TIPnl1JDrVP
        bRUF2aILKQTKo2vv3eekoNnAUzOHClfBBLfzjdS9x2ro9Ppm7ZTgXL2bKueSctspee0vM8SrgMb
        cFN6jj66Wxv5E3PODmIOrYBQxl0A9YcNHMBeD/eJqdQ==
X-Received: by 2002:a17:906:7386:b0:715:7024:3df7 with SMTP id f6-20020a170906738600b0071570243df7mr7641895ejl.543.1657784957531;
        Thu, 14 Jul 2022 00:49:17 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u0i3ByKydjHXecFgiEiZThLjzaR73ohdpt+ID4N4aAM1yy7oR5xNprhfnWRNlPexiKJoYvlg==
X-Received: by 2002:a17:906:7386:b0:715:7024:3df7 with SMTP id f6-20020a170906738600b0071570243df7mr7641880ejl.543.1657784957322;
        Thu, 14 Jul 2022 00:49:17 -0700 (PDT)
Received: from localhost ([2001:67c:1560:8007::aac:c1b6])
        by smtp.gmail.com with ESMTPSA id y2-20020a170906524200b0072a66960843sm375935ejm.51.2022.07.14.00.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 00:49:16 -0700 (PDT)
Date:   Thu, 14 Jul 2022 09:49:15 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        x86@kernel.org, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2][RESEND] x86/entry: build thunk_$(BITS) only if
 CONFIG_PREEMPTION=y
Message-ID: <Ys/Ke7EWjcX+ZlXO@arighi-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_PREEMPTION disabled, arch/x86/entry/thunk_$(BITS).o becomes
an empty object file.

With some old versions of binutils (i.e., 2.35.90.20210113-1ubuntu1) the
GNU assembler doesn't generate a symbol table for empty object files and
objtool fails with the following error when a valid symbol table cannot
be found:

  arch/x86/entry/thunk_64.o: warning: objtool: missing symbol table

To prevent this from happening, build thunk_$(BITS).o only if
CONFIG_PREEMPTION is enabled.

BugLink: https://bugs.launchpad.net/bugs/1911359
Fixes: 320100a5ffe5 ("x86/entry: Remove the TRACE_IRQS cruft")
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 arch/x86/entry/Makefile   | 3 ++-
 arch/x86/entry/thunk_32.S | 2 --
 arch/x86/entry/thunk_64.S | 4 ----
 arch/x86/um/Makefile      | 3 ++-
 4 files changed, 4 insertions(+), 8 deletions(-)

ChangeLog (v1 -> v2):
 - rebased to the latest kernel
 - do not break UML build

diff --git a/arch/x86/entry/Makefile b/arch/x86/entry/Makefile
index eeadbd7d92cc..ca2fe186994b 100644
--- a/arch/x86/entry/Makefile
+++ b/arch/x86/entry/Makefile
@@ -11,12 +11,13 @@ CFLAGS_REMOVE_common.o		= $(CC_FLAGS_FTRACE)
 
 CFLAGS_common.o			+= -fno-stack-protector
 
-obj-y				:= entry.o entry_$(BITS).o thunk_$(BITS).o syscall_$(BITS).o
+obj-y				:= entry.o entry_$(BITS).o syscall_$(BITS).o
 obj-y				+= common.o
 
 obj-y				+= vdso/
 obj-y				+= vsyscall/
 
+obj-$(CONFIG_PREEMPTION)	+= thunk_$(BITS).o
 obj-$(CONFIG_IA32_EMULATION)	+= entry_64_compat.o syscall_32.o
 obj-$(CONFIG_X86_X32_ABI)	+= syscall_x32.o
 
diff --git a/arch/x86/entry/thunk_32.S b/arch/x86/entry/thunk_32.S
index 7591bab060f7..ff6e7003da97 100644
--- a/arch/x86/entry/thunk_32.S
+++ b/arch/x86/entry/thunk_32.S
@@ -29,10 +29,8 @@ SYM_CODE_START_NOALIGN(\name)
 SYM_CODE_END(\name)
 	.endm
 
-#ifdef CONFIG_PREEMPTION
 	THUNK preempt_schedule_thunk, preempt_schedule
 	THUNK preempt_schedule_notrace_thunk, preempt_schedule_notrace
 	EXPORT_SYMBOL(preempt_schedule_thunk)
 	EXPORT_SYMBOL(preempt_schedule_notrace_thunk)
-#endif
 
diff --git a/arch/x86/entry/thunk_64.S b/arch/x86/entry/thunk_64.S
index 505b488fcc65..f38b07d2768b 100644
--- a/arch/x86/entry/thunk_64.S
+++ b/arch/x86/entry/thunk_64.S
@@ -31,14 +31,11 @@ SYM_FUNC_END(\name)
 	_ASM_NOKPROBE(\name)
 	.endm
 
-#ifdef CONFIG_PREEMPTION
 	THUNK preempt_schedule_thunk, preempt_schedule
 	THUNK preempt_schedule_notrace_thunk, preempt_schedule_notrace
 	EXPORT_SYMBOL(preempt_schedule_thunk)
 	EXPORT_SYMBOL(preempt_schedule_notrace_thunk)
-#endif
 
-#ifdef CONFIG_PREEMPTION
 SYM_CODE_START_LOCAL_NOALIGN(__thunk_restore)
 	popq %r11
 	popq %r10
@@ -53,4 +50,3 @@ SYM_CODE_START_LOCAL_NOALIGN(__thunk_restore)
 	RET
 	_ASM_NOKPROBE(__thunk_restore)
 SYM_CODE_END(__thunk_restore)
-#endif
diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index ba5789c35809..a8cde4e8ab11 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -28,7 +28,8 @@ else
 
 obj-y += syscalls_64.o vdso/
 
-subarch-y = ../lib/csum-partial_64.o ../lib/memcpy_64.o ../entry/thunk_64.o
+subarch-y = ../lib/csum-partial_64.o ../lib/memcpy_64.o
+subarch-$(CONFIG_PREEMPTION) += ../entry/thunk_64.o
 
 endif
 
-- 
2.34.1

