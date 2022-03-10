Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357764D40D4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 06:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239609AbiCJFfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 00:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbiCJFe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 00:34:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25048A776E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 21:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646890435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C+CV2ZTheCDjwIQatvOSM+2IpK+hatXZ+6LPwmkSoIU=;
        b=N90JfKlmeePUtDw4z7bSzDBr6LEElZui/cmC6h/JBAggfjg4dS8M8YTfhxOYooho2ZQTst
        PWojlfDIXgxvC+7Hrsno/Focx83tSghhMdmJs6vCG+iJuCfwk+DUEfyprsDnnuXHB3Bpal
        nf2sRT1Wf62G3c9F0EXE2eC5cdDuqv8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-5Z_bA30MO5Ko7qeS7XP13w-1; Thu, 10 Mar 2022 00:33:53 -0500
X-MC-Unique: 5Z_bA30MO5Ko7qeS7XP13w-1
Received: by mail-lj1-f197.google.com with SMTP id g8-20020a2e9e48000000b00247bc56d2a0so1822848ljk.15
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 21:33:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=C+CV2ZTheCDjwIQatvOSM+2IpK+hatXZ+6LPwmkSoIU=;
        b=XOGKqb8u8S386rzN8CIZROdXC4UXbszr7PwyATDyqXJmKSGri8yR1KSgxkG4RzTs0C
         kstIBPAOwTJ+9rumhhOXlVUDJjln4WLNhphwiMVXzcgx/y1YoYst99W9TAS8mrmC7bat
         onSPxG0a69LRWTLDJbstZxu0J4NwXWgCIAilbkecjH9pX+ixY5/A1Kh36Q6GQ3fUkEV2
         sw5jSn3nznfu8y9Kv3i5SQ5WK8zk9lllG12Trb/Km10BccUN8YAjc/yPf1ZVIjHoYwBV
         dm7gDj5yYtg+mcEhLGkdEn7TG6qYOeccsjk+cLFrAUvDLJn6ye8B7BLwQSKxZnFp8DNO
         0pZg==
X-Gm-Message-State: AOAM530obNW2LtwgJVbSmkIbagehYE01hvepQMcTjWANfifx3DaLqhop
        Y57c1Dq9YApto5n1Q975c1xb1Rs1uxbyVlHQ7kBuOtmf3Kh2zCHCeq/uhQKHtGGprANZqcz4T4y
        9urNk9W7hoRkZRcHiG7AVOU0=
X-Received: by 2002:a05:651c:105:b0:247:e127:5e0b with SMTP id a5-20020a05651c010500b00247e1275e0bmr1913677ljb.147.1646890432230;
        Wed, 09 Mar 2022 21:33:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz3JB6LT24RsvA9CYAMMS6VXGgsDqV6dK6GcgPOO9FwRlM1R3+OJmNsicqEiGdPL5QEbmlgGg==
X-Received: by 2002:a05:651c:105:b0:247:e127:5e0b with SMTP id a5-20020a05651c010500b00247e1275e0bmr1913669ljb.147.1646890431963;
        Wed, 09 Mar 2022 21:33:51 -0800 (PST)
Received: from [192.168.1.121] (91-145-109-188.bb.dnainternet.fi. [91.145.109.188])
        by smtp.gmail.com with ESMTPSA id o20-20020ac24e94000000b004481ceec304sm773072lfr.220.2022.03.09.21.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 21:33:51 -0800 (PST)
Message-ID: <f36ae290-979e-1f6f-3169-edd5f729a971@redhat.com>
Date:   Thu, 10 Mar 2022 07:33:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] HMM selftests changes
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20220308015705.8424-1-mpenttil@redhat.com>
 <7fc9cae2-04b3-153c-f826-e565a1beeb2d@suse.cz>
 <4c6bc437-32ba-7bfd-05e6-b555a1a13776@nvidia.com>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mpenttil@redhat.com>
In-Reply-To: <4c6bc437-32ba-7bfd-05e6-b555a1a13776@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.3.2022 5.44, John Hubbard wrote:
> On 3/8/22 5:10 AM, Vlastimil Babka wrote:
>> +CC relevant folks
>>
>> On 3/8/22 02:57, mpenttil@redhat.com wrote:
>>> From: Mika Penttilä <mpenttil@redhat.com>
> 
> Hi Mika,
> 
> This looks like a very nice cleanup and simplification, delighted to see
> it!

Thanks!

> 
> In fact, I like it so much that I've got a bunch of fussy nitpicks I'm
> hoping you'll consider applying, below. :)
> 
> Also, I'm assuming you've tested it a little bit? (My test rig is boxed
> up for another day or two, don't ask...haha.)
> 

Yes it passed the tests with the changes.


>>>
>>> HMM selftests use a in-kernel pseudo device to emulate device private memory.
>>>
>>> For now, the pseudo device registers a major device range for two pseudo device instances.
>>> User space has a script that goes figures out from /proc/devices the assigned major
>>> and mknods the device nodes.
>>>
>>> Change this use to a more standard device framework, like misc device,
>>> which makes the device node names to appear right under any decent user space.
>>> This also makes it possible for udev- like processing if wanted,
>>> and the /proc/devices parsing is not needed any more.
> 
> How about this for the subject line and body? I've made the subject line
> match what other commits look like in this area, and I've clarified the
> wording in the body:
> 
> 
> mm/hmm/test: simplify hmm test code: use miscdevice instead of char dev
> 
> HMM selftests use an in-kernel pseudo device to emulate device private
> memory. The pseudo device registers a major device range for two pseudo
> device instances. User space has a script that reads /proc/devices in
> order to find the assigned major number, and sends that to mknod(1),
> once for each node.
> 
> This duplicates a fair amount of boilerplate that misc device can do
> instead.
> 
> Change this to use misc device, which makes the device node names appear
> for us. This also enables udev-like processing if desired.
> 
> Delete the /proc/devices parsing from the user-space test script, now
> that it is unnecessary.
> 
>>>
>>> Signed-off-by: Mika Penttilä <mpenttil@redhat.com>
>>> ---
>>>   lib/test_hmm.c                         | 46 +++++++++++++++-----------
>>>   tools/testing/selftests/vm/test_hmm.sh |  6 ----
>>>   2 files changed, 26 insertions(+), 26 deletions(-)
>>>
>>> diff --git a/lib/test_hmm.c b/lib/test_hmm.c
>>> index 767538089a62..76f6129e1f1f 100644
>>> --- a/lib/test_hmm.c
>>> +++ b/lib/test_hmm.c
>>> @@ -10,7 +10,6 @@
>>>   #include <linux/mm.h>
>>>   #include <linux/module.h>
>>>   #include <linux/kernel.h>
>>> -#include <linux/cdev.h>
>>>   #include <linux/device.h>
>>>   #include <linux/mutex.h>
>>>   #include <linux/rwsem.h>
>>> @@ -25,18 +24,25 @@
>>>   #include <linux/swapops.h>
>>>   #include <linux/sched/mm.h>
>>>   #include <linux/platform_device.h>
>>> +#include <linux/miscdevice.h>
>>>   #include <linux/rmap.h>
>>>   
>>>   #include "test_hmm_uapi.h"
>>>   
>>> -#define DMIRROR_NDEVICES		2
>>>   #define DMIRROR_RANGE_FAULT_TIMEOUT	1000
>>>   #define DEVMEM_CHUNK_SIZE		(256 * 1024 * 1024U)
>>>   #define DEVMEM_CHUNKS_RESERVE		16
>>>   
>>> +
> 
> Extra newline, please delete.
> 

yep


>>> +static const char *dmirror_device_names[] = {
>>> +	"hmm_dmirror0",
>>> +	"hmm_dmirror1"
>>> +};
>>> +
>>> +#define DMIRROR_NDEVICES ARRAY_SIZE(dmirror_device_names)
>>> +
>>>   static const struct dev_pagemap_ops dmirror_devmem_ops;
>>>   static const struct mmu_interval_notifier_ops dmirror_min_ops;
>>> -static dev_t dmirror_dev;
>>>   
>>>   struct dmirror_device;
>>>   
>>> @@ -82,7 +88,7 @@ struct dmirror_chunk {
>>>    * Per device data.
>>>    */
>>>   struct dmirror_device {
>>> -	struct cdev		cdevice;
>>> +	struct miscdevice	miscdevice;
>>>   	struct hmm_devmem	*devmem;
>>>   
>>>   	unsigned int		devmem_capacity;
>>> @@ -118,16 +124,20 @@ static void dmirror_bounce_fini(struct dmirror_bounce *bounce)
>>>   
>>>   static int dmirror_fops_open(struct inode *inode, struct file *filp)
>>>   {
>>> -	struct cdev *cdev = inode->i_cdev;
>>> +
>>> +	struct dmirror_device *dd = container_of(filp->private_data,
>>> +                                              struct dmirror_device, miscdevice
>>> +		);
> 
> Let's delete that whole chunk, because the variable is unnecessary, and
> is adding to the line count and mental load for no reason.


Agreed.


> 
> Look how much cleaner this it gets after applying this incremental diff
> on top of your patch:
> 
> diff --git a/lib/test_hmm.c b/lib/test_hmm.c
> index 76f6129e1f1f..3ec8ca8059cd 100644
> --- a/lib/test_hmm.c
> +++ b/lib/test_hmm.c
> @@ -125,19 +125,16 @@ static void dmirror_bounce_fini(struct dmirror_bounce *bounce)
>   static int dmirror_fops_open(struct inode *inode, struct file *filp)
>   {
>   
> -	struct dmirror_device *dd = container_of(filp->private_data,
> -                                              struct dmirror_device, miscdevice
> -		);
>   	struct dmirror *dmirror;
>   	int ret;
>   
> -
>   	/* Mirror this process address space */
>   	dmirror = kzalloc(sizeof(*dmirror), GFP_KERNEL);
>   	if (dmirror == NULL)
>   		return -ENOMEM;
>   
> -	dmirror->mdevice = dd;
> +	dmirror->mdevice = container_of(filp->private_data,struct dmirror_device,
> +									miscdevice);
>   	mutex_init(&dmirror->mutex);
>   	xa_init(&dmirror->pt);
> 
> 
>>>   	struct dmirror *dmirror;
>>>   	int ret;
>>>   
>>> +
>>>   	/* Mirror this process address space */
>>>   	dmirror = kzalloc(sizeof(*dmirror), GFP_KERNEL);
>>>   	if (dmirror == NULL)
>>>   		return -ENOMEM;
>>>   
>>> -	dmirror->mdevice = container_of(cdev, struct dmirror_device, cdevice);
>>> +	dmirror->mdevice = dd;
>>>   	mutex_init(&dmirror->mutex);
>>>   	xa_init(&dmirror->pt);
>>>   
>>> @@ -1216,16 +1226,18 @@ static const struct dev_pagemap_ops dmirror_devmem_ops = {
>>>   
>>>   static int dmirror_device_init(struct dmirror_device *mdevice, int id)
>>>   {
>>> -	dev_t dev;
>>> +
>>>   	int ret;
>>>   
>>> -	dev = MKDEV(MAJOR(dmirror_dev), id);
>>>   	mutex_init(&mdevice->devmem_lock);
>>>   	spin_lock_init(&mdevice->lock);
>>>   
>>> -	cdev_init(&mdevice->cdevice, &dmirror_fops);
>>> -	mdevice->cdevice.owner = THIS_MODULE;
>>> -	ret = cdev_add(&mdevice->cdevice, dev, 1);
>>> +	mdevice->miscdevice.minor = MISC_DYNAMIC_MINOR;
>>> +	mdevice->miscdevice.name = dmirror_device_names[id];
>>> +	mdevice->miscdevice.fops = &dmirror_fops;
>>> +
>>> +	ret = misc_register(&mdevice->miscdevice);
>>> +
>>>   	if (ret)
>>>   		return ret;
>>>   
>>> @@ -1252,7 +1264,7 @@ static void dmirror_device_remove(struct dmirror_device *mdevice)
>>>   		kfree(mdevice->devmem_chunks);
>>>   	}
>>>   
>>> -	cdev_del(&mdevice->cdevice);
>>> +	misc_deregister(&mdevice->miscdevice);
>>>   }
>>>   
>>>   static int __init hmm_dmirror_init(void)
>>> @@ -1260,11 +1272,6 @@ static int __init hmm_dmirror_init(void)
>>>   	int ret;
>>>   	int id;
>>>   
>>> -	ret = alloc_chrdev_region(&dmirror_dev, 0, DMIRROR_NDEVICES,
>>> -				  "HMM_DMIRROR");
>>> -	if (ret)
>>> -		goto err_unreg;
>>> -
>>>   	for (id = 0; id < DMIRROR_NDEVICES; id++) {
>>>   		ret = dmirror_device_init(dmirror_devices + id, id);
>>>   		if (ret)
>>> @@ -1277,8 +1284,7 @@ static int __init hmm_dmirror_init(void)
>>>   err_chrdev:
>>>   	while (--id >= 0)
>>>   		dmirror_device_remove(dmirror_devices + id);
>>> -	unregister_chrdev_region(dmirror_dev, DMIRROR_NDEVICES);
>>> -err_unreg:
>>> +
>>>   	return ret;
>>>   }
>>>   
>>> @@ -1288,7 +1294,7 @@ static void __exit hmm_dmirror_exit(void)
>>>   
>>>   	for (id = 0; id < DMIRROR_NDEVICES; id++)
>>>   		dmirror_device_remove(dmirror_devices + id);
>>> -	unregister_chrdev_region(dmirror_dev, DMIRROR_NDEVICES);
>>> +
> 
> Another extra newline, please delete it.

yes

> 
>>>   }
>>>   
>>>   module_init(hmm_dmirror_init);
>>> diff --git a/tools/testing/selftests/vm/test_hmm.sh b/tools/testing/selftests/vm/test_hmm.sh
>>> index 0647b525a625..69f5889f8575 100755
>>> --- a/tools/testing/selftests/vm/test_hmm.sh
>>> +++ b/tools/testing/selftests/vm/test_hmm.sh
>>> @@ -41,17 +41,11 @@ check_test_requirements()
>>>   load_driver()
>>>   {
>>>   	modprobe $DRIVER > /dev/null 2>&1
>>> -	if [ $? == 0 ]; then
>>> -		major=$(awk "\$2==\"HMM_DMIRROR\" {print \$1}" /proc/devices)
>>> -		mknod /dev/hmm_dmirror0 c $major 0
>>> -		mknod /dev/hmm_dmirror1 c $major 1
>>> -	fi
>>>   }
>>>   
>>>   unload_driver()
>>>   {
>>>   	modprobe -r $DRIVER > /dev/null 2>&1
>>> -	rm -f /dev/hmm_dmirror?
> 
> Nice!
> 
>>>   }
>>>   
>>>   run_smoke()
>>
> 
> thanks,



Ok will make the changes and repost,

thanks!

--Mika

