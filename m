Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B524BC338
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 01:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240323AbiBSAMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 19:12:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235702AbiBSAMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 19:12:32 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA393EA8D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:12:14 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id i11so8340627lfu.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jQMDNFv9gtsCnS3VKdmm1wB76M4VJRSnZhhrQoJVMi8=;
        b=iu4h36i9IKyV1eJhR7o6UMEKBkADEj98y1ow9+syZgFbN4JVfEyAKHY2N3SFupf+Ge
         c+ZNYsI/0leBzkBebfaUaSZkKrnqMXQvZlaYMrBeP0GuluGbgKSH0nH+/RBqhd9kcuaP
         PWZ2+G5ujpxGcnLZyQdh6O8v6VPGZuC0tp1soZRvX8NfDwfAfJHrENvnLDXKtA3HaN/X
         155i57XdOCx1Tle80Kb9oENof+H1UBdXaYV8Ie2tlveIt1yBkDC4cDwMKqOJrxn7SGmd
         zJ8XXqPBOZ/xH5Fa+FIV0eYb95J76RIsVuq7mtyH+HVHDsyPwh3h4ey7k1LspxRdX3a7
         78IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jQMDNFv9gtsCnS3VKdmm1wB76M4VJRSnZhhrQoJVMi8=;
        b=Nbvg1S0TZTDZlComgrz4BtqyferhWm676dKTntlw5zBLCB6TIEN0jSWtjlPtfQIbmd
         vOa7aQloZ3mTzozWOksDJWCLonnev7PqwEGU5Yn5rMxCb7DtUivY9PUIVTeLqSd4nRyg
         OZqWjZhJZ5iaR3+KlwnxRN4MaIXWPlH+D0bKqwQgY8LHAeqNmWLW72HHQekTrHFJjpu5
         Kh54hOwUISy7fkrNXu9AIChIBG5LCVr/qGOiqilkzoT86vz2MbKxQzp/fO6SBsZWXEqk
         Cww/dvx7CQzdT/fw1fzGsCJhiYZidnf076zMY1KNHlg3jaHfpkTDdiYVAS2l1GvAKV1r
         /+0A==
X-Gm-Message-State: AOAM530urIFZEE0/+AAJ5AHVYcn9gm5vKBrOUEtBctiPJJMPTLUrS72A
        +E9Kab+eRWzXh1isAT+wU7YDWA==
X-Google-Smtp-Source: ABdhPJx4mCqVjx8MJl+GBymqCFuuuz1j1s3igoio+6J5srrfvMjo6dCh4ixi0zx1nVxqnS+j148ZVQ==
X-Received: by 2002:a05:6512:2306:b0:443:3db8:d6c8 with SMTP id o6-20020a056512230600b004433db8d6c8mr6886555lfu.161.1645229533313;
        Fri, 18 Feb 2022 16:12:13 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id o17sm406732lfo.189.2022.02.18.16.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 16:12:11 -0800 (PST)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 17D2A103935; Sat, 19 Feb 2022 03:13:07 +0300 (+03)
To:     bp@alien8.de
Cc:     aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        dave.hansen@intel.com, david@redhat.com, hpa@zytor.com,
        jgross@suse.com, jmattson@google.com, joro@8bytes.org,
        jpoimboe@redhat.com, kirill.shutemov@linux.intel.com,
        knsathya@kernel.org, linux-kernel@vger.kernel.org, luto@kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, sdeep@vmware.com,
        seanjc@google.com, tglx@linutronix.de, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org
Subject: [PATCHv3.1 2/32] x86/coco: Explicitly declare type of confidential computing platform
Date:   Sat, 19 Feb 2022 03:13:04 +0300
Message-Id: <20220219001305.22883-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <YhAWcPbzgUGcJZjI@zn.tnic>
References: <YhAWcPbzgUGcJZjI@zn.tnic>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel derives type of confidential computing platform from sme_me_mask
value and hv_is_isolation_supported(). This detection process will be
more complicated as more platforms get added.

Declare confidential computing vendor explicitly via cc_init().

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/coco.h        | 16 ++++++++++++++++
 arch/x86/kernel/cc_platform.c      | 29 +++++++++++++++++------------
 arch/x86/kernel/cpu/mshyperv.c     |  3 +++
 arch/x86/mm/mem_encrypt_identity.c |  8 +++++---
 4 files changed, 41 insertions(+), 15 deletions(-)
 create mode 100644 arch/x86/include/asm/coco.h

diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
new file mode 100644
index 000000000000..6e770e0dd683
--- /dev/null
+++ b/arch/x86/include/asm/coco.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_COCO_H
+#define _ASM_X86_COCO_H
+
+#include <asm/pgtable_types.h>
+
+enum cc_vendor {
+	CC_VENDOR_NONE,
+	CC_VENDOR_AMD,
+	CC_VENDOR_HYPERV,
+	CC_VENDOR_INTEL,
+};
+
+void cc_init(enum cc_vendor);
+
+#endif /* _ASM_X86_COCO_H */
diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
index 6a6ffcd978f6..891d3074a16e 100644
--- a/arch/x86/kernel/cc_platform.c
+++ b/arch/x86/kernel/cc_platform.c
@@ -9,18 +9,15 @@
 
 #include <linux/export.h>
 #include <linux/cc_platform.h>
-#include <linux/mem_encrypt.h>
 
-#include <asm/mshyperv.h>
+#include <asm/coco.h>
 #include <asm/processor.h>
 
-static bool __maybe_unused intel_cc_platform_has(enum cc_attr attr)
+static enum cc_vendor cc_vendor;
+
+static bool intel_cc_platform_has(enum cc_attr attr)
 {
-#ifdef CONFIG_INTEL_TDX_GUEST
-	return false;
-#else
 	return false;
-#endif
 }
 
 /*
@@ -74,12 +71,20 @@ static bool hyperv_cc_platform_has(enum cc_attr attr)
 
 bool cc_platform_has(enum cc_attr attr)
 {
-	if (sme_me_mask)
+	switch (cc_vendor) {
+	case CC_VENDOR_AMD:
 		return amd_cc_platform_has(attr);
-
-	if (hv_is_isolation_supported())
+	case CC_VENDOR_INTEL:
+		return intel_cc_platform_has(attr);
+	case CC_VENDOR_HYPERV:
 		return hyperv_cc_platform_has(attr);
-
-	return false;
+	default:
+		return false;
+	}
 }
 EXPORT_SYMBOL_GPL(cc_platform_has);
+
+__init void cc_init(enum cc_vendor vendor)
+{
+	cc_vendor = vendor;
+}
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 5a99f993e639..d77cf3a31f07 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -33,6 +33,7 @@
 #include <asm/nmi.h>
 #include <clocksource/hyperv_timer.h>
 #include <asm/numa.h>
+#include <asm/coco.h>
 
 /* Is Linux running as the root partition? */
 bool hv_root_partition;
@@ -344,6 +345,8 @@ static void __init ms_hyperv_init_platform(void)
 		 */
 		swiotlb_force = SWIOTLB_FORCE;
 #endif
+		if (hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE)
+			cc_init(CC_VENDOR_HYPERV);
 	}
 
 	if (hv_max_functions_eax >= HYPERV_CPUID_NESTED_FEATURES) {
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 3f0abb403340..eb7fbd85b77e 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -44,6 +44,7 @@
 #include <asm/setup.h>
 #include <asm/sections.h>
 #include <asm/cmdline.h>
+#include <asm/coco.h>
 
 #include "mm_internal.h"
 
@@ -565,8 +566,7 @@ void __init sme_enable(struct boot_params *bp)
 	} else {
 		/* SEV state cannot be controlled by a command line option */
 		sme_me_mask = me_mask;
-		physical_mask &= ~sme_me_mask;
-		return;
+		goto out;
 	}
 
 	/*
@@ -600,6 +600,8 @@ void __init sme_enable(struct boot_params *bp)
 		sme_me_mask = 0;
 	else
 		sme_me_mask = active_by_default ? me_mask : 0;
-
+out:
 	physical_mask &= ~sme_me_mask;
+	if (sme_me_mask)
+		cc_init(CC_VENDOR_AMD);
 }
-- 
2.34.1

