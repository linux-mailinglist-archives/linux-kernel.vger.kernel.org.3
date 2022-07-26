Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F573580BF8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 08:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237626AbiGZGzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 02:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbiGZGzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 02:55:37 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457ED766A;
        Mon, 25 Jul 2022 23:55:35 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LsSLJ3JLTzmVHK;
        Tue, 26 Jul 2022 14:53:44 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Jul 2022 14:55:00 +0800
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Jul 2022 14:55:00 +0800
Subject: Re: [PATCH v2 -next] ACPI/IORT: Fix build error
 implicit-function-declaration
To:     Ren Zhijie <renzhijie2@huawei.com>, <lpieralisi@kernel.org>,
        <sudeep.holla@arm.com>, <rafael@kernel.org>, <lenb@kernel.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jroedel@suse.de>,
        <robin.murphy@arm.com>
CC:     <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220726033520.47865-1-renzhijie2@huawei.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <bc4ec60d-3abf-efd9-6536-cec24c6b19ef@huawei.com>
Date:   Tue, 26 Jul 2022 14:54:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220726033520.47865-1-renzhijie2@huawei.com>
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

On 2022/7/26 11:35, Ren Zhijie wrote:
> If CONFIG_ACPI_IORT=y and CONFIG_IOMMU_API is not set,
> make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-,
> will be failed, like this:
> 
> drivers/acpi/arm64/iort.c: In function ‘iort_get_rmr_sids’:
> drivers/acpi/arm64/iort.c:1406:2: error: implicit declaration of function ‘iort_iommu_rmr_get_resv_regions’; did you mean ‘iort_iommu_get_resv_regions’? [-Werror=implicit-function-declaration]
>    iort_iommu_rmr_get_resv_regions(iommu_fwnode, NULL, head);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    iort_iommu_get_resv_regions
> cc1: some warnings being treated as errors
> make[3]: *** [drivers/acpi/arm64/iort.o] Error 1
> 
> The function iort_iommu_rmr_get_resv_regions()
> is declared under CONFIG_IOMMU_API,
> and the callers of iort_get_rmr_sids() and iort_put_rmr_sids()
> would select IOMMU_API.
> 
> To fix this error, move the definitions to #ifdef CONFIG_IOMMU_API.
> 
> Fixes: e302eea8f497 ("ACPI/IORT: Add a helper to retrieve RMR info directly")
> Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
> ---
> Changes in v2:
>   - change commit message to a max of 75 chars per line.
> 

Acked-by: Hanjun Guo <guohanjun@huawei.com>

Lorenzo, will this patch go via ARM64 tree?

Thanks
Hanjun

