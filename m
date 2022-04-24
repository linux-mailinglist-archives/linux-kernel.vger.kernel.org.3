Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0273A50CFD6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 07:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238283AbiDXFYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 01:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238263AbiDXFYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 01:24:10 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A462AE23;
        Sat, 23 Apr 2022 22:21:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mszKNp5wc2vdoNtbsW05Gs4V+9vWoyVmrbePVoEZ8cktdGEvGw8wOqbv258BT/RTJTSZeB9JxcWN9wH1dKu+B3da5Use5YbGkCai2sAYMansHxG51TGZbdWW1sxNuoEt3E1bfn3SRNAe4MDTw1M0WAAhZo1QzEp0eQ71TfNkXnl8Vwj8YXafK7PrGJAAhiKvRV57uZE/XtAQ9lAohDuls6i6k3zuxKBfNBGmKh4mf/tEfUAqGkAgp6aq75nqHiWqWnSIfgX4PUMpvtAFgQlUJWzjoh0hBCosEkwmvnPSz4OKCtNSn3eGtkFoVv/6O96lvQQ8792Voi0vBwnuI2RCQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kczy+Y6YvEGKDLbUd/503Y58m7piqvkRMbC6tlO9m3I=;
 b=bIARXmWdDR8hKYsyXDhyeOuQjFZNR919FNvmzAP8bU6QosjW+qrsUau29tfHzvTu+77NuZprDU1BKJ5mCFHnqsQDtPyOrVljU+PIsWdtoFcRg2+IDnmQw7rDcQOdX9FojP04XoyM7GpDBONSmgCQSBtXjDNRKryPxSX0/s4usBoPH+6PFJYKhoOJgpwTpf6qpxbH3SO7XHCwannDkP7yTA/pW40UiJ2s68DaoD0iFuYdMhtNj9F3Mv1gFM/eaHFGj/t/MtQrYvxv2ru5qVtz0lHsusBbaX60SXY5QjqBsFBTpnNZkdM2WTZZOMnZPZbaACLQX24zACyW25I7IZXmPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kczy+Y6YvEGKDLbUd/503Y58m7piqvkRMbC6tlO9m3I=;
 b=HsQox/Dchedyrbic12D2oi6eMh6wt4NFRF9CLCt9lOR9KymR1ZHTck+yh1QrreyDnSrpvqhKijTWiGOv/U6b5XsZwF+YnFmaizRtMkcCIGYxIqThyzUkK/b06YSYnsswTjkoir/9b+afcnjigJq5hP7ANLA8YsnJE2pRybYZ/KARo2eBiJNUzQkvn+tB4crbnOwosruI0/eWk9kFnskV+ZLGdF1T9cpFW4LRADNA0UFpwmOdij394vSCF026RslLD1e+LlbW7GFICQHdiS8fbNe0GgSCIBBaHbP9ZdpH1dQU9etvlh39r9lFhpTlzFNNYVXNOVygoFm4PcknfZtfvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by CH2PR12MB3848.namprd12.prod.outlook.com (2603:10b6:610:16::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Sun, 24 Apr
 2022 05:21:08 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::4d90:3332:acb3:395d]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::4d90:3332:acb3:395d%5]) with mapi id 15.20.5186.020; Sun, 24 Apr 2022
 05:21:08 +0000
Message-ID: <011311d4-7139-c10c-edd7-119f5466469e@nvidia.com>
Date:   Sun, 24 Apr 2022 10:50:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [Patch v7 3/4] dt-bindings: memory: Update reg/reg-names
 validation
Content-Language: en-US
From:   Ashish Mhetre <amhetre@nvidia.com>
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
 <60db2153-2d78-646c-1e5e-e89346991b0c@nvidia.com>
In-Reply-To: <60db2153-2d78-646c-1e5e-e89346991b0c@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR0101CA0051.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::13) To SA0PR12MB4349.namprd12.prod.outlook.com
 (2603:10b6:806:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ba43bc0-6ad2-4996-d745-08da25b23cae
X-MS-TrafficTypeDiagnostic: CH2PR12MB3848:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB38488B0211ABAD32706999F2CAF99@CH2PR12MB3848.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WhSAalMf+NuTUbpWsBovgKZ4DItQNxhv2wipzIE/F1IlwHb5J3v/WN7+YzbRmosn3c6FlcljR7zqabXXoUJMlYg7LNHBriglNqL/e2kSjhQOYZOyml/Wx1VL741aJ2h77PDy3ufhm921LQQtrHtdoQ2tU0I1FjVkVIrGnQ2Gb5WMSfNvBdE9R5fFwBy6+/b1P0z27r/wHl6Py2uev+uZUPpZoUpV5YvRrsnkPTf5qjQ4+8f2nUrk3CSrTBwGkPxE+kvyLQFoNGLRidUO/liAnjj18FP5Lqt6LJ9TkJ5ZIpz0UXxA3G1j2qDkQPm9ZhcpbroQe9EOFDH+BA+OwLFLCeGmXkw/bwr+4h0kN3raoCRSlWcpPrEe4/cf8jODe4hFixAxmBclNhESaw8/lbY7ssdhFaqtmls5dYvYytT+F3EWJG9aUWYclF7lwZKJiYunAttEnYyZh6cbfqDOerECL/3NPaEEu/C9Kk2hFi7dQRUAcwmmM1ItMoHo1s/Nl/wP4yW8n8yNuCtVYHXVHwJwbpklF3k/65eD4bOD9F9mHq9p5dacgDFpyCVa/oBqStTFOLZbuicTs3FgUkTCKf8YWrgGTTEi/GTianoap94WnxoKMVwkAbIsy8D99Ws8QU1D0P3nzI+bv+V+zRCqdUhsNyOroTtIjL+6DDoL1Mlt6RtOcDYe/jUcdjTj42qzGwNGuuvS6mvJf4j5t4vAOZ+88Cqly223kchTZdf7Vi27Oco=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(107886003)(55236004)(53546011)(6512007)(26005)(6506007)(2616005)(6486002)(6916009)(508600001)(38100700002)(83380400001)(31696002)(186003)(86362001)(2906002)(8936002)(5660300002)(36756003)(15650500001)(66476007)(8676002)(4326008)(31686004)(66556008)(66946007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHpNNkcwcElxWldOcWVtQ21ZOHpESkFPL2svUVJpeitqMFl4Mjc2RlBQRVFL?=
 =?utf-8?B?ZUFBekxxaGU3L3JSQThpQU1vM1hJNllRandBU1YyaFg1d2x4bnU3MEdFekVS?=
 =?utf-8?B?NnczcWhTM3RGVDJQb1BzZ1E3YXo0K212VHcvMXlwaEdrbVJNV0IzMVJoRG1j?=
 =?utf-8?B?MjdMNDRRRDd6ais0eE5SZVEyWGFCYmpRMGdSTHJCODN1dTF5Sy9QeEhBMlh1?=
 =?utf-8?B?T1V1UmpWTEFkVDlKVlBLSDZ4OEU0eWltU20yNTJ5UUk4ZFZVVTlmbmk0Y1FK?=
 =?utf-8?B?alk4YmpwaUZiNHRaSEE5aHFNdXZoQ1pIdy90QkJHdUUxdWhwUXFuUHAyeE0y?=
 =?utf-8?B?K3dXZmYxOHNDb3BkODc5RzlYUCtzdHlPaUJ5TjlIbWtmYUs4ejZucVRzWThz?=
 =?utf-8?B?MnF0NmdETjQybjZYY0twL2pqa1g4ZkVURXRLQ1FCbmVWUGVSdzM4STEyaWtj?=
 =?utf-8?B?V05zc1pmNWp3YTR2c1hIUmZON0hHMDVhR1dXUEprcWZkY1R6dE9mTzNyL3Fy?=
 =?utf-8?B?VE9tUUVCdVpNYlRPNW9iTndjTlU5MEpZYVBtU1YzWWIrdTVwdVdhZ3Jvb1VR?=
 =?utf-8?B?NEs3bEYraW1ZWWdMOUpxYk9JZmZWT2ZMdVlnRnYwYitMd3lqTC9iaG9INnVi?=
 =?utf-8?B?RGtqKzEySC9ZOTRqRjNmN08vYWppYkR6M1hpS3Z3NUx2MTlsUUJOcHRmY0pB?=
 =?utf-8?B?T0lrcTJIeGZXeU4vb2FyTDJ4YmZvcjNucUlJU3ZNTGhnTlRDWHZPS08yWnU2?=
 =?utf-8?B?clFkWit3aStnc0FudTJPY2FKckxhdStYK1B1ZXN4RTVOVkh0M05MSU9XOTAx?=
 =?utf-8?B?OXpYWlpWdnd3dFhkdUxnbVZhcUo2YUlVQlRSaHZHdEYyUlNWODMzRzJkRFZT?=
 =?utf-8?B?WDM2TUR1RmMrVzdIM2tHZ1F2VDg0ZUM1Rjh0NTdSNVQxL0JvM3c3TnZjbTNi?=
 =?utf-8?B?WFpCMUtXQjUwYzJ3Nkh5U2lWRXp4NG9OVEVkdEM5T0M5MHhKL0REdjhXWUlQ?=
 =?utf-8?B?dnc3dEY1a2diQ0dBclYrL2dqVVNVRFlFQ05qVzdKenU5a1NVaHd3R1pFak9B?=
 =?utf-8?B?c21mTFJ1ZytObmVQc1RVOXJzT2twNGdZKzFGTVV0Z3Y5Z0VMbnk1NjZKd25H?=
 =?utf-8?B?Y3JKeHlCeGtyRjh0VTVLVEtZbzloK2kxZW5FeC9IOVJsc0NPT0ZVQ3kwY3J2?=
 =?utf-8?B?bzBFbnh3Yk8vZ05zOVM1MlFvQTZEUFRRa1kvaUZTL09POFgwSldLWW50R0Z5?=
 =?utf-8?B?VVZOeGVtOUxCTGxCV256TUxuVG1acmRmQWJ0dVFKRUNOMDRXQzBsQ1ZMcHVR?=
 =?utf-8?B?SUlqVGtiODBsU25tZTJFRmN6dmtLeGk5OUloMUJ6NmgzV1RCbkNlUk8rNENl?=
 =?utf-8?B?cnFWcWNYdFBPQmYwWEdNdUNnRkNCR0lVNVdIeURqeWt6UW0zZnUwemtCeTlI?=
 =?utf-8?B?TWRWM1c4Mk1nYzU5dVZOTWpwRXpqejlzckFyaDNKK09HRmFTR0diN0g4UEJa?=
 =?utf-8?B?L0hrMlgrVHVOaDlySEpyTnVDSEJuMEJwcXlyS3NHMklHQ2laTERBMERZcXBk?=
 =?utf-8?B?T09TSi9STVRxYk4zcFI4c212aFJXVU5US3MyMGZWbHpPalBxT1lsMG1HSnV3?=
 =?utf-8?B?b3RuQjhzYnlNcmc5ZlFZT0MyUXFDbE9PNGhMWVowbFAxaDJHSC9CUkk5OGVF?=
 =?utf-8?B?VUVCZllZVzg3V3FlOG9kekl2WENKeWRwNWJTTWJrVVQveDhhMGk4TUE3R1RI?=
 =?utf-8?B?YXFMb3dHak5hMnlleFNLcHNoeDM1amNWajlGQjcxTWM2YWIraDU4cnZLMVlY?=
 =?utf-8?B?c1VzbWtrYVpXd0ErNE1DbGNHTi9jNDJIMnFkSmJqS09BcDc1d0VtUjRBclgr?=
 =?utf-8?B?enlyQkFrcWNDdVJ2eFIzbWlZZ3pxcnJHUU95UU9nNU9Wa0sxRkRrbVg1ZjlE?=
 =?utf-8?B?aGRsMFJOVlRjV2RLNnM2M2R4VkRyeGd6Qm81VnpGbHc0akVteWROcmlHOEJJ?=
 =?utf-8?B?UlFGQU5YRHNuMjNFdnNBeUFHMURXTFJWK3VaV1hIVk51U2NZVVkrTjNuWFYw?=
 =?utf-8?B?STg1aGRnanB5N0ZpY0p3aVFtajdVM001VXFjdnNsd0RETUFhWUpiZlVyZWJP?=
 =?utf-8?B?R1RFSk8zL0FOL3pDL2VvazU0WEhPZE1iQXk2cjFIZTFZNDMrV3pLNVBCNHNM?=
 =?utf-8?B?NXphZ3VleXAwVFZGMGUzQkxyVWg2OEFna3I0VkZSMGh4UHF4cGZ2TDUvcUVj?=
 =?utf-8?B?a2tnaHZYdVhJd3Uyc2lOWjdjYWpCNjI4bEp5RHNRaW1Md3FkNU9WUEJDU0pw?=
 =?utf-8?B?WjIxZkFlbG9Ra250QlErN0tsVVo4OWxVekdKRzN2dHd4bjQ0UVIxUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba43bc0-6ad2-4996-d745-08da25b23cae
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2022 05:21:08.2906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TEyfIzhuPwp6fGRkXVsnb8R2GtGKETa8mKWzl5JxfOpr2R7anATlS/3n6YHpza+gIw37kdXfkDzgos4FsH5crQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3848
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/17/2022 2:57 PM, Ashish Mhetre wrote:
> 
> 
> On 4/13/2022 7:07 PM, Rob Herring wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On Wed, Apr 13, 2022 at 03:10:11PM +0530, Ashish Mhetre wrote:
>>>  From tegra186 onwards, memory controller support multiple channels.
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
> Okay, I'll update the subject.
> 
>>>
>>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>>> ---
>>>   .../nvidia,tegra186-mc.yaml                   | 80 +++++++++++++++++--
>>>   1 file changed, 74 insertions(+), 6 deletions(-)
>>>
>>> diff --git 
>>> a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml 
>>> b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml 
>>>
>>> index 13c4c82fd0d3..c7cfa6c2cd81 100644
>>> --- 
>>> a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml 
>>>
>>> +++ 
>>> b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml 
>>>
>>> @@ -34,8 +34,12 @@ properties:
>>>             - nvidia,tegra234-mc
>>>
>>>     reg:
>>> -    minItems: 1
>>> -    maxItems: 3
>>> +    minItems: 6
>>
>> You just broke current users.
>>
> The DTS changes are handled in driver. The driver is compatible with
> older DTS as well. dt bindings check will fail but that will request
> the users to switch to new DTS. Will that be fine?
> 
>>> +    maxItems: 18
>>> +
>>> +  reg-names:
>>> +    minItems: 6
>>> +    maxItems: 18
>>>
>>>     interrupts:
>>>       items:
>>> @@ -142,7 +146,18 @@ allOf:
>>>       then:
>>>         properties:
>>>           reg:
>>> -          maxItems: 1
>>> +          maxItems: 6
>>> +          description: 5 memory controller channels and 1 for 
>>> stream-id registers
>>> +
>>> +        reg-names:
>>> +          maxItems: 6
>>> +          items:
>>> +            - const: sid
>>> +            - const: broadcast
>>> +            - const: ch0
>>> +            - const: ch1
>>> +            - const: ch2
>>> +            - const: ch3
>>>
>>>     - if:
>>>         properties:
>>> @@ -151,7 +166,30 @@ allOf:
>>>       then:
>>>         properties:
>>>           reg:
>>> -          minItems: 3
>>> +          minItems: 18
>>> +          description: 17 memory controller channels and 1 for 
>>> stream-id registers
>>> +
>>> +        reg-names:
>>> +          minItems: 18
>>> +          items:
>>> +            - const: sid
>>> +            - const: broadcast
>>> +            - const: ch0
>>> +            - const: ch1
>>> +            - const: ch2
>>> +            - const: ch3
>>> +            - const: ch4
>>> +            - const: ch5
>>> +            - const: ch6
>>> +            - const: ch7
>>> +            - const: ch8
>>> +            - const: ch9
>>> +            - const: ch10
>>> +            - const: ch11
>>> +            - const: ch12
>>> +            - const: ch13
>>> +            - const: ch14
>>> +            - const: ch15
>>>
>>>     - if:
>>>         properties:
>>> @@ -160,13 +198,37 @@ allOf:
>>>       then:
>>>         properties:
>>>           reg:
>>> -          minItems: 3
>>> +          minItems: 18
>>> +          description: 17 memory controller channels and 1 for 
>>> stream-id registers
>>> +
>>> +        reg-names:
>>> +          minItems: 18
>>> +          items:
>>> +            - const: sid
>>> +            - const: broadcast
>>> +            - const: ch0
>>> +            - const: ch1
>>> +            - const: ch2
>>> +            - const: ch3
>>> +            - const: ch4
>>> +            - const: ch5
>>> +            - const: ch6
>>> +            - const: ch7
>>> +            - const: ch8
>>> +            - const: ch9
>>> +            - const: ch10
>>> +            - const: ch11
>>> +            - const: ch12
>>> +            - const: ch13
>>> +            - const: ch14
>>> +            - const: ch15
>>>
>>>   additionalProperties: false
>>>
>>>   required:
>>>     - compatible
>>>     - reg
>>> +  - reg-names
>>
>> New, added properties cannot be required. That's an ABI break.
>>
> This is handled in driver code to make sure driver works with old dts
> as well. So is this bindings change fine or shall I change it such that
> dt bindings check shall pass with older dts as well?
> Or as mentioned by Dmitry, I can update the commit message to reflect
> that ABI change is intended and driver is compatible with older DTBs as
> well.
> 
Hi Rob,
Can you please confirm how shall I go in next version?
Is it fine for dt bindings check to fail if driver is compatible with
old as well as new dts? Or dt bindings check shall pass with old as
well as new dts?

>>>     - interrupts
>>>     - "#address-cells"
>>>     - "#size-cells"
>>> @@ -182,7 +244,13 @@ examples:
>>>
>>>           memory-controller@2c00000 {
>>>               compatible = "nvidia,tegra186-mc";
>>> -            reg = <0x0 0x02c00000 0x0 0xb0000>;
>>> +            reg = <0x0 0x02c00000 0x0 0x10000>,    /* MC-SID */
>>> +                  <0x0 0x02c10000 0x0 0x10000>,    /* Broadcast 
>>> channel */
>>> +                  <0x0 0x02c20000 0x0 0x10000>,    /* MC0 */
>>> +                  <0x0 0x02c30000 0x0 0x10000>,    /* MC1 */
>>> +                  <0x0 0x02c40000 0x0 0x10000>,    /* MC2 */
>>> +                  <0x0 0x02c50000 0x0 0x10000>;    /* MC3 */
>>> +            reg-names = "sid", "broadcast", "ch0", "ch1", "ch2", "ch3";
>>>               interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
>>>
>>>               #address-cells = <2>;
>>> -- 
>>> 2.17.1
>>>
