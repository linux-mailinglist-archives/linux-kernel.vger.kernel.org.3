Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF7F4D1C67
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347894AbiCHP4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348025AbiCHP4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:56:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392FF4F9C1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=1h/ft8uEzPwA8bso5xyVZXC8EKcwtN+ddoxwlbZkOho=; b=soql6lMdq3XuWGHaqJj8Hpn0D8
        U/uotjFuvIgkGvssSSGyZDTEjRKI8JAjuWsx1kHpZ/VPtMMg0bF8MAR4dWBy2Ifk4/CNN6J3t2kTY
        G57d227xgzJJnnNybekPhQ/j7AMJgEzIiTEC3g35CaxTiXJHVhjsD/kQ5Sew8s6ksQFX/eur9OU4G
        5XLiD4zlZr1MC+QW0xjNweoDZP+LxLMM74byXqCI7mM9TsHbfZBtmNezZ6srlcFGL5B/P8/PPXsEl
        vh+OgjVpwADGCpDohYUQ4zNyGwYmhV3Tfo+1xyeyCXfz0q/s0CicKvqDl3Kp24hvsVfamZwmkQiSR
        wodz2rMg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRcAc-00GIvF-Qg; Tue, 08 Mar 2022 15:54:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4608E302D66;
        Tue,  8 Mar 2022 16:54:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8027C2B561937; Tue,  8 Mar 2022 16:54:39 +0100 (CET)
Message-ID: <20220308154318.818707586@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 08 Mar 2022 16:30:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v4 28/45] x86/bugs: Disable Retpoline when IBT
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


