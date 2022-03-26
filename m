Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B4A4E7EC0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 04:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiCZDVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 23:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiCZDVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 23:21:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68353532DD
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 20:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648264801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YdzHyBRiDoFBIFf36Fo0Qt/OhY+QHu6QN9v137onA3I=;
        b=IecoOcQ7OCBBTkcdBdymmyoMRnEfe4vDXDZPpz+jcy2vA8QTFfaRjh9e/M54NynWZu5Ofd
        PSXzkaLLtQhPzMGnFJRrGub2ifP8MXxKgkRUxi0RNQQaurmMXmM74m0ntt1JmP1RAs+ysl
        sAZtHkt1kZa7JriAx8qWYZfsNIxHrHE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-445-4tGJ-uZhMwi4qGdGogkQLQ-1; Fri, 25 Mar 2022 23:19:59 -0400
X-MC-Unique: 4tGJ-uZhMwi4qGdGogkQLQ-1
Received: by mail-lf1-f72.google.com with SMTP id cf15-20020a056512280f00b0044a7b923686so522221lfb.20
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 20:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YdzHyBRiDoFBIFf36Fo0Qt/OhY+QHu6QN9v137onA3I=;
        b=pQPm8OvjxRIAFldgzK5zj1b+tWI0H2WyZFPYsuU2VfxcH56GYZjVLixWXuFPbhCfaK
         yTYGlbg1Jfoej8ZX97jiCQSWUVtBb7bo7fUvAUFmO5YxzdY/LYMJda+OnzioOi6eYCCJ
         mZ1aCGKkU6rSwhBRRj1ArG6XDhpvHGWPuTKes5L2Vhy4VW8kNQeiqrhy16ciHmscRAVA
         Xp9qo67rsVrjmu4UU8wh8hZug5pgDGiXGvrIRpyhv6rQKW3MRYmIDtGvTMtwfwCstuc9
         0//oWWP987WgqwU9ghyGxAHSModT+01Ahyq8MIQLtpwV2m36LERZNh36lFU6Odea2C1+
         Y4OA==
X-Gm-Message-State: AOAM5300JoaK6zA0EzRLr3tsIWrcuCeI+5BTNrXHOfeyJoUmJP4HZBOC
        vbx1ouUK6mvMe3b4WS0QpfVtwuSVxpQiEcyZVsC/CXvbtKt6XYHvOl55mchSid4EwdnDuMg5OQt
        TJJl2HhzVaM2iQuPBDSL3NgE=
X-Received: by 2002:a19:5f12:0:b0:44a:3274:9b96 with SMTP id t18-20020a195f12000000b0044a32749b96mr10370088lfb.251.1648264797573;
        Fri, 25 Mar 2022 20:19:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwM3qYsyxD83Noo9clgxEEeANZ0nfQgAU/eUnMtrWmJHrKNISm2dBMmAdspzViGDbAiPam47Q==
X-Received: by 2002:a19:5f12:0:b0:44a:3274:9b96 with SMTP id t18-20020a195f12000000b0044a32749b96mr10370079lfb.251.1648264797376;
        Fri, 25 Mar 2022 20:19:57 -0700 (PDT)
Received: from [192.168.1.121] (91-145-109-188.bb.dnainternet.fi. [91.145.109.188])
        by smtp.gmail.com with ESMTPSA id y24-20020a199158000000b0044a76a4808esm342529lfj.22.2022.03.25.20.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 20:19:57 -0700 (PDT)
Message-ID: <18ee348d-f617-9e55-ed11-21321e284c0b@redhat.com>
Date:   Sat, 26 Mar 2022 05:19:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5] mm/hmm/test: use char dev with struct device to get
 device node
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        apopple@nvidia.com, jhubbard@nvidia.com, rcampbell@nvidia.com,
        vbabka@suse.cz
References: <20220322043543.18424-1-mpenttil@redhat.com>
 <20220325181739.GL64706@ziepe.ca>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mpenttil@redhat.com>
In-Reply-To: <20220325181739.GL64706@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.3.2022 20.17, Jason Gunthorpe wrote:
> On Tue, Mar 22, 2022 at 06:35:43AM +0200, mpenttil@redhat.com wrote:
>> From: Mika Penttilä <mpenttil@redhat.com>
>>
>> HMM selftests use an in-kernel pseudo device to emulate device private
>> memory. The pseudo device registers a major device range for two pseudo
>> device instances. User space has a script that reads /proc/devices in
>> order to find the assigned major number, and sends that to mknod(1),
>> once for each node.
>>
>> Change this to properly use cdev and struct device APIs.
>>
>> Delete the /proc/devices parsing from the user-space test script, now
>> that it is unnecessary.
>>
>> Also, deleted an unused field in struct dmirror_device: devmem.
>>
>> Signed-off-by: Mika Penttilä <mpenttil@redhat.com>
>> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
>> Cc: Alistair Popple <apopple@nvidia.com>
>> Cc: Ralph Campbell <rcampbell@nvidia.com>
>> Cc: Jason Gunthorpe <jgg@ziepe.ca>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> v5:
>>          - fix whitespace
>>          . delete unused structure field
>> v4:
>>          - fix commit log
>> v3:
>>          - use cdev_device_add() instead of miscdevice
>> v2:
>>          - Cleanups per review comments from John Hubbard
>>          - Added Tested-by and Ccs
>>
>>   lib/test_hmm.c                         | 18 ++++++++++++++----
>>   tools/testing/selftests/vm/test_hmm.sh |  6 ------
>>   2 files changed, 14 insertions(+), 10 deletions(-)
>>
>> diff --git a/lib/test_hmm.c b/lib/test_hmm.c
>> index 767538089a62..3c7f2a92b09e 100644
>> +++ b/lib/test_hmm.c
>> @@ -29,11 +29,17 @@
>>   
>>   #include "test_hmm_uapi.h"
>>   
>> -#define DMIRROR_NDEVICES		2
>>   #define DMIRROR_RANGE_FAULT_TIMEOUT	1000
>>   #define DEVMEM_CHUNK_SIZE		(256 * 1024 * 1024U)
>>   #define DEVMEM_CHUNKS_RESERVE		16
>>   
>> +static const char *dmirror_device_names[] = {
>> +	"hmm_dmirror0",
>> +	"hmm_dmirror1"
>> +};
>> +
>> +#define DMIRROR_NDEVICES ARRAY_SIZE(dmirror_device_names)
>> +
>>   static const struct dev_pagemap_ops dmirror_devmem_ops;
>>   static const struct mmu_interval_notifier_ops dmirror_min_ops;
>>   static dev_t dmirror_dev;
>> @@ -83,7 +89,7 @@ struct dmirror_chunk {
>>    */
>>   struct dmirror_device {
>>   	struct cdev		cdevice;
>> -	struct hmm_devmem	*devmem;
>> +	struct device		device;
>>   
>>   	unsigned int		devmem_capacity;
>>   	unsigned int		devmem_count;
>> @@ -1225,7 +1231,11 @@ static int dmirror_device_init(struct dmirror_device *mdevice, int id)
>>   
>>   	cdev_init(&mdevice->cdevice, &dmirror_fops);
>>   	mdevice->cdevice.owner = THIS_MODULE;
>> -	ret = cdev_add(&mdevice->cdevice, dev, 1);
>> +	device_initialize(&mdevice->device);
>> +	dev_set_name(&mdevice->device, "%s", dmirror_device_names[id]);
> 
> Just
> 	dev_set_name(&mdevice->device, "hmm_dmirror%u", id);
> 
> No need for an array

Yeah, no absolute need, thought names in an array is less hardcoded wrt 
device node count and naming standard.

> 
> Also check for error

True. Interesting fact is that even the device core itself doesn't check 
for errors calling dev_set_name(), but sure it can fail in memory 
allocations.

> 
> Jason
> 

Mika

