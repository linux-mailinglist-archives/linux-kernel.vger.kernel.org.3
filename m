Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE734BBE1E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238269AbiBRRPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:15:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238206AbiBRRPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:15:15 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB30E4C78C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=1StuCFD7IMuaC46LcT3bBt2dSUahkx7GWhFzvO6cAkU=; b=JvvmVBx87dt6L0z1Y5sisgnqYf
        WwVHXjCqK0QWSDl8jh6wgDGAWghhL844ye2omJQxZqsom105UWusesqAHhgHR59t/cdwvn3cxPTIR
        ysNup5LwIVchnXLDLoSiG+IXodjt6qTLFBi4OPJ+UZxQReh4JNOXCpVcxBpgaJlIQ1RrXwO62ieW9
        IiWzuy32eD9n/krvYGKBReYsAUtDMJlydpev5RShupwiEOKj0KQa0CF8FhGbAc7tu97avhp9gFwTj
        qUrCx5Uh7H4CSG8m/W8MMOAgazPD7r/qRhBP1TqV+mapPJwd9hV8NIZx50HaOQUCjXo67DXOQVUgN
        aAJfZytA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nL6qA-00AsBd-GK; Fri, 18 Feb 2022 17:14:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C82BB3011C0;
        Fri, 18 Feb 2022 18:14:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 38EF320965465; Fri, 18 Feb 2022 18:14:39 +0100 (CET)
Message-ID: <20220218171409.336519740@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 18 Feb 2022 17:49:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: [PATCH 13/29] x86/ibt,ftrace: Add ENDBR to samples/ftrace
References: <20220218164902.008644515@infradead.org>
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


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 samples/ftrace/ftrace-direct-modify.c       |    5 +++++
 samples/ftrace/ftrace-direct-multi-modify.c |   10 +++++++---
 samples/ftrace/ftrace-direct-multi.c        |    5 ++++-
 samples/ftrace/ftrace-direct-too.c          |    3 +++
 samples/ftrace/ftrace-direct.c              |    3 +++
 5 files changed, 22 insertions(+), 4 deletions(-)

--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -24,20 +24,25 @@ static unsigned long my_ip = (unsigned l
 
 #ifdef CONFIG_X86_64
 
+#include <asm/ibt.h>
+
 asm (
 "	.pushsection    .text, \"ax\", @progbits\n"
 "	.type		my_tramp1, @function\n"
 "	.globl		my_tramp1\n"
 "   my_tramp1:"
+	ASM_ENDBR
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
 "	call my_direct_func1\n"
 "	leave\n"
 "	.size		my_tramp1, .-my_tramp1\n"
 	ASM_RET
+
 "	.type		my_tramp2, @function\n"
 "	.globl		my_tramp2\n"
 "   my_tramp2:"
+	ASM_ENDBR
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
 "	call my_direct_func2\n"
--- a/samples/ftrace/ftrace-direct-multi-modify.c
+++ b/samples/ftrace/ftrace-direct-multi-modify.c
@@ -22,11 +22,14 @@ extern void my_tramp2(void *);
 
 #ifdef CONFIG_X86_64
 
+#include <asm/ibt.h>
+
 asm (
 "	.pushsection    .text, \"ax\", @progbits\n"
 "	.type		my_tramp1, @function\n"
 "	.globl		my_tramp1\n"
 "   my_tramp1:"
+	ASM_ENDBR
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
 "	pushq %rdi\n"
@@ -34,12 +37,13 @@ asm (
 "	call my_direct_func1\n"
 "	popq %rdi\n"
 "	leave\n"
-"	ret\n"
+	ASM_RET
 "	.size		my_tramp1, .-my_tramp1\n"
+
 "	.type		my_tramp2, @function\n"
-"\n"
 "	.globl		my_tramp2\n"
 "   my_tramp2:"
+	ASM_ENDBR
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
 "	pushq %rdi\n"
@@ -47,7 +51,7 @@ asm (
 "	call my_direct_func2\n"
 "	popq %rdi\n"
 "	leave\n"
-"	ret\n"
+	ASM_RET
 "	.size		my_tramp2, .-my_tramp2\n"
 "	.popsection\n"
 );
--- a/samples/ftrace/ftrace-direct-multi.c
+++ b/samples/ftrace/ftrace-direct-multi.c
@@ -17,11 +17,14 @@ extern void my_tramp(void *);
 
 #ifdef CONFIG_X86_64
 
+#include <asm/ibt.h>
+
 asm (
 "	.pushsection    .text, \"ax\", @progbits\n"
 "	.type		my_tramp, @function\n"
 "	.globl		my_tramp\n"
 "   my_tramp:"
+	ASM_ENDBR
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
 "	pushq %rdi\n"
@@ -29,7 +32,7 @@ asm (
 "	call my_direct_func\n"
 "	popq %rdi\n"
 "	leave\n"
-"	ret\n"
+	ASM_RET
 "	.size		my_tramp, .-my_tramp\n"
 "	.popsection\n"
 );
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -19,11 +19,14 @@ extern void my_tramp(void *);
 
 #ifdef CONFIG_X86_64
 
+#include <asm/ibt.h>
+
 asm (
 "	.pushsection    .text, \"ax\", @progbits\n"
 "	.type		my_tramp, @function\n"
 "	.globl		my_tramp\n"
 "   my_tramp:"
+	ASM_ENDBR
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
 "	pushq %rdi\n"
--- a/samples/ftrace/ftrace-direct.c
+++ b/samples/ftrace/ftrace-direct.c
@@ -16,11 +16,14 @@ extern void my_tramp(void *);
 
 #ifdef CONFIG_X86_64
 
+#include <asm/ibt.h>
+
 asm (
 "	.pushsection    .text, \"ax\", @progbits\n"
 "	.type		my_tramp, @function\n"
 "	.globl		my_tramp\n"
 "   my_tramp:"
+	ASM_ENDBR
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
 "	pushq %rdi\n"


