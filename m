Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A7C546E35
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 22:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350465AbiFJUWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 16:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350145AbiFJUWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 16:22:24 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856B63002C7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 13:22:22 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id f12so166795ilj.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 13:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CMK9HHoC+CkaS7ESlgdwWQx56QlM6DUYZIowUim1ARU=;
        b=ZLB1iJbyDobtzDI6Is5SV0nGWNdc2St9G6RlgjYVVGp0uVrZ6v4ZI92gVUwT0/BUmg
         J1/JWP6jEh3acyYwnnlCKNfItePYtpwUoe4FsgljkRzHTiAD8WdXLlFypHP5c9KtpVT6
         OVc61CGaDh4DF57LxzGE9s/A9/9Jq6BpcSWUXxunYSqP+/8OBDRgx34AFQV8gQtQVb3g
         TJs4tFwoXAMtvtHU5s1KN/0NC9+7/vIBAv1VmSLm104PLcIWCxPocPztCu5rDgBE5O8v
         HDOefH58ccSQ3qHiFcHoLvaXVgGb1gZxnK5xmyQvSOufs5BGfU+dJ3Efrt+8fZGNdIVA
         R/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CMK9HHoC+CkaS7ESlgdwWQx56QlM6DUYZIowUim1ARU=;
        b=w2gJgIs/+tSdgogF+zf5fFVGDwDxJ2pQWrr0KzoIGHkYtFzO4YkyaEP5Reqg247eqA
         FU70iwK9OedJoYKGYaRMYVr8Nd3DLYZ9gsElbt7BTpB4rQ2EbqLmYi12ICe2bBP2dxXg
         g3fnp4xOe0aKHjXGqiTO1VRJH7NShke1EW85bbmWlNMvjinL7ivds5ApHHzQ79OEFeOY
         qNGhHGVC05FtgkCYo9kzcQylZmwTSKvybCUxa0EbdVeZt+xXBLhUvZBUBPCXeNGHWDK8
         /8/A5zO72KB0GzeiJZJj67nIhqdFRvIWDYTuJCtg6maUXLMxu9jyINij2r9jvU+9e4c4
         r2eg==
X-Gm-Message-State: AOAM533XC1Dskb7AfTpxkrheZpW5N2r43W9k5PnPrVxcyOYTEo+wM5dS
        CWfgYOXfoZodq5FjiThTnFrAD0ahNtoqKMsWAL7/gQ==
X-Google-Smtp-Source: ABdhPJx7aIDRy4/ea1YuQNAB9DPV8h6BLDUQFCm0oW5u78S9oIvdyHsF8T9YMmUUAdQ8H6gdA9z+fhfk2kTAUFocyQI=
X-Received: by 2002:a92:c24c:0:b0:2d1:cdd0:1959 with SMTP id
 k12-20020a92c24c000000b002d1cdd01959mr25304794ilo.39.1654892541600; Fri, 10
 Jun 2022 13:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
From:   Kostya Serebryany <kcc@google.com>
Date:   Fri, 10 Jun 2022 13:22:09 -0700
Message-ID: <CAN=P9piM76o313X194oSB2mZC-4eVc9f38oy5fXEsjKFWaQgnw@mail.gmail.com>
Subject: Re: [PATCHv3 0/8] Linear Address Masking enabling
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for working on this, please make LAM happen.
It enables efficient memory safety testing that is already available on AAr=
ch64.

Memory error detectors, such as ASAN and Valgrind (or KASAN for the kernel)
have limited applicability, primarily because of their run-time overheads
(CPU, RAM, and code size). In many cases, the major obstacle to a wider
deployment is the RAM overhead, which is typically 2x-3x. There is another =
tool,
HWASAN [1], which solves the same problem and has < 10% RAM overhead.
This tool is available only on AArch64 because it relies on the
top-byte-ignore (TBI)
feature. Full support for that feature [2] has been added to the
kernel in order to
enable HWASAN. Adding support for LAM will enable HWASAN on x86_64.

HWASAN is already the main memory safety tool for Android [3] - the reduced=
 RAM
overhead allowed us to utilize this testing tool where ASAN=E2=80=99s RAM o=
verhead was
prohibitive. We have also prototyped the x86_64 variant of HWASAN, and we c=
an
observe that it is a major improvement over ASAN. The kernel support
and hardware
availability are the only missing parts.

Making HWASAN available on x86_64 will enable developers of server and
client software
to scale up their memory safety testing, and thus improve the quality
and security of their products.


[1] https://clang.llvm.org/docs/HardwareAssistedAddressSanitizerDesign.html
[2] https://www.kernel.org/doc/html/latest/arm64/tagged-address-abi.html
[3] https://source.android.com/devices/tech/debug/hwasan

--kcc


On Fri, Jun 10, 2022 at 7:35 AM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> Linear Address Masking[1] (LAM) modifies the checking that is applied to
> 64-bit linear addresses, allowing software to use of the untranslated
> address bits for metadata.
>
> The patchset brings support for LAM for userspace addresses.
>
> LAM_U48 enabling is controversial since it competes for bits with
> 5-level paging. Its enabling isolated into an optional last patch that
> can be applied at maintainer's discretion.
>
> Please review and consider applying.
>
> v3:
>   - Rebased onto v5.19-rc1
>   - Per-process enabling;
>   - API overhaul (again);
>   - Avoid branches and costly computations in the fast path;
>   - LAM_U48 is in optional patch.
> v2:
>   - Rebased onto v5.18-rc1
>   - New arch_prctl(2)-based API
>   - Expose status of LAM (or other thread features) in
>     /proc/$PID/arch_status
>
> [1] ISE, Chapter 14.
> https://software.intel.com/content/dam/develop/external/us/en/documents-t=
ps/architecture-instruction-set-extensions-programming-reference.pdf
>
> Kirill A. Shutemov (8):
>   x86/mm: Fix CR3_ADDR_MASK
>   x86: CPUID and CR3/CR4 flags for Linear Address Masking
>   mm: Pass down mm_struct to untagged_addr()
>   x86/mm: Handle LAM on context switch
>   x86/uaccess: Provide untagged_addr() and remove tags before address che=
ck
>   x86/mm: Provide ARCH_GET_UNTAG_MASK and ARCH_ENABLE_TAGGED_ADDR
>   x86: Expose untagging mask in /proc/$PID/arch_status
>   x86/mm: Extend LAM to support to LAM_U48
>
>  arch/arm64/include/asm/memory.h               |  4 +-
>  arch/arm64/include/asm/signal.h               |  2 +-
>  arch/arm64/include/asm/uaccess.h              |  4 +-
>  arch/arm64/kernel/hw_breakpoint.c             |  2 +-
>  arch/arm64/kernel/traps.c                     |  4 +-
>  arch/arm64/mm/fault.c                         | 10 +--
>  arch/sparc/include/asm/pgtable_64.h           |  2 +-
>  arch/sparc/include/asm/uaccess_64.h           |  2 +
>  arch/x86/include/asm/cpufeatures.h            |  1 +
>  arch/x86/include/asm/elf.h                    |  3 +-
>  arch/x86/include/asm/mmu.h                    |  2 +
>  arch/x86/include/asm/mmu_context.h            | 58 +++++++++++++++++
>  arch/x86/include/asm/processor-flags.h        |  2 +-
>  arch/x86/include/asm/tlbflush.h               |  3 +
>  arch/x86/include/asm/uaccess.h                | 44 ++++++++++++-
>  arch/x86/include/uapi/asm/prctl.h             |  3 +
>  arch/x86/include/uapi/asm/processor-flags.h   |  6 ++
>  arch/x86/kernel/Makefile                      |  2 +
>  arch/x86/kernel/fpu/xstate.c                  | 47 --------------
>  arch/x86/kernel/proc.c                        | 50 +++++++++++++++
>  arch/x86/kernel/process.c                     |  3 +
>  arch/x86/kernel/process_64.c                  | 54 +++++++++++++++-
>  arch/x86/kernel/sys_x86_64.c                  |  5 +-
>  arch/x86/mm/hugetlbpage.c                     |  6 +-
>  arch/x86/mm/mmap.c                            |  9 ++-
>  arch/x86/mm/tlb.c                             | 62 ++++++++++++++-----
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  2 +-
>  drivers/gpu/drm/radeon/radeon_gem.c           |  2 +-
>  drivers/infiniband/hw/mlx4/mr.c               |  2 +-
>  drivers/media/common/videobuf2/frame_vector.c |  2 +-
>  drivers/media/v4l2-core/videobuf-dma-contig.c |  2 +-
>  .../staging/media/atomisp/pci/hmm/hmm_bo.c    |  2 +-
>  drivers/tee/tee_shm.c                         |  2 +-
>  drivers/vfio/vfio_iommu_type1.c               |  2 +-
>  fs/proc/task_mmu.c                            |  2 +-
>  include/linux/mm.h                            | 11 ----
>  include/linux/uaccess.h                       | 11 ++++
>  lib/strncpy_from_user.c                       |  2 +-
>  lib/strnlen_user.c                            |  2 +-
>  mm/gup.c                                      |  6 +-
>  mm/madvise.c                                  |  2 +-
>  mm/mempolicy.c                                |  6 +-
>  mm/migrate.c                                  |  2 +-
>  mm/mincore.c                                  |  2 +-
>  mm/mlock.c                                    |  4 +-
>  mm/mmap.c                                     |  2 +-
>  mm/mprotect.c                                 |  2 +-
>  mm/mremap.c                                   |  2 +-
>  mm/msync.c                                    |  2 +-
>  virt/kvm/kvm_main.c                           |  2 +-
>  51 files changed, 342 insertions(+), 126 deletions(-)
>  create mode 100644 arch/x86/kernel/proc.c
>
> --
> 2.35.1
>
