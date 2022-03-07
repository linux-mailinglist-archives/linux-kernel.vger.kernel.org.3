Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3EB4CFD55
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240373AbiCGLrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240917AbiCGLr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:47:29 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5046B673CD;
        Mon,  7 Mar 2022 03:46:30 -0800 (PST)
Received: from integral2.. (unknown [182.2.38.152])
        by gnuweeb.org (Postfix) with ESMTPSA id C6C2A7E248;
        Mon,  7 Mar 2022 11:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1646653589;
        bh=312ClY2TF1vfr/9Ev0z6C5MG3DUanFPh1/gqtPzwpOs=;
        h=From:To:Cc:Subject:Date:From;
        b=RX3h6pRr4fNGtu3e6dOEyFq5COjbqEtNdDge1VtNmuWqZN8t8zXeGVRCm+2SPFfuJ
         Wa1UhU+CAePcAXP1zJ3OSf8iUV7XjMqM6lupmH8yIhK3sXVFXJMPpXjGlsCAj1j5hr
         ygLF/JdjFAj7qzx0nALOViUgFHqCIZ5vZnA4N+Q5TCy2Jh4pW2xaN//BZNJBo9AaOh
         fH5BE6sIuCZvB9Yjsh4g+GaVyY9yEtLB08S0ZfwoHQ5AGCSLoyBO3y0APBMtOY2TOp
         eNglrD0kKiKBans9A4GALKjS+K5S5oJ2mYjjQG1CN0Gv4HQEXjl+/3eTdfgwS9RTmz
         5dyBS62O4XDhA==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Youquan Song <youquan.song@intel.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        gwml@vger.gnuweeb.org, x86@kernel.org
Subject: [PATCH v1 0/2] x86: Avoid using INC and DEC instructions on hot paths
Date:   Mon,  7 Mar 2022 18:45:56 +0700
Message-Id: <20220307114558.1234494-1-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In order to take maximum advantage of out-of-order execution,
avoid using INC/DEC instructions when appropriate. INC/DEC only
writes to part of the flags register, which can cause a partial
flag register stall. This series replaces INC/DEC with ADD/SUB.

Agner Fog's optimization manual says [1]:
"""
  The INC and DEC instructions are inefficient on some CPUs because they
  write to only part of the flags register (excluding the carry flag).
  Use ADD or SUB instead to avoid false dependences or inefficient
  splitting of the flags register, especially if they are followed by
  an instruction that reads the flags.
"""

Intel's optimization manual 3.5.1.1 says [2]:
"""
  The INC and DEC instructions modify only a subset of the bits in the
  flag register. This creates a dependence on all previous writes of
  the flag register. This is especially problematic when these
  instructions are on the critical path because they are used to change
  an address for a load on which many other instructions depend.

  Assembly/Compiler Coding Rule 33. (M impact, H generality) INC and DEC
  instructions should be replaced with ADD or SUB instructions, because
  ADD and SUB overwrite all flags, whereas INC and DEC do not, therefore
  creating false dependencies on earlier instructions that set the flags.
"""

Newer compilers also do it for generic x86-64 CPU (https://godbolt.org/z/rjsfbdx54).
# C code:

  int fy_inc(int a, int b, int c)
  {
      a++; b++; c++;
      return a * b * c;
  }

# ASM
## GCC 4.1.2 and older use INC (old).
fy_inc:
    incl    %edi
    incl    %esi
    leal    1(%rdx), %eax
    imull   %esi, %edi
    imull   %edi, %eax
    ret

## GCC 4.4.7 to GCC 11.2 use ADD (new).
fy_inc:
    addl    $1, %edi
    addl    $1, %esi
    addl    $1, %edx
    imull   %esi, %edi
    movl    %edi, %eax
    imull   %edx, %eax
    ret

## Clang 5.0.2 and older use INC (old).
fy_inc:
    incl    %edi
    leal    1(%rsi), %eax
    imull   %edi, %eax
    incl    %edx
    imull   %edx, %eax
    retq

## Clang 6.0.0 to Clang 13.0.1 use ADD (new).
fy_inc:
    addl    $1, %edi
    leal    1(%rsi), %eax
    imull   %edi, %eax
    addl    $1, %edx
    imull   %edx, %eax
    retq

[1]: https://www.agner.org/optimize/optimizing_assembly.pdf
[2]: https://www.intel.com/content/dam/www/public/us/en/documents/manuals/64-ia-32-architectures-optimization-manual.pdf

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
Ammar Faizi (2):
  x86/include/asm: Avoid using INC and DEC instructions on hot paths
  x86/lib: Avoid using INC and DEC instructions on hot paths

 arch/x86/include/asm/xor_32.h | 16 ++++++++--------
 arch/x86/lib/copy_mc_64.S     | 14 +++++++-------
 arch/x86/lib/copy_user_64.S   | 26 +++++++++++++-------------
 arch/x86/lib/memset_64.S      |  6 +++---
 arch/x86/lib/string_32.c      | 20 ++++++++++----------
 arch/x86/lib/strstr_32.c      |  4 ++--
 arch/x86/lib/usercopy_64.c    | 12 ++++++------
 7 files changed, 49 insertions(+), 49 deletions(-)


base-commit: ffb217a13a2eaf6d5bd974fc83036a53ca69f1e2
-- 
Ammar Faizi

