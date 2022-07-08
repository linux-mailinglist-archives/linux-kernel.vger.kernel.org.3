Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC45D56BEEC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238522AbiGHQRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238559AbiGHQRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:17:13 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5026F7B367;
        Fri,  8 Jul 2022 09:17:11 -0700 (PDT)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Lfdbm5bSbz686M3;
        Sat,  9 Jul 2022 00:12:52 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 8 Jul 2022 18:17:08 +0200
Received: from [10.195.34.23] (10.195.34.23) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 8 Jul
 2022 17:17:07 +0100
Message-ID: <5fd4814a-81b1-0e71-58e0-57a747eb684e@huawei.com>
Date:   Fri, 8 Jul 2022 17:17:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v5 0/5] DMA mapping changes for SCSI core
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>
CC:     <damien.lemoal@opensource.wdc.com>, <joro@8bytes.org>,
        <will@kernel.org>, <jejb@linux.ibm.com>,
        <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <iommu@lists.linux.dev>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1656590892-42307-1-git-send-email-john.garry@huawei.com>
 <b5f80062-e8ef-9597-1b0c-393140950dfb@huawei.com>
 <20220706134447.GA23753@lst.de> <yq1y1x47jgn.fsf@ca-mkp.ca.oracle.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <yq1y1x47jgn.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.195.34.23]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
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

On 07/07/2022 21:35, Martin K. Petersen wrote:
> Christoph,
> 
>> Yes, I've mostly been waiting for an ACK from Martin.
> Sorry, I'm on vacation this week. The series looks OK to me although I
> do agree that it would be great if the max was reflected in the queue's
> hard limit and opt in the soft limit.

Ah, I think that I misunderstood Damien's question. I thought he was 
asking why not keep shost max_sectors at dma_max_mapping_size() and then 
init each sdev request queue max hw sectors at dma_opt_mapping_size().

But he seems that you want to know why not have the request queue max 
sectors at dma_opt_mapping_size(). The answer is related to meaning of 
dma_opt_mapping_size(). If we get any mappings which exceed this size 
then it can have a big dma mapping performance hit. So I set max hw 
sectors at this ‘opt’ mapping size to ensure that we get no mappings 
which exceed this size. Indeed, I think max sectors is 128Kb today for 
my host, which would be same as dma_opt_mapping_size() value with an 
IOMMU enabled. And I find that only a small % of request size may exceed 
this 128kb size, but it still has a big performance impact.

> 
> Acked-by: Martin K. Petersen<martin.petersen@oracle.com>

Thanks,
John
