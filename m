Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E41056C91F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 13:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiGILJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 07:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGILJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 07:09:46 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7127F43E48
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 04:09:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+7NeeSHGbvJlwbd1cRGdH8J9YyLKmtiWVOFGuSneYwkHphPTnqAPqj5fXkehjz4OC9Htkv/Ey6j523UuRz956AmV6zizKvwAKrDuSfYnEdKvct+i8jyqamHf3xGR1qJEdtybufCQfrJ3xQpUXFhHuT/EgSA42PQySPZAn8EXPWhWU2Va60YNpfD6ZxPBaR8GX0TWkK83cJa03fefI7GxXNQsnXAdhelb7mNTLjxlBq8cR9ejhQ/gmcuAl2CEjb25xdoYuYEyz1aTHoD3mF2tCITYgVGgVSzPmg2ExbRnXon2ncXH2CMltpoZRKpoWxJitjIrKtwfp/jTa/vhIhLHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M51zRpvKPM76vEyzthGN19e8g+GYwJnJe4XoUbaHd0o=;
 b=W+St6nMiQWnxnzz6qfNERgXReW/XIS4BzOtHP2m7zHY/EvHFKOTEnBhZqUPOQlop9RVLNInIUaid6qwCD5wnMOhi5vE6MN/GkpV47AGdKnlAKLby0UkTQw6dZTiwF4WxYDKQnhsUubWKvzLjdTOKtYyT4l4GZxwP5o7mYOypGsfVQG9XBx0NrWVqceeg9ZgXxAgFmUsU1peaLHlEiOt7RI9IpNkZdkYwbyr+EdtROBB5ycME03ifbX7GhpM4iDV6x7Ge+gX6UoH84RUCFr45AyYKOO92fiKwiheEPYhw3em7IfJb8ZMPMfQ1PDwdAmGTagByQKMeOUWDW4sXnfRghg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M51zRpvKPM76vEyzthGN19e8g+GYwJnJe4XoUbaHd0o=;
 b=CUmrY6WwGeeggIAmOjAIEJVhgUVCmW0mFQePVwSn/C3rlZUqVCblL7X/K/Ri+1UdSbnsLmE1IHm+ASP56rDFJyuLS7riSHKRdkbINF8SULv07j3X2ju7wffql6WZBMSYuvdY8NxVazswNJPnwN8MK6ARYGTeMmDbLwHNNL0vhUQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by MW3PR12MB4393.namprd12.prod.outlook.com (2603:10b6:303:2c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Sat, 9 Jul
 2022 11:09:43 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::6d50:f6c5:cea4:1d95]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::6d50:f6c5:cea4:1d95%7]) with mapi id 15.20.5417.023; Sat, 9 Jul 2022
 11:09:43 +0000
Message-ID: <d2828d36-275e-60d7-782e-2bff265bae0b@amd.com>
Date:   Sat, 9 Jul 2022 16:42:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/3] ASoC: amd: fix for variable set but not used warning
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     amadeuszx.slawinski@linux.intel.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, zhuning@everest-semi.com,
        kernel test robot <lkp@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20220707132613.3150931-1-Vijendar.Mukunda@amd.com>
 <20220707132613.3150931-3-Vijendar.Mukunda@amd.com>
 <e2eab942-f122-7e37-e3a3-c8a1e153c91b@wanadoo.fr>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <e2eab942-f122-7e37-e3a3-c8a1e153c91b@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0128.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::13) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28c9ce6a-1e1a-4ab6-c847-08da619b868f
X-MS-TrafficTypeDiagnostic: MW3PR12MB4393:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WMs1idMxG7okzlllPG5tHaByQhSJgFFupKiYUVChlU0n96GYsRKksmFCFeLoofz5LVrgTe34408W5mi+Npzgn4t+S6ViaxUcvq+vgY7JB1dULuMoXtS6L+LvzQ0jj8JlKukTW6IrKjdm5gqu8caMFHRoFFFFzmHm0oJww1B7diRQFoHfolwx5CBPp6rWGRxxwz9BdZ3W0y57MWo/2+uLppGGq5pQFGRHBBnpIM5gzNanlIsojjRFoPXKfyl+9qpSV+kb6z9VxvbJRHxjih4P9vdjpZPJAXAipqmg45HXRwH7gmIs7L9JBwiO7XPo/kkIMJelyLGf8qIncqOg2hMiC79LSR2gBUwU2x9Sxx29gP8/GXuKF6pyW2PXiLlT6iBCLVS5HOMxdXFxyIyQ9pPOFNWDT9xO8vwTYERKncDdZKlLTYtIlWXNTyxocwMBwZtYhcHJdNUFadNHig4j1vG07DyQmbBBmO4gzsx24gbnVQtNbutlA1qSsScx5ame/2Xe3hnnvs655BpQR6//j3Glz9X5l2W7A4CVpYPNr3XvXJ+B8yvRFMbf5r9DUwg72O2Atr4UMhAfTiHLOYPuDz/MZr1tAKKYgKUGa50vFHS64BzurBGEukdmnv7K4zOYTo0jRXiyq3bToK2M6Yp/oEe3JMpuw3ADhXsrLWGFKBOEZy1wdC+EC+orwvsC7Y7Nc01eoEbSQ1XR3WcMJCKJxj/RmSsoZRRJgIQvui/pmsippTufI5dCAo5t1D2150vNfpUy459la6AdmP1VK7awXbyQN2wiZtupUHqQELk3a8wp5EG+pY8V+98xJ4bSpu39SmK/KgYNWVgJ8cI+EzoiGWGXgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(5660300002)(4326008)(26005)(2616005)(66574015)(8676002)(6512007)(66476007)(7416002)(66946007)(8936002)(66556008)(6666004)(83380400001)(186003)(6506007)(316002)(36756003)(31696002)(41300700001)(478600001)(31686004)(6486002)(86362001)(38100700002)(2906002)(53546011)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnZpOXlyNHNITjRiOTBIQi9IYmJZb0EzT3laS09OTGkwZTAxTDhuYXN2SFJM?=
 =?utf-8?B?bktIUUEwTnpvMS8zWkxmWFdjWjg5UmZSbTlvOGhLVVVCM0lTaEJUSDVWMXh5?=
 =?utf-8?B?MFFsWlFja29KdHEvUVJ6Rmt2eVh5a1VXTFJWRHh6TU1tRjFQdUx2aVFkMU9y?=
 =?utf-8?B?UXFSSDdSY1h2VlJ6MHhHVWRJT0g5RCtieFg1Nnh5V2k2SXNJOE5FZkk2blZk?=
 =?utf-8?B?U0tGQTl3MjFnVldFbCtZdFlFcEpwUmRBNyt1RDFCQ3VIejJmOGhQWGJENUc4?=
 =?utf-8?B?Zm5reThsQTRyeDFnSCs4Yi9zd0JUcDBEc3lPZXpvdms0TUY0UG5DcDc4dnlx?=
 =?utf-8?B?QmhmZGxtZW4weDdLM0FseGhCaHQydlBiakkwK1lYWnJWZHBRU2hoSkpwcHlQ?=
 =?utf-8?B?QW9wNkcwLzQ4MUtsWUQvZEpsVHBsaU5Pb295M0szTFBYeWcwcDdIQnN3aFRo?=
 =?utf-8?B?Y3NsUDl6VHZpemtFRC9iUlIybzhlaXVKS1BWTHJhN3QzTm5MUTFUQmoycEJJ?=
 =?utf-8?B?ei9ZdGs5Y2lZbmVtUGliZmVMTTRRWlFPaU1tYXNMbC9hVHRHN094NWE1cy9K?=
 =?utf-8?B?c3RCdmloamlGUUZ3Nmc0amptL1Z2aWRKYU52cE9OQjVxQ0V2R2hlNjVHV3kz?=
 =?utf-8?B?bHYwTEF1aWl1S1NZWDdGYmowa3QwSjNQNmtNYzJYYmxPZXYrVWpRTzkvU24z?=
 =?utf-8?B?WDBvMHNtaUZETEQrb1JkK0xYN2Mra3o1QWx5RUNrSlBLVTRzSXJlUEtPd0RE?=
 =?utf-8?B?UEhqaGxmNy9RQUlJSkNnUXJxM1RZUGhHTTRwSjJhRTN6Q3ptcjYxUFE4RFdr?=
 =?utf-8?B?RkF6Z0Q2NTlIOEpGRWMvSW9PSmh1WDJoSG9IWS93cGF3RUo5SWhDSjg5THp1?=
 =?utf-8?B?UXdwRjJTMk9iTTFGUXcrYnJMakhTNndqQzVUWUdnNlUyZ3dra3E2aHFpVzN5?=
 =?utf-8?B?b1pwSnJlQzhRaDNBektKRlhxdGNpVUx2SllSTE4xRkswQjdqa01MTmQyU0Nw?=
 =?utf-8?B?azRZMUpXeFU3L2toWXV1eHlRYnc0VFNEdi9aei9VNDZlRXF1RlM1SXhwWnJm?=
 =?utf-8?B?cmZGNUViQTdwYWt4Y2xBZTM4Yk5Ga0RPMnA3SHI3ZGFoRXhMcHgvS2xSRVkz?=
 =?utf-8?B?N21ha2RUR1FxM29EMU5hU0JYMVllMHU5MTNSK0VnMG5rRFdJSGVqVTBmVHVV?=
 =?utf-8?B?b2hiYk5qQmhBR2RaSitrTzhQNzJrdWFEWVdJM1Jvd2NQWDhpRzRnbHpHYlpK?=
 =?utf-8?B?MnJDRDFCZHJsdGpKK0h5MUtFd0NCMk96M091QUp1cVF4Y1RMdTdnYTQ3ZTRO?=
 =?utf-8?B?K3gwTGUycWRBRkdtTk9YVzhvTnkvWStpaTZXVFlCbzhodXBOYUZjVVBPRi9J?=
 =?utf-8?B?OVN1Wkt0Y2R0NHNhamQwaFJlOEhLN3BaL2pVaWl4L25vUUJVOTdubDV6V1NC?=
 =?utf-8?B?TEYrcVR6Y3p4cThlYkFoUU1GdlJVUjgyWTQwR0dDVkk3VnJJdUs3ZnB3blJ1?=
 =?utf-8?B?VFlid1Y4YWpXNHl4QWpPSU1IdzdiWGs4UHp0dld0enk3RUR4MEFiZmd1NG53?=
 =?utf-8?B?dnlCNk9pN1UzdW5wWTg4R043elRWdG5tUVpVQVhwN25NbHlGaEQvcUxHalJk?=
 =?utf-8?B?d1lFNGlPYVNHNUZUY1lMVk1yZnNJZTRrRGpNS3BveTZFLzdXcTU1MnVReWZs?=
 =?utf-8?B?UlU2dTBqRllFejRRNHZaMDFtNHRPZDZ1eGhadU9UaXZKSVZIK3R0RTNPNjk1?=
 =?utf-8?B?UEJ5Z3RMRHFaRjNKQzVlMTNyb3hYdFNTUzdrY1JtUWJvMjlsYXFaR0FPLzl6?=
 =?utf-8?B?ZVovYWRHM0x6WU8vWm1Nb0FNQW8wbGpmNmxJK3lZK0o3RzJROHY4UnNEV0ds?=
 =?utf-8?B?Q0hHdFAybnEwdUgvWXRUN29RbEtqMzRHMVkyV1YzbXdKNWl4ODVVQ1B4R0U3?=
 =?utf-8?B?OHhXUTB6NEx3Y05XMHlnZUI3WjZuQ0xIYlF2MzhkMS9OYzFpM216bVF3VEJa?=
 =?utf-8?B?RGxYZzlHU2p1aWhsR2lPNGY5L0lPYUpRM0wrL0NUK2VtTmpxdUMxay9ONWJB?=
 =?utf-8?B?UGVrVGs1Rzl5Ykx2dWtlSWdpazNrbkk1YW1zdUx3dVk5c09aN2lZSE9COTVF?=
 =?utf-8?Q?2RYjqpOtpSRmueChyZN8vwptr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c9ce6a-1e1a-4ab6-c847-08da619b868f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2022 11:09:43.4866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5lH90vxS6UUDJ330n2X2SVgS1DURjVHPSfk0XAmt/QPgUMhwlfa+bXC5eKYPPYRuA4017ohELLfjXaFyUjkDpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4393
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/22 1:03 PM, Christophe JAILLET wrote:
> Le 07/07/2022 à 15:26, Vijendar Mukunda a écrit :
>> Fix below kernel warning.
>>>>> sound/soc/amd/acp-es8336.c:200:13: warning: variable 'ret' set but
>>>>> not used [-Wunused-but-set-variable]
>>
> 
> Hi,
> this patch, looks odd to me.
> 
> 
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> Reported-by: kernel test robot <lkp@intel.com>
>> ---
>>   sound/soc/amd/acp-es8336.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/sound/soc/amd/acp-es8336.c b/sound/soc/amd/acp-es8336.c
>> index 90f4e5809c72..e1479ae684e9 100644
>> --- a/sound/soc/amd/acp-es8336.c
>> +++ b/sound/soc/amd/acp-es8336.c
>> @@ -206,6 +206,8 @@ static int st_es8336_late_probe(struct
>> snd_soc_card *card)
>>           dev_err(card->dev, "can not find codec dev\n");
> 
> The next devm_acpi_dev_add_driver_gpios() will fail, should we return
> immediately?
> 
>>         ret = devm_acpi_dev_add_driver_gpios(codec_dev,
>> acpi_es8336_gpios);
>> +    if (ret)
>> +        dev_warn(card->dev, "Failed to add driver gpios\n");
> 
> Should we return immediately?
As it required to support Machine driver differed probe , we shouldn't
return immediately.
We are checking gpiod_get_optional() return status. If still error is
reported, then return is invoked after checking whether return error
code is -EPROBE_DEFER.

We found similar implementation in other platforms machine driver code
as well.

>>         gpio_pa = gpiod_get_optional(codec_dev, "pa-enable",
>> GPIOD_OUT_LOW);
>>       if (IS_ERR(gpio_pa)) {
>> @@ -213,6 +215,7 @@ static int st_es8336_late_probe(struct
>> snd_soc_card *card)
>>                       "could not get pa-enable GPIO\n");
>>           gpiod_put(gpio_pa);
>>           put_device(codec_dev);
>> +        return ret;
> 
> Here, we return 'ret' which is what is returned by
> devm_acpi_dev_add_driver_gpios(). So there doesn't seem to be a link
> with this block which checks for gpiod_get_optional() errors.
> 
> Moreover, returning an error for something that is optional
> (gpiod_get_optional()) looks strange.
> 
> Finally, should an error be returned, maybe PTR_ERR(gpio_pa) would be
> better here.

Machine driver deferred probing should be supported.
err code PTR_ERR(gpio_pa) is compared with -EPROBE_DIFFER and same err
returned from dev_err_probe() API.

same code can also be modified as below

if (IS_ERR(gpio_pa)) {
	gpiod_put(gpio_pa);
	put_device(codec_dev);
	return dev_err_probe(card->dev, PTR_ERR(gpio_pa),
			    "could not get pa-enable GPIO\n");		

}





> 
> 
> Just my 2c.
> 
> CJ
> 
>>       }
>>       return 0;
>>   }
> 

