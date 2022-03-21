Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC024E1F31
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 03:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344259AbiCUC6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 22:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344255AbiCUC6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 22:58:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8D98E9CB9
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 19:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647831427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pCuhllurteRua5PyUU4kLUMk7Q61fYm32vUEavsNEtE=;
        b=Rzenykna5aRjO1X4YmEJ+tlgYnCycqtdoicPzJzFVEpkEAcFxhV2gLItxFmYiwM4rrpCDD
        nEvGmxwnsoSlprnkDgo2c86xMovAV51aEpoIZcD1vUCpw4XqM3WyMNoS4yFvF6oqYExIax
        4JGWE86RVOK4nj7qlQCB5SA6L/jyQ2M=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-AJBX0qcYMfiQNQX9TXqfbA-1; Sun, 20 Mar 2022 22:57:06 -0400
X-MC-Unique: AJBX0qcYMfiQNQX9TXqfbA-1
Received: by mail-lf1-f69.google.com with SMTP id d14-20020a05651233ce00b004475964142aso3405102lfg.21
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 19:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pCuhllurteRua5PyUU4kLUMk7Q61fYm32vUEavsNEtE=;
        b=mz/tL7rUkfOMjbisTJRJai1dB0foSW0U6VXGlXG2wePeKYoUYt/G+jprBMrqNAWZdk
         U03CO7/byHCOkIV+95pNmW60LhNfW/OMuyjPl3rxoLHw0gYB8lLJXl5+YS935R87EzrF
         qnyyRyKQv7VnvJR1pYiBZz1dvZb/Hvjt+4/+/vp7+Yzo0KssPNIAW2xDQQWQo2kKXR+4
         pGT1wCSbWI3OwoAO+xd+GSRTRFChMmASdgLUwJg0b/4MMrqyzsoKH4VsSo6SKVTn4gxD
         8Xpr/Fb3ivYEPsdXfYQVwzPc3nWpgDTDI0GUh86ELq58sqXboU8e1adDvPDxLp+JR7G2
         YuPw==
X-Gm-Message-State: AOAM530WkHef9QUqD1SefHfL41reRSXfMxRM2olcv4IFyg0R7zC5+UCV
        kzwny7JRG+jgNXIP4Wxcu15YQ5aZrr14Vv/SzG0JQu3tHvK4bW94H82Fz+zaFtEAPH8gMrO/njS
        7YRR26/n6K8g5BKc/s8GAHfkRNG4Vx7bfDFwjZwKT2Kn/5Ui1mUz2WafqurqNtaJ78ErfgrJCfv
        g=
X-Received: by 2002:a05:6512:168f:b0:44a:2173:ed7b with SMTP id bu15-20020a056512168f00b0044a2173ed7bmr5262118lfb.371.1647831424603;
        Sun, 20 Mar 2022 19:57:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGJ6Jw1DEi6JG7t+j0bPwnAbvz6hpB8dNlEaxU1hDs2uTDRVf/3MKog+mSrYdO+eyKYtn8Bg==
X-Received: by 2002:a05:6512:168f:b0:44a:2173:ed7b with SMTP id bu15-20020a056512168f00b0044a2173ed7bmr5262101lfb.371.1647831424325;
        Sun, 20 Mar 2022 19:57:04 -0700 (PDT)
Received: from [192.168.1.121] (91-145-109-188.bb.dnainternet.fi. [91.145.109.188])
        by smtp.gmail.com with ESMTPSA id s6-20020a2e98c6000000b0024803f88994sm1944727ljj.79.2022.03.20.19.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Mar 2022 19:57:04 -0700 (PDT)
Message-ID: <3db4f14c-b0ff-45be-738d-3baa40490892@redhat.com>
Date:   Mon, 21 Mar 2022 04:57:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] mm/hmm/test: use char dev with struct device to get
 device node
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     apopple@nvidia.com, jhubbard@nvidia.com, rcampbell@nvidia.com,
        jgg@ziepe.ca, vbabka@suse.cz
References: <20220321024400.20956-1-mpenttil@redhat.com>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mpenttil@redhat.com>
In-Reply-To: <20220321024400.20956-1-mpenttil@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry ignore this one, see v4


On 21.3.2022 4.44, mpenttil@redhat.com wrote:
> From: Mika Penttilä <mpenttil@redhat.com>
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
> Signed-off-by: Mika Penttilä <mpenttil@redhat.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> ---
> v3:
>          - use cdev_device_add() instead of miscdevice
> v2:
>          - Cleanups per review comments from John Hubbard
>          - Added Tested-by and Ccs
> 
>   lib/test_hmm.c                         | 25 ++++++++++++++++++-------
>   tools/testing/selftests/vm/test_hmm.sh |  6 ------
>   2 files changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/lib/test_hmm.c b/lib/test_hmm.c
> index 767538089a62..d247e9c0fe94 100644
> --- a/lib/test_hmm.c
> +++ b/lib/test_hmm.c
> @@ -29,11 +29,17 @@
>   
>   #include "test_hmm_uapi.h"
>   
> -#define DMIRROR_NDEVICES		2
>   #define DMIRROR_RANGE_FAULT_TIMEOUT	1000
>   #define DEVMEM_CHUNK_SIZE		(256 * 1024 * 1024U)
>   #define DEVMEM_CHUNKS_RESERVE		16
>   
> +static const char *dmirror_device_names[] = {
> +	"hmm_dmirror0",
> +	"hmm_dmirror1"
> +};
> +
> +#define DMIRROR_NDEVICES ARRAY_SIZE(dmirror_device_names)
> +
>   static const struct dev_pagemap_ops dmirror_devmem_ops;
>   static const struct mmu_interval_notifier_ops dmirror_min_ops;
>   static dev_t dmirror_dev;
> @@ -74,7 +80,7 @@ struct dmirror {
>    * ZONE_DEVICE pages for migration and simulating device memory.
>    */
>   struct dmirror_chunk {
> -	struct dev_pagemap	pagemap;
> +	struct dev_pagemap      pagemap;
>   	struct dmirror_device	*mdevice;
>   };
>   
> @@ -82,8 +88,9 @@ struct dmirror_chunk {
>    * Per device data.
>    */
>   struct dmirror_device {
> -	struct cdev		cdevice;
> -	struct hmm_devmem	*devmem;
> +	struct cdev             cdevice;
> +	struct device           device;
> +	struct hmm_devmem       *devmem;
>   
>   	unsigned int		devmem_capacity;
>   	unsigned int		devmem_count;
> @@ -132,7 +139,7 @@ static int dmirror_fops_open(struct inode *inode, struct file *filp)
>   	xa_init(&dmirror->pt);
>   
>   	ret = mmu_interval_notifier_insert(&dmirror->notifier, current->mm,
> -				0, ULONG_MAX & PAGE_MASK, &dmirror_min_ops);
> +					0, ULONG_MAX & PAGE_MASK, &dmirror_min_ops);
>   	if (ret) {
>   		kfree(dmirror);
>   		return ret;
> @@ -1225,7 +1232,11 @@ static int dmirror_device_init(struct dmirror_device *mdevice, int id)
>   
>   	cdev_init(&mdevice->cdevice, &dmirror_fops);
>   	mdevice->cdevice.owner = THIS_MODULE;
> -	ret = cdev_add(&mdevice->cdevice, dev, 1);
> +	device_initialize(&mdevice->device);
> +	dev_set_name(&mdevice->device, "%s", dmirror_device_names[id]);
> +	mdevice->device.devt = dev;
> +
> +	ret = cdev_device_add(&mdevice->cdevice, &mdevice->device);
>   	if (ret)
>   		return ret;
>   
> @@ -1252,7 +1263,7 @@ static void dmirror_device_remove(struct dmirror_device *mdevice)
>   		kfree(mdevice->devmem_chunks);
>   	}
>   
> -	cdev_del(&mdevice->cdevice);
> +	cdev_device_del(&mdevice->cdevice, &mdevice->device);
>   }
>   
>   static int __init hmm_dmirror_init(void)
> diff --git a/tools/testing/selftests/vm/test_hmm.sh b/tools/testing/selftests/vm/test_hmm.sh
> index 0647b525a625..69f5889f8575 100755
> --- a/tools/testing/selftests/vm/test_hmm.sh
> +++ b/tools/testing/selftests/vm/test_hmm.sh
> @@ -41,17 +41,11 @@ check_test_requirements()
>   load_driver()
>   {
>   	modprobe $DRIVER > /dev/null 2>&1
> -	if [ $? == 0 ]; then
> -		major=$(awk "\$2==\"HMM_DMIRROR\" {print \$1}" /proc/devices)
> -		mknod /dev/hmm_dmirror0 c $major 0
> -		mknod /dev/hmm_dmirror1 c $major 1
> -	fi
>   }
>   
>   unload_driver()
>   {
>   	modprobe -r $DRIVER > /dev/null 2>&1
> -	rm -f /dev/hmm_dmirror?
>   }
>   
>   run_smoke()

