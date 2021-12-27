Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81BF848004F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 16:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240109AbhL0Poj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 10:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239120AbhL0PlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 10:41:04 -0500
X-Greylist: delayed 321 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Dec 2021 07:40:17 PST
Received: from mail.bugwerft.de (mail.bugwerft.de [IPv6:2a03:6000:1011::59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15017C061784
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 07:40:16 -0800 (PST)
Received: from [192.168.2.141] (p57a52d4a.dip0.t-ipconnect.de [87.165.45.74])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 1EAFF282E51;
        Mon, 27 Dec 2021 15:34:52 +0000 (UTC)
Message-ID: <b4a94938-9443-14e8-af86-229f61970657@zonque.org>
Date:   Mon, 27 Dec 2021 16:34:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] ARM: pxa: Fix error handling in viper_tpm_init
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <marc.zyngier@altran.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211227125154.3145-1-linmq006@gmail.com>
From:   Daniel Mack <daniel@zonque.org>
In-Reply-To: <20211227125154.3145-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27/12/2021 13:51, Miaoqian Lin wrote:
> tpm_device get by platform_device_alloc(), which calls device_initialize.
> Call platform_device_put(tpm_device) instead of kfree(tmp_device) to
> prevent memory leak.

While this seems correct, I don't think we should make any effort to 
maintain legacy board support files but rather move to DTS instead. 
Robert and I laid the foundation and ported a few machines a while ago, 
but I was reluctant to touch the board support code I can't test on real 
hardware.

As you seem to have access to a Viper board, could you have a look at 
the existing device-tree ported PXA machines and see if you can follow 
suit here please?


Thanks,
Daniel


> 
> Fixes: 352699a ("Basic support for the Arcom/Eurotech Viper SBC.")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>   arch/arm/mach-pxa/viper.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
> index 3aa34e9a15d3..9a0f184dbecb 100644
> --- a/arch/arm/mach-pxa/viper.c
> +++ b/arch/arm/mach-pxa/viper.c
> @@ -815,11 +815,11 @@ static void __init viper_tpm_init(void)
>   					      sizeof(i2c_tpm_data))) {
>   			if (platform_device_add(tpm_device)) {
>   				errstr = "register TPM i2c bus";
> -				goto error_free_tpm;
> +				goto exit_put_device;
>   			}
>   		} else {
>   			errstr = "allocate TPM i2c bus data";
> -			goto error_free_tpm;
> +			goto exit_put_device;
>   		}
>   	} else {
>   		errstr = "allocate TPM i2c device";
> @@ -827,9 +827,8 @@ static void __init viper_tpm_init(void)
>   	}
>   
>   	return;
> -
> -error_free_tpm:
> -	kfree(tpm_device);
> +exit_put_device:
> +	platform_device_put(tpm_device);
>   error_tpm:
>   	pr_err("viper: Couldn't %s, giving up\n", errstr);
>   }

