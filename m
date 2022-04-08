Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83F94F91D8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbiDHJQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbiDHJMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:12:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B8F1E9616;
        Fri,  8 Apr 2022 02:09:14 -0700 (PDT)
Date:   Fri, 08 Apr 2022 09:09:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649408952;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XZfOORXOceXGeCyxCEY73gG4PbmKJjXmHrYNPDbmj5k=;
        b=OwS5Wj/PvIU76x9zV5D/uSVNoydHVXiTzm88Igw7xdGcBD/hr4hztn1JaJTKRufIkagykE
        45sLtp/Ur1mP/jFUVLGIpz8hbHoKUMskYtnAOK1sBvjSIi4sCmzlzd7Kust5/R2Trxk8qp
        XZw/Phz2o/O0mF7tzG8nu4EjQj9++EWQuk+ryHoMEEGoxby11Kth5MSHdVGQrs+XB/TS5u
        NjKlCCmn+aceYamx8UAdt5/xRZmvOmJYEfC0zBY1ZWcA5tEzdEhZ5j7d8o7bWNH2NA8sUo
        YkE6Cbi03PjX3fIHmJhS8f3U99tu8KHZhlLNts350po53jmEkDYzp0LRUH7Z9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649408952;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XZfOORXOceXGeCyxCEY73gG4PbmKJjXmHrYNPDbmj5k=;
        b=55quWZZT1JIN5qUFBfnOfXXFJt8iOybJou4eaJOBOsOj+RtkVunHwUnjkdDmM8XuNYVFyT
        YY7M7q3rXoLhVbDw==
From:   "tip-bot2 for Brijesh Singh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/mm: Extend cc_attr to include AMD SEV-SNP
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220307213356.2797205-10-brijesh.singh@amd.com>
References: <20220307213356.2797205-10-brijesh.singh@amd.com>
MIME-Version: 1.0
Message-ID: <164940895162.389.18126300040300189146.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     f742b90e61bb53b27771f64bdae05db03a6ab1f2
Gitweb:        https://git.kernel.org/tip/f742b90e61bb53b27771f64bdae05db03a6ab1f2
Author:        Brijesh Singh <brijesh.singh@amd.com>
AuthorDate:    Thu, 24 Feb 2022 10:55:49 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 06 Apr 2022 13:02:34 +02:00

x86/mm: Extend cc_attr to include AMD SEV-SNP

The CC_ATTR_GUEST_SEV_SNP can be used by the guest to query whether the
SNP (Secure Nested Paging) feature is active.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220307213356.2797205-10-brijesh.singh@amd.com
---
 arch/x86/coco/core.c             | 3 +++
 arch/x86/include/asm/msr-index.h | 2 ++
 arch/x86/mm/mem_encrypt.c        | 4 ++++
 include/linux/cc_platform.h      | 8 ++++++++
 4 files changed, 17 insertions(+)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index fc1365d..dafd488 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -57,6 +57,9 @@ static bool amd_cc_platform_has(enum cc_attr attr)
 		return (sev_status & MSR_AMD64_SEV_ENABLED) &&
 			!(sev_status & MSR_AMD64_SEV_ES_ENABLED);
 
+	case CC_ATTR_GUEST_SEV_SNP:
+		return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
+
 	default:
 		return false;
 	}
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 0eb90d2..ef96f16 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -502,8 +502,10 @@
 #define MSR_AMD64_SEV			0xc0010131
 #define MSR_AMD64_SEV_ENABLED_BIT	0
 #define MSR_AMD64_SEV_ES_ENABLED_BIT	1
+#define MSR_AMD64_SEV_SNP_ENABLED_BIT	2
 #define MSR_AMD64_SEV_ENABLED		BIT_ULL(MSR_AMD64_SEV_ENABLED_BIT)
 #define MSR_AMD64_SEV_ES_ENABLED	BIT_ULL(MSR_AMD64_SEV_ES_ENABLED_BIT)
+#define MSR_AMD64_SEV_SNP_ENABLED	BIT_ULL(MSR_AMD64_SEV_SNP_ENABLED_BIT)
 
 #define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
 
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 50d2099..f85868c 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -62,6 +62,10 @@ static void print_mem_encrypt_feature_info(void)
 	if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
 		pr_cont(" SEV-ES");
 
+	/* Secure Nested Paging */
+	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		pr_cont(" SEV-SNP");
+
 	pr_cont("\n");
 }
 
diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
index efd8205..d08dd65 100644
--- a/include/linux/cc_platform.h
+++ b/include/linux/cc_platform.h
@@ -72,6 +72,14 @@ enum cc_attr {
 	 * Examples include TDX guest & SEV.
 	 */
 	CC_ATTR_GUEST_UNROLL_STRING_IO,
+
+	/**
+	 * @CC_ATTR_SEV_SNP: Guest SNP is active.
+	 *
+	 * The platform/OS is running as a guest/virtual machine and actively
+	 * using AMD SEV-SNP features.
+	 */
+	CC_ATTR_GUEST_SEV_SNP,
 };
 
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
