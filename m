Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20E74CB790
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 08:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiCCHUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 02:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiCCHUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 02:20:23 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663F31567B3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 23:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646291978; x=1677827978;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=byfI6ZD/mTZQBtc8lg28DE8DSoO/IS2OKwGlLuNHLsI=;
  b=fJ4KXuN70vpjr9DwxiINQWnixs+qOtcuVVXsvW1S0PHp4iy9J4AyRDSH
   YOnpru15UKNKF3HuSxrspVNm4Zc7g3JaRIeaYEj67ZH35er0Ng/RbBgah
   2XexCIUqEENwTDhMeuJCcsYxGdfWWSaZjXL4PU/k4U/FPWSzHQm2JAFx+
   l+WN2VdatLkbi0NG98qUVvpbqGOtN3OC2aRMA2mRG/eAv9wM0nQxNuZH5
   wG8Xh49HGqyv7bQhs+sE0IWc/6+kvPpIz9rZdyoKIGOpXXDrsQRXW9XLA
   g+EWxXn/oWvWcTWH3mio7dT9HIADAm24iMfj/b02ICJz0gu38aI3+/B0V
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="278280105"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="278280105"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 23:19:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="535712029"
Received: from louislifei-optiplex-7090.sh.intel.com (HELO louislifei-OptiPlex-7090) ([10.239.146.211])
  by orsmga007.jf.intel.com with ESMTP; 02 Mar 2022 23:19:36 -0800
Date:   Thu, 3 Mar 2022 15:19:53 +0800
From:   Li Fei1 <fei1.li@intel.com>
To:     Xiaolong Huang <butterflyhuangxx@gmail.com>
Cc:     linux-kernel@vger.kernel.org, fei1.li@intel.com
Subject: Re: [RESEND PATCH] virt: acrn: fix a memory leak in acrn_dev_ioctl()
Message-ID: <20220303071953.GA763961@louislifei-OptiPlex-7090>
References: <20220303065401.259202-1-butterflyhuangxx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303065401.259202-1-butterflyhuangxx@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 02:54:00PM +0800, Xiaolong Huang wrote:
> The vm_param and cpu_regs need to be freed via kfree()
> before return -EINVAL error.
> 
> Fixes: 9c5137aedd11 ("virt: acrn: Introduce VM management interfaces")
> Fixes: 2ad2aaee1bc9 ("virt: acrn: Introduce an ioctl to set vCPU registers state")
> Signed-off-by: Xiaolong Huang <butterflyhuangxx@gmail.com>
LGTM, thanks.

Please add Signed-off-by: Fei Li <fei1.li@intel.com>

> ---
>  drivers/virt/acrn/hsm.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
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
> 
> base-commit: 5859a2b1991101d6b978f3feb5325dad39421f29
> -- 
> 2.25.1
> 
