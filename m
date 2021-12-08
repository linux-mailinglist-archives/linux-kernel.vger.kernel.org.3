Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC0C46D6E2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 16:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235967AbhLHP0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 10:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235961AbhLHP0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 10:26:42 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5083DC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 07:23:10 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id j71-20020a1c234a000000b00342f418ae7cso3185061wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 07:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WFv2lXz9eCHT3yd+CF6ElCbrsux6py5SHwDqlqAaTn4=;
        b=ZDiX6clEZwsCO576ptI4p+U8abQdk4d/G9Oef955pfW4K0FAUmdqldx2WNOMkcw9ak
         5qSvscHuqPi9DAOEf9QVnnWjJ0eeoJurD1kc1Ea5jfSWXTNnLJWLVDBU6AJOV7sIIG8/
         Pj1j4AYMPQGGlZR/X4DymKwUQpNV1Upw0xVjLfOPKCa+hA/UhqGSyjcFm2+Act+iJqI5
         GSAuAGgG5gFc8GwslklSGNlNKa08cXanws+vPcdHC51+MWHmwmFsAbRHed6kq+FwtS8Q
         SRgV/L9TyhcBHOZLXurecAnFAJEuOgoccyWzRd6O1ChhBQV/YHcSQeEYlhC+TfRaL5Je
         kYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WFv2lXz9eCHT3yd+CF6ElCbrsux6py5SHwDqlqAaTn4=;
        b=zgf8WGWQMJUrry3FNYGSNss5LuyQqMaDQqtqpZEJs/QBzLFsNhgy4oa7C3U61XuP31
         bbu6Im08RqfJkyS5k4qdlzPXg7b5f7tPGwyHPsA/g9iyzv1vVKJ+d6vGNW7bsVEpobeC
         i3vCS6V29Tvpcr+HPbsUPMu3nnEg9u3NRYEZvd0Mz8jqcM8oogs8OhJ3ayR7ameRL8LY
         qeFUJLqojhBHV/dqnFj+HWkpy/m3akBntkhMlsHwDm7N51J1UIillx0r3PyU/xd1Cz1N
         02eR9YK9KJ8kGeFYnx0aEgTPbv5JJzzgG7R0/zx1thOuKdjIhnPND3dgejlUIt2dZj2v
         ixag==
X-Gm-Message-State: AOAM531O49PP0wiZ434uMH3/tlIN3p2mTpVOPtTyXSuO9vCSY3mfUi2G
        OC9JR7T3+Dzj9nMLZOjT+v0eP+5lfi+N
X-Google-Smtp-Source: ABdhPJxSs8eDEFE+1XbumupLfjxLtoH5gK9ACn6/1cAzmR58bQj+dtBX/daKqvo9wufYXRpz+sc7M4xxqTKl
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:c718:14b8:982a:57d5])
 (user=qperret job=sendgmr) by 2002:a05:600c:1c1a:: with SMTP id
 j26mr17342732wms.28.1638976988812; Wed, 08 Dec 2021 07:23:08 -0800 (PST)
Date:   Wed,  8 Dec 2021 15:22:55 +0000
In-Reply-To: <20211208152300.2478542-1-qperret@google.com>
Message-Id: <20211208152300.2478542-3-qperret@google.com>
Mime-Version: 1.0
References: <20211208152300.2478542-1-qperret@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH 2/6] KVM: arm64: pkvm: Disable GICv2 support
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GICv2 requires having device mappings in guests and the hypervisor,
which is incompatible with the current pKVM EL2 page ownership model
which only covers memory. While it would be desirable to support pKVM
with GICv2, this will require a lot more work, so let's make the
current assumption clear until then.

Co-developed-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/vgic/vgic-v2.c | 5 +++++
 arch/arm64/kvm/vgic/vgic-v3.c | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/vgic/vgic-v2.c b/arch/arm64/kvm/vgic/vgic-v2.c
index 95a18cec14a3..8e337a0d7817 100644
--- a/arch/arm64/kvm/vgic/vgic-v2.c
+++ b/arch/arm64/kvm/vgic/vgic-v2.c
@@ -345,6 +345,11 @@ int vgic_v2_probe(const struct gic_kvm_info *info)
 	int ret;
 	u32 vtr;
 
+	if (is_protected_kvm_enabled()) {
+		kvm_err("GICv2 not supported in protected mode\n");
+		return -ENXIO;
+	}
+
 	if (!info->vctrl.start) {
 		kvm_err("GICH not present in the firmware table\n");
 		return -ENXIO;
diff --git a/arch/arm64/kvm/vgic/vgic-v3.c b/arch/arm64/kvm/vgic/vgic-v3.c
index 04f62c4b07fb..debad4e6e6c9 100644
--- a/arch/arm64/kvm/vgic/vgic-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-v3.c
@@ -651,7 +651,7 @@ int vgic_v3_probe(const struct gic_kvm_info *info)
 	} else if (!PAGE_ALIGNED(info->vcpu.start)) {
 		pr_warn("GICV physical address 0x%llx not page aligned\n",
 			(unsigned long long)info->vcpu.start);
-	} else {
+	} else if (kvm_get_mode() != KVM_MODE_PROTECTED) {
 		kvm_vgic_global_state.vcpu_base = info->vcpu.start;
 		kvm_vgic_global_state.can_emulate_gicv2 = true;
 		ret = kvm_register_vgic_device(KVM_DEV_TYPE_ARM_VGIC_V2);
-- 
2.34.1.400.ga245620fadb-goog

