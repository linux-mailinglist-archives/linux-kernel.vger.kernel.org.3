Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE79C4B0C74
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 12:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241023AbiBJLh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 06:37:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235635AbiBJLh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 06:37:27 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9F81001
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 03:37:28 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JvZT42pQKzcckG;
        Thu, 10 Feb 2022 19:36:24 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Feb 2022 19:37:24 +0800
Subject: Re: [PATCH 01/27] mm: remove a pointless CONFIG_ZONE_DEVICE check in
 memremap_pages
To:     Christoph Hellwig <hch@lst.de>
CC:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Alistair Popple <apopple@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <20220210072828.2930359-1-hch@lst.de>
 <20220210072828.2930359-2-hch@lst.de>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <fcd1848f-19af-6572-942f-bdcd51bf143c@huawei.com>
Date:   Thu, 10 Feb 2022 19:37:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220210072828.2930359-2-hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/2/10 15:28, Christoph Hellwig wrote:
> memremap.c is only built when CONFIG_ZONE_DEVICE is set, so remove
> the superflous extra check.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  mm/memremap.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/memremap.c b/mm/memremap.c
> index 6aa5f0c2d11fda..5f04a0709e436e 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -328,8 +328,7 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
>  		}
>  		break;
>  	case MEMORY_DEVICE_FS_DAX:
> -		if (!IS_ENABLED(CONFIG_ZONE_DEVICE) ||
> -		    IS_ENABLED(CONFIG_FS_DAX_LIMITED)) {
> +		if (IS_ENABLED(CONFIG_FS_DAX_LIMITED)) {
>  			WARN(1, "File system DAX not supported\n");
>  			return ERR_PTR(-EINVAL);
>  		}
> 

LGTM. Thanks.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
