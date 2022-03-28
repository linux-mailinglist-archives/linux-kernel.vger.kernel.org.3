Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3324E97E5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 15:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243096AbiC1NVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 09:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiC1NVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 09:21:17 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A183EABE;
        Mon, 28 Mar 2022 06:19:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yj3DKkpNfiZkuDlLFI/Lz40/jSmpkmA/R3zVXvB4xVLSZXy++xolO8y9dra0Rx+9fT/n1AP77caFMX0WYJj9+sYOOl9eqa2hmugwKXQaoN4u4yvKkg7kGrEipaqn3EBOyR/bMvFSZw/d0R/kI+94Rm21NjvDkrC864noFw2BtB9AHTIxGt2PUY4MD/nrQ8TUD5esMe6ag8zhOYoQbJ6b7juZAXBGafU466MAh2j48W8DeoMGCp4KXDwMR32xqLXnkoA0YqvoGtCu42n3RgXqgk3tqT/Ibc8Y2sB79XS7d/HD710mMkp/a13+myacfP9iItjiOIOMusOU70N7izIONw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4LWhrzcLBKyt9+VIVYnY/AQlw0yLMVrxjyvsE1DNjg=;
 b=RrMKy/9DNFOpAARd7JhFlRn/8n+kvYxp/VyGzGF1qEhDns8jIdtKo47TbsNowH+9BjmJpbZcxM2h/rofszNnwncM3CLI2h/jQpsrtTTFqIPF7eGYYQqepRd7gvoBCLh80MSocO8AhuAXW15YNWlqUipk9JO8VmcEd5kWp7oWzd3crt41kTCYZxNY/46Kcp3bj6cNwEXa8qN9iVN3Piuh+B6GVkEYG6yPmfZzKSpmATHk0TNbpu3zqm4MjtEGTi+6mtuhzmMovmO8v8px70cqtgHMkgg+8g9S0gMh0UoZzTDIsN1I7rqKxIiREpsEvSDvgr2yfcKWMszT+02dMoixXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4LWhrzcLBKyt9+VIVYnY/AQlw0yLMVrxjyvsE1DNjg=;
 b=UkHyq3EK8WJX43413rymJCXcRbj78jNcwDphz0EFcfKAy9CtA3EzxNWHcb3YTEHNrVb9bDqTKU0IUsptcTJMrIg2+VKJ1xLJ/zwQVF8wuyCkkSmP9AJ/heRZV0QJPuYGbFdvK95lMmFTZv2BS1fWIw94353QmKUP5e29LMwvQDg8qR8dnCa2yy0MsPJ//nAODD+GdrwjAVTFd0fueRB1zUHQk3QPwWE9h858l5rDfx08faOWiYZjc/JlQiwzz9UWE4kirBhNE6iXkv0j2lv5/zKKFdwLPj+4g/P6cZZb9/V479nBrEQoSbLQoXS8sugurQ5ANQwaTSUp0YH3RXR8TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY4PR12MB1576.namprd12.prod.outlook.com (2603:10b6:910:10::9)
 by BN6PR12MB1729.namprd12.prod.outlook.com (2603:10b6:404:108::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Mon, 28 Mar
 2022 13:19:34 +0000
Received: from CY4PR12MB1576.namprd12.prod.outlook.com
 ([fe80::a185:161d:ce15:3e07]) by CY4PR12MB1576.namprd12.prod.outlook.com
 ([fe80::a185:161d:ce15:3e07%9]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 13:19:34 +0000
Message-ID: <fbd9cbfe-d653-d6d2-e55c-fb80527bea13@nvidia.com>
Date:   Mon, 28 Mar 2022 18:49:17 +0530
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
 <53d77f33-27e8-3446-d758-3e545eea2db4@nvidia.com>
 <5e4e11b5-02b8-e03e-2924-c9f2882921be@kernel.org>
From:   Sameer Pujar <spujar@nvidia.com>
In-Reply-To: <5e4e11b5-02b8-e03e-2924-c9f2882921be@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0075.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::15)
 To CY4PR12MB1576.namprd12.prod.outlook.com (2603:10b6:910:10::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31402f0b-cd26-49bb-b8b3-08da10bd9976
X-MS-TrafficTypeDiagnostic: BN6PR12MB1729:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1729AD4F8A4AF0A2446FB219A71D9@BN6PR12MB1729.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UjeK50TrZk7Jr48A8TGas5Csfu/XSE2mJOsdZLW0886DdNMA3jp3IRypIa8cBi2cwLBAoeLCASwJjFnPrXINIIscL1VBVKU/J1l1xcjtxsFX+zDyZR9LJHE2L2rpfSdGMdD9DK/dxeftq2UiqTT3GtnqfZmeBsa6WGPUCKQUBq6vyIPOlYLAXNV1l1pS8+fJraUJBcask2nVTN5bRSXT4ys/byP5iJkBCiknLKHS75yKU9qL/V3d75g7ZrLl12gKtIRgdxCLNjX4QxGowMFCOD/9UFpw8GH/jfQzruJHimmvz7ewds77OgUdsFoJ3uObUpzSqxATl04rAzSTrV5Iqy43LZ5XzYXi0jmy9f/oB0qc2NY4S198x7a8dWRp7gNs8LO1eoPfXJpPxoITnFCkROH/Noi3ORdsfymFieYmKB9PA1HmtTNQp6+BsV5C6xCdHIDNbLBOemknpvsxyfSeZtVHu5U35rWwncpjXsHMw+RbYB9DoluuSDtrmNMsyIyvXkX0hK25GpfS+umIGiqadrVTnVK4m1ZcVnnXK+YzJ04oSXgPwZQ39KbKbRJ8Nqq9NuIWt2h42tGNyPcvPDy+U1QTWnbCj9OC363FndqGkSNi9Y1ZfG/ZK6R+b8kK5Ngp2TWT7AxbqXyqSmCeUirZlTLRfTWd22yo9nYQ1SYNdokPMLOUKajckO3WEgfjDK3vwE2Eq2yUe9qRkXCCpuThN/Cw+yJOQ60mnO/vjYrltRs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1576.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(4326008)(66946007)(66556008)(66476007)(5660300002)(7416002)(2906002)(8936002)(83380400001)(6512007)(86362001)(31696002)(6486002)(36756003)(2616005)(6666004)(508600001)(186003)(26005)(31686004)(316002)(6506007)(53546011)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0h1N2pxdU1BZW9VVVk4a1Brc1d1eGhHcjhqellvVWRiQllva0NyVWljdVVB?=
 =?utf-8?B?UnI3aHlYbW1IelVtcERvOGhBR2Fycy9rbDdoWU1yUE1kU3dBTTN0clEyK3pL?=
 =?utf-8?B?S1JMNlFmQUhzYWpPQkpUNEMwNFZsSEJManNuQ2hHNzJ3Wkp3Y0M2YnlhbU1o?=
 =?utf-8?B?L1h3ZXp5TG4zOFZkU0JJTHIxODRQNUZPbFBtd0lOa2MxVmZoTlJlRDEvMTla?=
 =?utf-8?B?Q1paTU1KUER2ZmJMcVN5ODR3S213MXVXc1J5N0NRTDVMbUJ0WXgvcUw2WDhJ?=
 =?utf-8?B?SzNldWVudTB4V0ZDempOeGFMb0F4SkRLVzY3aUFhOXZHZlkyRTNPZm1HVmdq?=
 =?utf-8?B?azRxTnFEYTA5Q3NUZ3RtRXhyWDFVdkFoN2ZhbTR5cUh6QUE0ZnF6WEdDcWlr?=
 =?utf-8?B?RGN0WXJ5SWFlY1FOaGVqRE5RMkJaRmtGdU1ZR1VQRzlwRjRTdHl5d2Z2K0lD?=
 =?utf-8?B?NVRNUGoybWZaNnd4ZEhxZDkyNnI3aVBrR0tTakNSZjQyMmxUNHZFWGsxWk4y?=
 =?utf-8?B?VlRzVTNrTUMzbmdHZ1pyVUhLLzd1enVmb2l5WEg2dzdlN1Z2czBadWhjd3d2?=
 =?utf-8?B?eUVySzczVjhyR2tVYnlMSkZVUlNmQVkraTRSNkEreFJzbzNUdU9LbUhZaDBi?=
 =?utf-8?B?NW51eFRncTBkTVBza0ZsMHd2ZFQ5ZTVwdFNtOVh4clN5N0V4N2FmaGdwelJO?=
 =?utf-8?B?RzNZT240OTlJMnBoLzk1UVJJZ3hqZmlSR3pDdnpVU3VOMUtDUytwZUY2YjNx?=
 =?utf-8?B?b0o1YkRQQmV6NWI2ZEorSWxXb0NxQXJSRE9HTnRNQnhNOCtjNkZzSmxLempo?=
 =?utf-8?B?blc2S3c5WW43eUpaMnRQVkpVMzhYcVVTU3AzaVFIVXg4UkxFQzgwSGNkNU1q?=
 =?utf-8?B?M08wTGJQRDVpRnA5YXdTS1FlMUxlMHVQNTUranVhTGFvRkVld0l1cllHL1Mx?=
 =?utf-8?B?RmNuSkZPYlhuVjZWTzcrS1FjNXAxV3FyVzd4UWpyK3hkQWJKdWdmT2t2SkNl?=
 =?utf-8?B?ZDFyeU1pMWtRR1JyTlVKVU5UVEx4QTlFWGgydFNjMU9VRHp6N2RqSHc5TWls?=
 =?utf-8?B?bm5ieHNEN2p2eVdSN1JxRHBub0pkeU9QRjloVTJtRGNENWdnOVdPL0w3Y01H?=
 =?utf-8?B?YzBpbkQ5cW1rOWdscFd6RllMUjJaOVNiZkIycTM0bHREZWxVcjVrN0tVMXkx?=
 =?utf-8?B?UlMxaGhzV1lIMUxVVWNUSWNHVGMwMzZqOVVGZHVnMWJFbkJHWUlMUGdua3Jq?=
 =?utf-8?B?QWJ6U0dHdk5MRnhuclVsNXRibHZVQmFXTitJWjgxWnpWVXJncDJTYWhjUVJ3?=
 =?utf-8?B?WXo3Sy9BWjJpOTA0ZDBWU00wbDZwdnhQZk1oTStRa0JpdDRFdDNKZE1URlc3?=
 =?utf-8?B?RHpSeGV2ckh6Y3lDNEJMYTdTenA0MzBHUWd1SDJsQXcrVndKWm0vK1dKNmo3?=
 =?utf-8?B?bVEyTjh1bHlHcG1hMk1meitiYVRJdXdSY3JPM0lzbUZoN3Q4WTVRcE9NOTcv?=
 =?utf-8?B?QWxQYTVTVERNYnM1RldhTU5iVnM1SGV4b3NNM29NWW1OcERzSXpPR0p5cEhk?=
 =?utf-8?B?YWNVOG1jSnhRTCtVSWtFcUdtRmpPYyt2UjFwNE9qeGVZSzRzS200MWNLKzBO?=
 =?utf-8?B?aGhoQkoyRHo2V3pUcDFSZnAydWVjOTc4R0FTaWxBb1dXd1d4cFE0Vzh1cGp5?=
 =?utf-8?B?VXdDVU1IT1YyVWZ3QXlCbDJOcUpER3Nob2VXNmFaYVorWTAzOHJRMUFIenRH?=
 =?utf-8?B?cTFKeVRTU1pzV25SRExwS282VWdhRnc3MklaTkI2Z2VkZnJUZ0VZV1p4UFZN?=
 =?utf-8?B?c1BCMElQRUU5bmNTNFFqUXJtSVUvT1dXOFhjSlMzNWJSQmYzM1F5WkxyUk5t?=
 =?utf-8?B?UDA0dE9EUm1iTmdqdGhZVmE0MXNUSHlPY2h3WlFTMWhzT1U5R2N1b1M2aUtG?=
 =?utf-8?B?VGFUckFnS3FpWi9hUjY2bjZhd3dNWmp0UHhEQ1YvRnEyUWxabDZHQ25OSW9X?=
 =?utf-8?B?a0tXMjhyOVJJSGhPSnZNRzFrM0o4VGpNdDVmRUg5UjFHVUVVOWVvdFhISHV0?=
 =?utf-8?B?dXRSQkIxSTdYcFJxcms3L0lFYmJtS0NjUlM0cHBSNFhoTk8wdVlNN2l3RTAv?=
 =?utf-8?B?K3lHQ0k1YjMzaUdQTWh3dWE2MEJPTnp2SDFEMGdFTVlyMjFsY2xQK01oZGhr?=
 =?utf-8?B?Rk1FSjh1eWd5WGRyVU9nOVAxS3VKem1ja3BUdERobkQwRDF0Q2w4dmF0OFd1?=
 =?utf-8?B?UlMvMlBhUk1PZWo0cUdXMHpwNExwTzAycEJmVEgzWkVpVXJwVE1qZUVjWFpY?=
 =?utf-8?B?dFZPZHNtVXV1U2NCS2ZaZVZuRE5qWmtuR0lzV2dmMmJucEU0NWlzZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31402f0b-cd26-49bb-b8b3-08da10bd9976
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1576.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 13:19:33.9341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zOQkdU7xYZKXpvfUlnesLjTLuForNQkwxoFmiO7j3GjPviad4SlOgP02B5k91MqnnIn+4xDd7zLSTe8ME7wV9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1729
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


On 28-03-2022 13:37, Krzysztof Kozlowski wrote:
> On 28/03/2022 09:58, Sameer Pujar wrote:
>> On 28-03-2022 12:36, Krzysztof Kozlowski wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 28/03/2022 08:14, Sameer Pujar wrote:
>>>> The rt5658 or rt5659 CODEC system clock (SYSCLK) can be derived from
>>>> various clock sources. For example it can be derived either from master
>>>> clock (MCLK) or by internal PLL. The internal PLL again can take input
>>>> clock references from bit clocks (BCLKs) and MCLK. To enable a flexible
>>>> clocking configuration the DT binding is extended here.
>>>>
>>>> It makes use of standard clock bindings and sets up the clock relation
>>>> via DT.
>>>>
>>>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>>>> Cc: Oder Chiou <oder_chiou@realtek.com>
>>>> ---
>>>>    .../devicetree/bindings/sound/realtek,rt5659.yaml  | 53 ++++++++++++++++++++--
>>>>    1 file changed, 49 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5659.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5659.yaml
>>>> index b0485b8..0c2f3cb 100644
>>>> --- a/Documentation/devicetree/bindings/sound/realtek,rt5659.yaml
>>>> +++ b/Documentation/devicetree/bindings/sound/realtek,rt5659.yaml
>>>> @@ -29,12 +29,28 @@ properties:
>>>>        maxItems: 1
>>>>
>>>>      clocks:
>>>> -    items:
>>>> -      - description: Master clock (MCLK) to the CODEC
>>>> +    description: |
>>>> +      CODEC can receive multiple clock inputs like Master
>>>> +      clock (MCLK), I2S bit clocks (BCLK1, BCLK2, BCLK3,
>>>> +      BCLK4). The CODEC SYSCLK can be generated from MCLK
>>>> +      or internal PLL. In turn PLL can reference from MCLK
>>>> +      and BCLKs.
>>>>
>>>>      clock-names:
>>>> -    items:
>>>> -      - const: mclk
>>>> +    description: |
>>>> +      The clock names can be combination of following:
>>>> +        "mclk"        : Master clock
>>>> +        "pll_ref"     : Reference to CODEC PLL clock
>>>> +        "sysclk"      : CODEC SYSCLK
>>>> +        "^bclk[1-4]$" : Bit clocks to CODEC
>>> No, that does not look correct. You allow anything as clock input (even
>>> 20 clocks, different names, any order). That's not how DT schema should
>>> work and that's not how hardware looks like.
>>> Usually the clock inputs are always there which also you mentioned in
>>> description - "multiple clock inputs". All these clocks should be
>>> expected, unless really the wires (physical wires) can be left disconnected.
>> The CODEC can receive multiple clocks but all the input clocks need not
>> be present or connected always. If a specific configuration is needed
>> and platform supports such an input, then all these inputs can be added.
>> I don't know how to define this detail in the schema. If I make all of
>> them expected, then binding check throws errors. If I were to list all
>> the possible combinations, the list is going to be big (not sure if this
>> would be OK?).
> Thanks for explanation. Please differentiate between these two:
> 1. clock inputs connected, but unused (not needed for driver or for
> particular use case),
> 2. clock inputs really not connected.
>
> For the 1. above, such clock inputs should still be listed in the
> bindings and DTS. For the 2. above, such clocks should actually not be
> there.

Thank you for the suggestion.

> How to achieve this depends on number of your combinations. IOW,
> how many clocks are physically optional.

 From CODEC point of view all these clock inputs are possible and a 
platform may choose to connect a subset of it depending on the 
application. The binding is expected to support all such cases. To 
support all possibilities, the total combinations can be very big (100+).

> For some small number of
> variations this can be:
> oneOf:
>   - const: mclk
>   - items:
>     - const: mclk
>     - enum:
>         - bclk1
>         - bclk2
>         - bclk3
>         - bclk4
>   - items:
>     - const: mclk
>     - const: pll_ref
>     - enum:
>         - bclk1
>         - bclk2
>         - bclk3
>         - bclk4
>
> For a total flexibility that any clock input can be disconnected, this
> should be a list of enums I guess (with minItems). However please find
> the clocks always connected and include them if possible in a fixed way
> (like this oneOf above).

May be I can list the most commonly required combinations like below and 
extend it whenever there is a need for specific combination?

   clock-names:
     oneOf:
       - const: mclk
       - pattern: '^bclk[1-4]$'
       - items:
           - const: mclk
           - pattern: '^bclk[1-4]$'
       - items:
           - const: mclk
           - const: sysclk
       - items:
           - const: mclk
           - const: pll_ref
           - const: sysclk
       - items:
           - pattern: '^bclk[1-4]$'
           - const: pll_ref
           - const: sysclk
       - items:
           - const: mclk
           - pattern: '^bclk[1-4]$'
           - const: pll_ref
           - const: sysclk

