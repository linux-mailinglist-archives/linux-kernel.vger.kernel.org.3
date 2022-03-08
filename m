Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AEE4D1C71
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347983AbiCHP5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348033AbiCHP4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:56:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA6C4F47D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=a8RzkWIyNVeQCr7WhMgSPa2HnZwX8Lz4UbWUw4JBOXo=; b=kDLcgh1/5K+lErR1foNH14mBkD
        L60ZNh7q+559RXjevqAEDG4JVGoDEgLqq3nTQkwntA2hS6wpyNerBmP2lR3QXsK3Tww6GQFsUpMVC
        jQ4M3h4S4Pdv+/W2Y678Q5Qqv+K6AATHM9KxIksgfqcvgMRweCFhu/EudJiJJO5AUcF87Vo2mX+tK
        iD3BPp68BO2GhDK64IgqDNr1Ffr50+cP0eZILQDQX5wYi2a4FJwIcgyrTd5xE+r3N9u5IkXRi3CEr
        BfMLjc46iCC+ydL28J6v9SN2rxzeisshxpjrsYTn9pA63BZ3ovdz20XR3sgUKaTlI3Hr5EdjFcgw4
        GWEQuhSw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRcAc-00GIv7-Hg; Tue, 08 Mar 2022 15:54:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 349FB301A96;
        Tue,  8 Mar 2022 16:54:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1D58B2B561919; Tue,  8 Mar 2022 16:54:39 +0100 (CET)
Message-ID: <20220308154318.110500806@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 08 Mar 2022 16:30:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v4 16/45] x86/ibt,crypto: Add ENDBR for the jump-table entries
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

The code does:

	## branch into array
	mov     jump_table(,%rax,8), %bufp
	JMP_NOSPEC bufp

resulting in needing to mark the jump-table entries with ENDBR.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/crypto/crc32c-pcl-intel-asm_64.S |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
+++ b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
@@ -195,6 +195,7 @@ SYM_FUNC_START(crc_pcl)
 .altmacro
 LABEL crc_ %i
 .noaltmacro
+	ENDBR
 	crc32q   -i*8(block_0), crc_init
 	crc32q   -i*8(block_1), crc1
 	crc32q   -i*8(block_2), crc2
@@ -204,6 +205,7 @@ LABEL crc_ %i
 .altmacro
 LABEL crc_ %i
 .noaltmacro
+	ENDBR
 	crc32q   -i*8(block_0), crc_init
 	crc32q   -i*8(block_1), crc1
 # SKIP  crc32  -i*8(block_2), crc2 ; Don't do this one yet
@@ -237,6 +239,7 @@ LABEL crc_ %i
 	################################################################
 
 LABEL crc_ 0
+	ENDBR
 	mov     tmp, len
 	cmp     $128*24, tmp
 	jae     full_block


