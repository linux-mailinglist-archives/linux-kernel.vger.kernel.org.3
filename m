Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714EA46FC5B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 09:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238259AbhLJIOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 03:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhLJIOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 03:14:31 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BCCC061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 00:10:56 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id x10so10029605edd.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 00:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=forissier-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ti28hlD6/mM6Vg90/8VM+TSPaSUQtoFUjWONgp5rZnc=;
        b=vX5sRYM7r7+BE/j6lVfnHA//8R9hgVB5W22tp+8YBS7yUjU0+wS7bBeNIuNvOalasA
         geVcrS+lQ1B2EuwN0BTEaJs76rOx5jMo0gDIu8Hk035p1StnqoALqdeAPHoliSjGslJm
         cRuud7BCecdYL3tLLpmXiRI0XHpiZZJi9xwP12M2gaJDy77xrxEa4KoaU6lC8k6AlRvD
         pHhg+Hfd8ye+BTNXqTHoSP1CP7sOvRJSj25EHrZoe+kZAd6WmFRaRurWbfyJ7bVyBtMk
         aP4tqoLDeyDWta1lSBeGSPqwGpQDCvyeT6sDZGSHvrfc0LXwR2do6dKGL3Ttttlz47KP
         d/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ti28hlD6/mM6Vg90/8VM+TSPaSUQtoFUjWONgp5rZnc=;
        b=IvmWgpnMhc8wbbjvXXDyNj5t4YYx6XZFsqmEnhfdIG8bPfXqXJ3SmFSGwVB31YfCCc
         y8G8wDh3h5Sa+eeChtxBzM7Wm0RDVUdPrgdRgrMOIobvG0WLn26yNfI6YpAZfHyWCksE
         gEC7tD8PKnJbSwmV4chAN6/pEcxUXmpei7FSutW/AkWf46KLu9EXZL5AK1G93nXpWkOz
         j5opELb4w5YDfqYu1BYbeny96Hm3qQy1qJ1v6Anll8vNVEwsueSNiGitQxzloiCd1FGy
         68Eb6BmYDnm7sa1uEpnOLh5OTMN1DIs7DVbDO4KnBq+p+T9w/AghqPByQ7fh5b2w3zuE
         R3mw==
X-Gm-Message-State: AOAM5312Nah1iZvgsuczp0UEA1a8dxJ8HJ+f1FwP6bjwWtPGahU3QX7X
        e/qoX+dC9NlzmJ1Xjy4V6vAGIw==
X-Google-Smtp-Source: ABdhPJyPAal9NH4/u6WTiuOKujCs9pvI1Ylpl75lH5ouCB76Ntm2H9ZX2S/rOwXTIsRzl10mpEa33Q==
X-Received: by 2002:a17:906:1599:: with SMTP id k25mr21937049ejd.298.1639123854646;
        Fri, 10 Dec 2021 00:10:54 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:b5f:7231:307a:3eaa? ([2a01:e0a:3cb:7bb0:b5f:7231:307a:3eaa])
        by smtp.gmail.com with ESMTPSA id qa7sm1005997ejc.64.2021.12.10.00.10.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 00:10:54 -0800 (PST)
Message-ID: <ede44051-41db-60b4-d5a3-97a789dd52bc@forissier.org>
Date:   Fri, 10 Dec 2021 09:10:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] optee: Suppress false positive kmemleak report in
 optee_handle_rpc()
Content-Language: en-US
To:     Sumit Garg <sumit.garg@linaro.org>,
        "Wang, Xiaolei" <xiaolei.wang@windriver.com>
Cc:     "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>
References: <20211206120533.602062-1-xiaolei.wang@windriver.com>
 <CAFA6WYN+0751=feb-O9Drmm5V_Gz-1qsgiHmLsA88=49MoK_dg@mail.gmail.com>
 <PH0PR11MB507734019F54C2BB24D1456F95719@PH0PR11MB5077.namprd11.prod.outlook.com>
 <CAFA6WYMOHUEve8cbZdwzsijer3fRsy=50q67ndsC6U2JD6gK5Q@mail.gmail.com>
From:   Jerome Forissier <jerome@forissier.org>
In-Reply-To: <CAFA6WYMOHUEve8cbZdwzsijer3fRsy=50q67ndsC6U2JD6gK5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC Jens, Etienne

On 12/10/21 06:00, Sumit Garg wrote:
> On Fri, 10 Dec 2021 at 09:42, Wang, Xiaolei <Xiaolei.Wang@windriver.com> wrote:
>>
>> -----Original Message-----
>> From: Sumit Garg <sumit.garg@linaro.org>
>> Sent: Thursday, December 9, 2021 7:41 PM
>> To: Wang, Xiaolei <Xiaolei.Wang@windriver.com>
>> Cc: jens.wiklander@linaro.org; op-tee@lists.trustedfirmware.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] optee: Suppress false positive kmemleak report in optee_handle_rpc()
>>
>> [Please note: This e-mail is from an EXTERNAL e-mail address]
>>
>> On Mon, 6 Dec 2021 at 17:35, Xiaolei Wang <xiaolei.wang@windriver.com> wrote:
>>>
>>> We observed the following kmemleak report:
>>> unreferenced object 0xffff000007904500 (size 128):
>>>   comm "swapper/0", pid 1, jiffies 4294892671 (age 44.036s)
>>>   hex dump (first 32 bytes):
>>>     00 47 90 07 00 00 ff ff 60 00 c0 ff 00 00 00 00  .G......`.......
>>>     60 00 80 13 00 80 ff ff a0 00 00 00 00 00 00 00  `...............
>>>   backtrace:
>>>     [<000000004c12b1c7>] kmem_cache_alloc+0x1ac/0x2f4
>>>     [<000000005d23eb4f>] tee_shm_alloc+0x78/0x230
>>>     [<00000000794dd22c>] optee_handle_rpc+0x60/0x6f0
>>>     [<00000000d9f7c52d>] optee_do_call_with_arg+0x17c/0x1dc
>>>     [<00000000c35884da>] optee_open_session+0x128/0x1ec
>>>     [<000000001748f2ff>] tee_client_open_session+0x28/0x40
>>>     [<00000000aecb5389>] optee_enumerate_devices+0x84/0x2a0
>>>     [<000000003df18bf1>] optee_probe+0x674/0x6cc
>>>     [<000000003a4a534a>] platform_drv_probe+0x54/0xb0
>>>     [<000000000c51ce7d>] really_probe+0xe4/0x4d0
>>>     [<000000002f04c865>] driver_probe_device+0x58/0xc0
>>>     [<00000000b485397d>] device_driver_attach+0xc0/0xd0
>>>     [<00000000c835f0df>] __driver_attach+0x84/0x124
>>>     [<000000008e5a429c>] bus_for_each_dev+0x70/0xc0
>>>     [<000000001735e8a8>] driver_attach+0x24/0x30
>>>     [<000000006d94b04f>] bus_add_driver+0x104/0x1ec
>>>
>>> This is not a memory leak because we pass the share memory pointer to
>>> secure world and would get it from secure world before releasing it.
>>
>>> How about if it's actually a memory leak caused by the secure world?
>>> An example being secure world just allocates kernel memory via OPTEE_SMC_RPC_FUNC_ALLOC and doesn't free it via OPTEE_SMC_RPC_FUNC_FREE.
>>
>>> IMO, we need to cross-check optee-os if it's responsible for leaking kernel memory.
>>
>> Hi sumit,
>>
>> You mean we need to check whether there is a real memleak,
>> If being secure world just allocate kernel memory via OPTEE_SMC_PRC_FUNC_ALLOC and until the end, there is no free
>> It via OPTEE_SMC_PRC_FUNC_FREE, then we should judge it as a memory leak, wo need to judge whether it is caused by secure os?
> 
> Yes. AFAICT, optee-os should allocate shared memory to communicate
> with tee-supplicant. So once the communication is done, the underlying
> shared memory should be freed. I can't think of any scenario where
> optee-os should keep hold-off shared memory indefinitely.

I believe it can happen when OP-TEE's CFG_PREALLOC_RPC_CACHE is y. See
the config file [1] and the commit which introduced this config [2].

[1] https://github.com/OP-TEE/optee_os/blob/3.15.0/mk/config.mk#L709
[2] https://github.com/OP-TEE/optee_os/commit/8887663248ad

-- 
Jerome
