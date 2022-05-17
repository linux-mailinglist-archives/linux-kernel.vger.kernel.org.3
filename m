Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E11252A7F4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 18:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345823AbiEQQb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 12:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbiEQQby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 12:31:54 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF0414D1E
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 09:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1652805112; x=1684341112;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IteN9ICL3vHHQMXeE78rzjKCW/+s+R1bzkPHD4BhrHE=;
  b=jNGHWE4exEF9jzdP5+0zeSB1dH0UvztDW3mIVGXc9Ln2IkCnWVlb7B4y
   vDo+kZbfUPnST6P1OiRM1I/QDqOwMyxd62gX+LCeztO8mN9IS9v2j9wSs
   oLb0rj/AYav73tqW6OC+g59BUPPMQkNldho/s5ztqOS+cpPbuW4/3wb+N
   c=;
X-IronPort-AV: E=Sophos;i="5.91,233,1647302400"; 
   d="scan'208";a="89313648"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-718d0906.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP; 17 May 2022 16:24:43 +0000
Received: from EX13D08EUC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-718d0906.us-west-2.amazon.com (Postfix) with ESMTPS id 2584E3E00E4;
        Tue, 17 May 2022 16:24:43 +0000 (UTC)
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D08EUC002.ant.amazon.com (10.43.164.124) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Tue, 17 May 2022 16:24:41 +0000
Received: from dev-dsk-mheyne-1b-c1524648.eu-west-1.amazon.com (10.15.60.66)
 by mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP Server id
 15.0.1497.32 via Frontend Transport; Tue, 17 May 2022 16:24:40 +0000
Received: by dev-dsk-mheyne-1b-c1524648.eu-west-1.amazon.com (Postfix, from userid 5466572)
        id DC06A41146; Tue, 17 May 2022 16:24:40 +0000 (UTC)
From:   Maximilian Heyne <mheyne@amazon.de>
CC:     Maximilian Heyne <mheyne@amazon.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, <xen-devel@lists.xenproject.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86: xen: remove STACK_FRAME_NON_STANDARD from xen_cpuid
Date:   Tue, 17 May 2022 16:24:25 +0000
Message-ID: <20220517162425.100567-1-mheyne@amazon.de>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 4d65adfcd119 ("x86: xen: insn: Decode Xen and KVM
emulate-prefix signature"), objtool is able to correctly parse the
prefixed instruction in xen_cpuid and emit correct orc unwind
information. Hence, marking the function as STACKFRAME_NON_STANDARD is
no longer needed.

This commit is basically a revert of commit 983bb6d254c7 ("x86/xen: Mark
xen_cpuid() stack frame as non-standard").

Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
CC: Josh Poimboeuf <jpoimboe@kernel.org>

cr: https://code.amazon.com/reviews/CR-69645080
---
 arch/x86/xen/enlighten_pv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 5038edb79ad5..ca85d1409917 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -30,7 +30,6 @@
 #include <linux/pci.h>
 #include <linux/gfp.h>
 #include <linux/edd.h>
-#include <linux/objtool.h>
 
 #include <xen/xen.h>
 #include <xen/events.h>
@@ -165,7 +164,6 @@ static void xen_cpuid(unsigned int *ax, unsigned int *bx,
 
 	*bx &= maskebx;
 }
-STACK_FRAME_NON_STANDARD(xen_cpuid); /* XEN_EMULATE_PREFIX */
 
 static bool __init xen_check_mwait(void)
 {
-- 
2.32.0




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



