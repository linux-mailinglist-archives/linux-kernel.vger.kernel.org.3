Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222D94EA938
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 10:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbiC2IaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 04:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbiC2IaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 04:30:20 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1311112;
        Tue, 29 Mar 2022 01:28:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fh4f6kH8rHnW2uJencWDZl+7vNSiSa0QKieSK9WhkeHHrcXVydQ4m//Kej7TyL+TAoaPHbftXZNdwvTMqACJx3JvIITZKSjX/YaSi+40v9TMiTheCvUuOLanfWjtL+M5Ug+mgqeiSKH7CT4+n519gcjL6B/LGLuh6L1F14/9f65qn6t6VAuCWy8YWPjgz8ZX4KLleMB9cNFFqMcE36kojU+qz2K7vhXWbU7zTN6OO2cL62wQJIImi7wY1MAIfKy26HUPImUo6J8yNBb1gq/axSR3OxAeedPzqrBgH7p7GUgC+VXtu1zyV6Sz4Jd4htkc9COo81KeVTRFvbOZk8CWkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8R7KHASr6Jf/cMoBbNl6hAuuUIjb8TC/dojYMFTZlg=;
 b=OeK4YqNMvCDZIHePDiU3okvT1uX/QJ4c6n6Cz9ZNao2RQKoqD/VJfz9P21PIIeDvpbfeAP7xGuSygloQhIDqm5dnvjipSOjDn0BrnD+C7anNU7rvOvskyWVR8GPmsXdfPXoGBOGJayv59bkgmLei85ysCVgx/ZbtWCz6wyHaWzUAiZDx+f3C3ezWKa2NWBn8A0G677f1ViT2MHE/xmHRg7Cp8e/7sCzdCuyv2LkGQRPHy2UMRfJPi/jAeRn2xxxqbh1zHHFoCMenFBw4TVMMRLOzu/yyK4xFqkrvQMmHKzFHq5Ze5UrAcscnfF6rBdTmXMKcse8CxdX9mqAON3urTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8R7KHASr6Jf/cMoBbNl6hAuuUIjb8TC/dojYMFTZlg=;
 b=oKfaOic4cWz/WcrXrb45/Bd2MGd6Vq4bdgtHLCUrXEy3ewSJSlo3wKy2J9ZlQpCLV8cZ10VQmVL2AHQq/xFjU6A4Hnvcbdf/KSIQZLEZjNzjW2mj1XqIHnWQBy8g4Hspy5N9lYe5gq4K8X06HwHzCLv6uib47mQ6WIMeT8lF2mqAHgBDUu+F6mkUNtXooIck4Kg0UAaTECBIBJNOPGealukuVKG7czB/0Kd4PjLqg8TR201nzJGvyP2AJIYz3hcUtSaCXf9r4dnsEYtLpa4ULbm5MRn4JAg0CuExjrON59WN5IH/kYR3ZyF2x4Qby6PeWhWzw7RvtPKYAL7lXQXNSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM5PR12MB1579.namprd12.prod.outlook.com (2603:10b6:4:c::21) by
 BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Tue, 29 Mar
 2022 08:28:35 +0000
Received: from DM5PR12MB1579.namprd12.prod.outlook.com
 ([fe80::55b6:14a1:6fa5:3955]) by DM5PR12MB1579.namprd12.prod.outlook.com
 ([fe80::55b6:14a1:6fa5:3955%11]) with mapi id 15.20.5102.023; Tue, 29 Mar
 2022 08:28:34 +0000
Message-ID: <b598df5a-ed24-af15-7857-af47b6f8fad6@nvidia.com>
Date:   Tue, 29 Mar 2022 13:58:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   Sameer Pujar <spujar@nvidia.com>
Subject: Re: [RFC PATCH v2 4/6] ASoC: soc-pcm: tweak DPCM BE hw_param() call
 order
To:     =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>, broonie@kernel.org,
        lgirdwood@gmail.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, peter.ujfalusi@linux.intel.com,
        pierre-louis.bossart@linux.intel.com
Cc:     oder_chiou@realtek.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        jonathanh@nvidia.com, thierry.reding@gmail.com,
        linux-tegra@vger.kernel.org
References: <1648448050-15237-1-git-send-email-spujar@nvidia.com>
 <1648448050-15237-5-git-send-email-spujar@nvidia.com>
 <6ae534e4-25f8-5825-a2ec-cb1c512dac57@linux.intel.com>
Content-Language: en-US
In-Reply-To: <6ae534e4-25f8-5825-a2ec-cb1c512dac57@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0163.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::33) To DM5PR12MB1579.namprd12.prod.outlook.com
 (2603:10b6:4:c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5dd384cd-8dbf-4817-5ca9-08da115e1d6b
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB286957596A40B6C12ADFF3F7A71E9@BYAPR12MB2869.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NSxBoNCQowlDDq0MuKX1wlvlqGMMoUgmjA3qh9LH7BWnHQ+MjFI0xPwXlV9XckFmUg6FvDOJncFtD4ENKC2nS9/a8eYCFoTLzlgaA/ds7Lmo/OeJqiCkMInCDGzZGhZdZ+bnGe1MA9vGyy9zbsZFQ4hoFhBMDv5sRGPIcirFVGsIIun2wAHTKdBpHJWJo6vEpNR35cdpd9tWbhQnmPvYGfC8HXMv7dQKkHZ+piBFaqLGgS5J7YXYM0N7cbNFFzH22ilU85ZgeEnFYSsDV8NibpnKav1eUkfanx6oXZxZUypPfG//usFXQeKXORdxXra2apDbEOfLcK2pi7Vkkn0f62K3xw1+nwjFW5p0uCz23dLgdxV3iA3Q0GGZbA1sqG+sUmloYPHAoT/sFhu/chKLmcnQF/4/kUzrvziUz4pnT0TtzzFHuLAgbFka/Ph7Rf9RiyBhEAXin/vq1aZlI8Bb0F3SidaodRP0dsz2q3kLVdDv1RhKBblFcbhm22/fOkSJTaxLDWCFuZ/mIxjofEOLPXEp3KBBUSdIl+8P+dT3GGe1UxU4xlWKT+g6f9APAx4nvowXvLS6TjHQ2zwIqmq5eGUkWR7aCRSs1URmFwFdlz7xo1rEk6g4gE8j/IMRii/JsnmE6YH+54IE/B9BAhtTGMLOv8OqDtvtHIG0Xrx9CvjSXmbvp2VFHLQ4g6Vr09Jys57BqeI096WDwP+Sq/ZpbwtYLjeAh735uqMYnYvSpk0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1579.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(86362001)(83380400001)(2616005)(186003)(26005)(31696002)(66574015)(31686004)(5660300002)(36756003)(2906002)(316002)(66946007)(6486002)(7416002)(6506007)(8936002)(66556008)(66476007)(508600001)(6666004)(53546011)(8676002)(6512007)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzg4MEtsd0tvVk9NMTlXd2NNM1RUcm1ZR040YmNXRnVpajVWWGx2TUtsd01P?=
 =?utf-8?B?akxMNW1ZNTlodWxOM1VYd0s5ZW0wa05yNU52QnVMSm15SC9BbGplL1E4enFo?=
 =?utf-8?B?REU3ZG5kMUErODd0bmZmZWJGZ0JCWjVoZnNWQjQzL1kyenRRejMzOEZjeTFx?=
 =?utf-8?B?SGdvOXdqVWRZTmJqRmxnL2hSZThNMVorNFdsOFg4bEJ4ZjB4a2ZrSzdleklV?=
 =?utf-8?B?UXVkQXAvbStWQ093L0s2OVU5VEkrYXlobUpsMlNuc3lLMzBqcldLVkhxUHpa?=
 =?utf-8?B?d3A5djNEYWpKWUVobks1TzgrcFpmL0lJamlUM0dGbFNTaVVBZGdlWm1BZGs4?=
 =?utf-8?B?cFVtNENvMjFZQVZhZDBpb1Y5TFpxdnlZRzlWMlRqNDN1bWwyRzRnZ2U2Ukhk?=
 =?utf-8?B?RXF2M1QxUWY5ZThZeStlY053Q25lMkhXblR6RkwzNWRDYXM1T0ZkWXRZcjFq?=
 =?utf-8?B?ZUJYL0JVc0xuU0hZaU1NNms0QkJKT1d5NWdrUWxwVmtEbm5BNURxQXFwRFZH?=
 =?utf-8?B?dzhtNUNuRlc4MnVBT1hNeVJXRUtDVEtlYlBtQk1VTjdHYXRhOEhWL2tTQUxW?=
 =?utf-8?B?QXgySGtIYjZQN0ZZR0xpVDA1ZGxFR3l5T0psUThrM1JtYWUzN0lmWHBBUlpy?=
 =?utf-8?B?NzhuM0U4UzdhclljOGxINFBxZnFzL1FVUTB3SC84MHFVWXFIMW4zSHFqamU2?=
 =?utf-8?B?eit3cXdyUnAwUENMTFE0Z1Ixb3FIMWFCR0RnZ1N6c2J1d1YxSEtmS3FteDVX?=
 =?utf-8?B?SE5EalBtWkVwVjZiVXN4dG81NjZoSllVeDFTRVR6cGl2SkhVZTlEc3NIM0JO?=
 =?utf-8?B?UXJFTGVuWlF4OEw4emlFRGJRZEdVVG41ZTZ2N0YrTGdJbm1MUlRzV3p6Z2pS?=
 =?utf-8?B?SHJBNXIwWksvcXdLajFiVmEyQnFPSUFhOWp6MFFwZjM3aHVCMklEc3VXamRD?=
 =?utf-8?B?UEtoRWUzS21WNk9FQVQyY0dJMGF2NmgwYkFTZU5NVHlwUVBNM0pDbGFGd2JY?=
 =?utf-8?B?OTduL0pIVHlKM2RGdnR1cGlSTnY3V1pkUmhGYmd2T1JWbkpXR1NhRTJDVHlX?=
 =?utf-8?B?cUYxc0dvRG5xemJNMzh0clRZRWZVVTc4K0RGa2k0c2VnRXF0WlZvTTVMZVU2?=
 =?utf-8?B?SFd4MkZWa1p6eTJqb09FRTYxVEhHK21xdjMxUDJQV3lNTlMzakMySC90TUZu?=
 =?utf-8?B?ck9yTVdERHl0YVpkbkNRRExqSExnaWY1VGxjR0JIWHlZOG1uWlpzdTZMbzJ3?=
 =?utf-8?B?SDJYbkNPOGc3dUNpanl3VUorSk1mOGRXbldhaGNKQm5zSzcvRTVaYU94dDMx?=
 =?utf-8?B?a25adHBqL3RnaHRLWFJ5Q0RzeVdJQ0pHRXFWcEpJeEFIMlZ3RE02MzNTQnBw?=
 =?utf-8?B?UXZJSHA5V0Z3QVNHQzJZcUkxWlBkODZ4NXAreWlOUWpZKzJ2eUFPT3FNaVV0?=
 =?utf-8?B?Q2J5WWRTZ2I4ejY3YWRwU01HczdSNE9ycDVqeFkxRDhFU2Y0SU1MN3pYNy96?=
 =?utf-8?B?YXExN01XR3V5bGNNY0FyckFQRjdFUzRudXVMQ0hrQWQxZGFsSEVEd0dEd29W?=
 =?utf-8?B?b29wSExuVHNpM1ZESDh3RjFGbit3U0YwVlB4VWtkWitYSXZzRldiNUlHNEVp?=
 =?utf-8?B?MEZQYW4wU2ZFdEJiWDdKUnAwSStjR3Jia21ZSmFXbTc0VXFYR3p4VFk2Nk1I?=
 =?utf-8?B?Yk10VjhGOU5ibW9QekZPRGpza1hCb0k0RFBzUzkzY2ZJb2RJL3E0Y3YwUHJS?=
 =?utf-8?B?YzU0SFRJSnd6UHJ0dTZxMjV3WVRaUzlzY2cvVGFwT0hnajdsZjZLSVUvUjJ0?=
 =?utf-8?B?eTd5clFuQ3JuMTQ2b2R3ZjdmYVFsNDZpRHpFc3FXaFd1MVNDdUhrTmE0Qk15?=
 =?utf-8?B?NCtxSmVUeU1aTTZibHVOVXFOTUpuOSswK1c1b1NBZmF6amJmSm5rb2RmUXBz?=
 =?utf-8?B?MjNRV0QwUHJKb004ZEM5Tm9DQ0l0UGxDei85VHlXajhGNzVpYndHMTJKTDY4?=
 =?utf-8?B?OVpjS2pwMStSNmtxeEV0TGM0aTArMUZlNjJjWkpja3lraTRKckpmQ2dsS0N4?=
 =?utf-8?B?VlF3RTZGaUFncHluckV2UjROeWN5Y3BnOEUvYlhYdm0xUEY2MTNJeEYxa0tD?=
 =?utf-8?B?cEZVbTI3dVcrUnBtTDBEQ2dlZkt4N2tkRStmT0JPdWtmOTZNTWxHTnN3b1g0?=
 =?utf-8?B?MHpUVVlsUWQ0UWRoeHlSYjd0TzBhMFo5czFXRit2RHYrOGwrUWtMa3VZcHho?=
 =?utf-8?B?dUV5MzUrK3dCUFZndXEzMG5YUkJRRGpBc3J2RzRkTC9UZWNjaC9jc1llMWRy?=
 =?utf-8?B?T0p1LzBvRERLZXFYNEdyYzJacDNacUh5Nk95NGppSkxOV0hFWko1Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd384cd-8dbf-4817-5ca9-08da115e1d6b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1579.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 08:28:34.8269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U3IIob01Bcl9R9U2G/ZGtjOVMNbTybUMNenPH9/yDGIIXaf1mvAM6PRyNfHm7N4xc0uzjT10xWnsrE2apLZoJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2869
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 28-03-2022 20:41, Amadeusz Sławiński wrote:
> On 3/28/2022 8:14 AM, Sameer Pujar wrote:
>> For DPCM links, the order of hw_param() call depends on the sequence of
>> BE connection to FE. It is possible that one BE link can provide clock
>> to another BE link. In such cases consumer BE DAI, to get the rate set
>> by provider BE DAI, can use the standard clock functions only if 
>> provider
>> has already set the appropriate rate during its hw_param() stage.
>
> Above sentence seems to suggest that consumer can set clock only after
> provider has started, but code in this patch seems to do it the other
> way around?
>
This patch makes provider calls to happen first.

>>
>> Presently the order is fixed and does not depend on the provider and
>> consumer relationships. So the clock rates need to be known ahead of
>> hw_param() stage.
>>
>> This patch tweaks the hw_param() order by connecting the provider BEs
>> late to a FE. With this hw_param() calls for provider BEs happen first
>> and then followed by consumer BEs. The consumers can use the standard
>> clk_get_rate() function to get the rate of the clock they depend on.
>>
>
> I'm bit confused by " With this hw_param() calls for provider BEs happen
> first and then followed by consumer BEs. "
>
> Aren't consumers started first and provider second? Code and previous
> sentence "connecting the provider BEs late to a FE" confuse me.

The dpcm_be_connect() call adds the new connection to a list using 
list_add() which would be a stack. When dpcm_be_connect() is deferred 
for provider BEs, these occupy top of the stack. When operating on this 
list during hw_params() stage, the provider call happen first. Is this 
part clear now? I can rephrase the comments/commit message for more clarity.

>
>
> Overall I don't exactly understand correct order of events after reading
> commit message and patch...
>
Consider there are two BEs (BE1 and BE2) and "BE1<==>BE2" can be an I2S 
interface for example. I am trying to get following sequence.

1. When BE1 is provider and BE2 is consumer, the call sequence expected 
is : hw_params(BE1) -> hw_params(BE2).

2. When BE2 is provider and BE1 is consumer, the call sequence expected 
is : hw_params(BE2) -> hw_params(BE1).

Idea is to make use of standard clock functions for rate info. Provider 
can use clk_set_rate() and consumer can clk_get_rate().

>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>> ---
>>   TODO:
>>    * The FE link is not considered in this. For Tegra it is fine to
>>      call hw_params() for FE at the end. But systems, which want to 
>> apply
>>      this tweak for FE as well, have to extend this tweak to FE.
>>    * Also only DPCM is considered here. If normal links require such
>>      tweak, it needs to be extended.
>>
>>   sound/soc/soc-pcm.c | 60 
>> ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 59 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
>> index 9a95468..5829514 100644
>> --- a/sound/soc/soc-pcm.c
>> +++ b/sound/soc/soc-pcm.c
>> @@ -1442,6 +1442,29 @@ static int dpcm_prune_paths(struct 
>> snd_soc_pcm_runtime *fe, int stream,
>>       return prune;
>>   }
>>
>> +static bool defer_dpcm_be_connect(struct snd_soc_pcm_runtime *rtd)
>> +{
>> +     struct snd_soc_dai *dai;
>> +     int i;
>> +
>> +     if (!(rtd->dai_link->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK))
>> +             return false;
>> +
>> +     if ((rtd->dai_link->dai_fmt & 
>> SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) ==
>> +         SND_SOC_DAIFMT_CBC_CFC) {
>> +
>> +             for_each_rtd_cpu_dais(rtd, i, dai) {
>> +
>> +                     if (!snd_soc_dai_is_dummy(dai))
>> +                             return true;
>> +             }
>> +     }
>> +
>> +     return false;
>> +}
>> +
>> +#define MAX_CLK_PROVIDER_BE 10
>
> Not sure about this define, it adds unnecessary limitation on max clock
> number, can't you just run same loop twice while checking
> defer_dpcm_be_connect() first time and !defer_dpcm_be_connect() second
> time? defer_dpcm_be_connect() function name may need a bit of adjustment
> (rtd_is_clock_consumer() maybe?), but it gets rid of the limit.
>
> or do something like following instead of copy pasting loop twice:
>
> rename original dpcm_add_paths() to _dpcm_add_paths() and add additional
> argument and check somewhere inline:
> static int dpcm_add_paths(struct snd_soc_pcm_runtime *fe, int stream,
>        struct snd_soc_dapm_widget_list **list_, bool clock_consumer)
> {
>        ...
>
>  // with renamed defer_dpcm_be_connect
>        if (clock_consumer ^ !rtd_is_clock_consumer())
>                continue;
>
>        ...
> }
>
> static int dpcm_add_paths(struct snd_soc_pcm_runtime *fe, int stream,
>        struct snd_soc_dapm_widget_list **list_)
> {
>        int ret;
>
>        /* start clock consumer BEs */
>        ret = _dpcm_add_paths(*fe, stream, **list_, true);
>        if (ret)
>                return ret;
>
>        /* start clock provider BEs */
>        ret = _dpcm_add_paths(*fe, stream, **list_, false);
>
>        return ret;
> }
>
Thanks for the suggestion. I will check if loop copy can be avoided.


>> +
>>   static int dpcm_add_paths(struct snd_soc_pcm_runtime *fe, int stream,
>>       struct snd_soc_dapm_widget_list **list_)
>>   {
>> @@ -1449,7 +1472,8 @@ static int dpcm_add_paths(struct 
>> snd_soc_pcm_runtime *fe, int stream,
>>       struct snd_soc_dapm_widget_list *list = *list_;
>>       struct snd_soc_pcm_runtime *be;
>>       struct snd_soc_dapm_widget *widget;
>> -     int i, new = 0, err;
>> +     struct snd_soc_pcm_runtime *prov[MAX_CLK_PROVIDER_BE];
>> +     int i, new = 0, err, count = 0;
>>
>>       /* Create any new FE <--> BE connections */
>>       for_each_dapm_widgets(list, i, widget) {
>> @@ -1489,6 +1513,40 @@ static int dpcm_add_paths(struct 
>> snd_soc_pcm_runtime *fe, int stream,
>>                   (be->dpcm[stream].state != SND_SOC_DPCM_STATE_CLOSE))
>>                       continue;
>>
>> +             /* Connect clock provider BEs at the end */
>> +             if (defer_dpcm_be_connect(be)) {
>> +                     if (count >= MAX_CLK_PROVIDER_BE) {
>> +                             dev_err(fe->dev, "ASoC: too many clock 
>> provider BEs\n");
>> +                             return -EINVAL;
>> +                     }
>> +
>> +                     prov[count++] = be;
>> +                     continue;
>> +             }
>> +
>> +             /* newly connected FE and BE */
>> +             err = dpcm_be_connect(fe, be, stream);
>> +             if (err < 0) {
>> +                     dev_err(fe->dev, "ASoC: can't connect %s\n",
>> +                             widget->name);
>> +                     break;
>> +             } else if (err == 0) /* already connected */
>> +                     continue;
>> +
>> +             /* new */
>> +             dpcm_set_be_update_state(be, stream, 
>> SND_SOC_DPCM_UPDATE_BE);
>> +             new++;
>> +     }
>> +
>> +     /*
>> +      * Now connect clock provider BEs. A late connection means,
>> +      * these BE links appear first in the list maintained by FE
>> +      * and hw_param() call for these happen first.
>
> Let's stick to ALSA terminology, hw_params() please, same in commit 
> message.

Sorry about this. I will fix it.

