Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B624F841B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345198AbiDGPy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiDGPy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:54:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3DAB27
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 08:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0vI6/4V5OCKDnf4uxGz/NqAP0SaWI42PZAcJfNZ2m/w=; b=AXYY4nYpb7UPHt3pC+1MlqGGx1
        z1WO/W9rN4nhM9p+GCFWd4G0gSjAsWhUg/Skbc/Z5/WVRVUACtlURwJQWKVXnUiZgCkf7IC80b5DX
        qfiKbVx6fcVMIrbyNJrnne09y+VXkFsqdm7Phcn4zD4sQ20IskDOsd93QgydhSdplBOyAEodvqkIQ
        JpW+kKGrqFCAotUSPf3JR2hAd9wxZs1W2/2/WCry3pZX293j6tme9jXW5IVQefkMXbhGCVio3vVrZ
        beTIf8xVFNQSidubN12G/LSgHL8USLJjKgbKZsCvSOii3WZbVe3sBkpiGX/84/EHq69KZQlGRHP5m
        RnjtCVFw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncUPc-008yem-Hf; Thu, 07 Apr 2022 15:51:08 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4BAC49862CF; Thu,  7 Apr 2022 17:51:06 +0200 (CEST)
Date:   Thu, 7 Apr 2022 17:51:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Poimboe, Josh" <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: IBT related objtool warnings
Message-ID: <20220407155106.GL2731@worktop.programming.kicks-ass.net>
References: <314eeced310b07b50b500384741378e59168c36c.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <314eeced310b07b50b500384741378e59168c36c.camel@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 10:43:33PM +0000, Edgecombe, Rick P wrote:
> Hi,
> 
> After commit:
> ed53a0d97192 x86/alternative: Use .ibt_endbr_seal to seal indirect calls
> 
> I am getting objtool "unreachable instruction" warnings.
> 
> On one system with gcc 8.4.0:
> vmlinux.o: warning: objtool: start_secondary()+0x10e: unreachable
> instruction
> 
> On another with gcc 11.2.1:
> vmlinux.o: warning: objtool: pvh_start_xen()+0x0: unreachable
> instruction
> 
> Let me know if any tests on my end would help.

This seems to make it go on gcc-11.2 tip/x86/urgent..

---

 arch/x86/entry/entry_64.S    | 3 +++
 arch/x86/platform/pvh/head.S | 1 +
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 4faac48ebec5..73d958522b6a 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -337,6 +337,9 @@ SYM_CODE_END(ret_from_fork)
 
 	call	\cfunc
 
+	/* For some configurations \cfunc ends up being a noreturn. */
+	REACHABLE
+
 	jmp	error_return
 .endm
 
diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index 72c1e42d121d..7fe564eaf228 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -50,6 +50,7 @@
 #define PVH_DS_SEL		(PVH_GDT_ENTRY_DS * 8)
 
 SYM_CODE_START_LOCAL(pvh_start_xen)
+	UNWIND_HINT_EMPTY
 	cld
 
 	lgdt (_pa(gdt))
