Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94C24D13F9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 10:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345533AbiCHJ5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 04:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345506AbiCHJ5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 04:57:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DF3424B7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 01:56:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F029614AF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 09:56:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21591C340EB;
        Tue,  8 Mar 2022 09:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646733372;
        bh=Gf8xjLLG6y2c+UbvP31+EcyVjgRh5mZ67b05LPS1FC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QIbDi8pzn/L62J4mO2VAKJtr/Ln6xIG+pDuC7C5pDr0WDj7rW5hOisSwVUR9ikHKz
         LaQTRpuGdaSs3MMCW4xYafafCa06JRupvmR+GBOQ3G78s4olPXHjuwPeEWY6MvUjBx
         4P9FvrJbWAVy6QmyfCXewZpKS4JjNE1eWabTtDmo=
Date:   Tue, 8 Mar 2022 10:56:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xiaolong Huang <butterflyhuangxx@gmail.com>
Cc:     fei1.li@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virt: acrn: fix a memory leak in acrn_dev_ioctl()
Message-ID: <YicoOC+WZhNLq+pX@kroah.com>
References: <20220308092047.1008409-1-butterflyhuangxx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308092047.1008409-1-butterflyhuangxx@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 05:20:47PM +0800, Xiaolong Huang wrote:
> The vm_param and cpu_regs need to be freed via kfree()
> before return -EINVAL error.
> 
> Fixes: 9c5137aedd11 ("virt: acrn: Introduce VM management interfaces")
> Fixes: 2ad2aaee1bc9 ("virt: acrn: Introduce an ioctl to set vCPU registers state")
> Signed-off-by: Xiaolong Huang <butterflyhuangxx@gmail.com>
> Signed-off-by: Fei Li <fei1.li@intel.com>
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

How did you test this?
