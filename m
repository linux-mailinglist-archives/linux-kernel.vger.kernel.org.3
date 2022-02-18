Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DB04BBE31
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237109AbiBRRQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:16:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238226AbiBRRPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:15:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADCF4D9D8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=PjvfK7saKiLg8/19lPI9jQLr5DFWC3c0Wg3QbfhTaEg=; b=JEGIRF+hfZ2dfqhZxy2GaHe7IJ
        GlF/x6JlrSg0IoDLFCmNMgUK2opOOpi9crNOiJMop0eUn0q1Uw0I4OimNTw6Pbu6vJwSX7I69eZqw
        iqNfvksnZb/6fk6ghiMBvY0Ux7++5TJWr6/lxPLaDsA8n8I+UTefFMiQhJ106tp8g4yB98OUtBwy+
        sZPZ3rqO2q49Z4D5wDk9w+R6yK9fudPT8j+LfDy0I4Voex5hBqiW95wZ/vybtIdo6mZ+JMt/mY77L
        9Lk0KoRkqdKqad0wtfy4pcvXJigOMkLrtP96PakvwL3hp5Ih21SGouZYXWEBUC2OlEgLhGnMM5nx9
        ii89h8rQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nL6q9-00Gl8T-63; Fri, 18 Feb 2022 17:14:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 473B930076F;
        Fri, 18 Feb 2022 18:14:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0E72F203C1CAC; Fri, 18 Feb 2022 18:14:39 +0100 (CET)
Message-ID: <20220218171408.808810436@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 18 Feb 2022 17:49:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 04/29] x86/livepatch: Validate __fentry__ location
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

Currently livepatch assumes __fentry__ lives at func+0, which is most
likely untrue with IBT on. Override the weak klp_get_ftrace_location()
function with an arch specific version that's IBT aware.

Also make the weak fallback verify the location is an actual ftrace
location as a sanity check.

Suggested-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/livepatch.h |    9 +++++++++
 kernel/livepatch/patch.c         |    2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/livepatch.h
+++ b/arch/x86/include/asm/livepatch.h
@@ -17,4 +17,13 @@ static inline void klp_arch_set_pc(struc
 	ftrace_instruction_pointer_set(fregs, ip);
 }
 
+#define klp_get_ftrace_location klp_get_ftrace_location
+static inline unsigned long klp_get_ftrace_location(unsigned long faddr)
+{
+	unsigned long addr = ftrace_location(faddr);
+	if (!addr && IS_ENABLED(CONFIG_X86_IBT))
+		addr = ftrace_location(faddr + 4);
+	return addr;
+}
+
 #endif /* _ASM_X86_LIVEPATCH_H */
--- a/kernel/livepatch/patch.c
+++ b/kernel/livepatch/patch.c
@@ -133,7 +133,7 @@ static void notrace klp_ftrace_handler(u
 #ifndef klp_get_ftrace_location
 static unsigned long klp_get_ftrace_location(unsigned long faddr)
 {
-	return faddr;
+	return ftrace_location(faddr);
 }
 #endif
 


