Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA437504762
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 11:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbiDQJaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 05:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbiDQJaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 05:30:03 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2055.outbound.protection.outlook.com [40.107.100.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB6B387A0;
        Sun, 17 Apr 2022 02:27:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNkj9b7piBuKnBZGYM7wV+x0pGuoOSHUtX/frjLoQlSyS6j7RtFOYuoS+9AURTeJv+IXlgjovXS1X4hHhRruLI5TkZxWGteVoVYenTE4hFKTGWboSduCMjHOaaZnqnNqCTpJxkYAzWyW84w6tcpqByfmt1wIDxQyiT4uFOBe/bzFNwDd73TMy+VkyBZi/2ND6ckjPi4cu9eNMUHaD8hUhqUrK9Rs/fT77l3bLhIV6XY/2TXsL+F1neGHgh/YyrTZbQd6L7xLyjmyA40B5ln3Ul5ihz34HfA+cME4v/to+uEm5MfQomEtpdIpcBqswbLpZvw3aC6H0Y9jYhTN5HnGMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIwpaS9adKtMQYMFAcQcfd4GSUBHga/RX4nWNU+ugDQ=;
 b=WqEt6EYQMspZzeG3wNMtY6MTGmnHp8mZT18yAmQw+DiApds0/9expIZckx1KOtxawoUR8CEeQbfvVL7GO1K0r1qYBIo+ogPPJYFbEbmbDA6W6nmryS4dJkEIe93e7zxlozQLMGPvikAbWry5CQ6b90bUNHnZkL5xHHvbZzRQKCTED+mzctIhsHlfr16R+CGSQIYfSZnaFIp02VH8+MM0bIb6L/BzRGwAOz/8s7qK6QoVzQ/7CDWknnGSOGRb9+JE9TvE7gLuVHu/13bow3AKieVz8v2ZkpIxxe9vcZj0EUo5AokPGYMk5NEY1fVliAddNVbhOmns/DpL7M4rmxmZcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIwpaS9adKtMQYMFAcQcfd4GSUBHga/RX4nWNU+ugDQ=;
 b=ZoIeb05a9ufjS+pwcq7sCsSpQgOVIZpovsnCI8MQYYdEyX16uUzIlWGEfBtLqmZ+m2FCw7x1cIwacPNYLWVt1V12mJF+HJbSMsDvKq/dq0zQO0NlMBEYi09ck5IZidRVjtLIDWKgZWBWm3InfHxsf0eym4gYQiRpVV/NipmW21W+0PRc4Fc1E323Dp7+2o2UFYCLlSZBxXkxXqv48UYS5K/b9EGVEMaifkUNYOno/goVu/xZK3LHHTiDzUDBEpyReKGUuu93h8qvVBvK+RTiBL4rDjNZHh1cw52CEVlhFQ37BVTJ+nqt1TrBLS6tNwF0c8AkL12TGqLPduwVqwqiLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by MN2PR12MB4190.namprd12.prod.outlook.com (2603:10b6:208:1dd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Sun, 17 Apr
 2022 09:27:25 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef%3]) with mapi id 15.20.5164.025; Sun, 17 Apr 2022
 09:27:25 +0000
Message-ID: <60db2153-2d78-646c-1e5e-e89346991b0c@nvidia.com>
Date:   Sun, 17 Apr 2022 14:57:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [Patch v7 3/4] dt-bindings: memory: Update reg/reg-names
 validation
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     dmitry.osipenko@collabora.com, digetx@gmail.com,
        krzysztof.kozlowski@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vdumpa@nvidia.com,
        Snikam@nvidia.com
References: <20220413094012.13589-1-amhetre@nvidia.com>
 <20220413094012.13589-4-amhetre@nvidia.com>
 <YlbSGEBKgpVC51dZ@robh.at.kernel.org>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <YlbSGEBKgpVC51dZ@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0079.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::19)
 To SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67e0c4a5-24ac-4664-eabe-08da20547bde
X-MS-TrafficTypeDiagnostic: MN2PR12MB4190:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB41902002045D29440A8D2EE5CAF09@MN2PR12MB4190.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3QKUkywkyNrDH95TUZ/iq8i2tIgDltS7gRsWikpepMGCI6zTbQcrnOZnpt/BwKlP/1XeUAbLDpd/uDI7qk09DTHlRytijLSiqwVw0w+563vQeEzHF1Uofid5Tqbu7oLDylkmJfmKPE3LbkEUH6tUsAbCXwS03rPexUqlxReJqGF7jvHe1x4hPpyfewffag9YVMjrG3u8Ua03vP0n5mwu73BL6IfFT+nPoS4r79LAybEIoSG+qzK4x+pP4PBs86yfQnrB0UYQ3JMCyK/2rAY0jZ+IGnA9Vu/dFHECBsZsU9ngooUiALIptHi3nq8wpiNWBAZSRtwxBpNbLQso3WXXLwq1/3L9nzHZXc7xFB4yHQD7evNuMNScCZBglaOX3nkeK3l43AUUCFfLqr7isx/zN6EvYCiUyUtygsXV9/kAkPLQELbCtypeHekOQuDkpP2d/Qnur1T0eT9n9Ce6li7zUmRI145son3fSJSgfM1K6VlQCwhsxChjm+gVrE31vffubSx6YO3gNF6hpMwtmtVYxUs25QZ6NLHORQu/0P9VsiVbcyziGYaysw/zEVOyg3KZwzozQPZnlyqLP4G2If7SMfW8CpZOvF/8VUM6RhlNXwXag8wiG1cYpwpBSmtgxlsA2jSKPobPY8IbJ1gRMQrsgbLPiw8VqkLmtXI214XRb21P/0Tn03u/C00JcNTcF0QEnTxZQ8AL2DGXOSUFEadRLwfxMGNgxA4KhM8qlW3YiX4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(15650500001)(186003)(83380400001)(2616005)(55236004)(26005)(5660300002)(31686004)(38100700002)(2906002)(508600001)(6666004)(6512007)(6506007)(53546011)(107886003)(36756003)(6916009)(316002)(6486002)(66556008)(8676002)(4326008)(66946007)(66476007)(86362001)(31696002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXdtU0I2ZGdIdVA4bVlTTEpLeEZ6bGtObmZzWXUvZXdBNUJWZG1oMmtHalpQ?=
 =?utf-8?B?c0QxYkZVdjBKSWt2dFZEa1ZKNFliVXNxelFCdDM0RnJWaHRsaXNBdlNLTVU4?=
 =?utf-8?B?ZzJpNk5yT3VQS2tRNnRrZDR1ek8vSFdXdyttTHVYL2MvZUE2MDZOZUFOcmpT?=
 =?utf-8?B?Y0FiS2tjN090K0gxSUQ5NXBKZCtyWFd6YjRJY3B4ZUVGcFlKU3oyRlN3bFE2?=
 =?utf-8?B?bDF5dW1sTlM4NCtFZVkrcmhPUmlYSFhRdkg5K2huZ3lGbWUyc1UxeE9ra2xp?=
 =?utf-8?B?eHo4VU5GK29GQWhFWDdwYkJYOTlxVzVuN0tNK3JxbEpmd1d3cEhNbXQ3WE11?=
 =?utf-8?B?S1JJMHl4RDZvb3ZSS1VxaUJMeklyY1ZPWDQvTjM3WXdjL2gvWmQ4U1lobWVH?=
 =?utf-8?B?b2gvbDNxSW9yWWd6alFwVDNXdWRxNHk5MzJDYjlmYXBRd1pVeUxPNUdVang4?=
 =?utf-8?B?YklsNlRrQnRZZStTdHZuQXZFNk80dlFuckVOOWZZQ2lhbTltTnRiTHByZWFS?=
 =?utf-8?B?dkJ0c095OS9RSkw2L3lwaFQrYnN6V3QzWXVzY2JJa3N0UFBldWdScVh5TElN?=
 =?utf-8?B?T2xjN0J5TnVwV1pNWmFmZWxKYUJzQWs3TyswNFhibnkycTdkOUZmNWwrVXlQ?=
 =?utf-8?B?RXFuOHVlWnFTS2dTZ1dTN3dSanYwQkhxUVgremxrTmM2QVhDYTcrdkk3d0p6?=
 =?utf-8?B?Y3pJT1hlb2puZ3pZL0hMMHk2MzA1S0NLTUZBUkJmcGRWTTYwdDRaeXU1SUt3?=
 =?utf-8?B?UDlwaDJZZ1ZkZFd0cVlkRTNvaHJUYnc1T2l2U09hbFRLb3dUU3JMT1FYYzBn?=
 =?utf-8?B?c0VMRVZvaXM5Tlk5U3c2RHlJVkd1cVZrTkdDcldTN01UU045UEVyeWpVbXZB?=
 =?utf-8?B?a0x0ZVlaRFJVZFZpSlMxUXI5WUJCMW9xSm51Zjk1enIwcm5uR055NUdZTzVL?=
 =?utf-8?B?NGNlS2E5b2hCSEd4bDZaTm43WGlONWdFZTlJNHRaWXFRZ0RMVGJaUm12d1p6?=
 =?utf-8?B?RjUvL3RxaUhtSjl6czFuRXFWdlNaNVUvS2pHV0dselFoZ09rTWUxSkhwTlRE?=
 =?utf-8?B?WVh2WVBHK2ZWTjR6RldmRlFaWjEzRWJmdXQxODNMWmdSV0tJUmdiSDZ6Vk1a?=
 =?utf-8?B?WjI1bVZZa291ZXZpQnNzWHJQMnJNaVcrVGFTU2dCR00zSHBvMENQSEZHWmpV?=
 =?utf-8?B?UU9BYmcyV1dsUGVZeU40M1h5RDFpWGpUU1l6KzU2aVpzaXpYZ1dTVm5UOVVK?=
 =?utf-8?B?a0RxOFd2UGplWHFoRXlhenFuR00yNDlmbEhYczU2Z3Rpbm5hQUt3aEU5Y0Jh?=
 =?utf-8?B?SlFoNDlPcFVCcEgyNnFkNGc3Nkt5UGg4RGxiNU8vR1VKbEJ2aHVKdldjUHpC?=
 =?utf-8?B?SzRvU2JteEQxOTlNUDN0aEZ6aWFYSUZqQURhZ0RJWXR1UGdzclJGTThkSTBp?=
 =?utf-8?B?MHQzUXcxUVFOSEkzMFhQS1ZCaVgvblpmT0dwVm55cU1RUTRvTVFpSXdQY0Fx?=
 =?utf-8?B?bVJHclcrMlV6Y3FrbHR2SlhacUJhS3BoVStwRytnR1g3ZmNCUFRmSkgvbGRp?=
 =?utf-8?B?U0cydzFNZkcwcTZiZGI2MkhRLzhRZlVtUHl0Qzg0V1pXclEzcmlCTGl2WXBJ?=
 =?utf-8?B?c2FyNjJES2gwQzMrc21uY2RYS3JoL2ZsZk9lbWN1UmJyTGQ5Z1hrdFdYb04r?=
 =?utf-8?B?L252ampPZjlhTlV0NERLQ1N0NXRnSVk1c09MUms1VjJHNVdmV3RicDNHbGwv?=
 =?utf-8?B?RWQzenFDYVBoYXNBT0c2SHE5eThQZFR6MGJaNWxBMDlnVXJjWFNVR081MnQy?=
 =?utf-8?B?VWdiTEExYzZlM01Qdi81cnpIcER4cStYeit0LytZdVkxSDlNY1lxZXJxOGNh?=
 =?utf-8?B?YzJzTXpwcFNYVEROZEVWZllNOUVqTjg0MzlDZUJNQnk0ek96amNrVUxvYTQz?=
 =?utf-8?B?bi8vTjVCYTdmNFo3dlV4NEYrVHZXMUUyUFNLRWRRRjgrQ1JEajdWZVIvNGpx?=
 =?utf-8?B?VnZFSTRDSXZWNnpBTmRjZ0NaSEUzUTJmeTBVWGVLNkc3UGJxTnR5SU5NeFRE?=
 =?utf-8?B?R0V1cnFvcWNrdFNLeVBhSHZDYjk2d1FuUVBpcFVrSGpjNlJEOWlLVElTWlpm?=
 =?utf-8?B?eHV6SDBCRDl6NXpEWldmRmlzTVZmVXJuemJJQktMd3JnUllJQzFFekNqQmtu?=
 =?utf-8?B?bml1Tmx4eFRmdjBaOFdxVVc1cThOOUVBRGx5cURkNWpwZ0o2VGQ4T2MxMU9w?=
 =?utf-8?B?MFhUV3FPVHRTYmRDWEF2eTVWU2ZPT1ZMVWVUT2EvZEExV21uZEhHUCtMMDRR?=
 =?utf-8?B?UmJJY1ZIUmtBN1ZERzZ5TkR5c0Vua1Z4UlVJTDdnMitHT3FGNTVBZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e0c4a5-24ac-4664-eabe-08da20547bde
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2022 09:27:25.7631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fRYwqj+0DWvEfyVpQUHOAb5zMdPRP1todc2kyaLaGo4roC4d1SlP6dCnHggTZW2eD051x3BDtM2OPVBPvyK+zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4190
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/13/2022 7:07 PM, Rob Herring wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Wed, Apr 13, 2022 at 03:10:11PM +0530, Ashish Mhetre wrote:
>>  From tegra186 onwards, memory controller support multiple channels.
>> Reg items are updated with address and size of these channels.
>> Tegra186 has overall 5 memory controller channels. Tegra194 and tegra234
>> have overall 17 memory controller channels each.
>> There is 1 reg item for memory controller stream-id registers.
>> So update the reg maxItems to 18 in tegra186 devicetree documentation.
>> Also update validation for reg-names added for these corresponding reg
>> items.
> 
> Somehow your subject should indicate this is for Tegra.
> 
Okay, I'll update the subject.

>>
>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>> ---
>>   .../nvidia,tegra186-mc.yaml                   | 80 +++++++++++++++++--
>>   1 file changed, 74 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>> index 13c4c82fd0d3..c7cfa6c2cd81 100644
>> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>> @@ -34,8 +34,12 @@ properties:
>>             - nvidia,tegra234-mc
>>
>>     reg:
>> -    minItems: 1
>> -    maxItems: 3
>> +    minItems: 6
> 
> You just broke current users.
> 
The DTS changes are handled in driver. The driver is compatible with
older DTS as well. dt bindings check will fail but that will request
the users to switch to new DTS. Will that be fine?

>> +    maxItems: 18
>> +
>> +  reg-names:
>> +    minItems: 6
>> +    maxItems: 18
>>
>>     interrupts:
>>       items:
>> @@ -142,7 +146,18 @@ allOf:
>>       then:
>>         properties:
>>           reg:
>> -          maxItems: 1
>> +          maxItems: 6
>> +          description: 5 memory controller channels and 1 for stream-id registers
>> +
>> +        reg-names:
>> +          maxItems: 6
>> +          items:
>> +            - const: sid
>> +            - const: broadcast
>> +            - const: ch0
>> +            - const: ch1
>> +            - const: ch2
>> +            - const: ch3
>>
>>     - if:
>>         properties:
>> @@ -151,7 +166,30 @@ allOf:
>>       then:
>>         properties:
>>           reg:
>> -          minItems: 3
>> +          minItems: 18
>> +          description: 17 memory controller channels and 1 for stream-id registers
>> +
>> +        reg-names:
>> +          minItems: 18
>> +          items:
>> +            - const: sid
>> +            - const: broadcast
>> +            - const: ch0
>> +            - const: ch1
>> +            - const: ch2
>> +            - const: ch3
>> +            - const: ch4
>> +            - const: ch5
>> +            - const: ch6
>> +            - const: ch7
>> +            - const: ch8
>> +            - const: ch9
>> +            - const: ch10
>> +            - const: ch11
>> +            - const: ch12
>> +            - const: ch13
>> +            - const: ch14
>> +            - const: ch15
>>
>>     - if:
>>         properties:
>> @@ -160,13 +198,37 @@ allOf:
>>       then:
>>         properties:
>>           reg:
>> -          minItems: 3
>> +          minItems: 18
>> +          description: 17 memory controller channels and 1 for stream-id registers
>> +
>> +        reg-names:
>> +          minItems: 18
>> +          items:
>> +            - const: sid
>> +            - const: broadcast
>> +            - const: ch0
>> +            - const: ch1
>> +            - const: ch2
>> +            - const: ch3
>> +            - const: ch4
>> +            - const: ch5
>> +            - const: ch6
>> +            - const: ch7
>> +            - const: ch8
>> +            - const: ch9
>> +            - const: ch10
>> +            - const: ch11
>> +            - const: ch12
>> +            - const: ch13
>> +            - const: ch14
>> +            - const: ch15
>>
>>   additionalProperties: false
>>
>>   required:
>>     - compatible
>>     - reg
>> +  - reg-names
> 
> New, added properties cannot be required. That's an ABI break.
> 
This is handled in driver code to make sure driver works with old dts
as well. So is this bindings change fine or shall I change it such that
dt bindings check shall pass with older dts as well?
Or as mentioned by Dmitry, I can update the commit message to reflect
that ABI change is intended and driver is compatible with older DTBs as
well.

>>     - interrupts
>>     - "#address-cells"
>>     - "#size-cells"
>> @@ -182,7 +244,13 @@ examples:
>>
>>           memory-controller@2c00000 {
>>               compatible = "nvidia,tegra186-mc";
>> -            reg = <0x0 0x02c00000 0x0 0xb0000>;
>> +            reg = <0x0 0x02c00000 0x0 0x10000>,    /* MC-SID */
>> +                  <0x0 0x02c10000 0x0 0x10000>,    /* Broadcast channel */
>> +                  <0x0 0x02c20000 0x0 0x10000>,    /* MC0 */
>> +                  <0x0 0x02c30000 0x0 0x10000>,    /* MC1 */
>> +                  <0x0 0x02c40000 0x0 0x10000>,    /* MC2 */
>> +                  <0x0 0x02c50000 0x0 0x10000>;    /* MC3 */
>> +            reg-names = "sid", "broadcast", "ch0", "ch1", "ch2", "ch3";
>>               interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
>>
>>               #address-cells = <2>;
>> --
>> 2.17.1
>>
