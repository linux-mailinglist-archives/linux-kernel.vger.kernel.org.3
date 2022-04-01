Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1EA94EEDC3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 15:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346130AbiDANFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 09:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346156AbiDANFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 09:05:46 -0400
Received: from smtpout1.mo3004.mail-out.ovh.net (smtpout1.mo3004.mail-out.ovh.net [79.137.123.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7232211C26;
        Fri,  1 Apr 2022 06:03:44 -0700 (PDT)
Received: from pro2.mail.ovh.net (unknown [10.108.20.220])
        by mo3004.mail-out.ovh.net (Postfix) with ESMTPS id E28952451C7;
        Fri,  1 Apr 2022 13:03:31 +0000 (UTC)
Received: from [192.168.1.42] (88.125.132.78) by DAG1EX2.emp2.local
 (172.16.2.2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 1 Apr
 2022 15:03:30 +0200
Message-ID: <8fb86bde-7672-87e1-28a1-e78f371bfcca@traphandler.com>
Date:   Fri, 1 Apr 2022 15:03:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 2/2] watchdog: Add Renesas RZ/N1 Watchdog driver
Content-Language: en-US
To:     Tzung-Bi Shih <tzungbi@kernel.org>
CC:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <geert+renesas@glider.be>, <linux-watchdog@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>
References: <20220330100829.1000679-1-jjhiblot@traphandler.com>
 <20220330100829.1000679-3-jjhiblot@traphandler.com>
 <YkVFc6Q6/6rxSw89@google.com>
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
In-Reply-To: <YkVFc6Q6/6rxSw89@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [88.125.132.78]
X-ClientProxiedBy: DAG3EX1.emp2.local (172.16.2.21) To DAG1EX2.emp2.local
 (172.16.2.2)
X-Ovh-Tracer-Id: 17880416423138572789
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudeiiedgheelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfhisehtjeertddtfeejnecuhfhrohhmpeflvggrnhdqlfgrtghquhgvshcujfhisghlohhtuceojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqeenucggtffrrghtthgvrhhnpefhiedthedttdegueeggfdtjeegtdeileeftdegheeutdetjeeuieehtdevvdefieenucfkpheptddrtddrtddrtddpkeekrdduvdehrddufedvrdejkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepjhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepphhhihhlrdgvugifohhrthhhhiesrhgvnhgvshgrshdrtghomh
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 31/03/2022 08:08, Tzung-Bi Shih wrote:
> On Wed, Mar 30, 2022 at 12:08:29PM +0200, Jean-Jacques Hiblot wrote:
>> diff --git a/drivers/watchdog/rzn1_wdt.c b/drivers/watchdog/rzn1_wdt.c
> [...]
>> +/*
>> + * Renesas RZ/N1 Watchdog timer.
>> + * This is a 12-bit timer driver from a (62.5/16384) MHz clock. It can't even
>> + * cope with 2 seconds.
>> + *
>> + * Copyright 2018 Renesas Electronics Europe Ltd.
> s/2018/2022/ ?
This driver wasn't written by me originally. So I'd rather not change 
this line.
>
>> +#define RZN1_WDT_RETRIGGER			0x0
>> +#define RZN1_WDT_RETRIGGER_RELOAD_VAL		0
>> +#define RZN1_WDT_RETRIGGER_RELOAD_VAL_MASK	0xfff
>> +#define RZN1_WDT_RETRIGGER_PRESCALE		BIT(12)
>> +#define RZN1_WDT_RETRIGGER_ENABLE		BIT(13)
>> +#define RZN1_WDT_RETRIGGER_WDSI			(0x2 << 14)
> Do RZN1_WDT_RETRIGGER_RELOAD_VAL and RZN1_WDT_RETRIGGER_WDSI get 1 more tab
> indent intentionally?
>
>> +static const struct watchdog_device rzn1_wdt = {
>> +	.info = &rzn1_wdt_info,
>> +	.ops = &rzn1_wdt_ops,
>> +	.status = WATCHDOG_NOWAYOUT_INIT_STATUS,
>> +};
> [...]
>> +static int rzn1_wdt_probe(struct platform_device *pdev)
>> +{
> [...]
>> +	wdt->wdt = rzn1_wdt;
> Does it really need to copy the memory?  For example,
>
> 1. Use the memory in `wdt` directly and fill the `wdd`.
>
> struct watchdog_device *wdd = &wdt->wdt;
> wdd->info = &rzn1_wdt_info;
> wdd->ops = &rzn1_wdt_ops;
> ...
>
> 2. Use drvdata instead of container_of().
>
> Use watchdog_set_drvdata() in _probe and watchdog_get_drvdata() in the
> watchdog ops to get struct rzn1_watchdog.
I'll rework this. Thanks for the review
>> +static const struct of_device_id rzn1_wdt_match[] = {
>> +	{ .compatible = "renesas,rzn1-wdt" },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, rzn1_wdt_match);
> Doesn't it need to guard by CONFIG_OF?

I don't think it has to.

>
>> +static struct platform_driver rzn1_wdt_driver = {
>> +	.probe		= rzn1_wdt_probe,
>> +	.driver		= {
>> +		.name		= KBUILD_MODNAME,
>> +		.of_match_table	= rzn1_wdt_match,
> Does it makes more sense to use of_match_ptr()?
>
>> +	},
>> +};
>> +
>> +module_platform_driver(rzn1_wdt_driver);
> To make it look like a whole thing, I prefer to remove the extra blank line
> in between struct platform_driver and module_platform_driver().
