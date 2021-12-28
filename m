Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2AC480DB5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 23:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237647AbhL1WbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 17:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237594AbhL1WbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 17:31:03 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCC5C06173E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 14:31:02 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id o10so17627683qvc.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 14:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a0/3qSFlOvOlmytaGVTpc9gdOx4u3JLG4E+U1ypvGmM=;
        b=nFO6iFEysMfZ1442t476XZKLpSxTJNbNvfANEmihYgvNTkUIhuj6oSuNv7QHSLDXaj
         7Z0DBLr+yMaKimBTXMj1d8ZLcqgKVpNoUtVDomtFMc5D5lusariXnRrAEb0sCa5kFzGE
         8suS7AVZTcGkzz209ZpgWvSMcljUZkdUcqQXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a0/3qSFlOvOlmytaGVTpc9gdOx4u3JLG4E+U1ypvGmM=;
        b=WGxFUIMOtbP2bDGBU+QSJJW0Fwn4r30SvMsVbh1R9mH2mRg0bFA1NesvHm3AG0lZP7
         Di/Ddg0crmZjAKFKYqOsmUaFgjcGprTQ4TAPtqBeAPL3iRURn8/WpGZOR2d1SQfaqX3P
         27S5+lJ9Cc1OW7C2CjivDCnr7KkaC/A8TouoLdPJs0Fw5njfAqm4GQX8UGqsd2Kt/FOH
         O+3/lcL3P+jPg+aGaUzOqt9RDJiyjPPRbehgvM8HpK9RO62khkDLu3TsAle0Pf0FdY0v
         msfInsJF8lC+Juor8AYT9TNsUL/Mpk1S9rJFAhd2kVfetFdc8bquMssyu55M6tsAF+RS
         aXLw==
X-Gm-Message-State: AOAM531FxGw5t+6PcV6JHkSafcDpcf61rjpajY/J/5R+1Yyr9fTBqI6j
        fEOmBtBwg3cIlP22ErjHpTL3m6ItQN7e
X-Google-Smtp-Source: ABdhPJy115f92bcf4Eeg1/nZa+Vwk46UoyIMubczunCmbr+wsGR08eXjE9zxJetXfh9Y+/Qz3+S8zw==
X-Received: by 2002:a05:6214:d8b:: with SMTP id e11mr21078879qve.32.1640730661904;
        Tue, 28 Dec 2021 14:31:01 -0800 (PST)
Received: from fedora.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id i5sm2738407qti.27.2021.12.28.14.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 14:31:01 -0800 (PST)
From:   Atish Patra <atishp@atishpatra.org>
X-Google-Original-From: Atish Patra <atishp@rivosinc.com>
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
Subject: [PATCH v2 0/6] Sparse HART id support 
Date:   Tue, 28 Dec 2021 14:30:51 -0800
Message-Id: <20211228223057.2772727-1-atishp@rivosinc.com>
X-Mailer: git-send-email 2.33.1
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
arch/riscv/include/asm/smp.h         |   8 --
arch/riscv/kernel/Makefile           |   3 +-
arch/riscv/kernel/asm-offsets.c      |   3 +
arch/riscv/kernel/cpu_ops.c          |  26 ++--
arch/riscv/kernel/cpu_ops_sbi.c      |  23 +++-
arch/riscv/kernel/cpu_ops_spinwait.c |  27 +++-
arch/riscv/kernel/head.S             |  35 ++---
arch/riscv/kernel/head.h             |   6 +-
arch/riscv/kernel/sbi.c              | 189 +++++++++++++++------------
arch/riscv/kernel/smp.c              |  10 --
arch/riscv/kernel/smpboot.c          |   2 +-
arch/riscv/kvm/mmu.c                 |   4 +-
arch/riscv/kvm/vcpu_sbi_replace.c    |  11 +-
arch/riscv/kvm/vcpu_sbi_v01.c        |  11 +-
arch/riscv/kvm/vmid.c                |   4 +-
arch/riscv/mm/cacheflush.c           |   5 +-
arch/riscv/mm/tlbflush.c             |   9 +-
21 files changed, 253 insertions(+), 183 deletions(-)
create mode 100644 arch/riscv/include/asm/cpu_ops_sbi.h

--
2.33.1

