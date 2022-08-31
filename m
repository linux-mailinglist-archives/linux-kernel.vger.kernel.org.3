Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6565A723E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 02:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiHaAKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 20:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiHaAKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 20:10:09 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FE31FCC0;
        Tue, 30 Aug 2022 17:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661904608; x=1693440608;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ycqr6beUoX/Dkc6cppmDzo9xRaG5F1v6sGpb+uApczQ=;
  b=gefjYgJBGkPdtNEw+b4lSuvdrtOSsLwtXY6uT/u18887roZw6Rp5Gd4V
   JPqXRn8iMueEYjS6+0cP2QMyKQcfUhgD8pO53PfQm/bNPLJjchbOTdC0I
   Tmsp57+DHQa/RQqeZnuyf1TzhvbPHCjoqQnnfaszKsqXDKtZYzzuoVJ4O
   Q/PGyLrzLU0la5dhswhhWdFjViiaZLeFYx7sZMGTitJcwgwsPsQSJBZJP
   pjFVg/w3tLHalGH4qTHbVc1NIsu6fjfGX2yfn305Uysmmj4znP7ljmEq/
   8A1gMqStjb/yBtPxeznHJvmjKlL0NcDUY7MtSDicVPoyTTIYQsLwqchTf
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="357052788"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="357052788"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 17:10:08 -0700
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="641625500"
Received: from skanpuri-mobl1.amr.corp.intel.com (HELO desk) ([10.212.18.137])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 17:10:07 -0700
Date:   Tue, 30 Aug 2022 17:10:06 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        antonio.gomez.iglesias@linux.intel.com,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>
Subject: [PATCH] x86/bugs: Fix retbleed reporting "Vulnerable" when
 spectre_v2=ibrs
Message-ID: <bb49bdae73c993b8d7e68a8652116dc9512769a9.1661904261.git.pawan.kumar.gupta@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.3 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With cmdline "spectre_v2=ibrs retbleed=off" sysfs reports vulnerable to
retbleed:

  $ cat /sys/devices/system/cpu/vulnerabilities/retbleed
  Vulnerable

On Intel CPUs when IBRS or Enhanced IBRS is enabled, system is not
vulnerable to retbleed.

Even if a user has passed retbleed=off, mitigation for retbleed could be
deployed as part of spectre_v2 mitigation. Fix retbleed reporting for
such a case.

Fixes: 6ad0ad2bf8a6 ("x86/bugs: Report Intel retbleed vulnerability")
Reported-by: Antonio Gomez Iglesias <antonio.gomez.iglesias@linux.intel.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: stable@vger.kernel.org
---
 .../admin-guide/kernel-parameters.txt         |  4 +++-
 arch/x86/kernel/cpu/bugs.c                    | 19 +++++++++++--------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 426fa892d311..70447979111c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5280,7 +5280,9 @@
 			cessors that support it, and mitigate SMT on processors
 			that don't.
 
-			off          - no mitigation
+			off          - no mitigation. Overridden when
+				       spectre_v2 mitigation already mitigates
+				       retbleed.
 			auto         - automatically select a migitation
 			auto,nosmt   - automatically select a mitigation,
 				       disabling SMT if necessary for
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index da7c361f47e0..02f4e0a2f725 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -778,6 +778,14 @@ early_param("nospectre_v1", nospectre_v1_cmdline);
 static enum spectre_v2_mitigation spectre_v2_enabled __ro_after_init =
 	SPECTRE_V2_NONE;
 
+static inline bool spectre_v2_in_ibrs_mode(enum spectre_v2_mitigation mode)
+{
+	return mode == SPECTRE_V2_IBRS ||
+	       mode == SPECTRE_V2_EIBRS ||
+	       mode == SPECTRE_V2_EIBRS_RETPOLINE ||
+	       mode == SPECTRE_V2_EIBRS_LFENCE;
+}
+
 #undef pr_fmt
 #define pr_fmt(fmt)     "RETBleed: " fmt
 
@@ -856,6 +864,9 @@ static void __init retbleed_select_mitigation(void)
 
 	switch (retbleed_cmd) {
 	case RETBLEED_CMD_OFF:
+		if (spectre_v2_in_ibrs_mode(spectre_v2_enabled) &&
+		    boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+			goto do_cmd_auto;
 		return;
 
 	case RETBLEED_CMD_UNRET:
@@ -1095,14 +1106,6 @@ spectre_v2_parse_user_cmdline(void)
 	return SPECTRE_V2_USER_CMD_AUTO;
 }
 
-static inline bool spectre_v2_in_ibrs_mode(enum spectre_v2_mitigation mode)
-{
-	return mode == SPECTRE_V2_IBRS ||
-	       mode == SPECTRE_V2_EIBRS ||
-	       mode == SPECTRE_V2_EIBRS_RETPOLINE ||
-	       mode == SPECTRE_V2_EIBRS_LFENCE;
-}
-
 static void __init
 spectre_v2_user_select_mitigation(void)
 {

base-commit: b90cb1053190353cc30f0fef0ef1f378ccc063c5
-- 
2.37.2


