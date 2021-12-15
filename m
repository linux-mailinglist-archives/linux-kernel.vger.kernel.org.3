Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A367475168
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 04:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239592AbhLODhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 22:37:24 -0500
Received: from mail5.windriver.com ([192.103.53.11]:43924 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231547AbhLODhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 22:37:23 -0500
X-Greylist: delayed 1801 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Dec 2021 22:37:23 EST
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com [147.11.82.252])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 1BF375ts005794
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Dec 2021 19:07:05 -0800
Received: from [128.224.162.192] (128.224.162.192) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 14 Dec 2021 19:07:03 -0800
Subject: Re: [PATCH] Revert "spi: spi-zynqmp-gqspi: add mutex locking for
 exec_op"
To:     Tudor Ambarus <tudor.ambarus@microchip.com>, <broonie@kernel.org>,
        <amit.kumar-mahapatra@xilinx.com>
CC:     <michal.simek@xilinx.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20211214110152.48316-1-tudor.ambarus@microchip.com>
From:   Quanyang Wang <quanyang.wang@windriver.com>
Message-ID: <58864ce3-c925-6946-670b-60233b1653a5@windriver.com>
Date:   Wed, 15 Dec 2021 11:06:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211214110152.48316-1-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [128.224.162.192]
X-ClientProxiedBy: ala-exchng01.corp.ad.wrs.com (147.11.82.252) To
 ala-exchng01.corp.ad.wrs.com (147.11.82.252)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/14/21 7:01 PM, Tudor Ambarus wrote:
> This reverts commit a0f65be6e880a14d3445b75e7dc03d7d015fc922.
> 
> SPIMEM uses ctlr->bus_lock_mutex to prevent concurrency on
> ctlr->mem_ops->exec_op().
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Quanyang Wang <quanyang.wang@windriver.com>
> ---
>   drivers/spi/spi-zynqmp-gqspi.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
> index 328b6559bb19..189fe4eb59ad 100644
> --- a/drivers/spi/spi-zynqmp-gqspi.c
> +++ b/drivers/spi/spi-zynqmp-gqspi.c
> @@ -174,7 +174,6 @@ struct zynqmp_qspi {
>   	u32 genfifoentry;
>   	enum mode_type mode;
>   	struct completion data_completion;
> -	struct mutex op_lock;
>   };
>   
>   /**
> @@ -946,7 +945,6 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
>   		op->cmd.opcode, op->cmd.buswidth, op->addr.buswidth,
>   		op->dummy.buswidth, op->data.buswidth);
>   
> -	mutex_lock(&xqspi->op_lock);
>   	zynqmp_qspi_config_op(xqspi, mem->spi);
>   	zynqmp_qspi_chipselect(mem->spi, false);
>   	genfifoentry |= xqspi->genfifocs;
> @@ -1069,7 +1067,6 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
>   return_err:
>   
>   	zynqmp_qspi_chipselect(mem->spi, true);
> -	mutex_unlock(&xqspi->op_lock);
>   
>   	return err;
>   }
> @@ -1143,8 +1140,6 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
>   
>   	init_completion(&xqspi->data_completion);
>   
> -	mutex_init(&xqspi->op_lock);
> -
>   	pm_runtime_use_autosuspend(&pdev->dev);
>   	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
>   	pm_runtime_set_active(&pdev->dev);
> 
