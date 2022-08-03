Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3452589489
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 00:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238135AbiHCWuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 18:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiHCWuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 18:50:03 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A2B22B29
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 15:50:02 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id i9-20020a170902cf0900b0016d1e277547so11206197plg.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 15:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:reply-to:from:to:cc;
        bh=iEzoP/rzV++W5PuQTMr3p4g6UHkwxev9hZqYhDsH6KM=;
        b=fg0NieWPjppblCtDTg4aMqdocCfyzqxgG9lCZtICe/JTQk93ItMtHMyUv+ZYutbgoW
         R5VAlz0yoTISOD7oHNjX16xPpkkENt7PCxIU+HvKudOgylzd+jRyoSC/SWQbBfhagTLm
         w9pnlLHaZHHosa0LiAFOzGoMG74SdF0zGPA8OFrZciu4CSl7tgppVpAoYSLhMIQsjBeO
         Hz7JDdiiKhrOFnZ1E9QxOnXzYFSKSv4rG09pIcDf//pK4SJVdtVN7ekBQG6eJqbj/ouV
         61t0NU55auFycc0z/bZeFVXFyDLr8fWa/3bMggIEIJhzNzr9LFawkjdWKkqE/N4yR8+y
         aBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:reply-to
         :x-gm-message-state:from:to:cc;
        bh=iEzoP/rzV++W5PuQTMr3p4g6UHkwxev9hZqYhDsH6KM=;
        b=dplRWElHdkxHVjmw1904mKAOWKHqWBO9sb+KtwUydWBjjBc9kFjP6yWfkXMdiI8y4C
         smjh0juxniR+BKTWsHwu23fbjm4DVZ3CxMA8uGKznTdp9fXYkO8+hz6Km3olYhr6867B
         K7Df3bmt2ANeQRBJ/KWEoiQHNKFBQXClcS6JTz7itVgq/dKWveZocCNw71ToF16739kd
         h2wFRYrsh9DGWJuvopHHK23vSrFvZUrocL4cDi6wfD5Y74+Tl06/MbFeKJOP5TC/X4Xi
         xaNNXPPOgnZlw3/iLtQ+wNdLxGD7D+xgXiW9+MXWJnOStwn4cHhqWlW2R/mv6vKZmShe
         Zzbg==
X-Gm-Message-State: ACgBeo1Mxp9T6s7jR//HuKOWG5yiRpWAb4ZMj6DBXVTCXqcAbaC9JUcM
        ua0a93KyA0zY8meQCYkV9gHFftP9VFg=
X-Google-Smtp-Source: AA6agR6ySTXk29zEprgrEcThxpNov93eCKFnf3IvrbZBrpzjSFBg1a3DNOh7HKzpQ/nk2Yrodg3QktCCgTA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:842:b0:52e:2515:d657 with SMTP id
 q2-20020a056a00084200b0052e2515d657mr5697818pfk.31.1659567001835; Wed, 03 Aug
 2022 15:50:01 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  3 Aug 2022 22:49:54 +0000
Message-Id: <20220803224957.1285926-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v2 0/3] KVM: x86/mmu: MMIO caching bug fixes
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai Huang <kai.huang@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix two bugs I introduced when adding the enable_mmio_caching module param.

Bug #1 is that KVM unintentionally makes disabling caching due to a config
incompatibility "sticky", e.g. disabling caching because there are no
reserved PA bits prevents KVM from enabling when "switching" to an EPT
config (doesn't rely on PA bits) or when SVM adjusts the MMIO masks to
account for C-bit shenanigans (even if MAXPHYADDR=52 and C-bit=51, there
can be reserved PA bits due to the "real" MAXPHYADDR being reduced).

Bug #2 is that KVM doesn't explicitly check that MMIO caching is enabled
when doing SEV-ES setup.  Prior to the module param, MMIO caching was
guaranteed when SEV-ES could be enabled as SEV-ES-capable CPUs effectively
guarantee there will be at least one reserved PA bit (see above).  With
the module param, userspace can explicitly disable MMIO caching, thus
silently breaking SEV-ES.

v2:
 - Collect *-by. [Mike, Kai]
 - Squash patches 3 and 4 together. [Kai]

v1:
 - https://lore.kernel.org/all/20220728221759.3492539-1-seanjc@google.com

Sean Christopherson (3):
  KVM: x86: Tag kvm_mmu_x86_module_init() with __init
  KVM: x86/mmu: Fully re-evaluate MMIO caching when SPTE masks change
  KVM: SVM: Disable SEV-ES support if MMIO caching is disable

 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/mmu.h              |  2 ++
 arch/x86/kvm/mmu/mmu.c          |  6 +++++-
 arch/x86/kvm/mmu/spte.c         | 20 ++++++++++++++++++++
 arch/x86/kvm/mmu/spte.h         |  3 +--
 arch/x86/kvm/svm/sev.c          | 10 ++++++++++
 arch/x86/kvm/svm/svm.c          |  9 ++++++---
 7 files changed, 45 insertions(+), 7 deletions(-)


base-commit: 93472b79715378a2386598d6632c654a2223267b
-- 
2.37.1.559.g78731f0fdb-goog

