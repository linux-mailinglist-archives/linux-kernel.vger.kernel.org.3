Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0354E8F91
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 09:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239049AbiC1IAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 04:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237938AbiC1IAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 04:00:17 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6105D140B8;
        Mon, 28 Mar 2022 00:58:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6dn6Czz/5REoOi3zD79NueS8HqJsuLVbmKBeZpjXYrsYOIP0vr9Bs1aP24iDTzu8O37kPU/2dsb/LvpdJ8AA7cTwxbFWfsTeCHPHklZGQgnc7RSsZf0iRgs9hWdbRtCaNR3cwXE6Qf1KQ9EpMH2ePiBazbIXA80zBZ4oDdlyQksuEYpvlWW0ZJISdS4MY68pB0W4ftuv5pEEe1cjWazT/uksEJpqfOxU6B/mz+3DHvUP6Sv0YfBtkbux/lm1IKp/SGL/WKcSGEXpahZnPmgBmHpnht/h9Pu0gPpAxd0CqC9x6rrSFP3I4qPrAsgeXnen7zH8pESC2OZ+gWhqsbawA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zH/rl0Lxj8yi5lS+rZ8godO72gxzvRa0WrrSiJ89PK0=;
 b=OIqN4E6P7+IYH1aDDDj0KFm+oU6trdhNLh529CIUemqkVrIN2WV+N1lH6dQTgt1uu+mGptp5V3YCZhwXumrwYo5dA22Tk4XDDaAWiM5YijQWlIHwUwqwr2LLWTwE295CCkkapCav3DTBnmzgCZBHGLCgcdJN+3hPdaNy4mmaQt2IYBTQNb660RWGZ9Tke4BJCG+sGT0Jl3qpaUJlN3uffWa9GFp7b4nZirwz0JjutxsRYhdueKXnivaTBXxSR68g958SGVkAtnA+vLfSfA+uYPdKbPd3WtgOLfGtjFdsGGJdUMP0FbGSW0nqR9Qc7hZAXD7MTun2mFf3VhF0UGX8GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zH/rl0Lxj8yi5lS+rZ8godO72gxzvRa0WrrSiJ89PK0=;
 b=gUxNQB0Z4EkWPzZ+bDgnbB7hR7+Y4ZtWkeAh+ZuozEYTKBFpq4/yWYy5pmUytVTQhOhOrKlgEGgmULrzwfPnWzXhgjgQJ+lEnZekCmdoNIhumEdbD31PDd3HiBJaE+6QYTbaUvMtJGC7ReOcFKJegBEq4QRWAssor0R855bma/sGUmNriGYO8JdLdTPdDoRPXhBZgabUVzHtAWnZUvUVYt0yJc6kCfoDGiCYefyiqSaZmedxwY9e1tNSyS4PjGUIltJKZ7cjSV1lZu4DzKx6m31JvzQTiTRBISd6ZU+p0tKiQf5M0wyHMTb7TD9Q/R2Ejaw294w3JNF/DtHUKl592A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY4PR12MB1576.namprd12.prod.outlook.com (2603:10b6:910:10::9)
 by BY5PR12MB4113.namprd12.prod.outlook.com (2603:10b6:a03:207::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Mon, 28 Mar
 2022 07:58:34 +0000
Received: from CY4PR12MB1576.namprd12.prod.outlook.com
 ([fe80::a185:161d:ce15:3e07]) by CY4PR12MB1576.namprd12.prod.outlook.com
 ([fe80::a185:161d:ce15:3e07%9]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 07:58:34 +0000
Message-ID: <53d77f33-27e8-3446-d758-3e545eea2db4@nvidia.com>
Date:   Mon, 28 Mar 2022 13:28:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH v2 3/6] ASoC: dt-bindings: Extend clock bindings of
 rt5659
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>, broonie@kernel.org,
        lgirdwood@gmail.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, peter.ujfalusi@linux.intel.com,
        pierre-louis.bossart@linux.intel.com
Cc:     oder_chiou@realtek.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <1648448050-15237-1-git-send-email-spujar@nvidia.com>
 <1648448050-15237-4-git-send-email-spujar@nvidia.com>
 <da414b44-1bec-5918-84f5-9dfff2009f41@kernel.org>
From:   Sameer Pujar <spujar@nvidia.com>
In-Reply-To: <da414b44-1bec-5918-84f5-9dfff2009f41@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0102.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:1::18) To CY4PR12MB1576.namprd12.prod.outlook.com
 (2603:10b6:910:10::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6912150a-712a-4e55-25ba-08da1090c180
X-MS-TrafficTypeDiagnostic: BY5PR12MB4113:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB411324B6756631C203AE371DA71D9@BY5PR12MB4113.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4eJfkv6tjarW7TqT1jASYBn2AK59Mb1o4J8RdUBWnGuHh0YBYtW6zXzFZ6fJzxYR+9oQRH9teaMEG0Fb7naMwxCjiDyQ8aSaVk7A+urHI4aKHz3ann354YCGeR0lu89RkBZBNyjK2zPI58ovqBSybY9jX7XMRSlHAt7UvDrWgWvZqIMBuEaNCF78CLM7GQMPloEABzIlum+hITAOC3kZUxcXwdToMq7eKz/Zpd1y1yfixNz2c9nS1B5qj+7p8pafWSHfPUauWrcsJ/yVCLspqldVMDmRjZiy+FfhdswWLQQiPQ07HUbtHGA3OOG03olMXC+bWNYOxTpFNDRr7JMLp3jK1TTkldloRadHx0/aUnM0wDZYyPcmFr0bsa64uuZbq+kmPk9lxuN+PA5IesCn0IMLRdxMFPuNrRYGTE+w4wn54q46yUoTmansnjFnrYDkcP0i0Y8/4MtC5XIBUx2d2EuxmxK5yJUJBGuMWs8ZwZWuTwrmC0UcVQbHKqvMrpG5lW/wwRJmdm94nS5dIj9BAZGp3wpn0W01bLIisMEvkMBWhjlCdLkBxwHK97KnEHXQRer56K+7aGg6eIYdeE7OBdOk3FxA3w8PPQ/Sxlf5eEbfjzBESC/Cgi2JRYckZqTHwih/kOiQhGc+ezbWidQGTICvE1mWC0i4KaQQ426ekhjVVVa2cG0EPl0s89n1id3JYEOYiuVgjpnGsBQJJBiGnA2LZz+wRkog3FNGD4HJ7/A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1576.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(316002)(8676002)(83380400001)(66476007)(36756003)(66946007)(26005)(31686004)(186003)(38100700002)(2616005)(53546011)(7416002)(8936002)(6506007)(6512007)(6666004)(508600001)(86362001)(66556008)(6486002)(5660300002)(31696002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0Y0SHNpZmFmb2pEWEdxaDQ2aXFSWGtPNDVRQ1pteGcrZ3Bmd2dIb0JCQ0t2?=
 =?utf-8?B?WHhTUk1zT1NidmRleVBwWW1WcWVLZ1Y2cnVsaS9EWGxvRmdnT2sxTE5UdldJ?=
 =?utf-8?B?NjRhVGFweklYbFg3VXpTQU0wYlhvdGVxVGVLYmo1MSt2UTRKdTFzRkZHaXZS?=
 =?utf-8?B?dUtBTURMa053OFllS2l5NGhKVnA4WENqMnZjZTcvdUx6YXJoUGZnZ1BXRE8r?=
 =?utf-8?B?elNINzh1Y2lhVGxSUGFmSnJQQU0xZGJpUEFCOHdoSFRJb1pJSm1tOTd6eFFB?=
 =?utf-8?B?OXlYVW9zTGUrNk9CTC9xRWZGSGVEekZhVUlHR1lCSXhCSm95MlREeFNES1hs?=
 =?utf-8?B?K1FvK0s4VXBSNU5lNGNGbzNMd0MxWWh5QlZmanJFWU5oYmx2SzBOMmM0VzYr?=
 =?utf-8?B?eHljcUd6anlzcmN0dzRLS3pEWUd3WjZyRWFCMHFIc3dFODZTZG9YUFZLQVh2?=
 =?utf-8?B?OFdYUGxZdUJBSjFjajc4VUE5eDlZTXRZcmxHWlhOcjNuOHVJTEJnemVDTy8y?=
 =?utf-8?B?WUNUL09tQzl5NW9vZ1pRL2QrRngvQVp0V2dRbWZvL3RXZlV5a1ZjdVRVOTE2?=
 =?utf-8?B?U0JGdGZSUWhwbU0wdmtlYVAxa3hYL3J3VzVGUW1aZEg5R0J4WVRLZTlUTnZP?=
 =?utf-8?B?cUxLL2ViM3ZxRlNkL3FWY2tWUnpMZmxKV3RZeC8xMkxqYjFjQU9aOFVyMVNX?=
 =?utf-8?B?UjNNemVLT1d0T0lDay9FVEVJWXdlMnREaVprTjlSNG1iQzNvam9iMlNmam5q?=
 =?utf-8?B?dkU0Y2s2d1k3UndETUpzQ1F0ekQ4VEtHQ0Jncnh4THRaYks1UHEzaERScHg5?=
 =?utf-8?B?d2FJQ1FMYzVoa0tvTXdpTEU1b2tGK3RDTC8yOTdmNHhYdDdIT3hKdGxxaDVj?=
 =?utf-8?B?SFVHVzRIalcydXkvVHlUZk1YRit5Y1pLRjlLaUFBaVlTNlhIS2tjaGViYzJo?=
 =?utf-8?B?K01zcXZjeURuSUUrNlVaYjlhOHY4QTNtRk5lZzVPTXFURklzVVE3S291YnZ4?=
 =?utf-8?B?b0U2ZWRSOVhtRXRMRmNld1h0Y3JTOXNMYUhWR0I3VHpjOXQvZFhQblBrcjhZ?=
 =?utf-8?B?SHk3U0gwOHQ2RDRKTzVBT01ua05FOTZzV2VGOHZhMGNmNS9NNjNNdTFyTnNN?=
 =?utf-8?B?elAwOGt0WXl3WXRuZFZiRFFjZ293TUJJSU9Yek9TaUdvejVNN1FEbUIxdXZD?=
 =?utf-8?B?L0x2ZnhZYmJJRFhkVGJVNlpKYkRJQmRONGk5a1Uxblo3UDhDZ2Y0NXlCOGM4?=
 =?utf-8?B?UkhqZmZIQnBIQ3UrVVplamZGQlg2L2h0Q244azd2L0JaN3M1YVArOU1IbmQ2?=
 =?utf-8?B?SWtvUkp3R0g1WnZ4WVgrTlZrS1ZKWjRRS29yVnUrVWdyT3lweGNCNFd6Umk4?=
 =?utf-8?B?WlBaLzBUekRFcjF0dndaSjYzdTRUR2M0UC9sSk44ZE9PUWFaMm8wRFpFU2pr?=
 =?utf-8?B?Y0FhTHd6dXpTZ0J1QktsTXY0ODNtVnlEVGdVN1pmU1ZwTld6ZW83UnVZUDBv?=
 =?utf-8?B?bFFXV1F6NEhZTkcrSEZ2bjQ0Z01Pa09ZcTRiamMraWxuMno0MTg2dXN1UUdD?=
 =?utf-8?B?WWxRMGdiZ2JMWnlGTkV3WVRzVnJSSzZmbzhKemFvYU9jUkxEdXY4bFIyT2I5?=
 =?utf-8?B?TmdiUWNtcGJEakI5K0Q2Wi9kU3NXRTByUDllZ0dyOGdCUVlJUjRxQ3Q0eVVn?=
 =?utf-8?B?OVRYQm1qUmVEVXBMWkVScVdKV3Z1Z3p0Qk4wTi94bzhJWmlXaTB2dkRXS2t2?=
 =?utf-8?B?UkdyMGlNWExYMnk0eDNoY3R1RFc2bGhHemxIN3RiNVdIcnFKM3dLcEM0anVP?=
 =?utf-8?B?Vm8rdzFORXNMd3Vka1MxekNqejdzOHRidHVVb2t0RytRdUJzWXcyU3Ria2NH?=
 =?utf-8?B?ZnE2QjZxUDF4QWhINitwSVY5K25ITHNXeFRXZWlIOWVETE1TOWJadVQrdGlq?=
 =?utf-8?B?c1NNeVRQSlFRajRsVW5oQU1hTUdqc3o1S3B4ejNnUjhlcjVLdzBOZVdnWm43?=
 =?utf-8?B?VVdpUkhaRDdpWkUxWXRvUjBsV3BIU29TYjF2TEJnUStCdzN6NlJwdlFxdFNF?=
 =?utf-8?B?cVhKdGljc2hMdGhraU5OSC9ITVNvR0VVd0QvQmJQT2NWa2QxNkVsaFdaSkwx?=
 =?utf-8?B?U1l2ei91b1R2YTNEdDFHTW5hMFcwR3NISUUrV3pzK3BpYlpVNXU1b1ZTTU1W?=
 =?utf-8?B?UWxlL1A0eTIwQ0F6UVV1aTd3OHBUN21LMlBoUmEyejdSWEJlOXJFemZiV3p5?=
 =?utf-8?B?ZHBKZ0xVaDRlMFkyK3phbis5bTBnUE9vZGhnclBJWm9lNDRramFNR01rUFky?=
 =?utf-8?B?anFkOGpXSThkMENnRDNzbGxKYUNxcnA0aEV0YitqeUU0bFE1dDdNQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6912150a-712a-4e55-25ba-08da1090c180
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1576.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 07:58:33.7832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IiWOmrPjOShNgk6EEFw5ayFSXuEVpv/0VViBR5mZX45P2tmeTtXv1GzRtLI1cU1djluZ5PobTuHQ5V4l+yLCXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4113
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 28-03-2022 12:36, Krzysztof Kozlowski wrote:
> External email: Use caution opening links or attachments
>
>
> On 28/03/2022 08:14, Sameer Pujar wrote:
>> The rt5658 or rt5659 CODEC system clock (SYSCLK) can be derived from
>> various clock sources. For example it can be derived either from master
>> clock (MCLK) or by internal PLL. The internal PLL again can take input
>> clock references from bit clocks (BCLKs) and MCLK. To enable a flexible
>> clocking configuration the DT binding is extended here.
>>
>> It makes use of standard clock bindings and sets up the clock relation
>> via DT.
>>
>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>> Cc: Oder Chiou <oder_chiou@realtek.com>
>> ---
>>   .../devicetree/bindings/sound/realtek,rt5659.yaml  | 53 ++++++++++++++++++++--
>>   1 file changed, 49 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5659.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5659.yaml
>> index b0485b8..0c2f3cb 100644
>> --- a/Documentation/devicetree/bindings/sound/realtek,rt5659.yaml
>> +++ b/Documentation/devicetree/bindings/sound/realtek,rt5659.yaml
>> @@ -29,12 +29,28 @@ properties:
>>       maxItems: 1
>>
>>     clocks:
>> -    items:
>> -      - description: Master clock (MCLK) to the CODEC
>> +    description: |
>> +      CODEC can receive multiple clock inputs like Master
>> +      clock (MCLK), I2S bit clocks (BCLK1, BCLK2, BCLK3,
>> +      BCLK4). The CODEC SYSCLK can be generated from MCLK
>> +      or internal PLL. In turn PLL can reference from MCLK
>> +      and BCLKs.
>>
>>     clock-names:
>> -    items:
>> -      - const: mclk
>> +    description: |
>> +      The clock names can be combination of following:
>> +        "mclk"        : Master clock
>> +        "pll_ref"     : Reference to CODEC PLL clock
>> +        "sysclk"      : CODEC SYSCLK
>> +        "^bclk[1-4]$" : Bit clocks to CODEC
> No, that does not look correct. You allow anything as clock input (even
> 20 clocks, different names, any order). That's not how DT schema should
> work and that's not how hardware looks like.

>
> Usually the clock inputs are always there which also you mentioned in
> description - "multiple clock inputs". All these clocks should be
> expected, unless really the wires (physical wires) can be left disconnected.

The CODEC can receive multiple clocks but all the input clocks need not 
be present or connected always. If a specific configuration is needed 
and platform supports such an input, then all these inputs can be added. 
I don't know how to define this detail in the schema. If I make all of 
them expected, then binding check throws errors. If I were to list all 
the possible combinations, the list is going to be big (not sure if this 
would be OK?).

