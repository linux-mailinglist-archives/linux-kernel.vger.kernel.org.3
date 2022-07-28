Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B35B583BE7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbiG1KSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbiG1KSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:18:46 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3BD550AC
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 03:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659003525; x=1690539525;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=AMBbqvyYuouSOjsJQ6yoXqSR8Ha2uvsQ3LIDmItFAdU=;
  b=hTuncudR5H4NrUUznlmm+m++5lADuyTUW5RT+rSQktvqgyGu9x3Kw5fg
   24Jslgf6Yguln/WBUgx2vXH5qU/CXczFxKClwGtC2f2TuJse78+Swfg/J
   yML6FGH4XieIL2dmFc8viM58vIM0iexX9b/KietaoBLXiH3GBTTexqgji
   p27vbWObP2O9wknZemz41rCexXf4ecLPp3YEzIuyZB8HWF4u4D9ZoODSz
   dvU9jphDpbTYtdFJ3BWLNTc1Z5hvuK6+Kr2d3PPntMSAZjm9wpldT2p6B
   bSSpbtSorKwgm2PcMryiicEiA7OEIOF9mJdz6sIsLkQJTL152Yfhaiy4p
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="289247315"
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="289247315"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 03:18:44 -0700
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="928225749"
Received: from byeongky-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.209.170.137])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 03:18:40 -0700
Message-ID: <19db3f9edf0af05424fd16d0c7a1ea23766e8330.camel@intel.com>
Subject: Re: [PATCH v9 3/6] x86/tdx: Add TDX Guest event notify interrupt
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
Date:   Thu, 28 Jul 2022 22:18:38 +1200
In-Reply-To: <20220728034420.648314-4-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20220728034420.648314-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220728034420.648314-4-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-07-27 at 20:44 -0700, Kuppuswamy Sathyanarayanan wrote:
> Host-guest event notification via configured interrupt vector is useful
> in cases where a guest makes an asynchronous request and needs a
> callback from the host to indicate the completion or to let the host
> notify the guest about events like device removal. One usage example is,
> callback requirement of GetQuote asynchronous hypercall.
>=20
> In TDX guest, SetupEventNotifyInterrupt hypercall can be used by the
> guest to specify which interrupt vector to use as an event-notify
> vector to the VMM. Details about the SetupEventNotifyInterrupt
> hypercall can be found in TDX Guest-Host Communication Interface
> (GHCI) Specification, sec 3.5 "VP.VMCALL<SetupEventNotifyInterrupt>".
> Add a tdx_hcall_set_notify_intr() helper function to implement the
> SetupEventNotifyInterrupt hypercall.
>=20
> As per design VMM will post the event completion IRQ using the same CPU
> in which SetupEventNotifyInterrupt hypercall request is received. So
> allocate an IRQ vector from "x86_vector_domain", and set the CPU
> affinity of the IRQ vector to the current CPU.

Set the affinity to the CPU isn't good enough.  Please call out we need a n=
on-
migratable IRQ here, i.e. userspace is not allowed to change the affinity w=
hich
can cause the vector being reallocated from another cpu.

>=20
> Please note that this patch only reserves the IRQ number. It is
> expected that the user of event notify IRQ (like GetQuote handler) will
> directly register the handler for "tdx_notify_irq" IRQ by using
> request_irq() with  IRQF_SHARED flag set. Using IRQF_SHARED will enable
> multiple users to use the same IRQ for event notification.
>=20
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Wander Lairson Costa <wander@redhat.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>
> ---
>  arch/x86/coco/tdx/tdx.c    | 84 ++++++++++++++++++++++++++++++++++++++
>  arch/x86/include/asm/tdx.h |  2 +
>  2 files changed, 86 insertions(+)
>=20
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 205f98f42da8..3563b208979c 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -8,12 +8,16 @@
>  #include <linux/miscdevice.h>
>  #include <linux/mm.h>
>  #include <linux/io.h>
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
>  #include "tdx.h"
> =20
> @@ -24,6 +28,7 @@
> =20
>  /* TDX hypercall Leaf IDs */
>  #define TDVMCALL_MAP_GPA		0x10001
> +#define TDVMCALL_SETUP_NOTIFY_INTR	0x10004
> =20
>  /* MMIO direction */
>  #define EPT_READ	0
> @@ -42,6 +47,7 @@
>  #define DRIVER_NAME	"tdx-guest"
> =20
>  static struct miscdevice tdx_misc_dev;
> +int tdx_notify_irq =3D -1;
> =20
>  /*
>   * Wrapper for standard use of __tdx_hypercall with no output aside from
> @@ -107,6 +113,31 @@ static inline void tdx_module_call(u64 fn, u64 rcx, =
u64 rdx, u64 r8, u64 r9,
>  		panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
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

I don't think this function is super useful.  I guess it's just better to o=
penly
call the _tdx_hypercall() directly in below.  With some comments, this way =
makes
the code more clear that we don't want any scheduling during the IRQ/vector
allocation and the hypervisor to guarantee the vector is always allocated o=
n the
CPU where the hypercall is called.

Also, checking vector < 32 isn't needed, as the hypercall is guaranteed to
return error in such case as suggested by GHCI (otherwise it is VMM bug).

The irq_domain_alloc_irqs() call also guarantees the allocated vector will =
never
< 32.  If really needed, you can just add a WARN_ON(vector < 32) right befo=
re
calling the hypercall.

>  static u64 get_cc_mask(void)
>  {
>  	struct tdx_module_output out;
> @@ -830,3 +861,56 @@ static int __init tdx_guest_init(void)
>  	return 0;
>  }
>  device_initcall(tdx_guest_init)
> +
> +/* Reserve an IRQ from x86_vector_domain for TD event notification */
> +static int __init tdx_arch_init(void)
> +{
> +	struct irq_alloc_info info;
> +	struct irq_cfg *cfg;
> +	int cpu;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
> +		return 0;
> +
> +	/* Make sure x86 vector domain is initialized */
> +	if (!x86_vector_domain) {
> +		pr_err("x86 vector domain is NULL\n");
> +		return 0;
> +	}

I don't think  this check is needed.  x86_vector_domain is guaranteed to be=
 non-
NULL in arch_early_irq_init():

        x86_vector_domain =3D irq_domain_create_tree(...);

        BUG_ON(x86_vector_domain =3D=3D NULL);

> +
> +	init_irq_alloc_info(&info, NULL);
> +
> +	/*
> +	 * Event notification vector will be delivered to the CPU
> +	 * in which TDVMCALL_SETUP_NOTIFY_INTR hypercall is requested.
> +	 * So set the IRQ affinity to the current CPU.
> +	 */
> +	cpu =3D get_cpu();
> +
> +	info.mask =3D cpumask_of(cpu);
> +
> +	tdx_notify_irq =3D irq_domain_alloc_irqs(x86_vector_domain, 1,
> +				NUMA_NO_NODE, &info);
> +
> +	if (tdx_notify_irq < 0) {
> +		pr_err("Event notification IRQ allocation failed %d\n",
> +				tdx_notify_irq);
> +		goto init_failed;
> +	}
> +
> +	irq_set_handler(tdx_notify_irq, handle_edge_irq);
> +
> +	cfg =3D irq_cfg(tdx_notify_irq);
> +	if (!cfg) {
> +		pr_err("Event notification IRQ config not found\n");
> +		goto init_failed;
> +	}
> +
> +	if (tdx_hcall_set_notify_intr(cfg->vector))
> +		pr_err("Setting event notification interrupt failed\n");

So the request_irq() with IRQF_NOBALANCING isn't in this patch but in later
patch.  Nor the IRQ is made affinity kernel-managed in this patch.  This me=
ans
for this patch alone, the IRQ is migratable (i.e. usespace can change its
affinity).  In another words, this patch depends on later patch to work.  I
don't think this is right/good.

Perhaps we can explicitly call irq_modify_status() to set IRQF_NOBALANCING =
here?

	irq_modify_status(tdx_notify_irq, 0, IRQ_NO_BALANCING);

But again, I am not expert here.  It would be helpful if some expert can he=
lp to
check whether this is good way to handle.


--=20
Thanks,
-Kai


