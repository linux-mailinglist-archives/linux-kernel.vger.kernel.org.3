Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5AE4E7D3C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiCYTce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiCYTcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:32:15 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67122A62C3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:26:21 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id i65so6753637qkd.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=a4k5sbPFB7Mgl39AqQajFxJ0WncwlBA+vY/pc2FuGuQ=;
        b=NaH2YRifYfDOG4sLSe0nOlUcBAytVbGgd1dX2oDX9irhwrBzW3zXOEyrge/eyRxfRS
         +ytcCYlHxdMLqvznjTf/DU2HIvH7li4oTgm6km69bBf5tvMweS8XAmKeDSPbBC74dvHF
         GMeFD+uwwaczOaa/lJn2DLIme+h1M/05vUfEiy4aTJkg9PUMnuXxOHO0DuNGTQ+1aWya
         pmlNSAdaBg1oV7pOQWVta4FYSKNUlsSAc8jUx8Roix8YcMUOk7bi2KZ2+WX2UNcjuO9w
         NPBqYKRO0R5oGK94F7/gbS710rqdeBXy0SP1Rf3CkwIk3kgNWF4i/wKEGP7I5Uj8mfwB
         0VMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=a4k5sbPFB7Mgl39AqQajFxJ0WncwlBA+vY/pc2FuGuQ=;
        b=0wcmVO0LMrjlTB4FL7ZGFc03mE8aQDWprd6EsqmsFdSlxi79MuKOWSRpcYaVk1KDgT
         yyZVXOU5Q9YH2OOWH6dqBtpUkGVwQD1Lu5og/lNF7VfsJofM11DOv1wcbwZTjvac0q+a
         l3Zav0WGA5olKWy/g3x8edm8XtJZRLzqUJmlDJVxZbmuhroDL7Mo02LyFlXx4CQSvy+h
         heOdL6OeRI9tQxxf3Scr4lDrVjQS7suYAqns8aRyCwjmtIZBNLVMxlgCV+4f1QrPm4ZC
         0rL2jXpjJwE4DYGdhcjoUtrURNhoS0p9vLzxL2JQjzOti1FFuflDJx7K3zf7WT04inUV
         yizw==
X-Gm-Message-State: AOAM533OboSDliOe8GLTxVlDAsaKRSN4/q4bae5HbJGwyd22/F7kyduF
        GxG6CdcpT4dP3YVyu2RiZonc7LrtNBdhow==
X-Google-Smtp-Source: ABdhPJzNAr7bQJxiSmbWztajQP3dB8GgZrrjaaoBs3KvGJKV1qPJ15NyR+3vAKW+TAjxFr9sWXz30w==
X-Received: by 2002:ac8:58c4:0:b0:2e1:cdbb:50da with SMTP id u4-20020ac858c4000000b002e1cdbb50damr10793954qta.334.1648232261827;
        Fri, 25 Mar 2022 11:17:41 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id t13-20020a05622a148d00b002e22f105099sm5932262qtx.21.2022.03.25.11.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:17:41 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nXoVH-0065Gp-Ql; Fri, 25 Mar 2022 15:17:39 -0300
Date:   Fri, 25 Mar 2022 15:17:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     mpenttil@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        apopple@nvidia.com, jhubbard@nvidia.com, rcampbell@nvidia.com,
        vbabka@suse.cz
Subject: Re: [PATCH v5] mm/hmm/test: use char dev with struct device to get
 device node
Message-ID: <20220325181739.GL64706@ziepe.ca>
References: <20220322043543.18424-1-mpenttil@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220322043543.18424-1-mpenttil@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 06:35:43AM +0200, mpenttil@redhat.com wrote:
> From: Mika Penttilä <mpenttil@redhat.com>
> 
> HMM selftests use an in-kernel pseudo device to emulate device private
> memory. The pseudo device registers a major device range for two pseudo
> device instances. User space has a script that reads /proc/devices in
> order to find the assigned major number, and sends that to mknod(1),
> once for each node.
> 
> Change this to properly use cdev and struct device APIs.
> 
> Delete the /proc/devices parsing from the user-space test script, now
> that it is unnecessary.
> 
> Also, deleted an unused field in struct dmirror_device: devmem.
> 
> Signed-off-by: Mika Penttilä <mpenttil@redhat.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> v5:
>         - fix whitespace
>         . delete unused structure field     
> v4:
>         - fix commit log
> v3:
>         - use cdev_device_add() instead of miscdevice
> v2:
>         - Cleanups per review comments from John Hubbard
>         - Added Tested-by and Ccs
> 
>  lib/test_hmm.c                         | 18 ++++++++++++++----
>  tools/testing/selftests/vm/test_hmm.sh |  6 ------
>  2 files changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/lib/test_hmm.c b/lib/test_hmm.c
> index 767538089a62..3c7f2a92b09e 100644
> +++ b/lib/test_hmm.c
> @@ -29,11 +29,17 @@
>  
>  #include "test_hmm_uapi.h"
>  
> -#define DMIRROR_NDEVICES		2
>  #define DMIRROR_RANGE_FAULT_TIMEOUT	1000
>  #define DEVMEM_CHUNK_SIZE		(256 * 1024 * 1024U)
>  #define DEVMEM_CHUNKS_RESERVE		16
>  
> +static const char *dmirror_device_names[] = {
> +	"hmm_dmirror0",
> +	"hmm_dmirror1"
> +};
> +
> +#define DMIRROR_NDEVICES ARRAY_SIZE(dmirror_device_names)
> +
>  static const struct dev_pagemap_ops dmirror_devmem_ops;
>  static const struct mmu_interval_notifier_ops dmirror_min_ops;
>  static dev_t dmirror_dev;
> @@ -83,7 +89,7 @@ struct dmirror_chunk {
>   */
>  struct dmirror_device {
>  	struct cdev		cdevice;
> -	struct hmm_devmem	*devmem;
> +	struct device		device;
>  
>  	unsigned int		devmem_capacity;
>  	unsigned int		devmem_count;
> @@ -1225,7 +1231,11 @@ static int dmirror_device_init(struct dmirror_device *mdevice, int id)
>  
>  	cdev_init(&mdevice->cdevice, &dmirror_fops);
>  	mdevice->cdevice.owner = THIS_MODULE;
> -	ret = cdev_add(&mdevice->cdevice, dev, 1);
> +	device_initialize(&mdevice->device);
> +	dev_set_name(&mdevice->device, "%s", dmirror_device_names[id]);

Just 
	dev_set_name(&mdevice->device, "hmm_dmirror%u", id);

No need for an array

Also check for error

Jason
