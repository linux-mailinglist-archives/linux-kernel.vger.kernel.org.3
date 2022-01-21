Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB29495ADC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 08:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348786AbiAUHgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 02:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379043AbiAUHfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 02:35:53 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BB1C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 23:35:52 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id v74so4875287pfc.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 23:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Hvv3OzpSP3DgWOXjZUEqtS8KSrYGm9AVRKurqA0p2g=;
        b=QSgYGhGYDXB1Dr6XGxdqxDiL3bN5AMz0iPXRnxr11ckfFWeg5cU9vbJyIHPnRUq4+s
         ZbLD0tKe0LzCBXogRE0sBUFg7HVrtfOtUuAU5KfMI3a4sKVtl2iHgv5xGMxF/Az/pwQL
         SBHBZMxGwfyKNZH3m0PbImofnaxEGtiy2IFF0qygUf4Mfvn6PdZ+s5BUlLpKGSPA6DlB
         PYTcKS2bYKVRHCks7J1t1miX4cLX2o/aCILZ5VmEFmZPONZjIJz4qNY4UrghcBIDzXgq
         xUtuUVdaA2F61jE32T2eZ2Q4+XhbLbswaJzrU2WGH6YT1z4lu0SBiPmqgpcDEQqbBE0L
         F+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Hvv3OzpSP3DgWOXjZUEqtS8KSrYGm9AVRKurqA0p2g=;
        b=fsM9PDo2iArSxzFFrrlGbfdDL1UjOvEywU+9Fd9OXQFIyXqh4EM64Zm9pbJArqGIVU
         dtfJ/DZZzYxLxA/D8RLN/MuDUnznqBDQ+DgNFdf3hfL2GG1bXIf7xarhoXJJ6sM+1MgR
         l5Ihzr1I6LFIJh0nHum3Knlc2ctR6qdj+CiM/W7C1wwbG9R2knQ6kAPjFWiNOxcTzfLq
         MaFP3Gs/pDE8n2t1un10pVcL82za17jZJfB7nWZqVEYmkpR4EdVATuIFnir5MCM2C8Na
         HD+a/5f3jh2fvHJcqPSkd0ZUcrFiilKFHuJ2gYP4f0Dg+65YyFPXs5AUaXTmIgWpjC6a
         n91w==
X-Gm-Message-State: AOAM532Dip/rr/NNQnVl8mXUQOkDxYZNLS2zwkoJrX3FjIzyybnIshBs
        SDhSgxysVXR5kWl3+rNGL1BWk3D11mdj2iflFqdpUQ==
X-Google-Smtp-Source: ABdhPJx+48zCbOjc/6CX4ePMmHr0t3Q47qTfTlh9BqX+m72O8mWZPKCZHPWK4zpwXAzAa+mKypHw/rUKKeXkS/Cbwhg=
X-Received: by 2002:a05:6a00:1592:b0:4c2:7f6e:c37d with SMTP id
 u18-20020a056a00159200b004c27f6ec37dmr2908262pfk.82.1642750551846; Thu, 20
 Jan 2022 23:35:51 -0800 (PST)
MIME-Version: 1.0
References: <20211122121844.867-1-shameerali.kolothum.thodi@huawei.com> <20211122121844.867-2-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20211122121844.867-2-shameerali.kolothum.thodi@huawei.com>
From:   Reiji Watanabe <reijiw@google.com>
Date:   Thu, 20 Jan 2022 23:35:35 -0800
Message-ID: <CAAeT=FwWNZ7O=oxGB5d0Pp2jVZVs71nCAGJTp9_+6fhuOK+dKw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] KVM: arm64: Introduce a new VMID allocator for KVM
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        jean-philippe@linaro.org, Marc Zyngier <maz@kernel.org>,
        linuxarm@huawei.com, jonathan.cameron@huawei.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 4:19 AM Shameer Kolothum
<shameerali.kolothum.thodi@huawei.com> wrote:
>
> A new VMID allocator for arm64 KVM use. This is based on
> arm64 ASID allocator algorithm.
>
> One major deviation from the ASID allocator is the way we
> flush the context. Unlike ASID allocator, we expect less
> frequent rollover in the case of VMIDs. Hence, instead of
> marking the CPU as flush_pending and issuing a local context
> invalidation on the next context switch, we  broadcast TLB
> flush + I-cache invalidation over the inner shareable domain
> on rollover.
>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  arch/arm64/include/asm/kvm_host.h |   4 +
>  arch/arm64/kvm/vmid.c             | 177 ++++++++++++++++++++++++++++++
>  2 files changed, 181 insertions(+)
>  create mode 100644 arch/arm64/kvm/vmid.c
>
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 2a5f7f38006f..f4a86a79ea4a 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -690,6 +690,10 @@ int kvm_arm_pvtime_get_attr(struct kvm_vcpu *vcpu,
>  int kvm_arm_pvtime_has_attr(struct kvm_vcpu *vcpu,
>                             struct kvm_device_attr *attr);
>
> +int kvm_arm_vmid_alloc_init(void);
> +void kvm_arm_vmid_alloc_free(void);
> +void kvm_arm_vmid_update(struct kvm_vmid *kvm_vmid);
> +
>  static inline void kvm_arm_pvtime_vcpu_init(struct kvm_vcpu_arch *vcpu_arch)
>  {
>         vcpu_arch->steal.base = GPA_INVALID;
> diff --git a/arch/arm64/kvm/vmid.c b/arch/arm64/kvm/vmid.c
> new file mode 100644
> index 000000000000..aa01c97f7df0
> --- /dev/null
> +++ b/arch/arm64/kvm/vmid.c
> @@ -0,0 +1,177 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * VMID allocator.
> + *
> + * Based on Arm64 ASID allocator algorithm.
> + * Please refer arch/arm64/mm/context.c for detailed
> + * comments on algorithm.
> + *
> + * Copyright (C) 2002-2003 Deep Blue Solutions Ltd, all rights reserved.
> + * Copyright (C) 2012 ARM Ltd.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +
> +#include <asm/kvm_asm.h>
> +#include <asm/kvm_mmu.h>
> +
> +static unsigned int kvm_arm_vmid_bits;
> +static DEFINE_RAW_SPINLOCK(cpu_vmid_lock);
> +
> +static atomic64_t vmid_generation;
> +static unsigned long *vmid_map;
> +
> +static DEFINE_PER_CPU(atomic64_t, active_vmids);
> +static DEFINE_PER_CPU(u64, reserved_vmids);
> +
> +#define VMID_MASK              (~GENMASK(kvm_arm_vmid_bits - 1, 0))
> +#define VMID_FIRST_VERSION     (1UL << kvm_arm_vmid_bits)
> +
> +#define NUM_USER_VMIDS         VMID_FIRST_VERSION
> +#define vmid2idx(vmid)         ((vmid) & ~VMID_MASK)
> +#define idx2vmid(idx)          vmid2idx(idx)
> +
> +#define vmid_gen_match(vmid) \
> +       (!(((vmid) ^ atomic64_read(&vmid_generation)) >> kvm_arm_vmid_bits))
> +
> +static void flush_context(void)
> +{
> +       int cpu;
> +       u64 vmid;
> +
> +       bitmap_clear(vmid_map, 0, NUM_USER_VMIDS);
> +
> +       for_each_possible_cpu(cpu) {
> +               vmid = atomic64_xchg_relaxed(&per_cpu(active_vmids, cpu), 0);
> +
> +               /* Preserve reserved VMID */
> +               if (vmid == 0)
> +                       vmid = per_cpu(reserved_vmids, cpu);
> +               __set_bit(vmid2idx(vmid), vmid_map);
> +               per_cpu(reserved_vmids, cpu) = vmid;
> +       }
> +
> +       /*
> +        * Unlike ASID allocator, we expect less frequent rollover in
> +        * case of VMIDs. Hence, instead of marking the CPU as
> +        * flush_pending and issuing a local context invalidation on
> +        * the next context-switch, we broadcast TLB flush + I-cache
> +        * invalidation over the inner shareable domain on rollover.
> +        */
> +        kvm_call_hyp(__kvm_flush_vm_context);
> +}
> +
> +static bool check_update_reserved_vmid(u64 vmid, u64 newvmid)
> +{
> +       int cpu;
> +       bool hit = false;
> +
> +       /*
> +        * Iterate over the set of reserved VMIDs looking for a match
> +        * and update to use newvmid (i.e. the same VMID in the current
> +        * generation).
> +        */
> +       for_each_possible_cpu(cpu) {
> +               if (per_cpu(reserved_vmids, cpu) == vmid) {
> +                       hit = true;
> +                       per_cpu(reserved_vmids, cpu) = newvmid;
> +               }
> +       }

Once updating reserved_vmids gets done for the all CPUs, it appears
that the function doesn't need to iterate over the set of reserved
VMIDs (correct ?). So, I'm wondering if KVM can manage the number of
CPUs for which reserved_vmids need to get updated so that the function
can skip the loop when the number is zero.  I'm not sure how likely
that would help though.
(Since every vmid allocation for non-new guest needs to iterate over
 reserved_vmids holding cpu_vmid_lock, I'm a bit concerned about the
 performance impact on systems with a large number of CPUs.)

Thanks,
Reiji

> +
> +       return hit;
> +}
> +
> +static u64 new_vmid(struct kvm_vmid *kvm_vmid)
> +{
> +       static u32 cur_idx = 1;
> +       u64 vmid = atomic64_read(&kvm_vmid->id);
> +       u64 generation = atomic64_read(&vmid_generation);
> +
> +       if (vmid != 0) {
> +               u64 newvmid = generation | (vmid & ~VMID_MASK);
> +
> +               if (check_update_reserved_vmid(vmid, newvmid)) {
> +                       atomic64_set(&kvm_vmid->id, newvmid);
> +                       return newvmid;
> +               }
> +
> +               if (!__test_and_set_bit(vmid2idx(vmid), vmid_map)) {
> +                       atomic64_set(&kvm_vmid->id, newvmid);
> +                       return newvmid;
> +               }
> +       }
> +
> +       vmid = find_next_zero_bit(vmid_map, NUM_USER_VMIDS, cur_idx);
> +       if (vmid != NUM_USER_VMIDS)
> +               goto set_vmid;
> +
> +       /* We're out of VMIDs, so increment the global generation count */
> +       generation = atomic64_add_return_relaxed(VMID_FIRST_VERSION,
> +                                                &vmid_generation);
> +       flush_context();
> +
> +       /* We have more VMIDs than CPUs, so this will always succeed */
> +       vmid = find_next_zero_bit(vmid_map, NUM_USER_VMIDS, 1);
> +
> +set_vmid:
> +       __set_bit(vmid, vmid_map);
> +       cur_idx = vmid;
> +       vmid = idx2vmid(vmid) | generation;
> +       atomic64_set(&kvm_vmid->id, vmid);
> +       return vmid;
> +}
> +
> +void kvm_arm_vmid_update(struct kvm_vmid *kvm_vmid)
> +{
> +       unsigned long flags;
> +       u64 vmid, old_active_vmid;
> +
> +       vmid = atomic64_read(&kvm_vmid->id);
> +
> +       /*
> +        * Please refer comments in check_and_switch_context() in
> +        * arch/arm64/mm/context.c.
> +        */
> +       old_active_vmid = atomic64_read(this_cpu_ptr(&active_vmids));
> +       if (old_active_vmid && vmid_gen_match(vmid) &&
> +           atomic64_cmpxchg_relaxed(this_cpu_ptr(&active_vmids),
> +                                    old_active_vmid, vmid))
> +               return;
> +
> +       raw_spin_lock_irqsave(&cpu_vmid_lock, flags);
> +
> +       /* Check that our VMID belongs to the current generation. */
> +       vmid = atomic64_read(&kvm_vmid->id);
> +       if (!vmid_gen_match(vmid))
> +               vmid = new_vmid(kvm_vmid);
> +
> +       atomic64_set(this_cpu_ptr(&active_vmids), vmid);
> +       raw_spin_unlock_irqrestore(&cpu_vmid_lock, flags);
> +}
> +
> +/*
> + * Initialize the VMID allocator
> + */
> +int kvm_arm_vmid_alloc_init(void)
> +{
> +       kvm_arm_vmid_bits = kvm_get_vmid_bits();
> +
> +       /*
> +        * Expect allocation after rollover to fail if we don't have
> +        * at least one more VMID than CPUs. VMID #0 is always reserved.
> +        */
> +       WARN_ON(NUM_USER_VMIDS - 1 <= num_possible_cpus());
> +       atomic64_set(&vmid_generation, VMID_FIRST_VERSION);
> +       vmid_map = kcalloc(BITS_TO_LONGS(NUM_USER_VMIDS),
> +                          sizeof(*vmid_map), GFP_KERNEL);
> +       if (!vmid_map)
> +               return -ENOMEM;
> +
> +       return 0;
> +}
> +
> +void kvm_arm_vmid_alloc_free(void)
> +{
> +       kfree(vmid_map);
> +}
> --
> 2.17.1
>
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
