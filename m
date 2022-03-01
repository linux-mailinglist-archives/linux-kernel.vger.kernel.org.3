Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8364C9529
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 20:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237353AbiCAT4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 14:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbiCAT4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 14:56:35 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AC16CA4F;
        Tue,  1 Mar 2022 11:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646164554; x=1677700554;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=dD5vgT47K/7ze5uYlH7rkWVlSTm7dGQOtKM9I4Tl4yk=;
  b=XqtrboGDAuCJsIrMAO1os/Hn/6qPO0aHZzm6DQotgXZNmpStDZLXLtKH
   yZzbKSGDl5JV+tcLyInYpaeMS+672IAUxEakoqDtuaiagRJjNYwaqjkCJ
   +CraijzEuLFlkWSRQo+wZ+hs/NWFdyUgJSYDsrwGOtBfGvqo6Gqtnp2Y7
   P4FnxkCA1kxz1uaNQ18RAbZiCwMqCFbRI6SxVf7rnK5S1iVf7DX/S6Zod
   LgrR7O6i3bsjx7Xx5PgZO1gjCDI8/ZE3+SwF+xziLeayNW7M6pWCFBP5f
   v52UN/GY/4T6ccpNA/JyXpcVuxhCRgxQWGdRxuKxk5i48z5CzBkGQPQD0
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="233194889"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="233194889"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 11:55:53 -0800
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="630133155"
Received: from coffy.sc.intel.com ([10.3.79.166])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 11:55:53 -0800
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, jithu.joseph@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com
Subject: [RFC 01/10] x86/microcode/intel: expose collect_cpu_info_early() for IFS
Date:   Tue,  1 Mar 2022 11:54:48 -0800
Message-Id: <20220301195457.21152-2-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220301195457.21152-1-jithu.joseph@intel.com>
References: <20220301195457.21152-1-jithu.joseph@intel.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IFS uses a image provided by Intel that can be regarded as firmware.
IFS image carries the Processor Signature such as family/model/stepping
similar to what we find in the microcode header.

Expose collect_cpu_info_early() and cpu_signatures_match() for IFS image
sanity check.

No functional change.

Originally-by: Kyung Min Park <kyung.min.park@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/microcode_intel.h | 6 ++++++
 arch/x86/kernel/cpu/microcode/intel.c  | 8 +++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/microcode_intel.h b/arch/x86/include/asm/microcode_intel.h
index d85a07d7154f..ec19eeac535b 100644
--- a/arch/x86/include/asm/microcode_intel.h
+++ b/arch/x86/include/asm/microcode_intel.h
@@ -74,12 +74,18 @@ extern void load_ucode_intel_ap(void);
 extern void show_ucode_info_early(void);
 extern int __init save_microcode_in_initrd_intel(void);
 void reload_ucode_intel(void);
+int collect_cpu_info_early(struct ucode_cpu_info *uci);
+bool cpu_signatures_match(unsigned int s1, unsigned int p1,
+			  unsigned int s2, unsigned int p2);
 #else
 static inline __init void load_ucode_intel_bsp(void) {}
 static inline void load_ucode_intel_ap(void) {}
 static inline void show_ucode_info_early(void) {}
 static inline int __init save_microcode_in_initrd_intel(void) { return -EINVAL; }
 static inline void reload_ucode_intel(void) {}
+static inline void collect_cpu_info_early(struct ucode_cpu_info *uci) {}
+static inline void cpu_signatures_match(unsigned int s1, unsigned int p1,
+					unsigned int s2, unsigned int p2) {}
 #endif
 
 #endif /* _ASM_X86_MICROCODE_INTEL_H */
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index d28a9f8f3fec..360ec06eec1e 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -45,8 +45,8 @@ static struct microcode_intel *intel_ucode_patch;
 /* last level cache size per core */
 static int llc_size_per_core;
 
-static inline bool cpu_signatures_match(unsigned int s1, unsigned int p1,
-					unsigned int s2, unsigned int p2)
+bool cpu_signatures_match(unsigned int s1, unsigned int p1,
+			  unsigned int s2, unsigned int p2)
 {
 	if (s1 != s2)
 		return false;
@@ -58,6 +58,7 @@ static inline bool cpu_signatures_match(unsigned int s1, unsigned int p1,
 	/* ... or they intersect. */
 	return p1 & p2;
 }
+EXPORT_SYMBOL_GPL(cpu_signatures_match);
 
 /*
  * Returns 1 if update has been found, 0 otherwise.
@@ -342,7 +343,7 @@ scan_microcode(void *data, size_t size, struct ucode_cpu_info *uci, bool save)
 	return patch;
 }
 
-static int collect_cpu_info_early(struct ucode_cpu_info *uci)
+int collect_cpu_info_early(struct ucode_cpu_info *uci)
 {
 	unsigned int val[2];
 	unsigned int family, model;
@@ -372,6 +373,7 @@ static int collect_cpu_info_early(struct ucode_cpu_info *uci)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(collect_cpu_info_early);
 
 static void show_saved_mc(void)
 {
-- 
2.17.1

