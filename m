Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED264B69D5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 11:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236749AbiBOKyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 05:54:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235894AbiBOKyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 05:54:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E422ED76D5;
        Tue, 15 Feb 2022 02:54:28 -0800 (PST)
Date:   Tue, 15 Feb 2022 10:54:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644922467;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RkZMy+ERFfrqhETTeWsinoFCBi+ZW4eueVTtslhwASg=;
        b=PLt7lYuXZsYGywadZZ81YS9lsCfvn6XGyNA/xnnoeO0gtDuuwqZ7umBHJKl5TYMWwuJFuS
        +2p7kt/pMCq0kzHMCi5CApI2gcqOOs8xKPsCVqjhwzGKlqA2VXZ/aosNOPXajIZvz6ltD8
        lK9uAyTbaQAP/D2doezdDAs3swwzG29FW69QdY3qMzkxaPry/LB0za30RF2crIxdNEPYGO
        Y9ORyuYijtQTqP9StsVtWszz4am7FDith+a9TX8gt06OoT2j8T85i0+/ZCk/gGplZaChW1
        K7/nzZ05hehglGCEnFP9EJ2f+gEC4m4QmCHvVVVw4zZZz+Dzx18unQzCmvsGwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644922467;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RkZMy+ERFfrqhETTeWsinoFCBi+ZW4eueVTtslhwASg=;
        b=V1YnpLHqdvSJXv66Fad8xBBgUwOoTTt5zOy+nVgZoVsSL/fH/PEvXNKoVgcdJyGPTSnISV
        Jt0lw+a5o0NVtpDQ==
From:   "tip-bot2 for Fenghua Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/pasid] x86/cpufeatures: Re-enable ENQCMD
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220207230254.3342514-10-fenghua.yu@intel.com>
References: <20220207230254.3342514-10-fenghua.yu@intel.com>
MIME-Version: 1.0
Message-ID: <164492246651.16921.17243295814818323213.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/pasid branch of tip:

Commit-ID:     7c1ef59145f1c8bf9a2cc7a6ebf2fd56bbb440de
Gitweb:        https://git.kernel.org/tip/7c1ef59145f1c8bf9a2cc7a6ebf2fd56bbb440de
Author:        Fenghua Yu <fenghua.yu@intel.com>
AuthorDate:    Mon, 07 Feb 2022 15:02:52 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 15 Feb 2022 11:31:43 +01:00

x86/cpufeatures: Re-enable ENQCMD

The ENQCMD feature can only be used if CONFIG_INTEL_IOMMU_SVM is set.
Add X86_FEATURE_ENQCMD to the disabled features mask as appropriate so
that cpu_feature_enabled() can be used to check the feature.

  [ bp: Massage commit message. ]

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20220207230254.3342514-10-fenghua.yu@intel.com
---
 arch/x86/include/asm/disabled-features.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 8f28faf..1231d63 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -56,8 +56,11 @@
 # define DISABLE_PTI		(1 << (X86_FEATURE_PTI & 31))
 #endif
 
-/* Force disable because it's broken beyond repair */
-#define DISABLE_ENQCMD		(1 << (X86_FEATURE_ENQCMD & 31))
+#ifdef CONFIG_INTEL_IOMMU_SVM
+# define DISABLE_ENQCMD		0
+#else
+# define DISABLE_ENQCMD		(1 << (X86_FEATURE_ENQCMD & 31))
+#endif
 
 #ifdef CONFIG_X86_SGX
 # define DISABLE_SGX	0
