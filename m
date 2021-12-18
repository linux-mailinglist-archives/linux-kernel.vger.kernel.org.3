Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1698479DE1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 22:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbhLRV7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 16:59:54 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33178 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhLRV7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 16:59:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2312A60B8D;
        Sat, 18 Dec 2021 21:59:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07558C36AE2;
        Sat, 18 Dec 2021 21:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639864792;
        bh=wam9loU8V856n8e0hFf1diTiVcbDuIvMneEPX8rUNV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=REadAfyLv1DPdHMcI3znvivxHTwBT+obVubXSCL2jk37x8zJZ6X17ndi+m11UKL5F
         pmqxCOO1O6Lat6Eo8Eb8K/03XKBaqty8OBqigHWKSrveq+L30YRB0SPL2GLiHjgZ3K
         S47e4JEHf0PX3BHlYQ4uMFIeMyxqs5y8a/OELfaA/8sAtvSbbMUhoh6DIFtdCurwHW
         7L0tGvG4hDH/RGncFZrtqwfYEjIwpePL2EZJLlEyhLd0DGBLzvYqIME0nZQPUGukuF
         ny/KIh/BWGDIHpPqMfaJouiRMXiEO0EyJXBtOAt94sCi1vqgixdyH2Rps4oqsm6tjX
         iy/tlh9EkH1/Q==
Date:   Sat, 18 Dec 2021 14:59:48 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     trix@redhat.com
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, ndesaulniers@google.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] gpio: sim: fix uninitialized ret variable
Message-ID: <Yb5Z1A1tX6xdrDce@archlinux-ax161>
References: <20211218152712.2832502-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211218152712.2832502-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 18, 2021 at 07:27:12AM -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Building with clang returns this error:
> 
> gpio-sim.c:889:7: error: variable 'ret' is uninitialized
>   when used here
> 
> ret should be the status of the call to
> gpio_sim_make_bank_swnode stored in bank->swnode.
> 
> Fixes: 83960fcf4818 ("gpio: sim: new testing module")
> Signed-off-by: Tom Rix <trix@redhat.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  drivers/gpio/gpio-sim.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
> index ef6145f51c8ae..bef00dcc4dc8f 100644
> --- a/drivers/gpio/gpio-sim.c
> +++ b/drivers/gpio/gpio-sim.c
> @@ -886,7 +886,8 @@ static int gpio_sim_device_activate_unlocked(struct gpio_sim_device *dev)
>  
>  	list_for_each_entry(bank, &dev->bank_list, siblings) {
>  		bank->swnode = gpio_sim_make_bank_swnode(bank, swnode);
> -		if (ret) {
> +		if (IS_ERR(bank->swnode)) {
> +			ret = PTR_ERR(bank->swnode);
>  			gpio_sim_remove_swnode_recursive(swnode);
>  			return ret;
>  		}
> -- 
> 2.26.3
> 
