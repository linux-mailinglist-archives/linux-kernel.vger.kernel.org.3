Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DE25689B6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbiGFNkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiGFNku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:40:50 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE652317C;
        Wed,  6 Jul 2022 06:40:48 -0700 (PDT)
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LdLG35gX0z689K5;
        Wed,  6 Jul 2022 21:38:03 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Jul 2022 15:40:46 +0200
Received: from [10.126.171.66] (10.126.171.66) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Jul 2022 14:40:45 +0100
Message-ID: <b5f80062-e8ef-9597-1b0c-393140950dfb@huawei.com>
Date:   Wed, 6 Jul 2022 14:40:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v5 0/5] DMA mapping changes for SCSI core
To:     <damien.lemoal@opensource.wdc.com>, <joro@8bytes.org>,
        <will@kernel.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <hch@lst.de>,
        <m.szyprowski@samsung.com>, <robin.murphy@arm.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <iommu@lists.linux.dev>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1656590892-42307-1-git-send-email-john.garry@huawei.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <1656590892-42307-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.171.66]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/2022 13:08, John Garry wrote:

Hi Christoph,

Can you please consider picking up this series? A few things to note 
beforehand:

- I changed to only apply the mapping limit to SAS hosts in this 
version. I would need a fresh ack from Martin for those SCSI parts, but 
wanted to make sure you were ok with it.
- Damien had some doubt on updating the shost max_sectors as opposed to 
the per-request queue default, but I think he's ok with it - see patch 4/5

Thanks,
John


> As reported in [0], DMA mappings whose size exceeds the IOMMU IOVA caching
> limit may see a big performance hit.
> 
> This series introduces a new DMA mapping API, dma_opt_mapping_size(), so
> that drivers may know this limit when performance is a factor in the
> mapping.
> 
> The SCSI SAS transport code is modified only to use this limit. For now I
> did not want to touch other hosts as I have a concern that this change
> could cause a performance regression.
> 
> I also added a patch for libata-scsi as it does not currently honour the
> shost max_sectors limit.
> 
> [0]https://lore.kernel.org/linux-iommu/20210129092120.1482-1-thunder.leizhen@huawei.com/
> 
> Changes since v4:
> - tweak libata and other patch titles
> - Add Robin's tag (thanks!)
> - Clarify description of new DMA mapping API

