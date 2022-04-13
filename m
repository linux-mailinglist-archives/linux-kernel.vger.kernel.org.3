Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80BF4FFB0C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235266AbiDMQUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiDMQU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:20:29 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2044.outbound.protection.outlook.com [40.107.95.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D307B22BDE;
        Wed, 13 Apr 2022 09:18:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=feWEMgX9JlenM4viuAIAt7W3cik7O5sYPGQVvWkP1tdNM3FK+sdEbukkZmQm+qhhFyViAKBTjxBGe6aVFF+kc/bU3AJAim6XFvrAmTU5X0l5mgAGLlVvgvUT/PiJI0BUFED0wjXwke/drKxLUnRTKspkcIN5ZWKjxWQ/BpqKrBe8QwKCURWEa5Hqf29Q+ygZpvyhGeX6qf5JGNKjI6EgdxmFyCxj9JCOHdBK5BHXEb71uHu6tq91p627Mf/0PNG69ne5ixlsb8/3EeHSYs0rtgqTY9Si5JjtIQC5+aOR0jntpjNS6mMMcMa+lzWnxZTYtEwhXIN7DY/GpmbpeMFczw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbRm0CZSbVNg2RyJZdJ1u1AdqQZwdf32fq2p4/x0zhg=;
 b=oH5gzethGDXHcueAM1dzZULg7DbsE4LbXo6K0ouZAX5zSAhj4vGFzSyizlZOCryH8On0jj4hPkU4LspOy0E2ntNeJV4FKOdK2J94qTm9EOu5LpFpaDCOOMpXtLOgvq3B77T5CmHQ8WS7RpLlFPslORwUoTJFm/EioiLxeICB9CzZjQ3NfOJcoMBQkgdo6OkXM7qQfQr3LP2zQMvi3z08nFxzaZJl5HrwkU6BizNHoENttIjqrAf5HCijDZ2V4OzPUK5HFxxSuNQQLuaV0FE8i/CZUkBb0LoN2qg0PKCD6Jiq+ZFu71vtHyoAtEHgA2z1i9zG6JfpHLYJtuiEHfKe8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbRm0CZSbVNg2RyJZdJ1u1AdqQZwdf32fq2p4/x0zhg=;
 b=SxNYCo4hISUD9NoCXTtjbCN4ULIDhYZo3ZJDupn+w4ESNb+5lRrm1YTAKBH0BzSfE6XF58N90BxbinUEx/INpign9EyDpBJhZptz8SRZsC4oVKtwS/wzjRbj92jTPgfqwjVdkgXs+ZgKyJxS4zHl6Q3kP17yH+l7BepaCiMBDdglMC2Twj80xMgJuFzC4Qq6pXQViaP4axDiMaduPJYFc43DBe8Vs9/tT724mlPBKov1KwoyVjWTJGfYJs3XM2LIRYRmCsIyBFuQC6dU2IDbpIBaxRgoZepe3D4nPsL+IwMVrzmdOxcIW35C/w/sEdvdXk47+Bt+UblQZ79h10/oBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by BYAPR12MB3207.namprd12.prod.outlook.com (2603:10b6:a03:135::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 16:18:04 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef%4]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 16:18:04 +0000
Message-ID: <71fc3efb-5110-287e-0422-10c1ae90139c@nvidia.com>
Date:   Wed, 13 Apr 2022 21:47:50 +0530
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
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <b050247d-a62c-62e7-7750-24cefcc93506@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0117.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:1::33) To SA0PR12MB4349.namprd12.prod.outlook.com
 (2603:10b6:806:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df03f1ff-dfb9-403d-7e93-08da1d692fba
X-MS-TrafficTypeDiagnostic: BYAPR12MB3207:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB32079CBB151B723920039D3CCAEC9@BYAPR12MB3207.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 25kpPtLSnhamHNyQVOSHWMxHTD7yLl8z4hLzFU9QJ7hv0EjBlhgOl9d86x2+YQbxAWjm+ts03lZ/57Z/GtnzhGuO/77r7EosXuwJMfFGil0MQKoa7R8UWIo3vK8OqnhMgNADOWheCDWtm92BzYkzjR9C7snJ4HvYM+P33VN3xVRGrFrynycYdQbxisrJJnebYUENVJaZyfvq8oh3uqoslo/Suau4oqMle4oDWn5bGZvCmm5i/qboJp9y6mCUPygscfka23Uiq4g+Ixxl/j+KtqWeOrKsnMgJhUemXbV6qurx1OMkj+NDKr07Q6DYcppcQWPJyfcX2VY2RM16nOIhyNa61lMtSq3WAWEbwruGDezJ+aDYxIPdBv4i9rJEdy92FmE3HtY8RgMVVMg+mnALlnnEXVEx47a5+nSB42c4wvfFGTQGeWSYv5w2cyJC4KKkflA+559ixOCiQ0xYKaqy7lKK5kP1hHxmlc3Dhm294OjXymmScM+xBeqZLQ/DLgEhGhrc0pKSuEXk49fCS0IGpnrX055jV88OUexLElTRwN4y2RXySbm7DNn+HGj0dJ3LZ1bgacmNneV27iTElU4S6s4ucp/PnD9Jcou4bD3r85ZYj7W1aLG4fxGktrwpPub1TqyaUk/Xm1WIhui68PcCd/MDM7u8yeVoJFqbu5LHk3gjFxKl5Dp0fUbpBoie5S/xg4Dm8NdrfZM89IrTvEjHUsUhJwplXQlIIEF6D6POVOM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(66946007)(4326008)(8676002)(5660300002)(8936002)(2906002)(55236004)(66476007)(6666004)(6506007)(6486002)(508600001)(26005)(31696002)(38100700002)(53546011)(186003)(2616005)(107886003)(86362001)(83380400001)(15650500001)(6512007)(316002)(31686004)(36756003)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2hWWkE2ZTgzNmN3SDVlWTREMkY1NEtCTDNLWnFXYnVIMU12Y3dEbWlTV3pK?=
 =?utf-8?B?cTRsa1lzUUFadnB2VE5xRloyMHZNZXhoL2xlWkJ4c2M3REthY29kemRDa1Fu?=
 =?utf-8?B?U2gva2lJUW01V0s4Vmlkd2kvZDJUZmZqMUUrT2o0Qmtta1BxRWJpWnExWnZO?=
 =?utf-8?B?S2dsY1ZTb2s2QXV1Yi9mNlNUREFnZnRYMXlmUTBZb3E2YjY3SmYvSTI2KzFz?=
 =?utf-8?B?NkJKdENDc1VnLzJpd3dkbGVkQnR0Ny9ya2M4eFpmZnZkRzJyaVYyVmYwMWVL?=
 =?utf-8?B?enZwZ21vTlhrVkhkaFFRdmxVb0hkWTFWa0FIdlVxZjdZMVBxa08rQXlQYW1O?=
 =?utf-8?B?RjJkam1nSkpqYjhCOUlzM3VMUXFNK0gzMXIyUTFLT1hFWnVOTHNSZHRxdW1s?=
 =?utf-8?B?SmwrdjJWNzZSSm1DZHdXc2dSOTBMVGZpL1BMbmpkV3JiZmN6QUdBSUVRT1Vr?=
 =?utf-8?B?NkE0TmlQSmJubDdGdGJvQXdWbWduUnAxZ21sYWNxeHNrS0xya2hrUkp3WVgr?=
 =?utf-8?B?dDNYMlpzenBsS1FuTUR0T3E2Mmt2NktVKy9VcFRvd3hUcVRMNUpJUlllZFJa?=
 =?utf-8?B?QjFIbnlraWhXNU0vVzlzMUhnay9YOXJNS25jSm1FYkI3Z3psVlcyVWpKVkpX?=
 =?utf-8?B?TUFDaG9UcjVoYzdJZXY0WEFZR25QczFWREp3SDBTL1lUNVdjWDd1dlNMemhM?=
 =?utf-8?B?M2k3dHV4eStSRUpaSXlKdXB6eEZzNGh4TnpwVHJFelJVUGticzF2c2JzbWd5?=
 =?utf-8?B?SzJFT3VXMklWNnR4NzFOYy96VEdpMDFtVUhkL3Z1RVhHTDloN1A2L2pXWENN?=
 =?utf-8?B?M0dRWnc0MGw1SHd3Yk9qcHQvRmFkUVYxc3gxNytWNHQ2VnM2N2lMbFB1WUxX?=
 =?utf-8?B?UUJsaG9QS1dMaXhlUEkxeVIxUzdGcDhYYTFuWE5ZR21zYXdNdVRvWDhHK3Iw?=
 =?utf-8?B?ZFhOWWpiVHcyVk8wZG42d0dHVDJjRjRvVXZSRHc5TGdzOG1WOWJ2YW4xN3J3?=
 =?utf-8?B?ZXJJZFM4Y0RGVUd5ektJWGVMMVpCMzI2V05LNXMySnJmTEIvVFFsOUZzbnNS?=
 =?utf-8?B?NWtEM3c0aENGU0tGd0tramlESTVGck0wdzN0Q1BFQWpKdjMrRkJEWGRZSUJp?=
 =?utf-8?B?MXRINEFzaUlaSUs5U29FR0VENEFrUDVVRFZzR212Vjd1b2lpN3pHcmNJaXZq?=
 =?utf-8?B?NXowbExsdThWUjBVang5OVd0SUx2c25DajdBV3dyT2NmZlAxSWhnaE1qVHkz?=
 =?utf-8?B?VUt1NUsyTVJuTUpEOW1KRXBnMXlCL3VZUk9yVE9VL3BKb0lSaUJzU1Urd3hY?=
 =?utf-8?B?dHFJeHcvR2EwLzU4aHZpd0trdlBpZUlOV3dwVW9sLzRrWTYxSi9GVW5lQ1dn?=
 =?utf-8?B?aCs2WmZhVmVHUTVNcXVFY2RzQnlDSk1Bc1owb3JRb01oZ0tJT3k0ajlRazZB?=
 =?utf-8?B?bEMyRWpFaDhJQ29wOFE1ZjJwVG5qRlpFb2FjUCswQ1R5VVJFK2xzNHhlZ1pG?=
 =?utf-8?B?RzUxQW1YaVpDVHI3Mlhpbk1rWHltbGorRWtaRlpXMmZZenIxeHh1VW13ajk1?=
 =?utf-8?B?UVhQZ3U5bWhFUmVQSkVqcS9kQ1drRnZ4dXdKdzQwOUsxT01IYzk0SXA1bWtt?=
 =?utf-8?B?RHZ5K3hwNGFkQWs1d3NjUk1CVVR6N1VQS1FjYW9LaXBobzl6L1JjSGJNMXpw?=
 =?utf-8?B?cm9uQzNBbEx1QzdGODZjU05IeTJIdmFPdDJYeVhwajM3OHFTSXlhdXJDOGt5?=
 =?utf-8?B?dzd5ejY3WlgyR3ZKaEE0WHdpcFhDYXV6UGxmYmpzRit2WXVEV2xaeTl3aHdX?=
 =?utf-8?B?VVRGTTJoQ1NvVGY4amFKTERNYnVnQmFKU1VGQk9LQWlmMGJpVzBiZUUyNFlR?=
 =?utf-8?B?alJTWXRhUUtjV0dpRi9JMjVRNTlUV1g0YU5RaE9xbCtsc0dPc3hKeHJTN3Jt?=
 =?utf-8?B?MEtMY0hUMlV0ZzZPL28rMVo5aHpFMTI2R25Sd3JldnFWaDhqYm80b3hkTmdw?=
 =?utf-8?B?U25nendyOUcvVlhVTThseWZiQk1CNkpBd2Zpbk1nSEdwUEVnRDJWYVJzdUVZ?=
 =?utf-8?B?UFlURTM3SXEvYndiODBSSTJ3WnJOeW8vMy9SbTJXUFBqdzNVQ2YyMU1YWU5J?=
 =?utf-8?B?WGhqWGVoY1JKbTZ1TStLdjJ2cDdkVDN1eEYwdlRWNmxQY1Fnc3Z4LzFNR1c2?=
 =?utf-8?B?L3U3SnhqTk5xOXZKOVdDQ1VxcHJ4eWg1SU5nMHlKL3VKRUJreUduQWdtb1V5?=
 =?utf-8?B?QU9RM0xOUGRZSEczcThiVEZKYTJ0ellsa2tDNUg4dUxPSDE0VUw0TWxPWXlV?=
 =?utf-8?B?WXVjdE5CUTUrTm1RQ1cxYmZpTXNBaVpOYXlSOTRWalBqRk80UGRVUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df03f1ff-dfb9-403d-7e93-08da1d692fba
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 16:18:04.0243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5kl5+2wYz/p9oxW9iSWSdWTQ0xAXg1+GNc4IhL69k1Ps7aJrBkPZ8Y+QPVJYDp+wKHxTE82K8Lq1inuphqwmLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3207
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



On 4/13/2022 7:34 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 4/13/22 16:37, Rob Herring wrote:
>> On Wed, Apr 13, 2022 at 03:10:11PM +0530, Ashish Mhetre wrote:
>>>  From tegra186 onwards, memory controller support multiple channels.
>>> Reg items are updated with address and size of these channels.
>>> Tegra186 has overall 5 memory controller channels. Tegra194 and tegra234
>>> have overall 17 memory controller channels each.
>>> There is 1 reg item for memory controller stream-id registers.
>>> So update the reg maxItems to 18 in tegra186 devicetree documentation.
>>> Also update validation for reg-names added for these corresponding reg
>>> items.
>>
>> Somehow your subject should indicate this is for Tegra.
>>
>>>
>>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>>> ---
>>>   .../nvidia,tegra186-mc.yaml                   | 80 +++++++++++++++++--
>>>   1 file changed, 74 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>>> index 13c4c82fd0d3..c7cfa6c2cd81 100644
>>> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>>> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>>> @@ -34,8 +34,12 @@ properties:
>>>             - nvidia,tegra234-mc
>>>
>>>     reg:
>>> -    minItems: 1
>>> -    maxItems: 3
>>> +    minItems: 6
>>
>> You just broke current users.
>>
>>> +    maxItems: 18
>>> +
>>> +  reg-names:
>>> +    minItems: 6
>>> +    maxItems: 18
>>>
>>>     interrupts:
>>>       items:
>>> @@ -142,7 +146,18 @@ allOf:
>>>       then:
>>>         properties:
>>>           reg:
>>> -          maxItems: 1
>>> +          maxItems: 6
>>> +          description: 5 memory controller channels and 1 for stream-id registers
>>> +
>>> +        reg-names:
>>> +          maxItems: 6
>>> +          items:
>>> +            - const: sid
>>> +            - const: broadcast
>>> +            - const: ch0
>>> +            - const: ch1
>>> +            - const: ch2
>>> +            - const: ch3
>>>
>>>     - if:
>>>         properties:
>>> @@ -151,7 +166,30 @@ allOf:
>>>       then:
>>>         properties:
>>>           reg:
>>> -          minItems: 3
>>> +          minItems: 18
>>> +          description: 17 memory controller channels and 1 for stream-id registers
>>> +
>>> +        reg-names:
>>> +          minItems: 18
>>> +          items:
>>> +            - const: sid
>>> +            - const: broadcast
>>> +            - const: ch0
>>> +            - const: ch1
>>> +            - const: ch2
>>> +            - const: ch3
>>> +            - const: ch4
>>> +            - const: ch5
>>> +            - const: ch6
>>> +            - const: ch7
>>> +            - const: ch8
>>> +            - const: ch9
>>> +            - const: ch10
>>> +            - const: ch11
>>> +            - const: ch12
>>> +            - const: ch13
>>> +            - const: ch14
>>> +            - const: ch15
>>>
>>>     - if:
>>>         properties:
>>> @@ -160,13 +198,37 @@ allOf:
>>>       then:
>>>         properties:
>>>           reg:
>>> -          minItems: 3
>>> +          minItems: 18
>>> +          description: 17 memory controller channels and 1 for stream-id registers
>>> +
>>> +        reg-names:
>>> +          minItems: 18
>>> +          items:
>>> +            - const: sid
>>> +            - const: broadcast
>>> +            - const: ch0
>>> +            - const: ch1
>>> +            - const: ch2
>>> +            - const: ch3
>>> +            - const: ch4
>>> +            - const: ch5
>>> +            - const: ch6
>>> +            - const: ch7
>>> +            - const: ch8
>>> +            - const: ch9
>>> +            - const: ch10
>>> +            - const: ch11
>>> +            - const: ch12
>>> +            - const: ch13
>>> +            - const: ch14
>>> +            - const: ch15
>>>
>>>   additionalProperties: false
>>>
>>>   required:
>>>     - compatible
>>>     - reg
>>> +  - reg-names
>>
>> New, added properties cannot be required. That's an ABI break.
>>
>>>     - interrupts
>>>     - "#address-cells"
>>>     - "#size-cells"
>>> @@ -182,7 +244,13 @@ examples:
>>>
>>>           memory-controller@2c00000 {
>>>               compatible = "nvidia,tegra186-mc";
>>> -            reg = <0x0 0x02c00000 0x0 0xb0000>;
>>> +            reg = <0x0 0x02c00000 0x0 0x10000>,    /* MC-SID */
>>> +                  <0x0 0x02c10000 0x0 0x10000>,    /* Broadcast channel */
>>> +                  <0x0 0x02c20000 0x0 0x10000>,    /* MC0 */
>>> +                  <0x0 0x02c30000 0x0 0x10000>,    /* MC1 */
>>> +                  <0x0 0x02c40000 0x0 0x10000>,    /* MC2 */
>>> +                  <0x0 0x02c50000 0x0 0x10000>;    /* MC3 */
>>> +            reg-names = "sid", "broadcast", "ch0", "ch1", "ch2", "ch3";
>>>               interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
>>>
>>>               #address-cells = <2>;
>>> --
>>> 2.17.1
>>>
> 
> Oh, wait.. I didn't notice that the new reg ranges are only splitting up
> the old ranges. Previously it appeared to me that these are the new ranges.
>  > Ashish, in this case you don't need to change the regs in the DT at all.
> Instead, you need to specify the per-channel reg-base offsets in the
> driver code.

Yes, it's kind of splitting up the old ranges and straight forward for
Tegra186. But on Tegra194 and Tegra234 the old address is not in single
range. It's already split across 3 ranges. We have to choose right range
and add channel offsets to that range in order to read interrupts.
So I went with the approach of splitting the regs in DT itself as per
the channels because that way they can be mapped in a single loop and
used easily.
If we want to specify per-channel reg-base offsets then that would be
per-SOC. Also we would need to choose correct reg-range for Tegra194 and
Tegra234 and have a way to maintain offsets of channels from those
respective reg-ranges.
