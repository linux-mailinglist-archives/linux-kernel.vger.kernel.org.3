Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7024904DA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 10:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235703AbiAQJ2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 04:28:37 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4414 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbiAQJ2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 04:28:35 -0500
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jcmj71Jybz67jS1;
        Mon, 17 Jan 2022 17:25:31 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 17 Jan 2022 10:28:33 +0100
Received: from [10.47.83.126] (10.47.83.126) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 17 Jan
 2022 09:28:32 +0000
Subject: Re: [PATCH] scsi: hisi_sas: Remove useless DMA-32 fallback
 configuration
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>
References: <1bf2d3660178b0e6f172e5208bc0bd68d31d9268.1642237482.git.christophe.jaillet@wanadoo.fr>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b7e68ce9-cca0-a5d7-0bd6-82cf597b9619@huawei.com>
Date:   Mon, 17 Jan 2022 09:28:06 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <1bf2d3660178b0e6f172e5208bc0bd68d31d9268.1642237482.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.83.126]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/01/2022 09:05, Christophe JAILLET wrote:
> As stated in [1], dma_set_mask() with a 64-bit mask never fails if
> dev->dma_mask is non-NULL.
> So, if it fails, the 32 bits case will also fail for the same reason.
> 
> Simplify code and remove some dead code accordingly.
> 
> [1]: https://lore.kernel.org/linux-kernel/YL3vSPK5DXTNvgdx@infradead.org/#t
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Great, you got both callsites:

Acked-by: John Garry <john.garry@huawei.com>

> ---
>   drivers/scsi/hisi_sas/hisi_sas_main.c  | 3 ---
>   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 2 --
>   2 files changed, 5 deletions(-)
> 
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
> index a05ec7aece5a..2f53a2ee024a 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_main.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
> @@ -2666,9 +2666,6 @@ static struct Scsi_Host *hisi_sas_shost_alloc(struct platform_device *pdev,
>   		goto err_out;
>   
>   	error = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> -	if (error)
> -		error = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> -
>   	if (error) {
>   		dev_err(dev, "No usable DMA addressing method\n");
>   		goto err_out;
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> index a45ef9a5e12e..a01a3a7b706b 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> @@ -4695,8 +4695,6 @@ hisi_sas_v3_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   		goto err_out;
>   
>   	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> -	if (rc)
> -		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
>   	if (rc) {
>   		dev_err(dev, "No usable DMA addressing method\n");
>   		rc = -ENODEV;
> 

