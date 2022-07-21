Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8CC57CB94
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 15:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbiGUNNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 09:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiGUNNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 09:13:08 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4D8308
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:12:58 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id b143so1468006yba.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2j4ci87XEWRwF5j1WThsJY0C3+FMhEQIRXlReee9hXo=;
        b=nQw+VcLT1Fy17FIn+/YFxTep73Yo759mY7gT0fwrGYh+3HEt2SwL7ctDVTKJcPUjb+
         +bzwq/f+OIbdH0G3DW1dpw20K7YR0o30jGoHpmAiNJYyyR5bbpsw/R5NBaXSIPnkkemL
         C9YAWlCfFBv+sc0idQKi6v2+keBqc/IfA+CJH1gUEbDXvEF2PgMHsZGOf3msKyARM/sd
         OEzzJJuYcXd8fIq9lTKKqgbWXQBcC7p0nzoU46AowUHPUpIEDIuh0ufMwD1uzCSxaWOO
         vv/gHFb9fbDU3NHRaQRc1nA0VFNEk7f5NSYc/NDvp9ANMK/hMVL7oqbM0OnBYmva+fVZ
         qQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2j4ci87XEWRwF5j1WThsJY0C3+FMhEQIRXlReee9hXo=;
        b=NVXnqcSUoAY6IdrE3CgyYqQAgF21klcVTfChezp9p3i99zlRYY5tk3PxXAXF5VRt+t
         bb7QslGS6CQ1B0u8IM1SjC9gB5SuBYi0Tp+Q8rkocTvEvfknlAypOt1Y8J+JjMo8xpO/
         zxqYp8C2oYwa3b9ORM8J9nV+Stget2CuUS2b9O2DmLy2KixcPr4+3FJdiHYBCH+USzBH
         LgZf6a03krp8X7I9ko4QWHz3NKBCe+NsWvI6gKO2KBPgHqe1SSQaCWGiLVxwO4ZZRU7A
         8CuW4WSNH6eU3N1er667H+3KBC0UI+SJtwPO5so0NDYkSD/T7HpN+XLJ3Ve6p0a3EC6m
         nGRw==
X-Gm-Message-State: AJIora887QVnEmFN7QgRs8gmFbZ2ndliQE0r9ReE5KpjXwtCZ8Kj7RVu
        rb+kox6AQa9M5jjkhHJluH5fxA7fCtP+q8a6nhRKsQ==
X-Google-Smtp-Source: AGRyM1uBXv/dbfycSqwUJisZ4IRO2fQLXAOwgW67yImZ5RI8orVZPVmR7a45z4SGgc/Sb93pNUYi0qmT8dmOqVIunEc=
X-Received: by 2002:a25:6847:0:b0:66e:b676:834c with SMTP id
 d68-20020a256847000000b0066eb676834cmr41215833ybc.5.1658409177341; Thu, 21
 Jul 2022 06:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220712231328.5294-1-kirill.shutemov@linux.intel.com> <20220712231328.5294-4-kirill.shutemov@linux.intel.com>
In-Reply-To: <20220712231328.5294-4-kirill.shutemov@linux.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 21 Jul 2022 15:12:21 +0200
Message-ID: <CAG_fn=V8b0+JeoATiR3pGH1dgdY6mTT1adYKsy6+xAmV2vVo5Q@mail.gmail.com>
Subject: Re: [PATCHv5 03/13] mm: Pass down mm_struct to untagged_addr()
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 1:13 AM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> Intel Linear Address Masking (LAM) brings per-mm untagging rules. Pass
> down mm_struct to the untagging helper. It will help to apply untagging
> policy correctly.
>
> In most cases, current->mm is the one to use, but there are some
> exceptions, such as get_user_page_remote().
>
> Move dummy implementation of untagged_addr() from <linux/mm.h> to
> <linux/uaccess.h>. <asm/uaccess.h> can override the implementation.
> Moving the dummy header outside <linux/mm.h> helps to avoid header hell
> if you need to defer mm_struct within the helper.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Reviewed-by: Alexander Potapenko <glider@google.com>
Tested-by: Alexander Potapenko <glider@google.com>


> ---
>  arch/arm64/include/asm/memory.h                  |  4 ++--
>  arch/arm64/include/asm/signal.h                  |  2 +-
>  arch/arm64/include/asm/uaccess.h                 |  4 ++--
>  arch/arm64/kernel/hw_breakpoint.c                |  2 +-
>  arch/arm64/kernel/traps.c                        |  4 ++--
>  arch/arm64/mm/fault.c                            | 10 +++++-----
>  arch/sparc/include/asm/pgtable_64.h              |  2 +-
>  arch/sparc/include/asm/uaccess_64.h              |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c          |  2 +-
>  drivers/gpu/drm/radeon/radeon_gem.c              |  2 +-
>  drivers/infiniband/hw/mlx4/mr.c                  |  2 +-
>  drivers/media/common/videobuf2/frame_vector.c    |  2 +-
>  drivers/media/v4l2-core/videobuf-dma-contig.c    |  2 +-
>  drivers/staging/media/atomisp/pci/hmm/hmm_bo.c   |  2 +-
>  drivers/tee/tee_shm.c                            |  2 +-
>  drivers/vfio/vfio_iommu_type1.c                  |  2 +-
>  fs/proc/task_mmu.c                               |  2 +-
>  include/linux/mm.h                               | 11 -----------
>  include/linux/uaccess.h                          | 15 +++++++++++++++
>  lib/strncpy_from_user.c                          |  2 +-
>  lib/strnlen_user.c                               |  2 +-
>  mm/gup.c                                         |  6 +++---
>  mm/madvise.c                                     |  2 +-
>  mm/mempolicy.c                                   |  6 +++---
>  mm/migrate.c                                     |  2 +-
>  mm/mincore.c                                     |  2 +-
>  mm/mlock.c                                       |  4 ++--
>  mm/mmap.c                                        |  2 +-
>  mm/mprotect.c                                    |  2 +-
>  mm/mremap.c                                      |  2 +-
>  mm/msync.c                                       |  2 +-
>  virt/kvm/kvm_main.c                              |  2 +-
>  33 files changed, 59 insertions(+), 53 deletions(-)
>
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/mem=
ory.h
> index 0af70d9abede..88bee513b74c 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -215,8 +215,8 @@ static inline unsigned long kaslr_offset(void)
>  #define __untagged_addr(addr)  \
>         ((__force __typeof__(addr))sign_extend64((__force u64)(addr), 55)=
)
>
> -#define untagged_addr(addr)    ({                                      \
> -       u64 __addr =3D (__force u64)(addr);                              =
         \
> +#define untagged_addr(mm, addr)        ({                               =
       \
> +       u64 __addr =3D (__force u64)(addr);                              =
 \
>         __addr &=3D __untagged_addr(__addr);                             =
 \
>         (__force __typeof__(addr))__addr;                               \
>  })
> diff --git a/arch/arm64/include/asm/signal.h b/arch/arm64/include/asm/sig=
nal.h
> index ef449f5f4ba8..0899c355c398 100644
> --- a/arch/arm64/include/asm/signal.h
> +++ b/arch/arm64/include/asm/signal.h
> @@ -18,7 +18,7 @@ static inline void __user *arch_untagged_si_addr(void _=
_user *addr,
>         if (sig =3D=3D SIGTRAP && si_code =3D=3D TRAP_BRKPT)
>                 return addr;
>
> -       return untagged_addr(addr);
> +       return untagged_addr(current->mm, addr);
>  }
>  #define arch_untagged_si_addr arch_untagged_si_addr
>
> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/ua=
ccess.h
> index 63f9c828f1a7..bdcc014bd297 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -44,7 +44,7 @@ static inline int access_ok(const void __user *addr, un=
signed long size)
>          */
>         if (IS_ENABLED(CONFIG_ARM64_TAGGED_ADDR_ABI) &&
>             (current->flags & PF_KTHREAD || test_thread_flag(TIF_TAGGED_A=
DDR)))
> -               addr =3D untagged_addr(addr);
> +               addr =3D untagged_addr(current->mm, addr);
>
>         return likely(__access_ok(addr, size));
>  }
> @@ -217,7 +217,7 @@ static inline void __user *__uaccess_mask_ptr(const v=
oid __user *ptr)
>         "       csel    %0, %1, xzr, eq\n"
>         : "=3D&r" (safe_ptr)
>         : "r" (ptr), "r" (TASK_SIZE_MAX - 1),
> -         "r" (untagged_addr(ptr))
> +         "r" (untagged_addr(current->mm, ptr))
>         : "cc");
>
>         csdb();
> diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_bre=
akpoint.c
> index b29a311bb055..d637cee7b771 100644
> --- a/arch/arm64/kernel/hw_breakpoint.c
> +++ b/arch/arm64/kernel/hw_breakpoint.c
> @@ -715,7 +715,7 @@ static u64 get_distance_from_watchpoint(unsigned long=
 addr, u64 val,
>         u64 wp_low, wp_high;
>         u32 lens, lene;
>
> -       addr =3D untagged_addr(addr);
> +       addr =3D untagged_addr(current->mm, addr);
>
>         lens =3D __ffs(ctrl->len);
>         lene =3D __fls(ctrl->len);
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 9ac7a81b79be..385612d9890b 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -476,7 +476,7 @@ void arm64_notify_segfault(unsigned long addr)
>         int code;
>
>         mmap_read_lock(current->mm);
> -       if (find_vma(current->mm, untagged_addr(addr)) =3D=3D NULL)
> +       if (find_vma(current->mm, untagged_addr(current->mm, addr)) =3D=
=3D NULL)
>                 code =3D SEGV_MAPERR;
>         else
>                 code =3D SEGV_ACCERR;
> @@ -540,7 +540,7 @@ static void user_cache_maint_handler(unsigned long es=
r, struct pt_regs *regs)
>         int ret =3D 0;
>
>         tagged_address =3D pt_regs_read_reg(regs, rt);
> -       address =3D untagged_addr(tagged_address);
> +       address =3D untagged_addr(current->mm, tagged_address);
>
>         switch (crm) {
>         case ESR_ELx_SYS64_ISS_CRM_DC_CVAU:     /* DC CVAU, gets promoted=
 */
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index c5e11768e5c1..9577d7e37f36 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -454,7 +454,7 @@ static void set_thread_esr(unsigned long address, uns=
igned long esr)
>  static void do_bad_area(unsigned long far, unsigned long esr,
>                         struct pt_regs *regs)
>  {
> -       unsigned long addr =3D untagged_addr(far);
> +       unsigned long addr =3D untagged_addr(current->mm, far);
>
>         /*
>          * If we are in kernel mode at this point, we have no context to
> @@ -524,7 +524,7 @@ static int __kprobes do_page_fault(unsigned long far,=
 unsigned long esr,
>         vm_fault_t fault;
>         unsigned long vm_flags;
>         unsigned int mm_flags =3D FAULT_FLAG_DEFAULT;
> -       unsigned long addr =3D untagged_addr(far);
> +       unsigned long addr =3D untagged_addr(mm, far);
>
>         if (kprobe_page_fault(regs, esr))
>                 return 0;
> @@ -675,7 +675,7 @@ static int __kprobes do_translation_fault(unsigned lo=
ng far,
>                                           unsigned long esr,
>                                           struct pt_regs *regs)
>  {
> -       unsigned long addr =3D untagged_addr(far);
> +       unsigned long addr =3D untagged_addr(current->mm, far);
>
>         if (is_ttbr0_addr(addr))
>                 return do_page_fault(far, esr, regs);
> @@ -719,7 +719,7 @@ static int do_sea(unsigned long far, unsigned long es=
r, struct pt_regs *regs)
>                  * UNKNOWN for synchronous external aborts. Mask them out=
 now
>                  * so that userspace doesn't see them.
>                  */
> -               siaddr  =3D untagged_addr(far);
> +               siaddr  =3D untagged_addr(current->mm, far);
>         }
>         arm64_notify_die(inf->name, regs, inf->sig, inf->code, siaddr, es=
r);
>
> @@ -809,7 +809,7 @@ static const struct fault_info fault_info[] =3D {
>  void do_mem_abort(unsigned long far, unsigned long esr, struct pt_regs *=
regs)
>  {
>         const struct fault_info *inf =3D esr_to_fault_info(esr);
> -       unsigned long addr =3D untagged_addr(far);
> +       unsigned long addr =3D untagged_addr(current->mm, far);
>
>         if (!inf->fn(far, esr, regs))
>                 return;
> diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm=
/pgtable_64.h
> index 4679e45c8348..1336d7bfaab9 100644
> --- a/arch/sparc/include/asm/pgtable_64.h
> +++ b/arch/sparc/include/asm/pgtable_64.h
> @@ -1071,7 +1071,7 @@ static inline unsigned long __untagged_addr(unsigne=
d long start)
>
>         return start;
>  }
> -#define untagged_addr(addr) \
> +#define untagged_addr(mm, addr) \
>         ((__typeof__(addr))(__untagged_addr((unsigned long)(addr))))
>
>  static inline bool pte_access_permitted(pte_t pte, bool write)
> diff --git a/arch/sparc/include/asm/uaccess_64.h b/arch/sparc/include/asm=
/uaccess_64.h
> index 94266a5c5b04..b825a5dd0210 100644
> --- a/arch/sparc/include/asm/uaccess_64.h
> +++ b/arch/sparc/include/asm/uaccess_64.h
> @@ -8,8 +8,10 @@
>
>  #include <linux/compiler.h>
>  #include <linux/string.h>
> +#include <linux/mm_types.h>
>  #include <asm/asi.h>
>  #include <asm/spitfire.h>
> +#include <asm/pgtable.h>
>
>  #include <asm/processor.h>
>  #include <asm-generic/access_ok.h>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 6b6d46e29e6e..b37199b16643 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1491,7 +1491,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>                 if (flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
>                         if (!offset || !*offset)
>                                 return -EINVAL;
> -                       user_addr =3D untagged_addr(*offset);
> +                       user_addr =3D untagged_addr(current->mm, *offset)=
;
>                 } else if (flags & (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
>                                     KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) =
{
>                         bo_type =3D ttm_bo_type_sg;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index 8ef31d687ef3..691dfb3f2c0e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -382,7 +382,7 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, =
void *data,
>         uint32_t handle;
>         int r;
>
> -       args->addr =3D untagged_addr(args->addr);
> +       args->addr =3D untagged_addr(current->mm, args->addr);
>
>         if (offset_in_page(args->addr | args->size))
>                 return -EINVAL;
> diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon=
/radeon_gem.c
> index 8c01a7f0e027..2c3980677f64 100644
> --- a/drivers/gpu/drm/radeon/radeon_gem.c
> +++ b/drivers/gpu/drm/radeon/radeon_gem.c
> @@ -371,7 +371,7 @@ int radeon_gem_userptr_ioctl(struct drm_device *dev, =
void *data,
>         uint32_t handle;
>         int r;
>
> -       args->addr =3D untagged_addr(args->addr);
> +       args->addr =3D untagged_addr(current->mm, args->addr);
>
>         if (offset_in_page(args->addr | args->size))
>                 return -EINVAL;
> diff --git a/drivers/infiniband/hw/mlx4/mr.c b/drivers/infiniband/hw/mlx4=
/mr.c
> index 04a67b481608..b2860feeae3c 100644
> --- a/drivers/infiniband/hw/mlx4/mr.c
> +++ b/drivers/infiniband/hw/mlx4/mr.c
> @@ -379,7 +379,7 @@ static struct ib_umem *mlx4_get_umem_mr(struct ib_dev=
ice *device, u64 start,
>          * again
>          */
>         if (!ib_access_writable(access_flags)) {
> -               unsigned long untagged_start =3D untagged_addr(start);
> +               unsigned long untagged_start =3D untagged_addr(current->m=
m, start);
>                 struct vm_area_struct *vma;
>
>                 mmap_read_lock(current->mm);
> diff --git a/drivers/media/common/videobuf2/frame_vector.c b/drivers/medi=
a/common/videobuf2/frame_vector.c
> index 542dde9d2609..7e62f7a2555d 100644
> --- a/drivers/media/common/videobuf2/frame_vector.c
> +++ b/drivers/media/common/videobuf2/frame_vector.c
> @@ -47,7 +47,7 @@ int get_vaddr_frames(unsigned long start, unsigned int =
nr_frames,
>         if (WARN_ON_ONCE(nr_frames > vec->nr_allocated))
>                 nr_frames =3D vec->nr_allocated;
>
> -       start =3D untagged_addr(start);
> +       start =3D untagged_addr(mm, start);
>
>         ret =3D pin_user_pages_fast(start, nr_frames,
>                                   FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM=
,
> diff --git a/drivers/media/v4l2-core/videobuf-dma-contig.c b/drivers/medi=
a/v4l2-core/videobuf-dma-contig.c
> index 52312ce2ba05..a1444f8afa05 100644
> --- a/drivers/media/v4l2-core/videobuf-dma-contig.c
> +++ b/drivers/media/v4l2-core/videobuf-dma-contig.c
> @@ -157,8 +157,8 @@ static void videobuf_dma_contig_user_put(struct video=
buf_dma_contig_memory *mem)
>  static int videobuf_dma_contig_user_get(struct videobuf_dma_contig_memor=
y *mem,
>                                         struct videobuf_buffer *vb)
>  {
> -       unsigned long untagged_baddr =3D untagged_addr(vb->baddr);
>         struct mm_struct *mm =3D current->mm;
> +       unsigned long untagged_baddr =3D untagged_addr(mm, vb->baddr);
>         struct vm_area_struct *vma;
>         unsigned long prev_pfn, this_pfn;
>         unsigned long pages_done, user_address;
> diff --git a/drivers/staging/media/atomisp/pci/hmm/hmm_bo.c b/drivers/sta=
ging/media/atomisp/pci/hmm/hmm_bo.c
> index 0168f9839c90..863d30a7ad23 100644
> --- a/drivers/staging/media/atomisp/pci/hmm/hmm_bo.c
> +++ b/drivers/staging/media/atomisp/pci/hmm/hmm_bo.c
> @@ -913,7 +913,7 @@ static int alloc_user_pages(struct hmm_buffer_object =
*bo,
>          * and map to user space
>          */
>
> -       userptr =3D untagged_addr(userptr);
> +       userptr =3D untagged_addr(current->mm, userptr);
>
>         bo->pages =3D pages;
>
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index f2b1bcefcadd..386be09cb2cd 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -261,7 +261,7 @@ register_shm_helper(struct tee_context *ctx, unsigned=
 long addr,
>         shm->flags =3D flags;
>         shm->ctx =3D ctx;
>         shm->id =3D id;
> -       addr =3D untagged_addr(addr);
> +       addr =3D untagged_addr(current->mm, addr);
>         start =3D rounddown(addr, PAGE_SIZE);
>         shm->offset =3D addr - start;
>         shm->size =3D length;
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_ty=
pe1.c
> index c13b9290e357..5ac6c61d7caa 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -561,7 +561,7 @@ static int vaddr_get_pfns(struct mm_struct *mm, unsig=
ned long vaddr,
>                 goto done;
>         }
>
> -       vaddr =3D untagged_addr(vaddr);
> +       vaddr =3D untagged_addr(mm, vaddr);
>
>  retry:
>         vma =3D vma_lookup(mm, vaddr);
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 2d04e3470d4c..c7d262bd6d6b 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1659,7 +1659,7 @@ static ssize_t pagemap_read(struct file *file, char=
 __user *buf,
>         /* watch out for wraparound */
>         start_vaddr =3D end_vaddr;
>         if (svpfn <=3D (ULONG_MAX >> PAGE_SHIFT))
> -               start_vaddr =3D untagged_addr(svpfn << PAGE_SHIFT);
> +               start_vaddr =3D untagged_addr(mm, svpfn << PAGE_SHIFT);
>
>         /* Ensure the address is inside the task */
>         if (start_vaddr > mm->task_size)
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index bc8f326be0ce..f0cb92ff1391 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -94,17 +94,6 @@ extern int mmap_rnd_compat_bits __read_mostly;
>  #include <asm/page.h>
>  #include <asm/processor.h>
>
> -/*
> - * Architectures that support memory tagging (assigning tags to memory r=
egions,
> - * embedding these tags into addresses that point to these memory region=
s, and
> - * checking that the memory and the pointer tags match on memory accesse=
s)
> - * redefine this macro to strip tags from pointers.
> - * It's defined as noop for architectures that don't support memory tagg=
ing.
> - */
> -#ifndef untagged_addr
> -#define untagged_addr(addr) (addr)
> -#endif
> -
>  #ifndef __pa_symbol
>  #define __pa_symbol(x)  __pa(RELOC_HIDE((unsigned long)(x), 0))
>  #endif
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index 5a328cf02b75..46fd816179d7 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -10,6 +10,21 @@
>
>  #include <asm/uaccess.h>
>
> +/*
> + * Architectures that support memory tagging (assigning tags to memory r=
egions,
> + * embedding these tags into addresses that point to these memory region=
s, and
> + * checking that the memory and the pointer tags match on memory accesse=
s)
> + * redefine this macro to strip tags from pointers.
> + *
> + * Passing down mm_struct allows to define untagging rules on per-proces=
s
> + * basis.
> + *
> + * It's defined as noop for architectures that don't support memory tagg=
ing.
> + */
> +#ifndef untagged_addr
> +#define untagged_addr(mm, addr) (addr)
> +#endif
> +
>  /*
>   * Architectures should provide two primitives (raw_copy_{to,from}_user(=
))
>   * and get rid of their private instances of copy_{to,from}_user() and
> diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
> index 6432b8c3e431..6e1e2aa0c994 100644
> --- a/lib/strncpy_from_user.c
> +++ b/lib/strncpy_from_user.c
> @@ -121,7 +121,7 @@ long strncpy_from_user(char *dst, const char __user *=
src, long count)
>                 return 0;
>
>         max_addr =3D TASK_SIZE_MAX;
> -       src_addr =3D (unsigned long)untagged_addr(src);
> +       src_addr =3D (unsigned long)untagged_addr(current->mm, src);
>         if (likely(src_addr < max_addr)) {
>                 unsigned long max =3D max_addr - src_addr;
>                 long retval;
> diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
> index feeb935a2299..abc096a68f05 100644
> --- a/lib/strnlen_user.c
> +++ b/lib/strnlen_user.c
> @@ -97,7 +97,7 @@ long strnlen_user(const char __user *str, long count)
>                 return 0;
>
>         max_addr =3D TASK_SIZE_MAX;
> -       src_addr =3D (unsigned long)untagged_addr(str);
> +       src_addr =3D (unsigned long)untagged_addr(current->mm, str);
>         if (likely(src_addr < max_addr)) {
>                 unsigned long max =3D max_addr - src_addr;
>                 long retval;
> diff --git a/mm/gup.c b/mm/gup.c
> index 551264407624..dbe825faf842 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1104,7 +1104,7 @@ static long __get_user_pages(struct mm_struct *mm,
>         if (!nr_pages)
>                 return 0;
>
> -       start =3D untagged_addr(start);
> +       start =3D untagged_addr(mm, start);
>
>         VM_BUG_ON(!!pages !=3D !!(gup_flags & (FOLL_GET | FOLL_PIN)));
>
> @@ -1285,7 +1285,7 @@ int fixup_user_fault(struct mm_struct *mm,
>         struct vm_area_struct *vma;
>         vm_fault_t ret;
>
> -       address =3D untagged_addr(address);
> +       address =3D untagged_addr(mm, address);
>
>         if (unlocked)
>                 fault_flags |=3D FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILL=
ABLE;
> @@ -2865,7 +2865,7 @@ static int internal_get_user_pages_fast(unsigned lo=
ng start,
>         if (!(gup_flags & FOLL_FAST_ONLY))
>                 might_lock_read(&current->mm->mmap_lock);
>
> -       start =3D untagged_addr(start) & PAGE_MASK;
> +       start =3D untagged_addr(current->mm, start) & PAGE_MASK;
>         len =3D nr_pages << PAGE_SHIFT;
>         if (check_add_overflow(start, len, &end))
>                 return 0;
> diff --git a/mm/madvise.c b/mm/madvise.c
> index d7b4f2602949..e3c668ddb099 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1373,7 +1373,7 @@ int do_madvise(struct mm_struct *mm, unsigned long =
start, size_t len_in, int beh
>         size_t len;
>         struct blk_plug plug;
>
> -       start =3D untagged_addr(start);
> +       start =3D untagged_addr(mm, start);
>
>         if (!madvise_behavior_valid(behavior))
>                 return -EINVAL;
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index d39b01fd52fe..a03b4d2bc26a 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1458,7 +1458,7 @@ static long kernel_mbind(unsigned long start, unsig=
ned long len,
>         int lmode =3D mode;
>         int err;
>
> -       start =3D untagged_addr(start);
> +       start =3D untagged_addr(current->mm, start);
>         err =3D sanitize_mpol_flags(&lmode, &mode_flags);
>         if (err)
>                 return err;
> @@ -1481,7 +1481,7 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned l=
ong, start, unsigned long, le
>         unsigned long end;
>         int err =3D -ENOENT;
>
> -       start =3D untagged_addr(start);
> +       start =3D untagged_addr(mm, start);
>         if (start & ~PAGE_MASK)
>                 return -EINVAL;
>         /*
> @@ -1684,7 +1684,7 @@ static int kernel_get_mempolicy(int __user *policy,
>         if (nmask !=3D NULL && maxnode < nr_node_ids)
>                 return -EINVAL;
>
> -       addr =3D untagged_addr(addr);
> +       addr =3D untagged_addr(current->mm, addr);
>
>         err =3D do_get_mempolicy(&pval, &nodes, addr, flags);
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index e51588e95f57..af05049b055b 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1714,7 +1714,7 @@ static int do_pages_move(struct mm_struct *mm, node=
mask_t task_nodes,
>                         goto out_flush;
>                 if (get_user(node, nodes + i))
>                         goto out_flush;
> -               addr =3D (unsigned long)untagged_addr(p);
> +               addr =3D (unsigned long)untagged_addr(mm, p);
>
>                 err =3D -ENODEV;
>                 if (node < 0 || node >=3D MAX_NUMNODES)
> diff --git a/mm/mincore.c b/mm/mincore.c
> index fa200c14185f..72c55bd9d184 100644
> --- a/mm/mincore.c
> +++ b/mm/mincore.c
> @@ -236,7 +236,7 @@ SYSCALL_DEFINE3(mincore, unsigned long, start, size_t=
, len,
>         unsigned long pages;
>         unsigned char *tmp;
>
> -       start =3D untagged_addr(start);
> +       start =3D untagged_addr(current->mm, start);
>
>         /* Check the start address: needs to be page-aligned.. */
>         if (start & ~PAGE_MASK)
> diff --git a/mm/mlock.c b/mm/mlock.c
> index 716caf851043..054168d3e648 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -571,7 +571,7 @@ static __must_check int do_mlock(unsigned long start,=
 size_t len, vm_flags_t fla
>         unsigned long lock_limit;
>         int error =3D -ENOMEM;
>
> -       start =3D untagged_addr(start);
> +       start =3D untagged_addr(current->mm, start);
>
>         if (!can_do_mlock())
>                 return -EPERM;
> @@ -634,7 +634,7 @@ SYSCALL_DEFINE2(munlock, unsigned long, start, size_t=
, len)
>  {
>         int ret;
>
> -       start =3D untagged_addr(start);
> +       start =3D untagged_addr(current->mm, start);
>
>         len =3D PAGE_ALIGN(len + (offset_in_page(start)));
>         start &=3D PAGE_MASK;
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 61e6135c54ef..1a7baf6b6b8e 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2926,7 +2926,7 @@ EXPORT_SYMBOL(vm_munmap);
>
>  SYSCALL_DEFINE2(munmap, unsigned long, addr, size_t, len)
>  {
> -       addr =3D untagged_addr(addr);
> +       addr =3D untagged_addr(current->mm, addr);
>         return __vm_munmap(addr, len, true);
>  }
>
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index ba5592655ee3..871e954f6155 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -622,7 +622,7 @@ static int do_mprotect_pkey(unsigned long start, size=
_t len,
>                                 (prot & PROT_READ);
>         struct mmu_gather tlb;
>
> -       start =3D untagged_addr(start);
> +       start =3D untagged_addr(current->mm, start);
>
>         prot &=3D ~(PROT_GROWSDOWN|PROT_GROWSUP);
>         if (grows =3D=3D (PROT_GROWSDOWN|PROT_GROWSUP)) /* can't be both =
*/
> diff --git a/mm/mremap.c b/mm/mremap.c
> index b522cd0259a0..f76648bc4f67 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -906,7 +906,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned=
 long, old_len,
>          *
>          * See Documentation/arm64/tagged-address-abi.rst for more inform=
ation.
>          */
> -       addr =3D untagged_addr(addr);
> +       addr =3D untagged_addr(mm, addr);
>
>         if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE | MREMAP_DONTUNMAP))
>                 return ret;
> diff --git a/mm/msync.c b/mm/msync.c
> index 137d1c104f3e..5fe989bd3c4b 100644
> --- a/mm/msync.c
> +++ b/mm/msync.c
> @@ -37,7 +37,7 @@ SYSCALL_DEFINE3(msync, unsigned long, start, size_t, le=
n, int, flags)
>         int unmapped_error =3D 0;
>         int error =3D -EINVAL;
>
> -       start =3D untagged_addr(start);
> +       start =3D untagged_addr(mm, start);
>
>         if (flags & ~(MS_ASYNC | MS_INVALIDATE | MS_SYNC))
>                 goto out;
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index a49df8988cd6..03f7ad0ebc8a 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1876,7 +1876,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
>                 return -EINVAL;
>         /* We can read the guest memory with __xxx_user() later on. */
>         if ((mem->userspace_addr & (PAGE_SIZE - 1)) ||
> -           (mem->userspace_addr !=3D untagged_addr(mem->userspace_addr))=
 ||
> +           (mem->userspace_addr !=3D untagged_addr(kvm->mm, mem->userspa=
ce_addr)) ||
>              !access_ok((void __user *)(unsigned long)mem->userspace_addr=
,
>                         mem->memory_size))
>                 return -EINVAL;
> --
> 2.35.1
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
