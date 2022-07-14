Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813C9574AFA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 12:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiGNKnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 06:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiGNKnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 06:43:04 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976C754661
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 03:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657795383; x=1689331383;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=hufqI4f/1PfwNYYAJozQMqsmXZUEwUbhsvoM1GVNgVI=;
  b=RoA79jyhtJNImBMiUIuywmxtIzyc12zNgkDiOChMDU881wd2Oca9XAXr
   gy9sdgqTDNtPFV5A5Xc5Kzd95kg5MeaAJNInvaobLcNqOl3qqLZtT8R86
   TUl0huLUInFIyoLPst/tEdVyCJT0VCzgKZZLscePHDxvGZmHPy1lCQw3W
   sUaG7Ihj+A+qVRtA2Qoi2+untyfTyHD+flm5JkM1BYIrHVV0yo/ivqZf4
   Tjwu/sF0WGj0mCoG0lbnvfLlUfZ1vKYuiHUKb6sHA/emRCRRj/8k5Ya+2
   /jKT+PpDtvNhd1YolI/EZEOgRl8/pTyHkhw0yrGXxbGX8B0v3chAaAosG
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="283033256"
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="283033256"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 03:43:03 -0700
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="685526256"
Received: from wmoyer-mobl3.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.212.86.31])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 03:42:59 -0700
Message-ID: <434ff0edcd5a0f1eb671bb2850ef5444ac1359a3.camel@intel.com>
Subject: Re: [PATCH v8 2/5] x86/tdx: Add TDX Guest event notify interrupt
 support
From:   Kai Huang <kai.huang@intel.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Yao, Jiewen" <jiewen.yao@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "tim.gardner@canonical.com" <tim.gardner@canonical.com>,
        "khalid.elmously@canonical.com" <khalid.elmously@canonical.com>,
        "Cox, Philip" <philip.cox@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 14 Jul 2022 22:42:57 +1200
In-Reply-To: <503e7135-782c-b72b-6f55-3c4acf55921b@linux.intel.com>
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220609025220.2615197-3-sathyanarayanan.kuppuswamy@linux.intel.com>
         <78873cc1db47ba00a4c01f38290521c1a6072820.camel@intel.com>
         <efb2cdab-289b-8757-fe5e-5348519b0474@linux.intel.com>
         <385B219C-4DB2-480C-913C-411AB4D644ED@intel.com>
         <MW4PR11MB5872E3B775A680678331D6358CB79@MW4PR11MB5872.namprd11.prod.outlook.com>
         <9c7d99469179340eeecabaf3e9c414fc98900626.camel@intel.com>
         <503e7135-782c-b72b-6f55-3c4acf55921b@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-07-13 at 17:46 -0700, Sathyanarayanan Kuppuswamy wrote:
> Hi Kai/Dave,
>=20
> On 6/27/22 4:21 AM, Kai Huang wrote:
> > On Sat, 2022-06-25 at 15:35 +1200, Yao, Jiewen wrote:
> > > Thank you, Jun.
> > >=20
> > > Yes. I confirmed that we will include below change to GHCI.next spec.
> > >=20
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > 3.5 TDG.VP.VMCALL<SetupEventNotifyInterrupt>
> > >=20
> > > From: "The host VMM should use SEAMCALL [TDWRVPS] leaf to inject an i=
nterrupt at the requested-interrupt vector into the TD via the posted-inter=
rupt descriptor. "
> > >=20
> > > To: "The host VMM should use SEAMCALL [TDWRVPS] leaf to inject an int=
errupt at the requested-interrupt vector into the TD VCPU that executed TDG=
.VP.VMCALL <SetupEventNotifyInterrupt> via the posted-interrupt descriptor.=
 "
> > >=20
> >=20
> > Hi Sathy,
> >=20
> > With this change, I don't think we should use system vector anymore.  I=
nstead,
> > we just need one non-migratable IRQ which has a fixed vector on a fixed=
 cpu.
> >=20
>=20
> Thanks. As suggested, I have attempted to allocate IRQ vector at runtime
> using irq_domain_alloc_irqs() call. Vector is allocated from
> "x86_vector_domain" as Kai suggested.

I am not expert either. I said "idea only" in my first reply :)

>=20
> Since I am not well versed in this area, I would like expert comments on =
it.
> Mainly for IRQ allocation logic in tdx_late_init(). I have tested this ve=
rsion using
> QEMU and it works fine.
>=20
>=20
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 928dcf7a20d9..dcc878546574 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -5,12 +5,16 @@
>  #define pr_fmt(fmt)     "tdx: " fmt
> =20
>  #include <linux/cpufeature.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/numa.h>
>  #include <asm/coco.h>
>  #include <asm/tdx.h>
>  #include <asm/vmx.h>
>  #include <asm/insn.h>
>  #include <asm/insn-eval.h>
>  #include <asm/pgtable.h>
> +#include <asm/irqdomain.h>
> =20
>  /* TDX module Call Leaf IDs */
>  #define TDX_GET_INFO                   1
> @@ -19,6 +23,7 @@
> =20
>  /* TDX hypercall Leaf IDs */
>  #define TDVMCALL_MAP_GPA               0x10001
> +#define TDVMCALL_SETUP_NOTIFY_INTR     0x10004
> =20
>  /* MMIO direction */
>  #define EPT_READ       0
> @@ -34,6 +39,26 @@
>  #define VE_GET_PORT_NUM(e)     ((e) >> 16)
>  #define VE_IS_IO_STRING(e)     ((e) & BIT(4))
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
> +       tdx_event_notify_handler =3D handler;
> +}
> +
> +/* Helper function to unregister tdx_event_notify_handler */
> +void tdx_remove_ev_notify_handler(void)
> +{
> +       tdx_event_notify_handler =3D NULL;
> +}
> +

Looks it's weird that you still need it.  Couldn't we pass the function to
handle GetQuote directly to request_irq()?

>  /*
>   * Wrapper for standard use of __tdx_hypercall with no output aside from
>   * return code.
> @@ -98,6 +123,31 @@ static inline void tdx_module_call(u64 fn, u64 rcx, u=
64 rdx, u64 r8, u64 r9,
>                 panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
>  }
> =20
> +/*
> + * tdx_hcall_set_notify_intr() - Setup Event Notify Interrupt Vector.
> + *
> + * @vector: Vector address to be used for notification.
> + *
> + * return 0 on success or failure error number.
> + */
> +static long tdx_hcall_set_notify_intr(u8 vector)
> +{
> +       /* Minimum vector value allowed is 32 */
> +       if (vector < 32)
> +               return -EINVAL;
> +
> +       /*
> +        * Register callback vector address with VMM. More details
> +        * about the ABI can be found in TDX Guest-Host-Communication
> +        * Interface (GHCI), sec titled
> +        * "TDG.VP.VMCALL<SetupEventNotifyInterrupt>".
> +        */
> +       if (_tdx_hypercall(TDVMCALL_SETUP_NOTIFY_INTR, vector, 0, 0, 0))
> +               return -EIO;
> +
> +       return 0;
> +}
> +
>  static u64 get_cc_mask(void)
>  {
>         struct tdx_module_output out;
> @@ -775,3 +825,52 @@ void __init tdx_early_init(void)
> =20
>         pr_info("Guest detected\n");
>  }
> +
> +static irqreturn_t tdx_ev_handler(int irq, void *dev_id)
> +{
> +       tdx_event_notify_handler();
> +       return IRQ_HANDLED;
> +}
> +
> +static int __init tdx_late_init(void)
> +{
> +        struct irq_alloc_info info;
> +       struct irq_cfg *cfg;
> +       int evirq, cpu;
> +
> +       if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
> +               return 0;
> +
> +       if (!x86_vector_domain) {
> +               pr_err("x86 vector domain is NULL\n");
> +               return 0;
> +       }
> +
> +       init_irq_alloc_info(&info, NULL);
> +
> +       evirq =3D irq_domain_alloc_irqs(x86_vector_domain, 1, NUMA_NO_NOD=
E, &info);

If I read correctly, if you set info->mask to cpumask_of(cpu), and pass it =
to
irq_domain_alloc_irqs(), the x86_vector_domain.alloc will immediately alloc=
ate a
vector on the given cpu, so you don't need to call irq_set_affinity() and w=
ait
to allocate the vector on _this_ cpu until request_irq().

> +
> +       cpu =3D get_cpu();
> +
> +       irq_set_handler(evirq, handle_edge_irq);
> +
> +       /*
> +        * Event notification vector will be delivered to the CPU
> +        * in which TDVMCALL_SETUP_NOTIFY_INTR hypercall is requested.
> +        * So set the IRQ affinity to the current CPU.
> +        */
> +       irq_set_affinity(evirq, cpumask_of(cpu));
> +
> +       if (request_irq(evirq, tdx_ev_handler, 0, "tdx_evirq", NULL))
> +               pr_err("Request event IRQ failed\n");
> +
> +       cfg =3D irq_cfg(evirq);
> +
> +       if (tdx_hcall_set_notify_intr(cfg->vector))
> +               pr_err("Setting event notification interrupt failed\n");
> +
> +       put_cpu();

So the IRQ's affinity isn't kernel managed.  Also looks it doesn't have any=
thing
like IRQF_NOBALANCING to prevent it from being migrated.  If I understand
correctly, userspace can still change the affinity which could cause the ve=
ctor
being reallocated on another cpu?

Perhaps you can pass IRQF_NO_BALANCING to request_irq()?


--=20
Thanks,
-Kai


