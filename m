Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10607591D07
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 00:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239501AbiHMWi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 18:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiHMWix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 18:38:53 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182406CD21
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 15:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660430332; x=1691966332;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1fpF+ymFnH5IX7O5IPicQaNHD1gQ01NDudBysAsl4rs=;
  b=LHr8O2FdqIthDvh7gWA+Tr4R6+2F4Z21S7kIv/QHjLpH/2kAYdK/Hhkz
   4vktPkFFi5SgquatUpoJNoLt/J4hzfigyQ8HZ/EcrhItYlpgXTyKuMRlf
   hcUgFw1sFwhI7hR7jFB5xfV6nNoGX7GPxmFyjR+btm15c7u5XjYpKqUjG
   Fjy5t+MP+xbXRYuxocmIy04VLxJMFw/sfmrTjzm13y2sBRKi8ai/rcO38
   aZBahT+/J0X1EkWbbMkITRukOmvLnx8jQfU/hixsFOSB+ZGTfMTCp3MsD
   jzMieZsPkz3q6PWqgA7rd540V8W++XKYVhHJnSEo0UTKgYSznFQDV4dis
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="353523720"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="353523720"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 15:38:49 -0700
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="556890228"
Received: from araj-dh-work.jf.intel.com ([10.165.157.158])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 15:38:49 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "LKML Mailing List" <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH 2/5] x86/microcode/intel: Check against CPU signature before saving microcode
Date:   Sat, 13 Aug 2022 22:38:22 +0000
Message-Id: <20220813223825.3164861-3-ashok.raj@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220813223825.3164861-1-ashok.raj@intel.com>
References: <20220813223825.3164861-1-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When save_microcode_patch() is looking to replace an existing microcode in
the cache, current code is *only* checks the CPU sig/pf in the main
header. Microcode can carry additional sig/pf combinations in the extended
signature table, which is completely missed today.

For e.g. Current patch is a multi-stepping patch and new incoming patch is
a specific patch just for this CPUs stepping.

patch1:
fms3 <--- header FMS
...
ext_sig:
fms1
fms2

patch2: new
fms2 <--- header FMS

Current code takes only fms3 and checks with patch2 fms2.

saved_patch.header.fms3 != new_patch.header.fms2, so save_microcode_patch
saves it to the end of list instead of replacing patch1 with patch2.

There is no functional user observable issue since find_patch() skips
patch versions that are <= current_patch and will land on patch2 properly.

Nevertheless this will just end up storing every patch that isn't required.
Kernel just needs to store the latest patch. Otherwise its a memory leak
that sits in kernel and never used.

Tested-by: William Xie <william.xie@intel.com>
Reported-by: William Xie <william.xie@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 arch/x86/kernel/cpu/microcode/intel.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 025c8f0cd948..c4b11e2fbe33 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -114,10 +114,18 @@ static void save_microcode_patch(struct ucode_cpu_info *uci, void *data, unsigne
 
 	list_for_each_entry_safe(iter, tmp, &microcode_cache, plist) {
 		mc_saved_hdr = (struct microcode_header_intel *)iter->data;
-		sig	     = mc_saved_hdr->sig;
-		pf	     = mc_saved_hdr->pf;
 
-		if (find_matching_signature(data, sig, pf)) {
+		sig = uci->cpu_sig.sig;
+		pf  = uci->cpu_sig.pf;
+
+		/*
+		 * Compare the current CPUs signature with the ones in the
+		 * cache to identify the right candidate to replace. At any
+		 * given time, we should have no more than one valid patch
+		 * file for a given CPU fms+pf in the cache list.
+		 */
+
+		if (find_matching_signature(iter->data, sig, pf)) {
 			prev_found = true;
 
 			if (mc_hdr->rev <= mc_saved_hdr->rev)
-- 
2.32.0

