Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B375487FA2
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 00:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbiAGXwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 18:52:41 -0500
Received: from ip59.38.31.103.in-addr.arpa.unknwn.cloudhost.asia ([103.31.38.59]:44788
        "EHLO gnuweeb.org" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231823AbiAGXwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 18:52:30 -0500
Received: from integral2.. (unknown [36.68.70.227])
        by gnuweeb.org (Postfix) with ESMTPSA id 20915C2045;
        Fri,  7 Jan 2022 23:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=gnuweeb.org;
        s=default; t=1641599545;
        bh=pq7GMGN2XVhws1W/M5TNvweCWJ0nrQE9bX7JQKOZrl4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EcGAmBM+8bc53/WamLCtUjHcN/GJK08c3THc2n/wJ4ve8E1ym8syIcfF3+1ORRLPN
         K2sOyHtvaATkrWujw7uGbcoCOMv7z5Li5LJQw1xBXJD9691TOInj0jM72Br1V9nB2T
         /wwktY/fTVmxI347x5QLOQzjiuXCOONk5FSUnvWPb7ZaqGDgkMLbeCSi3AjQEWd6Z5
         dCNO3fcfxQ04QXAdfpiDlGgS1nq4pyY/BZbSBUrdgQ9TQm0+JlcaFW3le93Sawo36C
         Ul1q6bYdbb6FAgv7cseTd1SRHNIUZlhGSoInZTkCixWzFXUx3Bz9Hl435Emkg1oYHi
         0oD7UU3ipe/qQ==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        Michael Matz <matz@suse.de>, "H.J. Lu" <hjl.tools@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v1 3/3] Documentation: x86-64: Document registers on entry and exit
Date:   Sat,  8 Jan 2022 06:52:10 +0700
Message-Id: <20220107235210.1339168-4-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220107235210.1339168-1-ammarfaizi2@gnuweeb.org>
References: <20220107235210.1339168-1-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There was a controversial discussion about the wording in the System
V ABI document regarding what registers the kernel is allowed to
clobber when the userspace executes syscall.

The resolution of the discussion was reviewing the clobber list in
the glibc source. For a historical reason in the glibc source, the
kernel must restore all registers before returning to the userspace
(except for rax, rcx and r11).

On Wed, 13 Oct 2021 at 16:24:28 +0000, Michael Matz <matz@suse.de> wrote:
> It might also be interesting to know that while the wording of the psABI
> was indeed intended to imply that all argument registers are potentially
> clobbered (like with normal calls) glibc's inline assembler to call
> syscalls relies on most registers to actually be preserved:
>
> # define REGISTERS_CLOBBERED_BY_SYSCALL "cc", "r11", "cx"
> ...
> #define internal_syscall6(number, arg1, arg2, arg3, arg4, arg5, arg6) \
> ({                                                                      \
>     unsigned long int resultvar;                                        \
>     TYPEFY (arg6, __arg6) = ARGIFY (arg6);                              \
>     TYPEFY (arg5, __arg5) = ARGIFY (arg5);                              \
>     TYPEFY (arg4, __arg4) = ARGIFY (arg4);                              \
>     TYPEFY (arg3, __arg3) = ARGIFY (arg3);                              \
>     TYPEFY (arg2, __arg2) = ARGIFY (arg2);                              \
>     TYPEFY (arg1, __arg1) = ARGIFY (arg1);                              \
>     register TYPEFY (arg6, _a6) asm ("r9") = __arg6;                    \
>     register TYPEFY (arg5, _a5) asm ("r8") = __arg5;                    \
>     register TYPEFY (arg4, _a4) asm ("r10") = __arg4;                   \
>     register TYPEFY (arg3, _a3) asm ("rdx") = __arg3;                   \
>     register TYPEFY (arg2, _a2) asm ("rsi") = __arg2;                   \
>     register TYPEFY (arg1, _a1) asm ("rdi") = __arg1;                   \
>     asm volatile (                                                      \
>     "syscall\n\t"                                                       \
>     : "=a" (resultvar)                                                  \
>     : "0" (number), "r" (_a1), "r" (_a2), "r" (_a3), "r" (_a4),         \
>       "r" (_a5), "r" (_a6)                                              \
>     : "memory", REGISTERS_CLOBBERED_BY_SYSCALL);                        \
>     (long int) resultvar;                                               \
> })
>
>
> Note in particular the missing clobbers or outputs of any of the argument
> regs.
>
> So, even though the psABI (might have) meant something else, as glibc is
> doing the above we in fact have a de-facto standard that the kernel can't
> clobber any of the argument regs.  The wording and the linux x86-64
> syscall implementation (and use in glibc) all come from the same time in
> 2001, so there never was a time when the kernel was not saving/restoring
> the arg registers, so it can't stop now.
>
> In effect this means the psABI should be clarified to explicitely say the
> the arg registers aren't clobbered, i.e. that the mentioned list of
> clobbered regs isn't inclusive but exclusive.  I will do that.
>
> When I was discussing this with Boris earlier I hadn't yet looked at glibc
> use but only gave my interpretation from memory and reading.  Obviously
> reality trumps anything like that :-)

Link: https://lore.kernel.org/lkml/alpine.LSU.2.20.2110131601000.26294@wotan.suse.de/
Link: https://gitlab.com/x86-psABIs/x86-64-ABI/-/merge_requests/25

This documents "registers on entry" and "registers on exit".

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Michael Matz <matz@suse.de>
Cc: "H.J. Lu" <hjl.tools@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Willy Tarreau <w@1wt.eu>
Cc: x86-ml <x86@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Cc: GNU/Weeb Mailing List <gwml@gnuweeb.org>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 Documentation/x86/entry_64.rst | 47 ++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/x86/entry_64.rst b/Documentation/x86/entry_64.rst
index e433e08f7018..3f2007e2a938 100644
--- a/Documentation/x86/entry_64.rst
+++ b/Documentation/x86/entry_64.rst
@@ -108,3 +108,50 @@ We try to only use IST entries and the paranoid entry code for vectors
 that absolutely need the more expensive check for the GS base - and we
 generate all 'normal' entry points with the regular (faster) paranoid=0
 variant.
+
+
+Registers on entry:
+-------------------
+
+  - rax  system call number
+  - rcx  return address
+  - r11  saved rflags (note: r11 is callee-clobbered register in C ABI)
+  - rdi  arg0
+  - rsi  arg1
+  - rdx  arg2
+  - r10  arg3 (needs to be moved to rcx to conform to C ABI)
+  - r8   arg4
+  - r9   arg5
+
+
+Registers on exit:
+------------------
+
+This explanation is adapted from a controversial discussion about the
+wording in the System V ABI document regarding what registers the
+kernel is allowed to clobber when the userspace executes syscall.
+
+The resolution of the discussion was reviewing the clobber list in the
+glibc source. For a historical reason in the glibc source, the kernel
+must restore all registers before returning to the userspace (except
+for rax, rcx and r11).
+
+For the detailed story, see the email from Michael Matz:
+
+https://lore.kernel.org/lkml/alpine.LSU.2.20.2110131601000.26294@wotan.suse.de/
+
+The kernel saves/restores all registers, so the userspace using it can
+assume the value of all registers are still intact, except for the rax,
+rcx, and r11.
+
+When the kernel returns to the userspace, only 3 registers are
+clobbered:
+
+  - rax  syscall return value
+  - rcx  return address
+  - r11  rflags
+
+The kernel syscall entry actually also saves/restores rcx and r11, but
+at that point, they have already been overwritten by the syscall
+instruction itself with the userspace rip and rflags value, they will
+be used by the sysret instruction when returning to the userspace.
-- 
2.32.0

