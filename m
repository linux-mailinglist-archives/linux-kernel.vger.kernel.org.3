Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E24E48BD47
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 03:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348724AbiALC2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 21:28:40 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:17340 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348713AbiALC2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 21:28:39 -0500
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JYWg547Nzz9s7h;
        Wed, 12 Jan 2022 10:27:29 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 12 Jan 2022 10:28:37 +0800
Received: from [10.174.178.220] (10.174.178.220) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 12 Jan 2022 10:28:36 +0800
Subject: Re: [PATCH] scsi: Do not break scan luns loop if add single lun
 failed
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        Wenchao Hao <haowenchao@huawei.com>
References: <20211225232911.1117843-1-haowenchao@huawei.com>
From:   Wenchao Hao <haowenchao@huawei.com>
Message-ID: <5ec37028-052c-3851-6a89-983ab5ed4ae2@huawei.com>
Date:   Wed, 12 Jan 2022 10:28:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20211225232911.1117843-1-haowenchao@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/26 7:29, Wenchao Hao wrote:
> Failed to add a single lun does not mean all luns are unaccessible,
> if we break the scan luns loop, the other luns reported by REPORT LUNS
> command would not be probed any more.
> 
> In this case, we might loss some luns which are accessible.
> 
> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
> ---
>   drivers/scsi/scsi_scan.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
> index 23e1c0acdeae..fee7ce082103 100644
> --- a/drivers/scsi/scsi_scan.c
> +++ b/drivers/scsi/scsi_scan.c
> @@ -1476,13 +1476,13 @@ static int scsi_report_lun_scan(struct scsi_target *starget, blist_flags_t bflag
>   				lun, NULL, NULL, rescan, NULL);
>   			if (res == SCSI_SCAN_NO_RESPONSE) {
>   				/*
> -				 * Got some results, but now none, abort.
> +				 * Got some results, but now none, abort this lun
>   				 */
>   				sdev_printk(KERN_ERR, sdev,
>   					"Unexpected response"
>   					" from lun %llu while scanning, scan"
>   					" aborted\n", (unsigned long long)lun);
> -				break;
> +				continue;
>   			}
>   		}
>   	}
> 

ping ...
