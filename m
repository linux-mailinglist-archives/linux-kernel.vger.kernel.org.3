Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F4F551901
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 14:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242709AbiFTMfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 08:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242818AbiFTMd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 08:33:28 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131986241
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 05:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655728407; x=1687264407;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=3a6jq5mf9EwgiHcZ3krQN7yO/1tAKGrsF7+BtxkTz+s=;
  b=HeldLkmunQ6hGQ1YqV+PuUJ6RIBPS2QU0NntjiGR3qkk1ib1qGlwyqhH
   OlI9QnFmxYexWgF7sD9mjiJb7bSusn9IHiaiYu5SWIYoe1DdgdLPR2stj
   kpOOOLD/5IyMWwYcVdXm/OD8sxsgXrCtzEYs18JRg/6YcAFvBJtRkWSDh
   1GuC/Ldf0DQJOWMtNCauw5bCu73/x0zDQWtar6qlLs0pHzhdgYcMGeg53
   jNp4Lzh4jvPlIk6IIUayG4aUNHZ8awOd9/qVMjhRApAJXvYMSR5TPVhxd
   5ZrVwxbZJQOoVKgybvUxknoqam2JmITJ4AkjrVcVV5FccrPKe7KqRBdME
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="341565363"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="341565363"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 05:33:26 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="913642512"
Received: from dkburrow-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.213.191.162])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 05:33:22 -0700
Message-ID: <78873cc1db47ba00a4c01f38290521c1a6072820.camel@intel.com>
Subject: Re: [PATCH v8 2/5] x86/tdx: Add TDX Guest event notify interrupt
 support
From:   Kai Huang <kai.huang@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Date:   Tue, 21 Jun 2022 00:33:20 +1200
In-Reply-To: <20220609025220.2615197-3-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220609025220.2615197-3-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-06-08 at 19:52 -0700, Kuppuswamy Sathyanarayanan wrote:
> Host-guest event notification via configured interrupt vector is useful
> in cases where a guest makes an asynchronous request and needs a
> callback from the host to indicate the completion or to let the host
> notify the guest about events like device removal. One usage example is,
> callback requirement of GetQuote asynchronous hypercall.

Although this paragraph is from GHCI spec, IMHO it is not very helpful.  In
fact, I think this paragraph is not that right and should be removed from G=
HCI.
The reason is such event notification from VMM in cases like "device remova=
l" is
too vague.  There's no _specification_ in GHCI around which "device removal=
"
should VMM inject such event.  For instance, I _think_ the Qemu enumerated =
ACPI-
based hotplug should continue to work in TD.

That being said, if a TD has multiple devices, it cannot know whether the V=
MM
will inject the removal event via the vector set by SetupEventNotifyInterru=
pt.=20
And for the same device in the same TD, different VMMs may use different wa=
y to
notify its removal.

It seems GetQuote is the only user of SetupEventNotifyInterrupt.  Maybe we
should just declare it is for GetQuote.

Isaku, what do you think?  Does this make sense?

>=20
> In TDX guest, SetupEventNotifyInterrupt hypercall can be used by the
> guest to specify which interrupt vector to use as an event-notify
> vector to the VMM. Details about the SetupEventNotifyInterrupt
> hypercall can be found in TDX Guest-Host Communication Interface
> (GHCI) Specification, sec 3.5 "VP.VMCALL<SetupEventNotifyInterrupt>".
> Add a tdx_hcall_set_notify_intr() helper function to implement the
> SetupEventNotifyInterrupt hypercall.

As you also used "can" above, the GHCI only says the VMM _CAN_ inject the v=
ector
set by SetupEventNotifyInterrupt, but not must (3.3 TDG.VP.VMCALL<GetQuote>=
).=20
This means theoretically TD should implement pooling mode in case VMM doesn=
't
support injecting event via vector done by SetupEventNotifyInterrupt?

Perhaps we should update the GHCI spec to use must..

>=20
> Reserve 0xec IRQ vector address for TDX guest to receive the event
> completion notification from VMM. Also add related IDT handler to
> process the notification event.

Here lacks why we need to choose to reserve a system vector.  For instance,=
 why
we cannot choose to use device IRQ way which only requires one vector on on=
e
cpu.  As you can see reserving a system vector isn't ideal especially for
attestation as it is not a frequent operation.  It is wasteful of using IRQ
resource especially on server systems with a lot of CPUs.

The reason is SetupEventNotifyInterrupt TDVMCALL only has one argument, whi=
ch is
vector, but cannot specify which CPU that the VMM should inject the event t=
o.=20
The GHCI spec doesn't say which CPU the VMM should inject to (i.e. must inj=
ect
to the CPU on which SetupEventNotifyInterrupt is called), so we can only as=
sume
VMM can inject to any CPU.

Btw, x86 maintainers,

I'd like to check with you to see whether we should improve the existing
SetupEventNotifyInterrupt so we can choose to use request_irq() style for
attestation.  Using request_irq() means we don't need to reserve a system
vector, but can allocate a vector dynamically when needed.

Assuming we update SetupEventNotifyInterrupt to also allow TD to specify wh=
ich
CPU (i.e. via APICID) to inject (along with the vector), my understanding i=
s we
can use below way (idea only) to dynamically allocate a vector on one CPU w=
hen
attestation is needed:


	int cpu, vector;
	int irq;

	// request an IRQ, and prevent it from being migrated
	irq =3D __irq_domain_alloc_irqs(x86_vector_domain, 0, 1, ...);
	request_irq(irq, ...);
=09
	// get vector, cpu from irq

	TDVMCALL<SetupEventNotifyInterrupt>(vector,=C2=A0
		apic->cpu_present_to_apidid(cpu));
=09
Is this reasonable? If yes, is it worth to do?

--=20
Thanks,
-Kai


>=20
> Add support to track the notification event status via
> /proc/interrupts.
>=20
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Wander Lairson Costa <wander@redhat.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>
> ---
>  arch/x86/coco/tdx/tdx.c            | 71 ++++++++++++++++++++++++++++++
>  arch/x86/include/asm/hardirq.h     |  3 ++
>  arch/x86/include/asm/idtentry.h    |  4 ++
>  arch/x86/include/asm/irq_vectors.h |  7 ++-
>  arch/x86/include/asm/tdx.h         |  4 ++
>  arch/x86/kernel/irq.c              |  7 +++
>  6 files changed, 95 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 03deb4d6920d..94542876f26a 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -11,6 +11,10 @@
>  #include <asm/insn.h>
>  #include <asm/insn-eval.h>
>  #include <asm/pgtable.h>
> +#include <asm/apic.h>
> +#include <asm/idtentry.h>
> +#include <asm/irq_regs.h>
> +#include <asm/desc.h>
> =20
>  /* TDX module Call Leaf IDs */
>  #define TDX_GET_INFO			1
> @@ -19,6 +23,7 @@
> =20
>  /* TDX hypercall Leaf IDs */
>  #define TDVMCALL_MAP_GPA		0x10001
> +#define TDVMCALL_SETUP_NOTIFY_INTR	0x10004
> =20
>  /* MMIO direction */
>  #define EPT_READ	0
> @@ -34,6 +39,26 @@
>  #define VE_GET_PORT_NUM(e)	((e) >> 16)
>  #define VE_IS_IO_STRING(e)	((e) & BIT(4))
> =20
> +/*
> + * Handler used to report notifications about
> + * TDX_GUEST_EVENT_NOTIFY_VECTOR IRQ. Currently it will be
> + * used only by the attestation driver. So, race condition
> + * with read/write operation is not considered.
> + */
> +static void (*tdx_event_notify_handler)(void);
> +
> +/* Helper function to register tdx_event_notify_handler */
> +void tdx_setup_ev_notify_handler(void (*handler)(void))
> +{
> +	tdx_event_notify_handler =3D handler;
> +}
> +
> +/* Helper function to unregister tdx_event_notify_handler */
> +void tdx_remove_ev_notify_handler(void)
> +{
> +	tdx_event_notify_handler =3D NULL;
> +}
> +
>  /*
>   * Wrapper for standard use of __tdx_hypercall with no output aside from
>   * return code.
> @@ -98,6 +123,46 @@ static inline void tdx_module_call(u64 fn, u64 rcx, u=
64 rdx, u64 r8, u64 r9,
>  		panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
>  }
> =20
> +/* TDX guest event notification handler */
> +DEFINE_IDTENTRY_SYSVEC(sysvec_tdx_event_notify)
> +{
> +	struct pt_regs *old_regs =3D set_irq_regs(regs);
> +
> +	inc_irq_stat(irq_tdx_event_notify_count);
> +
> +	if (tdx_event_notify_handler)
> +		tdx_event_notify_handler();
> +
> +	ack_APIC_irq();
> +
> +	set_irq_regs(old_regs);
> +}
> +
> +/*
> + * tdx_hcall_set_notify_intr() - Setup Event Notify Interrupt Vector.
> + *
> + * @vector: Vector address to be used for notification.
> + *
> + * return 0 on success or failure error number.
> + */
> +static long tdx_hcall_set_notify_intr(u8 vector)
> +{
> +	/* Minimum vector value allowed is 32 */
> +	if (vector < 32)
> +		return -EINVAL;
> +
> +	/*
> +	 * Register callback vector address with VMM. More details
> +	 * about the ABI can be found in TDX Guest-Host-Communication
> +	 * Interface (GHCI), sec titled
> +	 * "TDG.VP.VMCALL<SetupEventNotifyInterrupt>".
> +	 */
> +	if (_tdx_hypercall(TDVMCALL_SETUP_NOTIFY_INTR, vector, 0, 0, 0))
> +		return -EIO;
> +
> +	return 0;
> +}
> +
>  static u64 get_cc_mask(void)
>  {
>  	struct tdx_module_output out;
> @@ -688,5 +753,11 @@ void __init tdx_early_init(void)
>  	x86_platform.guest.enc_tlb_flush_required   =3D tdx_tlb_flush_required;
>  	x86_platform.guest.enc_status_change_finish =3D tdx_enc_status_changed;
> =20
> +	alloc_intr_gate(TDX_GUEST_EVENT_NOTIFY_VECTOR,
> +			asm_sysvec_tdx_event_notify);
> +
> +	if (tdx_hcall_set_notify_intr(TDX_GUEST_EVENT_NOTIFY_VECTOR))
> +		pr_warn("Setting event notification interrupt failed\n");
> +
>  	pr_info("Guest detected\n");
>  }
> diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardir=
q.h
> index 275e7fd20310..582deff56210 100644
> --- a/arch/x86/include/asm/hardirq.h
> +++ b/arch/x86/include/asm/hardirq.h
> @@ -44,6 +44,9 @@ typedef struct {
>  	unsigned int irq_hv_reenlightenment_count;
>  	unsigned int hyperv_stimer0_count;
>  #endif
> +#if IS_ENABLED(CONFIG_INTEL_TDX_GUEST)
> +	unsigned int irq_tdx_event_notify_count;
> +#endif
>  } ____cacheline_aligned irq_cpustat_t;
> =20
>  DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idten=
try.h
> index 72184b0b2219..655086dd940e 100644
> --- a/arch/x86/include/asm/idtentry.h
> +++ b/arch/x86/include/asm/idtentry.h
> @@ -700,6 +700,10 @@ DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_CALLBACK_VECTOR,	=
sysvec_xen_hvm_callback);
>  DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_CALLBACK_VECTOR,	sysvec_kvm_asyncpf_i=
nterrupt);
>  #endif
> =20
> +#if IS_ENABLED(CONFIG_INTEL_TDX_GUEST)
> +DECLARE_IDTENTRY_SYSVEC(TDX_GUEST_EVENT_NOTIFY_VECTOR,	sysvec_tdx_event_=
notify);
> +#endif
> +
>  #undef X86_TRAP_OTHER
> =20
>  #endif
> diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/ir=
q_vectors.h
> index 43dcb9284208..82ac0c0a34b1 100644
> --- a/arch/x86/include/asm/irq_vectors.h
> +++ b/arch/x86/include/asm/irq_vectors.h
> @@ -104,7 +104,12 @@
>  #define HYPERV_STIMER0_VECTOR		0xed
>  #endif
> =20
> -#define LOCAL_TIMER_VECTOR		0xec
> +#if IS_ENABLED(CONFIG_INTEL_TDX_GUEST)
> +/* Vector on which TDX Guest event notification is delivered */
> +#define TDX_GUEST_EVENT_NOTIFY_VECTOR	0xec
> +#endif
> +
> +#define LOCAL_TIMER_VECTOR		0xeb
> =20
>  #define NR_VECTORS			 256
> =20
> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index 020c81a7c729..eb4db837cc44 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -67,6 +67,10 @@ void tdx_safe_halt(void);
> =20
>  bool tdx_early_handle_ve(struct pt_regs *regs);
> =20
> +void tdx_setup_ev_notify_handler(void (*handler)(void));
> +
> +void tdx_remove_ev_notify_handler(void);
> +
>  #else
> =20
>  static inline void tdx_early_init(void) { };
> diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
> index 766ffe3ba313..a96ecd866723 100644
> --- a/arch/x86/kernel/irq.c
> +++ b/arch/x86/kernel/irq.c
> @@ -181,6 +181,13 @@ int arch_show_interrupts(struct seq_file *p, int pre=
c)
>  		seq_printf(p, "%10u ",
>  			   irq_stats(j)->kvm_posted_intr_wakeup_ipis);
>  	seq_puts(p, "  Posted-interrupt wakeup event\n");
> +#endif
> +#if IS_ENABLED(CONFIG_INTEL_TDX_GUEST)
> +	seq_printf(p, "%*s: ", prec, "TGN");
> +	for_each_online_cpu(j)
> +		seq_printf(p, "%10u ",
> +			   irq_stats(j)->irq_tdx_event_notify_count);
> +	seq_puts(p, "  TDX Guest event notification\n");
>  #endif
>  	return 0;
>  }


