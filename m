Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA8E55491E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiFVIO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiFVIOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:14:53 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294F737BD7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:14:52 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id x1-20020a17090abc8100b001ec7f8a51f5so12039513pjr.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=kZTnS3VTllrLoaJqF/w8mR2VHKq3Lk7ph/8GKtgAs1s=;
        b=kwtFYGvf5kooG2LYNIEXgMNdUgRE2PTCmzJmp4fCELFGTNJ3ZyNNa8TjWnqpWfaXVD
         7G9kCTpUy/GYrDCymhpu1QZDUkcd7WmQbLPGaXPr4inPEshWm0TwY/F9Plr8F1Wi+jt2
         eRTtLt6grfJNlBaWbpMas44jwiDdBxXFI+G28HDXly5Tr8il7cx2B4Qe6rwShYKN/TSr
         hMT2nfAAICylX/8y3nSv7y9FINJEM78JgXndoTziueNznyT6SCLfbsqPqGTYOXiEZ1xT
         oOrMwZQpq2c14O60h2LwA7+WnU1zEYQtRHzCeBymb+wsiW0fMOCnrMnslpt4rSjVMF8d
         TDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=kZTnS3VTllrLoaJqF/w8mR2VHKq3Lk7ph/8GKtgAs1s=;
        b=feIw1lAGZZLk+TwzmDQJQ34O86wmNiI9E6vAIG3V6XHCkPNOxZabXXN/aexd9boti3
         a0t7i3memD/dMI7+DuKuRh66g8mNiCTrUa240SVSczIPPBTV4J3BSfy34azwY+ri8vrI
         tsAgckUMUrj1LlH0q3wPAUTYJ22I7nuD8oKMW/qvAX4f24KmrkbeTG4cdtWWA6Fndz/T
         xXq7RnTyhHkusGpnNIFIO/9D80XJ7SIcxIqI/v6Lu69XpDnDnm5KBDhSdLD9QxwsQm8o
         QtXGJiVQqOm265rNln7kne8U2hX0ad2aLEQH9IJa+OpaFO+cVKNk6Z6oro8i8RVm6sE/
         Zz0A==
X-Gm-Message-State: AJIora/pT7g/8PH/VmA53H+Wt6G7x2499+KYvkqOvHx09l8coYyslzE+
        4Ci8JjsLHCoeJiPpHBHnOaNU3619RGeaqttG
X-Google-Smtp-Source: AGRyM1vbNjUQdcM5L8IS2ZvOJX1TwTUio7KEYjbj54a3TQmeH7w7l0VX34LQDWIEY7SIyt+4Vt0fcw==
X-Received: by 2002:a17:903:11c6:b0:167:90e5:59c2 with SMTP id q6-20020a17090311c600b0016790e559c2mr32466748plh.50.1655885691654;
        Wed, 22 Jun 2022 01:14:51 -0700 (PDT)
Received: from [10.166.0.6] ([199.101.192.137])
        by smtp.gmail.com with ESMTPSA id cp1-20020a170902e78100b00168f329b282sm12053860plb.155.2022.06.22.01.14.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 01:14:51 -0700 (PDT)
Subject: Re: [PATCH] uacce: fix concurrency of fops_open and uacce_remove
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
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
 <YrB1D9rv9G4h/BYU@myrica> <YrB30M9yAbUbPFrG@kroah.com>
 <b5011dd2-e8ec-a307-1b43-5aff6cbb6891@linaro.org>
 <YrF2yypHZfiNVRBh@kroah.com>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <6fb8bed5-8d40-fd63-4537-44e9eb6aa053@linaro.org>
Date:   Wed, 22 Jun 2022 16:14:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YrF2yypHZfiNVRBh@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Greg

On 2022/6/21 下午3:44, Greg Kroah-Hartman wrote:
> On Tue, Jun 21, 2022 at 03:37:31PM +0800, Zhangfei Gao wrote:
>>
>> On 2022/6/20 下午9:36, Greg Kroah-Hartman wrote:
>>> On Mon, Jun 20, 2022 at 02:24:31PM +0100, Jean-Philippe Brucker wrote:
>>>> On Fri, Jun 17, 2022 at 02:05:21PM +0800, Zhangfei Gao wrote:
>>>>>> The refcount only ensures that the uacce_device object is not freed as
>>>>>> long as there are open fds. But uacce_remove() can run while there are
>>>>>> open fds, or fds in the process of being opened. And atfer uacce_remove()
>>>>>> runs, the uacce_device object still exists but is mostly unusable. For
>>>>>> example once the module is freed, uacce->ops is not valid anymore. But
>>>>>> currently uacce_fops_open() may dereference the ops in this case:
>>>>>>
>>>>>> 	uacce_fops_open()
>>>>>> 	 if (!uacce->parent->driver)
>>>>>> 	 /* Still valid, keep going */		
>>>>>> 	 ...					rmmod
>>>>>> 						 uacce_remove()
>>>>>> 	 ...					 free_module()
>>>>>> 	 uacce->ops->get_queue() /* BUG */
>>>>> uacce_remove should wait for uacce->queues_lock, until fops_open release the
>>>>> lock.
>>>>> If open happen just after the uacce_remove: unlock, uacce_bind_queue in open
>>>>> should fail.
>>>> Ah yes sorry, I lost sight of what this patch was adding. But we could
>>>> have the same issue with the patch, just in a different order, no?
>>>>
>>>> 	uacce_fops_open()
>>>> 	 uacce = xa_load()
>>>> 	 ...					rmmod
>>> Um, how is rmmod called if the file descriptor is open?
>>>
>>> That should not be possible if the owner of the file descriptor is
>>> properly set.  Please fix that up.
>> Thanks Greg
>>
>> Set cdev owner or use module_get/put can block rmmod once fops_open.
>> -       uacce->cdev->owner = THIS_MODULE;
>> +       uacce->cdev->owner = uacce->parent->driver->owner;
>>
>> However, still not find good method to block removing parent pci device.
>>
>> $ echo 1 > /sys/bus/pci/devices/0000:00:02.0/remove &
>>
>> [   32.563350]  uacce_remove+0x6c/0x148
>> [   32.563353]  hisi_qm_uninit+0x12c/0x178
>> [   32.563356]  hisi_zip_remove+0xa0/0xd0 [hisi_zip]
>> [   32.563361]  pci_device_remove+0x44/0xd8
>> [   32.563364]  device_remove+0x54/0x88
>> [   32.563367]  device_release_driver_internal+0xec/0x1a0
>> [   32.563370]  device_release_driver+0x20/0x30
>> [   32.563372]  pci_stop_bus_device+0x8c/0xe0
>> [   32.563375]  pci_stop_and_remove_bus_device_locked+0x28/0x60
>> [   32.563378]  remove_store+0x9c/0xb0
>> [   32.563379]  dev_attr_store+0x20/0x38
> Removing the parent pci device does not remove the module code, it
> removes the device itself.  Don't confuse code vs. data here.

Do you mean even parent pci device is removed immediately, the code has 
to wait, like dma etc?

Currently parent driver has to ensure all dma stopped then call 
uacce_remove,
ie, after uacce_fops_open succeed, parent driver need wait fops_release, 
then uacce_remove can be called.
For example:
drivers/crypto/hisilicon/zip/zip_main.c:
hisi_qm_wait_task_finish

If remove this wait , there may other issue,
Unable to handle kernel paging request at virtual address ffff80000b700204
pc : hisi_qm_cache_wb.part.0+0x2c/0xa0

So uacce only need serialize uacce_fops_open and uacce_remove.
After uacce_fops_open, we can assume uacce_remove only happen after 
uacce_fops_release?
Then it would be much simpler.

Thanks


