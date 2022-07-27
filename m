Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD23558275D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 15:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbiG0NIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 09:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiG0NIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 09:08:16 -0400
X-Greylist: delayed 2126 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 27 Jul 2022 06:08:15 PDT
Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0795D281
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
        s=20200302mail; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID;
        bh=E6+gj7hdT4Zrz9hBQQ/b6zaYk6fh+BZKunB47YG96+k=; b=OCAUvZFu5ee5MYoUnfUBLlXn0o
        2TC3qv2dP8aUNapSne3agJCSYl1uC90+RCFSpxZZlb5BD5J7s6Fn9Ed3aB0biUnIt4hy+Iv53ZtQD
        Qq18ySSH64SAAQ2Da6lCkEeHTMdJZ8aQNlQGlVIsaxoAYEVxn58NPsuf9CKLuFYFtbv4=;
Received: from xenbits.xenproject.org ([104.239.192.120])
        by mail.xenproject.org with esmtp (Exim 4.92)
        (envelope-from <julien@xen.org>)
        id 1oGgDU-0004ih-79; Wed, 27 Jul 2022 12:32:44 +0000
Received: from [54.239.6.186] (helo=[192.168.6.7])
        by xenbits.xenproject.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <julien@xen.org>)
        id 1oGgDT-0008Pi-VU; Wed, 27 Jul 2022 12:32:44 +0000
Message-ID: <51ba135e-a105-036f-b891-e7d9e1bb607d@xen.org>
Date:   Wed, 27 Jul 2022 13:32:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.3
Subject: Re: [PATCH v2] x86/xen: Add support for
 HVMOP_set_evtchn_upcall_vector
Content-Language: en-US
To:     Jane Malalane <jane.malalane@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Maximilian Heyne <mheyne@amazon.de>,
        Jan Beulich <jbeulich@suse.com>,
        Colin Ian King <colin.king@intel.com>,
        xen-devel@lists.xenproject.org
References: <20220726125657.12151-1-jane.malalane@citrix.com>
From:   Julien Grall <julien@xen.org>
In-Reply-To: <20220726125657.12151-1-jane.malalane@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jane,

On 26/07/2022 13:56, Jane Malalane wrote:
> diff --git a/arch/x86/xen/suspend_hvm.c b/arch/x86/xen/suspend_hvm.c
> index 9d548b0c772f..0c4f7554b7cc 100644
> --- a/arch/x86/xen/suspend_hvm.c
> +++ b/arch/x86/xen/suspend_hvm.c
> @@ -5,6 +5,7 @@
>   #include <xen/hvm.h>
>   #include <xen/features.h>
>   #include <xen/interface/features.h>
> +#include <xen/events.h>
>   
>   #include "xen-ops.h"
>   
> @@ -14,6 +15,13 @@ void xen_hvm_post_suspend(int suspend_cancelled)
>   		xen_hvm_init_shared_info();
>   		xen_vcpu_restore();
>   	}
> -	xen_setup_callback_vector();
> +	if (xen_percpu_upcall) {
> +		unsigned int cpu;
> +
> +		for_each_online_cpu(cpu)
> +			BUG_ON(xen_set_upcall_vector(cpu));
> +	} else {
> +		xen_setup_callback_vector();
> +	}
>   	xen_unplug_emulated_devices();
>   }
> diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
> index 46d9295d9a6e..2ad93595d03a 100644
> --- a/drivers/xen/events/events_base.c
> +++ b/drivers/xen/events/events_base.c
> @@ -48,6 +48,7 @@
>   #include <asm/xen/pci.h>
>   #endif
>   #include <asm/sync_bitops.h>
> +#include <asm/xen/cpuid.h>

This include doesn't exist on Arm and will result to a build failure:

linux/drivers/xen/events/events_base.c:51:10: fatal error: 
asm/xen/cpuid.h: No such file or directory
    51 | #include <asm/xen/cpuid.h>
       |          ^~~~~~~~~~~~~~~~~


>   #include <asm/xen/hypercall.h>
>   #include <asm/xen/hypervisor.h>
>   #include <xen/page.h>
> @@ -2195,11 +2196,48 @@ void xen_setup_callback_vector(void)
>   		callback_via = HVM_CALLBACK_VECTOR(HYPERVISOR_CALLBACK_VECTOR);
>   		if (xen_set_callback_via(callback_via)) {
>   			pr_err("Request for Xen HVM callback vector failed\n");
> -			xen_have_vector_callback = 0;
> +			xen_have_vector_callback = false;
>   		}
>   	}
>   }
>   
> +/* Setup per-vCPU vector-type callbacks and trick toolstack to think
> + * we are enlightened. If this setup is unavailable, fallback to the
> + * global vector-type callback. */
> +static __init void xen_init_setup_upcall_vector(void)
> +{
> +	unsigned int cpu = 0;
> +
> +	if (!xen_have_vector_callback)
> +		return;
> +
> +	if ((cpuid_eax(xen_cpuid_base() + 4) & XEN_HVM_CPUID_UPCALL_VECTOR) &&
> +	    !xen_set_upcall_vector(cpu) && !xen_set_callback_via(1))

xen_cpuid_base() is an x86-ism. This is going to build because 
CONFIG_XEN_PVHVM is only set for x86. However, I think this is quite 
fragile.

You are also using more variable defined only on x86. So it feels to me 
that these functions should be implemented in x86 code.

> +		xen_percpu_upcall = true;
> +	else if (xen_feature(XENFEAT_hvm_callback_vector))
> +		xen_setup_callback_vector();
> +	else
> +		xen_have_vector_callback = false;
> +}
> +
> +int xen_set_upcall_vector(unsigned int cpu)
> +{
> +	int rc;
> +	xen_hvm_evtchn_upcall_vector_t op = {
> +		.vector = HYPERVISOR_CALLBACK_VECTOR,
> +		.vcpu = per_cpu(xen_vcpu_id, cpu),
> +	};
> +
> +	rc = HYPERVISOR_hvm_op(HVMOP_set_evtchn_upcall_vector, &op);
> +	if (rc)
> +		return rc;
> +
> +	if (!cpu)
> +		rc = xen_set_callback_via(1);
> +
> +	return rc;
> +}
> +
>   static __init void xen_alloc_callback_vector(void)
>   {
>   	if (!xen_have_vector_callback)
> @@ -2210,6 +2248,8 @@ static __init void xen_alloc_callback_vector(void)
>   }
>   #else
>   void xen_setup_callback_vector(void) {}
> +static inline void xen_init_setup_upcall_vector(void) {}
> +int xen_set_upcall_vector(unsigned int cpu) {}
>   static inline void xen_alloc_callback_vector(void) {}
>   #endif
>   
> @@ -2271,10 +2311,9 @@ void __init xen_init_IRQ(void)
>   		if (xen_initial_domain())
>   			pci_xen_initial_domain();
>   	}
> -	if (xen_feature(XENFEAT_hvm_callback_vector)) {
> -		xen_setup_callback_vector();
> -		xen_alloc_callback_vector();
> -	}
> +	xen_init_setup_upcall_vector();
> +	xen_alloc_callback_vector();
> +
>   
>   	if (xen_hvm_domain()) {
>   		native_init_IRQ();
> diff --git a/include/xen/hvm.h b/include/xen/hvm.h
> index b7fd7fc9ad41..8da7a6747058 100644
> --- a/include/xen/hvm.h
> +++ b/include/xen/hvm.h
> @@ -60,4 +60,6 @@ static inline int hvm_get_parameter(int idx, uint64_t *value)
>   
>   void xen_setup_callback_vector(void);
>   
> +int xen_set_upcall_vector(unsigned int cpu);
> +
>   #endif /* XEN_HVM_H__ */
> diff --git a/include/xen/interface/hvm/hvm_op.h b/include/xen/interface/hvm/hvm_op.h
> index f3097e79bb03..e714d8b6ef89 100644
> --- a/include/xen/interface/hvm/hvm_op.h
> +++ b/include/xen/interface/hvm/hvm_op.h
> @@ -46,4 +46,19 @@ struct xen_hvm_get_mem_type {
>   };
>   DEFINE_GUEST_HANDLE_STRUCT(xen_hvm_get_mem_type);
>   
> +/*
> + * HVMOP_set_evtchn_upcall_vector: Set a <vector> that should be used for event
> + *                                 channel upcalls on the specified <vcpu>. If set,
> + *                                 this vector will be used in preference to the
> + *                                 domain global callback via (see
> + *                                 HVM_PARAM_CALLBACK_IRQ).
> + */

Technically this hypercall is x86 specific. IOW, it would be possible 
for another architecture to define 23 for something different.

If it is not possible (or desired) to surround with an #ifdef, then I 
think we should at least be mentioned it in the comment.

Cheers,

-- 
Julien Grall
