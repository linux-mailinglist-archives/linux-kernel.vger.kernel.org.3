Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB3B46FF66
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 12:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240400AbhLJLJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 06:09:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45792 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240295AbhLJLI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 06:08:58 -0500
Date:   Fri, 10 Dec 2021 11:05:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639134321;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DVlDFOW24XJ6bkcLC8DsFpdLwlCu4BLQ4fnuUqgDOnU=;
        b=3YpzOPoRMf3ItRPvn3fqveDyYjhLgEjlPl/eqR4BHFyEtJNwyhnobRhQkpvbmDg2xEkUgE
        XJFOpdGQ/0ca9qZrKq56cKSdbMtCPpTvxQWkmPx/kg6iCYGe62QHojls4f4cIAnTzj4ggg
        nSlQVnvi7lQ4EJpIMdCxQFmVmEcB9Ko/YXIFoEBgZ6IMKzLTd4s0WWOTfbT3/GE1r54s7M
        FC3PieTizr5Ptw7e1r6v9s57fImNh1rwZOvLTJyyjmespdvLIHPZHVDW+vGP3VP+pJYq54
        nyuoQWUi5ndlflDJMcdxuCiFvvIJw3SCoCYoUvOEKDLpXHul3Rbh2yDKVJuPhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639134321;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DVlDFOW24XJ6bkcLC8DsFpdLwlCu4BLQ4fnuUqgDOnU=;
        b=QoZTREpX4Mce0erLhOmB2ZtyzBA4qbnfPGjBjUvo/t6cq9hPbF6Rz3QCayT0Q7FSq3a9v7
        zc1KKdrFQnmZrTAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86: Move RETPOLINE*_CFLAGS to arch Makefile
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211119165630.219152765@infradead.org>
References: <20211119165630.219152765@infradead.org>
MIME-Version: 1.0
Message-ID: <163913432083.23020.8355879993745940811.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     b2f825bfeda884f9d40386cc7d089d023017d2dd
Gitweb:        https://git.kernel.org/tip/b2f825bfeda884f9d40386cc7d089d023017d2dd
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 19 Nov 2021 17:50:24 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 08 Dec 2021 11:39:42 +01:00

x86: Move RETPOLINE*_CFLAGS to arch Makefile

Currently, RETPOLINE*_CFLAGS are defined in the top-level Makefile
but only x86 makes use of them. Move them there. If ever another
architecture finds the need, it can be reconsidered.

  [ bp: Massage a bit. ]

Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lkml.kernel.org/r/20211119165630.219152765@infradead.org
---
 Makefile          | 11 -----------
 arch/x86/Makefile | 11 +++++++++++
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index 8e35d78..b9ee63d 100644
--- a/Makefile
+++ b/Makefile
@@ -688,17 +688,6 @@ ifdef CONFIG_FUNCTION_TRACER
   CC_FLAGS_FTRACE := -pg
 endif
 
-ifdef CONFIG_CC_IS_GCC
-RETPOLINE_CFLAGS	:= $(call cc-option,-mindirect-branch=thunk-extern -mindirect-branch-register)
-RETPOLINE_VDSO_CFLAGS	:= $(call cc-option,-mindirect-branch=thunk-inline -mindirect-branch-register)
-endif
-ifdef CONFIG_CC_IS_CLANG
-RETPOLINE_CFLAGS	:= -mretpoline-external-thunk
-RETPOLINE_VDSO_CFLAGS	:= -mretpoline
-endif
-export RETPOLINE_CFLAGS
-export RETPOLINE_VDSO_CFLAGS
-
 include $(srctree)/arch/$(SRCARCH)/Makefile
 
 ifdef need-config
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 4224386..2f40de5 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -12,6 +12,17 @@ else
         KBUILD_DEFCONFIG := $(ARCH)_defconfig
 endif
 
+ifdef CONFIG_CC_IS_GCC
+RETPOLINE_CFLAGS	:= $(call cc-option,-mindirect-branch=thunk-extern -mindirect-branch-register)
+RETPOLINE_VDSO_CFLAGS	:= $(call cc-option,-mindirect-branch=thunk-inline -mindirect-branch-register)
+endif
+ifdef CONFIG_CC_IS_CLANG
+RETPOLINE_CFLAGS	:= -mretpoline-external-thunk
+RETPOLINE_VDSO_CFLAGS	:= -mretpoline
+endif
+export RETPOLINE_CFLAGS
+export RETPOLINE_VDSO_CFLAGS
+
 # For gcc stack alignment is specified with -mpreferred-stack-boundary,
 # clang has the option -mstack-alignment for that purpose.
 ifneq ($(call cc-option, -mpreferred-stack-boundary=4),)
