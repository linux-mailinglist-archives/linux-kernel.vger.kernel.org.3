Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF45531023
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbiEWL4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235177AbiEWL42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:56:28 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7108921BA;
        Mon, 23 May 2022 04:56:23 -0700 (PDT)
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L6G0N6q73z67njv;
        Mon, 23 May 2022 19:52:20 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 23 May 2022 13:56:20 +0200
Received: from [10.47.87.6] (10.47.87.6) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 23 May
 2022 12:56:19 +0100
Message-ID: <42350b3a-193f-a1a0-3ef7-13643e1101f0@huawei.com>
Date:   Mon, 23 May 2022 12:56:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 3/4] scsi: core: Cap shost max_sectors according to DMA
 optimum mapping limits
To:     Dan Carpenter <dan.carpenter@oracle.com>, <kbuild@lists.01.org>,
        <damien.lemoal@opensource.wdc.com>, <joro@8bytes.org>,
        <will@kernel.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <hch@lst.de>,
        <m.szyprowski@samsung.com>, <robin.murphy@arm.com>
CC:     <lkp@intel.com>, <kbuild-all@lists.01.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linux-scsi@vger.kernel.org>, <liyihang6@hisilicon.com>,
        <chenxiang66@hisilicon.com>, <thunder.leizhen@huawei.com>
References: <202205210545.gkS834ds-lkp@intel.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <202205210545.gkS834ds-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.87.6]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2022 12:08, Dan Carpenter wrote:

Thanks for the report

> 50b6cb3516365c Dexuan Cui        2021-10-07  224  	/* Use min_t(int, ...) in case shost->can_queue exceeds SHRT_MAX */
> 50b6cb3516365c Dexuan Cui        2021-10-07  225  	shost->cmd_per_lun = min_t(int, shost->cmd_per_lun,
> ea2f0f77538c50 John Garry        2021-05-19  226  				   shost->can_queue);
> ea2f0f77538c50 John Garry        2021-05-19  227
> 2ad7ba6ca08593 John Garry        2022-05-20 @228  	if (dma_dev->dma_mask) {
>                                                              ^^^^^^^^^^^^^^^^^

I knew that we fixed up dma_dev to be non-NULL, but I thought it was 
earlier in this function...

> The patch adds a new unchecked dereference
> 
> 2ad7ba6ca08593 John Garry        2022-05-20  229  		shost->max_sectors = min_t(unsigned int, shost->max_sectors,
> 2ad7ba6ca08593 John Garry        2022-05-20  230  				dma_opt_mapping_size(dma_dev) >> SECTOR_SHIFT);
> 2ad7ba6ca08593 John Garry        2022-05-20  231  	}
> 2ad7ba6ca08593 John Garry        2022-05-20  232
> 0a6ac4ee7c2109 Christoph Hellwig 2017-01-03  233  	error = scsi_init_sense_cache(shost);
> 0a6ac4ee7c2109 Christoph Hellwig 2017-01-03  234  	if (error)
> 0a6ac4ee7c2109 Christoph Hellwig 2017-01-03  235  		goto fail;
> 0a6ac4ee7c2109 Christoph Hellwig 2017-01-03  236
> d285203cf647d7 Christoph Hellwig 2014-01-17  237  	error = scsi_mq_setup_tags(shost);
> 542bd1377a9630 James Bottomley   2008-04-21  238  	if (error)
> 542bd1377a9630 James Bottomley   2008-04-21  239  		goto fail;
> d285203cf647d7 Christoph Hellwig 2014-01-17  240
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  241  	if (!shost->shost_gendev.parent)
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  242  		shost->shost_gendev.parent = dev ? dev : &platform_bus;
> 3c8d9a957d0ae6 James Bottomley   2012-05-04 @243  	if (!dma_dev)
>                                                              ^^^^^^^^

Cheers,
John
