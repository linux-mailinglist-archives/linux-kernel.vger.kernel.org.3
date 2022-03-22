Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBF14E3DD5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 12:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbiCVLxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 07:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234395AbiCVLxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 07:53:36 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7CC80230;
        Tue, 22 Mar 2022 04:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=yptc+lwfn3yV+Iw/l++6AeaRb8JVPDYG77qiQiKsN6s=; b=EexgfMSICmkEEqbZj0QX9U50Su
        8wGqNXIJnnYP1bOI6JNql8Y+z74eHAMEzcLLCvs/DqDbfJNNFEmGd+5FpLWJ5b3JMLEo/EZ/tEFst
        Z1s1fz3GoTdCc7MI1rKpzrzElgrmpXyKr5T64eiAfByjpuJ5XCihXaaTntUCAKn0PYYH4GoZHDfUG
        NkXESkGb4o6Ybo7fHQsKScNtWfVEYbsjeRxuI0UIHQVi2dJvYh6YvehEDTpiokZRcLqZwn56nPK2K
        wwgblxiYdRvnfNfkMyeR8HWk8QomABZxjTvYtPq+L/CzJfFGYs1Qa4XdNAba/clCCVcNlraRHz2jy
        xK1M9o8A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWd3I-003S9o-P3; Tue, 22 Mar 2022 11:51:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3E70F3002E5;
        Tue, 22 Mar 2022 12:51:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A4FBA2C9189FB; Tue, 22 Mar 2022 12:51:50 +0100 (CET)
Message-ID: <20220322115125.737671717@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 22 Mar 2022 12:48:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux-crypto@vger.kernel.org, ebiggers@google.com,
        herbert@gondor.apana.org.au, Jason@zx2c4.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 1/2] x86/chacha20: Avoid spurious jumps to other functions
References: <20220322114809.381992456@infradead.org>
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

The chacha_Nblock_xor_avx512vl() functions all have their own,
identical, .LdoneN label, however in one particular spot {2,4} jump to
the 8 version instead of their own. Resulting in:

  arch/x86/crypto/chacha-x86_64.o: warning: objtool: chacha_2block_xor_avx512vl() falls through to next function chacha_8block_xor_avx512vl()
  arch/x86/crypto/chacha-x86_64.o: warning: objtool: chacha_4block_xor_avx512vl() falls through to next function chacha_8block_xor_avx512vl()

Make each function consistently use its own done label.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/crypto/chacha-avx512vl-x86_64.S |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/crypto/chacha-avx512vl-x86_64.S
+++ b/arch/x86/crypto/chacha-avx512vl-x86_64.S
@@ -172,7 +172,7 @@ SYM_FUNC_START(chacha_2block_xor_avx512v
 	# xor remaining bytes from partial register into output
 	mov		%rcx,%rax
 	and		$0xf,%rcx
-	jz		.Ldone8
+	jz		.Ldone2
 	mov		%rax,%r9
 	and		$~0xf,%r9
 
@@ -438,7 +438,7 @@ SYM_FUNC_START(chacha_4block_xor_avx512v
 	# xor remaining bytes from partial register into output
 	mov		%rcx,%rax
 	and		$0xf,%rcx
-	jz		.Ldone8
+	jz		.Ldone4
 	mov		%rax,%r9
 	and		$~0xf,%r9
 


