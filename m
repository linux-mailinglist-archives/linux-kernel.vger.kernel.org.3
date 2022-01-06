Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42CE0485D0A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 01:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343671AbiAFAV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 19:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343658AbiAFAVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 19:21:33 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D42DC061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 16:21:33 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id x15so1009292plg.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 16:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xITu+Sl6HGZM3hfuz383EKdEmD5eQ+z8hstuvM779TY=;
        b=OAvjblJQO7dn+Wcy2HITT8AYClcNypez8+gWKXde6g6mJCgv4KbI93J3eoRCU4B56N
         9SLuwmJsuo7DJrLOZBMGpmyL8vM+X4sZorM04vxv9DHbPqaAja61Cp1YGcPxN3T4SX2B
         zct7gQsTmDjwnL3pgZdN9YhJgVmiZkyvunnDsJpvgStvgZCSZzRQ+Hh+D9nCWKG0w66B
         pM80QrKgSrZg7eVIkTFlqtt78MVnXLv6MMOG8xhdRk0f/ZnBwBnKNVX1tydquwYaCq2T
         HoezipZ9FJIxdWvqhph2Vi73+SIQbgUdtaPw+4v8dL+oq5Ap2ROsUFPNr9eUpryVcj7c
         u/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xITu+Sl6HGZM3hfuz383EKdEmD5eQ+z8hstuvM779TY=;
        b=av13WFxTohF1yiUT/FGI6V5fbQNpz0VdBAEY2JiSR5UY1lwAIbBnyrzpzOq/wpCq7N
         WnhaqiJRC6z2G4eGbbPRqHPtwcYCE/aaJCZvdnoe0ULRPWb9pFLLKBYght8F+R6D0Htt
         fDGt1Y6WBX1pHO2OxG3/sXTXDXouKZbD3lz+j18O8hc6PtKKU96RvRRRrkGfOVMT53FN
         0WRXhaDvDzTtPBkCvj6asNnO0MypdK2/lqCyZPaALweDEG+jXWhvg3gwZB3Q6m6JFOB9
         5v+FUKrgW8tKuiE8Ke4ccfR3ZamvPEpMazJ1yORdZXyOUpS6GOLqEz7vWeV2i6hO3BpG
         QkJA==
X-Gm-Message-State: AOAM530XSHmNhguehvRK/bg8oPUuLiugn8Cftkp4cGXCpKN4IvtzbWeV
        cv1OR37whbBEvt7FJpqK4SS8Qg==
X-Google-Smtp-Source: ABdhPJyhnd5PPMXq0CHj4j4Ti7HT6F4a4gdJ/gX3frDajuRGvzQKc7YdcfBH3lJTQeZr6KEa7SY2GA==
X-Received: by 2002:a17:902:7207:b0:149:aefd:c08a with SMTP id ba7-20020a170902720700b00149aefdc08amr23201002plb.67.1641428492768;
        Wed, 05 Jan 2022 16:21:32 -0800 (PST)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id d17sm224369pfl.125.2022.01.05.16.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 16:21:32 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1n5GX4-00CDWN-DH; Wed, 05 Jan 2022 20:21:30 -0400
Date:   Wed, 5 Jan 2022 20:21:30 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Li Zhijian <lizhijian@cn.fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com,
        aharonl@nvidia.com, leon@kernel.org, linux-kernel@vger.kernel.org,
        mbloch@nvidia.com, liweihang@huawei.com, liangwenpeng@huawei.com,
        yangx.jy@cn.fujitsu.com, rpearsonhpe@gmail.com, y-goto@fujitsu.com
Subject: Re: [RFC PATCH rdma-next 01/10] RDMA: mr: Introduce is_pmem
Message-ID: <20220106002130.GP6467@ziepe.ca>
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
 <20211228080717.10666-2-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211228080717.10666-2-lizhijian@cn.fujitsu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2021 at 04:07:08PM +0800, Li Zhijian wrote:
> We can use it to indicate whether the registering mr is associated with
> a pmem/nvdimm or not.
> 
> Currently, we only assign it in rxe driver, for other device/drivers,
> they should implement it if needed.
> 
> RDMA FLUSH will support the persistence feature for a pmem/nvdimm.
> 
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
>  drivers/infiniband/sw/rxe/rxe_mr.c | 47 ++++++++++++++++++++++++++++++
>  include/rdma/ib_verbs.h            |  1 +
>  2 files changed, 48 insertions(+)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index 7c4cd19a9db2..bcd5e7afa475 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -162,6 +162,50 @@ void rxe_mr_init_dma(struct rxe_pd *pd, int access, struct rxe_mr *mr)
>  	mr->type = IB_MR_TYPE_DMA;
>  }
>  
> +// XXX: the logic is similar with mm/memory-failure.c
> +static bool page_in_dev_pagemap(struct page *page)
> +{
> +	unsigned long pfn;
> +	struct page *p;
> +	struct dev_pagemap *pgmap = NULL;
> +
> +	pfn = page_to_pfn(page);
> +	if (!pfn) {
> +		pr_err("no such pfn for page %p\n", page);
> +		return false;
> +	}
> +
> +	p = pfn_to_online_page(pfn);
> +	if (!p) {
> +		if (pfn_valid(pfn)) {
> +			pgmap = get_dev_pagemap(pfn, NULL);
> +			if (pgmap)
> +				put_dev_pagemap(pgmap);
> +		}
> +	}
> +
> +	return !!pgmap;

You need to get Dan to check this out, but I'm pretty sure this should
be more like this:

if (is_zone_device_page(page) && page->pgmap->type == MEMORY_DEVICE_FS_DAX)


> +static bool iova_in_pmem(struct rxe_mr *mr, u64 iova, int length)
> +{
> +	struct page *page = NULL;
> +	char *vaddr = iova_to_vaddr(mr, iova, length);
> +
> +	if (!vaddr) {
> +		pr_err("not a valid iova %llu\n", iova);
> +		return false;
> +	}
> +
> +	page = virt_to_page(vaddr);

And obviously this isn't uniform for the entire umem, so I don't even
know what this is supposed to mean.

> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 6e9ad656ecb7..822ebb3425dc 100644
> +++ b/include/rdma/ib_verbs.h
> @@ -1807,6 +1807,7 @@ struct ib_mr {
>  	unsigned int	   page_size;
>  	enum ib_mr_type	   type;
>  	bool		   need_inval;
> +	bool		   is_pmem;

Or why it is being stored in the global struct?

Jason
