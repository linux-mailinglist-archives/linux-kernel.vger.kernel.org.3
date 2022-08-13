Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597EF5919E6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 12:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239311AbiHMKkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 06:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237459AbiHMKkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 06:40:08 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A590F25C4A
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 03:40:07 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id uj29so5876754ejc.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 03:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc;
        bh=8IUQPskIBgl2mxmBjoABlVJ2op5dkg7LRpx+HWgTYo8=;
        b=N73fR19aF/uGttZDGKgdAcjssjhbHLkqOjN0ks0acFHejh5GlEAiIa7j9G3kiNySAg
         4sJoWZylTfSVzpY//FmT63XVNpW00sStn6QYnhiJoa19xs4Ii7c32LoxPjMsydpnnKHO
         KmQTwT8gvGpgM1zPFOlqME90UMrsp+CEEtEnFjyQ3lYb0TXBXde8ECEruQgBnlil5AFS
         pT/jw/9IyweUtnp5L7i3Rno9sq22HWJX8TabfLZKiHSEfYADDFYEKJk57jdVID/f5gOf
         wdCDUIww6fwb0mfh6AXRLwcnir83qgCzZouYfaYK5ldQR+cCVfhmjKiRGR33dFM2Pt9f
         tQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc;
        bh=8IUQPskIBgl2mxmBjoABlVJ2op5dkg7LRpx+HWgTYo8=;
        b=7SEtOWOPJcfdG8QV7BJaHvqmmhBdZtjc/Mn9ObmI9SiObrGILgMKccDlyoED1dOKwK
         vEbx2p1NRYi1gLJQCXKtjfbggTjOO7wVnRxvvli+uuLle1HU1vwz2pWQtVw1kH313KTr
         QtF5UJqLBeSuY96O9sXdGr5f/Yz4m8ls1oVchDQSXNxhjPPRNs/6IixmORGz3w2nqU8K
         4O4PwwEdNIwRdnXUPJwAXxo4xkhhy9VG/MUOT1xjPCMYPUZQIJkilCwR7W49VRlJZkgC
         /DxrdUn2oxCtE2e8TjY0+8g7UcahPDWgZ4altC+BrDFCFlLD+FZAHQlCu9rUH9sw7lY/
         Vnkg==
X-Gm-Message-State: ACgBeo26rqbTSKMcmV1BXmzfPZHDH1Sy6xg8QsUIVNuplRu4Bep50DET
        ei5xSxOsJANKSLtEx9RsAHU=
X-Google-Smtp-Source: AA6agR4aSmrBHm+YH8JqP3eRoTC/XiGWApBdQewBdIFm4mqVFtpjmw+jdIXOh7QCAcJGUWADKQw7NQ==
X-Received: by 2002:a17:906:8a6c:b0:730:a322:6f69 with SMTP id hy12-20020a1709068a6c00b00730a3226f69mr5095188ejc.585.1660387206095;
        Sat, 13 Aug 2022 03:40:06 -0700 (PDT)
Received: from gmail.com (84-236-113-143.pool.digikabel.hu. [84.236.113.143])
        by smtp.gmail.com with ESMTPSA id e8-20020a170906080800b007309d640484sm1735948ejd.91.2022.08.13.03.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 03:40:05 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 13 Aug 2022 12:40:03 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [GIT PULL] x86 fix
Message-ID: <Yvd/g8RODN/pSkCX@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RISK_FREE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2022-08-13

   # HEAD: e6cfcdda8cbe81eaf821c897369a65fec987b404 x86/bugs: Enable STIBP for IBPB mitigated RETBleed

Fix the "IBPB mitigated RETBleed" mode of operation on AMD CPUs
(not turned on by default), which also need STIBP enabled (if
available) to be '100% safe' on even the shortest speculation
windows.

 Thanks,

	Ingo

------------------>
Kim Phillips (1):
      x86/bugs: Enable STIBP for IBPB mitigated RETBleed


 Documentation/admin-guide/kernel-parameters.txt | 29 ++++++++++++++++++-------
 arch/x86/kernel/cpu/bugs.c                      | 10 +++++----
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 5e9147fe8968..523b19624026 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5209,20 +5209,33 @@
 			Speculative Code Execution with Return Instructions)
 			vulnerability.
 
+			AMD-based UNRET and IBPB mitigations alone do not stop
+			sibling threads from influencing the predictions of other
+			sibling threads. For that reason, STIBP is used on pro-
+			cessors that support it, and mitigate SMT on processors
+			that don't.
+
 			off          - no mitigation
 			auto         - automatically select a migitation
 			auto,nosmt   - automatically select a mitigation,
 				       disabling SMT if necessary for
 				       the full mitigation (only on Zen1
 				       and older without STIBP).
-			ibpb	     - mitigate short speculation windows on
-				       basic block boundaries too. Safe, highest
-				       perf impact.
-			unret        - force enable untrained return thunks,
-				       only effective on AMD f15h-f17h
-				       based systems.
-			unret,nosmt  - like unret, will disable SMT when STIBP
-			               is not available.
+			ibpb         - On AMD, mitigate short speculation
+				       windows on basic block boundaries too.
+				       Safe, highest perf impact. It also
+				       enables STIBP if present. Not suitable
+				       on Intel.
+			ibpb,nosmt   - Like "ibpb" above but will disable SMT
+				       when STIBP is not available. This is
+				       the alternative for systems which do not
+				       have STIBP.
+			unret        - Force enable untrained return thunks,
+				       only effective on AMD f15h-f17h based
+				       systems.
+			unret,nosmt  - Like unret, but will disable SMT when STIBP
+				       is not available. This is the alternative for
+				       systems which do not have STIBP.
 
 			Selecting 'auto' will choose a mitigation method at run
 			time according to the CPU.
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 6761668100b9..d50686ca5870 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -152,7 +152,7 @@ void __init check_bugs(void)
 	/*
 	 * spectre_v2_user_select_mitigation() relies on the state set by
 	 * retbleed_select_mitigation(); specifically the STIBP selection is
-	 * forced for UNRET.
+	 * forced for UNRET or IBPB.
 	 */
 	spectre_v2_user_select_mitigation();
 	ssb_select_mitigation();
@@ -1179,7 +1179,8 @@ spectre_v2_user_select_mitigation(void)
 	    boot_cpu_has(X86_FEATURE_AMD_STIBP_ALWAYS_ON))
 		mode = SPECTRE_V2_USER_STRICT_PREFERRED;
 
-	if (retbleed_mitigation == RETBLEED_MITIGATION_UNRET) {
+	if (retbleed_mitigation == RETBLEED_MITIGATION_UNRET ||
+	    retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {
 		if (mode != SPECTRE_V2_USER_STRICT &&
 		    mode != SPECTRE_V2_USER_STRICT_PREFERRED)
 			pr_info("Selecting STIBP always-on mode to complement retbleed mitigation\n");
@@ -2320,10 +2321,11 @@ static ssize_t srbds_show_state(char *buf)
 
 static ssize_t retbleed_show_state(char *buf)
 {
-	if (retbleed_mitigation == RETBLEED_MITIGATION_UNRET) {
+	if (retbleed_mitigation == RETBLEED_MITIGATION_UNRET ||
+	    retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {
 	    if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
 		boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
-		    return sprintf(buf, "Vulnerable: untrained return thunk on non-Zen uarch\n");
+		    return sprintf(buf, "Vulnerable: untrained return thunk / IBPB on non-AMD based uarch\n");
 
 	    return sprintf(buf, "%s; SMT %s\n",
 			   retbleed_strings[retbleed_mitigation],
