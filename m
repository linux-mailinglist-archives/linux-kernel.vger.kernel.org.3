Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B894CDF2C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 22:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiCDUjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiCDUjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:39:03 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B705219EFC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 12:38:14 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id r187-20020a1c44c4000000b003898fc06f1eso95924wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 12:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qBo/KjEYbhLNof//al7T4qcownnCHQ9TTSma3O7WX8E=;
        b=nqLXN2GKlg3Dhbj8xIikdqscgqe/jtncBC6m+MTbrOFPFDM5rcVxNz3YDky5E+BtuI
         HoqbwTMyzSff2rifrlSO0VdzbgP+Zi039BTvr/6KVqzjHBC75O8HPZW+G0jahsnd2zZD
         Zd/spxlrvoElknigNqNYQR934hlgwo8lb45gn8k838HJcI81NbQOPALPuRjz8TVlWiFo
         y05hhe4ooZLCgbIQbyaRi5PyKRbKCLxzEDy68VPIfbQ5SShSvCJIxV6MhjyyLEb7xqtH
         Y27LbztnWb6oar56eTQ8k3MWyP0GygiVbYOMDKoZOpmkgly0VO+41B3gr1mqaOfxx7SF
         Fyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qBo/KjEYbhLNof//al7T4qcownnCHQ9TTSma3O7WX8E=;
        b=C45uhIHEcXyKTz1ilC4/aqMjZbS3UjrXxxRKZkuIIlAu/9D9qZ40jJDOfXazzljRTs
         Ulaj46LX0zstoNkNUz90MB5rkwqf/lxfHhxgtgW1MqnC2wd1Dd8Lww6Tc7uQYw1iJcmO
         vE2ks4huHNen+SOqy9nDZw6EbVO8LWr56qnwOfrk9/05ifD+EK/Vb8v52Fm/lPqxdrJy
         IVhHvRigW76KZo185MVxWNS2VBuH25rG98TDfOmGqRs87dhFh++1Bzx/eULYYohE4sMV
         DD6uzWz6irkkYHa5va5lpcEVZ8lpwPdtNHyqvaHYs/SxRNWHSspWY5BGH2286S2hK11i
         wZ9A==
X-Gm-Message-State: AOAM531pYz6cdfrIb3n8q2IzNp85Ph2xzWdzm+3iY+Lq0xo2sai63jm/
        3xP2CFAoMigQaQ/W3RuXTAILaA==
X-Google-Smtp-Source: ABdhPJybU/3EuPIMLW1wccJ3R9STxRb0VCiG91BvQ8+GW9DP2RCFoHFzPhC3pVpAbYPwrakk3tMZvA==
X-Received: by 2002:a05:600c:1994:b0:383:688e:2b57 with SMTP id t20-20020a05600c199400b00383688e2b57mr148979wmq.76.1646426292844;
        Fri, 04 Mar 2022 12:38:12 -0800 (PST)
Received: from smtpclient.apple (global-5-144.nat-2.net.cam.ac.uk. [131.111.5.144])
        by smtp.gmail.com with ESMTPSA id h20-20020a05600c351400b0038688a67568sm7368822wmq.21.2022.03.04.12.38.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Mar 2022 12:38:12 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [RFC PATCH v2 7/7] RISC-V: KVM: Support sstc extension
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20220304201020.810380-8-atishp@rivosinc.com>
Date:   Fri, 4 Mar 2022 20:38:11 +0000
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree <devicetree@vger.kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E7BF29AE-3633-47F0-8D8C-735743386370@jrtc27.com>
References: <20220304201020.810380-1-atishp@rivosinc.com>
 <20220304201020.810380-8-atishp@rivosinc.com>
To:     Atish Patra <atishp@rivosinc.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Mar 2022, at 20:10, Atish Patra <atishp@rivosinc.com> wrote:
>=20
> Sstc extension allows the guest to program the vstimecmp CSR directly
> instead of making an SBI call to the hypervisor to program the next
> event. The timer interrupt is also directly injected to the guest by
> the hardware in this case. To maintain backward compatibility, the
> hypervisors also update the vstimecmp in an SBI set_time call if
> the hardware supports it. Thus, the older kernels in guest also
> take advantage of the sstc extension.

Same comment as the OpenSBI patch. This changes the semantics of the
SBI call from only touching M-mode (or HS-mode in this case) state
(minus STIP as explicitly requested) to also touching S-mode (or
VS-mode in this case) visible and controlled state, which to me goes
against the spec as any clobbered state needs to be explicitly
specified, but is not in the current frozen 0.3 spec. All this does is
optimise for legacy systems by adding code complexity, anyway, so I
fail to see why it=E2=80=99s really needed, if they want to go faster =
they can
just adopt Sstc. You can=E2=80=99t get rid of the existing mechanism so =
long as
you want to support non-Sstc hardware so it=E2=80=99s just adding a =
third
poorly-motivated case that to me goes against the spec.

Jess

> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
> arch/riscv/include/asm/kvm_host.h       |   1 +
> arch/riscv/include/asm/kvm_vcpu_timer.h |   8 +-
> arch/riscv/include/uapi/asm/kvm.h       |   1 +
> arch/riscv/kvm/main.c                   |  12 ++-
> arch/riscv/kvm/vcpu.c                   |   4 +-
> arch/riscv/kvm/vcpu_timer.c             | 138 +++++++++++++++++++++++-
> 6 files changed, 158 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/riscv/include/asm/kvm_host.h =
b/arch/riscv/include/asm/kvm_host.h
> index 99ef6a120617..2ed93cdb334f 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -135,6 +135,7 @@ struct kvm_vcpu_csr {
> 	unsigned long hvip;
> 	unsigned long vsatp;
> 	unsigned long scounteren;
> +	u64 vstimecmp;
> };
>=20
> struct kvm_vcpu_arch {
> diff --git a/arch/riscv/include/asm/kvm_vcpu_timer.h =
b/arch/riscv/include/asm/kvm_vcpu_timer.h
> index 375281eb49e0..a24a265f3ccb 100644
> --- a/arch/riscv/include/asm/kvm_vcpu_timer.h
> +++ b/arch/riscv/include/asm/kvm_vcpu_timer.h
> @@ -28,6 +28,11 @@ struct kvm_vcpu_timer {
> 	u64 next_cycles;
> 	/* Underlying hrtimer instance */
> 	struct hrtimer hrt;
> +
> +	/* Flag to check if sstc is enabled or not */
> +	bool sstc_enabled;
> +	/* A function pointer to switch between stimecmp or hrtimer at =
runtime */
> +	int (*timer_next_event)(struct kvm_vcpu *vcpu, u64 ncycles);
> };
>=20
> int kvm_riscv_vcpu_timer_next_event(struct kvm_vcpu *vcpu, u64 =
ncycles);
> @@ -39,6 +44,7 @@ int kvm_riscv_vcpu_timer_init(struct kvm_vcpu =
*vcpu);
> int kvm_riscv_vcpu_timer_deinit(struct kvm_vcpu *vcpu);
> int kvm_riscv_vcpu_timer_reset(struct kvm_vcpu *vcpu);
> void kvm_riscv_vcpu_timer_restore(struct kvm_vcpu *vcpu);
> +void kvm_riscv_vcpu_timer_save(struct kvm_vcpu *vcpu);
> int kvm_riscv_guest_timer_init(struct kvm *kvm);
> -
> +bool kvm_riscv_vcpu_timer_pending(struct kvm_vcpu *vcpu);
> #endif
> diff --git a/arch/riscv/include/uapi/asm/kvm.h =
b/arch/riscv/include/uapi/asm/kvm.h
> index 92bd469e2ba6..d2f02ba1947a 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
> @@ -96,6 +96,7 @@ enum KVM_RISCV_ISA_EXT_ID {
> 	KVM_RISCV_ISA_EXT_H,
> 	KVM_RISCV_ISA_EXT_I,
> 	KVM_RISCV_ISA_EXT_M,
> +	KVM_RISCV_ISA_EXT_SSTC,
> 	KVM_RISCV_ISA_EXT_MAX,
> };
>=20
> diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
> index 2e5ca43c8c49..83c4db7fc35f 100644
> --- a/arch/riscv/kvm/main.c
> +++ b/arch/riscv/kvm/main.c
> @@ -32,7 +32,7 @@ int kvm_arch_hardware_setup(void *opaque)
>=20
> int kvm_arch_hardware_enable(void)
> {
> -	unsigned long hideleg, hedeleg;
> +	unsigned long hideleg, hedeleg, henvcfg;
>=20
> 	hedeleg =3D 0;
> 	hedeleg |=3D (1UL << EXC_INST_MISALIGNED);
> @@ -51,6 +51,16 @@ int kvm_arch_hardware_enable(void)
>=20
> 	csr_write(CSR_HCOUNTEREN, -1UL);
>=20
> +	if (riscv_isa_extension_available(NULL, SSTC)) {
> +#ifdef CONFIG_64BIT
> +		henvcfg =3D csr_read(CSR_HENVCFG);
> +		csr_write(CSR_HENVCFG, henvcfg | 1UL<<HENVCFG_STCE);
> +#else
> +		henvcfg =3D csr_read(CSR_HENVCFGH);
> +		csr_write(CSR_HENVCFGH, henvcfg | 1UL<<HENVCFGH_STCE);
> +#endif
> +	}
> +
> 	csr_write(CSR_HVIP, 0);
>=20
> 	return 0;
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index a3ae7042c696..f7c08a182e3a 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -143,7 +143,7 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
>=20
> int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu)
> {
> -	return kvm_riscv_vcpu_has_interrupts(vcpu, 1UL << IRQ_VS_TIMER);
> +	return kvm_riscv_vcpu_timer_pending(vcpu);
> }
>=20
> void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu)
> @@ -374,6 +374,7 @@ static unsigned long kvm_isa_ext_arr[] =3D {
> 	RISCV_ISA_EXT_h,
> 	RISCV_ISA_EXT_i,
> 	RISCV_ISA_EXT_m,
> +	RISCV_ISA_EXT_SSTC,
> };
>=20
> static int kvm_riscv_vcpu_get_reg_isa_ext(struct kvm_vcpu *vcpu,
> @@ -757,6 +758,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
> 				     vcpu->arch.isa);
> 	kvm_riscv_vcpu_host_fp_restore(&vcpu->arch.host_context);
>=20
> +	kvm_riscv_vcpu_timer_save(vcpu);
> 	csr_write(CSR_HGATP, 0);
>=20
> 	csr->vsstatus =3D csr_read(CSR_VSSTATUS);
> diff --git a/arch/riscv/kvm/vcpu_timer.c b/arch/riscv/kvm/vcpu_timer.c
> index 5c4c37ff2d48..d226a931de92 100644
> --- a/arch/riscv/kvm/vcpu_timer.c
> +++ b/arch/riscv/kvm/vcpu_timer.c
> @@ -69,7 +69,18 @@ static int kvm_riscv_vcpu_timer_cancel(struct =
kvm_vcpu_timer *t)
> 	return 0;
> }
>=20
> -int kvm_riscv_vcpu_timer_next_event(struct kvm_vcpu *vcpu, u64 =
ncycles)
> +static int kvm_riscv_vcpu_update_vstimecmp(struct kvm_vcpu *vcpu, u64 =
ncycles)
> +{
> +#if __riscv_xlen =3D=3D 32
> +		csr_write(CSR_VSTIMECMP, ncycles & 0xFFFFFFFF);
> +		csr_write(CSR_VSTIMECMPH, ncycles >> 32);
> +#else
> +		csr_write(CSR_VSTIMECMP, ncycles);
> +#endif
> +		return 0;
> +}
> +
> +static int kvm_riscv_vcpu_update_hrtimer(struct kvm_vcpu *vcpu, u64 =
ncycles)
> {
> 	struct kvm_vcpu_timer *t =3D &vcpu->arch.timer;
> 	struct kvm_guest_timer *gt =3D &vcpu->kvm->arch.timer;
> @@ -88,6 +99,68 @@ int kvm_riscv_vcpu_timer_next_event(struct kvm_vcpu =
*vcpu, u64 ncycles)
> 	return 0;
> }
>=20
> +int kvm_riscv_vcpu_timer_next_event(struct kvm_vcpu *vcpu, u64 =
ncycles)
> +{
> +	struct kvm_vcpu_timer *t =3D &vcpu->arch.timer;
> +
> +	return t->timer_next_event(vcpu, ncycles);
> +}
> +
> +static enum hrtimer_restart kvm_riscv_vcpu_vstimer_expired(struct =
hrtimer *h)
> +{
> +	u64 delta_ns;
> +	struct kvm_vcpu_timer *t =3D container_of(h, struct =
kvm_vcpu_timer, hrt);
> +	struct kvm_vcpu *vcpu =3D container_of(t, struct kvm_vcpu, =
arch.timer);
> +	struct kvm_guest_timer *gt =3D &vcpu->kvm->arch.timer;
> +
> +	if (kvm_riscv_current_cycles(gt) < t->next_cycles) {
> +		delta_ns =3D kvm_riscv_delta_cycles2ns(t->next_cycles, =
gt, t);
> +		hrtimer_forward_now(&t->hrt, ktime_set(0, delta_ns));
> +		return HRTIMER_RESTART;
> +	}
> +
> +	t->next_set =3D false;
> +	kvm_vcpu_kick(vcpu);
> +
> +	return HRTIMER_NORESTART;
> +}
> +
> +bool kvm_riscv_vcpu_timer_pending(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_vcpu_timer *t =3D &vcpu->arch.timer;
> +	struct kvm_guest_timer *gt =3D &vcpu->kvm->arch.timer;
> +	u64 vstimecmp_val =3D vcpu->arch.guest_csr.vstimecmp;
> +
> +	if (!kvm_riscv_delta_cycles2ns(vstimecmp_val, gt, t) ||
> +	    kvm_riscv_vcpu_has_interrupts(vcpu, 1UL << IRQ_VS_TIMER))
> +		return true;
> +	else
> +		return false;
> +}
> +
> +static void kvm_riscv_vcpu_timer_blocking(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_vcpu_timer *t =3D &vcpu->arch.timer;
> +	struct kvm_guest_timer *gt =3D &vcpu->kvm->arch.timer;
> +	u64 delta_ns;
> +	u64 vstimecmp_val =3D vcpu->arch.guest_csr.vstimecmp;
> +
> +	if (!t->init_done)
> +		return;
> +
> +	delta_ns =3D kvm_riscv_delta_cycles2ns(vstimecmp_val, gt, t);
> +	if (delta_ns) {
> +		t->next_cycles =3D vstimecmp_val;
> +		hrtimer_start(&t->hrt, ktime_set(0, delta_ns), =
HRTIMER_MODE_REL);
> +		t->next_set =3D true;
> +	}
> +}
> +
> +static void kvm_riscv_vcpu_timer_unblocking(struct kvm_vcpu *vcpu)
> +{
> +	kvm_riscv_vcpu_timer_cancel(&vcpu->arch.timer);
> +}
> +
> int kvm_riscv_vcpu_get_reg_timer(struct kvm_vcpu *vcpu,
> 				 const struct kvm_one_reg *reg)
> {
> @@ -180,10 +253,20 @@ int kvm_riscv_vcpu_timer_init(struct kvm_vcpu =
*vcpu)
> 		return -EINVAL;
>=20
> 	hrtimer_init(&t->hrt, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> -	t->hrt.function =3D kvm_riscv_vcpu_hrtimer_expired;
> 	t->init_done =3D true;
> 	t->next_set =3D false;
>=20
> +	/* Enable sstc for every vcpu if available in hardware */
> +	if (riscv_isa_extension_available(NULL, SSTC)) {
> +		t->sstc_enabled =3D true;
> +		t->hrt.function =3D kvm_riscv_vcpu_vstimer_expired;
> +		t->timer_next_event =3D kvm_riscv_vcpu_update_vstimecmp;
> +	} else {
> +		t->sstc_enabled =3D false;
> +		t->hrt.function =3D kvm_riscv_vcpu_hrtimer_expired;
> +		t->timer_next_event =3D kvm_riscv_vcpu_update_hrtimer;
> +	}
> +
> 	return 0;
> }
>=20
> @@ -202,7 +285,7 @@ int kvm_riscv_vcpu_timer_reset(struct kvm_vcpu =
*vcpu)
> 	return kvm_riscv_vcpu_timer_cancel(&vcpu->arch.timer);
> }
>=20
> -void kvm_riscv_vcpu_timer_restore(struct kvm_vcpu *vcpu)
> +static void kvm_riscv_vcpu_update_timedelta(struct kvm_vcpu *vcpu)
> {
> 	struct kvm_guest_timer *gt =3D &vcpu->kvm->arch.timer;
>=20
> @@ -214,6 +297,55 @@ void kvm_riscv_vcpu_timer_restore(struct kvm_vcpu =
*vcpu)
> #endif
> }
>=20
> +void kvm_riscv_vcpu_timer_restore(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_vcpu_csr *csr;
> +	struct kvm_vcpu_timer *t =3D &vcpu->arch.timer;
> +
> +	kvm_riscv_vcpu_update_timedelta(vcpu);
> +
> +	if (!t->sstc_enabled)
> +		return;
> +
> +	csr =3D &vcpu->arch.guest_csr;
> +#ifdef CONFIG_64BIT
> +	csr_write(CSR_VSTIMECMP, csr->vstimecmp);
> +#else
> +	csr_write(CSR_VSTIMECMP, (u32)csr->vstimecmp);
> +	csr_write(CSR_VSTIMECMPH, (u32)(csr->vstimecmp >> 32));
> +#endif
> +
> +	/* timer should be enabled for the remaining operations */
> +	if (unlikely(!t->init_done))
> +		return;
> +
> +	kvm_riscv_vcpu_timer_unblocking(vcpu);
> +}
> +
> +void kvm_riscv_vcpu_timer_save(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_vcpu_csr *csr;
> +	struct kvm_vcpu_timer *t =3D &vcpu->arch.timer;
> +
> +	if (!t->sstc_enabled)
> +		return;
> +
> +	csr =3D &vcpu->arch.guest_csr;
> +	t =3D &vcpu->arch.timer;
> +#ifdef CONFIG_64BIT
> +	csr->vstimecmp =3D csr_read(CSR_VSTIMECMP);
> +#else
> +	csr->vstimecmp =3D csr_read(CSR_VSTIMECMP);
> +	csr->vstimecmp |=3D (u64)csr_read(CSR_VSTIMECMPH) << 32;
> +#endif
> +	/* timer should be enabled for the remaining operations */
> +	if (unlikely(!t->init_done))
> +		return;
> +
> +	if (kvm_vcpu_is_blocking(vcpu))
> +		kvm_riscv_vcpu_timer_blocking(vcpu);
> +}
> +
> int kvm_riscv_guest_timer_init(struct kvm *kvm)
> {
> 	struct kvm_guest_timer *gt =3D &kvm->arch.timer;
> --=20
> 2.30.2
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

