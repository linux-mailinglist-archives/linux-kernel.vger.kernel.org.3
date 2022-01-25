Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A196749BE71
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 23:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbiAYW0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 17:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbiAYW0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 17:26:08 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E3DC06173B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 14:26:08 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id r126so2278105wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 14:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ufMQ+0vI9ePE9kFETlfuiGfM5slPMjHE1KYHVYml3nw=;
        b=Mc+DIgR6FIkoORaubeT9omFq2e3hC50GQnXjSqBFlYRR8hD6O+dSJ7vba/PQ9yuSOh
         wsyCnCa34bD3nLmGSEBJssoKkeG8NTrGXv0JiBmElVJFRHYlxtXCd2+GKjapDg24fohk
         miCslVIpq+ZksX/yhALD/a7oThQiM+Xw9JpsmbqNoK/nrYfXpb7x+l7KH+mESBeozbYs
         naBHZo3Quud+vJay8nfByLq6yGUWiSOmhM9rmu2COONOr7PAZq9pj8k9LaJOx9Km2BPm
         6LnCkBwI0FlyuDPfms4ohymUt3M82Mu9nHbsbj1VQ4Ks8whh9HxNjP9k+Fq59XytPBa0
         vp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ufMQ+0vI9ePE9kFETlfuiGfM5slPMjHE1KYHVYml3nw=;
        b=cfOWpuQeKqK/uGBb7IS7BaANtRB27rjlK1bzD9EHgredbTemUhCfimESd9hPauVmFg
         5K7uqv6fc1hANg3ODBMNtIm8Nd0XHIzaNY7yqf2oB0ru7lY2K/RG6JvoZfh1NyFDnRKo
         ert5EvivzBZOKMdm0/DNismZSTAIJsp080uwUrJ1uM9ZbpIuspxQmk+1J4iqQTxwpCoI
         0MqC2C1NbB2EcC/de/m8XjbwVKhJRFnrICZLYuZuCcdOl2TBY7NrV7K/gf/l9S6TMWvb
         Z0coKW5XmIrWLvPgzXhKMBPNWPFJ35rEiNfB5ma9uZYel2zJC5H4xyBz4Uv9xkNSycaT
         28wA==
X-Gm-Message-State: AOAM530y8JXL8edzJPJ0qZ8F8nTEp3vRnx2jNdPU73DYynWwon/W2JTS
        vtY7gBIU0xsb43BR4QkCszfh9g==
X-Google-Smtp-Source: ABdhPJyVXWH6D4oQdy6J+03zLVJGy185NgvASO1VPV/H/Xy55D348DEXfpfq1oDL0bQKEml7n6rNxw==
X-Received: by 2002:a05:600c:5107:: with SMTP id o7mr4841249wms.161.1643149566373;
        Tue, 25 Jan 2022 14:26:06 -0800 (PST)
Received: from smtpclient.apple (global-5-142.nat-2.net.cam.ac.uk. [131.111.5.142])
        by smtp.gmail.com with ESMTPSA id n14sm1472276wmq.42.2022.01.25.14.26.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jan 2022 14:26:05 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH v3 6/6] RISC-V: Do not use cpumask data structure for
 hartid bitmap
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20220120090918.2646626-7-atishp@rivosinc.com>
Date:   Tue, 25 Jan 2022 22:26:04 +0000
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree <devicetree@vger.kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1AA3005C-E9C8-4E4B-900D-DD48B37CEA41@jrtc27.com>
References: <20220120090918.2646626-1-atishp@rivosinc.com>
 <20220120090918.2646626-7-atishp@rivosinc.com>
To:     Atish Patra <atishp@rivosinc.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Jan 2022, at 09:09, Atish Patra <atishp@rivosinc.com> wrote:
>=20
> Currently, SBI APIs accept a hartmask that is generated from struct
> cpumask. Cpumask data structure can hold upto NR_CPUs value. Thus, it
> is not the correct data structure for hartids as it can be higher
> than NR_CPUs for platforms with sparse or discontguous hartids.
>=20
> Remove all association between hartid mask and struct cpumask.
>=20
> Reviewed-by: Anup Patel <anup@brainfault.org> (For Linux RISC-V =
changes)
> Acked-by: Anup Patel <anup@brainfault.org> (For KVM RISC-V changes)
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
> arch/riscv/include/asm/sbi.h      |  19 +--
> arch/riscv/include/asm/smp.h      |   2 -
> arch/riscv/kernel/sbi.c           | 189 +++++++++++++++++-------------
> arch/riscv/kernel/setup.c         |  10 --
> arch/riscv/kernel/smpboot.c       |   2 +-
> arch/riscv/kvm/mmu.c              |   4 +-
> arch/riscv/kvm/vcpu_sbi_replace.c |  11 +-
> arch/riscv/kvm/vcpu_sbi_v01.c     |  11 +-
> arch/riscv/kvm/vmid.c             |   4 +-
> arch/riscv/mm/cacheflush.c        |   5 +-
> arch/riscv/mm/tlbflush.c          |   9 +-
> 11 files changed, 130 insertions(+), 136 deletions(-)
>=20
> diff --git a/arch/riscv/include/asm/sbi.h =
b/arch/riscv/include/asm/sbi.h
> index 26ba6f2d7a40..d1c37479d828 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -8,6 +8,7 @@
> #define _ASM_RISCV_SBI_H
>=20
> #include <linux/types.h>
> +#include <linux/cpumask.h>
>=20
> #ifdef CONFIG_RISCV_SBI
> enum sbi_ext_id {
> @@ -128,27 +129,27 @@ long sbi_get_mimpid(void);
> void sbi_set_timer(uint64_t stime_value);
> void sbi_shutdown(void);
> void sbi_clear_ipi(void);
> -int sbi_send_ipi(const unsigned long *hart_mask);
> -int sbi_remote_fence_i(const unsigned long *hart_mask);
> -int sbi_remote_sfence_vma(const unsigned long *hart_mask,
> +int sbi_send_ipi(const struct cpumask *cpu_mask);
> +int sbi_remote_fence_i(const struct cpumask *cpu_mask);
> +int sbi_remote_sfence_vma(const struct cpumask *cpu_mask,
> 			   unsigned long start,
> 			   unsigned long size);
>=20
> -int sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
> +int sbi_remote_sfence_vma_asid(const struct cpumask *cpu_mask,
> 				unsigned long start,
> 				unsigned long size,
> 				unsigned long asid);
> -int sbi_remote_hfence_gvma(const unsigned long *hart_mask,
> +int sbi_remote_hfence_gvma(const struct cpumask *cpu_mask,
> 			   unsigned long start,
> 			   unsigned long size);
> -int sbi_remote_hfence_gvma_vmid(const unsigned long *hart_mask,
> +int sbi_remote_hfence_gvma_vmid(const struct cpumask *cpu_mask,
> 				unsigned long start,
> 				unsigned long size,
> 				unsigned long vmid);
> -int sbi_remote_hfence_vvma(const unsigned long *hart_mask,
> +int sbi_remote_hfence_vvma(const struct cpumask *cpu_mask,
> 			   unsigned long start,
> 			   unsigned long size);
> -int sbi_remote_hfence_vvma_asid(const unsigned long *hart_mask,
> +int sbi_remote_hfence_vvma_asid(const struct cpumask *cpu_mask,
> 				unsigned long start,
> 				unsigned long size,
> 				unsigned long asid);
> @@ -183,7 +184,7 @@ static inline unsigned long =
sbi_mk_version(unsigned long major,
>=20
> int sbi_err_map_linux_errno(int err);
> #else /* CONFIG_RISCV_SBI */
> -static inline int sbi_remote_fence_i(const unsigned long *hart_mask) =
{ return -1; }
> +static inline int sbi_remote_fence_i(const struct cpumask *cpu_mask) =
{ return -1; }
> static inline void sbi_init(void) {}
> #endif /* CONFIG_RISCV_SBI */
> #endif /* _ASM_RISCV_SBI_H */
> diff --git a/arch/riscv/include/asm/smp.h =
b/arch/riscv/include/asm/smp.h
> index 6ad749f42807..23170c933d73 100644
> --- a/arch/riscv/include/asm/smp.h
> +++ b/arch/riscv/include/asm/smp.h
> @@ -92,8 +92,6 @@ static inline void riscv_clear_ipi(void)
>=20
> #endif /* CONFIG_SMP */
>=20
> -void riscv_cpuid_to_hartid_mask(const struct cpumask *in, struct =
cpumask *out);
> -
> #if defined(CONFIG_HOTPLUG_CPU) && (CONFIG_SMP)
> bool cpu_has_hotplug(unsigned int cpu);
> #else
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index 9a84f0cb5175..f72527fcb347 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -16,8 +16,8 @@ unsigned long sbi_spec_version __ro_after_init =3D =
SBI_SPEC_VERSION_DEFAULT;
> EXPORT_SYMBOL(sbi_spec_version);
>=20
> static void (*__sbi_set_timer)(uint64_t stime) __ro_after_init;
> -static int (*__sbi_send_ipi)(const unsigned long *hart_mask) =
__ro_after_init;
> -static int (*__sbi_rfence)(int fid, const unsigned long *hart_mask,
> +static int (*__sbi_send_ipi)(const struct cpumask *cpu_mask) =
__ro_after_init;
> +static int (*__sbi_rfence)(int fid, const struct cpumask *cpu_mask,
> 			   unsigned long start, unsigned long size,
> 			   unsigned long arg4, unsigned long arg5) =
__ro_after_init;
>=20
> @@ -67,6 +67,30 @@ int sbi_err_map_linux_errno(int err)
> EXPORT_SYMBOL(sbi_err_map_linux_errno);
>=20
> #ifdef CONFIG_RISCV_SBI_V01
> +static unsigned long __sbi_v01_cpumask_to_hartmask(const struct =
cpumask *cpu_mask)
> +{
> +	unsigned long cpuid, hartid;
> +	unsigned long hmask =3D 0;
> +
> +	/*
> +	 * There is no maximum hartid concept in RISC-V and NR_CPUS must =
not be
> +	 * associated with hartid. As SBI v0.1 is only kept for backward =
compatibility
> +	 * and will be removed in the future, there is no point in =
supporting hartid
> +	 * greater than BITS_PER_LONG (32 for RV32 and 64 for RV64). =
Ideally, SBI v0.2
> +	 * should be used for platforms with hartid greater than =
BITS_PER_LONG.
> +	 */
> +	for_each_cpu(cpuid, cpu_mask) {
> +		hartid =3D cpuid_to_hartid_map(cpuid);
> +		if (hartid >=3D BITS_PER_LONG) {
> +			pr_warn("Unable to send any request to hartid > =
BITS_PER_LONG for SBI v0.1\n");
> +			break;
> +		}
> +		hmask |=3D 1 << hartid;

This should be 1UL otherwise hartid 31 and up cause UB.

> +	}
> +
> +	return hmask;
> +}
> +
> /**
>  * sbi_console_putchar() - Writes given character to the console =
device.
>  * @ch: The data to be written to the console.
> @@ -132,33 +156,44 @@ static void __sbi_set_timer_v01(uint64_t =
stime_value)
> #endif
> }
>=20
> -static int __sbi_send_ipi_v01(const unsigned long *hart_mask)
> +static int __sbi_send_ipi_v01(const struct cpumask *cpu_mask)
> {
> -	sbi_ecall(SBI_EXT_0_1_SEND_IPI, 0, (unsigned long)hart_mask,
> +	unsigned long hart_mask;
> +
> +	if (!cpu_mask)
> +		cpu_mask =3D cpu_online_mask;
> +	hart_mask =3D __sbi_v01_cpumask_to_hartmask(cpu_mask);
> +
> +	sbi_ecall(SBI_EXT_0_1_SEND_IPI, 0, (unsigned long)(&hart_mask),
> 		  0, 0, 0, 0, 0);
> 	return 0;
> }
>=20
> -static int __sbi_rfence_v01(int fid, const unsigned long *hart_mask,
> +static int __sbi_rfence_v01(int fid, const struct cpumask *cpu_mask,
> 			    unsigned long start, unsigned long size,
> 			    unsigned long arg4, unsigned long arg5)
> {
> 	int result =3D 0;
> +	unsigned long hart_mask;
> +
> +	if (!cpu_mask)
> +		cpu_mask =3D cpu_online_mask;
> +	hart_mask =3D __sbi_v01_cpumask_to_hartmask(cpu_mask);
>=20
> 	/* v0.2 function IDs are equivalent to v0.1 extension IDs */
> 	switch (fid) {
> 	case SBI_EXT_RFENCE_REMOTE_FENCE_I:
> 		sbi_ecall(SBI_EXT_0_1_REMOTE_FENCE_I, 0,
> -			  (unsigned long)hart_mask, 0, 0, 0, 0, 0);
> +			  (unsigned long)&hart_mask, 0, 0, 0, 0, 0);
> 		break;
> 	case SBI_EXT_RFENCE_REMOTE_SFENCE_VMA:
> 		sbi_ecall(SBI_EXT_0_1_REMOTE_SFENCE_VMA, 0,
> -			  (unsigned long)hart_mask, start, size,
> +			  (unsigned long)&hart_mask, start, size,
> 			  0, 0, 0);
> 		break;
> 	case SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID:
> 		sbi_ecall(SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID, 0,
> -			  (unsigned long)hart_mask, start, size,
> +			  (unsigned long)&hart_mask, start, size,
> 			  arg4, 0, 0);
> 		break;
> 	default:
> @@ -180,7 +215,7 @@ static void __sbi_set_timer_v01(uint64_t =
stime_value)
> 		sbi_major_version(), sbi_minor_version());
> }
>=20
> -static int __sbi_send_ipi_v01(const unsigned long *hart_mask)
> +static int __sbi_send_ipi_v01(const struct cpumask *cpu_mask)
> {
> 	pr_warn("IPI extension is not available in SBI v%lu.%lu\n",
> 		sbi_major_version(), sbi_minor_version());
> @@ -188,7 +223,7 @@ static int __sbi_send_ipi_v01(const unsigned long =
*hart_mask)
> 	return 0;
> }
>=20
> -static int __sbi_rfence_v01(int fid, const unsigned long *hart_mask,
> +static int __sbi_rfence_v01(int fid, const struct cpumask *cpu_mask,
> 			    unsigned long start, unsigned long size,
> 			    unsigned long arg4, unsigned long arg5)
> {
> @@ -212,37 +247,33 @@ static void __sbi_set_timer_v02(uint64_t =
stime_value)
> #endif
> }
>=20
> -static int __sbi_send_ipi_v02(const unsigned long *hart_mask)
> +static int __sbi_send_ipi_v02(const struct cpumask *cpu_mask)
> {
> -	unsigned long hartid, hmask_val, hbase;
> -	struct cpumask tmask;
> +	unsigned long hartid, cpuid, hmask =3D 0, hbase =3D 0;
> 	struct sbiret ret =3D {0};
> 	int result;
>=20
> -	if (!hart_mask || !(*hart_mask)) {
> -		riscv_cpuid_to_hartid_mask(cpu_online_mask, &tmask);
> -		hart_mask =3D cpumask_bits(&tmask);
> -	}
> +	if (!cpu_mask)
> +		cpu_mask =3D cpu_online_mask;

This is a change in behaviour. Are you sure nothing passes an empty =
mask?

> -	hmask_val =3D 0;
> -	hbase =3D 0;
> -	for_each_set_bit(hartid, hart_mask, NR_CPUS) {
> -		if (hmask_val && ((hbase + BITS_PER_LONG) <=3D hartid)) =
{
> +	for_each_cpu(cpuid, cpu_mask) {
> +		hartid =3D cpuid_to_hartid_map(cpuid);
> +		if (hmask && ((hbase + BITS_PER_LONG) <=3D hartid)) {
> 			ret =3D sbi_ecall(SBI_EXT_IPI, =
SBI_EXT_IPI_SEND_IPI,
> -					hmask_val, hbase, 0, 0, 0, 0);
> +					hmask, hbase, 0, 0, 0, 0);
> 			if (ret.error)
> 				goto ecall_failed;
> -			hmask_val =3D 0;
> +			hmask =3D 0;
> 			hbase =3D 0;
> 		}
> -		if (!hmask_val)
> +		if (!hmask)
> 			hbase =3D hartid;
> -		hmask_val |=3D 1UL << (hartid - hbase);
> +		hmask |=3D 1UL << (hartid - hbase);
> 	}
>=20
> -	if (hmask_val) {
> +	if (hmask) {
> 		ret =3D sbi_ecall(SBI_EXT_IPI, SBI_EXT_IPI_SEND_IPI,
> -				hmask_val, hbase, 0, 0, 0, 0);
> +				hmask, hbase, 0, 0, 0, 0);
> 		if (ret.error)
> 			goto ecall_failed;
> 	}
> @@ -252,11 +283,11 @@ static int __sbi_send_ipi_v02(const unsigned =
long *hart_mask)
> ecall_failed:
> 	result =3D sbi_err_map_linux_errno(ret.error);
> 	pr_err("%s: hbase =3D [%lu] hmask =3D [0x%lx] failed (error =
[%d])\n",
> -	       __func__, hbase, hmask_val, result);
> +	       __func__, hbase, hmask, result);
> 	return result;
> }
>=20
> -static int __sbi_rfence_v02_call(unsigned long fid, unsigned long =
hmask_val,
> +static int __sbi_rfence_v02_call(unsigned long fid, unsigned long =
hmask,
> 				 unsigned long hbase, unsigned long =
start,
> 				 unsigned long size, unsigned long arg4,
> 				 unsigned long arg5)
> @@ -267,31 +298,31 @@ static int __sbi_rfence_v02_call(unsigned long =
fid, unsigned long hmask_val,
>=20
> 	switch (fid) {
> 	case SBI_EXT_RFENCE_REMOTE_FENCE_I:
> -		ret =3D sbi_ecall(ext, fid, hmask_val, hbase, 0, 0, 0, =
0);
> +		ret =3D sbi_ecall(ext, fid, hmask, hbase, 0, 0, 0, 0);
> 		break;
> 	case SBI_EXT_RFENCE_REMOTE_SFENCE_VMA:
> -		ret =3D sbi_ecall(ext, fid, hmask_val, hbase, start,
> +		ret =3D sbi_ecall(ext, fid, hmask, hbase, start,
> 				size, 0, 0);
> 		break;
> 	case SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID:
> -		ret =3D sbi_ecall(ext, fid, hmask_val, hbase, start,
> +		ret =3D sbi_ecall(ext, fid, hmask, hbase, start,
> 				size, arg4, 0);
> 		break;
>=20
> 	case SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA:
> -		ret =3D sbi_ecall(ext, fid, hmask_val, hbase, start,
> +		ret =3D sbi_ecall(ext, fid, hmask, hbase, start,
> 				size, 0, 0);
> 		break;
> 	case SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA_VMID:
> -		ret =3D sbi_ecall(ext, fid, hmask_val, hbase, start,
> +		ret =3D sbi_ecall(ext, fid, hmask, hbase, start,
> 				size, arg4, 0);
> 		break;
> 	case SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA:
> -		ret =3D sbi_ecall(ext, fid, hmask_val, hbase, start,
> +		ret =3D sbi_ecall(ext, fid, hmask, hbase, start,
> 				size, 0, 0);
> 		break;
> 	case SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA_ASID:
> -		ret =3D sbi_ecall(ext, fid, hmask_val, hbase, start,
> +		ret =3D sbi_ecall(ext, fid, hmask, hbase, start,
> 				size, arg4, 0);
> 		break;
> 	default:
> @@ -303,43 +334,39 @@ static int __sbi_rfence_v02_call(unsigned long =
fid, unsigned long hmask_val,
> 	if (ret.error) {
> 		result =3D sbi_err_map_linux_errno(ret.error);
> 		pr_err("%s: hbase =3D [%lu] hmask =3D [0x%lx] failed =
(error [%d])\n",
> -		       __func__, hbase, hmask_val, result);
> +		       __func__, hbase, hmask, result);
> 	}
>=20
> 	return result;
> }
>=20
> -static int __sbi_rfence_v02(int fid, const unsigned long *hart_mask,
> +static int __sbi_rfence_v02(int fid, const struct cpumask *cpu_mask,
> 			    unsigned long start, unsigned long size,
> 			    unsigned long arg4, unsigned long arg5)
> {
> -	unsigned long hmask_val, hartid, hbase;
> -	struct cpumask tmask;
> +	unsigned long hartid, cpuid, hmask =3D 0, hbase =3D 0;
> 	int result;
>=20
> -	if (!hart_mask || !(*hart_mask)) {
> -		riscv_cpuid_to_hartid_mask(cpu_online_mask, &tmask);
> -		hart_mask =3D cpumask_bits(&tmask);
> -	}
> +	if (!cpu_mask)
> +		cpu_mask =3D cpu_online_mask;

As with __sbi_send_ipi_v02.

Jess

> -	hmask_val =3D 0;
> -	hbase =3D 0;
> -	for_each_set_bit(hartid, hart_mask, NR_CPUS) {
> -		if (hmask_val && ((hbase + BITS_PER_LONG) <=3D hartid)) =
{
> -			result =3D __sbi_rfence_v02_call(fid, hmask_val, =
hbase,
> +	for_each_cpu(cpuid, cpu_mask) {
> +		hartid =3D cpuid_to_hartid_map(cpuid);
> +		if (hmask && ((hbase + BITS_PER_LONG) <=3D hartid)) {
> +			result =3D __sbi_rfence_v02_call(fid, hmask, =
hbase,
> 						       start, size, =
arg4, arg5);
> 			if (result)
> 				return result;
> -			hmask_val =3D 0;
> +			hmask =3D 0;
> 			hbase =3D 0;
> 		}
> -		if (!hmask_val)
> +		if (!hmask)
> 			hbase =3D hartid;
> -		hmask_val |=3D 1UL << (hartid - hbase);
> +		hmask |=3D 1UL << (hartid - hbase);
> 	}
>=20
> -	if (hmask_val) {
> -		result =3D __sbi_rfence_v02_call(fid, hmask_val, hbase,
> +	if (hmask) {
> +		result =3D __sbi_rfence_v02_call(fid, hmask, hbase,
> 					       start, size, arg4, arg5);
> 		if (result)
> 			return result;
> @@ -361,44 +388,44 @@ void sbi_set_timer(uint64_t stime_value)
>=20
> /**
>  * sbi_send_ipi() - Send an IPI to any hart.
> - * @hart_mask: A cpu mask containing all the target harts.
> + * @cpu_mask: A cpu mask containing all the target harts.
>  *
>  * Return: 0 on success, appropriate linux error code otherwise.
>  */
> -int sbi_send_ipi(const unsigned long *hart_mask)
> +int sbi_send_ipi(const struct cpumask *cpu_mask)
> {
> -	return __sbi_send_ipi(hart_mask);
> +	return __sbi_send_ipi(cpu_mask);
> }
> EXPORT_SYMBOL(sbi_send_ipi);
>=20
> /**
>  * sbi_remote_fence_i() - Execute FENCE.I instruction on given remote =
harts.
> - * @hart_mask: A cpu mask containing all the target harts.
> + * @cpu_mask: A cpu mask containing all the target harts.
>  *
>  * Return: 0 on success, appropriate linux error code otherwise.
>  */
> -int sbi_remote_fence_i(const unsigned long *hart_mask)
> +int sbi_remote_fence_i(const struct cpumask *cpu_mask)
> {
> 	return __sbi_rfence(SBI_EXT_RFENCE_REMOTE_FENCE_I,
> -			    hart_mask, 0, 0, 0, 0);
> +			    cpu_mask, 0, 0, 0, 0);
> }
> EXPORT_SYMBOL(sbi_remote_fence_i);
>=20
> /**
>  * sbi_remote_sfence_vma() - Execute SFENCE.VMA instructions on given =
remote
>  *			     harts for the specified virtual address =
range.
> - * @hart_mask: A cpu mask containing all the target harts.
> + * @cpu_mask: A cpu mask containing all the target harts.
>  * @start: Start of the virtual address
>  * @size: Total size of the virtual address range.
>  *
>  * Return: 0 on success, appropriate linux error code otherwise.
>  */
> -int sbi_remote_sfence_vma(const unsigned long *hart_mask,
> +int sbi_remote_sfence_vma(const struct cpumask *cpu_mask,
> 			   unsigned long start,
> 			   unsigned long size)
> {
> 	return __sbi_rfence(SBI_EXT_RFENCE_REMOTE_SFENCE_VMA,
> -			    hart_mask, start, size, 0, 0);
> +			    cpu_mask, start, size, 0, 0);
> }
> EXPORT_SYMBOL(sbi_remote_sfence_vma);
>=20
> @@ -406,38 +433,38 @@ EXPORT_SYMBOL(sbi_remote_sfence_vma);
>  * sbi_remote_sfence_vma_asid() - Execute SFENCE.VMA instructions on =
given
>  * remote harts for a virtual address range belonging to a specific =
ASID.
>  *
> - * @hart_mask: A cpu mask containing all the target harts.
> + * @cpu_mask: A cpu mask containing all the target harts.
>  * @start: Start of the virtual address
>  * @size: Total size of the virtual address range.
>  * @asid: The value of address space identifier (ASID).
>  *
>  * Return: 0 on success, appropriate linux error code otherwise.
>  */
> -int sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
> +int sbi_remote_sfence_vma_asid(const struct cpumask *cpu_mask,
> 				unsigned long start,
> 				unsigned long size,
> 				unsigned long asid)
> {
> 	return __sbi_rfence(SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID,
> -			    hart_mask, start, size, asid, 0);
> +			    cpu_mask, start, size, asid, 0);
> }
> EXPORT_SYMBOL(sbi_remote_sfence_vma_asid);
>=20
> /**
>  * sbi_remote_hfence_gvma() - Execute HFENCE.GVMA instructions on =
given remote
>  *			   harts for the specified guest physical =
address range.
> - * @hart_mask: A cpu mask containing all the target harts.
> + * @cpu_mask: A cpu mask containing all the target harts.
>  * @start: Start of the guest physical address
>  * @size: Total size of the guest physical address range.
>  *
>  * Return: None
>  */
> -int sbi_remote_hfence_gvma(const unsigned long *hart_mask,
> +int sbi_remote_hfence_gvma(const struct cpumask *cpu_mask,
> 			   unsigned long start,
> 			   unsigned long size)
> {
> 	return __sbi_rfence(SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA,
> -			    hart_mask, start, size, 0, 0);
> +			    cpu_mask, start, size, 0, 0);
> }
> EXPORT_SYMBOL_GPL(sbi_remote_hfence_gvma);
>=20
> @@ -445,38 +472,38 @@ EXPORT_SYMBOL_GPL(sbi_remote_hfence_gvma);
>  * sbi_remote_hfence_gvma_vmid() - Execute HFENCE.GVMA instructions on =
given
>  * remote harts for a guest physical address range belonging to a =
specific VMID.
>  *
> - * @hart_mask: A cpu mask containing all the target harts.
> + * @cpu_mask: A cpu mask containing all the target harts.
>  * @start: Start of the guest physical address
>  * @size: Total size of the guest physical address range.
>  * @vmid: The value of guest ID (VMID).
>  *
>  * Return: 0 if success, Error otherwise.
>  */
> -int sbi_remote_hfence_gvma_vmid(const unsigned long *hart_mask,
> +int sbi_remote_hfence_gvma_vmid(const struct cpumask *cpu_mask,
> 				unsigned long start,
> 				unsigned long size,
> 				unsigned long vmid)
> {
> 	return __sbi_rfence(SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA_VMID,
> -			    hart_mask, start, size, vmid, 0);
> +			    cpu_mask, start, size, vmid, 0);
> }
> EXPORT_SYMBOL(sbi_remote_hfence_gvma_vmid);
>=20
> /**
>  * sbi_remote_hfence_vvma() - Execute HFENCE.VVMA instructions on =
given remote
>  *			     harts for the current guest virtual address =
range.
> - * @hart_mask: A cpu mask containing all the target harts.
> + * @cpu_mask: A cpu mask containing all the target harts.
>  * @start: Start of the current guest virtual address
>  * @size: Total size of the current guest virtual address range.
>  *
>  * Return: None
>  */
> -int sbi_remote_hfence_vvma(const unsigned long *hart_mask,
> +int sbi_remote_hfence_vvma(const struct cpumask *cpu_mask,
> 			   unsigned long start,
> 			   unsigned long size)
> {
> 	return __sbi_rfence(SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA,
> -			    hart_mask, start, size, 0, 0);
> +			    cpu_mask, start, size, 0, 0);
> }
> EXPORT_SYMBOL(sbi_remote_hfence_vvma);
>=20
> @@ -485,20 +512,20 @@ EXPORT_SYMBOL(sbi_remote_hfence_vvma);
>  * remote harts for current guest virtual address range belonging to a =
specific
>  * ASID.
>  *
> - * @hart_mask: A cpu mask containing all the target harts.
> + * @cpu_mask: A cpu mask containing all the target harts.
>  * @start: Start of the current guest virtual address
>  * @size: Total size of the current guest virtual address range.
>  * @asid: The value of address space identifier (ASID).
>  *
>  * Return: None
>  */
> -int sbi_remote_hfence_vvma_asid(const unsigned long *hart_mask,
> +int sbi_remote_hfence_vvma_asid(const struct cpumask *cpu_mask,
> 				unsigned long start,
> 				unsigned long size,
> 				unsigned long asid)
> {
> 	return __sbi_rfence(SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA_ASID,
> -			    hart_mask, start, size, asid, 0);
> +			    cpu_mask, start, size, asid, 0);
> }
> EXPORT_SYMBOL(sbi_remote_hfence_vvma_asid);
>=20
> @@ -591,11 +618,7 @@ long sbi_get_mimpid(void)
>=20
> static void sbi_send_cpumask_ipi(const struct cpumask *target)
> {
> -	struct cpumask hartid_mask;
> -
> -	riscv_cpuid_to_hartid_mask(target, &hartid_mask);
> -
> -	sbi_send_ipi(cpumask_bits(&hartid_mask));
> +	sbi_send_ipi(target);
> }
>=20
> static const struct riscv_ipi_ops sbi_ipi_ops =3D {
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 63241abe84eb..b42bfdc67482 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -59,16 +59,6 @@ atomic_t hart_lottery __section(".sdata")
> unsigned long boot_cpu_hartid;
> static DEFINE_PER_CPU(struct cpu, cpu_devices);
>=20
> -void riscv_cpuid_to_hartid_mask(const struct cpumask *in, struct =
cpumask *out)
> -{
> -	int cpu;
> -
> -	cpumask_clear(out);
> -	for_each_cpu(cpu, in)
> -		cpumask_set_cpu(cpuid_to_hartid_map(cpu), out);
> -}
> -EXPORT_SYMBOL_GPL(riscv_cpuid_to_hartid_mask);
> -
> /*
>  * Place kernel memory regions on the resource tree so that
>  * kexec-tools can retrieve them from /proc/iomem. While there
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index bd82375db51a..622f226454d5 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -96,7 +96,7 @@ void __init setup_smp(void)
> 		if (cpuid >=3D NR_CPUS) {
> 			pr_warn("Invalid cpuid [%d] for hartid [%d]\n",
> 				cpuid, hart);
> -			break;
> +			continue;
> 		}
>=20
> 		cpuid_to_hartid_map(cpuid) =3D hart;
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 9af67dbdc66a..f80a34fbf102 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -114,7 +114,6 @@ static bool stage2_get_leaf_entry(struct kvm *kvm, =
gpa_t addr,
>=20
> static void stage2_remote_tlb_flush(struct kvm *kvm, u32 level, gpa_t =
addr)
> {
> -	struct cpumask hmask;
> 	unsigned long size =3D PAGE_SIZE;
> 	struct kvm_vmid *vmid =3D &kvm->arch.vmid;
>=20
> @@ -127,8 +126,7 @@ static void stage2_remote_tlb_flush(struct kvm =
*kvm, u32 level, gpa_t addr)
> 	 * where the Guest/VM is running.
> 	 */
> 	preempt_disable();
> -	riscv_cpuid_to_hartid_mask(cpu_online_mask, &hmask);
> -	sbi_remote_hfence_gvma_vmid(cpumask_bits(&hmask), addr, size,
> +	sbi_remote_hfence_gvma_vmid(cpu_online_mask, addr, size,
> 				    READ_ONCE(vmid->vmid));
> 	preempt_enable();
> }
> diff --git a/arch/riscv/kvm/vcpu_sbi_replace.c =
b/arch/riscv/kvm/vcpu_sbi_replace.c
> index 00036b7f83b9..1bc0608a5bfd 100644
> --- a/arch/riscv/kvm/vcpu_sbi_replace.c
> +++ b/arch/riscv/kvm/vcpu_sbi_replace.c
> @@ -82,7 +82,7 @@ static int kvm_sbi_ext_rfence_handler(struct =
kvm_vcpu *vcpu, struct kvm_run *run
> {
> 	int ret =3D 0;
> 	unsigned long i;
> -	struct cpumask cm, hm;
> +	struct cpumask cm;
> 	struct kvm_vcpu *tmp;
> 	struct kvm_cpu_context *cp =3D &vcpu->arch.guest_context;
> 	unsigned long hmask =3D cp->a0;
> @@ -90,7 +90,6 @@ static int kvm_sbi_ext_rfence_handler(struct =
kvm_vcpu *vcpu, struct kvm_run *run
> 	unsigned long funcid =3D cp->a6;
>=20
> 	cpumask_clear(&cm);
> -	cpumask_clear(&hm);
> 	kvm_for_each_vcpu(i, tmp, vcpu->kvm) {
> 		if (hbase !=3D -1UL) {
> 			if (tmp->vcpu_id < hbase)
> @@ -103,17 +102,15 @@ static int kvm_sbi_ext_rfence_handler(struct =
kvm_vcpu *vcpu, struct kvm_run *run
> 		cpumask_set_cpu(tmp->cpu, &cm);
> 	}
>=20
> -	riscv_cpuid_to_hartid_mask(&cm, &hm);
> -
> 	switch (funcid) {
> 	case SBI_EXT_RFENCE_REMOTE_FENCE_I:
> -		ret =3D sbi_remote_fence_i(cpumask_bits(&hm));
> +		ret =3D sbi_remote_fence_i(&cm);
> 		break;
> 	case SBI_EXT_RFENCE_REMOTE_SFENCE_VMA:
> -		ret =3D sbi_remote_hfence_vvma(cpumask_bits(&hm), =
cp->a2, cp->a3);
> +		ret =3D sbi_remote_hfence_vvma(&cm, cp->a2, cp->a3);
> 		break;
> 	case SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID:
> -		ret =3D sbi_remote_hfence_vvma_asid(cpumask_bits(&hm), =
cp->a2,
> +		ret =3D sbi_remote_hfence_vvma_asid(&cm, cp->a2,
> 						  cp->a3, cp->a4);
> 		break;
> 	case SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA:
> diff --git a/arch/riscv/kvm/vcpu_sbi_v01.c =
b/arch/riscv/kvm/vcpu_sbi_v01.c
> index 4c7e13ec9ccc..07e2de14433a 100644
> --- a/arch/riscv/kvm/vcpu_sbi_v01.c
> +++ b/arch/riscv/kvm/vcpu_sbi_v01.c
> @@ -38,7 +38,7 @@ static int kvm_sbi_ext_v01_handler(struct kvm_vcpu =
*vcpu, struct kvm_run *run,
> 	int i, ret =3D 0;
> 	u64 next_cycle;
> 	struct kvm_vcpu *rvcpu;
> -	struct cpumask cm, hm;
> +	struct cpumask cm;
> 	struct kvm *kvm =3D vcpu->kvm;
> 	struct kvm_cpu_context *cp =3D &vcpu->arch.guest_context;
>=20
> @@ -101,15 +101,12 @@ static int kvm_sbi_ext_v01_handler(struct =
kvm_vcpu *vcpu, struct kvm_run *run,
> 				continue;
> 			cpumask_set_cpu(rvcpu->cpu, &cm);
> 		}
> -		riscv_cpuid_to_hartid_mask(&cm, &hm);
> 		if (cp->a7 =3D=3D SBI_EXT_0_1_REMOTE_FENCE_I)
> -			ret =3D sbi_remote_fence_i(cpumask_bits(&hm));
> +			ret =3D sbi_remote_fence_i(&cm);
> 		else if (cp->a7 =3D=3D SBI_EXT_0_1_REMOTE_SFENCE_VMA)
> -			ret =3D =
sbi_remote_hfence_vvma(cpumask_bits(&hm),
> -						cp->a1, cp->a2);
> +			ret =3D sbi_remote_hfence_vvma(&cm, cp->a1, =
cp->a2);
> 		else
> -			ret =3D =
sbi_remote_hfence_vvma_asid(cpumask_bits(&hm),
> -						cp->a1, cp->a2, cp->a3);
> +			ret =3D sbi_remote_hfence_vvma_asid(&cm, cp->a1, =
cp->a2, cp->a3);
> 		break;
> 	default:
> 		ret =3D -EINVAL;
> diff --git a/arch/riscv/kvm/vmid.c b/arch/riscv/kvm/vmid.c
> index 807228f8f409..2fa4f7b1813d 100644
> --- a/arch/riscv/kvm/vmid.c
> +++ b/arch/riscv/kvm/vmid.c
> @@ -67,7 +67,6 @@ void kvm_riscv_stage2_vmid_update(struct kvm_vcpu =
*vcpu)
> {
> 	unsigned long i;
> 	struct kvm_vcpu *v;
> -	struct cpumask hmask;
> 	struct kvm_vmid *vmid =3D &vcpu->kvm->arch.vmid;
>=20
> 	if (!kvm_riscv_stage2_vmid_ver_changed(vmid))
> @@ -102,8 +101,7 @@ void kvm_riscv_stage2_vmid_update(struct kvm_vcpu =
*vcpu)
> 		 * running, we force VM exits on all host CPUs using IPI =
and
> 		 * flush all Guest TLBs.
> 		 */
> -		riscv_cpuid_to_hartid_mask(cpu_online_mask, &hmask);
> -		sbi_remote_hfence_gvma(cpumask_bits(&hmask), 0, 0);
> +		sbi_remote_hfence_gvma(cpu_online_mask, 0, 0);
> 	}
>=20
> 	vmid->vmid =3D vmid_next;
> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> index 89f81067e09e..6cb7d96ad9c7 100644
> --- a/arch/riscv/mm/cacheflush.c
> +++ b/arch/riscv/mm/cacheflush.c
> @@ -67,10 +67,7 @@ void flush_icache_mm(struct mm_struct *mm, bool =
local)
> 		 */
> 		smp_mb();
> 	} else if (IS_ENABLED(CONFIG_RISCV_SBI)) {
> -		cpumask_t hartid_mask;
> -
> -		riscv_cpuid_to_hartid_mask(&others, &hartid_mask);
> -		sbi_remote_fence_i(cpumask_bits(&hartid_mask));
> +		sbi_remote_fence_i(&others);
> 	} else {
> 		on_each_cpu_mask(&others, ipi_remote_fence_i, NULL, 1);
> 	}
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index 64f8201237c2..37ed760d007c 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -32,7 +32,6 @@ static void __sbi_tlb_flush_range(struct mm_struct =
*mm, unsigned long start,
> 				  unsigned long size, unsigned long =
stride)
> {
> 	struct cpumask *cmask =3D mm_cpumask(mm);
> -	struct cpumask hmask;
> 	unsigned int cpuid;
> 	bool broadcast;
>=20
> @@ -46,9 +45,7 @@ static void __sbi_tlb_flush_range(struct mm_struct =
*mm, unsigned long start,
> 		unsigned long asid =3D =
atomic_long_read(&mm->context.id);
>=20
> 		if (broadcast) {
> -			riscv_cpuid_to_hartid_mask(cmask, &hmask);
> -			sbi_remote_sfence_vma_asid(cpumask_bits(&hmask),
> -						   start, size, asid);
> +			sbi_remote_sfence_vma_asid(cmask, start, size, =
asid);
> 		} else if (size <=3D stride) {
> 			local_flush_tlb_page_asid(start, asid);
> 		} else {
> @@ -56,9 +53,7 @@ static void __sbi_tlb_flush_range(struct mm_struct =
*mm, unsigned long start,
> 		}
> 	} else {
> 		if (broadcast) {
> -			riscv_cpuid_to_hartid_mask(cmask, &hmask);
> -			sbi_remote_sfence_vma(cpumask_bits(&hmask),
> -					      start, size);
> +			sbi_remote_sfence_vma(cmask, start, size);
> 		} else if (size <=3D stride) {
> 			local_flush_tlb_page(start);
> 		} else {
> --=20
> 2.30.2
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

