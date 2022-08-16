Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98E659537D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbiHPHKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbiHPHJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:09:46 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC01388E3D
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 21:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660624798; x=1692160798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FW9xRisc1P87Bo7EmCsCCev95LdEfxwofPWBD0JqoS0=;
  b=JELJHQDVar32VB3mYWVvHGpP1m/KCtMB8Bsezkmgq6J32EhFY7e55KR1
   BlJivqb8HthynEq4pHX1rZlzT214YE5smS3zanxg9ozLMqtPHJycCY1Ye
   fTSySHDcFED41lPti8k/mq2cQAxrtSCKtgIOCBdtKRUub8h14HPdtKv4O
   VvXEZRUiV7Ms2oxgOKBEgujdRERpst56IJiGeMRFEOBe1smMIiqgznEMu
   p0g/ncTIU22d/jvnVIxtj4qr+L09pqyiLgw8MNu2tNNYlTE3LS5/GjZNy
   Us7Btjdm6SZ3acW+GkpacLBUJKoGv3p8teuZg9kVogqqC3WVgKf3gWmZA
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="293395138"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="293395138"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 21:38:19 -0700
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="675071591"
Received: from araj-dh-work.jf.intel.com ([10.165.157.158])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 21:38:18 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "LKML Mailing List" <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH v2 2/4] x86/microcode/intel: Allow a late-load only if a min rev is specified
Date:   Tue, 16 Aug 2022 04:37:51 +0000
Message-Id: <20220816043754.3258815-3-ashok.raj@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220816043754.3258815-1-ashok.raj@intel.com>
References: <20220816043754.3258815-1-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In general users don't have the necessary information to determine
whether a late-load of a new microcode version has removed any feature
(MSR, CPUID etc) between what is currently loaded and this new microcode.
To address this issue, Intel has added a "minimum required version" field to
a previously reserved field in the file header. Microcode updates
should only be applied if the current microcode version is equal
to, or greater than this minimum required version.

https://lore.kernel.org/linux-kernel/alpine.DEB.2.21.1909062237580.1902@nanos.tec.linutronix.de/

Thomas made some suggestions on how meta-data in the microcode file could
provide Linux with information to decide if the new microcode is suitable
candidate for late-load. But even the "simpler" option#1 requires a lot of
metadata and corresponding kernel code to parse it.

The proposal here is an even simpler option. The criteria for a microcode to
be a viable late-load candidate is that no CPUID or OS visible MSR features
are removed with respect to an earlier version of the microcode.

Pseudocode for late-load is as follows:

if header.min_required_id == 0
	This is old format microcode, block late-load
else if current_ucode_version < header.min_required_id
	Current version is too old, block late-load of this microcode.
else
	OK to proceed with late-load.

Any microcode that removes a feature will set the min_version to itself.
This will enforce this microcode is not suitable for late-loading.

The enforcement is not in hardware and limited to kernel loader enforcing
the requirement. It is not required for early loading of microcode to
enforce this requirement, since the new features are only
evaluated after early loading in the boot process.


Test cases covered:

1. With new kernel, attempting to load an older format microcode with the
   min_rev=0 should be blocked by kernel.

   [  210.541802] microcode: Header MUST specify min version for late-load

2. New microcode with a non-zero min_rev in the header, but the specified
   min_rev is greater than what is currently loaded in the CPU should be
   blocked by kernel.

   245.139828] microcode: Current revision 0x8f685300 is too old to update,
must be at 0xaa000050 version or higher

3. New microcode with a min_rev < currently loaded should allow loading the
   microcode

4. Build initrd with microcode that has min_rev=0, or min_rev > currently
   loaded should permit early loading microcode from initrd.


Tested-by: William Xie <william.xie@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 arch/x86/include/asm/microcode_intel.h |  4 +++-
 arch/x86/kernel/cpu/microcode/intel.c  | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/microcode_intel.h b/arch/x86/include/asm/microcode_intel.h
index 4c92cea7e4b5..16b8715e0984 100644
--- a/arch/x86/include/asm/microcode_intel.h
+++ b/arch/x86/include/asm/microcode_intel.h
@@ -14,7 +14,9 @@ struct microcode_header_intel {
 	unsigned int            pf;
 	unsigned int            datasize;
 	unsigned int            totalsize;
-	unsigned int            reserved[3];
+	unsigned int            reserved1;
+	unsigned int		min_req_id;
+	unsigned int            reserved3;
 };
 
 struct microcode_intel {
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index c4b11e2fbe33..1eb202ec2302 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -178,6 +178,7 @@ static int microcode_sanity_check(void *mc, int print_err)
 	struct extended_sigtable *ext_header = NULL;
 	u32 sum, orig_sum, ext_sigcount = 0, i;
 	struct extended_signature *ext_sig;
+	struct ucode_cpu_info uci;
 
 	total_size = get_totalsize(mc_header);
 	data_size = get_datasize(mc_header);
@@ -248,6 +249,25 @@ static int microcode_sanity_check(void *mc, int print_err)
 		return -EINVAL;
 	}
 
+	/*
+	 * Enforce for late-load that min_req_id is specified in the header.
+	 * Otherwise its an old format microcode, reject it.
+	 */
+	if (print_err) {
+		if (!mc_header->min_req_id) {
+			pr_warn("Header MUST specify min version for late-load\n");
+			return -EINVAL;
+		}
+
+		intel_cpu_collect_info(&uci);
+		if (uci.cpu_sig.rev < mc_header->min_req_id) {
+			pr_warn("Current revision 0x%x is too old to update,"
+				"must  be at 0x%x version or higher\n",
+				uci.cpu_sig.rev, mc_header->min_req_id);
+			return -EINVAL;
+		}
+	}
+
 	if (!ext_table_size)
 		return 0;
 
-- 
2.32.0

