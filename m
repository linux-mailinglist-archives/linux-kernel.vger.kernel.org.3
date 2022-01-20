Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2B3495405
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 19:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244348AbiATSRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 13:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243805AbiATSRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 13:17:24 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B86C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 10:17:24 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id g9-20020a17090a67c900b001b4f1d71e4fso6523682pjm.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 10:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=KQ1vWUfThsgcO0TMX//y1/F6aK1Vz2XCJRw2Z+ID7Ls=;
        b=IeGtbhQKHlgHsUpPUReuIIuNM/1GaRyvGFBqBSyZ2zvuR+rx0OnkspBEyl0UDkbzge
         56sdBReFheQbsjNE3vACa7SkiCjC0ktFZ880I7Cocfl1XXtuDnEPMkLrug8EC6PdV0r8
         ZQU/FXbVwkZUcR/uvAaroXSswIBlqhrhZT7eemjZjof2hxSj1M0GuZeK5y6qT9EAH9SH
         W3HxwBxgoHfPb6hUS+GcZ/QBvhp+ANzY5N/Z0QbKQRMmW6Jj/ZBd7hHz9ZTzRkDOfzgk
         U3eZhuSANLneiRC6XBEvCzKST7W9WmuwDIbpBEpymsnaz9n1GHhhpM/oSTl+ndffu0nX
         PT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=KQ1vWUfThsgcO0TMX//y1/F6aK1Vz2XCJRw2Z+ID7Ls=;
        b=Zc/Kk4kLcAtGMCbNLe13oDAbvT/0ydhn2ztDLLuJeHTXapw3OsC/0JQdFof7xpo0ss
         4kthDcKCHq0E9Md9B3MESrAO9I72A96ADPg74grHd0/zoWddMWwM0ELahmbBxajinzyg
         kXdKLsGxmfOiSaCSclwFEjRaXYHuJDS2xIJZw1J4M9cb4UU4S4xtOr7TM/dWPRCtDH2z
         GUbXRNzTs2S4lP+PLsArfpFa/QpXWkoZ2Boq3PhgLH+9vpSEz31yhoOXSCahdD03Yujq
         +HNEe+OCosBuxoHb9RKdEXpyLBSZvpjGQXcmUidzQSRtNxykmBMjOraZuQofC99JP0rL
         zdbQ==
X-Gm-Message-State: AOAM532rVJB3iWd0lDbXeUk2xvFw4pB6HX2Buo0k9bBYhXTgQII64esk
        1iHSTPal0rZEyVcWo0+CJ7G/WmVS4AJhlQ==
X-Google-Smtp-Source: ABdhPJzo1syrhZbBJ2vXUJ9jpJzxvw01YRDAUtHo6ubpZbmmP51+HflWuEPTKfWLQ6wx5lTOwNzQKg==
X-Received: by 2002:a17:903:2442:b0:14a:54e3:3905 with SMTP id l2-20020a170903244200b0014a54e33905mr248717pls.55.1642702643084;
        Thu, 20 Jan 2022 10:17:23 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id f4sm4183556pfe.204.2022.01.20.10.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 10:17:22 -0800 (PST)
Date:   Thu, 20 Jan 2022 10:17:22 -0800 (PST)
X-Google-Original-Date: Thu, 20 Jan 2022 09:59:13 PST (-0800)
Subject:     Re: [PATCH v3 0/6] Sparse HART id support 
In-Reply-To: <20220120090918.2646626-1-atishp@rivosinc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>,
        aou@eecs.berkeley.edu, atishp@atishpatra.org, anup@brainfault.org,
        damien.lemoal@wdc.com, devicetree@vger.kernel.org,
        jszhang@kernel.org, krzysztof.kozlowski@canonical.com,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>, robh+dt@kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <atishp@rivosinc.com>
Message-ID: <mhng-b8ab7493-45b7-46d9-9cb3-8bc29c98833d@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jan 2022 01:09:12 PST (-0800), Atish Patra wrote:
> Currently, sparse hartid is not supported for Linux RISC-V for the following
> reasons.
> 1. Both spinwait and ordered booting method uses __cpu_up_stack/task_pointer
>    which is an array size of NR_CPUs.
> 2. During early booting, any hartid greater than NR_CPUs are not booted at all.
> 3. riscv_cpuid_to_hartid_mask uses struct cpumask for generating hartid bitmap.
> 4. SBI v0.2 implementation uses NR_CPUs as the maximum hartid number while
>    generating hartmask.
>
> In order to support sparse hartid, the hartid & NR_CPUS needs to be disassociated
> which was logically incorrect anyways. NR_CPUs represent the maximum logical|
> CPU id configured in the kernel while the hartid represent the physical hartid
> stored in mhartid CSR defined by the privilege specification. Thus, hartid
> can have much greater value than logical cpuid.
>
> Currently, we have two methods of booting. Ordered booting where the booting
> hart brings up each non-booting hart one by one using SBI HSM extension.
> The spinwait booting method relies on harts jumping to Linux kernel randomly
> and boot hart is selected by a lottery. All other non-booting harts keep
> spinning on __cpu_up_stack/task_pointer until boot hart initializes the data.
> Both these methods rely on __cpu_up_stack/task_pointer to setup the stack/
> task pointer. The spinwait method is mostly used to support older firmwares
> without SBI HSM extension and M-mode Linux.  The ordered booting method is the
> preferred booting method for booting general Linux because it can support
> cpu hotplug and kexec.
>
> The first patch modified the ordered booting method to use an opaque parameter
> already available in HSM start API to setup the stack/task pointer. The third
> patch resolves the issue #1 by limiting the usage of
> __cpu_up_stack/task_pointer to spinwait specific booting method. The fourth
> and fifth patch moves the entire hart lottery selection and spinwait method
> to a separate config that can be disabled if required. It solves the issue #2.
> The 6th patch solves issue #3 and #4 by removing riscv_cpuid_to_hartid_mask
> completely. All the SBI APIs directly pass a pointer to struct cpumask and
> the SBI implementation takes care of generating the hart bitmap from the
> cpumask.
>
> It is not trivial to support sparse hartid for spinwait booting method and
> there are no usecases to support sparse hartid for spinwait method as well.
> Any platform with sparse hartid will probably require more advanced features
> such as cpu hotplug and kexec. Thus, the series supports the sparse hartid via
> ordered booting method only. To maintain backward compatibility, spinwait
> booting method is currently enabled in defconfig so that M-mode linux will
> continue to work. Any platform that requires to sparse hartid must disable the
> spinwait method.
>
> This series also fixes the out-of-bounds access error[1] reported by Geert.
> The issue can be reproduced with SMP booting with NR_CPUS=4 on platforms with
> discontiguous hart numbering (HiFive unleashed/unmatched & polarfire).
> Spinwait method should also be disabled for such configuration where NR_CPUS
> value is less than maximum hartid in the platform.
>
> [1] https://lore.kernel.org/lkml/CAMuHMdUPWOjJfJohxLJefHOrJBtXZ0xfHQt4=hXpUXnasiN+AQ@mail.gmail.com/#t
>
> The series is based on queue branch on kvm-riscv as it has kvm related changes
> as well. I have tested it on HiFive Unmatched and Qemu.
>
> Changes from v2->v3:
> 1. Rebased on linux-next
> 2. Removed the redundant variable in PATCH 1.
> 3. Added the reviewed-by/acked-by tags.
>
> Changes from v1->v2:
> 1. Fixed few typos in Kconfig.
> 2. Moved the boot data structure offsets to a asm-offset.c
> 3. Removed the redundant config check in head.S
>
> Atish Patra (6):
> RISC-V: Avoid using per cpu array for ordered booting
> RISC-V: Do not print the SBI version during HSM extension boot print
> RISC-V: Use __cpu_up_stack/task_pointer only for spinwait method
> RISC-V: Move the entire hart selection via lottery to SMP
> RISC-V: Move spinwait booting method to its own config
> RISC-V: Do not use cpumask data structure for hartid bitmap
>
> arch/riscv/Kconfig                   |  14 ++
> arch/riscv/include/asm/cpu_ops.h     |   2 -
> arch/riscv/include/asm/cpu_ops_sbi.h |  25 ++++
> arch/riscv/include/asm/sbi.h         |  19 +--
> arch/riscv/include/asm/smp.h         |   2 -
> arch/riscv/kernel/Makefile           |   3 +-
> arch/riscv/kernel/asm-offsets.c      |   3 +
> arch/riscv/kernel/cpu_ops.c          |  26 ++--
> arch/riscv/kernel/cpu_ops_sbi.c      |  26 +++-
> arch/riscv/kernel/cpu_ops_spinwait.c |  27 +++-
> arch/riscv/kernel/head.S             |  35 ++---
> arch/riscv/kernel/head.h             |   6 +-
> arch/riscv/kernel/sbi.c              | 189 +++++++++++++++------------
> arch/riscv/kernel/setup.c            |  10 --
> arch/riscv/kernel/smpboot.c          |   2 +-
> arch/riscv/kvm/mmu.c                 |   4 +-
> arch/riscv/kvm/vcpu_sbi_replace.c    |  11 +-
> arch/riscv/kvm/vcpu_sbi_v01.c        |  11 +-
> arch/riscv/kvm/vmid.c                |   4 +-
> arch/riscv/mm/cacheflush.c           |   5 +-
> arch/riscv/mm/tlbflush.c             |   9 +-
> 21 files changed, 253 insertions(+), 180 deletions(-)
> create mode 100644 arch/riscv/include/asm/cpu_ops_sbi.h

Thanks, these are on for-next.
