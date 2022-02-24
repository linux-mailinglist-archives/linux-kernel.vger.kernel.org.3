Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2804C2F6A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236184AbiBXPVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236032AbiBXPSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:18:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD93148651
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=oyLIYavJ4bwy8nJAkQU3ztKN+wCuquz2h5oq2xl/NaA=; b=TjmmGizu3ea4axSFy8QZqs9qZ+
        4zLHHuaq+VK8EOnP4HSxRZHeHLgjkRKlniVHhixFnxrERnYFjjukYuWkq/5lJpepfhCz98QxAMKwo
        v44Ib0eZdPxFbgHkdY2dfkGu1xDf6KbOcPgtklawpWdA3fZfseP3Pcyul5dlNjOo/1RcVTm5XYAGA
        7gDyVcF9FqpOFKXcQkzd0tLGgBtEXzYyq1Zx+62EDDnwzPhpibn9TOVgm1noAi6q0cTF6qQUWKIT3
        nwSvDutXmilSU0FUieKC3oKSj/t9eMEUBCc3037dleN7jtqKskKqphepUPzddOGaExAuQ+ufwzFWX
        p8wHBYzg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNFs3-004s28-Qd; Thu, 24 Feb 2022 15:17:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3F9DA30218C;
        Thu, 24 Feb 2022 16:17:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6EC8B2B35478F; Thu, 24 Feb 2022 16:17:28 +0100 (CET)
Message-ID: <20220224151323.189353523@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Feb 2022 15:51:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v2 20/39] x86/bugs: Disable Retpoline when IBT
References: <20220224145138.952963315@infradead.org>
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

Retpoline and IBT are mutually exclusive. IBT relies on indirect
branches (JMP/CALL *%reg) while retpoline avoids them by design.

Demote to LFENCE on IBT enabled hardware.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/cpu/bugs.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -937,6 +937,11 @@ static void __init spectre_v2_select_mit
 	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
 	retpoline_amd:
 		if (!boot_cpu_has(X86_FEATURE_LFENCE_RDTSC)) {
+			if (HAS_KERNEL_IBT &&
+			    boot_cpu_has(X86_FEATURE_IBT)) {
+				pr_err("Spectre mitigation: LFENCE not serializing, generic retpoline not available due to IBT, switching to none\n");
+				return;
+			}
 			pr_err("Spectre mitigation: LFENCE not serializing, switching to generic retpoline\n");
 			goto retpoline_generic;
 		}
@@ -945,6 +950,26 @@ static void __init spectre_v2_select_mit
 		setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
 	} else {
 	retpoline_generic:
+		/*
+		 *  Full retpoline is incompatible with IBT, demote to LFENCE.
+		 */
+		if (HAS_KERNEL_IBT &&
+		    boot_cpu_has(X86_FEATURE_IBT)) {
+			switch (cmd) {
+			case SPECTRE_V2_CMD_FORCE:
+			case SPECTRE_V2_CMD_AUTO:
+			case SPECTRE_V2_CMD_RETPOLINE:
+				/* silent for auto select */
+				break;
+
+			default:
+				/* warn when 'demoting' an explicit selection */
+				pr_warn("Spectre mitigation: Switching to LFENCE due to IBT\n");
+				break;
+			}
+
+			goto retpoline_amd;
+		}
 		mode = SPECTRE_V2_RETPOLINE_GENERIC;
 		setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
 	}


