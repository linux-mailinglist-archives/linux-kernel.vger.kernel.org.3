Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A815004F1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 06:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239804AbiDNEKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 00:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiDNEKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 00:10:14 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2042.outbound.protection.outlook.com [40.107.95.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97121FA7C;
        Wed, 13 Apr 2022 21:07:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3tmkQwrGm+WbqC51b5weeBTj+4EIQpLuK/prEzs0/hOSVAuPVjwFRgol3Y2iAonFdv4NZ5YJwroInXOFycElFsf3GnXUK8jIF8IIC0ruu9NVSN6jSaRCDu7qhg9Z/fDWRRiKu8eY+Z8rdCOumIpbmB1S7JBOq4UQbPg6qR6N9eN5M/6beweJtEXO7JCji4ppSwMfla2Bzy/rZI+ax2ty6v/zSZkodxuvxKOyyOytLzaCJ7yOJvtBko4pUILf9VWLyC1/8q5TQYfN8ZORB8qq8qNw2OyEN2g3Xh+3Pvk5xV9bU/vosYiqOUInwn02XY0edsvCo+WdW+vSMh6XnjLnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlbcfHGrdomf5nZUru5aa8VW3zrPy8eVB7yeCFJ7TFM=;
 b=ncI4G/c+9kw1xb7secPg0XdvqJpmZ+hdFuHDNTMmXvkRF32NSTm6avJhqb6PK9IXCn3IbTHhoDKLB7maG6DTrn8gpxmZy+nNrLTXnuKgtwprVfEYtFNfvpfgqwDz4+pu14qp9a6oTZd2Y3A675A7Tffn5A4fhe8bPj9otRD8/5X0kb8t8cpZ/m2hzcLZGrvic1MUCb1WMcGqPPJB1yWyd/IrKbx0YnQHNn10dG4ixm1T22nRPygLtzEYs9IpJkRl+T8NL6o2zixLkRMJDmQO89HIIYq5pFNni0IbArGMwAj++8NqmWjJ+nt2ssSmW3HLoN++i8RvgALZpmDRLadTtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlbcfHGrdomf5nZUru5aa8VW3zrPy8eVB7yeCFJ7TFM=;
 b=RL+47+ph3cD460iEAsjOqK6mCQ6EeszGsHxsKnnW/bADmg0U+jVn1dagAMddZ0EQXmnXV9PgDBzqpgoffmxlbdN098R/763ZImK64wfFRr5v9uooguqYEr+CvZgp61G4yLjU4PNKmGzlE8YfINK5BpdjPMbXACP2xXMjWa6gGiE+ouac5TGG2YmNQGIhV9jQLwKDKKr+bg9ei+tSz7HPidDquLMdUlmxx7w5opw5aPr/o/gQA0hg4H4udRvhxa5ZwOcIjAr4Pqh6Q7obYprRy9p/JInXOLhTRPARUF4EB1XN4TQDrM/uguRRpgJfulfnJzbR6avnxg/wQL4yFXaZ6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by MWHPR12MB1872.namprd12.prod.outlook.com (2603:10b6:300:10d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 04:07:48 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef%4]) with mapi id 15.20.5144.030; Thu, 14 Apr 2022
 04:07:48 +0000
Message-ID: <e0faf79f-99e6-a0b6-0842-ec9de644f7f3@nvidia.com>
Date:   Thu, 14 Apr 2022 09:37:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [Patch v7 3/4] dt-bindings: memory: Update reg/reg-names
 validation
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Rob Herring <robh@kernel.org>
Cc:     digetx@gmail.com, krzysztof.kozlowski@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220413094012.13589-1-amhetre@nvidia.com>
 <20220413094012.13589-4-amhetre@nvidia.com>
 <YlbSGEBKgpVC51dZ@robh.at.kernel.org>
 <b050247d-a62c-62e7-7750-24cefcc93506@collabora.com>
 <71fc3efb-5110-287e-0422-10c1ae90139c@nvidia.com>
 <ae1d1098-f8b5-f41a-c33b-0f4863a43d5e@collabora.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <ae1d1098-f8b5-f41a-c33b-0f4863a43d5e@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR0101CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::28) To SA0PR12MB4349.namprd12.prod.outlook.com
 (2603:10b6:806:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 889dd9ef-5e82-4b74-5f81-08da1dcc561f
X-MS-TrafficTypeDiagnostic: MWHPR12MB1872:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1872714CB61C5A10FC5A4617CAEF9@MWHPR12MB1872.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X0aS2nF6x+sk37fBryLTvncYyB51ExLm3vD5SxQfkBNNgcFby1SFtGxYjYgU1UG2key5VnDHGL1WADgg20plOlDYGxQpFMUIyLdbtvkVSRGRnhaWu7PN655BL2cmIFcR5NyTDUTBLs90vLmxKgxG+OKC8pmFg8Rst0DRbbJ8385bW5me3d4UUUoAfIGI74+CEDxalQaYpzLejg/jIFbooJmawSz0MbcOwWvdnK5N+c41uHdYOvRh0Rj2+mlDtBP8eAYkvKuguHw3KBGZx5o2mMNZ6+EpcNk3qMr+4MCCyNK7iTNLRRCs7R6NF9OPV85F7OBHNXI1pIYxCE1gcVAjZ5Ul81Ih8FrWdZyaGPgdxrmgs9lBVje/e6W88yZD32E94YZHCoYIJH+4f44NXCE7/JvApmonVa54wCUafmrRNuKgNQldbBvW/XlWbHS/CtCBqbf5KOh95h4Het07uFqieXGt59/0fl+JIB2c6La+m0UbwIkJca/al/lrSZIJmAWumt25F6GRwFDNTWNi90Y3+vMSLag+2IOgB1WYgrvLaeREhR1RMGWHm4lcPBbTMtPVEySCiTFsL4AICCH+jrwMNVC6i4uPhlu3jIlVuD1getyqJSY/q0ju8zbk+T49RxEpLsVUP0Jzc6ks0gyaNzr/tySS7TZyxIrq7hsfac74i/49tzScOPDDN1SuD2jq1LINck7fx1R5wU5qVUI0g8lafZ1InPSJ1qUmrZPkJy0zIkp3MDU7rYwxAT/nYOkeWZCB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(6666004)(6506007)(53546011)(31696002)(83380400001)(316002)(2616005)(110136005)(8676002)(66946007)(66556008)(66476007)(4326008)(5660300002)(107886003)(55236004)(6486002)(15650500001)(186003)(86362001)(26005)(36756003)(6512007)(38100700002)(2906002)(8936002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nm1XZzVQd0pvYk5WUjFoZ1VBMmRWMVNNMlhjU2tBenlCb1FoMGVhTVh6NmZH?=
 =?utf-8?B?SnNTTGtWcVgvVnRRcWp2Q2RWTnRwMGlKbFQ1R2VCRWw3Z3VYVjN4ODBBQTBv?=
 =?utf-8?B?NStZMUhudHpXRmdraVNraEJlVWx0MmlEbFJOd3ZiK3NDYnVlVjdVUE5hdmsw?=
 =?utf-8?B?bU5nNGhJZS9YdmZXM2VNa0g5dzVDblZqU0dOajVvbU43ZUROaVM1ekxvVzZW?=
 =?utf-8?B?QURIVlRvWlN6U203UkltMVA0NnJ4T3RhdUFGRFA3U2kxek4reFFPT1FCdG8r?=
 =?utf-8?B?QlhVUUhjY1hId2FzajFnbWxHOE1pMmpmdEkzWThpZmp5Zk42MHJmak44dUxK?=
 =?utf-8?B?Q0krRFJ2Z0sreU4wUU1sZllyZ2lhcXJlRDdkbnBOMjlqMmdoTzJZdWhrajVZ?=
 =?utf-8?B?bzJkMEp4Y3E2V1RYUWdIUjIzazFPK3RhcW9QRkdwNE1rU2lSbGxxb0gwQnVC?=
 =?utf-8?B?RnFleFJpY21ucngyZkdFa3lUc2tiUGY1QWF4cWg1NUp6ZzFXVStMeDNwcmhY?=
 =?utf-8?B?Z0NPTUpXdW5IcXZyQjBUN0pkVTE3SnZJYmQ0L1hDZlNPQkNWbUxkcTJMWVAz?=
 =?utf-8?B?b2E0Mk1HRHRSL3hzRmJZU0lGME9GYWdwdktoMDZLbWJSMmw4SmZUd0NqRFNY?=
 =?utf-8?B?RW5BUzMxWGNWL1kydDFPTWEvTXdMSkNlYVFkbm9zWlp2T1VrdEVEWHBEZS8y?=
 =?utf-8?B?ME10TXFlSTFZNWRkd3hlY0QrRlIvd1paVmsyS3kvdnludi9RMEcrVXREZVBh?=
 =?utf-8?B?ZVlsZk5ROGRadTFHOEVtaHVlaDZ2OTkwYUppbFZKUVJpaFpyMmpGREwvL3ZL?=
 =?utf-8?B?aXpwMkYxYzdlSzI0T296aW1mMm82OWE4eWIyQWVqc0RoRWxqc001M3FJbDlT?=
 =?utf-8?B?RU9NVDVCVndHWlU1RHlzejRvTm1nZ0FzTmlxUWkrN2RaM0RueWh0SmM3Vktz?=
 =?utf-8?B?QVp6WThrb1BPcko2d3hFTVlLMlNiYmpiNDBwZDB4b2NRc05MM1p4UnZIOWRU?=
 =?utf-8?B?OUwxcG1NTUJ6VFdNdEVGRVlPRTdTdjF1NGdyN1lGU1FQOVFNQy9xamUzSmtz?=
 =?utf-8?B?d3Y3NWFPZCtFZ3VnU3pHRm45c0NUTTM0MmxxZ1VlcnZtYjVsM2NoQTVKRE0w?=
 =?utf-8?B?V1JHRFlFNG94U2h3OEdzR1F1V2tNd3ExeXB1M0U3TEc2N2lONU5DZG5tdlVx?=
 =?utf-8?B?WUFmQjI0NzZHbTNXcUJYQWNrMVcxcTJ2TFdhY0F5QjkrZCtrcUhRVHVHVnFW?=
 =?utf-8?B?R0VNN2g2a3ZhbDd0aXBscDM1ZjRxdUdqNlhwemNaTFZJc0tRSy83ZTNjYkZO?=
 =?utf-8?B?K1R5MUFtWkVLckI3cnhMVWxKVzN3TjZPbzFqQWMwb1RTOXQ4clBkOWFzSEZN?=
 =?utf-8?B?dnhPbENaV3BTWkJSWnQyZkorVFRmNUl2bDJoOFdnUlJYOE9wZEdnb1J0WVNs?=
 =?utf-8?B?bUFUVlc1WmRsRzRDamFja2tZd05rMiszTmxtajFadVBuaE1TYmk5NnhSU0o1?=
 =?utf-8?B?bFlLWnFjZTNsWXBaLzZQMWdCdkd6WnNITGh1VHFudGJObkxpQkEwTHdTYVp3?=
 =?utf-8?B?YzNZV3p3YWhyOTYxSFF4MXBqVjFqK1dNbVN5VThRcy9wTFd3QmhkL2laMjRn?=
 =?utf-8?B?ZUVUNU5kUjcwYmpIck1Qb3dDYUdJTzZZRkI2Q09tN1Y5cUNIbGl5MFArcUpS?=
 =?utf-8?B?aERaVS82ZDVmUEx4R3IyRm8vRFRnbmc1VWlGRkFvdW12ME1XOEp3ZWFXSllr?=
 =?utf-8?B?dWFOd3lLcXo2Rm9KclpDQ25DVU92aWZ4Y2lxeUJjb1p2empZR3djd3ljQ1ZN?=
 =?utf-8?B?enhHeEUvMm9waUZ0K3RLQkx3RE1ac0d3bTB3MnRLNFErOUYzYkpKSmpLK2ZQ?=
 =?utf-8?B?dmxaQXAyL0p1UFNJelM0aVV2cUExQlBZWWVUaU9OWGh1RU82ZnhKaS9MdE9t?=
 =?utf-8?B?dTFMNENQZXd3cHBsWkpSR3JWSFJWZnBDU2lCbXpQUG9PVHNrdkFWdWpJMVJT?=
 =?utf-8?B?dEV6Mnlndk1WcEpyYURJQkorWGQ4WW1JdjJuMkExMDZVVENGRTZMQnRqaG5L?=
 =?utf-8?B?SnhqdExnUTNZSmdscUxrL0Q1MVlVVldWeG5paUt2aGRyazV5UG5zWElDL3R5?=
 =?utf-8?B?TmVlSVNyWHhvV29OZmx1djA0bWdTVUxTTkJ3ajFkSjhPN0VJWEVPbFJ6QWx4?=
 =?utf-8?B?VFBxZzNuVlIzQWVSSXJPMXljNXY5STNuOXEvaFQ5NVc4UXpwNDYwa3FDcHRn?=
 =?utf-8?B?MkMyT3V2UG91V3FpTHg4Ui9hMEtoZ1ZoUi9FejZONml2ZEQ4VHNaOUFocVp6?=
 =?utf-8?B?RUtHbGlhbnRoZUxYTWsxZCt6eFFyOXJuc3VSQ3JJL0w3WnJjcm9Bdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 889dd9ef-5e82-4b74-5f81-08da1dcc561f
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 04:07:48.5995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EPs5L3TaHOYuwTdGwDwujI+Defz3LWvdtRE62rHcp8evE467VUboe4211hVWwjC2W8uxSxgKjGf8/VpWXAXzew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1872
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/14/2022 2:39 AM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 4/13/22 19:17, Ashish Mhetre wrote:
>>
>>
>> On 4/13/2022 7:34 PM, Dmitry Osipenko wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 4/13/22 16:37, Rob Herring wrote:
>>>> On Wed, Apr 13, 2022 at 03:10:11PM +0530, Ashish Mhetre wrote:
>>>>>   From tegra186 onwards, memory controller support multiple channels.
>>>>> Reg items are updated with address and size of these channels.
>>>>> Tegra186 has overall 5 memory controller channels. Tegra194 and
>>>>> tegra234
>>>>> have overall 17 memory controller channels each.
>>>>> There is 1 reg item for memory controller stream-id registers.
>>>>> So update the reg maxItems to 18 in tegra186 devicetree documentation.
>>>>> Also update validation for reg-names added for these corresponding reg
>>>>> items.
>>>>
>>>> Somehow your subject should indicate this is for Tegra.
>>>>
>>>>>
>>>>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>>>>> ---
>>>>>    .../nvidia,tegra186-mc.yaml                   | 80
>>>>> +++++++++++++++++--
>>>>>    1 file changed, 74 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git
>>>>> a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>>>>> b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>>>>>
>>>>> index 13c4c82fd0d3..c7cfa6c2cd81 100644
>>>>> ---
>>>>> a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>>>>>
>>>>> +++
>>>>> b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>>>>>
>>>>> @@ -34,8 +34,12 @@ properties:
>>>>>              - nvidia,tegra234-mc
>>>>>
>>>>>      reg:
>>>>> -    minItems: 1
>>>>> -    maxItems: 3
>>>>> +    minItems: 6
>>>>
>>>> You just broke current users.
>>>>
>>>>> +    maxItems: 18
>>>>> +
>>>>> +  reg-names:
>>>>> +    minItems: 6
>>>>> +    maxItems: 18
>>>>>
>>>>>      interrupts:
>>>>>        items:
>>>>> @@ -142,7 +146,18 @@ allOf:
>>>>>        then:
>>>>>          properties:
>>>>>            reg:
>>>>> -          maxItems: 1
>>>>> +          maxItems: 6
>>>>> +          description: 5 memory controller channels and 1 for
>>>>> stream-id registers
>>>>> +
>>>>> +        reg-names:
>>>>> +          maxItems: 6
>>>>> +          items:
>>>>> +            - const: sid
>>>>> +            - const: broadcast
>>>>> +            - const: ch0
>>>>> +            - const: ch1
>>>>> +            - const: ch2
>>>>> +            - const: ch3
>>>>>
>>>>>      - if:
>>>>>          properties:
>>>>> @@ -151,7 +166,30 @@ allOf:
>>>>>        then:
>>>>>          properties:
>>>>>            reg:
>>>>> -          minItems: 3
>>>>> +          minItems: 18
>>>>> +          description: 17 memory controller channels and 1 for
>>>>> stream-id registers
>>>>> +
>>>>> +        reg-names:
>>>>> +          minItems: 18
>>>>> +          items:
>>>>> +            - const: sid
>>>>> +            - const: broadcast
>>>>> +            - const: ch0
>>>>> +            - const: ch1
>>>>> +            - const: ch2
>>>>> +            - const: ch3
>>>>> +            - const: ch4
>>>>> +            - const: ch5
>>>>> +            - const: ch6
>>>>> +            - const: ch7
>>>>> +            - const: ch8
>>>>> +            - const: ch9
>>>>> +            - const: ch10
>>>>> +            - const: ch11
>>>>> +            - const: ch12
>>>>> +            - const: ch13
>>>>> +            - const: ch14
>>>>> +            - const: ch15
>>>>>
>>>>>      - if:
>>>>>          properties:
>>>>> @@ -160,13 +198,37 @@ allOf:
>>>>>        then:
>>>>>          properties:
>>>>>            reg:
>>>>> -          minItems: 3
>>>>> +          minItems: 18
>>>>> +          description: 17 memory controller channels and 1 for
>>>>> stream-id registers
>>>>> +
>>>>> +        reg-names:
>>>>> +          minItems: 18
>>>>> +          items:
>>>>> +            - const: sid
>>>>> +            - const: broadcast
>>>>> +            - const: ch0
>>>>> +            - const: ch1
>>>>> +            - const: ch2
>>>>> +            - const: ch3
>>>>> +            - const: ch4
>>>>> +            - const: ch5
>>>>> +            - const: ch6
>>>>> +            - const: ch7
>>>>> +            - const: ch8
>>>>> +            - const: ch9
>>>>> +            - const: ch10
>>>>> +            - const: ch11
>>>>> +            - const: ch12
>>>>> +            - const: ch13
>>>>> +            - const: ch14
>>>>> +            - const: ch15
>>>>>
>>>>>    additionalProperties: false
>>>>>
>>>>>    required:
>>>>>      - compatible
>>>>>      - reg
>>>>> +  - reg-names
>>>>
>>>> New, added properties cannot be required. That's an ABI break.
>>>>
>>>>>      - interrupts
>>>>>      - "#address-cells"
>>>>>      - "#size-cells"
>>>>> @@ -182,7 +244,13 @@ examples:
>>>>>
>>>>>            memory-controller@2c00000 {
>>>>>                compatible = "nvidia,tegra186-mc";
>>>>> -            reg = <0x0 0x02c00000 0x0 0xb0000>;
>>>>> +            reg = <0x0 0x02c00000 0x0 0x10000>,    /* MC-SID */
>>>>> +                  <0x0 0x02c10000 0x0 0x10000>,    /* Broadcast
>>>>> channel */
>>>>> +                  <0x0 0x02c20000 0x0 0x10000>,    /* MC0 */
>>>>> +                  <0x0 0x02c30000 0x0 0x10000>,    /* MC1 */
>>>>> +                  <0x0 0x02c40000 0x0 0x10000>,    /* MC2 */
>>>>> +                  <0x0 0x02c50000 0x0 0x10000>;    /* MC3 */
>>>>> +            reg-names = "sid", "broadcast", "ch0", "ch1", "ch2",
>>>>> "ch3";
>>>>>                interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
>>>>>
>>>>>                #address-cells = <2>;
>>>>> --
>>>>> 2.17.1
>>>>>
>>>
>>> Oh, wait.. I didn't notice that the new reg ranges are only splitting up
>>> the old ranges. Previously it appeared to me that these are the new
>>> ranges.
>>>   > Ashish, in this case you don't need to change the regs in the DT at
>>> all.
>>> Instead, you need to specify the per-channel reg-base offsets in the
>>> driver code.
>>
>> Yes, it's kind of splitting up the old ranges and straight forward for
>> Tegra186. But on Tegra194 and Tegra234 the old address is not in single
>> range. It's already split across 3 ranges. We have to choose right range
>> and add channel offsets to that range in order to read interrupts.
>> So I went with the approach of splitting the regs in DT itself as per
>> the channels because that way they can be mapped in a single loop and
>> used easily.
>> If we want to specify per-channel reg-base offsets then that would be
>> per-SOC. Also we would need to choose correct reg-range for Tegra194 and
>> Tegra234 and have a way to maintain offsets of channels from those
>> respective reg-ranges.
> 
> That is not nice too. Should be better to switch to the new DT scheme,
> since those channels weren't used by older kernels. It's okay to change
> the binding ABI in this case then, driver will continue to work for the
> older dtbs.

So the current DTS and binding changes are fine?

> Have you tested driver using the older dtbs?

Yes, the driver is tested with old dtb and it's working fine.
