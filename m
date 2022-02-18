Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9114BBE17
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238400AbiBRRPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:15:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238190AbiBRRPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:15:15 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1539A4C793
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=onqvYxLl0XY4n04MOOUigHRSjr5zZTaftQ2bK0tfXWo=; b=nfpEFhgaagoQc7eM/PwxfiIlvo
        7TZPe4qs+ubrAZzX9/UsQV2poAzh1LclctmVjCcsyGe2G7ax6C/sauOY/YcDpr6SnrRkTkx9Fs4wD
        oDkRdyuRWnnyuOB0DVCy8dbxJ7IzaldMQuDciZqDSC+/GGJ6Xl4enSkp9Kpjb8+GvWFXwzG3pY3YS
        eIew+2HemlP43ryDALjO83lZPIDcPoqwoMewYTlo2xMwd4DwPQuV+xoswWHANr5OBFGjf3CmQLEz9
        9yhUeTYUVcSu7mdLSB4RDHhb4mCIgP5qPJZd/y+hJzsXkxik94IG11SZFglONJim22leiohpYeE8j
        cG66DOdg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nL6q9-00AsBR-Od; Fri, 18 Feb 2022 17:14:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B7AD7300C1D;
        Fri, 18 Feb 2022 18:14:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 16CDB200C0A23; Fri, 18 Feb 2022 18:14:39 +0100 (CET)
Message-ID: <20220218171408.925598025@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 18 Feb 2022 17:49:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: [PATCH 06/29] x86/ibt: Add ANNOTATE_NOENDBR
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

In order to have objtool warn about code references to !ENDBR
instruction, we need an annotation to allow this for non-coontrol-flow
instances -- consider text range checks, text patching, or return
trampolines etc.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/linkage.h      |   11 +++++++++++
 include/linux/instruction_pointer.h |    5 +++++
 include/linux/objtool.h             |   13 +++++++++++++
 3 files changed, 29 insertions(+)

--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -78,6 +78,12 @@ struct unwind_hint {
 #define STACK_FRAME_NON_STANDARD_FP(func)
 #endif
 
+#define ANNOTATE_NOENDBR					\
+	"986: \n\t"						\
+	".pushsection .discard.noendbr\n\t"			\
+	_ASM_PTR " 986b\n\t"					\
+	".popsection\n\t"
+
 #else /* __ASSEMBLY__ */
 
 /*
@@ -130,6 +136,13 @@ struct unwind_hint {
 	.popsection
 .endm
 
+.macro ANNOTATE_NOENDBR
+.Lhere_\@:
+	.pushsection .discard.noendbr
+	.quad	.Lhere_\@
+	.popsection
+.endm
+
 #endif /* __ASSEMBLY__ */
 
 #else /* !CONFIG_STACK_VALIDATION */


