Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F88A5155A2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380731AbiD2UcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380708AbiD2UcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:32:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19DAD5EA5;
        Fri, 29 Apr 2022 13:28:50 -0700 (PDT)
Date:   Fri, 29 Apr 2022 20:28:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651264129;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UW7K9N3A3auzYpRLwTp+c3IV2cf0c6gZLPYYx8hXS9s=;
        b=u36OGIG+Cq/IUfL9YHrSaCABD2b0EmQXlAW+OHbWijM2MYVnlFZJd4M0mg4w93vwUYuZHW
        zjltlO4l3MCqTAkNPivlnexfO2fTEBsDPsrT806rTQ8HxogpTsWWFKjg5cBnjcBGP1KBZD
        azY6MQSqZvLUQEG+aoV4FNINFYWIk5ZVQklnxrZpvTzRdCjQjtXCY5lW0qTcDMpxK5SS2+
        um2gLp+I7x+xTCcIyYqNKdcp5pAYXUvpgt9SfzJ02GZ176di7pPypuEmOOg2v/MIZe83nG
        rrhYuQHEPFl6ZHEWDDI7V04aBtPEkkuiOh6mEvydRwmj8KkKXP7OHXOGpv578A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651264129;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UW7K9N3A3auzYpRLwTp+c3IV2cf0c6gZLPYYx8hXS9s=;
        b=NSeo9lGTTEjR2OwRI/pGzg3AwhJufXsat0tDdZGfwsm2g0GhcN27mw1NPEM1vUwsh/o7jB
        VvJJ4M6uYS+Y3jBw==
From:   "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] kvm: x86/cpuid: Fix CPUID leaf 0xA
Cc:     Vasant Hegde <vasant.hegde@amd.com>,
        Sandipan Das <sandipan.das@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C54bc7fe4cadf6bdef823bab1fba43d4891d2e1a9=2E16505?=
 =?utf-8?q?15382=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C54bc7fe4cadf6bdef823bab1fba43d4891d2e1a9=2E165051?=
 =?utf-8?q?5382=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165126412838.4207.9648561218200979307.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     fafd15ab6dc1fdfff66908e6d9231b124e1875cf
Gitweb:        https://git.kernel.org/tip/fafd15ab6dc1fdfff66908e6d9231b124e1875cf
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Thu, 21 Apr 2022 11:16:59 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 29 Apr 2022 11:06:27 +02:00

kvm: x86/cpuid: Fix CPUID leaf 0xA

On some x86 processors, CPUID leaf 0xA provides information
on Architectural Performance Monitoring features. It
advertises a PMU version which Qemu uses to determine the
availability of additional MSRs to manage the PMCs.

Upon receiving a KVM_GET_SUPPORTED_CPUID ioctl request for
the same, the kernel constructs return values based on the
x86_pmu_capability irrespective of the vendor.

This leaf and the additional MSRs are not supported on AMD
processors. If PerfMonV2 is detected, the PMU version is
set to 2 and guest startup breaks because of an attempt to
access a non-existent MSR. Return zeros to avoid this.

Fixes: a6c06ed1a60a ("KVM: Expose the architectural performance monitoring CPUID leaf")
Reported-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/54bc7fe4cadf6bdef823bab1fba43d4891d2e1a9.1650515382.git.sandipan.das@amd.com
---
 arch/x86/kvm/cpuid.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index b24ca7f..ae1d963 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -887,6 +887,12 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		union cpuid10_eax eax;
 		union cpuid10_edx edx;
 
+		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+		    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
+			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
+			break;
+		}
+
 		perf_get_x86_pmu_capability(&cap);
 
 		/*
