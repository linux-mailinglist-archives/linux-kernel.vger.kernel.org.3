Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0FF4F9DE6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 22:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238217AbiDHUGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 16:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiDHUF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 16:05:59 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368CC39689
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 13:03:55 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id y7-20020a62ce07000000b005058f370a08so409804pfg.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 13:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:cc;
        bh=uL4T8x7PjGlhNU0AUZ082p/RK2qsDuZaw90ql6pSgAk=;
        b=OVGsPQrYXwHuNe31ITOhye0y5tdZdj03XTVkCx5cOcyhrwhRfEDyKUSS1JIVjLaN/o
         XqeiY7Ly5Fd4YffB7xzCjxD+MsinUrXhkz1IX7fbJ7YF7DZo8EhlMIDvzWl16oEAi5Tg
         5GF7VQRqe3GCtryeQKKxcwfbA5cFkUyRL2b2TauXhZGh+Gkt1Q31YZXFgd0l9bDLJMaQ
         /SPTq1Zz+YJuAWJM4LZCaf65GbiCLYw4hygxl3QvtvGA7UUcsg5mrpvZYjihEgGjWbPC
         qUbD6DyMRsBchsR35e+T7yn5MH9/TED3jrkIjqCb4v/veg9ZrDip6Ui6iUFahq+zA8X9
         8s2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=uL4T8x7PjGlhNU0AUZ082p/RK2qsDuZaw90ql6pSgAk=;
        b=UsHFj2/cuKyJ9IjlfOM5YArQEpPakNVhwTcTtF6jjHN8uqhkMxO2vw9cVf5BbGDJQ4
         xKod+PuH1dG6M3CjmyOjzxn5sXci/qNU6GpK17vaXfj+wrLqHPKZamg/eE2aO5dPfdRq
         bpHCUGvU6m0SozPhxxuItJ0R4HS/0u1UfHX3tKFMRAyK8ksMhrkBersbvVjOupbQLpuk
         Os6m5oM58GyqbCK/FTsWoCh82EiuJMfmo9llez+efvOSjcNMIkAiwQ4VrVP1QfOcu7DP
         HM4vdLBKCZtip+iFDHEVvr2toPhBhs+xnrSyUqQRm0MZvvNoycU3IjlH0I9UC4Eg53k4
         ehAA==
X-Gm-Message-State: AOAM533MzK8YVVmopz9cTmXelPy27BOJz/IiyXh+/cnjwvQJ4ZrucApn
        WfoTdBHAa6+kA8yeKtFCnDYCvv8D+KLfRO2YOg==
X-Google-Smtp-Source: ABdhPJyiunI3puMJj1X39Qi2X/Kl8I3Sm0IuMT8hRzbT/V7JmfxVLYcFkeHruDPMJTX5Vy4HLKMcgBC/SSaYRfJ+Bg==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:f0ed:c8a:dab7:ecc2])
 (user=kaleshsingh job=sendgmr) by 2002:a17:903:216:b0:156:1e8d:a81 with SMTP
 id r22-20020a170903021600b001561e8d0a81mr20473765plh.140.1649448234615; Fri,
 08 Apr 2022 13:03:54 -0700 (PDT)
Date:   Fri,  8 Apr 2022 13:03:23 -0700
Message-Id: <20220408200349.1529080-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH v7 0/6] KVM: arm64: Hypervisor stack enhancements
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     will@kernel.org, maz@kernel.org, qperret@google.com,
        tabba@google.com, surenb@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Walbran <qwandor@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Changbin Du <changbin.du@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is v7 of the nVHE hypervisor stack enhancements. This version is based
on 5.18-rc1 and drops the hypervisor stack unwinding and overflow-stack
patches. These require further discussion and will be resent separately.

Previous versions can be found at: 
v6: https://lore.kernel.org/r/20220314200148.2695206-1-kaleshsingh@google.com/
v5: https://lore.kernel.org/r/20220307184935.1704614-1-kaleshsingh@google.com/
v4: https://lore.kernel.org/r/20220225033548.1912117-1-kaleshsingh@google.com/
v3: https://lore.kernel.org/r/20220224051439.640768-1-kaleshsingh@google.com/
v2: https://lore.kernel.org/r/20220222165212.2005066-1-kaleshsingh@google.com/
v1: https://lore.kernel.org/r/20220210224220.4076151-1-kaleshsingh@google.com/

Thanks,
Kalesh

-----

This series is based on 5.18-rc1 and adds stack guard pages to nVHE and pKVM
hypervisor; and symbolization of hypervisor addresses.

The guard page stack overflow detection is based on the technique used by
arm64 VMAP_STACK. i.e. the stack is aligned such that the 'stack shift' bit 
of any valid SP is 1. The 'stack shift' bit can be tested in the exception
entry to detect overflow without corrupting GPRs.

Kalesh Singh (6):
  KVM: arm64: Introduce hyp_alloc_private_va_range()
  KVM: arm64: Introduce pkvm_alloc_private_va_range()
  KVM: arm64: Add guard pages for KVM nVHE hypervisor stack
  KVM: arm64: Add guard pages for pKVM (protected nVHE) hypervisor stack
  KVM: arm64: Detect and handle hypervisor stack overflows
  KVM: arm64: Symbolize the nVHE HYP addresses

 arch/arm64/include/asm/kvm_asm.h     |  1 +
 arch/arm64/include/asm/kvm_mmu.h     |  4 ++
 arch/arm64/kvm/arm.c                 | 39 ++++++++++++--
 arch/arm64/kvm/handle_exit.c         | 13 ++---
 arch/arm64/kvm/hyp/include/nvhe/mm.h |  6 ++-
 arch/arm64/kvm/hyp/nvhe/host.S       | 24 +++++++++
 arch/arm64/kvm/hyp/nvhe/hyp-main.c   | 18 ++++++-
 arch/arm64/kvm/hyp/nvhe/mm.c         | 78 ++++++++++++++++++----------
 arch/arm64/kvm/hyp/nvhe/setup.c      | 31 +++++++++--
 arch/arm64/kvm/hyp/nvhe/switch.c     |  7 ++-
 arch/arm64/kvm/mmu.c                 | 70 ++++++++++++++++---------
 scripts/kallsyms.c                   |  2 +-
 12 files changed, 223 insertions(+), 70 deletions(-)


base-commit: 3123109284176b1532874591f7c81f3837bbdc17
-- 
2.35.1.1178.g4f1659d476-goog

