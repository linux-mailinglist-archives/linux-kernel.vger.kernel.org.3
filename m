Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52EF2536250
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 14:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241557AbiE0MV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 08:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353384AbiE0MLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 08:11:06 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE9514C755;
        Fri, 27 May 2022 04:58:49 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-f2a4c51c45so5474547fac.9;
        Fri, 27 May 2022 04:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=riYAAbHRq92K+lwWVOP6j+tCvpF9+fWD5d6/UiGVh3M=;
        b=iPwRxPV2145O5j0i2udTirgYfsApHfipu9c9nyWpwIRHsdQqkzditjcyd5WrM6DPuv
         pTlM3xrtQ/VSAy59YZWk26Ko61+REu5+SeNsglqU72jwkVkPYwfOfrLngv8b5xo9rUek
         pbLw+86M1Pqioj0EnZcO1SXeV9a1yJ89XkCZ52cY+gvvLiqC2Nv8AMjN1j311NKP0soa
         Ys27UvHfKNTay9dEM265vlWmi8j92oiwCa3g8jjsHQRLf1hunTLVcm7wbbEpuwSPDW4+
         CxEH4C7cc6vG0LVqMtLl84lZ+WN9FIs+z1ri7lb4SecBOQ9rlAOLJyUEhSDR5VgjqL0/
         j1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=riYAAbHRq92K+lwWVOP6j+tCvpF9+fWD5d6/UiGVh3M=;
        b=Yr/oVDZiac4xgGp0M/k+tHNta2mY8jwpuUANhVaCWXSlNjKPyjyt5G2k4LlAiS5LlE
         Gkg7+6f1IhBgeK556vUPWE9u9Yb8sjSLYogjDHm34NiIhonzLDwQ3X0V8FMuD/dHJOp8
         jyeEw7MWmMNjONTrxejQI/sJ+AR+1v22aDP3WDsC/9+3C3XVaN3orxAAhol1FXuoSMem
         6Gd1rnDGltqPIE3wbIB7THJK+lDUHHHGDI2xHJTdvaB/Hvz8j+NFFJbPR85MTBsFbcac
         8mgARIFsy549i9cYzg9i5FOwKSrSiMwqpA/TyZtpHIt/AtuxFFivFbI/WIkuXjDJI+tV
         1xFQ==
X-Gm-Message-State: AOAM532W9S5A4wsLYdwBR1m16ete1bCvEgpQ7CDKox9jg8Jn5xXlQC7K
        8s+Ts7g9nzUKckBQVlszGA==
X-Google-Smtp-Source: ABdhPJxJjIIYyrcib/I+TdXI7CjKXK7Wk/Zyx+OzIi2pCj0tEGYDCPowZiVCZFfWGv92m5fD99xGlQ==
X-Received: by 2002:a05:6870:4788:b0:ee:3a:8ab3 with SMTP id c8-20020a056870478800b000ee003a8ab3mr3546603oaq.231.1653652728251;
        Fri, 27 May 2022 04:58:48 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id r36-20020a05683044a400b0060ae5f10973sm1654569otv.15.2022.05.27.04.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 04:58:47 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:9845:e734:5235:fb48])
        by serve.minyard.net (Postfix) with ESMTPSA id AA0FE1800B7;
        Fri, 27 May 2022 11:58:46 +0000 (UTC)
Date:   Fri, 27 May 2022 06:58:45 -0500
From:   Corey Minyard <minyard@acm.org>
To:     keliu <liuke94@huawei.com>
Cc:     mpm@selenic.com, herbert@gondor.apana.org.au,
        sudipm.mukherjee@gmail.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, mst@redhat.com, lvivier@redhat.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: char: Directly use ida_alloc()/free()
Message-ID: <20220527115845.GJ3767252@minyard.net>
Reply-To: minyard@acm.org
References: <20220527074422.2475104-1-liuke94@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527074422.2475104-1-liuke94@huawei.com>
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

On Fri, May 27, 2022 at 07:44:22AM +0000, keliu wrote:
> Use ida_alloc()/ida_free() instead of deprecated
> ida_simple_get()/ida_simple_remove() .
> 
> Signed-off-by: keliu <liuke94@huawei.com>
> ---
>  drivers/char/hw_random/virtio-rng.c | 6 +++---
>  drivers/char/ipmi/ipmi_msghandler.c | 4 ++--
>  drivers/char/ppdev.c                | 6 +++---
>  3 files changed, 8 insertions(+), 8 deletions(-)

If you want this to go into individual maintainer trees, you will need
to split it up.  Otherwise, how are you planning to get this change
into the kernel?

-corey

> 
> diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
> index e856df7e285c..0ee602963c50 100644
> --- a/drivers/char/hw_random/virtio-rng.c
> +++ b/drivers/char/hw_random/virtio-rng.c
> @@ -135,7 +135,7 @@ static int probe_common(struct virtio_device *vdev)
>  	if (!vi)
>  		return -ENOMEM;
>  
> -	vi->index = index = ida_simple_get(&rng_index_ida, 0, 0, GFP_KERNEL);
> +	vi->index = index = ida_alloc(&rng_index_ida, GFP_KERNEL);
>  	if (index < 0) {
>  		err = index;
>  		goto err_ida;
> @@ -165,7 +165,7 @@ static int probe_common(struct virtio_device *vdev)
>  	return 0;
>  
>  err_find:
> -	ida_simple_remove(&rng_index_ida, index);
> +	ida_free(&rng_index_ida, index);
>  err_ida:
>  	kfree(vi);
>  	return err;
> @@ -183,7 +183,7 @@ static void remove_common(struct virtio_device *vdev)
>  		hwrng_unregister(&vi->hwrng);
>  	virtio_reset_device(vdev);
>  	vdev->config->del_vqs(vdev);
> -	ida_simple_remove(&rng_index_ida, vi->index);
> +	ida_free(&rng_index_ida, vi->index);
>  	kfree(vi);
>  }
>  
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index f1827257ef0e..c1584ed24a6b 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -3018,7 +3018,7 @@ static void cleanup_bmc_work(struct work_struct *work)
>  	int id = bmc->pdev.id; /* Unregister overwrites id */
>  
>  	platform_device_unregister(&bmc->pdev);
> -	ida_simple_remove(&ipmi_bmc_ida, id);
> +	ida_free(&ipmi_bmc_ida, id);
>  }
>  
>  static void
> @@ -3134,7 +3134,7 @@ static int __ipmi_bmc_register(struct ipmi_smi *intf,
>  
>  		bmc->pdev.name = "ipmi_bmc";
>  
> -		rv = ida_simple_get(&ipmi_bmc_ida, 0, 0, GFP_KERNEL);
> +		rv = ida_alloc(&ipmi_bmc_ida, GFP_KERNEL);
>  		if (rv < 0) {
>  			kfree(bmc);
>  			goto out;
> diff --git a/drivers/char/ppdev.c b/drivers/char/ppdev.c
> index 38b46c7d1737..f6024d97fe70 100644
> --- a/drivers/char/ppdev.c
> +++ b/drivers/char/ppdev.c
> @@ -299,7 +299,7 @@ static int register_device(int minor, struct pp_struct *pp)
>  		goto err;
>  	}
>  
> -	index = ida_simple_get(&ida_index, 0, 0, GFP_KERNEL);
> +	index = ida_alloc(&ida_index, GFP_KERNEL);
>  	memset(&ppdev_cb, 0, sizeof(ppdev_cb));
>  	ppdev_cb.irq_func = pp_irq;
>  	ppdev_cb.flags = (pp->flags & PP_EXCL) ? PARPORT_FLAG_EXCL : 0;
> @@ -310,7 +310,7 @@ static int register_device(int minor, struct pp_struct *pp)
>  	if (!pdev) {
>  		pr_warn("%s: failed to register device!\n", name);
>  		rc = -ENXIO;
> -		ida_simple_remove(&ida_index, index);
> +		ida_free(&ida_index, index);
>  		goto err;
>  	}
>  
> @@ -750,7 +750,7 @@ static int pp_release(struct inode *inode, struct file *file)
>  
>  	if (pp->pdev) {
>  		parport_unregister_device(pp->pdev);
> -		ida_simple_remove(&ida_index, pp->index);
> +		ida_free(&ida_index, pp->index);
>  		pp->pdev = NULL;
>  		pr_debug(CHRDEV "%x: unregistered pardevice\n", minor);
>  	}
> -- 
> 2.25.1
> 
