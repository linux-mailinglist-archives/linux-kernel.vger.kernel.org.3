Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EAB5AC584
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 18:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbiIDQ4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 12:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiIDQ4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 12:56:15 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EAC30565;
        Sun,  4 Sep 2022 09:56:11 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id b9so5090321qka.2;
        Sun, 04 Sep 2022 09:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=DweC0xGYEQiKuhEU2wfv4BL8C5hOa+ko8JEuIgGa79M=;
        b=LRaoVWgJT9RdH4EGC2nrqbah10twpMB/cBIeHGVoBfRxMiT1wWvOtp0qxDtN0MIIuJ
         zdjvxiXfzblBcqx3wgdHbU1iBqlz+0n6fqIH27IAWlfiCaiwBRw7zISg8nr6y/iAEV1q
         GjM5n3Vv09/1NMPvHHKsfh4lM9dZL9x5+QKIwgWWrHrXX22M4LFtnbcfQFSMluKpUkv1
         MFKJcFDYIZv6CtqWtP53fSqyfDWvhY+L33nJnuNw+qUmEY7yxcs3V6mz0E3ciWdDI3Ci
         voNOS99El6qtL2lqqhT1OGkrMIxDLw9m7gss6fsTRHptHm1U1RYVyQu58DzgALF3Qq9q
         awdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=DweC0xGYEQiKuhEU2wfv4BL8C5hOa+ko8JEuIgGa79M=;
        b=ufzbYOfSU/qvRmT7xBsX8+zxP6VDTTWwf+dnEKM48JU9p3EQ94dvzdZaS+z22djhzA
         ZjYdIBHQvSCsE/oozwgLO+GpouRuFxMBihs2n+YbEi2ZXk8Ve9arqbyqF7mf82QmUMAn
         5P41Y26SrZTFz8RSUo1v+dJk60Ilda3p+DeTTJsJwdbzvr/qIYQg9n58JLSTD520O0Ad
         PUnXQF7dpovEdnqotARkfKgYKrRFMUA4K0MB9JmmJtB2k+z2jH13bnDuxwzT6DNozzfR
         qZtQcpxve9ohbAcq9nNjOOcuAujm3hl3vOlPqk0JRQ5javbgC07AANxK7Gwop8lceCYJ
         qx2Q==
X-Gm-Message-State: ACgBeo3kSgxAYsgKazrT3BvhdcLnUCRPSeYciQhZjVWoM2g1lYnLRG33
        YoIdCmgr1DCjbWmCQ2mCdw==
X-Google-Smtp-Source: AA6agR7ugl73vbBqSVIq3LKbH4H4rLGSvzd8kxJ/CT2BLQss06uJv73Yx8FnWndMyA3intEFDR1fdg==
X-Received: by 2002:a05:620a:46a8:b0:6bb:29e6:f315 with SMTP id bq40-20020a05620a46a800b006bb29e6f315mr30165251qkb.714.1662310570611;
        Sun, 04 Sep 2022 09:56:10 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id 6-20020a370c06000000b006bbbd4ce6e1sm5912645qkm.35.2022.09.04.09.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 09:56:10 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:e25f:adca:563b:692])
        by serve.minyard.net (Postfix) with ESMTPSA id E16B01828A0;
        Sun,  4 Sep 2022 16:56:08 +0000 (UTC)
Date:   Sun, 4 Sep 2022 11:56:07 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net
Subject: Re: [PATCH] ipmi: kcs_bmc: Avoid wasting some memory.
Message-ID: <YxTYp6Hhmqdou3S9@minyard.net>
Reply-To: minyard@acm.org
References: <5d69a2d0939ce3917c856b36ef1e41b579081be6.1662298496.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d69a2d0939ce3917c856b36ef1e41b579081be6.1662298496.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Andrew, the author of this code.

On Sun, Sep 04, 2022 at 03:35:16PM +0200, Christophe JAILLET wrote:
> KCS_MSG_BUFSIZ is 1000.
> 
> When using devm_kmalloc(), there is a small memory overhead and, on most
> systems, this leads to 40 bytes of extra memory allocation.
> So 1040 bytes are expected to be allocated.
> 
> The memory allocator works with fixed size hunks of memory. In this case,
> it will require 2048 bytes of memory because more than 1024 bytes are
> required.
> 
> So, when requesting 3 x 1000 bytes, it ends up to 2048 x 3.
> 
> In order to avoid wasting 3ko of memory, allocate buffers all at once.
> 3000+40 bytes will be required and 4ko allocated. This still wastes 1ko,
> but it is already better.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Looking at this code, I wonder why priv->miscdev.name is not freed in
> kcs_bmc_ipmi_remove_device()?

If I understand correctly, none of these need to be freed.  devm
allocated memory is freed automatically when the device is removed.

> 
> If this make sense, this also mean that KCS_MSG_BUFSIZ can be increased at
> no cost.
> Or it could be slightly reduce to around 1024-40-1 bytes to keep the logic
> which is in place.
> 
> Another solution would be to use just kmalloc and add a
> devm_add_action_or_reset() call and a function that frees the memory.
> If it make sense, KCS_MSG_BUFSIZ could be increased to 1024 and we would
> allocate just a little above 3x1024 bytes.
> ---
>  drivers/char/ipmi/kcs_bmc_cdev_ipmi.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c b/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
> index 486834a962c3..15a4a39a6478 100644
> --- a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
> +++ b/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
> @@ -485,14 +485,15 @@ static int kcs_bmc_ipmi_add_device(struct kcs_bmc_device *kcs_bmc)
>  
>  	priv->client.dev = kcs_bmc;
>  	priv->client.ops = &kcs_bmc_ipmi_client_ops;
> -	priv->data_in = devm_kmalloc(kcs_bmc->dev, KCS_MSG_BUFSIZ, GFP_KERNEL);
> -	priv->data_out = devm_kmalloc(kcs_bmc->dev, KCS_MSG_BUFSIZ, GFP_KERNEL);
> -	priv->kbuffer = devm_kmalloc(kcs_bmc->dev, KCS_MSG_BUFSIZ, GFP_KERNEL);
> +	/* Allocate buffers all at once */
> +	priv->data_in = devm_kmalloc(kcs_bmc->dev, KCS_MSG_BUFSIZ * 3, GFP_KERNEL);
> +	priv->data_out = priv->data_in + KCS_MSG_BUFSIZ;
> +	priv->kbuffer  = priv->data_in + KCS_MSG_BUFSIZ * 2;

You are doing arithmetic on a possibly NULL pointer.  It's generally ok,
but kind of frowned upon.

Andew, what do you think?  I guess it saves a little memory.

-Corey

>  
>  	priv->miscdev.minor = MISC_DYNAMIC_MINOR;
>  	priv->miscdev.name = devm_kasprintf(kcs_bmc->dev, GFP_KERNEL, "%s%u", DEVICE_NAME,
>  					   kcs_bmc->channel);
> -	if (!priv->data_in || !priv->data_out || !priv->kbuffer || !priv->miscdev.name)
> +	if (!priv->data_in || !priv->miscdev.name)
>  		return -EINVAL;
>  
>  	priv->miscdev.fops = &kcs_bmc_ipmi_fops;
> @@ -531,8 +532,6 @@ static int kcs_bmc_ipmi_remove_device(struct kcs_bmc_device *kcs_bmc)
>  
>  	misc_deregister(&priv->miscdev);
>  	kcs_bmc_disable_device(priv->client.dev, &priv->client);
> -	devm_kfree(kcs_bmc->dev, priv->kbuffer);
> -	devm_kfree(kcs_bmc->dev, priv->data_out);
>  	devm_kfree(kcs_bmc->dev, priv->data_in);
>  	devm_kfree(kcs_bmc->dev, priv);
>  
> -- 
> 2.34.1
> 
