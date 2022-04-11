Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7934FB736
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344318AbiDKJVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbiDKJU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:20:59 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2073.outbound.protection.outlook.com [40.107.100.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B302CC87;
        Mon, 11 Apr 2022 02:18:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJjrckAUIF20lCKkmC9wv8VPmAHEwQMCB3K0vq2KmzQYWsH11cqlkWXT9ofzqA44PWlkh4/0HKFJGAW8A0zXARtc/+v9wThfoOkN7FEo8TDgjWWgoA4tjWBamwItAvNX1VtVopIeQb9BJ8m5pia+eAf8tnOd2IOfiZwvyPMhLL6vhGvSLYA1GH21INgPyr7cH4LmfUZhsWJtNk2G7wQ84ZlBeMDZYCT5aeiLJs3ri9hG8LVxlL4rVZuhBBicHEB/ekUJzvKK2iMFJIvuEuWSv7jHK6s7gJ5bhypSULzXdqlAxqpYzndQYB8UxWAAbm1SRd7c2CuOa9qOsqAcrxJgKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYihiIgFzQ2wo7fdbF09jXIxG0+Gq0PcsOKTsd8EAM4=;
 b=bUGjdr0DHsBBx5pkKSdvASXukLOIpIlpFRANLe0E/gBBh1lPgBuZHt1h1laQmMuO+/zaiKjqCRci1Et5ShvLLHnUSBq4ea0Naia+fJsuP28b2DiKUMLHrC6tvxJOExfF8FYSV++aCGe66AjthlE+f3Xa2B+Q5tzRbS05bmERfZPpSLdiEzwYtjEpWM+DnmKL7E2WO5TjyzMW5yCi68Q93JiPWF4WWpwRWEdjkmwulHjmTvFVbvHj+cZgm/c+BpITcN+rNTKYsEFouLoVv428D5qAofMpLGdyYGBtDwk17w15Vk2J/k/71SAw68NTmY9PQ4gA8jdMSFVvOiZqJpADZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYihiIgFzQ2wo7fdbF09jXIxG0+Gq0PcsOKTsd8EAM4=;
 b=eENLSwLK6hlACtoJD2AUF/l3ZOL7zCYo0F53AgP+YndekKGRJekRzEz1icChMXTZaJnc8iaBLTFJVZpHRtdCoTwJN1IN0HaWdc0zcijDJlpTQkGLQadTHDpmuJdFAhS/jc7/jvt8jMFjDpg6vR/vguBeIi0i4VcKonlhfNCKEzvmRex9fU97ihJ1R08nPdn/gMWnUQfbSYOw4AvhG/FOP1/Kkl4eGHJdOnEJBd1eG9Adqfc/mYIJgdKJ9jojWF3oHdSTzjWLM9ScdEgHfBIBNBTziUJg8qFy/tjm4q5sfugw7+r8uX5bEp8exAwXwM9F0YZfSvRT6pceTuKl5Cu7Ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by PH7PR12MB5877.namprd12.prod.outlook.com (2603:10b6:510:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.28; Mon, 11 Apr
 2022 09:18:43 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef%4]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 09:18:43 +0000
Message-ID: <3414a89d-bb80-ec89-3605-e435c7656321@nvidia.com>
Date:   Mon, 11 Apr 2022 14:48:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v6 1/4] memory: tegra: Add memory controller channels
 support
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        krzysztof.kozlowski@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220406052459.10438-1-amhetre@nvidia.com>
 <20220406052459.10438-2-amhetre@nvidia.com>
 <3bbbffff-6aa3-7068-6f0c-4372d53daf94@gmail.com>
 <ba28886f-be5d-9ab2-41d0-942609934263@nvidia.com>
 <0ce65e42-6567-9fd5-d959-3bc5aa0457eb@collabora.com>
 <16d5c86b-cb04-5f57-7923-724850ce2633@nvidia.com>
 <185f72b6-e6a1-3062-5f36-864973d12ec5@collabora.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <185f72b6-e6a1-3062-5f36-864973d12ec5@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::8) To SA0PR12MB4349.namprd12.prod.outlook.com
 (2603:10b6:806:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0b73a3e-4801-4693-1468-08da1b9c45c3
X-MS-TrafficTypeDiagnostic: PH7PR12MB5877:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB587792DFC70693A663793778CAEA9@PH7PR12MB5877.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GID/BxMJngsO55UC7jCA2Ljb3yiP4ZBnY7bYE165jLxCC1mkZJt4xw/x3rDEkgyE7pVfP3jnjCiC0yZyv3DStalBHNBShR9XYPG2tFDzATqCrvb4Y1HXQ7EQ1WksIELS/cEUt++mhKE0g/LmIKMpECngL5pbJC+KWnXpRxyBMmmYEq76l04YNPWMbnxJWYpMJlcE6+C5Q98Bn4pFxvJBSVQW8L4iNHlPvuZj6l6nfDio3yhWYzawzeR33MtVkvuOAiGzFsKJmUDUw4XvXx+/eCmmQxOZ5QrbZaAJ9be9eRsWE3h9rplcGUcnN+vPebiUHf2o6fKBE8IBUUgNxbbnJCifsfLjVjqm/8ykV6xXnnH+MtfBENfcg9Hk7kml0pa3srM2rFvlgaT8mU5nN4qHHhKKOnSBYjVLSmSGHco598Lx0v17PqF5JW76zPPMp0LUlorYNVmOKQUcDkzdYJ8Wf4gO35UklUm2EfMHtt8nmR/Dkzjig8KIuiKNrLm8TwOJ0s4WvCXyjolU0Uy2r9M0zA/wK4HDu1K4z7rC58nPbh8lk5QwGKyFQqTn1+1jb8VF6xaC9t9nkBMC5B6uD+0UYQRhIibJfnN7PMZ3KOqgx8mHJ5DDLROhCrSIp3kxUVEPVsC5Ys4IKi535T7Qc5i9cqazctSV/fGe8fBFa7jlkzhMOxlW5TGMjMaApYoKR8mWpNbUNfK3qULgj4NLEqx/3ppG9Z8I9orCL/4lv9jf7kvxMEl8P6IU7SvP+/+l8eJkfJO6/dHVfSgabdXsrJEDnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(110136005)(921005)(6486002)(31696002)(38100700002)(8936002)(4326008)(66946007)(316002)(66476007)(8676002)(5660300002)(508600001)(66556008)(26005)(186003)(107886003)(6506007)(83380400001)(6666004)(2616005)(55236004)(6512007)(53546011)(31686004)(2906002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVZKOVREYktYY2FBOXp2U05RdjJYUlF6ZXdXb2hjOTZPdURkL1FhdXluYm8z?=
 =?utf-8?B?NnQvdzhocHZ5NWZWQlc2aGxqcDZxaGNSN3JuNzdUM3VVNXJOakgvaHNHYy8r?=
 =?utf-8?B?aGowdXpVajhLek9iMk1BWFJnaW11b0RvQmJKd0o2K0tzZHNpaGtFT08yWmlY?=
 =?utf-8?B?c0haWEtZbzdqcXc5RGJjQzdvdldwa2tWenNYVmpuQ3pPWXkxczVPZXhOYTNm?=
 =?utf-8?B?QzBrZ3JvZzVORDFZdThpc1pIQWlEODZIQzZnQXBjdHBaU2hScnU4bnBUbks3?=
 =?utf-8?B?TW5rQmNYVHFVeElmems1b3liVE9xS084RVQrMTc4c1BZMVg3Ti9Dd1hPWEc5?=
 =?utf-8?B?SUx6d3lqQ3N0VUFjMlMxTmRJOWR2dVo5QW9WdnpGN2o3YldCTGlrajdmenhn?=
 =?utf-8?B?NUhySlBuMnpCQmN4WXkzVzhCYzBmaFRUTFR2S25oSkpKTmVLbkhqK2hiblFy?=
 =?utf-8?B?eGNEMkliMjFZSkRlTmY2em5taGd0TU1mQ1pPU0t0MmM0WFVIWVpEd1VtQUVj?=
 =?utf-8?B?TUo3a3pybThxZDVQNHpYaXpRcGQxRGpOZEwzbGl4ZU9FZTcyTG5aMUJMdGJR?=
 =?utf-8?B?djNRYmhFMXM2S2xycFFtaEpOYjZEWUFGVDdNTmw3SnlMWTJqYW04c00wTyts?=
 =?utf-8?B?OUxqcnh6L0h4b05qRWNFcGNhckpici82VW5saDZ3dFRkSnc0OXQxOVBwUkFt?=
 =?utf-8?B?VGJzTTg5UFVMbXpVTkx6aUNteW1XS29YTjNOYnQvdXltYjVtNFA2cVlMWHEv?=
 =?utf-8?B?U1NzVGVlSmpldFRmNHNNdnRqUXlEcm90SGtWbFg0NEJlc20yY016ZUQyUFIx?=
 =?utf-8?B?MVVYWHNsU3dMcTkvUHZDWERzMVpBbFNaZTZKOUsrWGZWUHRCc1EzdWNodjhx?=
 =?utf-8?B?ODA2TmU3SDBOZEVYTjRVT1dNZDkzWVVLMlBmaE5YRWVLa3NEbmZXU0RkNzdX?=
 =?utf-8?B?bjFncVBVVlMrc2Z3Q01TVkx2UEdDemxBdXhScVdQWE9UbGhzczgrVkVXdU5K?=
 =?utf-8?B?dFVHOGFmdksvcVVYRzQ3Rk93WjlMM3VpS0IyY3NRQWZ6Z29tUDVBWnRFZndP?=
 =?utf-8?B?VFpVTTcwL1JzdENPSUVCSDJQZTVyNlZxWG9aTjlmYmtMcjdBUWUwaW9rUGVY?=
 =?utf-8?B?SGFtZWxseUhTK1FKUWhJNVRVbmxPUTVaQTZ1blRvVW4xMllMMDJpdld6a2JE?=
 =?utf-8?B?TVQ2S3JpVXNWSGxudHRERjFvUkN1YmxQUnQ3Z090bWo5S3FEa2RaUFd6K01Z?=
 =?utf-8?B?em9DNm9WZnI3ZG9EaW1sZTZwWkhPT2tMMEtDQ1dHWDdJT2V0S3hrazVvV3M5?=
 =?utf-8?B?RS9jUm0rWWl5Nm9pZE12YVRweDBhK3dKK1hsUWlzdGUzTDF3NU1JQTgwUmM1?=
 =?utf-8?B?d3ZqSjZJanRhQmcvZzRhWVNobVY2ejZJQkozTUdFKzA5R3JDUkZKRFNKSnFl?=
 =?utf-8?B?UmV1OGR3RzNiU250MU0rRjVPcEtNYm1ZOFhuczBPSlBySkpFS1lnZXN3cGxy?=
 =?utf-8?B?ZnlYRGdlN2xCZFhUT056RkRtVFlSSDk0RzJBVFNtQndKSzRkUHcxT002TnBh?=
 =?utf-8?B?Rkc5ckxOc0Fac3JyTUZiWUllUTdvZ3pqY0VwWmJPTEZ6T2lGTDNZSFE5QWp5?=
 =?utf-8?B?S3YvNm0wOTNDQ1hXVGJQWWpRUTZQaFprOWFaTTdPZlFVdUUzRlptTG5DM2U1?=
 =?utf-8?B?a0FmZjF0bzl3VTJyTU9ubkRhSEFwUnAvWU1UVEh0aDliQUxZMGV0R0hsWWJh?=
 =?utf-8?B?Ri8ra3VDSUd6aHJuSnk2dWdOVEs5bndhWHVhQXNQQmJ0Q1l4Z0l5K1pEaVpX?=
 =?utf-8?B?QVBBald4UkhORHBka2tmaHlMUEZwUDFvS29OVi9iNmVKVDlOSWhmTWtnbzVJ?=
 =?utf-8?B?TjBVM0ZRS3hMcUVyV2l3bGFUaCs1bzJvd1BDTm82UlNkVEFEMjRTMEdFcllr?=
 =?utf-8?B?bkNHSnZmcklIeGRUdUFQVUs3WmgxVGViZUY2cmFlcTBuU1ZmdUFZQVNEM0dE?=
 =?utf-8?B?ZWZkUld6Zi80dlBFcmFFdVd0dVVPeFNkUDJUdndibEg2Q3liV0hXSVZ2SE5R?=
 =?utf-8?B?WkhDOWhRSGtOUzE4Mmo5RmpSZW55ekRzRmQzYThjZ01BOWY0RHNaeVg2dkVV?=
 =?utf-8?B?ZGJTa0hlMnAwcVZKNWpaS0xOMVRuNm1VaHpWVEVXZHErcERsYytNZmRBYjVX?=
 =?utf-8?B?SUtKeVFnRjZCWE1iZWlHMDc3Slk3N2E0MDEvb2x0Qm9Qc2l5MU45ZDU1d01h?=
 =?utf-8?B?Z21ldkNQNHFvMmlzMnowOGgrTVVEUHVKaUtFL1RZNEI5dlg2cXo5ZkxBZW1u?=
 =?utf-8?B?dldQN3R0QUFyMkFuN01RdGJ5WjdnN1NqMW9ybzJKTUZWdFlxVTVRUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b73a3e-4801-4693-1468-08da1b9c45c3
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 09:18:42.9212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 88ZdKragvyE4J+ieyqhNZv2o5GSHEWdO3gqIFE9uCIhL+98uh30W4eaI5B0m7ujUgvsirBfYDFB8vvo7KTcNVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5877
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/11/2022 1:05 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 4/11/22 10:28, Ashish Mhetre wrote:
>>
>>
>> On 4/11/2022 12:03 PM, Dmitry Osipenko wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 4/11/22 09:05, Ashish Mhetre wrote:
>>>>
>>>>
>>>> On 4/10/2022 7:48 PM, Dmitry Osipenko wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> 06.04.2022 08:24, Ashish Mhetre пишет:
>>>>>> +     num_dt_channels =
>>>>>> of_property_count_elems_of_size(pdev->dev.of_node, "reg",
>>>>>> +                                                       reg_cells *
>>>>>> sizeof(u32));
>>>>>> +     /*
>>>>>> +      * On tegra186 onwards, memory controller support multiple
>>>>>> channels.
>>>>>> +      * Apart from regular memory controller channels, there is one
>>>>>> broadcast
>>>>>> +      * channel and one for stream-id registers.
>>>>>> +      */
>>>>>> +     if (num_dt_channels < mc->soc->num_channels + 2) {
>>>>>> +             dev_warn(&pdev->dev, "MC channels are missing, please
>>>>>> update memory controller DT node with MC channels\n");
>>>>>> +             return 0;
>>>>>> +     }
>>>>>> +
>>>>>> +     mc->bcast_ch_regs = devm_platform_ioremap_resource_byname(pdev,
>>>>>> "mc-broadcast");
>>>>>> +     if (IS_ERR(mc->bcast_ch_regs))
>>>>>> +             return PTR_ERR(mc->bcast_ch_regs);
>>>>>
>>>>> Looks to me that you don't need to use
>>>>> of_property_count_elems_of_size()
>>>>> and could only check the "mc-broadcast" presence to decide whether this
>>>>> is an older DT.
>>>>>
>>>> Now that we are using reg-names in new DT, yes it'd be fine to just
>>>> check mc-broadcast to decide it's a new or old DT.
>>>>
>>>>> mc->bcast_ch_regs = devm_platform_ioremap_resource_byname(pdev,
>>>>> "broadcast");
>>>>> if (IS_ERR(mc->bcast_ch_regs)) {
>>>>>            dev_warn(&pdev->dev, "Broadcast channel is missing, please
>>>>> update your
>>>>> device-tree\n");
>>>>>            return PTR_ERR(mc->bcast_ch_regs);
>>>>> }
>>>>
>>>> return 0;
>>>>
>>>> to avoid DT ABI break, right?
>>>
>>> Yes, it should be "return 0".
>>
>> But if we "return 0" from here, then what about the case when ioremap()
>> actually fails with new DT i.e. when broadcast reg is present in DT?
>> In that case error should be returned and probe should be failed, right?
> 
> You should check for the -ENOENT.

I checked __devm_ioremap_resource(), it returns -EINVAL if given
resource is not present. So should we check for -EINVAL instead?
