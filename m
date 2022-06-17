Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970F654F2B5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 10:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380853AbiFQIUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 04:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380357AbiFQIUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 04:20:40 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4056A68338
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:20:39 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id g8so3290309plt.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=OdNhNfoqdC0FVLit2cDZSs2L6y6qr7vA7s4OIwUXg9k=;
        b=PS7hc574OxdHYQVtA0Z6It9mhv0nnSGL7KhN1FWmFGS4vEhL+Aoql8zsGAu4Vm8gtU
         K67X59H+flFBydVsHR5Myn+4g/p4BgEAE5I3ISsM1Gp0xV8UEsvSeMd0lVT1od526AFX
         AduJhFxXFdSeSYUIkGLiw2HUKABu5y/JUmc0HS8PkC9CsvECgz5h6DR31f4r+n9MC28I
         Ogoh0YMfwvuh4Nbs1S8uaAaaNObhgA8GHoG/eWDxAVbGPdSUIarUqBVacCAwOkA5VIrm
         qgeDRm5ew8uCK0FR+4Vv3xkVLrSy4vGaZh3OI+D+YYfxRIVEIdb0YlUALc7eOJD5ApX+
         4bew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OdNhNfoqdC0FVLit2cDZSs2L6y6qr7vA7s4OIwUXg9k=;
        b=NQmYfUhA9Euq5FJtQLVjaS7LguuNkCe7IQwicjFtFwkA4pwcF6kRuyAU3cv5EcWJkw
         3XvH4DdBeeUU24l67jsIlr3BPA+Zm+e68XF7Obnfwp8Yawgq9/jKgoVkz0dIuNxFsFck
         sUPHbbyGd9dJYfzd1jhjQBCGAgQiDHWxKV2YVIzv2Ktue0jhuRU0Bj+OPcHwAUSB6t2N
         kH4Buu4PtBqRZXwC+hSQ8/sbViuk07l2S2cVWHtD+Lh4WK43S2KhshiV685wFzsV7W6t
         mxn12emrc3Hdy7uSbCC8sBLEC/rnQhfjCx9E8IVhgu7N3asvh7nBPz7ioBHc1Vsd4z6P
         0UEA==
X-Gm-Message-State: AJIora9z3I0AnK9L/01ARtiyN72RPa2UiakB8JotU0c2gslYSGHWPyS3
        BJyAcZPsIb6ugX2sU69fmQyp3w==
X-Google-Smtp-Source: AGRyM1uAbkIkSICeQYdBSNboTTqudBkUwBrYaUDh/Hk0+dlw2DMRWzxjJ9PGhUg9G4uOAEBePL0oBA==
X-Received: by 2002:a17:902:b598:b0:168:b0b2:f05a with SMTP id a24-20020a170902b59800b00168b0b2f05amr8377071pls.0.1655454038736;
        Fri, 17 Jun 2022 01:20:38 -0700 (PDT)
Received: from [10.83.0.6] ([199.101.192.187])
        by smtp.gmail.com with ESMTPSA id x19-20020a637c13000000b00408c56d3379sm3121430pgc.74.2022.06.17.01.20.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 01:20:38 -0700 (PDT)
Subject: Re: [PATCH] uacce: fix concurrency of fops_open and uacce_remove
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Wangzhou <wangzhou1@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        Yang Shen <shenyang39@huawei.com>
References: <20220610123423.27496-1-zhangfei.gao@linaro.org>
 <Yqn3spLZHpAkQ9Us@myrica> <fdc8d8b0-4e04-78f5-1e8a-4cf44c89a37f@linaro.org>
 <YqrmdKNrYTCiS/MC@myrica> <d90e8ea5-2f18-2eda-b4b2-711083aa7ecd@linaro.org>
Message-ID: <53b9acef-ad32-d0aa-fa1b-a7cb77a0d088@linaro.org>
Date:   Fri, 17 Jun 2022 16:20:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d90e8ea5-2f18-2eda-b4b2-711083aa7ecd@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/17 下午2:05, Zhangfei Gao wrote:
>
>
> On 2022/6/16 下午4:14, Jean-Philippe Brucker wrote:
>> On Thu, Jun 16, 2022 at 12:10:18PM +0800, Zhangfei Gao wrote:
>>>>> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
>>>>> index 281c54003edc..b6219c6bfb48 100644
>>>>> --- a/drivers/misc/uacce/uacce.c
>>>>> +++ b/drivers/misc/uacce/uacce.c
>>>>> @@ -136,9 +136,16 @@ static int uacce_fops_open(struct inode 
>>>>> *inode, struct file *filep)
>>>>>        if (!q)
>>>>>            return -ENOMEM;
>>>>> +    mutex_lock(&uacce->queues_lock);
>>>>> +
>>>>> +    if (!uacce->parent->driver) {
>>>> I don't think this is useful, because the core clears 
>>>> parent->driver after
>>>> having run uacce_remove():
>>>>
>>>>     rmmod hisi_zip        open()
>>>>      ...                 uacce_fops_open()
>>>>      __device_release_driver()      ...
>>>>       pci_device_remove()
>>>>        hisi_zip_remove()
>>>>         hisi_qm_uninit()
>>>>          uacce_remove()
>>>>           ...              ...
>>>>                        mutex_lock(uacce->queues_lock)
>>>>       ...                  if (!uacce->parent->driver)
>>>>       device_unbind_cleanup()      /* driver still valid, proceed */
>>>>        dev->driver = NULL
>>> The check  if (!uacce->parent->driver) is required, otherwise NULL 
>>> pointer
>>> may happen.
>> I agree we need something, what I mean is that this check is not
>> sufficient.
>>
>>> iommu_sva_bind_device
>>> const struct iommu_ops *ops = dev_iommu_ops(dev);  ->
>>> dev->iommu->iommu_dev->ops
>>>
>>> rmmod has no issue, but remove parent pci device has the issue.
>> Ah right, relying on the return value of bind() wouldn't be enough 
>> even if
>> we mandated SVA.
>>
>> [...]
>>>> I think we need the global uacce_mutex to serialize uacce_remove() and
>>>> uacce_fops_open(). uacce_remove() would do everything, including
>>>> xa_erase(), while holding that mutex. And uacce_fops_open() would 
>>>> try to
>>>> obtain the uacce object from the xarray while holding the mutex, which
>>>> fails if the uacce object is being removed.
>>> Since fops_open get char device refcount, uacce_release will not happen
>>> until open returns.
>> The refcount only ensures that the uacce_device object is not freed as
>> long as there are open fds. But uacce_remove() can run while there are
>> open fds, or fds in the process of being opened. And atfer 
>> uacce_remove()
>> runs, the uacce_device object still exists but is mostly unusable. For
>> example once the module is freed, uacce->ops is not valid anymore. But
>> currently uacce_fops_open() may dereference the ops in this case:
>>
>>     uacce_fops_open()
>>      if (!uacce->parent->driver)
>>      /* Still valid, keep going */
>>      ...                    rmmod
>>                          uacce_remove()
>>      ...                     free_module()
>>      uacce->ops->get_queue() /* BUG */
>
> uacce_remove should wait for uacce->queues_lock, until fops_open 
> release the lock.
> If open happen just after the uacce_remove: unlock, uacce_bind_queue 
> in open should fail.
>
>> Accessing uacce->ops after free_module() is a use-after-free. We need 
>> all
> you men parent release the resources.
>> the fops to synchronize with uacce_remove() to ensure they don't use any
>> resource of the parent after it's been freed.
> After fops_open, currently we are counting on parent driver stop all 
> dma first, then call uacce_remove, which is assumption.
> Like drivers/crypto/hisilicon/zip/zip_main.c: 
> hisi_qm_wait_task_finish, which will wait uacce_release.
> If comments this , there may other issue,
> Unable to handle kernel paging request at virtual address 
> ffff80000b700204
> pc : hisi_qm_cache_wb.part.0+0x2c/0xa0
>
>> I see uacce_fops_poll() may have the same problem, and should be inside
>> uacce_mutex.
> Do we need consider this, uacce_remove can happen anytime but not 
> waiting dma stop?
>
> Not sure uacce_mutex can do this.
> Currently the sequence is
> mutex_lock(&uacce->queues_lock);
> mutex_lock(&uacce_mutex);
>
> Or we set all the callbacks of uacce_ops to NULL?
How about in uacce_remove
mutex_lock(&uacce_mutex);
uacce->ops = NULL;
mutex_unlock(&uacce_mutex);

And check uacce->ops  first when using.

Or set all ops of uacce->ops to NULL.

> Module_get/put only works for module, but not for removing device.
>
> Thanks
>
>>
>> Thanks,
>> Jean
>

