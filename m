Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813A74A6BF2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 07:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244831AbiBBGx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 01:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244748AbiBBGwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 01:52:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BF8C06176E;
        Tue,  1 Feb 2022 22:31:17 -0800 (PST)
Date:   Wed, 02 Feb 2022 06:31:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643783476;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0emAQ48jRxtzizThS52wvAHsxt+GeSw1t2tSVXHJh78=;
        b=0wPlwQMlRsBQeD5dMtreEyBz8ezQD1KBe/peAaAK/4aKwmXdfg1exGkfw+ayCj8GflmRcX
        IFwD2dy+RKJNkn6f+e5aHbuo30VUVrcTL6dIdnvobxy8X2B4XwXNpuMfNaHrayeQMSPRQD
        +0WD10wNi0a0XmrMwWEmdUBoKMnuh3NJzSVbQXluQumyUFbbdhOMzbEPlsmXs4RYWGUjbD
        iOaIqEHy380c6wV6ePGoNbZsqRqHMInCFCRuIJ1NblqnoZCRe2My8I5DMhHmKLko+FHepw
        n+l7sRiEu33puHFe67rLLh5fCyyWGpwjTSK2TU2aVTT/qFkdMtBlK4VIITqxXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643783476;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0emAQ48jRxtzizThS52wvAHsxt+GeSw1t2tSVXHJh78=;
        b=Llsk0SsfehoDWDjnGmJhWEmOmDaCmHn0EnMavEp0MSRJ2ibPcA8tX5LL/WwUWwAVfh8L0Z
        XEPG7cLFLwJ47BDg==
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: X86_FEATURE_INTEL_PPIN finally has a CPUID bit
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220131230111.2004669-3-tony.luck@intel.com>
References: <20220131230111.2004669-3-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <164378347508.16921.12136876420722891274.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     00a2f23eef7d1fa6c2dfdc613857b84fbf5e2b3b
Gitweb:        https://git.kernel.org/tip/00a2f23eef7d1fa6c2dfdc613857b84fbf5e2b3b
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Mon, 31 Jan 2022 15:01:08 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 01 Feb 2022 16:15:19 +01:00

x86/cpu: X86_FEATURE_INTEL_PPIN finally has a CPUID bit

After nine generations of adding to model specific list of CPUs that
support PPIN (Protected Processor Inventory Number) Intel allocated
a CPUID bit to enumerate the MSRs.

CPUID(EAX=7, ECX=1).EBX bit 0 enumerates presence of MSR_PPIN_CTL and
MSR_PPIN. Add it to the "scattered" CPUID bits and add an entry to the
ppin_cpuids[] x86_match_cpu() array to catch Intel CPUs that implement
it.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220131230111.2004669-3-tony.luck@intel.com
---
 arch/x86/kernel/cpu/common.c    | 1 +
 arch/x86/kernel/cpu/scattered.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index b0bd8a6..0681c69 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -104,6 +104,7 @@ static struct ppin_info {
 
 static const struct x86_cpu_id ppin_cpuids[] = {
 	X86_MATCH_FEATURE(X86_FEATURE_AMD_PPIN, &ppin_info[X86_VENDOR_AMD]),
+	X86_MATCH_FEATURE(X86_FEATURE_INTEL_PPIN, &ppin_info[X86_VENDOR_INTEL]),
 
 	/* Legacy models without CPUID enumeration */
 	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE_X, &ppin_info[X86_VENDOR_INTEL]),
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 21d1f06..4143b1e 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -26,6 +26,7 @@ struct cpuid_bit {
 static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_APERFMPERF,       CPUID_ECX,  0, 0x00000006, 0 },
 	{ X86_FEATURE_EPB,		CPUID_ECX,  3, 0x00000006, 0 },
+	{ X86_FEATURE_INTEL_PPIN,	CPUID_EBX,  0, 0x00000007, 1 },
 	{ X86_FEATURE_CQM_LLC,		CPUID_EDX,  1, 0x0000000f, 0 },
 	{ X86_FEATURE_CQM_OCCUP_LLC,	CPUID_EDX,  0, 0x0000000f, 1 },
 	{ X86_FEATURE_CQM_MBM_TOTAL,	CPUID_EDX,  1, 0x0000000f, 1 },
