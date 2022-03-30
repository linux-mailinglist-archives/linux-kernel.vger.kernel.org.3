Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78574EBCAC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 10:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244254AbiC3IWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 04:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiC3IWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 04:22:34 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF38430F52
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 01:20:48 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: rcn)
        with ESMTPSA id 817A61F443EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648628447;
        bh=BsgS3Yrnz9Ahm/XDneBzS9oUTSGp3sCkzNQSr/FIjUI=;
        h=From:To:Cc:Subject:Date:From;
        b=Yn3KxJPOdxeKyamCekKoxq+nkIoxQ91HCB4lWUbQKWKSZ3eZkdHtCxtVux8dYq8O3
         OlYLzH0WwcrfK1R9f8GxEhOXNvB3l0D+lmtJJi6ieTSikWj1ARXJ7i1VFJGEnHfylN
         HUufNYEDww+CSdjALmGvm9GSt4UL63uQ/N6u/eRc6QP5jeCXvLFgGYUoRJ3C8QjOOR
         r+UMn2wuSY70PMZO0YZSOKY15eDnI5Qe9rZT0wczJgFt4TXdk1XW3ZytgJLGowzHpc
         etoGT2a95xn7oInMXjOaOG7S357vMOFz9eSijXrFhvI9pGuxAn8F1x4kZF5Trv3i7n
         adPwaDHRtKJCw==
From:   =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        Borislav Petkov <bp@alien8.de>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Mark Gross <mgross@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Johansen <john.johansen@canonical.com>,
        Steve Beattie <sbeattie@ubuntu.com>, kernel@collabora.com
Subject: [PATCH v2] x86/speculation/srbds: do not try to turn mitigation off when not supported
Date:   Wed, 30 Mar 2022 10:20:26 +0200
Message-Id: <20220330082026.1549073-1-ricardo.canuelo@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When SRBDS is mitigated by TSX OFF, update_srbds_msr will still read and
write to MSR_IA32_MCU_OPT_CTRL even when that is not supported by the
microcode.

Checking for X86_FEATURE_SRBDS_CTRL as a CPU feature available makes more
sense than checking for SRBDS_MITIGATION_UCODE_NEEDED as the found
"mitigation".

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Signed-off-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
Tested-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
---
Hi all,

This patch was originally posted here:

https://lore.kernel.org/all/20200609174313.2600320-1-cascardo@canonical.com/#t

by Boris, based on the original patch by Cascardo, I didn't make any
changes to it. I didn't see it merged or discussed further and I can
still reproduce the issue on a Samsung Galaxy Chromebook 2 (Intel
Cometlake-U). When booted without the proper CPU u-codes, TSX is
disabled (so the CPU isn't vulnerable to SRDBS) but this code still
tries to access an unavailable MSR register so I get these two warning
messages:

unchecked MSR access error: RDMSR from 0x123 at rIP: 0xffffffff8203707e (update_srbds_msr+0x2e/0xa0)
Call Trace:
 <TASK>
 check_bugs+0x994/0xa6e
 ? __get_locked_pte+0x8f/0x100
 start_kernel+0x630/0x664
 secondary_startup_64_no_verify+0xd5/0xdb
 </TASK>
unchecked MSR access error: WRMSR to 0x123 (tried to write 0x0000000000000001) at rIP: 0xffffffff820370a9 (update_srbds_msr+0x59/0xa0)
Call Trace:
 <TASK>
 check_bugs+0x994/0xa6e
 ? __get_locked_pte+0x8f/0x100
 start_kernel+0x630/0x664
 secondary_startup_64_no_verify+0xd5/0xdb
 </TASK>

This patch avoids them.

 arch/x86/kernel/cpu/bugs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 6296e1ebed1d..9b14cb2ec693 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -443,14 +443,14 @@ void update_srbds_msr(void)
 	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
 		return;
 
-	if (srbds_mitigation == SRBDS_MITIGATION_UCODE_NEEDED)
+	if (srbds_mitigation == SRBDS_MITIGATION_UCODE_NEEDED ||
+	    srbds_mitigation == SRBDS_MITIGATION_TSX_OFF)
 		return;
 
 	rdmsrl(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl);
 
 	switch (srbds_mitigation) {
 	case SRBDS_MITIGATION_OFF:
-	case SRBDS_MITIGATION_TSX_OFF:
 		mcu_ctrl |= RNGDS_MITG_DIS;
 		break;
 	case SRBDS_MITIGATION_FULL:
-- 
2.25.1

