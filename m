Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F224CBC9F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 12:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbiCCLbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 06:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbiCCLbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:31:11 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C761795FE
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 03:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=1h/ft8uEzPwA8bso5xyVZXC8EKcwtN+ddoxwlbZkOho=; b=OtRwD1HTr0fSKeREEY0D0sLC9w
        YAtaRXS/hMz+JQnCMiKtxwNtUlcvcrqqHBPcx0IDwy4ydQnsMxm1uzFrn3nQnuRjNQgcrbOIXeAAz
        9CVKaShaWsEo/c0hGLahNYXais5z6HallAE5FR4eXKy59n/+ahYaral4DhS41y3vwbtB+/d55EOzp
        OIxmG2QYX6f+0L3ft/T8FMOX+/9U9ZE0T9+Oj/ztmtXfiePqezSgtUhMG8wv3rZs8jFwYAuo9ek7e
        B7Zj8XLW4Pa/E2GaRczNvBeL63xvRLKsmXTAOOExgLgrwoAnAZkw8I0nWC41RoZRmIgnkXCzYebwe
        +tDtDOMA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPjeh-00Etph-Sf; Thu, 03 Mar 2022 11:30:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 09C7B302D41;
        Thu,  3 Mar 2022 12:29:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7DAD530126B23; Thu,  3 Mar 2022 12:29:56 +0100 (CET)
Message-ID: <20220303112826.481793874@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 03 Mar 2022 12:23:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v3 25/39] x86/bugs: Disable Retpoline when IBT
References: <20220303112321.422525803@infradead.org>
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
 arch/x86/kernel/cpu/bugs.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -891,6 +891,7 @@ static void __init spectre_v2_select_mit
 {
 	enum spectre_v2_mitigation_cmd cmd = spectre_v2_parse_cmdline();
 	enum spectre_v2_mitigation mode = SPECTRE_V2_NONE;
+	bool silent_demote = false;
 
 	/*
 	 * If the CPU is not affected and the command line mode is NONE or AUTO
@@ -906,6 +907,7 @@ static void __init spectre_v2_select_mit
 
 	case SPECTRE_V2_CMD_FORCE:
 	case SPECTRE_V2_CMD_AUTO:
+		silent_demote = true;
 		if (boot_cpu_has(X86_FEATURE_IBRS_ENHANCED)) {
 			mode = SPECTRE_V2_IBRS_ENHANCED;
 			/* Force it so VMEXIT will restore correctly */
@@ -938,6 +940,7 @@ static void __init spectre_v2_select_mit
 	retpoline_amd:
 		if (!boot_cpu_has(X86_FEATURE_LFENCE_RDTSC)) {
 			pr_err("Spectre mitigation: LFENCE not serializing, switching to generic retpoline\n");
+			silent_demote = false;
 			goto retpoline_generic;
 		}
 		mode = SPECTRE_V2_RETPOLINE_AMD;
@@ -947,6 +950,16 @@ static void __init spectre_v2_select_mit
 	retpoline_generic:
 		mode = SPECTRE_V2_RETPOLINE_GENERIC;
 		setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
+
+		/*
+		 * ROP defeats IBT, make sure not to use Retpolines and IBT together.
+		 */
+		if (HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT)) {
+			if (!silent_demote)
+				pr_warn("Spectre mitigation: Switching to LFENCE due to IBT\n");
+			mode = SPECTRE_V2_RETPOLINE_AMD;
+			setup_force_cpu_cap(X86_FEATURE_RETPOLINE_AMD);
+		}
 	}
 
 specv2_set_mode:


