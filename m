Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 184EA46FF64
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 12:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240445AbhLJLJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 06:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240284AbhLJLI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 06:08:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE9CC061353;
        Fri, 10 Dec 2021 03:05:22 -0800 (PST)
Date:   Fri, 10 Dec 2021 11:05:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639134320;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MssHXMCrQN31dY2N3/ceydmP1UXuME7QpiDNl8chhYY=;
        b=LuNZcMVG1c6/3LXsoSZGnQvGTDFRQHjGltCOZaBEXUbitzboWlvi6IpoZL/oC5PWJ1C+c/
        sFgNQwqc9tBXTMFEd2SrztB/cjXZJmlOQrx9d5xzx+ttXLwgA1oWicaE5YhRoTTgNtZMkj
        CTC5F1kW5xENw+sbbCkY1QCH/2MItG7+GixjgqeLbKBUhrUsBKVsDaD7ILZEA8VdKluoIF
        LDebmG2QUfXaBWiaG1Snc65oOoe7F53vwNq3t89FT+Kk+YgHiVhLBqD7e+eOIrbZML4nun
        saFuDdtteBVFgJFihQVf+bb9jKikVrF1CKtd8N9s8auA0qrFtzhoAHNC59y+GA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639134320;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MssHXMCrQN31dY2N3/ceydmP1UXuME7QpiDNl8chhYY=;
        b=2BWq/gjlIr8Pz2pDS7IrHSvXs6cudXIh7SUvWBfL+rEUtSjuvMhoqKn2vNCcmnN9uBLRov
        uqUNT66Kn9CNQgBQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86: Use -mindirect-branch-cs-prefix for RETPOLINE builds
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211119165630.276205624@infradead.org>
References: <20211119165630.276205624@infradead.org>
MIME-Version: 1.0
Message-ID: <163913431994.23020.11976140208986700884.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     68cf4f2a72ef8786e6b7af6fd9a89f27ac0f520d
Gitweb:        https://git.kernel.org/tip/68cf4f2a72ef8786e6b7af6fd9a89f27ac0f520d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 19 Nov 2021 17:50:25 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 08 Dec 2021 11:57:04 +01:00

x86: Use -mindirect-branch-cs-prefix for RETPOLINE builds

In order to further enable commit:

  bbe2df3f6b6d ("x86/alternative: Try inline spectre_v2=retpoline,amd")

add the new GCC flag -mindirect-branch-cs-prefix:

  https://gcc.gnu.org/g:2196a681d7810ad8b227bf983f38ba716620545e
  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=102952
  https://bugs.llvm.org/show_bug.cgi?id=52323

to RETPOLINE=y builds. This should allow fully inlining retpoline,amd
for GCC builds.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lkml.kernel.org/r/20211119165630.276205624@infradead.org
---
 arch/x86/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 2f40de5..c38b657 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -14,6 +14,7 @@ endif
 
 ifdef CONFIG_CC_IS_GCC
 RETPOLINE_CFLAGS	:= $(call cc-option,-mindirect-branch=thunk-extern -mindirect-branch-register)
+RETPOLINE_CFLAGS	+= $(call cc-option,-mindirect-branch-cs-prefix)
 RETPOLINE_VDSO_CFLAGS	:= $(call cc-option,-mindirect-branch=thunk-inline -mindirect-branch-register)
 endif
 ifdef CONFIG_CC_IS_CLANG
