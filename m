Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFFF4EA89A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 09:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbiC2HjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 03:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiC2Hi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 03:38:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BE548388;
        Tue, 29 Mar 2022 00:37:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2FC661554;
        Tue, 29 Mar 2022 07:37:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C80BC340ED;
        Tue, 29 Mar 2022 07:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648539435;
        bh=+etXV8lANDE8ZS57f0zCn3WwYkPsh0BB3chSoBhHPDk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TCyEpZUpEGLqePzgXmHk89RG4p4AdNes/ZGbDlmoMyPOpbEISigo1OSFIeg5TaFHx
         zbtM/4mu5R+lka88E/TGn4fb+Pgm2gjIA+NDb8o6/LfTkVp/+LGIu7/Q/NYF2M/giP
         dO5Lffhd3XOAMcJTzFM9CKRcnsAvxujMee4Wp90Lvz0FlOrC7C6iB4jJvpavzxXj8z
         J4wTzlm/UowGn0gbqTc5TTsaEjN3z1w0KNxgyc/e0m3WgE8b9YlHJu5CtQ+KBNW8/h
         T0XS/a4GmO8+bvBp7aXzMbwCpSyRuTNxgG6jflHuKYAAqp++pFr+ddm+7lNrP4RarZ
         ck5SK7AzqiI+A==
Message-ID: <c9b0b3e5-28f3-67a2-6456-d63f3232e432@kernel.org>
Date:   Tue, 29 Mar 2022 10:37:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/2] memory: omap-gpmc: Allow building as a module
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     miquel.raynal@bootlin.com, tony@atomide.com, vigneshr@ti.com,
        kishon@ti.com, nm@ti.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220328111319.1236-1-rogerq@kernel.org>
 <20220328111319.1236-3-rogerq@kernel.org>
 <8a55260d-7354-028b-8439-475a9fbfe092@kernel.org>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <8a55260d-7354-028b-8439-475a9fbfe092@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 28/03/2022 16:11, Krzysztof Kozlowski wrote:
> On 28/03/2022 13:13, Roger Quadros wrote:
>> Allow OMAP_GPMC to be built as a module.
>>
>> Remove redundant of_match_node() call before
>> of_platform_default_populate() as the latter takes
>> care of matching with of_default_bus_match_table.
> 
> Split this part to separate commit, please. It does not look related to
> making it a module.

Actually it is related. Without that change build fails
as it cannot find symbol 'of_default_bus_match_table'

Maybe I'll mention it in commit log.

> 
>>
>> Move compatible match table to the end where it is usually expected.
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>  drivers/memory/Kconfig     |  2 +-
>>  drivers/memory/omap-gpmc.c | 44 +++++++++++++++++++++-----------------
>>  2 files changed, 25 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
>> index da2af9c38fe3..4debd4b2c8da 100644
>> --- a/drivers/memory/Kconfig
>> +++ b/drivers/memory/Kconfig
>> @@ -103,7 +103,7 @@ config TI_EMIF
>>  	  temperature changes
>>  
>>  config OMAP_GPMC
>> -	bool "Texas Instruments OMAP SoC GPMC driver"
>> +	tristate "Texas Instruments OMAP SoC GPMC driver"
>>  	depends on OF_ADDRESS || COMPILE_TEST
>>  	select GPIOLIB
>>  	help
>> diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
>> index ed11887c1b7c..6fdb76cc3bc9 100644
>> --- a/drivers/memory/omap-gpmc.c
>> +++ b/drivers/memory/omap-gpmc.c
>> @@ -12,6 +12,7 @@
>>  #include <linux/cpu_pm.h>
>>  #include <linux/irq.h>
>>  #include <linux/kernel.h>
>> +#include <linux/module.h>
>>  #include <linux/init.h>
>>  #include <linux/err.h>
>>  #include <linux/clk.h>
>> @@ -1889,16 +1890,6 @@ int gpmc_cs_program_settings(int cs, struct gpmc_settings *p)
>>  }
>>  
>>  #ifdef CONFIG_OF
>> -static const struct of_device_id gpmc_dt_ids[] = {
>> -	{ .compatible = "ti,omap2420-gpmc" },
>> -	{ .compatible = "ti,omap2430-gpmc" },
>> -	{ .compatible = "ti,omap3430-gpmc" },	/* omap3430 & omap3630 */
>> -	{ .compatible = "ti,omap4430-gpmc" },	/* omap4430 & omap4460 & omap543x */
>> -	{ .compatible = "ti,am3352-gpmc" },	/* am335x devices */
>> -	{ .compatible = "ti,am64-gpmc" },
>> -	{ }
>> -};
>> -
>>  static void gpmc_cs_set_name(int cs, const char *name)
>>  {
>>  	struct gpmc_cs_data *gpmc = &gpmc_cs[cs];
>> @@ -2257,11 +2248,9 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
>>  	if (!of_platform_device_create(child, NULL, &pdev->dev))
>>  		goto err_child_fail;
>>  
>> -	/* is child a common bus? */
>> -	if (of_match_node(of_default_bus_match_table, child))
>> -		/* create children and other common bus children */
>> -		if (of_platform_default_populate(child, NULL, &pdev->dev))
>> -			goto err_child_fail;
>> +	/* create children and other common bus children */
>> +	if (of_platform_default_populate(child, NULL, &pdev->dev))
>> +		goto err_child_fail;
>>  
>>  	return 0;
>>  
>> @@ -2278,6 +2267,8 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
>>  	return ret;
>>  }
>>  
>> +static const struct of_device_id gpmc_dt_ids[];
>> +
>>  static int gpmc_probe_dt(struct platform_device *pdev)
>>  {
>>  	int ret;
>> @@ -2644,6 +2635,19 @@ static int gpmc_resume(struct device *dev)
>>  
>>  static SIMPLE_DEV_PM_OPS(gpmc_pm_ops, gpmc_suspend, gpmc_resume);
>>  
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id gpmc_dt_ids[] = {
>> +	{ .compatible = "ti,omap2420-gpmc" },
>> +	{ .compatible = "ti,omap2430-gpmc" },
>> +	{ .compatible = "ti,omap3430-gpmc" },	/* omap3430 & omap3630 */
>> +	{ .compatible = "ti,omap4430-gpmc" },	/* omap4430 & omap4460 & omap543x */
>> +	{ .compatible = "ti,am3352-gpmc" },	/* am335x devices */
>> +	{ .compatible = "ti,am64-gpmc" },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, gpmc_dt_ids);
>> +#endif
>> +
>>  static struct platform_driver gpmc_driver = {
>>  	.probe		= gpmc_probe,
>>  	.remove		= gpmc_remove,
>> @@ -2654,8 +2658,8 @@ static struct platform_driver gpmc_driver = {
>>  	},
>>  };
>>  
>> -static __init int gpmc_init(void)
>> -{
>> -	return platform_driver_register(&gpmc_driver);
>> -}
>> -postcore_initcall(gpmc_init);
>> +module_platform_driver(gpmc_driver);
>> +
>> +MODULE_DESCRIPTION("Texas Instruments GPMC driver");
>> +MODULE_ALIAS("platform:" DEVICE_NAME);
> 
> Why do you need this alias?

Not required. I'll remove it.

> 
>> +MODULE_LICENSE("GPL v2");
> 
> 
> Best regards,
> Krzysztof

--
cheers,
-roger
