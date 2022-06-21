Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36787552C32
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347322AbiFUHjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346958AbiFUHiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:38:17 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D945FAF
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:38:15 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id l6so3621077plg.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=nk+fdQE93FqPegDOLztKBITezax/oNzcyKzefYaORp8=;
        b=fg3yA65YsHeVetLshPkg44ZoS0+r4kYz2gK82/9ZhWuhbuhVCG8b1IdASjgMLW9F8P
         wo5ttxvpAXD/hkkxsxLIM3+CBiBChOIsQ3RNAzLUsbHjSWRRQ1JoPJeddxJmPypYwIDm
         uLgUOck8sGg5x8fOxEN70TWDH9gWl9Wbnv+6R/mh1fTzZBKh+XeoxxFhRJgG5PZUK9DW
         nqfEtw30mbezb6SjSdTry30MQ96gE3J2Hddk1ntmpTBAhiKYHRFYBolJEKTxUXGTeuu/
         YfE/BdyNZZwSOCsxvcz1u38p0OwiwbgnrM79Hvr5UZyx3obezETo8+t91kh276rwrnYH
         KUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nk+fdQE93FqPegDOLztKBITezax/oNzcyKzefYaORp8=;
        b=YpnD5eqjl1hEf/IYEj9HiW0qBTnH/wwZ7yqR09bxtGCgQXtdHEaw4+8rngrWAgaA0r
         iYRqwv7k2MML4/3eK4v+m0qavwUFVnRIGkmcadRMVdGXgPEHC1xTfiStWYe2/6o4zgcy
         KzSUprBhHfspIj89BwF3aZGoYncc85r25ASxC4JJH5sGB8M2FX3F9/FHQaIeYZF4jwLa
         3muG1KyFEJDG4MluGmeJy66Vgi3Up/L0sxjKShICDI0jWp0Imqg6XT1oy03jJHiS9y8u
         r5hAuhhJpa8tzDUiBW1b82Cuw26wmk3gHWyzYsxAueUQ7m0RiVt4mUf6MzBEFGYrwtbt
         KrFQ==
X-Gm-Message-State: AJIora+v/vzTr5m8ucOnvtDaP1PlgDyJQ/HILEiwmNHxWkrZsiaKnEu9
        aB2mJXyUqmc8d8PCcKJ0b1GSsQ==
X-Google-Smtp-Source: AGRyM1tzcOchkt7DypAfKrCwXNSUY5s5v3wBe6Pw1F/TJ4XsfE6hlLD+8GcyGAve96CoC88+Qgh+mw==
X-Received: by 2002:a17:902:728d:b0:168:d0cf:2246 with SMTP id d13-20020a170902728d00b00168d0cf2246mr27711694pll.74.1655797095238;
        Tue, 21 Jun 2022 00:38:15 -0700 (PDT)
Received: from [10.97.0.6] ([199.101.192.33])
        by smtp.gmail.com with ESMTPSA id z4-20020a17090a66c400b001e345c579d5sm9463008pjl.26.2022.06.21.00.38.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 00:38:14 -0700 (PDT)
Subject: Re: [PATCH] uacce: fix concurrency of fops_open and uacce_remove
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
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
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <b5011dd2-e8ec-a307-1b43-5aff6cbb6891@linaro.org>
Date:   Tue, 21 Jun 2022 15:37:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YrB30M9yAbUbPFrG@kroah.com>
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



On 2022/6/20 下午9:36, Greg Kroah-Hartman wrote:
> On Mon, Jun 20, 2022 at 02:24:31PM +0100, Jean-Philippe Brucker wrote:
>> On Fri, Jun 17, 2022 at 02:05:21PM +0800, Zhangfei Gao wrote:
>>>> The refcount only ensures that the uacce_device object is not freed as
>>>> long as there are open fds. But uacce_remove() can run while there are
>>>> open fds, or fds in the process of being opened. And atfer uacce_remove()
>>>> runs, the uacce_device object still exists but is mostly unusable. For
>>>> example once the module is freed, uacce->ops is not valid anymore. But
>>>> currently uacce_fops_open() may dereference the ops in this case:
>>>>
>>>> 	uacce_fops_open()
>>>> 	 if (!uacce->parent->driver)
>>>> 	 /* Still valid, keep going */		
>>>> 	 ...					rmmod
>>>> 						 uacce_remove()
>>>> 	 ...					 free_module()
>>>> 	 uacce->ops->get_queue() /* BUG */
>>> uacce_remove should wait for uacce->queues_lock, until fops_open release the
>>> lock.
>>> If open happen just after the uacce_remove: unlock, uacce_bind_queue in open
>>> should fail.
>> Ah yes sorry, I lost sight of what this patch was adding. But we could
>> have the same issue with the patch, just in a different order, no?
>>
>> 	uacce_fops_open()
>> 	 uacce = xa_load()
>> 	 ...					rmmod
> Um, how is rmmod called if the file descriptor is open?
>
> That should not be possible if the owner of the file descriptor is
> properly set.  Please fix that up.
Thanks Greg

Set cdev owner or use module_get/put can block rmmod once fops_open.
-       uacce->cdev->owner = THIS_MODULE;
+       uacce->cdev->owner = uacce->parent->driver->owner;

However, still not find good method to block removing parent pci device.

$ echo 1 > /sys/bus/pci/devices/0000:00:02.0/remove &

[   32.563350]  uacce_remove+0x6c/0x148
[   32.563353]  hisi_qm_uninit+0x12c/0x178
[   32.563356]  hisi_zip_remove+0xa0/0xd0 [hisi_zip]
[   32.563361]  pci_device_remove+0x44/0xd8
[   32.563364]  device_remove+0x54/0x88
[   32.563367]  device_release_driver_internal+0xec/0x1a0
[   32.563370]  device_release_driver+0x20/0x30
[   32.563372]  pci_stop_bus_device+0x8c/0xe0
[   32.563375]  pci_stop_and_remove_bus_device_locked+0x28/0x60
[   32.563378]  remove_store+0x9c/0xb0
[   32.563379]  dev_attr_store+0x20/0x38

mutex_lock(&dev->device_lock) can be used, which used in 
device_release_driver_internal.
Or use internal mutex.

Thanks
