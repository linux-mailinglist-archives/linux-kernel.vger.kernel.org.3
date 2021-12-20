Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2561147A799
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 11:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhLTKPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 05:15:23 -0500
Received: from mxout01.lancloud.ru ([45.84.86.81]:59048 "EHLO
        mxout01.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbhLTKPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 05:15:23 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 4DF6B20E24DD
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Message-ID: <cdec6cde-1734-e605-103d-66dbec0ec2ae@omp.ru>
Date:   Mon, 20 Dec 2021 13:15:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] USB: host: Check for null res pointer
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, <ok@artecdesign.ee>,
        <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211220064946.817004-1-jiasheng@iscas.ac.cn>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <20211220064946.817004-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 20.12.2021 9:49, Jiasheng Jiang wrote:

> The return value of platform_get_resource() needs to be checked.
> To avoid use of error pointer in case of the failure of alloc.
> 
> Fixes: 4808a1c02611 ("[PATCH] USB: Add isp116x-hcd USB host controller driver")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>   drivers/usb/host/isp116x-hcd.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/usb/host/isp116x-hcd.c b/drivers/usb/host/isp116x-hcd.c
> index 8835f6bd528e..addd2b43a14c 100644
> --- a/drivers/usb/host/isp116x-hcd.c
> +++ b/drivers/usb/host/isp116x-hcd.c
> @@ -1541,9 +1541,15 @@ static int isp116x_remove(struct platform_device *pdev)
>   
>   	iounmap(isp116x->data_reg);
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (!res)
> +		return -EINVAL;
> +
>   	release_mem_region(res->start, 2);
>   	iounmap(isp116x->addr_reg);
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -EINVAL;

    Hm, these usually are reported as -ENODEV, no?

[...]

MBR, Sergey
