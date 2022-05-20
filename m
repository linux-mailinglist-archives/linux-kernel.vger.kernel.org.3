Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9B252E747
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 10:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbiETI0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 04:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346989AbiETI0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:26:30 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F6C29820;
        Fri, 20 May 2022 01:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=gaCGQ+yh5emdDRE8cYRxfgXVHDQKI8BJefKClfe7IyY=; b=BNtIToPR3S91hd3/lYWM5PuHtJ
        4yfRneRpNaesTR+JwYbd4ysDiHDO10CBmCWNInTOevbpQgvYWBBMhKRGG0xmsWkXVRdj0gtfooQYQ
        ADgRdKdcjTgtBRW5IiGEavMoG/2WtGLUfuhxOBC0ae6T2w+xGnl76IbvP9rtnMS7lAEuUteurlye9
        TEhqCMVzOCDTS1oPR3OtWVyDKiUtKyeD2vcvhZLhgj2gervxXpxi4ecpbzq6xdrSpuExko4CznQ9W
        i5ZpAPcbaYl79IGnEUdKTL8/7IT7+H/FnL2RcmdkvF0lu6CLQyFaG8s8deMTD51UAJcBtBuEVixXZ
        8eKmLIKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrxxX-002H5V-4y; Fri, 20 May 2022 08:26:09 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 77306980E7F; Fri, 20 May 2022 10:26:04 +0200 (CEST)
Date:   Fri, 20 May 2022 10:26:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        jiangshan.ljs@antgroup.com, bp@suse.de
Subject: [PATCH] x86/entry: Fixup objtool/ibt validation
Message-ID: <20220520082604.GQ2578@worktop.programming.kicks-ass.net>
References: <20220520174954.1c306fc0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220520174954.1c306fc0@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 05:49:54PM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> After merging the tip tree, today's linux-next build (x86_64 allmodconfig)
> produced these warnings:
>=20
> vmlinux.o: warning: objtool: vc_switch_off_ist+0x76: relocation to !ENDBR=
: entry_SYSCALL_64+0x15c
> vmlinux.o: warning: objtool: vc_switch_off_ist+0x8e: relocation to !ENDBR=
: entry_SYSCALL_compat+0xa5
> vmlinux.o: warning: objtool: vc_switch_off_ist+0x96: relocation to !ENDBR=
: .entry.text+0x21ca
> vmlinux.o: warning: objtool: vc_switch_off_ist+0xee: relocation to !ENDBR=
: .entry.text+0x162
> vmlinux.o: warning: objtool: __sev_es_ist_enter+0x5f: relocation to !ENDB=
R: entry_SYSCALL_64+0x15c
> vmlinux.o: warning: objtool: __sev_es_ist_enter+0x6b: relocation to !ENDB=
R: .entry.text+0x162
> vmlinux.o: warning: objtool: __sev_es_ist_enter+0x89: relocation to !ENDB=
R: entry_SYSCALL_compat+0xa5
> vmlinux.o: warning: objtool: __sev_es_ist_enter+0xc0: relocation to !ENDB=
R: .entry.text+0x21ca
>=20
> I don't know what caused this.

It's commit 47f33de4aafb ("x86/sev: Mark the code returning to user space a=
s syscall gap")
that added a bunch of text references.

Lai, Boris, can we please be careful with that?

---
Subject: x86/entry: Fixup objtool/ibt validation

Commit 47f33de4aafb ("x86/sev: Mark the code returning to user space as
syscall gap") added a bunch of text references without annotating them,
resulting in a spree of objtool complaints:

  vmlinux.o: warning: objtool: vc_switch_off_ist+0x77: relocation to !ENDBR=
: entry_SYSCALL_64+0x15c
  vmlinux.o: warning: objtool: vc_switch_off_ist+0x8f: relocation to !ENDBR=
: entry_SYSCALL_compat+0xa5
  vmlinux.o: warning: objtool: vc_switch_off_ist+0x97: relocation to !ENDBR=
: .entry.text+0x21ea
  vmlinux.o: warning: objtool: vc_switch_off_ist+0xef: relocation to !ENDBR=
: .entry.text+0x162
  vmlinux.o: warning: objtool: __sev_es_ist_enter+0x60: relocation to !ENDB=
R: entry_SYSCALL_64+0x15c
  vmlinux.o: warning: objtool: __sev_es_ist_enter+0x6c: relocation to !ENDB=
R: .entry.text+0x162
  vmlinux.o: warning: objtool: __sev_es_ist_enter+0x8a: relocation to !ENDB=
R: entry_SYSCALL_compat+0xa5
  vmlinux.o: warning: objtool: __sev_es_ist_enter+0xc1: relocation to !ENDB=
R: .entry.text+0x21ea

Since these text references are used to compare against IP, and are not
an indirect call target, they don't need ENDBR so annotate them away.

Fixes: 47f33de4aafb ("x86/sev: Mark the code returning to user space as sys=
call gap")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_64.S        | 3 +++
 arch/x86/entry/entry_64_compat.S | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 5ec42bf86a61..221f82b4abc2 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -215,9 +215,12 @@ syscall_return_via_sysret:
 	popq	%rdi
 	popq	%rsp
 SYM_INNER_LABEL(entry_SYSRETQ_unsafe_stack, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR
 	swapgs
 	sysretq
 SYM_INNER_LABEL(entry_SYSRETQ_end, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR
+	int3
 SYM_CODE_END(entry_SYSCALL_64)

 /*
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_com=
pat.S
index 84ffcf504554..95d23364a131 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -245,6 +245,7 @@ sysret32_from_system_call:
          */
 	movq	RSP-ORIG_RAX(%rsp), %rsp
 SYM_INNER_LABEL(entry_SYSRETL_compat_unsafe_stack, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR

 	/*
 	 * The original userspace %rsp (RSP-ORIG_RAX(%rsp)) is stored
@@ -263,6 +264,8 @@ SYM_INNER_LABEL(entry_SYSRETL_compat_unsafe_stack, SYM_=
L_GLOBAL)
 	swapgs
 	sysretl
 SYM_INNER_LABEL(entry_SYSRETL_compat_end, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR
+	int3
 SYM_CODE_END(entry_SYSCALL_compat)

 /*

