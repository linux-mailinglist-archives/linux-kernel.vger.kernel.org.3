Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 275F5488BA3
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 19:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236487AbiAISar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 13:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236473AbiAISap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 13:30:45 -0500
X-Greylist: delayed 394 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 09 Jan 2022 10:30:44 PST
Received: from biche.re (biche.re [IPv6:2607:5300:201:3100::6c88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2559C06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 10:30:44 -0800 (PST)
From:   Victorien Molle <biche@biche.re>
DKIM-Filter: OpenDKIM Filter v2.11.0 biche.re 46FBC40F84
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=biche.re; s=biche;
        t=1641752648; bh=HmvLkz1mVjyAOwxpC8spDiTxpZx+nArauSp2vpV1ec0=;
        h=From:To:Cc:Subject:Date:From;
        b=tYQmiAzQTcNCv7TVJPB6fuahrJxmDXY9zHelOTr/0V0z62ek/RkOsJ0VsT234APEf
         vX9fBgllZtbmCiXfowMItimDkMp6EsYX8B2ABCOsTHR8hk1ZpqdhmE6UEhwe5cDPri
         9YQlio51DXcHO/F9+Y3o42YZrxuQxiotwiJ/W2kRxVPO0IxHOmxm0vdljFbt8fupXP
         YH8Q6dg/7cbKr754Skv0ykaItSgW3BkZkKjsX8W+ZpASc9GaZzHo9sYtwnGugsD2Q7
         R94LrA5xkVI1GrPB/sLMDLFgOoBIssOxvqN7tQtmsfdvwzooed407WrL25Tjhcy7BN
         f1n9nTNGTabZA==
To:     linux-kernel@vger.kernel.org
Cc:     Victorien Molle <biche@biche.re>
Subject: [PATCH] KVM: x86: Add support for basic RAPL (Running Average Power Limit) metrics
Date:   Sun,  9 Jan 2022 19:23:17 +0100
Message-Id: <20220109182317.1075762-1-biche@biche.re>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current KVM code handles two MSR registers,
which are used to store RAPL values:
    - MSR_RAPL_POWER_UNIT
    - MSR_PKG_ENERGY_STATUS

However, these two registers are currently not accessible for writing
and always return 0.
This patch enables the possibility to set these two MSR registers
and get the written values from guest.
It also adds support of the following MSR registers,
used to store RAPL values:
    - MSR_PKG_POWER_LIMIT
    - MSR_AMD_RAPL_POWER_UNIT
    - MSR_AMD_PKG_ENERGY_STATUS

Writing value into one of these MSR registers causes,
if there are multiple vCPUs, the value to be saved for all active vCPUs.

Signed-off-by: Victorien Molle <biche@biche.re>
---
 arch/x86/include/asm/kvm_host.h |  5 +++++
 arch/x86/kvm/vmx/pmu_intel.c    |  3 +++
 arch/x86/kvm/x86.c              | 35 +++++++++++++++++++++++++++++++--
 arch/x86/xen/pmu.c              |  6 ++++++
 4 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 555f4de47ef2..56182daadf88 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -908,6 +908,11 @@ struct kvm_vcpu_arch {
 #if IS_ENABLED(CONFIG_HYPERV)
 	hpa_t hv_root_tdp;
 #endif
+
+	/* RAPL values */
+	u64 power_unit;
+	u64 power_limit;
+	u64 energy_status;
 };
 
 struct kvm_lpage_info {
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 1b7456b2177b..e741f73d35ea 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -217,6 +217,9 @@ static bool intel_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
 	case MSR_CORE_PERF_GLOBAL_STATUS:
 	case MSR_CORE_PERF_GLOBAL_CTRL:
 	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
+	case MSR_RAPL_POWER_UNIT:
+	case MSR_PKG_POWER_LIMIT:
+	case MSR_PKG_ENERGY_STATUS:
 		ret = pmu->version > 1;
 		break;
 	default:
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e50e97ac4408..bc32b87a7989 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1359,6 +1359,9 @@ static const u32 msrs_to_save_all[] = {
 	MSR_F15H_PERF_CTL3, MSR_F15H_PERF_CTL4, MSR_F15H_PERF_CTL5,
 	MSR_F15H_PERF_CTR0, MSR_F15H_PERF_CTR1, MSR_F15H_PERF_CTR2,
 	MSR_F15H_PERF_CTR3, MSR_F15H_PERF_CTR4, MSR_F15H_PERF_CTR5,
+
+	MSR_RAPL_POWER_UNIT, MSR_PKG_POWER_LIMIT, MSR_PKG_ENERGY_STATUS,
+	MSR_AMD_RAPL_POWER_UNIT, MSR_AMD_PKG_ENERGY_STATUS,
 };
 
 static u32 msrs_to_save[ARRAY_SIZE(msrs_to_save_all)];
@@ -3383,6 +3386,7 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	bool pr = false;
+	u16 it = 0;
 	u32 msr = msr_info->index;
 	u64 data = msr_info->data;
 
@@ -3669,6 +3673,23 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			return 1;
 		vcpu->arch.msr_misc_features_enables = data;
 		break;
+	case MSR_RAPL_POWER_UNIT:
+	case MSR_AMD_RAPL_POWER_UNIT:
+		/* Apply the value on all vCPUs */
+		for (; it < vcpu->kvm->created_vcpus; ++it)
+			vcpu->kvm->vcpus[it]->arch.power_unit = data;
+		break;
+	case MSR_PKG_POWER_LIMIT:
+		/* Apply the value on all vCPUs */
+		for (; it < vcpu->kvm->created_vcpus; ++it)
+			vcpu->kvm->vcpus[it]->arch.power_limit = data;
+		break;
+	case MSR_PKG_ENERGY_STATUS:
+	case MSR_AMD_PKG_ENERGY_STATUS:
+		/* Apply the value on all vCPUs */
+		for (; it < vcpu->kvm->created_vcpus; ++it)
+			vcpu->kvm->vcpus[it]->arch.energy_status = data;
+		break;
 	default:
 		if (kvm_pmu_is_valid_msr(vcpu, msr))
 			return kvm_pmu_set_msr(vcpu, msr_info);
@@ -3742,13 +3763,23 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	 * data here. Do not conditionalize this on CPUID, as KVM does not do
 	 * so for existing CPU-specific MSRs.
 	 */
-	case MSR_RAPL_POWER_UNIT:
 	case MSR_PP0_ENERGY_STATUS:	/* Power plane 0 (core) */
 	case MSR_PP1_ENERGY_STATUS:	/* Power plane 1 (graphics uncore) */
-	case MSR_PKG_ENERGY_STATUS:	/* Total package */
 	case MSR_DRAM_ENERGY_STATUS:	/* DRAM controller */
+		kvm_pmu_is_valid_msr(vcpu, msr_info->index);
 		msr_info->data = 0;
 		break;
+	case MSR_RAPL_POWER_UNIT:
+	case MSR_AMD_RAPL_POWER_UNIT:
+		msr_info->data = vcpu->arch.power_unit;
+		break;
+	case MSR_PKG_POWER_LIMIT:
+		msr_info->data = vcpu->arch.power_limit;
+		break;
+	case MSR_PKG_ENERGY_STATUS:	/* Total package */
+	case MSR_AMD_PKG_ENERGY_STATUS:
+		msr_info->data = vcpu->arch.energy_status;
+		break;
 	case MSR_F15H_PERF_CTL0 ... MSR_F15H_PERF_CTR5:
 		if (kvm_pmu_is_valid_msr(vcpu, msr_info->index))
 			return kvm_pmu_get_msr(vcpu, msr_info);
diff --git a/arch/x86/xen/pmu.c b/arch/x86/xen/pmu.c
index e13b0b49fcdf..c3baaa34836b 100644
--- a/arch/x86/xen/pmu.c
+++ b/arch/x86/xen/pmu.c
@@ -157,6 +157,12 @@ static int is_intel_pmu_msr(u32 msr_index, int *type, int *index)
 		*type = MSR_TYPE_GLOBAL;
 		return true;
 
+	case MSR_RAPL_POWER_UNIT:
+	case MSR_PKG_POWER_LIMIT:
+	case MSR_PKG_ENERGY_STATUS:
+		*type = MSR_TYPE_GLOBAL;
+		return true;
+
 	default:
 
 		if ((msr_index >= MSR_CORE_PERF_FIXED_CTR0) &&
-- 
2.34.1

