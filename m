Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C9D56718D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbiGEOwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiGEOwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:52:03 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AEFA3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 07:52:02 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Lcltm6k9hz689P2;
        Tue,  5 Jul 2022 22:49:20 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Tue, 5 Jul 2022 16:52:00 +0200
Received: from [10.126.171.232] (10.126.171.232) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2375.24; Tue, 5 Jul 2022 15:51:59 +0100
Message-ID: <f85d13df-b3b9-5cde-6f4c-a68507cedee9@huawei.com>
Date:   Tue, 5 Jul 2022 15:51:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v1 4/4] bus: hisi_lpc: Don't guard ACPI IDs with
 ACPI_PTR()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        <linux-kernel@vger.kernel.org>
References: <20220705114312.86164-1-andriy.shevchenko@linux.intel.com>
 <20220705114312.86164-4-andriy.shevchenko@linux.intel.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220705114312.86164-4-andriy.shevchenko@linux.intel.com>
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
> The OF is not guarded neither ACPI needs.

This doesn't read well.

> The IDs do not depend
> to the configuration. Hence drop ACPI_PTR() from the code and
> move ID table closer to its user.

Do you need to explicitly include mod_devicetable.h, which has the 
definition of acpi_device_id?

I saw a similar change for another driver and it was claimed that 
including mod_devicetable.h was required.

Thanks,
John

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/bus/hisi_lpc.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
> index a6513a571d7b..74f4448bff9d 100644
> --- a/drivers/bus/hisi_lpc.c
> +++ b/drivers/bus/hisi_lpc.c
> @@ -589,11 +589,6 @@ static int hisi_lpc_acpi_probe(struct device *hostdev)
>   
>   	return ret;
>   }
> -
> -static const struct acpi_device_id hisi_lpc_acpi_match[] = {
> -	{"HISI0191"},
> -	{}
> -};
>   #else
>   static int hisi_lpc_acpi_probe(struct device *dev)
>   {
> @@ -688,11 +683,16 @@ static const struct of_device_id hisi_lpc_of_match[] = {
>   	{}
>   };
>   
> +static const struct acpi_device_id hisi_lpc_acpi_match[] = {
> +	{"HISI0191"},
> +	{}
> +};
> +
>   static struct platform_driver hisi_lpc_driver = {
>   	.driver = {
>   		.name           = DRV_NAME,
>   		.of_match_table = hisi_lpc_of_match,
> -		.acpi_match_table = ACPI_PTR(hisi_lpc_acpi_match),
> +		.acpi_match_table = hisi_lpc_acpi_match,
>   	},
>   	.probe = hisi_lpc_probe,
>   	.remove = hisi_lpc_remove,

