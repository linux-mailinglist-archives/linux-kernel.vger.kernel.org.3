Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43AA4EB9DE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 07:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242753AbiC3FJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 01:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240719AbiC3FJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 01:09:12 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51736F2138;
        Tue, 29 Mar 2022 22:07:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kL3zbeDPimeSbySZ2JnJmZN9aUktTMn6nTyW8/9t1bEx316lr3LnwHuzIDDq3LJlinr43bL8/JYaNstafA1E6xBdwTeSmH/HzJWU3aRgvlVjLSZbUYBw8ZO1HG+VkqtUmxTKDyoXb1eyfq/LeGio/eKO8SrMHfk44OLTgiqfhweVq/RU/LaQOEARXzppbXVRPzYmnazQkVqO7soQ90Fa6/Y+sLTqkW2VNCo86nj+HiDwth7Mztmw2qZ4TUH2FnjDwtk7QBjHy74p1mfe9HC0v2ZOOhk2zIh4zLe6kf3cb2l66b6woyoXUFuKExc2fMN/qsJ5cjGv1fNCygOq3k+7rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4+RvlehFAIcVUVHJ4wKFMXpcpYasO558cTuaGV+qWc=;
 b=PY4Zt8mKMZmc/ttzt9T/7XWAvP4rfoOv59zOzDxHxgP5/+72gDfH6IB2SIbgFg0l4wh/YbO7OBkAI9QRTndj4Oq4IT4mlflG8Dw3FpN3pRna9Tr+231spI7PiiRt+TsZ6GwyEtPrGqwEccV575BHq1FO6K1RPugAJlqBaqA9cNrRyG3K83wJ24SMwstoqteRrxGaqwN95FA+RO9cQvAvJYJkhL/sNZ9gGwck+80m938waOY4/AA/O68YeEaksuA2zmT7cyjUc/BMdqu1s+WcX9mJCBTthlRIds3ZIp4LuMGgLmzPub7weNNVyaJjlndJe2IAlBkiGo0ikbOir7ZQyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4+RvlehFAIcVUVHJ4wKFMXpcpYasO558cTuaGV+qWc=;
 b=CR2MYwS+rfqt8Ki5yRaK+ZnoXfKKV8eNMxAZoi1iGaxEXjRp/P3Xdm5KDAgpHRjws16/9uMe7KnLkxGZeIu9Gi9qBU9S4i8K3NNFtUov795aQXWG0c+6V9tHyj2QKNfflQAHIK9QEFXJPTwqMXFEWNYEx6zqHK+Eol7/2Bi4ZC6A9jbN8X4wgX6UFyla0TMN+1Ujypu6F+quqkAkkp/sIfe2gHpJhPrwPInLx0N+jwHBmuDUvOLjaH7szGIoMilx6RngmFpVYTU7/ySENxcEgcN2xpd062vF6zlBeKogwZWEQhjSiK2tEyE8eR34LCcnEbwzxBjq5zuqgf9IZ5e1Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by PH7PR12MB5832.namprd12.prod.outlook.com (2603:10b6:510:1d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 30 Mar
 2022 05:07:21 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef%3]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 05:07:21 +0000
Message-ID: <349166ad-7bcc-c550-8636-8342eb098333@nvidia.com>
Date:   Wed, 30 Mar 2022 10:37:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v5 1/4] memory: tegra: Add memory controller channels
 support
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220316092525.4554-1-amhetre@nvidia.com>
 <20220316092525.4554-2-amhetre@nvidia.com>
 <83bc4c12-13e3-d239-3845-a3541b1fbb2a@gmail.com>
 <981610f0-374a-b18f-8e3a-445b20edb257@nvidia.com>
 <22eb6b37-3bcd-71ab-f99f-dc059043b56b@collabora.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <22eb6b37-3bcd-71ab-f99f-dc059043b56b@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR0101CA0021.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::31) To SA0PR12MB4349.namprd12.prod.outlook.com
 (2603:10b6:806:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff37fa3a-7d56-4dfc-a28f-08da120b2b9e
X-MS-TrafficTypeDiagnostic: PH7PR12MB5832:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5832B8F4119946CF98BE7159CA1F9@PH7PR12MB5832.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CUFsezB19r/7XaQImHfc9221W+UPKsRc3yTA/OHqmyO2p4X90NqDlikgMOxRn5ztoaLAbXSJ4lV5pLHJobRq3lXzHUDgQw8tBTHw/Y9EtmOoRylOzpiqcWz6cFPhy3jaO5shs+A+JlICLDKxpwJRgZY9nYN7xbU6rd3XrF/k8MRvmm57aTNQUtBRngkuwUacA3WP5Vx5njnvvAv2Am+RFCT+oIG5qWc2POEbIEwOYgFkyU/PJSXeUAPq+F/UAOwJ/w1r3gYY4UPac+OUoDNXpe8kZ3IBdHMJ9zVwEhoE8qs3S1POOhwiTVTEkwE8h45gvuMKHTcCJHMRQ5Z/Gk5dTSE8Z8p/t4ICNwHFIt5rWegS8+p+dqVqJaEUtZ9UWbRLCJ0sd0HFZIbbDlm6XpRKeBiEl3w1k/585maoRuVVF5tT2awTjPRWWg0vEUUXn1gpBnwqglDjAIY8bDFYw9ybwApCwb2PK2mB5oLqFCQxFnNMyutVG186q/i2JUOVODI9ruWuIMGOS5WcCCGf/5z2V9G7KVUCu1VL/91QUiDDynzcr8DCoZ8GsElVKerBbaTDwjm58WYmHZAx4YCXBecV4n/VmQFCNgKxDoJ8qzjvdou9dw1UqbLOnlP65bG3FLNC355XF6YDFKhxWVFU0GhOWj06+180Q2b8D0caDhSnXJnt7szY2FfKpK6W1cq6jTKnPLFAPxvX1gg3xVrV4vTG28O79TBiNtM12ITObIpF5Lk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(5660300002)(31696002)(2616005)(6512007)(36756003)(55236004)(186003)(107886003)(53546011)(83380400001)(508600001)(6666004)(2906002)(6506007)(6486002)(31686004)(26005)(38100700002)(316002)(110136005)(66556008)(66476007)(4326008)(66946007)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGhqcTRHenU5M1pWb25vRS9LdEsvUzlpSEdaT3FCcWlyMGpzY296TzJFVDdM?=
 =?utf-8?B?bkI3R2l3ZjRQM1ljbE5ndm9mejExaStnd1FIK05WSVBKcW1pR3U1NU0xUGsw?=
 =?utf-8?B?dGU5L1hWcE5xUmNiUmxwenRGbWp5VWVESlMydWF0L3hzbFR3U1NBdzNFVXpX?=
 =?utf-8?B?SDcyejlQWnkyMm5sdXBpQTBKVXpiYWIyMUJUVWM3eDgvd0VzNmJTWG01dk1L?=
 =?utf-8?B?ejV2Z2Y2UkVHZkRsaDc3ZnZCTGw5MlViL2F0T0cwSWZZS0RtQ1p4MzRrVDcz?=
 =?utf-8?B?TmJtZFhIRWJpZThzVlhWendPYVArTlZKelZ3K3o0Nmx1YkVIS3N1WTQwMXpj?=
 =?utf-8?B?Zm9zUlRNd3BEcUVXOFZadWNqbTF1anB2Nk5ER1NCVlFxeXpjTk13b2N2OEtK?=
 =?utf-8?B?bGRYMzBXdE14dy95Y1Jaald5OG1JS2t0RDA5blVlRVNoSHNCbVVJRExOUjQ3?=
 =?utf-8?B?MStvdVNxRXBnUWFZTmxHMkh3bjZoVGtQZkZxemtDQ282b3IzVVB5UHgzMG1y?=
 =?utf-8?B?V3B2UlZ0d0pUNzJrQzV3TGIrUVpvbzViMi9ZWnBEbnlvLzVzRFFPeExjZWpz?=
 =?utf-8?B?RXZTNDloZlJqRUt4MU1vTTl3V01JMyt1RXBFWkoyTlcvTHVHNnFpQlJ5V3VR?=
 =?utf-8?B?bUgwSkxJSmphclRpdlVRTy9kaStBZC9GTXJ0T2ZUbHVSRkZFQWRkZHFMaUti?=
 =?utf-8?B?MXNadjRyK0puMlhPOXAzelNaSmQ3RlVxQjVDbFMrcGtlbEh4VE1kL2ViZERN?=
 =?utf-8?B?OEhrQnZ0azFrdVFEOUkwWEhxTmxXTTRIY2grblA3MTU1aXB6TGo3UTNGMHll?=
 =?utf-8?B?QURNaklBS1MxdVdtYWZwOFpQUEFtb1NKOHNoejJqQ3R5cnRDV2M5ZkpDa1Zk?=
 =?utf-8?B?MVIwTkMvcW9STVQxRHNlNVlpUTR1MytSZ0JmOE5TQWk1Q29Dam9qVmthTWow?=
 =?utf-8?B?M3FDeE8wSkFkTTRvc2dEMU94L3d0ZTBMVis1ajE1MmdMdnRxVTUwNWZhYjI0?=
 =?utf-8?B?MHRwTVVBVlhadDdXOW9kSHROaFpydlhlUE9URVN3ZHpTNmNGYWVXTzJ2RUFu?=
 =?utf-8?B?S2c5YWtnbTVxNGs2dEJUVFE0K1BoNVYzVFppWjNIUWwvaG9EQ0hjR3E5UHdk?=
 =?utf-8?B?dXRBMVQ1V2k1ODY2Yk5WQS9lckV6ZDYyZ3FSM0ZRRk43RUJXaU5OWGwySFN6?=
 =?utf-8?B?S2ZBYStTUW5IRUIyTnAzUmlQQ2lXUGZsSThNRmMzbkJOYU1xMDBreWg0OXJ1?=
 =?utf-8?B?QmRyaEVTdThHbWhYTjE1SVFpNWh5SW8rOStZbk9IcFdESG1DbDRHb0c1dzl2?=
 =?utf-8?B?amhOcm9oL3phaURWdDRrWDhIeXJGUEpENkNQTU5RazhYV1J3N2NTcTBObXBN?=
 =?utf-8?B?WWUxWDljZCtVRzNRMTdBN0FzOHkzazlaSHdVRGk4YmpYTjZwUVp0NVJLelVq?=
 =?utf-8?B?bnB6TjJUYk9ua1BJZWhkSjNCR0hXS090U3BWd3Y3ZW9sYzlFN0xIajZ4VHJS?=
 =?utf-8?B?U0ExcitTalVRUkJIMjBzUWwvOGg2dnhScVA0RUNZaVd4SjBmRnVySFl5OWtQ?=
 =?utf-8?B?d0JKTlFzTjM3TlIvZTRsNmdwYUhhb3ZGdmoyV2I5MWp5TEFaR0hKSUcyZUVn?=
 =?utf-8?B?bFZCVGVRY0g1UmdsaE1hTEQvdjdrNHM4TXZvbjFPS3BnWWlmdVdrdkVNRG84?=
 =?utf-8?B?Z0JXUm9NWmxIYkFEQXpFU3U5UEhCUWt6aWE0QVFiRE14cENMM1Fna0dRNXZw?=
 =?utf-8?B?c3pEaFd5VjhCcVJOYmk2cDIvZFA0ZUxaYVQ5NWlHdzVSbEh5engvSk5xVURn?=
 =?utf-8?B?cTF2ZlhXZ3FUV25XQVRZeDd1RGxMZnFIeTczWE1waFdPQy9BbnM5UVZ6Tjg4?=
 =?utf-8?B?OHJjWm81U0gvbXFKN3lNUFBWY0dUUUxSa3VJYjBTSkhMZWc4UFZNVVVtK0RN?=
 =?utf-8?B?YUludWtiQThWVmMzUjFyRlRyT0dXbHkzRUFnRnprVzNiU1IyamFaNGVvb2to?=
 =?utf-8?B?UkJ5M1Y0bG1OTHlwdVFhdXowZEFqeDBDWkZURkFOcGViNmJ2enBzOUw4SHpk?=
 =?utf-8?B?SzNhcTk0bWE1VFlHRUs5cDhVa0lra3RtNTNlNHNzUU5nS2x5bHBlQzRGY1ht?=
 =?utf-8?B?c25TTmRONFlEaGw4QkZsSnhVOGJvYjQ5eFNqRk9aTFV3emxNb01BbXE3QmFC?=
 =?utf-8?B?UEVBZTM1Rm4wQ3FvYkFNaEUyTlVtVHBVK2drUFZqYks1cXdlZjdSVzNPMys3?=
 =?utf-8?B?QktzMUVCWG44dGd4U2ZCVjUxd2FEUjhPd0xIUU9JTWJBNlYrRGhUckk1a3NG?=
 =?utf-8?B?T0hCRWtWWHVFRDY5MEE3QkwzUlFxZ1BTbGI2TVNHQW5aMHRTR0I2Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff37fa3a-7d56-4dfc-a28f-08da120b2b9e
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 05:07:21.5831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D4Nr+F3f2m2Xvy1bcZ6MhLyTjqIzjFtZ/npUE1VxWQAii9vYrNipRdtzt/UCsgv4moAK03ZoFIN8qwuSHgDRPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5832
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



On 3/30/2022 5:18 AM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 3/25/22 07:50, Ashish Mhetre wrote:
>>
>>
>> On 3/19/2022 9:12 PM, Dmitry Osipenko wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> 16.03.2022 12:25, Ashish Mhetre пишет:
>>>>   From tegra186 onwards, memory controller support multiple channels.
>>>> Add support for mapping address spaces of these channels.
>>>> Make sure that number of channels are as expected on each SOC.
>>>> During error interrupts from memory controller, appropriate registers
>>>> from these channels need to be accessed for logging error info.
>>>>
>>>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>>>> ---
>>>>    drivers/memory/tegra/mc.c       |  6 ++++
>>>>    drivers/memory/tegra/tegra186.c | 52 +++++++++++++++++++++++++++++++++
>>>>    drivers/memory/tegra/tegra194.c |  1 +
>>>>    drivers/memory/tegra/tegra234.c |  1 +
>>>>    include/soc/tegra/mc.h          |  7 +++++
>>>>    5 files changed, 67 insertions(+)
>>>>
>>>> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
>>>> index bf3abb6d8354..3cda1d9ad32a 100644
>>>> --- a/drivers/memory/tegra/mc.c
>>>> +++ b/drivers/memory/tegra/mc.c
>>>> @@ -749,6 +749,12 @@ static int tegra_mc_probe(struct platform_device
>>>> *pdev)
>>>>         if (IS_ERR(mc->regs))
>>>>                 return PTR_ERR(mc->regs);
>>>>
>>>> +     if (mc->soc->ops && mc->soc->ops->map_regs) {
>>>> +             err = mc->soc->ops->map_regs(mc, pdev);
>>>> +             if (err < 0)
>>>> +                     return err;
>>>> +     }
>>>> +
>>>>         mc->debugfs.root = debugfs_create_dir("mc", NULL);
>>>>
>>>>         if (mc->soc->ops && mc->soc->ops->probe) {
>>>> diff --git a/drivers/memory/tegra/tegra186.c
>>>> b/drivers/memory/tegra/tegra186.c
>>>> index 3d153881abc1..a8a45e6ff1f1 100644
>>>> --- a/drivers/memory/tegra/tegra186.c
>>>> +++ b/drivers/memory/tegra/tegra186.c
>>>> @@ -139,11 +139,62 @@ static int tegra186_mc_probe_device(struct
>>>> tegra_mc *mc, struct device *dev)
>>>>         return 0;
>>>>    }
>>>>
>>>> +static int tegra186_mc_map_regs(struct tegra_mc *mc,
>>>> +                             struct platform_device *pdev)
>>>> +{
>>>> +     struct device_node *np = pdev->dev.parent->of_node;
>>>> +     int num_dt_channels, reg_cells = 0;
>>>> +     struct resource *res;
>>>> +     int i, ret;
>>>> +     u32 val;
>>>> +
>>>> +     ret = of_property_read_u32(np, "#address-cells", &val);
>>>> +     if (ret) {
>>>> +             dev_err(&pdev->dev, "missing #address-cells property\n");
>>>> +             return ret;
>>>> +     }
>>>> +
>>>> +     reg_cells = val;
>>>> +
>>>> +     ret = of_property_read_u32(np, "#size-cells", &val);
>>>> +     if (ret) {
>>>> +             dev_err(&pdev->dev, "missing #size-cells property\n");
>>>> +             return ret;
>>>> +     }
>>>> +
>>>> +     reg_cells += val;
>>>> +
>>>> +     num_dt_channels =
>>>> of_property_count_elems_of_size(pdev->dev.of_node, "reg",
>>>> +                                                       reg_cells *
>>>> sizeof(u32));
>>>> +     /*
>>>> +      * On tegra186 onwards, memory controller support multiple
>>>> channels.
>>>> +      * Apart from regular memory controller channels, there is one
>>>> broadcast
>>>> +      * channel and one for stream-id registers.
>>>> +      */
>>>> +     if (num_dt_channels < mc->soc->num_channels + 2) {
>>>> +             dev_warn(&pdev->dev, "MC channels are missing, please
>>>> update\n");
>>>
>>> Update what?
>>>
>>>> +             return 0;
>>>> +     }
>>>> +
>>>> +     mc->mcb_regs = devm_platform_get_and_ioremap_resource(pdev, 1,
>>>> &res);
>>>
>>> Can't we name each reg bank individually in the DT and then use
>>> devm_platform_ioremap_resource_byname()?
>>>
>> That can be done but I think current logic will be better as we can
>> simply ioremap them by running in loop and assigning the mc_regs array.
>> Otherwise there will be like 17 ioremap_byname() individual calls for
>> Tegra194 and Tegra234.
>> Will it be fine having that many ioremap_byname() calls?
>> Also, Tegra186 has 5 channels which are less than Tegra194 and Tegra234.
>> If we go with ioremap_byname() then we'll have to differentiate number
>> of ioremap_byname() calls.
> for (i = 0; i < mc->soc->num_channels; i++) {
>          sprintf(name, "mc%u", i);
>          err = devm_platform_ioremap_resource_byname(dev, name);
>          ...
> }

Okay, for this reg banks should be named "mc0", "mc1", and so on.
I will update this in v6.
