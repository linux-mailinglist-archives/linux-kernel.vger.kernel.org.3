Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5B2509242
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 23:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382077AbiDTVqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 17:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241443AbiDTVqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 17:46:17 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8B33DDC6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 14:43:29 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f16f3a7c34so26806187b3.17
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 14:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:cc;
        bh=+ofVstgby+3VUZOCrqyBENIw0S2XGlsTcYhm1RZdUZ8=;
        b=V7/nRf1aqIhn3GrpHT/lkZMBo6WJCgvRWtI4hC60Tae7j51kV7NX/30fPVFIT1ZkRi
         UKsROxDen1kXaLPU9eDlOYdcjYnozYuA1MnCV5aibXYS3U3bKc+BUjEJwkVwRxaK3hCB
         GGSVcC3uywSpPEm1PDWOTeFyI7qJnBk/oLORu10hqRdBr9k0nt570qWwaznIFNr2gmiw
         8XjMBScKKSOI1Y+1Y77BNZ7MLZTkTJ13fqOIjHBAd6Rfx4XFYzh/TGqiQ6vNll2ZiYoS
         WRm5geb+q+v1x1QVSZEjNHe3dtSRAg2v4RqdKtcocsQgYo32gQqVgraqx9QT36kUhGkB
         Rg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=+ofVstgby+3VUZOCrqyBENIw0S2XGlsTcYhm1RZdUZ8=;
        b=Pm5ZQ6begRf0/rddJtfshkxiJ4SdRThDT2CUy8gwxAKAngY4nuuYE6JBXaAva7xSgU
         fUYSCw9quZNI1ywxtVPXEzck5vp2KctqF314yU+a10oGKQrLsq9P7WiPtOgkZpE4FW8V
         +m95h0z1ui6wr/owsB345937Xt5dyFBuyLa3C7viGo7YPX9U9uQuI+QjVC8AgsFNm+db
         vzDyFm0hTc8jRNgzXeOT3sjqS8DGDXt+W0LfX92NmiAOjudaGb8Dt146QemF5bKiSYsF
         UbnPRvnJd3Z4Y2UuiuRAhJ8ua+ds4phnR4X9dpCO5iSYEaXDJIp9VFN9T5CQc+GT4uN3
         7bDA==
X-Gm-Message-State: AOAM531BgJQ205mJ3OF+ngwYs6rz/xfSkHII3IZ5Aylejlq+3jEuDFki
        MJbK9uAfXKfUw6rD9UNGxsvQbEGkYqA2zh61ow==
X-Google-Smtp-Source: ABdhPJynQJ6HrTNIms4xwX26QBfSuJVgQPazfDGqbIdwuqV/+SEBOChc4CyWeC3dRM3VwPtqGh5RY3jW3hVs31ZLaw==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:2a20:cec4:8f41:cd6f])
 (user=kaleshsingh job=sendgmr) by 2002:a81:478b:0:b0:2ea:da8c:5c21 with SMTP
 id u133-20020a81478b000000b002eada8c5c21mr23887312ywa.189.1650491008962; Wed,
 20 Apr 2022 14:43:28 -0700 (PDT)
Date:   Wed, 20 Apr 2022 14:42:51 -0700
Message-Id: <20220420214317.3303360-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH v8 0/6] KVM: arm64: Hypervisor stack enhancements
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     will@kernel.org, maz@kernel.org, qperret@google.com,
        tabba@google.com, surenb@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is v8 of the nVHE hypervisor stack enhancements. This version is based
on 5.18-rc3.

Previous versions can be found at: 
v7: https://lore.kernel.org/r/20220408200349.1529080-1-kaleshsingh@google.com/
v6: https://lore.kernel.org/r/20220314200148.2695206-1-kaleshsingh@google.com/
v5: https://lore.kernel.org/r/20220307184935.1704614-1-kaleshsingh@google.com/
v4: https://lore.kernel.org/r/20220225033548.1912117-1-kaleshsingh@google.com/
v3: https://lore.kernel.org/r/20220224051439.640768-1-kaleshsingh@google.com/
v2: https://lore.kernel.org/r/20220222165212.2005066-1-kaleshsingh@google.com/
v1: https://lore.kernel.org/r/20220210224220.4076151-1-kaleshsingh@google.com/

Thanks,
Kalesh

-----

This series is based on 5.18-rc3 and adds stack guard pages to nVHE and pKVM
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
 arch/arm64/include/asm/kvm_mmu.h     |  3 ++
 arch/arm64/kvm/arm.c                 | 37 +++++++++++--
 arch/arm64/kvm/handle_exit.c         | 13 ++---
 arch/arm64/kvm/hyp/include/nvhe/mm.h |  6 ++-
 arch/arm64/kvm/hyp/nvhe/host.S       | 24 +++++++++
 arch/arm64/kvm/hyp/nvhe/hyp-main.c   | 18 ++++++-
 arch/arm64/kvm/hyp/nvhe/mm.c         | 78 ++++++++++++++++++----------
 arch/arm64/kvm/hyp/nvhe/setup.c      | 31 +++++++++--
 arch/arm64/kvm/hyp/nvhe/switch.c     |  7 ++-
 arch/arm64/kvm/mmu.c                 | 68 ++++++++++++++++--------
 scripts/kallsyms.c                   |  3 +-
 12 files changed, 220 insertions(+), 69 deletions(-)


base-commit: b2d229d4ddb17db541098b83524d901257e93845
-- 
2.36.0.rc0.470.gd361397f0d-goog

