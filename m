Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF27D565C34
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbiGDQek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbiGDQeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:34:37 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410FF654D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 09:34:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8zy7dqcWLaNCdfhQnWQR9lRKGBlBmHkC70xi2b5yd28MqARGRVPuNO1ztHbFgxdxK84vjJybndStt+/HXGeXiU7eHMMnXfxz8AefZxrBlsnSuQgyxioTZKLFupRMVMGl3jL/ln1+kUL0Q4PRcjSPd+AEtlqjFHQbq5JPnTexuDSeVHOLeDWqNAC62AxZce2HFoNp3lqB+eZ3t/jc2NKqeSE4AvuvcqbZkiDwLakaU+uV9Hf+8GPJrc4iCu/v8FS5igVCNy3af7cPlOw6BBHelGepV8lKG00R9l71XQuOmWnlN2dhKyDHyfa2TTmM9Tr7uJXIu81cIOc4aQRnRTjfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6s0CqIMydvo6nichuccO89m7vrDhcyi+AgExCjMHnXk=;
 b=WaDfaxWFdqBKmg6uNP0qdcVBYkJbwkQe6gUqQEwVICgu/+nDuvHFfffNT1FKsAz4bD6sy3xOFfDTBron4oy8S0Aq9zGDhFYhL0DWmZz/NaVjSo3xbZhQbvCPmizSElpWAIDmYn5bxAtGtatjD0YBDzEIFmhg8SrnLTN9y8UiWurEp2OjhjCMUbMdeap5kMBZpEcEwAXqVv+RQUqCsjc/tKu/ZEdduf49hpeQK2tNkPkeoAvqVk+VkbrGkZiNksQcQrB0Xhrrj5KNf5gxwPesSEr0gCJqYy3lE1xD/3hics80OQCVzN+vBagRnwhxhBOo4Of5d8LKJPoGc3wsETaTqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6s0CqIMydvo6nichuccO89m7vrDhcyi+AgExCjMHnXk=;
 b=IyjAd6s9OJ6R9ttvQidefZ9Jfhus8qxCVnJ7d+B/+hgMjV35Z0UC9Dnx4cSciV8H91UrAixQ+83FqpQf66na5XUbL7/CC6ycppnbd3d2trBlkNpg52q6Rj4ALu6kqVns8FFxL8B7fUVWnIs0Ls/cRX8ILrmQ2eABiQb7UNGIGsA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by DM5PR12MB1482.namprd12.prod.outlook.com (2603:10b6:4:a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.15; Mon, 4 Jul 2022 16:34:34 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::6d50:f6c5:cea4:1d95]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::6d50:f6c5:cea4:1d95%6]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 16:34:34 +0000
Message-ID: <9462763e-b99e-b530-ee16-81502f245614@amd.com>
Date:   Mon, 4 Jul 2022 22:07:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH RESEND V2 2/3] ASoC: amd: add Machine driver for Jadeite
 platform
Content-Language: en-US
To:     =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Sunil-kumar.Dommati@amd.com,
        open list <linux-kernel@vger.kernel.org>,
        Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Alexander.Deucher@amd.com,
        zhuning@everest-semi.com
References: <20220704140837.1215534-1-Vijendar.Mukunda@amd.com>
 <20220704140837.1215534-2-Vijendar.Mukunda@amd.com>
 <684b0081-5dc7-73c1-67c0-b707941b7043@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <684b0081-5dc7-73c1-67c0-b707941b7043@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0167.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::11) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b20c572-3041-475c-e7f3-08da5ddb13f8
X-MS-TrafficTypeDiagnostic: DM5PR12MB1482:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ePeZdID5Pj7JXo7NMyi1JbTA86sL7/aBk3zOl9baxK51Ro9DnEmGogfqbG9GapvIzGt2RYe9xLuzWd7F1XTVoV93KAmevCySwGR8vLTsxnirChzc00RamL/CbuPqDERwkEMk2CVsIC3g5oGSanFG09ISwvZicBhj+AL4MvNgJyBATEowJInHdr3tkmFxzbPD/ZC07ca6Lz6drcOJg6PiAMevG4ClAvtL7kfQtOkaZjo2/dfKpTMVEEKBh8U1i0ZRZqVPhe0BK3htPoqr5oHnKJGs47Mq/KqE5t2sCiaTvASpv5EUOyo6ugaknQeAYai/mtSBShRb2/Z4qb4HJRwKqcBFXTDs2kwltAXvgYR2DN78MpHCSILV8PaB+IC9O2Kgwbc2KgJNlRdk2fN3JQU3HjNQINF9B3A3wK0rDRJARfY7lo8m1+cErG85ZDm/zRI6Hl4gBlQMBZw8AIBxa9r4WQtJv60x7p8Nz95JJlzntO7egNLHQH2ThLSa+OAA+2V0AOicXBLwJmjbr/LB1HgqdoFXIsywda0RO5biSF9Nom2txtpOTAjPo0HdqV2upG7D622OYfl5+mBUxD6V8z0ETQJ8ccD8bf8kw1NKojQvH3h/pRNm1SCVpTDjnVkMD0DNhcuT4YTLGtZVslGui7FjEyWUoPEU7Y8CmKPQUUw2Xz6+UokXJWDUQVjWxgX/Bouz88bJJVcQt490iSbitOSs/rCJWCKhUYKbTCP/kkqVs7zRLZvc6NQODZsItmUuWNsKy6jKQaqmGfOSFmY/ku6KND+z45AiYOChXpdzzLrEphYxLauyhaIdNWd4tN12datrl1o+/k3DEFp7alc1ieDIpyAp32XlwHM8KqLKyQ5H7Wo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(6512007)(186003)(26005)(53546011)(31686004)(2616005)(38100700002)(5660300002)(6506007)(8936002)(36756003)(2906002)(478600001)(41300700001)(4326008)(6486002)(8676002)(66556008)(66476007)(316002)(86362001)(66946007)(6666004)(54906003)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ciszMmFGZjk4YmpaaVQxdXRhd0lDRDhYUWtZTWdEeVFVVmUzNDZ4bjhiQUpx?=
 =?utf-8?B?T2Y5VkVMTWNYS0t4WlNiMEgycTZtank2b3cvSWlIaldicWFpZmJPVUs4OTI5?=
 =?utf-8?B?QzFlRklwNXpXcmp4SWdpd21LV1VpOVMwVlRhbm10amVpallTZHBhOEV1OWpv?=
 =?utf-8?B?MXNTOXJUcU92SmhvYVRkeVZIMUYyTGFDdGlXeDZqR0hhd2hXUnozWVM0bVFk?=
 =?utf-8?B?Ulp5NHROUUYyZHRSS1FIUkZiTCtBVmRNa0lkZFMxVmZhU1BaR0dpSXJOZXZv?=
 =?utf-8?B?cUVJVVJnbzEyWU4vLzljZm4xUndDYkh4MWRsV3piektIek9UK005MDRlYnZr?=
 =?utf-8?B?Z01Dc3p4ODVWZGZZekVCTmZEZXJKSDA3ZmRtazZ4SDRPWTNzQXNkMTFLTERD?=
 =?utf-8?B?bHRjMnFMa1oySHU0UkE4b3V6aFNEM0hGcXVzWEhoc2hKMkVqdUxnYXI2Ylcr?=
 =?utf-8?B?YWI5djZXWEpMVCs3ZFBFTm85c09qbWU4SHBYT0JkMWZtTDRzUEhuZGhxR0tK?=
 =?utf-8?B?dzQ5QlFGN2gzRHRtRzFXZitFOFJZY21obWVmaW12NXl0LzR6cTZiSUI4cXZM?=
 =?utf-8?B?UmpSUE1vREpQbkxob1RKK21WQ2w0dFNlWjEwZWJPU2lpbUtOT0VVVkU2QnVT?=
 =?utf-8?B?SWVpNG9tcTFxa21kYkc1VWxGL25lUXhyWE9jOTdIZ2FPLzI0WmJKWTdXNUth?=
 =?utf-8?B?N04zMTVKY2VYQVNHNkhaUld4ZW40dm9EZG5Oc0RpWCtXUHp0UmtTQzFPcktG?=
 =?utf-8?B?L2NqNTMvVHdVSVNlaGNJbnZlSmlEQXZLeTFudnpIalAwMS8xemg2QkhhU25x?=
 =?utf-8?B?MjZiNTIwSEdqMUFPZGlxNjlRSVlxbW5SemxHdjhQL2JjWUIveUdYbkRlWDFm?=
 =?utf-8?B?RjdFTG1YYjE5TlZ2K2RidTM3R1RpZmtqVWhCb2w4MEp0R3RDSk11cXpGV09P?=
 =?utf-8?B?UDgvdTlwYkVqYjRpY1hzSGNycStNL0ZpVG1NTG45c3FpeXFXdTZCRjJ3NmxJ?=
 =?utf-8?B?bjl6am9aZy9Lb0xIQnlOa2hWM2E4SnA2WUVzK1NZMEROdVZQRytxZjVWVFA4?=
 =?utf-8?B?OURJQWdvTzJSczBqWmxIVTV5azJZNkZpVTBjc2FwNG5nWHdoUDNRaERBTUVJ?=
 =?utf-8?B?TXJpZlRYbktBcE1zR3g4c3BOR01NbG8yMlNFMlBBMjNFQnRuMUJyRStnNVRa?=
 =?utf-8?B?MnJzblZJV09IZU5wU0luVzc3cm8rY2N5OXEwSjM5N2VBMlFzdm93bklnL2d0?=
 =?utf-8?B?cnFEdVVqVEE0NTFCWk1ndUppVS9RNEJaV3U5U3BpMDJpK0ZUa0taTEZ0KzFI?=
 =?utf-8?B?eXQ3MUhZK2FNTFBvekJBSGpEeU1pb3lRMnIyb1c1d2JoTkhrUmk3NzdGWDdq?=
 =?utf-8?B?UWpnanpoNDdrZTExMTRHQ2RLQXVzc1Y0ZnBHczNGeEwzRnVIYnBnOFpvbUlE?=
 =?utf-8?B?c3M1YUU2MGpORUphY1B6dXUwVVllNm9ZU05NdWkwZkJyOHZEWWxMeDB6K2pI?=
 =?utf-8?B?MTArQjlIY2VaUWdhSXZyZzJkSVZVaER5cTVqaHRRL1VmYS94ai9LUzlWT0Zn?=
 =?utf-8?B?VHhLaHhJRStxNnIza0xiUFNQN1J6UEMxa3hUdTFJWHlVYTRjT0FjVEFURU5H?=
 =?utf-8?B?Z0ZhazBxSGI3TjFVaWNZWEwyTjdSQldjUzJXYnllY2oyMERaenpuT0FqNms5?=
 =?utf-8?B?WUJ1Y01Fcm5OT1l4bllDb0J3K0N1TC9OMTk1dkdKdVZJcDRidlV2SURhaHIz?=
 =?utf-8?B?dVZHYTd5U3YyQUtlbGJ5RHFaUE1Ib1NGNlFGbWthQzFOYzNKWEJmMFMrRmNH?=
 =?utf-8?B?eU9uWkhYVGtEekk1YmtIYUc0bjNLK2hVZGxtWVhFZlRuZmhmNmNZN2dmNzA2?=
 =?utf-8?B?MW0wS2NCczBBM04wTnVCNC9UczJXdzBFenVNMGczeEt3S2t3eTVHV29Ob0N4?=
 =?utf-8?B?dEVuVDlCLzd0MXhRMFRMOFUycVFPTXptN3FJVHZaWTU0NVhwYWdlaTRjSUNQ?=
 =?utf-8?B?T1lPbTNOZVJMenJQUkJkS2tqNVUxQiswUDBxclJHWk5UT2M0bXdLcXU5YkpH?=
 =?utf-8?B?R0ZGM2dPNDlZVDJLM29PNHRXUjNUbU5JQ1Rzb0RlVjRwRFJHeWRabUhtVUFj?=
 =?utf-8?Q?2SxoIVNWXcJ+LAxgR5dZPQddt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b20c572-3041-475c-e7f3-08da5ddb13f8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 16:34:34.4708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hFVrnATDphwENbVbpdXUA6zRadWEcLwutoz3IJgsTeIrOLgPKrmIq6AyFz6uw/3RDDyrzGEQ0XR1THCj/HWjHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1482
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/22 8:27 PM, Amadeusz Sławiński wrote:
> On 7/4/2022 4:08 PM, Vijendar Mukunda wrote:
>> Add Machine driver for Jadeite platform which uses ES8336 codec.
>>
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>>
>> Changes since v1:
>>        - as sysclk is fixed, moved code to startup() callback.
>>        - Removed unused macros (ST_PLAT_CLK & ST_ES8336_GPIO_QUIRK)
>> from code.
>> ---
>>   sound/soc/amd/acp-es8336.c | 324 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 324 insertions(+)
>>   create mode 100644 sound/soc/amd/acp-es8336.c
>>
>> diff --git a/sound/soc/amd/acp-es8336.c b/sound/soc/amd/acp-es8336.c
>> new file mode 100644
>> index 000000000000..eec3d57092fa
>> --- /dev/null
>> +++ b/sound/soc/amd/acp-es8336.c
>> @@ -0,0 +1,324 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Machine driver for AMD Stoney platform using ES8336 Codec
>> + *
>> + * Copyright 2022 Advanced Micro Devices, Inc.
>> + */
>> +
>> +#include <sound/core.h>
>> +#include <sound/soc.h>
>> +#include <sound/pcm.h>
>> +#include <sound/pcm_params.h>
>> +#include <sound/soc-dapm.h>
>> +#include <sound/jack.h>
>> +#include <linux/gpio.h>
>> +#include <linux/device.h>
>> +#include <linux/dmi.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/gpio/machine.h>
>> +#include <linux/i2c.h>
>> +#include <linux/input.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/module.h>
>> +#include <linux/acpi.h>
>> +
>> +#include "../codecs/es8316.h"
> 
> Any reason to include this header? From quick check I see that it only
> defines ES8316_* defines and those don't seem to be used anywhere in
> this driver?

Agreed. There are no references to ES8316_*.
Will drop the header inclusion.
> 
> (...)
> 
>> +
>> +static int st_es8336_remove(struct platform_device *pdev)
>> +{
>> +    return 0;
>> +}
> 
> No need to provide .remove handler when it only returns.
> 
Will remove this API and post the new patch .
