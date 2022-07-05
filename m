Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F203C567212
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbiGEPFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbiGEPEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:04:36 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1270E15A3E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 08:02:25 -0700 (PDT)
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Lcm8b5hBbz6GD7R;
        Tue,  5 Jul 2022 23:01:19 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 5 Jul 2022 17:02:22 +0200
Received: from [10.126.171.232] (10.126.171.232) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2375.24; Tue, 5 Jul 2022 16:02:22 +0100
Message-ID: <ee6b33f5-c5c0-658e-8cf9-61031cd27dca@huawei.com>
Date:   Tue, 5 Jul 2022 16:02:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v1 1/4] bus: hisi_lpc: Don't dereference fwnode handle
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        <linux-kernel@vger.kernel.org>
References: <20220705114312.86164-1-andriy.shevchenko@linux.intel.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220705114312.86164-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.171.232]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
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

On 05/07/2022 12:43, Andy Shevchenko wrote:
> Use dev_fwnode() and acpi_fwnode_handle() instead of dereferencing
> an fwnode handle directly.

...which is a better coding practice, right? If so, it would be nice to 
mention it - well at least I think so.

> 
> While at it, reuse fwnode instead of ACPI_COMPANION().

Apart from above and nit, below:
Acked-by: John Garry <john.garry@huawei.com>

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/bus/hisi_lpc.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
> index 2e564803e786..6d432a07cbba 100644
> --- a/drivers/bus/hisi_lpc.c
> +++ b/drivers/bus/hisi_lpc.c
> @@ -347,7 +347,7 @@ static int hisi_lpc_acpi_xlat_io_res(struct acpi_device *adev,
>   	unsigned long sys_port;
>   	resource_size_t len = resource_size(res);
>   
> -	sys_port = logic_pio_trans_hwaddr(&host->fwnode, res->start, len);
> +	sys_port = logic_pio_trans_hwaddr(acpi_fwnode_handle(host), res->start, len);

nit: currently the driver keeps to the old 80 character line limit. 
While the rules may have been relaxed, I'd rather we still maintain it.

>   	if (sys_port == ~0UL)
>   		return -EFAULT;
>   
> @@ -615,7 +615,6 @@ static void hisi_lpc_acpi_remove(struct device *hostdev)
>   static int hisi_lpc_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> -	struct acpi_device *acpi_device = ACPI_COMPANION(dev);
>   	struct logic_pio_hwaddr *range;
>   	struct hisi_lpc_dev *lpcdev;
>   	resource_size_t io_end;
> @@ -637,7 +636,7 @@ static int hisi_lpc_probe(struct platform_device *pdev)
>   	if (!range)
>   		return -ENOMEM;
>   
> -	range->fwnode = dev->fwnode;
> +	range->fwnode = dev_fwnode(dev);
>   	range->flags = LOGIC_PIO_INDIRECT;
>   	range->size = PIO_INDIRECT_SIZE;
>   	range->hostdata = lpcdev;
> @@ -651,7 +650,7 @@ static int hisi_lpc_probe(struct platform_device *pdev)
>   	}
>   
>   	/* register the LPC host PIO resources */
> -	if (acpi_device)
> +	if (is_acpi_device_node(range->fwnode))
>   		ret = hisi_lpc_acpi_probe(dev);
>   	else
>   		ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
> @@ -672,11 +671,10 @@ static int hisi_lpc_probe(struct platform_device *pdev)
>   static int hisi_lpc_remove(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> -	struct acpi_device *acpi_device = ACPI_COMPANION(dev);
>   	struct hisi_lpc_dev *lpcdev = dev_get_drvdata(dev);
>   	struct logic_pio_hwaddr *range = lpcdev->io_host;
>   
> -	if (acpi_device)
> +	if (is_acpi_device_node(range->fwnode))
>   		hisi_lpc_acpi_remove(dev);
>   	else
>   		of_platform_depopulate(dev);

