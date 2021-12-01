Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F584653A2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 18:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351796AbhLARJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 12:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351748AbhLARIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 12:08:43 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52D3C061758
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 09:05:10 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id v17-20020adfedd1000000b0017c5e737b02so4467238wro.18
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 09:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HbFxjGh3zL5KJap6QW7mkZZ6VIZaiwXKEnlk6BAwVfU=;
        b=JtzM0gEDraZHkDaYQXTg0ZV8V0cXC3mNBHZ97J5W0AM9joQ+Tu6jEW6c3fBIQkM6Ib
         GwAR01pqvQylN5LeKRH5Q7RYcav9puXAvqGGEcceHhNVJtu2fZHSGJ5I0rAaGQRSIYb2
         um0QpT9MkVgcbMmR6Fe5Gy1YhwIaojgSu8kpYp6Fc99EcuSk/ZUsB6cbr7CyUb/dupU5
         Gz5vsL1JQx95KAsJyQQyYmsRFPNuLYANb7uJyyiLv4lMWxabM0Cwl9zjdJN6qvIeviEy
         3CnwNybnqLkVpaWiFzwQXR0drk5xVz195jgBHNzbI5LpKat6JDQIqFPJtbQdyW+JwiqW
         0uQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HbFxjGh3zL5KJap6QW7mkZZ6VIZaiwXKEnlk6BAwVfU=;
        b=qECDlvrWUWMPskOIQN9alc6m9jlFMq9LQnh8GgaVs4IThSUkXqpOTXrtXEDQUPh97V
         Qcmhgg1aAEf1oQhRtbjJxQNAgDurvs3iHHpbuHwMd7d6Rvxkmk66XUMUpPZFFAZ0oMsV
         7Ct4LdjMlhOT6yTqimC/hlVR8WA6RlELAGPfB3ZuyJs/zjaSoVa3o1OApKSTRY52zqhp
         MoHtBZa0Fr8LNWYmcFNiZFdz6krLPPqpTcgph492su2xfkEcjfEb7S3G//6PeG9K5A4g
         vU6/0/EvtOfw4AbWvXWbemi5CIjK6miDvJfg8CKIeEFYNIEHoCfujMj4H7rZXBjZqGcq
         Lnnw==
X-Gm-Message-State: AOAM532UBg1YCMPs5HP4w0oH7SyRALM1I9f8P1qTC4KZULKJeOser/SY
        TMDQMoqBu4W9uM8UWr9rm6tdke3nHqWs
X-Google-Smtp-Source: ABdhPJwxaQUpa6nGrPntWg01UvZg5ANqj35b7DgPpex7mqDVaKYEMPj2lT/WlosMtvdaA5BJp8zHD3MNtwZE
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:1cab:1a20:2ef1:ddde])
 (user=qperret job=sendgmr) by 2002:a5d:508d:: with SMTP id
 a13mr8350562wrt.41.1638378309381; Wed, 01 Dec 2021 09:05:09 -0800 (PST)
Date:   Wed,  1 Dec 2021 17:04:08 +0000
In-Reply-To: <20211201170411.1561936-1-qperret@google.com>
Message-Id: <20211201170411.1561936-15-qperret@google.com>
Mime-Version: 1.0
References: <20211201170411.1561936-1-qperret@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 14/15] KVM: arm64: Expose unshare hypercall to the host
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
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
index 43b25e2de780..640234d3896a 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -768,3 +768,36 @@ int __pkvm_host_share_hyp(u64 pfn)
 
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
+		.prot	= PAGE_HYP,
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
2.34.0.rc2.393.gf8c9666880-goog

