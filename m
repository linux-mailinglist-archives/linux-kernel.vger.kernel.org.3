Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4C2534DC9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347133AbiEZLDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 07:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347107AbiEZLDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:03:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F8ACEB9E
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=hrWj1TQzRXXNfBbwlPL8fBv3Cv5xKmT4kRjYFjpA0b8=; b=LPhC0XIJeHPEL3lzMrp71EjaRT
        RHi6MwUpTtIu0qZ31jnbU0JSDb9onf1s8LW5s+2l9mtA45ongpIt6MsVvs2gOTiJRzkbqkBC7r6i0
        0aKqo+PiNl2gN1noyDODwhG8P5mtyWgW/orvwUHZD47dVEinEPbzs0TgYPJwzna5VMprvEMLrqCXo
        SgiS201R+1NAyluMckoCOq4PCcVbaj2pwbPf1qPPSPD1M9m5OES/1HMZn0rMENq5y8uscFrFLveA7
        kyULDQSSIyUtfSYG3oTOsTskNosMPNpSnbWoJG7vDB3cal5t0K0IeLVH2uDJDxSFZjwXyic3rlwIr
        eIu9Xwlw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuBGX-001Bjx-Nq; Thu, 26 May 2022 11:02:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8FC1F3002AF;
        Thu, 26 May 2022 13:02:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 856332021C964; Thu, 26 May 2022 13:02:50 +0200 (CEST)
Message-ID: <20220526105958.134113388@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 26 May 2022 12:52:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        elver@google.com, jbaron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org, mark.rutland@arm.com
Subject: [PATCH 7/7] context_tracking: Always inline empty stubs
References: <20220526105252.440440893@infradead.org>
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

Because GCC is seriously challenged..

vmlinux.o: warning: objtool: enter_from_user_mode+0x85: call to context_tracking_enabled() leaves .noinstr.text section
vmlinux.o: warning: objtool: syscall_enter_from_user_mode+0x8f: call to context_tracking_enabled() leaves .noinstr.text section
vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0x85: call to context_tracking_enabled() leaves .noinstr.text section
vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0x85: call to context_tracking_enabled() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/context_tracking_state.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -46,10 +46,10 @@ static __always_inline bool context_trac
 	return __this_cpu_read(context_tracking.state) == CONTEXT_USER;
 }
 #else
-static inline bool context_tracking_in_user(void) { return false; }
-static inline bool context_tracking_enabled(void) { return false; }
-static inline bool context_tracking_enabled_cpu(int cpu) { return false; }
-static inline bool context_tracking_enabled_this_cpu(void) { return false; }
+static __always_inline bool context_tracking_in_user(void) { return false; }
+static __always_inline bool context_tracking_enabled(void) { return false; }
+static __always_inline bool context_tracking_enabled_cpu(int cpu) { return false; }
+static __always_inline bool context_tracking_enabled_this_cpu(void) { return false; }
 #endif /* CONFIG_CONTEXT_TRACKING */
 
 #endif


