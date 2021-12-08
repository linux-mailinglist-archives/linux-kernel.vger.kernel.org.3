Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428E646D6E8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 16:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236005AbhLHP0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 10:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235991AbhLHP0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 10:26:48 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372E1C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 07:23:16 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id d18-20020adfe852000000b001985d36817cso477984wrn.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 07:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dgTcer4H5x2V6vg1108kd2kvmSCOK/fdrPt0IEA/yAc=;
        b=OO++pgN0LQkRixb3Sq7Hd5w4QXWKTHU22mu8fVnumx/eTq9CxL7X2F8nL4x04jkISf
         kipUAI4bu44wE9v5DHK56LMB2no0ObvfG7M8kGv5bzcym0vpdnDAJ8Lk4yq+49UtdWo3
         bZ8yP9xdUCTiHdkctcvrwAgccOD0TBjeYFZucZKb836bHeZhaqsMS2NSKTW1g1P7/re0
         9AgPiRniaapcw/g+FhGxeT0goa83px619Dqwd1v+txQWUZTOE5sF8onQT6zmISmitbWL
         81NrTCgrmHgZ5NfFOREPevSqkUNFg6S1AEJOfg+NXVGsl4K9TjJThlPj455oD1dIYaT3
         +3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dgTcer4H5x2V6vg1108kd2kvmSCOK/fdrPt0IEA/yAc=;
        b=MsC49hGqrIkDF+KCRTjQC+5hUbmCLxXYFUFHHoc/R2LHVynfUknVRs1cb4rwinLrZ4
         sXRzUyhfkPBCvuFAWF6tCH6mXoeKK/kDp/FiGFS3HJCImeIV1Txz7/j3TwEjmJ0hyc6G
         0nyEu4NlF8R4WQ5vsqGkYqOuzK7YwnCs9xx4+PDxwfHmrntS8K4GuPPPqiJpPyHo65fm
         //94xWlod9AxBf9f5X+LV4t/xw3ct0akBSGzs3o5P577DJyGKBf9WmW1lmf+tzN2GBvI
         w+xkXTPb13729kuEZIf/D9U8a9IG/qLg1i3v6lpocmlduQ4t2zAwCyJv3s5vOsBK+2Ci
         Czsg==
X-Gm-Message-State: AOAM5303dkM1avB25FWgOltRd+GHIQOehu293797tGN+eeC+opE1uot2
        YENHCuHp4Yc8OPn9j/ny1nzYl4FjA3qq
X-Google-Smtp-Source: ABdhPJzw57yyhlFRsGBdsMP0b1MuPYqG3wH3zEnWZDUhTXBl2eHsIR7+DocFx3KMxHXiRp33Wa8qily/O8bz
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:c718:14b8:982a:57d5])
 (user=qperret job=sendgmr) by 2002:a7b:c407:: with SMTP id
 k7mr16929430wmi.35.1638976994756; Wed, 08 Dec 2021 07:23:14 -0800 (PST)
Date:   Wed,  8 Dec 2021 15:22:57 +0000
In-Reply-To: <20211208152300.2478542-1-qperret@google.com>
Message-Id: <20211208152300.2478542-5-qperret@google.com>
Mime-Version: 1.0
References: <20211208152300.2478542-1-qperret@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH 4/6] KVM: arm64: Make __io_map_base static
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

The __io_map_base variable is used at EL2 to track the end of the
hypervisor's "private" VA range in nVHE protected mode. However it
doesn't need to be used outside of mm.c, so let's make it static to keep
all the hyp VA allocation logic in one place.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/mm.h | 1 -
 arch/arm64/kvm/hyp/nvhe/mm.c         | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mm.h b/arch/arm64/kvm/hyp/include/nvhe/mm.h
index 3f60d6cc5368..2d08510c6cc1 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mm.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mm.h
@@ -12,7 +12,6 @@
 
 extern struct kvm_pgtable pkvm_pgtable;
 extern hyp_spinlock_t pkvm_pgd_lock;
-extern u64 __io_map_base;
 
 int hyp_create_idmap(u32 hyp_va_bits);
 int hyp_map_vectors(void);
diff --git a/arch/arm64/kvm/hyp/nvhe/mm.c b/arch/arm64/kvm/hyp/nvhe/mm.c
index 9e0ff5a700dd..526a7d6fa86f 100644
--- a/arch/arm64/kvm/hyp/nvhe/mm.c
+++ b/arch/arm64/kvm/hyp/nvhe/mm.c
@@ -19,11 +19,12 @@
 
 struct kvm_pgtable pkvm_pgtable;
 hyp_spinlock_t pkvm_pgd_lock;
-u64 __io_map_base;
 
 struct memblock_region hyp_memory[HYP_MEMBLOCK_REGIONS];
 unsigned int hyp_memblock_nr;
 
+static u64 __io_map_base;
+
 static int __pkvm_create_mappings(unsigned long start, unsigned long size,
 				  unsigned long phys, enum kvm_pgtable_prot prot)
 {
-- 
2.34.1.400.ga245620fadb-goog

