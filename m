Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A704A4CB8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 18:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380696AbiAaRGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 12:06:44 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4576 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236802AbiAaRGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 12:06:41 -0500
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JnZBT0rMfz67Pf9;
        Tue,  1 Feb 2022 01:02:57 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Mon, 31 Jan 2022 18:06:39 +0100
Received: from [10.47.91.239] (10.47.91.239) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 31 Jan
 2022 17:06:39 +0000
Subject: Re: [PATCH] iommu/amd: Fix loop timeout issue in
 iommu_ga_log_enable()
To:     Joerg Roedel <joro@8bytes.org>, <iommu@lists.linux-foundation.org>
CC:     Joerg Roedel <jroedel@suse.de>, <linux-kernel@vger.kernel.org>,
        "Maxim Levitsky" <mlevitsk@redhat.com>,
        Will Deacon <will@kernel.org>
References: <20220131161749.4021-1-joro@8bytes.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <48a674ae-f5cd-fc06-4505-6d863e6dad69@huawei.com>
Date:   Mon, 31 Jan 2022 17:06:03 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20220131161749.4021-1-joro@8bytes.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.91.239]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/2022 16:17, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The polling loop for the register change in iommu_ga_log_enable() needs
> to have a udelay() in it.  Otherwise the CPU might be faster than the
> IOMMU hardware and wrongly trigger the WARN_ON() further down the code
> stream.
> 
> Fixes: 8bda0cfbdc1a ("iommu/amd: Detect and initialize guest vAPIC log")
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>   drivers/iommu/amd/init.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index dc338acf3338..d2e09d53851f 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -834,6 +834,7 @@ static int iommu_ga_log_enable(struct amd_iommu *iommu)
>   		status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
>   		if (status & (MMIO_STATUS_GALOG_RUN_MASK))
>   			break;
> +		udelay(1);

Maybe readl_relaxed_poll_timeout_atomic() could be used instead

Thanks,
John

>   	}
>   
>   	if (WARN_ON(i >= LOOP_TIMEOUT))
> 

