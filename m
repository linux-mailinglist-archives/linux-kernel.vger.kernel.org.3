Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0304CB6A3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 07:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiCCGCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 01:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiCCGCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 01:02:17 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC612119F19
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 22:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646287293; x=1677823293;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0Z+ZH1umZkNELFDPrnAM2VJLDXgRWD8auXJ2VBm24Ag=;
  b=VlpnNcfciImA/roIatHUurSj3z2+9y4tIkjx2IfSIe6Y90XvWgUCViMI
   veIUMYnUYkCZRvnJ1wxGRgQU1GMroEzlrrBe3VQeFVbEFUHbnePuvNEGs
   AxV/hq7eo5L9gWlW7PxPg+L8vsqFOWKgp0PMK9it0o9qOqUz3gLT4+54N
   SrKo/BVOA33n/OUE0Qgpe53trvloKv9hdOGYj5aoNUjyJSDV8Mc+fnUUS
   noEUStliOZ/dq6Tp8SDR+USZK36/aNv0HkfJEpVBuVBkBDVH6mwgWDujk
   l1LpWoM2CEI46vmsDtc30QVub/ZZ/naaLAA+KJOSGpBiF0ibNLRWQoIIZ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="252413638"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="252413638"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 22:01:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="508468671"
Received: from louislifei-optiplex-7050.sh.intel.com (HELO louislifei-OptiPlex-7050) ([10.239.81.140])
  by orsmga002.jf.intel.com with ESMTP; 02 Mar 2022 22:01:08 -0800
Date:   Thu, 3 Mar 2022 14:01:52 +0800
From:   Li Fei1 <fei1.li@intel.com>
To:     Xiaolong Huang <butterflyhuangxx@gmail.com>
Cc:     linux-kernel@vger.kernel.org, fei1.li@intel.com
Subject: Re: [PATCH] virt: acrn: fix a memory leak in acrn_dev_ioctl()
Message-ID: <20220303060152.GA5056@louislifei-OptiPlex-7050>
References: <20220301100059.1834362-1-butterflyhuangxx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301100059.1834362-1-butterflyhuangxx@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 06:00:59PM +0800, Xiaolong Huang wrote:
> The vm_param and cpu_regs need to be freed via kfree() before return -EINVAL error.
> 
> Fixes: 9c5137aedd11 ("virt: acrn: Introduce VM management interfaces")
> Fixes: 2ad2aaee1bc9 ("virt: acrn: Introduce an ioctl to set vCPU registers state")
> Signed-off-by: Xiaolong Huang <butterflyhuangxx@gmail.com>
> ---
>  drivers/virt/acrn/hsm.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
Hi Xiaolong

Thanks for helping to fix this issue.

This patch looks good. But I didn't see the base tree information of your patch applies to.
Would you please help to record it.

Thanks.

> diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
> index 5419794fccf1..423ea888d79a 100644
> --- a/drivers/virt/acrn/hsm.c
> +++ b/drivers/virt/acrn/hsm.c
> @@ -136,8 +136,10 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
>  		if (IS_ERR(vm_param))
>  			return PTR_ERR(vm_param);
>  
> -		if ((vm_param->reserved0 | vm_param->reserved1) != 0)
> +		if ((vm_param->reserved0 | vm_param->reserved1) != 0) {
> +			kfree(vm_param);
>  			return -EINVAL;
> +		}
>  
>  		vm = acrn_vm_create(vm, vm_param);
>  		if (!vm) {
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
