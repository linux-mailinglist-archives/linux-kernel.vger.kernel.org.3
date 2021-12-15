Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC91475D1E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244670AbhLOQNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244665AbhLOQNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:13:33 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB368C061401
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:13:32 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id f13-20020adfe90d000000b001a15c110077so1264883wrm.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6/+wRoizJk26BilMAQp8YVWtbQFwSb0j0DewQLtAtvw=;
        b=YkCETberpgbtJKCbv+/WJLC5UGmjRAm0xu/20go38uYx4DnqXRD3iQt18izTdl2Fw/
         5DFvJ8PYcov+6doec4EZ6zTpNayYHI6bERB6CHYZ8lgR21kv55P9Yca6zGITgLW3VvrE
         FlqdjEXrneT3Ve0WstmZPIeufdAWavGUrADrzvA7ZXE5vSW8JLANZ/Tnrr8jRIs+vttg
         r+NB5BRA13r3AHhPyTx2L0t/qBJ0HFTbcPiFMT/Z5I9ZccNPT/yG3NxWVOosMcuE6X5d
         Xviv6fhHYlI4ZrXbFkPmNkxkx33LjzP7wwyF6vmpKwfiYqGlVP3OiSQCcCRUTROkUK79
         XHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6/+wRoizJk26BilMAQp8YVWtbQFwSb0j0DewQLtAtvw=;
        b=24pK2deqFZZ+f9xFeJiDvG/2xSi9DYp5a1YEZRJHbyHAeu2RJBGQiZGPzQrBRKuNuN
         lEOcgSoC5gQgZ1obRYdxJlDWxyr8ZzXQDAtAmK1tk9/3BLaUXSxmNFERiTpIT96o1VFl
         3dchEkYt0/vicz97xO3gSpDfZ3y35XSDhroEb6HJAQlVKaSCD8S/W8pU059SH5bOEwXB
         M3u6IaNnxVijzQ/U6ulBQl+yoFPPNsu91Zckq+R431qDhk5yBvpoNIn99EhZ1jOyntM+
         wQ6gIf/YMcuDdKmOK0YJYgahir7/B8uVWH5679wN0S8tYHkLzt/eNXCXir74kBAgFq1Z
         bH1A==
X-Gm-Message-State: AOAM532b4FGN+k+iusYeB9DdsFH4Iwy8MVfTiSCGQfCG30xgXntyUs4F
        oGGXIudBsHpPzr++jbmZl2GFedlKbyVj
X-Google-Smtp-Source: ABdhPJzawzj3ZP6DaUKhsLUL4YxgOKveJ6VpQUe53oOEQYCA8scUYeX44bkb2dVQtGkQKa5bt9wt5iTBGQ4C
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:fc03:4f5b:4e9b:3ec1])
 (user=qperret job=sendgmr) by 2002:a05:600c:1d1b:: with SMTP id
 l27mr93016wms.1.1639584811018; Wed, 15 Dec 2021 08:13:31 -0800 (PST)
Date:   Wed, 15 Dec 2021 16:12:30 +0000
In-Reply-To: <20211215161232.1480836-1-qperret@google.com>
Message-Id: <20211215161232.1480836-14-qperret@google.com>
Mime-Version: 1.0
References: <20211215161232.1480836-1-qperret@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v4 13/14] KVM: arm64: Expose unshare hypercall to the host
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     qperret@google.com, qwandor@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

Introduce an unshare hypercall which can be used to unmap memory from
the hypervisor stage-1 in nVHE protected mode. This will be useful to
update the EL2 ownership state of pages during guest teardown, and
avoids keeping dangling mappings to unreferenced portions of memory.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_asm.h              |  1 +
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  1 +
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            |  8 +++++
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 33 +++++++++++++++++++
 4 files changed, 43 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 50d5e4de244c..d5b0386ef765 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -63,6 +63,7 @@ enum __kvm_host_smccc_func {
 
 	/* Hypercalls available after pKVM finalisation */
 	__KVM_HOST_SMCCC_FUNC___pkvm_host_share_hyp,
+	__KVM_HOST_SMCCC_FUNC___pkvm_host_unshare_hyp,
 	__KVM_HOST_SMCCC_FUNC___kvm_adjust_pc,
 	__KVM_HOST_SMCCC_FUNC___kvm_vcpu_run,
 	__KVM_HOST_SMCCC_FUNC___kvm_flush_vm_context,
diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index 56445586c755..80e99836eac7 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -55,6 +55,7 @@ extern const u8 pkvm_hyp_id;
 
 int __pkvm_prot_finalize(void);
 int __pkvm_host_share_hyp(u64 pfn);
+int __pkvm_host_unshare_hyp(u64 pfn);
 
 bool addr_is_memory(phys_addr_t phys);
 int host_stage2_idmap_locked(phys_addr_t addr, u64 size, enum kvm_pgtable_prot prot);
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index b096bf009144..5e2197db0d32 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -147,6 +147,13 @@ static void handle___pkvm_host_share_hyp(struct kvm_cpu_context *host_ctxt)
 	cpu_reg(host_ctxt, 1) = __pkvm_host_share_hyp(pfn);
 }
 
+static void handle___pkvm_host_unshare_hyp(struct kvm_cpu_context *host_ctxt)
+{
+	DECLARE_REG(u64, pfn, host_ctxt, 1);
+
+	cpu_reg(host_ctxt, 1) = __pkvm_host_unshare_hyp(pfn);
+}
+
 static void handle___pkvm_create_private_mapping(struct kvm_cpu_context *host_ctxt)
 {
 	DECLARE_REG(phys_addr_t, phys, host_ctxt, 1);
@@ -184,6 +191,7 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__pkvm_prot_finalize),
 
 	HANDLE_FUNC(__pkvm_host_share_hyp),
+	HANDLE_FUNC(__pkvm_host_unshare_hyp),
 	HANDLE_FUNC(__kvm_adjust_pc),
 	HANDLE_FUNC(__kvm_vcpu_run),
 	HANDLE_FUNC(__kvm_flush_vm_context),
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 2b23b2db8d4a..16776d1d6151 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -769,3 +769,36 @@ int __pkvm_host_share_hyp(u64 pfn)
 
 	return ret;
 }
+
+int __pkvm_host_unshare_hyp(u64 pfn)
+{
+	int ret;
+	u64 host_addr = hyp_pfn_to_phys(pfn);
+	u64 hyp_addr = (u64)__hyp_va(host_addr);
+	struct pkvm_mem_share share = {
+		.tx	= {
+			.nr_pages	= 1,
+			.initiator	= {
+				.id	= PKVM_ID_HOST,
+				.addr	= host_addr,
+				.host	= {
+					.completer_addr = hyp_addr,
+				},
+			},
+			.completer	= {
+				.id	= PKVM_ID_HYP,
+			},
+		},
+		.completer_prot	= PAGE_HYP,
+	};
+
+	host_lock_component();
+	hyp_lock_component();
+
+	ret = do_unshare(&share);
+
+	hyp_unlock_component();
+	host_unlock_component();
+
+	return ret;
+}
-- 
2.34.1.173.g76aa8bc2d0-goog

