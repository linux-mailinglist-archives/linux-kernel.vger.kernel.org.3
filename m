Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E146B4A6955
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 01:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243541AbiBBAuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 19:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238381AbiBBAuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 19:50:00 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BC2C06173B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 16:50:00 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id 16-20020a621710000000b004c81f7ea48aso9899677pfx.17
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 16:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=4ANd1NUt8XUnXAXLJfyLyXEO2qzCf9R+Cd1MDd6nvE0=;
        b=cV8caTREkXIyZNXOZWEuBAuUILEs8niIQmAdqOwqy9Sp8eEqynTK7+QQfLP6gyuS4b
         lqJ+DmA3d4N9rmH4qlFiXq9ZuJxlNYcx2kzL8EMQN7wwCcTuYDNhXC0oMfxv6WRZ/erF
         Lal5TrRX8YxKFQeXudAvv8ctHBsDTv+un7qkUeHJGEXqf27hSEW0kx1YhXzvy5C/MLDV
         tAyqnNXXEtJt2xM5K/gjXytZFv9025spz7gL0TxZW3v7ZP5RADc78YtJvh84rAFpIYlT
         49wpkearPsmuurMmxnW0FX6oQKa/Sm2/F2QHNrOKGvlpFcTNQh7ZSMt3LbVk8EMMpIaE
         lF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=4ANd1NUt8XUnXAXLJfyLyXEO2qzCf9R+Cd1MDd6nvE0=;
        b=P5/erkALxSC0VXUDae4Vj3MI/J0OT8uV6qXrl6ezIMVTUyImNwmX7xO2nvtNpOTVr/
         HV0ijlHOSJMyn31EDCOAJDu4ryMOHCvwD1lbKUHsid8UAMwf72/cDmILk3CgdtWuGGUa
         p1UZMrZeM8booapkaGbQjs5FmB2pU5yXD01+xT8uWMzcP/RQPefE9fRuzxMHFjSCw4eE
         N7Rka9xkF13fIR5kjtrvkdB9NozpURanV5FME1RYoPolczKrEqGkGUE0509c6o//Z4c8
         +R06ebvt6HB6B0yYKoDVpwJpnZ62M6pkF5RCDWzrK2ZIcPPg8WaEjwqGWdgX9a8GzXlu
         udZA==
X-Gm-Message-State: AOAM532qBSsKBjeyOUkGzJt96LRL37OUeHezall5bzrAy5jpNa8TKaET
        8kI6XzK+1NmX0jUAg1SCbHJJPzdHKYA=
X-Google-Smtp-Source: ABdhPJzT4Dxs+EfukbNZysiCeyomNEphZ+rxnsI/uMF3ouGE9elNSk58GrrmSDabXQRLq7ZfIXwPvIRUsYI=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1989:: with SMTP id
 d9mr27233932pfl.14.1643763000201; Tue, 01 Feb 2022 16:50:00 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  2 Feb 2022 00:49:41 +0000
In-Reply-To: <20220202004945.2540433-1-seanjc@google.com>
Message-Id: <20220202004945.2540433-2-seanjc@google.com>
Mime-Version: 1.0
References: <20220202004945.2540433-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH v2 1/5] Kconfig: Add option for asm goto w/ tied outputs to
 workaround clang-13 bug
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Tadeusz Struk <tadeusz.struk@linaro.org>,
        syzbot+6cde2282daa792c49ab8@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a config option to guard (future) usage of asm_volatile_goto() that
includes "tied outputs", i.e. "+" constraints that specify both an input
and output parameter.  clang-13 has a bug[1] that causes compilation of
such inline asm to fail, and KVM wants to use a "+m" constraint to
implement a uaccess form of CMPXCHG[2].  E.g. the test code fails with

  <stdin>:1:29: error: invalid operand in inline asm: '.long (${1:l}) - .'
  int foo(int *x) { asm goto (".long (%l[bar]) - .\n": "+m"(*x) ::: bar); return *x; bar: return 0; }
                            ^
  <stdin>:1:29: error: unknown token in expression
  <inline asm>:1:9: note: instantiated into assembly here
          .long () - .
                 ^
  2 errors generated.

on clang-13, but passes on gcc (with appropriate asm goto support).  The
bug is fixed in clang-14, but won't be backported to clang-13 as the
changes are too invasive/risky.

gcc also had a similar bug[3], fixed in gcc-11, where gcc failed to
account for its behavior of assigning two numbers to tied outputs (one
for input, one for output) when evaluating symbolic references.

[1] https://github.com/ClangBuiltLinux/linux/issues/1512
[2] https://lore.kernel.org/all/YfMruK8%2F1izZ2VHS@google.com
[3] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=98096

Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 init/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index e9119bf54b1f..4a7a569706c5 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -77,6 +77,11 @@ config CC_HAS_ASM_GOTO_OUTPUT
 	depends on CC_HAS_ASM_GOTO
 	def_bool $(success,echo 'int foo(int x) { asm goto ("": "=r"(x) ::: bar); return x; bar: return 0; }' | $(CC) -x c - -c -o /dev/null)
 
+config CC_HAS_ASM_GOTO_TIED_OUTPUT
+	depends on CC_HAS_ASM_GOTO_OUTPUT
+	# Detect buggy gcc and clang, fixed in gcc-11 clang-14.
+	def_bool $(success,echo 'int foo(int *x) { asm goto (".long (%l[bar]) - .\n": "+m"(*x) ::: bar); return *x; bar: return 0; }' | $CC -x c - -c -o /dev/null)
+
 config TOOLS_SUPPORT_RELR
 	def_bool $(success,env "CC=$(CC)" "LD=$(LD)" "NM=$(NM)" "OBJCOPY=$(OBJCOPY)" $(srctree)/scripts/tools-support-relr.sh)
 
-- 
2.35.0.rc2.247.g8bbb082509-goog

