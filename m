Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C894750ACD6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 02:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442963AbiDVAjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 20:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiDVAjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 20:39:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E16C3F8A1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 17:36:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4AC22B829D0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 00:36:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 623EDC385A5;
        Fri, 22 Apr 2022 00:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650587812;
        bh=q77UrqyhbHNMDbtjl23QSlBQJqBW2qP/oerjc/apOe0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=O8K3b3ix/Aoq1gJHNVNPUCqoWFQCq5larOk4rtjfKjmMzsI3R228DrK0i5oZVxhnB
         xMu4yAbbvCnQMv+SNmGHPNiWBehcWGZ/7PwvzIHEWMmbyhRYfJGCfUQ7XMXhNptv3Y
         Ik1QPXzlX3MVQZhtndW7G0GzqkRrfZlnO6XIotP3waUhFWTeEYl8qJYnSZHK6RmPPJ
         63zDZGVx+kWkl9j3jmADIPqrSZPP04Yi0rHW2X8RyGjDPlsaD62ZmLE0Ep4nwKBQ1l
         N0qjuXKWN9v+PpLfp1PDZWXyOSYbQD1cpPaKDlB8HA14Fgmk0BLSPI2qbtB2xGsa73
         zy0oqZI4WmJSQ==
Date:   Thu, 21 Apr 2022 17:36:50 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Miaoqian Lin <linmq006@gmail.com>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Shannon Zhao <shannon.zhao@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Grall <julien.grall@arm.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm/xen: Fix some refcount leaks
In-Reply-To: <20220420014913.2586-1-linmq006@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2204211727060.915916@ubuntu-linux-20-04-desktop>
References: <20220406021905.GA30436@8345e2a12d0c> <20220420014913.2586-1-linmq006@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2022, Miaoqian Lin wrote:
> The of_find_compatible_node() function returns a node pointer with
> refcount incremented, We should use of_node_put() on it when done
> Add the missing of_node_put() to release the refcount.
> 
> Fixes: 9b08aaa3199a ("ARM: XEN: Move xen_early_init() before efi_init()")
> Fixes: b2371587fe0c ("arm/xen: Read extended regions from DT and init Xen resource")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

Juergen,  Boris,
I applied the patch to for-linus-5.18


> ---
> changes in v2:
> - call of_node_put in non-error path in xen_dt_guest_init
> - fix same refcount leak error in arch_xen_unpopulated_init
> ---
>  arch/arm/xen/enlighten.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> index ec5b082f3de6..07eb69f9e7df 100644
> --- a/arch/arm/xen/enlighten.c
> +++ b/arch/arm/xen/enlighten.c
> @@ -337,12 +337,15 @@ int __init arch_xen_unpopulated_init(struct resource **res)
>  
>  	if (!nr_reg) {
>  		pr_err("No extended regions are found\n");
> +		of_node_put(np);
>  		return -EINVAL;
>  	}
>  
>  	regs = kcalloc(nr_reg, sizeof(*regs), GFP_KERNEL);
> -	if (!regs)
> +	if (!regs) {
> +		of_node_put(np);
>  		return -ENOMEM;
> +	}
>  
>  	/*
>  	 * Create resource from extended regions provided by the hypervisor to be
> @@ -403,8 +406,8 @@ int __init arch_xen_unpopulated_init(struct resource **res)
>  	*res = &xen_resource;
>  
>  err:
> +	of_node_put(np);
>  	kfree(regs);
> -
>  	return rc;
>  }
>  #endif
> @@ -424,8 +427,10 @@ static void __init xen_dt_guest_init(void)
>  
>  	if (of_address_to_resource(xen_node, GRANT_TABLE_INDEX, &res)) {
>  		pr_err("Xen grant table region is not found\n");
> +		of_node_put(xen_node);
>  		return;
>  	}
> +	of_node_put(xen_node);
>  	xen_grant_frames = res.start;
>  }
>  
> -- 
> 2.17.1
> 
