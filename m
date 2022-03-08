Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3B74D1C97
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348721AbiCHP62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240553AbiCHP4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:56:09 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FEB4F9C6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=fh+AeJ8aNhji6VlzhvpE46DroTHAIn4XV7uW4+efjvc=; b=Pski3LI+g8vM6rv2WhgZTSo3vC
        bNqYRKp2cDlNhdFeQUItvTWUGnF0mWDEBLi8dN5r/S3wQOH54H2nswT2Vj1WJPAdGyZu3ERRMxJ1t
        RhswcTXiz74kpLryJkqa5TIhCQ/JD02SeYBPnmWcfAzabdrF4On/yq++7iliROy7Dr7xOisEGcoRG
        sxxjgj+K+aZYaZXGDDrmt34NiLQTlqdw0EklqJrB0/lt15Efh7efo9gazadlOZZbw5h0VsfTtUJiB
        8OkLE02LBAdoFua/T0DbRDdLWhCzT2LKJH8iS2lLZ8RDWXEWl1Rhinutjgixzb4Fe1owml04XcjFD
        sD8O6zFg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRcAb-00GUiK-G1; Tue, 08 Mar 2022 15:54:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E459D3007C3;
        Tue,  8 Mar 2022 16:54:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C32D42B55FFBB; Tue,  8 Mar 2022 16:54:38 +0100 (CET)
Message-ID: <20220308154317.402118218@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 08 Mar 2022 16:30:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v4 04/45] objtool,efi: Update __efi64_thunk annotation
References: <20220308153011.021123062@infradead.org>
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

The current annotation relies on not running objtool on the file; this
won't work when running objtool on vmlinux.o. Instead explicitly mark
__efi64_thunk() to be ignored.

This preserves the status quo, which is somewhat unfortunate. Luckily
this code is hardly ever used.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/platform/efi/Makefile       |    1 -
 arch/x86/platform/efi/efi_thunk_64.S |    6 ++++--
 2 files changed, 4 insertions(+), 3 deletions(-)

--- a/arch/x86/platform/efi/Makefile
+++ b/arch/x86/platform/efi/Makefile
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-OBJECT_FILES_NON_STANDARD_efi_thunk_$(BITS).o := y
 KASAN_SANITIZE := n
 GCOV_PROFILE := n
 
--- a/arch/x86/platform/efi/efi_thunk_64.S
+++ b/arch/x86/platform/efi/efi_thunk_64.S
@@ -20,12 +20,14 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/objtool.h>
 #include <asm/page_types.h>
 #include <asm/segment.h>
 
 	.text
 	.code64
-SYM_CODE_START(__efi64_thunk)
+SYM_FUNC_START(__efi64_thunk)
+STACK_FRAME_NON_STANDARD __efi64_thunk
 	push	%rbp
 	push	%rbx
 
@@ -79,7 +81,7 @@ SYM_CODE_START(__efi64_thunk)
 2:	pushl	$__KERNEL_CS
 	pushl	%ebp
 	lret
-SYM_CODE_END(__efi64_thunk)
+SYM_FUNC_END(__efi64_thunk)
 
 	.bss
 	.balign 8


