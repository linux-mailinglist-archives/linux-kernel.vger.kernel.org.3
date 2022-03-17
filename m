Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE624DBFC9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 07:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiCQHAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 03:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiCQHAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 03:00:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1717D7654
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 23:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647500337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KnRSdO66HNXmMRFDGV7E0Y6pab5MMr0xJk4rgppyXM8=;
        b=Qa2cMaOOkFBHI3Tokft1Ke9r8I2nVIruXNrTn/yPhKEVkg6C4jRmsNHTF8X5J/lEdP3VWo
        3KIwif4FmyR2xdk52sfP1h69CX2dHF4xt7xf0euQHuPHhFYGxgcebfvpV+SgfsKgU+bseu
        GXetLW94tHKM0yoqNxmI+QSlxd1vtOE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-cYVxceu4MUKc8LQCDbl5HA-1; Thu, 17 Mar 2022 02:58:55 -0400
X-MC-Unique: cYVxceu4MUKc8LQCDbl5HA-1
Received: by mail-lf1-f72.google.com with SMTP id w13-20020ac25d4d000000b004488cf80eb1so1470432lfd.23
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 23:58:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=KnRSdO66HNXmMRFDGV7E0Y6pab5MMr0xJk4rgppyXM8=;
        b=M7WI8RQn2tS7PzqIhKXIBj47yz49Q1bQr4+tBNApUs85zigRVqIvsS5UmGb9ZSia3h
         mjcmVSz/3fNsJK38LNOEdXIYHJz0E8BSaSRO8BGXeHyk7PnXWCF0iBIcKf7AatAEcNMm
         BlMqBEaJ0n2L+JycgzwZZXJQM8B/wKfBjsbLvums8tmXNJ7TrCjbg6seW9uYlj8VWXfs
         mZrXG1/gq4X6//fW7skocGGZFcHMupuOgsm7XCc0k2DDs/UOSWhX9A542q7J+PLn3n2n
         zGUYW15rLez6/KVYOpBqVgMqiIlRTklEYtw0NRnlq5UmzgL0wFPhEoEWszc0fsfHmFdl
         e/yA==
X-Gm-Message-State: AOAM533MQwnSMy2rkaNgQUA/HCRF2RTFBitovawPUzd8sHhTLUAImrbT
        nDbEcRR+MI40viPqtB/8NGjBzcgxPeQ+k5fh8sBWhSkFOdTF42Dl6yBPrkzGF9tU7h39mrExsBP
        6/y8hiOI7vEMBy7gcCHNo1/k=
X-Received: by 2002:a2e:8882:0:b0:244:8a8a:212 with SMTP id k2-20020a2e8882000000b002448a8a0212mr2040042lji.220.1647500333996;
        Wed, 16 Mar 2022 23:58:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylH+VggbD2HXSlPGduupiGrABceaM4x7qKSwqLCwC6jd4uf2rfcxnvHC/yzc59RSDz8FSrow==
X-Received: by 2002:a2e:8882:0:b0:244:8a8a:212 with SMTP id k2-20020a2e8882000000b002448a8a0212mr2040032lji.220.1647500333715;
        Wed, 16 Mar 2022 23:58:53 -0700 (PDT)
Received: from [192.168.1.121] (91-145-109-188.bb.dnainternet.fi. [91.145.109.188])
        by smtp.gmail.com with ESMTPSA id u13-20020a19600d000000b00448ba707284sm310144lfb.163.2022.03.16.23.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 23:58:53 -0700 (PDT)
Message-ID: <0f53c5ff-1711-861d-9a12-0634d4ab9fca@redhat.com>
Date:   Thu, 17 Mar 2022 08:58:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] mm/hmm/test: simplify hmm test code: use miscdevice
 instead of char dev
Content-Language: en-US
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mpenttil@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        apopple@nvidia.com, jhubbard@nvidia.com, rcampbell@nvidia.com,
        vbabka@suse.cz
References: <20220311033050.22724-1-mpenttil@redhat.com>
 <20220314182439.GB64706@ziepe.ca>
 <d9b9c82e-4012-cf0a-d966-d9669a684a27@redhat.com>
 <20220315183922.GC64706@ziepe.ca>
 <8e836d75-97b0-d301-4d6a-92025e91cad5@redhat.com>
In-Reply-To: <8e836d75-97b0-d301-4d6a-92025e91cad5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.3.2022 7.47, Mika Penttilä wrote:
> 
> 
> On 15.3.2022 20.39, Jason Gunthorpe wrote:
>> On Tue, Mar 15, 2022 at 05:22:15AM +0200, Mika Penttilä wrote:
>>> Hi Jason and thanks for your comments..
>>>
>>> On 14.3.2022 20.24, Jason Gunthorpe wrote:
>>>> On Fri, Mar 11, 2022 at 05:30:50AM +0200, mpenttil@redhat.com wrote:
>>>>> From: Mika Penttilä <mpenttil@redhat.com>
>>>>>
>>>>> HMM selftests use an in-kernel pseudo device to emulate device private
>>>>> memory. The pseudo device registers a major device range for two 
>>>>> pseudo
>>>>> device instances. User space has a script that reads /proc/devices in
>>>>> order to find the assigned major number, and sends that to mknod(1),
>>>>> once for each node.
>>>>>
>>>>> This duplicates a fair amount of boilerplate that misc device can do
>>>>> instead.
>>>>>
>>>>> Change this to use misc device, which makes the device node names 
>>>>> appear
>>>>> for us. This also enables udev-like processing if desired.
>>>>
>>>> This is borderline the wrong way to use misc devices, they should
>>>> never be embedded into other structs like this. It works out here
>>>> because they are eventually only placed in a static array, but still
>>>> it is a generally bad pattern to see.
>>>
>>> Could you elaborate on this one? We have many in-tree usages of the same
>>> pattern, like:
>>
>> The kernel is full of bugs
>>
>>> drivers/video/fbdev/pxa3xx-gcu.c
>>
>> ie this is broken because it allocates like this:
>>
>>          priv = devm_kzalloc(dev, sizeof(struct pxa3xx_gcu_priv), 
>> GFP_KERNEL);
>>          if (!priv)
>>                  return -ENOMEM;
>>
>> And free's via devm:
>>
>>
>> static int pxa3xx_gcu_remove(struct platform_device *pdev)
>> {
>>          struct pxa3xx_gcu_priv *priv = platform_get_drvdata(pdev);
>>
>>          misc_deregister(&priv->misc_dev);
>>          return 0;
>> }
>>
>> But this will UAF if it races fops open with misc_desregister.
> 
> 
> Yes this driver is broken because platform_device and miscdevice have 
> unrelated lifetimes.
> 
>>
>> Proper use of cdevs with proper struct devices prevent this bug.
>>
>>> You mention "placed in a static array", are you seeing a potential 
>>> lifetime
>>> issue or what? Many of the examples above embed miscdevice in a 
>>> dynamically
>>> allocated object also.
>>>
>>> The file object's private_data holds a pointer to the miscdevice, and
>>> fops_get() pins the module. So freeing the objects miscdevice is 
>>> embedded in
>>> at module_exit time should be fine. But, as you said, in this case the
>>> miscdevices are statically allocated, so that shouldn't be an issue
>>> either.
>>
>> Correct, it is OK here because the module refcounts prevent the
>> miscdevice memory from being freed, the above cases with dynamic
>> allocations do not have that protection and are wrong.
>>
>> This is why I don't care for the pattern of putting misc devices
>> inside other structs, it suggests this is perhaps generally safe but
>> it is not.
>>
>>> I think using cdev_add ends up in the same results in device_* api
>>> sense.
>>
>> Nope, everything works right once you use cdev_device_add on a
>> properly registered struct device.
>>
>>> miscdevice acting like a mux at a higher abstraction level simplifies 
>>> the
>>> code.
>>
>> It does avoid the extra struct device, but at the cost of broken
>> memory lifetime
> 
> No, misc_register() ends up calling device_create_with_groups() so there 
> is struct device involved. cdev_device_add() would make the explicit 
> struct_device as a parent of the cdev kobj ensuring that struct_device 
> (and maybe structure containing it) is not free before the cdev. But the 
> lifetime of the objects here are controlled by the module lifetime. 
> Note, there is also cdev involved with miscdevice protecting misc.ko and 
> our fops protecting our module unload.
> 
> I don't mind using the cdev APIs per se, just would like to do for the 
> right reasons. Using cdev apis might be just overkill for many usages, 
> and that's where miscdevice is useful. It miscdevice is broken in some 
> subtle ways I think it should be better documented, or better yet, fixed.
> 
> 
>>
>> Jason
>>
> 
> 
> Thanks,
> Mika

With the cdev approach, the patch (kernel parts) is not too bad either :

Thanks,
Mika

---

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 767538089a62..566e7142f33f 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -29,11 +29,17 @@

  #include "test_hmm_uapi.h"

-#define DMIRROR_NDEVICES               2
  #define DMIRROR_RANGE_FAULT_TIMEOUT    1000
  #define DEVMEM_CHUNK_SIZE              (256 * 1024 * 1024U)
  #define DEVMEM_CHUNKS_RESERVE          16

+static const char *dmirror_device_names[] = {
+       "hmm_dmirror0",
+       "hmm_dmirror1"
+};
+
+#define DMIRROR_NDEVICES ARRAY_SIZE(dmirror_device_names)
+
  static const struct dev_pagemap_ops dmirror_devmem_ops;
  static const struct mmu_interval_notifier_ops dmirror_min_ops;
  static dev_t dmirror_dev;
@@ -74,7 +80,7 @@ struct dmirror {
   * ZONE_DEVICE pages for migration and simulating device memory.
   */
  struct dmirror_chunk {
-       struct dev_pagemap      pagemap;
+       struct dev_pagemap      pagemap;
         struct dmirror_device   *mdevice;
  };

@@ -82,8 +88,9 @@ struct dmirror_chunk {
   * Per device data.
   */
  struct dmirror_device {
-       struct cdev             cdevice;
-       struct hmm_devmem       *devmem;
+       struct cdev             cdevice;
+       struct device           device;
+       struct hmm_devmem       *devmem;

         unsigned int            devmem_capacity;
         unsigned int            devmem_count;
@@ -132,7 +139,7 @@ static int dmirror_fops_open(struct inode *inode, 
struct file *filp)
         xa_init(&dmirror->pt);

         ret = mmu_interval_notifier_insert(&dmirror->notifier, current->mm,
-                               0, ULONG_MAX & PAGE_MASK, &dmirror_min_ops);
+                                       0, ULONG_MAX & PAGE_MASK, 
&dmirror_min_ops);
         if (ret) {
                 kfree(dmirror);
                 return ret;
@@ -1225,7 +1232,11 @@ static int dmirror_device_init(struct 
dmirror_device *mdevice, int id)

         cdev_init(&mdevice->cdevice, &dmirror_fops);
         mdevice->cdevice.owner = THIS_MODULE;
-       ret = cdev_add(&mdevice->cdevice, dev, 1);
+       device_initialize(&mdevice->device);
+       dev_set_name(&mdevice->device, "%s", dmirror_device_names[id]);
+       mdevice->device.devt = dev;
+
+       ret = cdev_device_add(&mdevice->cdevice, &mdevice->device);
         if (ret)
                 return ret;

