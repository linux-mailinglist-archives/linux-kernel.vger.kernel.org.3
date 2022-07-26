Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1FD5809AB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 04:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbiGZCxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 22:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiGZCx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 22:53:29 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4552A6160;
        Mon, 25 Jul 2022 19:53:28 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LsLwY3G6tzWfCw;
        Tue, 26 Jul 2022 10:49:33 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Jul 2022 10:53:26 +0800
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Jul 2022 10:53:25 +0800
Subject: Re: [PATCH -next] ACPI/IORT: Fix build error
 implicit-function-declaration
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        renzhijie <renzhijie2@huawei.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "jroedel@suse.de" <jroedel@suse.de>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lorenzo.pieralisi@linaro.org" <lorenzo.pieralisi@linaro.org>
References: <20220724115423.212932-1-renzhijie2@huawei.com>
 <d59bc043788e4dc796a445588d667ab7@huawei.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <078d74b2-151e-4b4a-55fc-9cd8f6fb910c@huawei.com>
Date:   Tue, 26 Jul 2022 10:53:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <d59bc043788e4dc796a445588d667ab7@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.247]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/25 21:50, Shameerali Kolothum Thodi wrote:
[...]
>>
>> If CONFIG_ACPI_IORT=y and CONFIG_IOMMU_API is not set,
>> make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-, will be failed, like
>> this:
>>
>> drivers/acpi/arm64/iort.c: In function ‘iort_get_rmr_sids’:
>> drivers/acpi/arm64/iort.c:1406:2: error: implicit declaration of function
>> ‘iort_iommu_rmr_get_resv_regions’; did you mean
>> ‘iort_iommu_get_resv_regions’? [-Werror=implicit-function-declaration]
>>    iort_iommu_rmr_get_resv_regions(iommu_fwnode, NULL, head);
>>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    iort_iommu_get_resv_regions
>> cc1: some warnings being treated as errors
>> make[3]: *** [drivers/acpi/arm64/iort.o] Error 1
> 
> Thanks for spotting this.
> 
>> The function iort_iommu_rmr_get_resv_regions() is declared at #ifdef
>> CONFIG_IOMMU_API area, and the callers of  iort_get_rmr_sids() and
>> iort_put_rmr_sids() would select IOMMU_API.
>> To fix this error, move the definitions to #ifdef CONFIG_IOMMU_API area.
> 
> That makes sense. And the only callers of these are SMMU drivers I think we
> don't need stub functions under !CONFIG_IOMMU_API(Lorenzo, could you
> please double check this).

I think so, because SMMU drivers will select IOMMU_API,
in drivers/iommu/Kconfig, it says:

# IOMMU_API always gets selected by whoever wants it. 

config IOMMU_API 

bool

> 
> Nit: Please wrap the commit description to a max of 75 chars per line.

Zhijie, would you mind send a updated version?

Thanks
Hanjun
