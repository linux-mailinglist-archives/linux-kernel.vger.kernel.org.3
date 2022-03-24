Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870D74E69DF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 21:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353428AbiCXUfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 16:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244145AbiCXUfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 16:35:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EA97B55D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 13:34:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6082560F27
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 20:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E16C340EC;
        Thu, 24 Mar 2022 20:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648154044;
        bh=Hke9uijvJjLH+sMjuC7Gd22j8kyXtDr8eWCu19CgugQ=;
        h=Date:From:Cc:Subject:From;
        b=VMyQlL3kUfwrvYNxhv9HC9vK4q/qHFfqhHV03J9LyO/HnFe+yhOcaY3cYsTcFQ9z1
         vix37R6s1N+ZqGgHNnASFY3ijUPWu2nG4JEUSaXY4P58yUhjlhrPCl4P0gaSVxzGtY
         yvBG7OVp65+qxAKuXurUirPM4AW2BYadpHtfrYXF5CBB39qQhQgwfrG27d1FcPVzCQ
         xMNi8NEHxyj8RR0hXJ2qY4YdnvCoW6RBEX2dSlK+1JozFaIcYCAS35Z9NZ4RE/yRK0
         rZeD5oFFp1cZAB6oaSzXpk08t5p9dR+C57K3AoXm7XEV+TCiReo/0Gl7QoB7Ra9LP0
         dFNTMeviU/0nA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CC50840407; Thu, 24 Mar 2022 17:33:59 -0300 (-03)
Date:   Thu, 24 Mar 2022 17:33:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] tools arch x86: Sync the msr-index.h copy with the
 kernel sources
Message-ID: <YjzVt8CjAORAsTCo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just FYI, I'm carrying this on the perf tools tree:

---------

To pick up the changes from these csets:

  7b8f40b3de75c971 ("x86/cpu: Add definitions for the Intel Hardware Feedback Interface")

That cause no changes to tooling:

  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > before
  $ cp arch/x86/include/asm/msr-index.h tools/arch/x86/include/asm/msr-index.h
  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > after
  $ diff -u before after
  $

Just silences this perf build warning:

  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/msr-index.h' differs from latest version at 'arch/x86/include/asm/msr-index.h'
  diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h

Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/msr-index.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index a4a39c3e0f196747..0e7f303542bf35d6 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -705,12 +705,14 @@
 
 #define PACKAGE_THERM_STATUS_PROCHOT		(1 << 0)
 #define PACKAGE_THERM_STATUS_POWER_LIMIT	(1 << 10)
+#define PACKAGE_THERM_STATUS_HFI_UPDATED	(1 << 26)
 
 #define MSR_IA32_PACKAGE_THERM_INTERRUPT	0x000001b2
 
 #define PACKAGE_THERM_INT_HIGH_ENABLE		(1 << 0)
 #define PACKAGE_THERM_INT_LOW_ENABLE		(1 << 1)
 #define PACKAGE_THERM_INT_PLN_ENABLE		(1 << 24)
+#define PACKAGE_THERM_INT_HFI_ENABLE		(1 << 25)
 
 /* Thermal Thresholds Support */
 #define THERM_INT_THRESHOLD0_ENABLE    (1 << 15)
@@ -959,4 +961,8 @@
 #define MSR_VM_IGNNE                    0xc0010115
 #define MSR_VM_HSAVE_PA                 0xc0010117
 
+/* Hardware Feedback Interface */
+#define MSR_IA32_HW_FEEDBACK_PTR        0x17d0
+#define MSR_IA32_HW_FEEDBACK_CONFIG     0x17d1
+
 #endif /* _ASM_X86_MSR_INDEX_H */
-- 
2.35.1

