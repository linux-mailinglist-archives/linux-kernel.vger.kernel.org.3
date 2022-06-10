Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21B654697D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 17:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbiFJPiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 11:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233903AbiFJPiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 11:38:03 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0938326562F;
        Fri, 10 Jun 2022 08:37:58 -0700 (PDT)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LKQ2n144hz689ML;
        Fri, 10 Jun 2022 23:33:05 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 10 Jun 2022 17:37:56 +0200
Received: from [10.47.88.201] (10.47.88.201) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 10 Jun
 2022 16:37:55 +0100
Message-ID: <f7872ebc-dfe5-d977-c51f-91b73e6d1fbb@huawei.com>
Date:   Fri, 10 Jun 2022 16:37:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 3/4] scsi: core: Cap shost max_sectors according to DMA
 optimum mapping limits
To:     Bart Van Assche <bvanassche@acm.org>,
        <damien.lemoal@opensource.wdc.com>, <joro@8bytes.org>,
        <will@kernel.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <hch@lst.de>,
        <m.szyprowski@samsung.com>, <robin.murphy@arm.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linux-scsi@vger.kernel.org>, <liyihang6@hisilicon.com>,
        <chenxiang66@hisilicon.com>, <thunder.leizhen@huawei.com>
References: <1654507822-168026-1-git-send-email-john.garry@huawei.com>
 <1654507822-168026-4-git-send-email-john.garry@huawei.com>
 <fe365aa8-00d5-153d-ceb2-f887a71a6927@acm.org>
 <31417477-953d-283e-808e-cf8701e820a8@huawei.com>
 <bccbcc9b-4750-a1a7-130f-69eeea5dcb23@acm.org>
 <5b214e95-dd95-551a-496e-a2139a74e8eb@huawei.com>
 <a2585983-75d7-c627-13ba-38a464cf716e@acm.org>
 <9b1d155e-28cc-08dc-5a5a-8580132575e7@huawei.com>
 <23bf4427-41c3-bf1d-903a-75928bb47627@acm.org>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <23bf4427-41c3-bf1d-903a-75928bb47627@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.88.201]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2022 21:34, Bart Van Assche wrote:
> On 6/9/22 10:54, John Garry wrote:
>> ok, but do you have a system where the UFS host controller is behind 
>> an IOMMU? I had the impression that UFS controllers would be mostly 
>> found in embedded systems and IOMMUs are not as common on there.
> 
> Modern phones have an IOMMU. Below one can find an example from a Pixel 
> 6 phone. The UFS storage controller is not controller by the IOMMU as 
> far as I can see but I wouldn't be surprised if the security team would 
> ask us one day to enable the IOMMU for the UFS controller.

OK, then unfortunately it seems that you have no method to test. I might 
be able to test USB MSC but I am not even sure if I can even get DMA 
mappings who length exceeds the IOVA rcache limit there.

Thanks,
John
