Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397DA494A65
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 10:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236736AbiATJKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 04:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240273AbiATJKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 04:10:22 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A506C06173F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 01:10:22 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id c3-20020a9d6c83000000b00590b9c8819aso6742666otr.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 01:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fHsT6WU5wb4MziMiJ3VGwy7dqSevPYGSnNhHfaodUms=;
        b=I5rb+NhYWFZ7Fzmy4flOQ8JZzx+qkh3oGptms1l/cTcefFRXfaBwLWITtx4Byx6Whj
         c/YVvpk0L5G+H3vyJPrx8jVP+ZTJ7EAhN3tWmci2QjwYLCzFL1O0M4U0asae5Ts0u0TZ
         ofkFTCZ3K8gHZAG+0s5yGWgPvp/o73Dp5IWKHQ7oYi/smVo+lL5z/yYtazFEJcu6ltQ5
         dm8wqAwwULQYDxo41IgEne4/wRAhyLMauLPI5HR2HraUnOBNyB6BOYjl4TyMSjqHRq2/
         9I8eNu3irQkccsdtqaLuUaEVcnVLug0TWL1TGj9JegF1raF2izRIdtfOSUntczRoYEGt
         vgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fHsT6WU5wb4MziMiJ3VGwy7dqSevPYGSnNhHfaodUms=;
        b=lnL2vy4Yt43upTGghJ4BmdWq6P8PH70vIXcRvbl0jQEi7ZsuIGY2PYdXYBxUhd2Y+a
         8cMRIci5zX5AeP/UNn61NU6XBO1qwDVDW02OAxEMdD1vMWx8kqZEdwjcxSYEVIlFSFfX
         1f90iSLfz2qyrq+TPWz4RhHWELu4pc1zHyCq0eJc84mpz9jHnB39eGqOI34pUTQUyxVq
         rwKm54u6A5SscSqwuvbSOZ8DzPWYgG/4Ei6UB7jLxlldru45jk3CHXNxLshavNbqO2eg
         YnEHNt8E6TcCZpCd/7u0GfakR/q4iJ+Rh9pZGhTjFwZGzGnf//GEEdxbwk18KXRVuI+A
         nwlA==
X-Gm-Message-State: AOAM530n33OhVv8HEzldgCyPkCVP2hPBytrzH1bmRs428fNG5q+7oyAj
        RymwhpRxuuZRy6KUBrBaihdLZ/Z1YhQNRg==
X-Google-Smtp-Source: ABdhPJz+hTMueXdXEZpcJ7Njw3ByUf9uV+Yqx5G/hZgLqP+6hxIUvAJj2dSHEr9rdNtBn9B5Vuxq/w==
X-Received: by 2002:a05:6830:1389:: with SMTP id d9mr23071815otq.114.1642669821318;
        Thu, 20 Jan 2022 01:10:21 -0800 (PST)
Received: from rivos-atish.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id i12sm944766oot.25.2022.01.20.01.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 01:10:20 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 0/6] Sparse HART id support 
Date:   Thu, 20 Jan 2022 01:09:12 -0800
Message-Id: <20220120090918.2646626-1-atishp@rivosinc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, sparse hartid is not supported for Linux RISC-V for the following
reasons.
1. Both spinwait and ordered booting method uses __cpu_up_stack/task_pointer
   which is an array size of NR_CPUs.
2. During early booting, any hartid greater than NR_CPUs are not booted at all.
3. riscv_cpuid_to_hartid_mask uses struct cpumask for generating hartid bitmap.
4. SBI v0.2 implementation uses NR_CPUs as the maximum hartid number while
   generating hartmask.

In order to support sparse hartid, the hartid & NR_CPUS needs to be disassociated
which was logically incorrect anyways. NR_CPUs represent the maximum logical|
CPU id configured in the kernel while the hartid represent the physical hartid
stored in mhartid CSR defined by the privilege specification. Thus, hartid
can have much greater value than logical cpuid.

Currently, we have two methods of booting. Ordered booting where the booting
hart brings up each non-booting hart one by one using SBI HSM extension.
The spinwait booting method relies on harts jumping to Linux kernel randomly
and boot hart is selected by a lottery. All other non-booting harts keep
spinning on __cpu_up_stack/task_pointer until boot hart initializes the data.
Both these methods rely on __cpu_up_stack/task_pointer to setup the stack/
task pointer. The spinwait method is mostly used to support older firmwares
without SBI HSM extension and M-mode Linux.  The ordered booting method is the
preferred booting method for booting general Linux because it can support
cpu hotplug and kexec.

The first patch modified the ordered booting method to use an opaque parameter
already available in HSM start API to setup the stack/task pointer. The third
patch resolves the issue #1 by limiting the usage of
__cpu_up_stack/task_pointer to spinwait specific booting method. The fourth 
and fifth patch moves the entire hart lottery selection and spinwait method
to a separate config that can be disabled if required. It solves the issue #2.
The 6th patch solves issue #3 and #4 by removing riscv_cpuid_to_hartid_mask
completely. All the SBI APIs directly pass a pointer to struct cpumask and
the SBI implementation takes care of generating the hart bitmap from the
cpumask.

It is not trivial to support sparse hartid for spinwait booting method and
there are no usecases to support sparse hartid for spinwait method as well.
Any platform with sparse hartid will probably require more advanced features
such as cpu hotplug and kexec. Thus, the series supports the sparse hartid via
ordered booting method only. To maintain backward compatibility, spinwait
booting method is currently enabled in defconfig so that M-mode linux will
continue to work. Any platform that requires to sparse hartid must disable the
spinwait method.

This series also fixes the out-of-bounds access error[1] reported by Geert.
The issue can be reproduced with SMP booting with NR_CPUS=4 on platforms with
discontiguous hart numbering (HiFive unleashed/unmatched & polarfire).
Spinwait method should also be disabled for such configuration where NR_CPUS
value is less than maximum hartid in the platform. 

[1] https://lore.kernel.org/lkml/CAMuHMdUPWOjJfJohxLJefHOrJBtXZ0xfHQt4=hXpUXnasiN+AQ@mail.gmail.com/#t

The series is based on queue branch on kvm-riscv as it has kvm related changes
as well. I have tested it on HiFive Unmatched and Qemu.

Changes from v2->v3:
1. Rebased on linux-next
2. Removed the redundant variable in PATCH 1.
3. Added the reviewed-by/acked-by tags.

Changes from v1->v2:
1. Fixed few typos in Kconfig.
2. Moved the boot data structure offsets to a asm-offset.c
3. Removed the redundant config check in head.S

Atish Patra (6):
RISC-V: Avoid using per cpu array for ordered booting
RISC-V: Do not print the SBI version during HSM extension boot print
RISC-V: Use __cpu_up_stack/task_pointer only for spinwait method
RISC-V: Move the entire hart selection via lottery to SMP
RISC-V: Move spinwait booting method to its own config
RISC-V: Do not use cpumask data structure for hartid bitmap

arch/riscv/Kconfig                   |  14 ++
arch/riscv/include/asm/cpu_ops.h     |   2 -
arch/riscv/include/asm/cpu_ops_sbi.h |  25 ++++
arch/riscv/include/asm/sbi.h         |  19 +--
arch/riscv/include/asm/smp.h         |   2 -
arch/riscv/kernel/Makefile           |   3 +-
arch/riscv/kernel/asm-offsets.c      |   3 +
arch/riscv/kernel/cpu_ops.c          |  26 ++--
arch/riscv/kernel/cpu_ops_sbi.c      |  26 +++-
arch/riscv/kernel/cpu_ops_spinwait.c |  27 +++-
arch/riscv/kernel/head.S             |  35 ++---
arch/riscv/kernel/head.h             |   6 +-
arch/riscv/kernel/sbi.c              | 189 +++++++++++++++------------
arch/riscv/kernel/setup.c            |  10 --
arch/riscv/kernel/smpboot.c          |   2 +-
arch/riscv/kvm/mmu.c                 |   4 +-
arch/riscv/kvm/vcpu_sbi_replace.c    |  11 +-
arch/riscv/kvm/vcpu_sbi_v01.c        |  11 +-
arch/riscv/kvm/vmid.c                |   4 +-
arch/riscv/mm/cacheflush.c           |   5 +-
arch/riscv/mm/tlbflush.c             |   9 +-
21 files changed, 253 insertions(+), 180 deletions(-)
create mode 100644 arch/riscv/include/asm/cpu_ops_sbi.h

--
2.30.2

