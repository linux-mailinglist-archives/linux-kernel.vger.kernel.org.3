Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 788F9483B31
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 04:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbiADDtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 22:49:42 -0500
Received: from mga09.intel.com ([134.134.136.24]:21362 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231165AbiADDtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 22:49:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641268181; x=1672804181;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=6zBoWgCly54NWJuAc14YtN3+mcG8gVTMTriRABr5dAo=;
  b=JKAIGFFZy06qWmiEPgPp6d1wQhzib7HwwREvX2S/rRVjPv7mSSvuYT/I
   drLIdJ6CXilEOhvbqJK3LhzLJsN6bwJ/owsQsHt+6DMUacY7V7fHulGRG
   2RqInAFCjwKZN5G1wO38X92b0Ke5xKSXhQcrGPwQMNflRLFogWoXpRim3
   ogL+9GrKu9Mp9YmGMdujexA4pfGbw0yqZDVWCW/MGzXBmmh0ScopclWtL
   kWuGa9tgivJb+gdKa2BwfV9fhEjOsK6uJY5FPPd3OU30WWWpGxosyTwGz
   pwva6PKxVeZZcwNb3FEn9EfP3B4Q3C45OMFMMsvBm0BU/xuJqiMW0cClj
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="241948296"
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="241948296"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 19:49:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="620498054"
Received: from louislifei-optiplex-7050.sh.intel.com (HELO louislifei-OptiPlex-7050) ([10.239.154.151])
  by orsmga004.jf.intel.com with ESMTP; 03 Jan 2022 19:49:39 -0800
Date:   Tue, 4 Jan 2022 11:50:33 +0800
From:   Li Fei1 <fei1.li@intel.com>
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     kjlu@umn.edu, gregkh@linuxfoundation.org,
        reinette.chatre@intel.com, zhi.a.wang@intel.com,
        linux-kernel@vger.kernel.org, fei1.li@intel.com
Subject: Re: [PATCH] virt: acrn: fix a memory leak bug in acrn_dev_ioctl()
Message-ID: <20220104035032.GA27848@louislifei-OptiPlex-7050>
References: <20220104024729.GA26952@louislifei-OptiPlex-7050>
 <20220104034501.45715-1-zhou1615@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220104034501.45715-1-zhou1615@umn.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 11:45:01AM +0800, Zhou Qingyang wrote:
> In acrn_dev_ioctl(), vm_param is not released or passed out on the 
> error path of "if ((vm_param->reserved0 | vm_param->reserved1) != 0)", 
> which could lead to a memory leak.
> 
> Fix this bug by adding a kfree of vm_param on the error path.
> 
> This bug was found by a static analyzer.
> 
> Builds with CONFIG_ACRN_GUEST=y, CONFIG_ACRN_HSM=y show no new warnings, 
> and our static analyzer no longer warns about this code.
> 
> Fixes: 9c5137aedd11 (“9c5137aedd11 virt: acrn: Introduce VM management interfaces”)
> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> ---
> The analysis employs differential checking to identify inconsistent
> security operations (e.g., checks or kfrees) between two code paths
> and confirms that the inconsistent operations are not recovered in 
> the current function or the callers, so they constitute bugs. 
> 
> Note that, as a bug found by static analysis, it can be a false
> positive or hard to trigger. Multiple researchers have cross-reviewed
> the bug.
> 
> Changes in v2:
>   -  Fix the same bug in ACRN_IOCTL_SET_VCPU_REGS.
> 

Signed-off-by: Fei Li <fei1.li@intel.com>

Thanks a lot.

>  drivers/virt/acrn/hsm.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
> index 5419794fccf1..7a8f722f431c 100644
> --- a/drivers/virt/acrn/hsm.c
> +++ b/drivers/virt/acrn/hsm.c
> @@ -136,9 +136,11 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
>  		if (IS_ERR(vm_param))
>  			return PTR_ERR(vm_param);
>  
> -		if ((vm_param->reserved0 | vm_param->reserved1) != 0)
> -			return -EINVAL;
> -
> +		if ((vm_param->reserved0 | vm_param->reserved1) != 0) {
> +			ret = -EINVAL;
> +			kfree(vm_param);
> +			break;
> +		}
>  		vm = acrn_vm_create(vm, vm_param);
>  		if (!vm) {
>  			ret = -EINVAL;
> @@ -182,21 +184,29 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
>  			return PTR_ERR(cpu_regs);
>  
>  		for (i = 0; i < ARRAY_SIZE(cpu_regs->reserved); i++)
> -			if (cpu_regs->reserved[i])
> +			if (cpu_regs->reserved[i]) {
> +				kfree(cpu_regs);
>  				return -EINVAL;
> +			}
>  
>  		for (i = 0; i < ARRAY_SIZE(cpu_regs->vcpu_regs.reserved_32); i++)
> -			if (cpu_regs->vcpu_regs.reserved_32[i])
> +			if (cpu_regs->vcpu_regs.reserved_32[i]) {
> +				kfree(cpu_regs);
>  				return -EINVAL;
> +			}
>  
>  		for (i = 0; i < ARRAY_SIZE(cpu_regs->vcpu_regs.reserved_64); i++)
> -			if (cpu_regs->vcpu_regs.reserved_64[i])
> +			if (cpu_regs->vcpu_regs.reserved_64[i]) {
> +				kfree(cpu_regs);
>  				return -EINVAL;
> +			}
>  
>  		for (i = 0; i < ARRAY_SIZE(cpu_regs->vcpu_regs.gdt.reserved); i++)
>  			if (cpu_regs->vcpu_regs.gdt.reserved[i] |
> -			    cpu_regs->vcpu_regs.idt.reserved[i])
> +			    cpu_regs->vcpu_regs.idt.reserved[i]) {
> +				kfree(cpu_regs);
>  				return -EINVAL;
> +			}
>  
>  		ret = hcall_set_vcpu_regs(vm->vmid, virt_to_phys(cpu_regs));
>  		if (ret < 0)
> -- 
> 2.25.1
> 
