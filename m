Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FEC4D1C75
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348151AbiCHP5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348043AbiCHP4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:56:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95074F9CE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=N852q9aWEiK0I+Tjg4v4NRP8lVB+Lypx5hQ0mJxyRSo=; b=uHBky8qUbVEnD4beh5Xt3fDSbz
        1uKLADBp/b7uDGppsDtuNhXhRqfHAsNsATnLwe6al5u/lxNshzvKDi1j00hZ3m97I0pcflNg3rl7s
        uvYm2gwx20pmPMxH2pWHBOg4lwa4n0OBASwKHjM8CMLx59pjiyBLaOo7JznNBKzpCa2NgRkuJvtnO
        Qa+Kf1AQiFRhsiQV7wPDCexv7VTeILXLv2msBqrla8qXJ9GSqYSQFTV8FBjLjlMzAAaJ4givH7kqp
        GIHEieslEe0Q824y8rL18WOpzIppsZ2l02GcWplG8A7E45Sd9ult9PeXo8s4/YA4ZD1uTPw8wZQC0
        wYcWxgcw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRcAc-00GIv3-BU; Tue, 08 Mar 2022 15:54:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 33C3B30175B;
        Tue,  8 Mar 2022 16:54:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 258BB2B56191C; Tue,  8 Mar 2022 16:54:39 +0100 (CET)
Message-ID: <20220308154318.168850084@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 08 Mar 2022 16:30:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v4 17/45] x86/ibt,kvm: Add ENDBR to fastops
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


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kvm/emulate.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -189,7 +189,7 @@
 #define X16(x...) X8(x), X8(x)
 
 #define NR_FASTOP (ilog2(sizeof(ulong)) + 1)
-#define FASTOP_SIZE 8
+#define FASTOP_SIZE (8 * (1 + HAS_KERNEL_IBT))
 
 struct opcode {
 	u64 flags;
@@ -311,7 +311,8 @@ static int fastop(struct x86_emulate_ctx
 #define __FOP_FUNC(name) \
 	".align " __stringify(FASTOP_SIZE) " \n\t" \
 	".type " name ", @function \n\t" \
-	name ":\n\t"
+	name ":\n\t" \
+	ASM_ENDBR
 
 #define FOP_FUNC(name) \
 	__FOP_FUNC(#name)
@@ -433,6 +434,7 @@ static int fastop(struct x86_emulate_ctx
 	".align 4 \n\t" \
 	".type " #op ", @function \n\t" \
 	#op ": \n\t" \
+	ASM_ENDBR \
 	#op " %al \n\t" \
 	__FOP_RET(#op)
 


