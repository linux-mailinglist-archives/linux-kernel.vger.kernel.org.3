Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7754E7005
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 10:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356988AbiCYJcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 05:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356485AbiCYJcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 05:32:50 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740E2CF4BA;
        Fri, 25 Mar 2022 02:31:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxaaJrWJ4daM0+JPzr2jZtpTf4VVysskQZ2lFwGSGDb+aoCmx8jv4vTC8nHKfcc/CmtLfW5DuifGBQmJU/dmxddQ0djRpRELttRvZifE0YzApXsYVlRvf+aiPrIP034he6iNhS+Ho28scPFSPSe2l/1zicxy73X5yEKIGWJ/1l6cG5814/SbwrprQErnOOwzn3ojefhq3XDc3tu6DexxqbsXyOSuqWCQTlPQQKTBSjQQJCXQUqCLVOjYZrnBE9i9XfH6h740JGLnVC+46DzTb/vpmV9lQtH4aTVxspnv3+rjJ6KP1lQSZz5BlUJ790sASF6F8MyL78zD/mdHLlGGtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pI1GtszXArGthdQRcriIeazRE2oNvGP5QYDkkfDv48=;
 b=gyD825LCJd8NpnuUMGc+nZJBjv+NdPW7RyUJaNCb3lOdwOiQQlNMQr0MMy64QGkVnwJ0gTOqm9103zOZphrjvJIQqoD2rET1hgudlVHP2zeLZ3x0i7oVAVp4nA5eWaO0lLad8+wbsBeQArHnIVsPt3FTCGzGlCIbSgE0Pk9VSB6aSWETsF8pGdA/SaOKnqFWMSSvp37WlNaUtN4x+2UcP/8759ieh7ksGXJ/SeRIQXrWQHPPHdPDuv4JVscIf89XTtHTiw2i4ZKdR+RSKXxGWZJq5T33fcDC5uU5FC/MT2XVmICRFcJ0EXNEffD27ptc/VUMpeqGdfmAs7vcHtd8Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pI1GtszXArGthdQRcriIeazRE2oNvGP5QYDkkfDv48=;
 b=sBigI58A6rEAHzkjcMMtnA7OjRiMVF08Uf8FZDEvv5cdUFJ1YPaCv3FixK+kI9VXd7piVWqesOz+0KnYWAOS1yU2eX6znkm6+26CoAaNVqnoLY7OaQwN4haVh4F5xcznGLxYfQcHxAmvvCzm1c+XVkbZ2TM6o4YKlrdvLi8n4369OKpao4mvQqp1+v6TGseOQpfiU9EL7Zf+g1IZPdkMrRYyGdTsS95hPhlM/rhdi3dz+ETdRGb7hRxPDQrnDSYEXwK+F3z5KBBH1E2yX1Tck/Z8wcMbObqqWNZL7UHHHxqxPa20zSpYTWDT4LvVy8fsQwesh5pVydhE6CLxlcdCqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4437.namprd12.prod.outlook.com (2603:10b6:208:26f::17)
 by BL0PR12MB2529.namprd12.prod.outlook.com (2603:10b6:207:4e::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Fri, 25 Mar
 2022 09:31:12 +0000
Received: from MN2PR12MB4437.namprd12.prod.outlook.com
 ([fe80::9c66:21b0:b8e8:ea63]) by MN2PR12MB4437.namprd12.prod.outlook.com
 ([fe80::9c66:21b0:b8e8:ea63%7]) with mapi id 15.20.5102.018; Fri, 25 Mar 2022
 09:31:12 +0000
Message-ID: <32e425be-5d78-e1e0-6ec4-70ea21895e15@nvidia.com>
Date:   Fri, 25 Mar 2022 15:01:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] arm64: tegra: Enable hda node for P3737 + P3701
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>, robh+dt@kernel.org,
        krzk+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com
References: <20220325072141.28597-1-mkumard@nvidia.com>
 <f35537de-6352-e6db-b4a6-17b1ab96deda@kernel.org>
From:   Mohan Kumar D <mkumard@nvidia.com>
In-Reply-To: <f35537de-6352-e6db-b4a6-17b1ab96deda@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR0101CA0021.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::31) To MN2PR12MB4437.namprd12.prod.outlook.com
 (2603:10b6:208:26f::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e0ab9dc-efe4-4557-8f42-08da0e423390
X-MS-TrafficTypeDiagnostic: BL0PR12MB2529:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB25296037263891D2AC90E5EFC11A9@BL0PR12MB2529.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6FaBgYPLlCxBbvsz/iuVtnzJrbjm2E20oOwXFR7Pl3tnPCPG/cnaehhDg+ItOKcOlOF7u2eUfrlnVHnkC6ZZKE0HyhraFrfBahP2ekty/XivM6D4Uq25Exzl5nqTZUoBbGZm8hvEBdxuNdKUJdu139LsU+EE5SZU50ajk9Y269Hr1O1nudXcJNhLO9g7ddY8i2go0psBvIx/BpaFBPtzSMayrolEx5jbBw4smThguEBxZvwOggN3Y4+daaV9DR52hy7ccJNR66cLrApi6Muc4+CfIDOEghY9y4INFh0Szq1ht69SitmP2HyG86YFnGIKZVBlpnQG7j3IChB4QF+dSyc5VNkgU8KOuSbApXrZU431V2Kb7NiXUDF3JQecsdmmun+Z9YC1nj26lE5S056kai/2l7uOTDPM7ussH5lOrKedXGMSeasQTZB0/rrjgA+Xtr+Olln6dfXkfRRasub58Xn+genl0c4yZWmBMLECssIBGbMKEWsQE6//HsY3eCt0xoWz3EPh+Fdtq1oFmZH3ylbJ48HqF643A6j6msSRkDuNJsdrQCDbB6ffBq6HjRLN1OYijCQDNltgtZHmdlFHM8snyjfDltEkT3lmWD2ZW/s8Hanjmzzjd6CTOyQ40QPIBE/Ip0mUwx6Sp8HRo4eKZ3JdKFpe7T0+E/Vrhv4j0ayPJPkret/2UgxSAKz4jeq7IQ5YsXTvsXYOX7ISqdhYO3UOJzIgTQpvf+KETqsQ2HzqjBAQOXaJ8GFT/mn6ebvm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4437.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(107886003)(86362001)(2616005)(31696002)(316002)(2906002)(26005)(186003)(6666004)(83380400001)(6512007)(508600001)(6486002)(31686004)(66946007)(66556008)(4326008)(6506007)(66476007)(8676002)(38100700002)(8936002)(5660300002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkxnOVQwblF5cFlBd2x4ek5zRldZOTM0OW40YktjQ1BYeEEvRlhLazVwZG9V?=
 =?utf-8?B?M0NmRWVVNU9weWN1a0dQaGNzL1NkanJsQjNvTmRRanlPRUhGa3JhYXAvMi96?=
 =?utf-8?B?NjhXbkM3Tk1FVXZHdHpTNGNJc3BnT1pFRmYvVUZUOVRoOVZMbWgzMGNDVUxh?=
 =?utf-8?B?WWJqdktHdTJIU0paNjhDRVdlMnJ4elVuRTNlR2VrWDlFSGNTd3RaaXhxLzhj?=
 =?utf-8?B?cXg4UHp2T1dIVTcxRTdLTE5nemNXVjZhMzRmeWxTOWY4d1U0QkJsVDNaeXNB?=
 =?utf-8?B?eWhDbWxwL1oyTDRPazdQa1RYVnFqZTlVbnhzbjNYWkF2WmNlR1l5N3VSamhr?=
 =?utf-8?B?ZFd5dXpxM3FvT0NFMGU2RDEzNE5LUHNXN3VNZW1CR2tFRStnUVI4amx3T3ZW?=
 =?utf-8?B?cDJ2Z1lzWFFFcmRXWG9lekRPdENGbUFWanZ2OE9rWm9ZNFlIWXp1Z3lsMEhB?=
 =?utf-8?B?UG9iekRVelpkdjJBamlqbXhpRTduUHlzOStGbFZCZDJOUkhFZ08zWTNoNENm?=
 =?utf-8?B?dlVmb2xwWm44R0NZcXdhYXZWYVZ1Yk5mcnE0UW0xTHNaTXhEOC9GZkNvRjFp?=
 =?utf-8?B?TG1XMWxIMUVxUTJ4QmR5U0w3VDVpVlI3MGRHemxwOHR1MWIyZ3hBY3NnRklr?=
 =?utf-8?B?TVdkczBhUm5jS2NtRW40NVl4MCt0MFV3QmZoQWF3K2h5L21VN1lNaFhSQkxZ?=
 =?utf-8?B?ZUNoR2plUlFMMDduTjdUUk8wc2o4dFdpVHFaV2tIb2hiNTh4eG15RC83QUJG?=
 =?utf-8?B?YzZCNjY4cXhKWVJTWDhqQ2NHN2ZyaGFJQWgrY1hEMXQyTDZOMUFOK3JZeHky?=
 =?utf-8?B?SGlrc0Fra0VGK2k2YWhxem9lVFBuOXNVZzc4c2ZpaDRvdU15ZmJPY3VXU0k3?=
 =?utf-8?B?Y3NmWTFBdUhuZUlvL2FzTkRyQjNZQUMrOTRRbHMwMEMySWE1b1VLeWU3aTky?=
 =?utf-8?B?QnVQR2NqdWFyblkwemdxbklMNmp2Z3RJTGVzRWRvNm5oSHljVHZhbUFYWm1s?=
 =?utf-8?B?bS91ZWZ2YUVqRlRBY2hqalpwWkN5T3JRMEx3Skg5N1QwS0tYemRJeHQ2cnB3?=
 =?utf-8?B?bk5yZG5JZjFUQW5JSGNKdFpQTjRxRjNqRHFZc3FzUy9tRk5EbXRUOWJuREsy?=
 =?utf-8?B?dGswOHVtWTRFMmRKQzNWYVZxaGc4VTVtdFBjdWtsb2hwWGxiMUVtMklPWjhx?=
 =?utf-8?B?aE1NSFU3Z2tBWXFkRFQ1bzBGUHlXaFVVS1p4SlM5Y0Npc2pNY21lbjI2Znp4?=
 =?utf-8?B?VThHcWV4cFlPT2VIRU9ZbUxZM0tsL3RsNUFuY0NFeEMweGtYNmc4cXZZZTJM?=
 =?utf-8?B?TXN0Q054ZCtUR0hJKy9ZWU1BMDhXeVhzbFRnUXhBZjUzZDBPS1B6cnVLb1FD?=
 =?utf-8?B?d081ZlpTelF3V1prNDJXRmM1RitZRVpOdTVuelJFUEpyWkY3Z1ErL2RDNmxH?=
 =?utf-8?B?Yy9jb28zbWovUXNnWFd6MVdXY29naFhZdFFOVTNjSnQ3dkNjNzhuN2hKVGpm?=
 =?utf-8?B?ZEZOU2dqdVdqTityNERSWGlzbG1kdEo0MUowZHA2clQ0MHJkRjFmM2h4UkVk?=
 =?utf-8?B?TXM3Tk5HenVhcmFuaFpjdmRLQkRpM1FPWG9wR2FkMkVFTFFzdFhyRUVmRDVU?=
 =?utf-8?B?MmJpVTZRR3BBZ29qbG8wMmFML0pTczNnb1FXcWsxWTBkVGxmVG4zY0lXSnZK?=
 =?utf-8?B?SXJEOVo2bldpakVPSlM5Vi9LQVRBTUR6TmRvMzJvVzk0SEpWQnhQa0l3eDZ0?=
 =?utf-8?B?Q3c0L2JoWUxzRS9ieGdHaHY5cXN4NDZqTGlhL2Fha3VaVGZoNE5uSWtjOFU2?=
 =?utf-8?B?dGp1d0J3NWNmNlBGNmZCVElTUkdlZFN5Z0R0TWx1dHhwaVRSQUZJN0xjVllu?=
 =?utf-8?B?aThWZHVOUjhLV3kwcjFGZFB2N1B1VnVaZ290NHkxK1ZVczRWemU5aHNuczd4?=
 =?utf-8?Q?nt0ArBwiRPNsPmAQmUUFr3PQjCR1HZne?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e0ab9dc-efe4-4557-8f42-08da0e423390
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4437.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 09:31:12.6162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iq+ALFroEw6M0JhGdD1a+gfRy//yxQpWhE6q1iXyrXm2Pu0wZv61E/R5lNveZT0NU8ZHYUm0jy7rpm5hODmpJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2529
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/25/2022 12:56 PM, Krzysztof Kozlowski wrote:
> External email: Use caution opening links or attachments
>
>
> On 25/03/2022 08:21, Mohan Kumar wrote:
>> Add iommus property for hda and enable the node for P3737 + P3701
>> platform.
>>
>> Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
>> ---
>>   arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts | 1 +
>>   arch/arm64/boot/dts/nvidia/tegra234.dtsi                      | 1 +
>>   2 files changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
>> index 34d6a01ee1c6..156d5d95fde7 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
>> +++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
>> @@ -1751,6 +1751,7 @@
>>
>>                hda@3510000 {
>>                        nvidia,model = "NVIDIA Jetson AGX Orin HDA";
>> +                     status = "okay";
> Nodes are enabled by default. Why do you need this?
hda node status is set to "disabled" by default in soc dts file 
tegra234.dtsi. The enable is controlled by platform specific dts files.
>
>
> Best regards,
> Krzysztof
