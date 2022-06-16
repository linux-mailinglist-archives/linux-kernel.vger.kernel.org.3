Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617FA54D922
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 06:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358631AbiFPEKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 00:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358622AbiFPEKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 00:10:25 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676F057B01
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 21:10:24 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 184so145554pga.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 21:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=WzJNadh1hSnmmL0dW8LI/MHOGJubcN11puGnqaQm174=;
        b=YgP+guyirvc2wR0eokmvk7hxnf7zaDI1NQnUMfVym3nkeqVioUdT0MkHkHtCM5Nmmv
         K7rzxJjZNn5BcBT5Tw7y29hcawM66158z5lOYoXPgw0SD8qDEIHodoP6/0lgOwQ97/bk
         BjZbwFE29Ljfquda8NqLiQrKRG5h6Lxre5G6MEgEleq2gE7gojxULZ4vbbgTmcaFE1AK
         gHgskvBnpglx5aL22vxohlAsbkYwBJc70n3ch08ugpKpNO0ka/56L6fndfl9z//45aS8
         NAdI9LQDmWXh61yKB4P3eCj4x0gqnIQ5JVG3gk+2zN2Vao457kr90g0Bp4C54dLTpTCG
         Etbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WzJNadh1hSnmmL0dW8LI/MHOGJubcN11puGnqaQm174=;
        b=gqV72IeAXRv68D/FB/zm6HUBT846erP7GhO5JlQsZT6JhmtFNW+r5rACNx5xWQcUAN
         Hne5CAJ3TJN00rgBc4QRkjPldRQlbuifVS6bxlFTjsXLmkq/4l0slgUfLQmq77SqjLs/
         uu7Dqo1hm+01fM2ZGMYzJNQuGZNDMCTXiOJ6X0C5IXqlcEOVosxPv8dYnsqE9Pkb43OQ
         dppsNjsuJhW8S7YfZiIW31fu+1wWTlHImWF01fyqJ3/ReWUYcVkzB2sxr5zECs7tvMhJ
         QTJ2KE2p7qMKXoj4TVFXfQSxlR+DdC4x090cLT1nAVVCq2n6Y7McOPabbK6gIt304Tyw
         orVw==
X-Gm-Message-State: AJIora86B78HNJSLFAyq6+xeufBHb+1mNVSqU1u1vsoO617Z9yfsA+hK
        Sw9SxFIGBGy9YQ+fuIwtOI+BIsFQEdtS9w==
X-Google-Smtp-Source: AGRyM1uef04u0KeO4Z0AwsOzUgxYO8oZy0vFCco9id7APLvqMzKEpKvUQfrb3Y3XHRK4iAcfsoThZw==
X-Received: by 2002:aa7:9e9c:0:b0:51b:e1b8:271c with SMTP id p28-20020aa79e9c000000b0051be1b8271cmr2885255pfq.73.1655352623853;
        Wed, 15 Jun 2022 21:10:23 -0700 (PDT)
Received: from [10.31.0.6] ([199.101.192.15])
        by smtp.gmail.com with ESMTPSA id n2-20020a63b442000000b003c265b7d4f6sm449755pgu.44.2022.06.15.21.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 21:10:23 -0700 (PDT)
Subject: Re: [PATCH] uacce: fix concurrency of fops_open and uacce_remove
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
 <Yqn3spLZHpAkQ9Us@myrica>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <fdc8d8b0-4e04-78f5-1e8a-4cf44c89a37f@linaro.org>
Date:   Thu, 16 Jun 2022 12:10:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <Yqn3spLZHpAkQ9Us@myrica>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jean

On 2022/6/15 下午11:16, Jean-Philippe Brucker wrote:
> Hi,
>
> On Fri, Jun 10, 2022 at 08:34:23PM +0800, Zhangfei Gao wrote:
>> The uacce parent's module can be removed when uacce is working,
>> which may cause troubles.
>>
>> If rmmod/uacce_remove happens just after fops_open: bind_queue,
>> the uacce_remove can not remove the bound queue since it is not
>> added to the queue list yet, which blocks the uacce_disable_sva.
>>
>> Change queues_lock area to make sure the bound queue is added to
>> the list thereby can be searched in uacce_remove.
>>
>> And uacce->parent->driver is checked immediately in case rmmod is
>> just happening.
>>
>> Also the parent driver must always stop DMA before calling
>> uacce_remove.
>>
>> Signed-off-by: Yang Shen <shenyang39@huawei.com>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> ---
>>   drivers/misc/uacce/uacce.c | 19 +++++++++++++------
>>   1 file changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
>> index 281c54003edc..b6219c6bfb48 100644
>> --- a/drivers/misc/uacce/uacce.c
>> +++ b/drivers/misc/uacce/uacce.c
>> @@ -136,9 +136,16 @@ static int uacce_fops_open(struct inode *inode, struct file *filep)
>>   	if (!q)
>>   		return -ENOMEM;
>>   
>> +	mutex_lock(&uacce->queues_lock);
>> +
>> +	if (!uacce->parent->driver) {
> I don't think this is useful, because the core clears parent->driver after
> having run uacce_remove():
>
>    rmmod hisi_zip		open()
>     ...				 uacce_fops_open()
>     __device_release_driver()	  ...
>      pci_device_remove()
>       hisi_zip_remove()
>        hisi_qm_uninit()
>         uacce_remove()
>          ...			  ...
>     				  mutex_lock(uacce->queues_lock)
>      ...				  if (!uacce->parent->driver)
>      device_unbind_cleanup()	  /* driver still valid, proceed */
>       dev->driver = NULL

The check  if (!uacce->parent->driver) is required, otherwise NULL 
pointer may happen.
iommu_sva_bind_device
const struct iommu_ops *ops = dev_iommu_ops(dev);  -> 
dev->iommu->iommu_dev->ops

rmmod has no issue, but remove parent pci device has the issue.

Test:
sleep in fops_open before mutex.

estuary:/mnt$ ./work/a.out &
//sleep in fops_open

echo 1 > /sys/bus/pci/devices/0000:00:02.0/remove &
estuary:/mnt$ [   22.594348] uacce_remove!
[   22.594663] pci 0000:00:02.0: Removing from iommu group 2
[   22.595073] iommu_release_device dev->iommu=0
[   22.595076] CPU: 2 PID: 229 Comm: ash Not tainted 
5.19.0-rc1-15071-gcbcf098c5257-dirty #633
[   22.595079] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 
02/06/2015
[   22.595080] Call trace:
[   22.595080]  dump_backtrace+0xe4/0xf0
[   22.595085]  show_stack+0x20/0x70
[   22.595086]  dump_stack_lvl+0x8c/0xb8
[   22.595089]  dump_stack+0x18/0x34
[   22.595091]  iommu_release_device+0x90/0x98
[   22.595095]  iommu_bus_notifier+0x58/0x68
[   22.595097]  blocking_notifier_call_chain+0x74/0xa8
[   22.595100]  device_del+0x268/0x3b0
[   22.595102]  pci_remove_bus_device+0x84/0x110
[   22.595106]  pci_stop_and_remove_bus_device_locked+0x30/0x60
...

estuary:/mnt$ [   31.466360] uacce: sleep end!
[   31.466362] uacce->parent->driver=0
[   31.466364] uacce->parent->iommu=0
[   31.466365] uacce_bind_queue!
[   31.466366] uacce_bind_queue call iommu_sva_bind_device!
[   31.466367] uacce->parent=d120d0
[   31.466371] Unable to handle kernel NULL pointer dereference at 
virtual address 0000000000000038
[   31.472870] Mem abort info:
[   31.473450]   ESR = 0x0000000096000004
[   31.474223]   EC = 0x25: DABT (current EL), IL = 32 bits
[   31.475390]   SET = 0, FnV = 0
[   31.476031]   EA = 0, S1PTW = 0
[   31.476680]   FSC = 0x04: level 0 translation fault
[   31.477687] Data abort info:
[   31.478294]   ISV = 0, ISS = 0x00000004
[   31.479152]   CM = 0, WnR = 0
[   31.479785] user pgtable: 4k pages, 48-bit VAs, pgdp=00000000714d8000
[   31.481144] [0000000000000038] pgd=0000000000000000, p4d=0000000000000000
[   31.482622] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[   31.483784] Modules linked in: hisi_zip
[   31.484590] CPU: 2 PID: 228 Comm: a.out Not tainted 
5.19.0-rc1-15071-gcbcf098c5257-dirty #633
[   31.486374] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 
02/06/2015
[   31.487862] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)
[   31.489390] pc : iommu_sva_bind_device+0x44/0xf4
[   31.490404] lr : uacce_fops_open+0x128/0x234

>
> Since uacce_remove() disabled SVA, the following uacce_bind_queue() will
> fail anyway. However, if uacce->flags does not have UACCE_DEV_SVA set,
> we'll proceed further and call uacce->ops->get_queue(), which does not
> exist anymore since the parent module is gone.
>
> I think we need the global uacce_mutex to serialize uacce_remove() and
> uacce_fops_open(). uacce_remove() would do everything, including
> xa_erase(), while holding that mutex. And uacce_fops_open() would try to
> obtain the uacce object from the xarray while holding the mutex, which
> fails if the uacce object is being removed.

Since fops_open get char device refcount, uacce_release will not happen 
until open returns.
So either uacce = xa_load(&uacce_xa, iminor(inode)) is got, 
uacce_release release uacce after fops_release.
Or uacce is not got and return -ENODEV．

open:
         uacce = xa_load(&uacce_xa, iminor(inode));
         if (!uacce)
                 return -ENODEV;

uacce->dev.release = uacce_release;
uacce_release: kfree(uacce);

Thanks
