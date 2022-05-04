Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC92251A043
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 15:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350268AbiEDNJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 09:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350249AbiEDNJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 09:09:14 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9470FDFB3;
        Wed,  4 May 2022 06:05:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0qfzVa9HmPBB/Z7lfoBawz03J/2specgTmKC6x044O8eZzGyo9J2CRBdfXbrt0e2AmcCjgFP6UZOy4wxcQtS9xAe0YoV8fAcSO9xM84ZAxsy9TzMdy+zEkjKUyg+HyFhVVfNGJt6Ds1fahKMCtA/d0WGM91SY11jJ5yd+KvezsgnooqaoMrushAuVJbeuvUf5apJGE0HskHwsFQhjE9ysGw29PXH5w1bbybLgyRA3X7qbELK4yH9W8zwTgrfi06UGaW7yWdDwvDQqsy0DLtHG0wz9tfQmYMKpKqC9TJ94jJtOt922aMsh0VfpZm7DJ3qlI45mrGBM3NSfzFT04UxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Yh/UOmO3Df1YBGz8lvLytpyTyOx9fwOApMNsAMvLLs=;
 b=PgDLVyTwooM2gvCr+PIeR2jkF3gNdtkQJjGL9fw3AaG74N0evpfQlCmj1thlIY1tnmuv4pSx41d+daZzupwzRDIY5Dx6z767T/Wnh+b+aknC1lRAhkg/x0VvdXO88LH/ShVjuRBcwkq7y2BO60iGaNViwbJKUEIXpyosxjcIMWjs20uUPbUbGb3T3uMMNTqgHransyZJ6mT+ja2y3jwuVlzKdEVvJxTi0HT2pO8hqV11ZuyUh07f1bANlPO2vjTwmCY4FHT79Z8S+nToVDHvdUVgWynAb8pT/aH8aM9rjfVkmXBpIvcMzwUakkFvKOUUyqq9IoyFKPB1qegZ57RWDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Yh/UOmO3Df1YBGz8lvLytpyTyOx9fwOApMNsAMvLLs=;
 b=d5s8/X6cqZGFWvuKXi+/XyFYNhu5zmHR6bCV6ljZjKsTLjq4nJPdTgwtsQD79ZgCJSq1XNl5DJGVfIekeuvK0qJK5pANw2w+bLFCpX6vEmuQOkxUqIDnubD7JsHoJ90C4rFIlLBnVTeP2UruIouygEEK9KQWKyaIQFnQbI9DK3hxhUAwknGdl+0D2ghTj+jj2Kz6SQP+MdBASCm0NZFYi1DkSyBuEy4kCW2In22w+lr+UlEJfCfAlrzD+Cc4zOCcFDjdUhKe4hAhVizpzGoeowjBBpZa4bFPuFqzeD1jBRwILMUTH3BCxMtcvX5ipR3YwErx57MQ1nuj9up6yXg3zA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MWHPR1201MB2556.namprd12.prod.outlook.com (2603:10b6:300:e3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 4 May
 2022 13:05:35 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::a4b2:cd18:51b1:57e0]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::a4b2:cd18:51b1:57e0%5]) with mapi id 15.20.5206.025; Wed, 4 May 2022
 13:05:35 +0000
Message-ID: <111a5b7d-e8e8-7a08-dcac-cad654fb3486@nvidia.com>
Date:   Wed, 4 May 2022 14:05:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] gpio: max77620: Make the irqchip immutable
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20220504111936.8412-1-jonathanh@nvidia.com>
 <877d718r95.wl-maz@kernel.org>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <877d718r95.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0305.eurprd06.prod.outlook.com
 (2603:10a6:20b:45b::24) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b621e70-48fe-49a7-e5e5-08da2dcec72a
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2556:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2556D69A496AA7127ED9606AD9C39@MWHPR1201MB2556.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kykPIAu3JRHziT68+4V6+uj2EDIdJfWk65J3tEtz3pEoFNL4WNJor0iFjQKuKNJwgVhaEGao6uf3LkTzLb21BiWlGXAA7FOgITmqDzv6F2b1CmZf9imapJHlYz7vPAHlnRz9mf9UYWMMS3o4lZ79UijVBAFLq66DiVC1o8YoT35fX737KK434njX4AXudf4eOpEdcmYWvmP4FgeLCG6U55oqEWU+ftKJueb+oTLs1yglYQhQXBmgNUs44O1T9WVjhCIjKp5lZfmyZdFWuo/3ek/abBI/Kk7h4fA2pIEqPW20f6FveeiZkvr4OKCAkKjU8aB50XWwT76trdaUQD984XTUX+A9R3DbY1uBkXaTrDv07armTiRbf8VAVkymDO2PjVbGogXfN0pbEvnXcPME4MKOUF2TJUzZHsyy4AexfQb5IjaylwD5QCtxQ1PJKFRSd126y3Ypw6fOs3yK0YyK0Vzp7JDF1vySTLRDTvnBfknk2jaDXwjwcTrgaL6MFT7fsIc4Oic2OvFoY45liiXClukkUiR561ohGul1pw00ENlhZtkxPZ8uW8qFIgk61CmHJ3HVi8bZuSzJGCgD5b+t3T/+Dj2+faiop6D69ml1jx3/Mq8bkQ/sLMgsxgsNqInropFrcZoVf+tG7aZXnKbEj+x0+tzSRs4guzL7+78mZG/R/hZ0J4xxcmNPUwgATN0BW3nNj5m6HtkgQ95+K+1fyOLAjvHv8J+/GP0rSPWYD34=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(508600001)(2616005)(6486002)(55236004)(6506007)(6512007)(53546011)(83380400001)(186003)(31686004)(4326008)(8676002)(86362001)(66476007)(66556008)(66946007)(31696002)(36756003)(2906002)(8936002)(5660300002)(38100700002)(6916009)(316002)(6666004)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUQrUE1ycjVQSnU2M2VWbFM2WTNTeHBJL0c5WGl0eDZvY1B4aHp4Vm1kd3Zk?=
 =?utf-8?B?NC90WnFzQllyUUFYN3F3OWZMUlRoYmJPc04yODJPZkl5R1BGaHdiUlVxVnE0?=
 =?utf-8?B?ZFJKNGRXMXMrdWZuanVId0V5bkY5SXpiVytvMFFYYnpDUE5lZ1FLRmplRGlE?=
 =?utf-8?B?ZFpMQVJUc3ZsNXRqRnhWKzFTRkRUUnZmQW1LMXAxZHk2RHk2VjZ3Y1FQQy9J?=
 =?utf-8?B?VlZZOHlFR0dmVW00YXNMWENpOCtRRUREY29nWGZxTTd3aHNjSVhybC8wWXNV?=
 =?utf-8?B?RFNMUFAvanJrU0Npd3VQenZXOCt5OXJ0cjBjT2pVMWtWc0Zpb0JxendQU1lo?=
 =?utf-8?B?UTNnUmpwY0JKNjhRMlZCK3Y0bUZOeDJBTk5JaWlQU1oyT2JIbTFNQWRXREFs?=
 =?utf-8?B?SWxwYVk1YkJWbzVoL1B2bjg1ZTRQUzZxeGhzbDhDbkJTYVVub2Q2c0tBUGdB?=
 =?utf-8?B?T2toZ0tRb1QxeGs2RjJMZWpHMmwvZUxySVE2VFFJOTV2YWluSldHdXFuemph?=
 =?utf-8?B?T1B2dmgzZytUaWNQbVBoTEw5bURMSFFtRmVCZUQwT3ZxUVFvM1l2Qnd5TjdG?=
 =?utf-8?B?anhwSU5INEN2QUFBQkw4NzF3Q0ZMeXJJUDBHM3pienJUcmNhdHJXc2JuUHdy?=
 =?utf-8?B?VEt1NlFlWjdJY2c5OUoxMEdOZS9DU3B4RGdVR1FhSUhGVldnZU5tdnFDUFda?=
 =?utf-8?B?Wkxudk1FdnhkSXN4aHVsaGJ0Tzc0cG5YSTZubStJd0krVW1nRDVObFVyOWhy?=
 =?utf-8?B?blFVeFRWZW04WjhOTWZCV3NXR2w5aThDajQrczg5L3NoNGx3MW1nbzhmcDlG?=
 =?utf-8?B?clpMV21TUC9tRGxJN2hGWVZyeHMrUFMxZm9IRm5CZFkzNGVGK2dtNWdmM00w?=
 =?utf-8?B?b1dFbnluOEJnY2pDRzdLQlFyaWRlNzgxT3NreWxtelpJczVJdkgveGxXS2o4?=
 =?utf-8?B?dGtKaERIL2Jmd1h5Nlg0U0Y3TFNuQUtmYll1U2VncDhpdmZUNFk5K3I0THZV?=
 =?utf-8?B?Q0lRMklweXlkMjJjRU5QRXJ1MjN1OVpibHc5aitFVnVMcDNPUnhKOVN0T2Ra?=
 =?utf-8?B?dmI1dUs4S1RHZ01aUElUSmFUMlg3VDVVTUpONkV3dldhSDRPeEJzSFpFbTZj?=
 =?utf-8?B?Mndib3c0aURMT1BjZG1zN3BWUmpiYVVLWjI4TTVPdEpVYWRYZVhuU3RVZDdy?=
 =?utf-8?B?NmZocW5IdFo3enljRE9Dem9ORVppTUdUcWdkUGFKOFJoRXlXaFZNdW5tZW55?=
 =?utf-8?B?eEFzWUpERjhtTDdTRExjRjExeVBZeG5NMHc3YXJ3MmNMOUprNEg2SkFuTWtx?=
 =?utf-8?B?a1dvSXRHV1BzdlNkaFpWY3poV1FyTXFuN0RCS2huZDZIaXlhL0xNMlVvS0ZB?=
 =?utf-8?B?MkExSVd3TkIrTFdZdmsyRTlUUjBMdTZSa2dUMTd0aGYrLzEwMUVWQS9lOW5G?=
 =?utf-8?B?WmxYdmpuelErNWZqelUxTCtZYXB4Q29uR1orZGtVQUZNTmg3cDJ1Qzd4Z3ZX?=
 =?utf-8?B?YlE0ekUwYTA5dmd3YXEwRW91ajRxTnlCMjAyYkNQOWxKaG9xTE9WK3J4TXFI?=
 =?utf-8?B?QnBSMlN1eDViZEFCbkxJNmM3NE5odk9XOG1LT2hITVJNeEUvN3Q3WXVYY1hP?=
 =?utf-8?B?OG5oSC80Mk5EVzZBRDM5Y2xjS2NseEtkMEdQSnpLTzczbFVJMjBZYXRkS0Rp?=
 =?utf-8?B?VW1seDBTVEcyM09VeXNLbUZkb1VkU2YzdWRva3dFcWtMekxlWENORnNlT1cw?=
 =?utf-8?B?Rk40OStkMDJzWmtJOVNRc1EvTnZWcGJxejQxSHJXMlExTWE5SzFKMStKK2s5?=
 =?utf-8?B?cHEra21XSXg0VmNOaUtkZkw4b3NraWViRklOMXI1ZkduN2ZRWWpiNmtkazNI?=
 =?utf-8?B?UVV1aThWQjVtNjFPUlViaWxJdjdxS1Vpd1E2QWZlYTUwbTRQNHVVdU1COUNs?=
 =?utf-8?B?WHpWKzh0akdVajdkREYrOFpXOGRlcENTeFNtS0N1b2QzVWg0blFxZGNMakdp?=
 =?utf-8?B?Ym5xWGpneDNNRC9SeEJ6UjcwcHUrZkhGdEd2RlM1K0VQNHQzY2hzZWdpNU5X?=
 =?utf-8?B?VXVKVFhWNGFVa1M3QUlocFZYTVludWJqMWtvSS9ZSVMyU3B1NUxDajJ6M1c3?=
 =?utf-8?B?ajJkeEtYcHZtZEZHanh1d0FFWUt0aHNXTGx1ejNISjN1MU1pa0VQSjBxRk9i?=
 =?utf-8?B?eE1ub05pU0t4cmIzbU1VVkhHRnU0SXNJam8yRE9pS1l4dUZMNzNlVENFaSti?=
 =?utf-8?B?ektvc25XWlErQVBDdG13eVZEbytHamZNNlZKK2w5S25tamxpL3IzS0I5eUh2?=
 =?utf-8?B?dzllSGZRaHVWQUxuTWFGN1h1MElwVVovSGliV2FVRks3TVA1V2QvUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b621e70-48fe-49a7-e5e5-08da2dcec72a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 13:05:35.7148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4hnExUzZeZXs+Y7USH0m64Nj9HQsNTmd+3J3iv4NRwx7EGDmXo961ItEuQVbtGNuOOO2peO0WAbb73e5o9utQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2556
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/05/2022 12:35, Marc Zyngier wrote:
> Hi Jon,
> 
> On Wed, 04 May 2022 12:19:36 +0100,
> Jon Hunter <jonathanh@nvidia.com> wrote:
>>
>> Commit 6c846d026d49 ("gpio: Don't fiddle with irqchips marked as
>> immutable") added a warning to indicate if the gpiolib is altering the
>> internals of irqchips. Following this change the following warning is
>> now observed for the max77620 gpio driver ...
>>
>>   WARNING KERN gpio gpiochip0: (max77620-gpio): not an immutable chip,
>>   	please consider fixing it!
>>
>> Fix the above warning by making the max77620 gpio driver immutable.
> 
> Thanks for looking into this. Comments below.
> 
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>> This warning is observed with v5.18-rc5 and so it would be great if
>> we can fix for v5.18. This is triggering a kernel warning test failure
>> on one of our platforms.
> 
> I'm surprised. This is definitely *not* 5.18 material, and I can't see
> the patches in Linus' tree. Are you sure you're not running -next
> instead?

Ah, you are correct, it was -next and not v5.18-rc5!

>>
>>   drivers/gpio/gpio-max77620.c | 15 ++++++++++++---
>>   1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-max77620.c b/drivers/gpio/gpio-max77620.c
>> index ebf9dea6546b..aa92658780d6 100644
>> --- a/drivers/gpio/gpio-max77620.c
>> +++ b/drivers/gpio/gpio-max77620.c
>> @@ -119,14 +119,23 @@ static void max77620_gpio_bus_sync_unlock(struct irq_data *data)
>>   	mutex_unlock(&gpio->buslock);
>>   }
>>   
>> -static struct irq_chip max77620_gpio_irqchip = {
>> +static void max77620_gpio_irq_print_chip(struct irq_data *data, struct seq_file *p)
>> +{
>> +	struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
>> +
>> +	seq_printf(p, dev_name(gc->parent));
>> +}
>> +
> 
> I'd rather you don't do this. This was added as a band-aid for drivers
> that display a device-specific string in /proc/interrupts, and that we
> cannot fix because the string is in effect an ABI.
> 
> Here, you're going in the opposite direction (making the name
> device-specific while it was constant so far). This has the same
> ABI-breaking effect, and we shouldn't do that. It is also rather
> pointless, as we already have all the required debugging information
> in debugfs (and I assume that this is the reason this is added).


OK, I will drop this.

>> +static const struct irq_chip max77620_gpio_irqchip = {
>>   	.name		= "max77620-gpio",
>>   	.irq_mask	= max77620_gpio_irq_mask,
>>   	.irq_unmask	= max77620_gpio_irq_unmask,
> 
> You seem to be missing the updates for these two functions. Please see
> the updated documentation in commit 5644b66a9c63 ("Documentation:
> Update the recommended pattern for GPIO irqchips").

Yes I see. OK, I will add that.

Thanks! Jon

-- 
nvpublic
