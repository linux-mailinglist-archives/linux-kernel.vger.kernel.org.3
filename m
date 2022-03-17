Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562764DBEF9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 07:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiCQGJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 02:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiCQGJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 02:09:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13E68279734
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 22:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647496063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j/KLDc89By4qA4kGRzPodGb4mNYSnQmxLVR6xOnnWng=;
        b=A8rkwVNcjYdYctNEIK1NROVrML5+9VEjfMuUwSE3++czKk/juF2TSxdWSZUV9vHf5xQkQW
        Pl++Fc50GiIbQ+QuLi+N7nGxlnbFoL3Rd2mf5Hw0ZR2RzYd319O0zOjc7Y2YWaZbnH7aJC
        LCX5XeoiyAVtpAIAxA2YIPashnW4cz4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-MJotG9IFOhavTuUw9o5xgA-1; Thu, 17 Mar 2022 01:47:42 -0400
X-MC-Unique: MJotG9IFOhavTuUw9o5xgA-1
Received: by mail-lj1-f197.google.com with SMTP id o8-20020a2e9448000000b00246133c54deso1719103ljh.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 22:47:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j/KLDc89By4qA4kGRzPodGb4mNYSnQmxLVR6xOnnWng=;
        b=6+AT/rUAOB2NgbUfMu/YJgddkWjzYc/B2EpEPaAVJX8GIJMaI5VL9Lz/rD8BQXGUpl
         FIyD5gBKArTaXPuu4V//unqW807G7B2KZEMpSJlJ3kUkMHAYDoGNLxtma36t+ETbHjEs
         +cNNt2Q/pOAzC7hZMJ3CGFTGnJcRAZyiOMZHzE+EDSJL6dByfz4O+Ok+j64i6EjENWAM
         roWNS8lfJFruFH4bwjFktpTCxR8fYEgh+lE3a1nUHY+DCHl1ffkwb9PDyu8F6JGevDwm
         zVa0ZwFRXrJTN+AF7P3e3HMk6rjvdt8ADxjms9cK6tvknGdyyEsrMttXYHuX+BqBKdiS
         vemA==
X-Gm-Message-State: AOAM5313FDGy2EXAH911AIyq+iAThMRk3FPVEbvkBCC569Ls2cqX2oxb
        fb7hMDlU0+rQigC63hXAXGr/8O+c8rXjM/1zvm8ZzHl67gkHeOUuvshSxsEGzNec4JDF7MqLdml
        vrtVDpz/fQRsbZWAwsuMTYqM=
X-Received: by 2002:a05:6512:3981:b0:448:40e5:cf90 with SMTP id j1-20020a056512398100b0044840e5cf90mr1787569lfu.656.1647496059955;
        Wed, 16 Mar 2022 22:47:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdTK5wvVLygRRXRR1UQYzsP+oY3rMafVhQyvquWomXKKQlBZlVJXihNGbpkr34wSeZNlbJzA==
X-Received: by 2002:a05:6512:3981:b0:448:40e5:cf90 with SMTP id j1-20020a056512398100b0044840e5cf90mr1787558lfu.656.1647496059721;
        Wed, 16 Mar 2022 22:47:39 -0700 (PDT)
Received: from [192.168.1.121] (91-145-109-188.bb.dnainternet.fi. [91.145.109.188])
        by smtp.gmail.com with ESMTPSA id s21-20020a2e9c15000000b0024917f4e911sm343689lji.80.2022.03.16.22.47.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 22:47:39 -0700 (PDT)
Message-ID: <8e836d75-97b0-d301-4d6a-92025e91cad5@redhat.com>
Date:   Thu, 17 Mar 2022 07:47:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] mm/hmm/test: simplify hmm test code: use miscdevice
 instead of char dev
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        apopple@nvidia.com, jhubbard@nvidia.com, rcampbell@nvidia.com,
        vbabka@suse.cz
References: <20220311033050.22724-1-mpenttil@redhat.com>
 <20220314182439.GB64706@ziepe.ca>
 <d9b9c82e-4012-cf0a-d966-d9669a684a27@redhat.com>
 <20220315183922.GC64706@ziepe.ca>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mpenttil@redhat.com>
In-Reply-To: <20220315183922.GC64706@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.3.2022 20.39, Jason Gunthorpe wrote:
> On Tue, Mar 15, 2022 at 05:22:15AM +0200, Mika Penttilä wrote:
>> Hi Jason and thanks for your comments..
>>
>> On 14.3.2022 20.24, Jason Gunthorpe wrote:
>>> On Fri, Mar 11, 2022 at 05:30:50AM +0200, mpenttil@redhat.com wrote:
>>>> From: Mika Penttilä <mpenttil@redhat.com>
>>>>
>>>> HMM selftests use an in-kernel pseudo device to emulate device private
>>>> memory. The pseudo device registers a major device range for two pseudo
>>>> device instances. User space has a script that reads /proc/devices in
>>>> order to find the assigned major number, and sends that to mknod(1),
>>>> once for each node.
>>>>
>>>> This duplicates a fair amount of boilerplate that misc device can do
>>>> instead.
>>>>
>>>> Change this to use misc device, which makes the device node names appear
>>>> for us. This also enables udev-like processing if desired.
>>>
>>> This is borderline the wrong way to use misc devices, they should
>>> never be embedded into other structs like this. It works out here
>>> because they are eventually only placed in a static array, but still
>>> it is a generally bad pattern to see.
>>
>> Could you elaborate on this one? We have many in-tree usages of the same
>> pattern, like:
> 
> The kernel is full of bugs
> 
>> drivers/video/fbdev/pxa3xx-gcu.c
> 
> ie this is broken because it allocates like this:
> 
>          priv = devm_kzalloc(dev, sizeof(struct pxa3xx_gcu_priv), GFP_KERNEL);
>          if (!priv)
>                  return -ENOMEM;
> 
> And free's via devm:
> 
> 
> static int pxa3xx_gcu_remove(struct platform_device *pdev)
> {
>          struct pxa3xx_gcu_priv *priv = platform_get_drvdata(pdev);
> 
>          misc_deregister(&priv->misc_dev);
>          return 0;
> }
> 
> But this will UAF if it races fops open with misc_desregister.


Yes this driver is broken because platform_device and miscdevice have 
unrelated lifetimes.

> 
> Proper use of cdevs with proper struct devices prevent this bug.
> 
>> You mention "placed in a static array", are you seeing a potential lifetime
>> issue or what? Many of the examples above embed miscdevice in a dynamically
>> allocated object also.
>>
>> The file object's private_data holds a pointer to the miscdevice, and
>> fops_get() pins the module. So freeing the objects miscdevice is embedded in
>> at module_exit time should be fine. But, as you said, in this case the
>> miscdevices are statically allocated, so that shouldn't be an issue
>> either.
> 
> Correct, it is OK here because the module refcounts prevent the
> miscdevice memory from being freed, the above cases with dynamic
> allocations do not have that protection and are wrong.
> 
> This is why I don't care for the pattern of putting misc devices
> inside other structs, it suggests this is perhaps generally safe but
> it is not.
> 
>> I think using cdev_add ends up in the same results in device_* api
>> sense.
> 
> Nope, everything works right once you use cdev_device_add on a
> properly registered struct device.
> 
>> miscdevice acting like a mux at a higher abstraction level simplifies the
>> code.
> 
> It does avoid the extra struct device, but at the cost of broken
> memory lifetime

No, misc_register() ends up calling device_create_with_groups() so there 
is struct device involved. cdev_device_add() would make the explicit 
struct_device as a parent of the cdev kobj ensuring that struct_device 
(and maybe structure containing it) is not free before the cdev. But the 
lifetime of the objects here are controlled by the module lifetime. 
Note, there is also cdev involved with miscdevice protecting misc.ko and 
our fops protecting our module unload.

I don't mind using the cdev APIs per se, just would like to do for the 
right reasons. Using cdev apis might be just overkill for many usages, 
and that's where miscdevice is useful. It miscdevice is broken in some 
subtle ways I think it should be better documented, or better yet, fixed.


> 
> Jason
> 


Thanks,
Mika

