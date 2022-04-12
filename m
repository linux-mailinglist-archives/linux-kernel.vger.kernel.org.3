Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69A04FDDE3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348537AbiDLL0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 07:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352737AbiDLLZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:25:41 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A6C237E5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:08:27 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ll10so9580533pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y8/JYtLwGTr+r9WhKddIHXBLC5TCTeFp3FTZ8BAk6HA=;
        b=BWQF6hyEhV41fw/Vfjf8js/WHVuO3KDWVkQ8iaSse8fQWRUMxww5Qo6CNykQ17EiqJ
         R9plY4ivF9hhzBQTg1z4+y6mKIq64h787PG2tMSkM21BHRwuDGku3NMVlkP3l2pUgZOr
         0uS52KvkqEcGka6JR8QD5Suprc65T9w/aFdLzxiyKHmZYNHvqkwYPzD3ZC1QXAMSuioi
         oxCseOUn1dQARtF/OdcH0P1WWbsgSOSymXv1WylLOHKcVTOM1K+1+5zNFRKwXh3K8CHw
         P2lU4Oksd7J26mj5hEnZmKUemEGP293GCRcM9Ix94AXPVy8w6j8ZGMy7mTjFDfuo4kOt
         j01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y8/JYtLwGTr+r9WhKddIHXBLC5TCTeFp3FTZ8BAk6HA=;
        b=LD+Zke4kjgkWF+3XE5kCpPUQCsr83gFQnpQxCnKs85pLPfvVLCh72diY15l4LGssRf
         N43jrNMTRMFKAjImHS1FYiY1kX+PL6x+aN1kN5cWnriDqGxBhYR0XoAraPXcAxgKE8C1
         IQPYmdOVNH1LET3miwgRR+F4Egn564QbcusxjpicQCyCGUIcy7djv5E1BP6dSlMae4ol
         BM3ihIQhgUYpvJDb6cscu4OlaJ+n3sU76Nh2WVeupQ9Xoc00b9W1JdxqnYbaRyuz+kWi
         4mzxXR2rE1Syktc7h8ol/MlB8YMLUqs4XhnjHzuCOfGP6fauvlmb7PGuselp+ZJTFoQW
         Rd8g==
X-Gm-Message-State: AOAM530+z9af+Lg5wBuUz2OMgFWqCPEIxYv5aykcrLhFf4Lqk8UuMynC
        lUHZHXIYjA3DxOE5vkgN1G5YzQ==
X-Google-Smtp-Source: ABdhPJz9BsX5BLP589MLDfJnGsKt1qLr3mtq0HfL/T8EgEobf38Mq+9s+26t59TCgZOSJxq3Z6xS9g==
X-Received: by 2002:a17:902:8684:b0:154:af35:82ce with SMTP id g4-20020a170902868400b00154af3582cemr37178055plo.137.1649758106758;
        Tue, 12 Apr 2022 03:08:26 -0700 (PDT)
Received: from localhost.localdomain ([122.182.197.47])
        by smtp.gmail.com with ESMTPSA id j9-20020a056a00130900b004f73df40914sm37515088pfu.82.2022.04.12.03.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 03:08:25 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 0/6] KVM RISC-V Sv57x4 support and HFENCE improvements
Date:   Tue, 12 Apr 2022 15:37:07 +0530
Message-Id: <20220412100713.1415094-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds Sv57x4 support for KVM RISC-V G-stage and various
HFENCE related improvements.

These patches can also be found in riscv_kvm_sv57_plus_v1 branch at:
https://github.com/avpatel/linux.git

Anup Patel (6):
  RISC-V: KVM: Use G-stage name for hypervisor page table
  RISC-V: KVM: Add Sv57x4 mode support for G-stage
  RISC-V: KVM: Treat SBI HFENCE calls as NOPs
  RISC-V: KVM: Introduce range based local HFENCE functions
  RISC-V: KVM: Reduce KVM_MAX_VCPUS value
  RISC-V: KVM: Add remote HFENCE functions based on VCPU requests

 arch/riscv/include/asm/csr.h      |   1 +
 arch/riscv/include/asm/kvm_host.h | 119 ++++++--
 arch/riscv/kvm/main.c             |  11 +-
 arch/riscv/kvm/mmu.c              | 264 ++++++++---------
 arch/riscv/kvm/tlb.S              |  74 -----
 arch/riscv/kvm/tlb.c              | 456 ++++++++++++++++++++++++++++++
 arch/riscv/kvm/vcpu.c             |  34 ++-
 arch/riscv/kvm/vcpu_exit.c        |   6 +-
 arch/riscv/kvm/vcpu_sbi_replace.c |  40 ++-
 arch/riscv/kvm/vcpu_sbi_v01.c     |  35 ++-
 arch/riscv/kvm/vm.c               |   8 +-
 arch/riscv/kvm/vmid.c             |  30 +-
 12 files changed, 791 insertions(+), 287 deletions(-)
 delete mode 100644 arch/riscv/kvm/tlb.S
 create mode 100644 arch/riscv/kvm/tlb.c

-- 
2.25.1

