Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A8E4DE2B6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 21:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240756AbiCRUp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 16:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235570AbiCRUp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 16:45:56 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4492ECFA6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 13:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=UtzMoHP3J3LWC+I942orkIBrjIM8G1XilIuT4M51tHE=; b=VWkUu2+DK1y8BJ9eySEeG0io17
        TbXxfVTWttvwFdCbZ7nzuVr4NBGdFmOL80Z2U5eKjUo3F7PDt3TAPVF+2l9EoGcRMKT5pleQr6BxR
        8HOZC/MPnSYTn3EKfojA22jZX9DH1k0117Ie/DO7nl10wo2LgAPxjy6O0+qWJgdjoftNDwi6wtzMQ
        CdX39/BJFn6H+Z1se3AHVIwMkiD3Q+arUz8xNI4wTsNAq+uK0nh6ki4eZPVDSl+BlbtF3eL86/e7w
        SjBFzlSRx0dxE1ZTFrOn+0y8LsWc9YTHg+Lq5953Brjazo0NrhcYql8rgrZVKUM7hopyB5Knb2xj2
        oKczCTsA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nVJSP-002IYH-Py; Fri, 18 Mar 2022 20:44:21 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 646DB98623C; Fri, 18 Mar 2022 21:44:19 +0100 (CET)
Date:   Fri, 18 Mar 2022 21:44:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Andrew.Cooper3@citrix.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>, seanjc@google.com
Subject: [RFC][PATCH] x86,static_call: Fix __static_call_return0 for i386
Message-ID: <20220318204419.GT8939@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Paolo reported that the instruction sequence that is used to replace:

    call __static_call_return0

namely:

    66 66 48 31 c0	data16 data16 xor %rax,%rax

decodes to something else on i386, namely:

    66 66 48		data16 dec %ax
    31 c0		xor    %eax,%eax

Which is a nonsensical sequence that happens to have the same outcome.
*However* an important distinction is that it consists of 2
instructions which is a problem when it needs to be overwriten with a
regular call instruction again.

As such, replace the instruction with something that is a 5 byte single
instruction and decodes the same on both i386 and x86_64.

Fixes: 3f2a8fc4b15d ("static_call/x86: Add __static_call_return0()")
Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/static_call.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -12,10 +12,9 @@ enum insn_type {
 };
 
 /*
- * data16 data16 xorq %rax, %rax - a single 5 byte instruction that clears %rax
- * The REX.W cancels the effect of any data16.
+ * cs cs cs xorl %eax, %eax - a single 5 byte instruction that clears %[er]ax
  */
-static const u8 xor5rax[] = { 0x66, 0x66, 0x48, 0x31, 0xc0 };
+static const u8 xor5rax[] = { 0x2e, 0x2e, 0x2e, 0x31, 0xc0 };
 
 static const u8 retinsn[] = { RET_INSN_OPCODE, 0xcc, 0xcc, 0xcc, 0xcc };
 
