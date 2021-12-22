Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E49547D535
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 17:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343866AbhLVQmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 11:42:55 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:43184 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhLVQmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 11:42:52 -0500
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 0C240803080B;
        Wed, 22 Dec 2021 19:42:40 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 0C240803080B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1640191362;
        bh=BfdxpmovsWOnIkoZeCNCwHay8UIDOjC/aJJWpZDrvMQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To:From;
        b=JpuG1wsluc1YKckkcAQvlZI4TbXkJysIvCTq10Bemmcgy+1OqWsjau4JHVQwitGgN
         xLAe0wJr1TxSeNDJ3tkk+VG33ERGRrl/lzvovnDzfmomrk8ww9zt3VlzwRW/a0izR+
         vKoGDwnv3hmRrEz+BZbepSZqFriMkq7utII2vqNU=
Received: from mobilestation (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 22 Dec 2021 19:42:24 +0300
Date:   Wed, 22 Dec 2021 19:42:40 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v2 2/3] spi: dw: Propagate firmware node
Message-ID: <20211222164240.cx2jq7kneb3p43lh@mobilestation>
References: <20211222155739.7699-1-andriy.shevchenko@linux.intel.com>
 <20211222155739.7699-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211222155739.7699-2-andriy.shevchenko@linux.intel.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 05:57:38PM +0200, Andy Shevchenko wrote:
> Propagate firmware node by using a specific API call, i.e. device_set_node().

Tested-by: Serge Semin <fancer.lancer@gmail.com>
Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: no changes
>  drivers/spi/spi-dw-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index 934cc7a922e8..ecea471ff42c 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -895,6 +895,8 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
>  	if (!master)
>  		return -ENOMEM;
>  
> +	device_set_node(&master->dev, dev_fwnode(dev));
> +
>  	dws->master = master;
>  	dws->dma_addr = (dma_addr_t)(dws->paddr + DW_SPI_DR);
>  
> @@ -931,8 +933,6 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
>  	if (dws->mem_ops.exec_op)
>  		master->mem_ops = &dws->mem_ops;
>  	master->max_speed_hz = dws->max_freq;
> -	master->dev.of_node = dev->of_node;
> -	master->dev.fwnode = dev->fwnode;
>  	master->flags = SPI_MASTER_GPIO_SS;
>  	master->auto_runtime_pm = true;
>  
> -- 
> 2.34.1
> 
