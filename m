Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF0E4D1C9C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348885AbiCHP6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348078AbiCHP4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:56:10 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4934F9E9
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=uyHdePDjSapXbs4or0osFrGLfSsyERtOG75XX/vWKF0=; b=muQwVwQtmhZcgPK5rZ7wLUWz4h
        oLSkKF5T/6VgmS9FVLoKY7CWlQgrZ/dcc0AK8Z2gjyzYHPx2uEIcEOkUSaVNsgSG8m3lGNFA7Iz4t
        nVKAp6zgoG4VNZL2Ee0D8kRyO0voVuG2LQfsxr/ViwFaI6MgsYK8WWxtwiVERTk413M6ECMiw22eD
        2TxTRNs0vwB6EzegJhvhgKw+YLqGmckaSKHX23QXO6vZtQ2XuMQgktYPC73evpy9mTWz46ZfSNTW/
        LVwGYaImF/XRdth3yi4Wmt9aqV4XT+NT5NPI0oDl3YWPREWc9cgt48AXU55Rbj11awmGVdNTf2w0m
        ii7D+KJg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRcAc-00GUih-WC; Tue, 08 Mar 2022 15:54:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4D30E302DD4;
        Tue,  8 Mar 2022 16:54:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C35522B5649D0; Tue,  8 Mar 2022 16:54:39 +0100 (CET)
Message-ID: <20220308154319.290905453@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 08 Mar 2022 16:30:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v4 36/45] x86: Mark stop_this_cpu() __noreturn
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

vmlinux.o: warning: objtool: smp_stop_nmi_callback()+0x2b: unreachable instruction

0000 0000000000047cf0 <smp_stop_nmi_callback>:
...
0026    47d16:  e8 00 00 00 00          call   47d1b <smp_stop_nmi_callback+0x2b>       47d17: R_X86_64_PLT32   stop_this_cpu-0x4
002b    47d1b:  b8 01 00 00 00          mov    $0x1,%eax

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/processor.h |    2 +-
 arch/x86/kernel/process.c        |    2 +-
 tools/objtool/check.c            |    1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -837,7 +837,7 @@ bool xen_set_default_idle(void);
 #define xen_set_default_idle 0
 #endif
 
-void stop_this_cpu(void *dummy);
+void __noreturn stop_this_cpu(void *dummy);
 void microcode_check(void);
 
 enum l1tf_mitigations {
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -747,7 +747,7 @@ bool xen_set_default_idle(void)
 }
 #endif
 
-void stop_this_cpu(void *dummy)
+void __noreturn stop_this_cpu(void *dummy)
 {
 	local_irq_disable();
 	/*
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -181,6 +181,7 @@ static bool __dead_end_function(struct o
 		"kunit_try_catch_throw",
 		"xen_start_kernel",
 		"cpu_bringup_and_idle",
+		"stop_this_cpu",
 	};
 
 	if (!func)


