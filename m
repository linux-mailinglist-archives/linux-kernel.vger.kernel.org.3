Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209044D18C4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 14:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243963AbiCHNLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 08:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbiCHNLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 08:11:08 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97086483A7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 05:10:11 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 53B43210F4;
        Tue,  8 Mar 2022 13:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646745010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5RiKceAKwe6HlRuFb6Ga5N8wMOB5Yew6R0QikN++sko=;
        b=3WVUNojInKG3WD5g7b3/ZUODUsIv2r/yPIF95AqbSCz4tNBiZh4yd7fh+f+mitjMIVsWpt
        2LxJ7tYp6YZ17i8DMRS6ZWTDSmM4UHXrLgjZILB9IWILE4c6fiVtnU+QzUrwWy2bKnBwnt
        fjPBZwkpznIAzWEvY3d/6lnq80V0XIc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646745010;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5RiKceAKwe6HlRuFb6Ga5N8wMOB5Yew6R0QikN++sko=;
        b=PI2L3vJUTgR8r196GgbfWCu/8aCjjOLNaxCbFrJ+Lu9FQKSv2Iphy07wtol7PcMjR8HWxr
        oPv0FcKJHT7z/gDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2EDEC13CA6;
        Tue,  8 Mar 2022 13:10:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SZvYCrJVJ2JwFQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 08 Mar 2022 13:10:10 +0000
Message-ID: <7fc9cae2-04b3-153c-f826-e565a1beeb2d@suse.cz>
Date:   Tue, 8 Mar 2022 14:10:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] HMM selftests changes
Content-Language: en-US
To:     mpenttil@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20220308015705.8424-1-mpenttil@redhat.com>
Cc:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220308015705.8424-1-mpenttil@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC relevant folks

On 3/8/22 02:57, mpenttil@redhat.com wrote:
> From: Mika Penttilä <mpenttil@redhat.com>
> 
> HMM selftests use a in-kernel pseudo device to emulate device private memory.
> 
> For now, the pseudo device registers a major device range for two pseudo device instances.
> User space has a script that goes figures out from /proc/devices the assigned major
> and mknods the device nodes.
> 
> Change this use to a more standard device framework, like misc device,
> which makes the device node names to appear right under any decent user space.
> This also makes it possible for udev- like processing if wanted,
> and the /proc/devices parsing is not needed any more.
> 
> Signed-off-by: Mika Penttilä <mpenttil@redhat.com>
> ---
>  lib/test_hmm.c                         | 46 +++++++++++++++-----------
>  tools/testing/selftests/vm/test_hmm.sh |  6 ----
>  2 files changed, 26 insertions(+), 26 deletions(-)
> 
> diff --git a/lib/test_hmm.c b/lib/test_hmm.c
> index 767538089a62..76f6129e1f1f 100644
> --- a/lib/test_hmm.c
> +++ b/lib/test_hmm.c
> @@ -10,7 +10,6 @@
>  #include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> -#include <linux/cdev.h>
>  #include <linux/device.h>
>  #include <linux/mutex.h>
>  #include <linux/rwsem.h>
> @@ -25,18 +24,25 @@
>  #include <linux/swapops.h>
>  #include <linux/sched/mm.h>
>  #include <linux/platform_device.h>
> +#include <linux/miscdevice.h>
>  #include <linux/rmap.h>
>  
>  #include "test_hmm_uapi.h"
>  
> -#define DMIRROR_NDEVICES		2
>  #define DMIRROR_RANGE_FAULT_TIMEOUT	1000
>  #define DEVMEM_CHUNK_SIZE		(256 * 1024 * 1024U)
>  #define DEVMEM_CHUNKS_RESERVE		16
>  
> +
> +static const char *dmirror_device_names[] = {
> +	"hmm_dmirror0",
> +	"hmm_dmirror1"
> +};
> +
> +#define DMIRROR_NDEVICES ARRAY_SIZE(dmirror_device_names)
> +
>  static const struct dev_pagemap_ops dmirror_devmem_ops;
>  static const struct mmu_interval_notifier_ops dmirror_min_ops;
> -static dev_t dmirror_dev;
>  
>  struct dmirror_device;
>  
> @@ -82,7 +88,7 @@ struct dmirror_chunk {
>   * Per device data.
>   */
>  struct dmirror_device {
> -	struct cdev		cdevice;
> +	struct miscdevice	miscdevice;
>  	struct hmm_devmem	*devmem;
>  
>  	unsigned int		devmem_capacity;
> @@ -118,16 +124,20 @@ static void dmirror_bounce_fini(struct dmirror_bounce *bounce)
>  
>  static int dmirror_fops_open(struct inode *inode, struct file *filp)
>  {
> -	struct cdev *cdev = inode->i_cdev;
> +
> +	struct dmirror_device *dd = container_of(filp->private_data,
> +                                              struct dmirror_device, miscdevice
> +		);
>  	struct dmirror *dmirror;
>  	int ret;
>  
> +
>  	/* Mirror this process address space */
>  	dmirror = kzalloc(sizeof(*dmirror), GFP_KERNEL);
>  	if (dmirror == NULL)
>  		return -ENOMEM;
>  
> -	dmirror->mdevice = container_of(cdev, struct dmirror_device, cdevice);
> +	dmirror->mdevice = dd;
>  	mutex_init(&dmirror->mutex);
>  	xa_init(&dmirror->pt);
>  
> @@ -1216,16 +1226,18 @@ static const struct dev_pagemap_ops dmirror_devmem_ops = {
>  
>  static int dmirror_device_init(struct dmirror_device *mdevice, int id)
>  {
> -	dev_t dev;
> +
>  	int ret;
>  
> -	dev = MKDEV(MAJOR(dmirror_dev), id);
>  	mutex_init(&mdevice->devmem_lock);
>  	spin_lock_init(&mdevice->lock);
>  
> -	cdev_init(&mdevice->cdevice, &dmirror_fops);
> -	mdevice->cdevice.owner = THIS_MODULE;
> -	ret = cdev_add(&mdevice->cdevice, dev, 1);
> +	mdevice->miscdevice.minor = MISC_DYNAMIC_MINOR;
> +	mdevice->miscdevice.name = dmirror_device_names[id];
> +	mdevice->miscdevice.fops = &dmirror_fops;
> +
> +	ret = misc_register(&mdevice->miscdevice);
> +
>  	if (ret)
>  		return ret;
>  
> @@ -1252,7 +1264,7 @@ static void dmirror_device_remove(struct dmirror_device *mdevice)
>  		kfree(mdevice->devmem_chunks);
>  	}
>  
> -	cdev_del(&mdevice->cdevice);
> +	misc_deregister(&mdevice->miscdevice);
>  }
>  
>  static int __init hmm_dmirror_init(void)
> @@ -1260,11 +1272,6 @@ static int __init hmm_dmirror_init(void)
>  	int ret;
>  	int id;
>  
> -	ret = alloc_chrdev_region(&dmirror_dev, 0, DMIRROR_NDEVICES,
> -				  "HMM_DMIRROR");
> -	if (ret)
> -		goto err_unreg;
> -
>  	for (id = 0; id < DMIRROR_NDEVICES; id++) {
>  		ret = dmirror_device_init(dmirror_devices + id, id);
>  		if (ret)
> @@ -1277,8 +1284,7 @@ static int __init hmm_dmirror_init(void)
>  err_chrdev:
>  	while (--id >= 0)
>  		dmirror_device_remove(dmirror_devices + id);
> -	unregister_chrdev_region(dmirror_dev, DMIRROR_NDEVICES);
> -err_unreg:
> +
>  	return ret;
>  }
>  
> @@ -1288,7 +1294,7 @@ static void __exit hmm_dmirror_exit(void)
>  
>  	for (id = 0; id < DMIRROR_NDEVICES; id++)
>  		dmirror_device_remove(dmirror_devices + id);
> -	unregister_chrdev_region(dmirror_dev, DMIRROR_NDEVICES);
> +
>  }
>  
>  module_init(hmm_dmirror_init);
> diff --git a/tools/testing/selftests/vm/test_hmm.sh b/tools/testing/selftests/vm/test_hmm.sh
> index 0647b525a625..69f5889f8575 100755
> --- a/tools/testing/selftests/vm/test_hmm.sh
> +++ b/tools/testing/selftests/vm/test_hmm.sh
> @@ -41,17 +41,11 @@ check_test_requirements()
>  load_driver()
>  {
>  	modprobe $DRIVER > /dev/null 2>&1
> -	if [ $? == 0 ]; then
> -		major=$(awk "\$2==\"HMM_DMIRROR\" {print \$1}" /proc/devices)
> -		mknod /dev/hmm_dmirror0 c $major 0
> -		mknod /dev/hmm_dmirror1 c $major 1
> -	fi
>  }
>  
>  unload_driver()
>  {
>  	modprobe -r $DRIVER > /dev/null 2>&1
> -	rm -f /dev/hmm_dmirror?
>  }
>  
>  run_smoke()

