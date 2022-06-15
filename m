Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658B454CC7B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347532AbiFOPQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347151AbiFOPQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:16:30 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334243DA46
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:16:29 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id a10so6492168wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wau0fGW8yZsKjnuoyb0VTR4qVyMVH48h3qQAcCmJxHM=;
        b=gsDwJdxlq2oa/E5drVyaHd8AqIB5EsHJGZX+yJs4Bh3IZRZWhyJg1tzAiW9vxJl9/Q
         I6bZWcAHui00mntM2ACoE/BL7ZEWL8139NyKHCSm8617afMK4Qeclks5GiCSExeiU6QX
         YOaHEWYs3I3Hy3jaUMZzD7qnubmVcnZR/NDqb/+uIGuUaw2hDDyLoyP5qkD1GvKWhAUq
         D1AXeoyOXog3gnba1I1g82Fzhom0FNx8iA6Uw1p3+kcd+hf9bvi1GtqbfUn9njQEvqDm
         FiY1W9rhvE/Z600Vn+e3KWPJ+NcO0SSJof7Hrm/ZFynpXA4M3t1Sc0kVO+U1Gzj+5tOg
         l9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wau0fGW8yZsKjnuoyb0VTR4qVyMVH48h3qQAcCmJxHM=;
        b=SoTsQOCp730YNUjDmgbRd/n2+iFAqc55a7IiAqQrMWV+XP+RjTau3QcecFlxWejIuj
         K1aI7GvWdIYFz3KcIOmqG0SzgT/i7Iqd6S2SJe8cnLE0hE+RDvqgPUi2PC9SETdX0VeO
         lXCONgw1AspgIqwoQgMDOQgPID++qBPpQ/VuMeVZNHgFA8IA5poEaSDDI6Vul/gg7jO7
         BPy6Mv0/xzZMgJe1tLTJAJ0DxBDlzOQrn97hVgpw4rZ8VM2FfuctSSWl9vxjX8gW6H8T
         FnILTbpYba6SvTfZIl33j0yCnyDzG3cvKz+SowaApHAqYiVJXEx0PxWt7rrlOjyWoWG+
         RrRA==
X-Gm-Message-State: AJIora9kDfQtqokG+hgdx7q4rkd3SUMegBLFAUWUyLx6QKPJ1qWiuC+G
        /tGPw9XW8mER7liYyMpJDjhGPg==
X-Google-Smtp-Source: AGRyM1vZvWOxzMMfyRsf49tj6gKTfsbDDI74LUEsue+sAc2CHuDIhWC6vvd1UMApy4oTjuKCS103AA==
X-Received: by 2002:a1c:29c1:0:b0:39d:86c0:3ece with SMTP id p184-20020a1c29c1000000b0039d86c03ecemr9939wmp.138.1655306187683;
        Wed, 15 Jun 2022 08:16:27 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id q16-20020a5d5750000000b0020e63ab5d78sm14781591wrw.26.2022.06.15.08.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 08:16:26 -0700 (PDT)
Date:   Wed, 15 Jun 2022 16:16:02 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Wangzhou <wangzhou1@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        Yang Shen <shenyang39@huawei.com>
Subject: Re: [PATCH] uacce: fix concurrency of fops_open and uacce_remove
Message-ID: <Yqn3spLZHpAkQ9Us@myrica>
References: <20220610123423.27496-1-zhangfei.gao@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610123423.27496-1-zhangfei.gao@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 10, 2022 at 08:34:23PM +0800, Zhangfei Gao wrote:
> The uacce parent's module can be removed when uacce is working,
> which may cause troubles.
> 
> If rmmod/uacce_remove happens just after fops_open: bind_queue,
> the uacce_remove can not remove the bound queue since it is not
> added to the queue list yet, which blocks the uacce_disable_sva.
> 
> Change queues_lock area to make sure the bound queue is added to
> the list thereby can be searched in uacce_remove.
> 
> And uacce->parent->driver is checked immediately in case rmmod is
> just happening.
> 
> Also the parent driver must always stop DMA before calling
> uacce_remove.
> 
> Signed-off-by: Yang Shen <shenyang39@huawei.com>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>  drivers/misc/uacce/uacce.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
> index 281c54003edc..b6219c6bfb48 100644
> --- a/drivers/misc/uacce/uacce.c
> +++ b/drivers/misc/uacce/uacce.c
> @@ -136,9 +136,16 @@ static int uacce_fops_open(struct inode *inode, struct file *filep)
>  	if (!q)
>  		return -ENOMEM;
>  
> +	mutex_lock(&uacce->queues_lock);
> +
> +	if (!uacce->parent->driver) {

I don't think this is useful, because the core clears parent->driver after
having run uacce_remove():

  rmmod hisi_zip		open()
   ...				 uacce_fops_open()
   __device_release_driver()	  ...
    pci_device_remove()
     hisi_zip_remove()
      hisi_qm_uninit()
       uacce_remove()
        ...			  ...
   				  mutex_lock(uacce->queues_lock)
    ...				  if (!uacce->parent->driver)
    device_unbind_cleanup()	  /* driver still valid, proceed */
     dev->driver = NULL

Since uacce_remove() disabled SVA, the following uacce_bind_queue() will
fail anyway. However, if uacce->flags does not have UACCE_DEV_SVA set,
we'll proceed further and call uacce->ops->get_queue(), which does not
exist anymore since the parent module is gone.

I think we need the global uacce_mutex to serialize uacce_remove() and
uacce_fops_open(). uacce_remove() would do everything, including
xa_erase(), while holding that mutex. And uacce_fops_open() would try to
obtain the uacce object from the xarray while holding the mutex, which
fails if the uacce object is being removed.

Thanks,
Jean

> +		ret = -ENODEV;
> +		goto out_with_lock;
> +	}
> +
>  	ret = uacce_bind_queue(uacce, q);
>  	if (ret)
> -		goto out_with_mem;
> +		goto out_with_lock;
>  
>  	q->uacce = uacce;
>  
> @@ -153,7 +160,6 @@ static int uacce_fops_open(struct inode *inode, struct file *filep)
>  	uacce->inode = inode;
>  	q->state = UACCE_Q_INIT;
>  
> -	mutex_lock(&uacce->queues_lock);
>  	list_add(&q->list, &uacce->queues);
>  	mutex_unlock(&uacce->queues_lock);
>  
> @@ -161,7 +167,8 @@ static int uacce_fops_open(struct inode *inode, struct file *filep)
>  
>  out_with_bond:
>  	uacce_unbind_queue(q);
> -out_with_mem:
> +out_with_lock:
> +	mutex_unlock(&uacce->queues_lock);
>  	kfree(q);
>  	return ret;
>  }
> @@ -171,10 +178,10 @@ static int uacce_fops_release(struct inode *inode, struct file *filep)
>  	struct uacce_queue *q = filep->private_data;
>  
>  	mutex_lock(&q->uacce->queues_lock);
> -	list_del(&q->list);
> -	mutex_unlock(&q->uacce->queues_lock);
>  	uacce_put_queue(q);
>  	uacce_unbind_queue(q);
> +	list_del(&q->list);
> +	mutex_unlock(&q->uacce->queues_lock);
>  	kfree(q);
>  
>  	return 0;
> @@ -513,10 +520,10 @@ void uacce_remove(struct uacce_device *uacce)
>  		uacce_put_queue(q);
>  		uacce_unbind_queue(q);
>  	}
> -	mutex_unlock(&uacce->queues_lock);
>  
>  	/* disable sva now since no opened queues */
>  	uacce_disable_sva(uacce);
> +	mutex_unlock(&uacce->queues_lock);
>  
>  	if (uacce->cdev)
>  		cdev_device_del(uacce->cdev, &uacce->dev);
> -- 
> 2.36.1
> 
