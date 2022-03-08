Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6FF4D1CA0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348948AbiCHP67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348075AbiCHP4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:56:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7194D266
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=cWrUD1KaL9aYwAdkiMBL/v8TI8q3NHQ2xjsiReq0bIM=; b=nl2gaTAEgkLcBC7k8+pPIudFkM
        8ADeg7c/nGUOzU0U0E5Vvo0yOJR1gGnR7FsoBvWSdTPSZv518tj/2WyTQty6kBMZPi2BdCJx5htCt
        IoSX63U0sfLQREe/IZLyl0enF/ajHXliRukKip+60ywuJEY9poI9/aDaQKfZ8RFIGaJVYMw/D8Nx+
        vA4tSbTM0akSgtQcPyLdx5LoW8R3oRovN1oZ/PxKii1bYxJIg5ugw1drNua1st9dBXscIleFPhxjl
        +gzLGeiDF9Db1wsvj1oW4f0WYfLmvRg1Gg2c85YcWAbITsT+BI8YXbZ2p4SyYt5CWUdAa6CIENqkZ
        Y7dP5cOQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRcAc-00GIvH-R9; Tue, 08 Mar 2022 15:54:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 476D6302DC3;
        Tue,  8 Mar 2022 16:54:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A02C02B5649C3; Tue,  8 Mar 2022 16:54:39 +0100 (CET)
Message-ID: <20220308154319.054842742@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 08 Mar 2022 16:30:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v4 32/45] x86/ibt: Dont generate ENDBR in .discard.text
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

Having ENDBR in discarded sections can easily lead to relocations into
discarded sections which the linkers aren't really fond of. Objtool
also shouldn't generate them, but why tempt fate.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/setup.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -8,6 +8,7 @@
 
 #include <linux/linkage.h>
 #include <asm/page_types.h>
+#include <asm/ibt.h>
 
 #ifdef __i386__
 
@@ -119,7 +120,7 @@ void *extend_brk(size_t size, size_t ali
  * executable.)
  */
 #define RESERVE_BRK(name,sz)						\
-	static void __section(".discard.text") __used notrace		\
+	static void __section(".discard.text") __noendbr __used notrace	\
 	__brk_reservation_fn_##name##__(void) {				\
 		asm volatile (						\
 			".pushsection .brk_reservation,\"aw\",@nobits;" \


