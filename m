Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4ACD5086E2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 13:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378005AbiDTL2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 07:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378026AbiDTL1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 07:27:48 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747D0112E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:25:02 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id t4so1357492pgc.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tCU3W9mlxHE4TMqBdkjcyOh2bqsvTjlfmzIF3NGnHvE=;
        b=UfaKu9dbb+wXEjWlLaL6U689AztbKkrzep/TzrQwLKereP5jlihhLW83hYi6pshpQT
         RC4D0gb86EnOjGNFqbJ+nXqRqcan40eCGd5YJ1poRTncgAmmYSx5Uec1das06uEnA80/
         kg5zlVNVqWob2/JwFwTcPHKCf50sEyeSvjMGdtnkAfHSNPolkhmSNWqnGq/4CTjBEGYk
         wYf0srChQ0tX9SB7KjZfNPT+06g3JGsqneDoziL+ZZep2OkoZ/s3RP6yxJrL3M4HsubV
         /GT1J/EpY3X6v59ZDCMStoygEgUkaFACI9IDAbD/eRKH1tvUvLRvXeYwkcwrcbXndXZ0
         39tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tCU3W9mlxHE4TMqBdkjcyOh2bqsvTjlfmzIF3NGnHvE=;
        b=vMUw0mOLdMVtYQLDRQ+bo6rbTtFykAcLgBj7okfLfLm4bo/4CBoKwELHpWgic4gCO+
         HF/E8D4oLnh0+aHavrqP1u2F9uV7+4H3oR1biF6Y/CX3t2v6Hud0mdoRVvExPwHO2w8f
         H4ipjLRekTz/iopXSb06BELwK2tvBRhncHvLWY73U1jtlWMpy54ZJnBj3EwBLa3tU0+6
         W6LGuWsUri7PHKShcBg+wH7YxJFxEJQF1RG/C89AHg5ud9UzMG86LX99izJQOppIQAMb
         EU/c0x9gnlRLvQhbKNv/4QEv/QKAymuDVqqh8V8FHi4+tMUS9XZTXPwgVF2ka2/FtDpv
         fn6g==
X-Gm-Message-State: AOAM533qVA3CBJ2tfhcYOqXT1G+n8IxX2e0QB8ZpV2WkXwV8KR8uaXxv
        6ysWl1aiK2BpR9bXLl6F0y0unn47HGMw6A==
X-Google-Smtp-Source: ABdhPJwWY6A6dVQh0vaMFD3tyaT0I/WyyNN+KyeBTF4LfaCmGbkpzDGXOOHqQQgY5qQgYEDIoTN2kQ==
X-Received: by 2002:a05:6a00:a94:b0:4fd:c14b:21cb with SMTP id b20-20020a056a000a9400b004fdc14b21cbmr22660388pfl.53.1650453901951;
        Wed, 20 Apr 2022 04:25:01 -0700 (PDT)
Received: from localhost.localdomain ([122.167.88.101])
        by smtp.gmail.com with ESMTPSA id u12-20020a17090a890c00b001b8efcf8e48sm22529274pjn.14.2022.04.20.04.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 04:25:01 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v2 0/7] KVM RISC-V Sv57x4 support and HFENCE improvements
Date:   Wed, 20 Apr 2022 16:54:43 +0530
Message-Id: <20220420112450.155624-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds Sv57x4 support for KVM RISC-V G-stage and various
HFENCE related improvements.

These patches can also be found in riscv_kvm_sv57_plus_v2 branch at:
https://github.com/avpatel/linux.git

Changes since v1:
 - Rebased on Linux-5.18-rc3
 - Drop gstage_tlb_pgsize_bitmap and hfence_update_order() from PATCH4
   because software is not required to know to page sizes supported by
   TLB. In fact, it is responsibility of hardware implementation to
   ensure that S/HFENCE on an address X invalidates all TLB entries
   created for PTE covering address X.
 - Added PATCH7 to cleanup stale TLB entries when VCPU is moved another
   host CPU

Anup Patel (7):
  RISC-V: KVM: Use G-stage name for hypervisor page table
  RISC-V: KVM: Add Sv57x4 mode support for G-stage
  RISC-V: KVM: Treat SBI HFENCE calls as NOPs
  RISC-V: KVM: Introduce range based local HFENCE functions
  RISC-V: KVM: Reduce KVM_MAX_VCPUS value
  RISC-V: KVM: Add remote HFENCE functions based on VCPU requests
  RISC-V: KVM: Cleanup stale TLB entries when host CPU changes

 arch/riscv/include/asm/csr.h      |   1 +
 arch/riscv/include/asm/kvm_host.h | 124 ++++++--
 arch/riscv/kvm/main.c             |  11 +-
 arch/riscv/kvm/mmu.c              | 264 +++++++++--------
 arch/riscv/kvm/tlb.S              |  74 -----
 arch/riscv/kvm/tlb.c              | 461 ++++++++++++++++++++++++++++++
 arch/riscv/kvm/vcpu.c             |  45 ++-
 arch/riscv/kvm/vcpu_exit.c        |   6 +-
 arch/riscv/kvm/vcpu_sbi_replace.c |  40 ++-
 arch/riscv/kvm/vcpu_sbi_v01.c     |  35 ++-
 arch/riscv/kvm/vm.c               |   8 +-
 arch/riscv/kvm/vmid.c             |  30 +-
 12 files changed, 812 insertions(+), 287 deletions(-)
 delete mode 100644 arch/riscv/kvm/tlb.S
 create mode 100644 arch/riscv/kvm/tlb.c

-- 
2.25.1

