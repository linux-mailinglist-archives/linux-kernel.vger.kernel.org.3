Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E683A564F37
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 10:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbiGDIBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 04:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiGDIBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 04:01:41 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F60AE59
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 01:01:40 -0700 (PDT)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Lbyqp2tV9z689F8;
        Mon,  4 Jul 2022 15:59:02 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Jul 2022 10:01:37 +0200
Received: from [10.195.35.180] (10.195.35.180) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Jul 2022 09:01:36 +0100
Message-ID: <d393f22f-4cf6-65ec-e24f-49d41b36e6ee@huawei.com>
Date:   Mon, 4 Jul 2022 09:01:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] bus: hisi_lpc: fix missing platform_device_put() in
 hisi_lpc_acpi_probe()
To:     Yang Yingliang <yangyingliang@huawei.com>,
        <linux-kernel@vger.kernel.org>
References: <20220701094352.2104998-1-yangyingliang@huawei.com>
CC:     "andriy.shevchenko@linux.intel.com >> Andy Shevchenko" 
        <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220701094352.2104998-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.35.180]
X-ClientProxiedBy: lhreml723-chm.china.huawei.com (10.201.108.74) To
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

On 01/07/2022 10:43, Yang Yingliang wrote:

+

Please send any updated version cc'ing Rafael, who kindly offered to 
pick up this patch

> In error case in hisi_lpc_acpi_probe() after calling platform_device_add(),
> hisi_lpc_acpi_remove() can't release the failed 'pdev', so it will be leak,
> call platform_device_put() to fix this problem.
> I'v constructed this error case and tested this patch on D05 board.
> 
> Fixes: 99c0228d6ff1 ("HISI LPC: Re-Add ACPI child enumeration support")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>   drivers/bus/hisi_lpc.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
> index 378f5d62a991..e7eaa8784fee 100644
> --- a/drivers/bus/hisi_lpc.c
> +++ b/drivers/bus/hisi_lpc.c
> @@ -503,13 +503,13 @@ static int hisi_lpc_acpi_probe(struct device *hostdev)
>   {
>   	struct acpi_device *adev = ACPI_COMPANION(hostdev);
>   	struct acpi_device *child;
> +	struct platform_device *pdev;

nit: please maintain reverse-firtree ordering

>   	int ret;
>   
>   	/* Only consider the children of the host */
>   	list_for_each_entry(child, &adev->children, node) {
>   		const char *hid = acpi_device_hid(child);
>   		const struct hisi_lpc_acpi_cell *cell;
> -		struct platform_device *pdev;
>   		const struct resource *res;
>   		bool found = false;
>   		int num_res;
> @@ -571,22 +571,24 @@ static int hisi_lpc_acpi_probe(struct device *hostdev)
>   
>   		ret = platform_device_add_resources(pdev, res, num_res);
>   		if (ret)
> -			goto fail;
> +			goto fail_put_device;
>   
>   		ret = platform_device_add_data(pdev, cell->pdata,
>   					       cell->pdata_size);
>   		if (ret)
> -			goto fail;
> +			goto fail_put_device;
>   
>   		ret = platform_device_add(pdev);
>   		if (ret)
> -			goto fail;
> +			goto fail_put_device;
>   
>   		acpi_device_set_enumerated(child);
>   	}
>   
>   	return 0;
>   
> +fail_put_device:
> +	platform_device_put(pdev);

is this enough? As I see, this invokes platform_device_release(), but we 
would still need platform_device_del() to drop the pdev resources. 
hisi_lpc_acpi_remove_subdev() calls platform_device_unregister(), so it 
seems proper to do that here also. Please check it.

Thanks,
John

>   fail:
>   	hisi_lpc_acpi_remove(hostdev);
>   	return ret;

