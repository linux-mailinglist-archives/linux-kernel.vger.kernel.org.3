Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A334FCD7B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 06:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344243AbiDLENn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 00:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiDLENh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 00:13:37 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674412E6AE;
        Mon, 11 Apr 2022 21:11:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5Zud59RRx7D/kZ6bcwosHWnHuvz8jUGRBM+mT3wtvNejgaqtIL8LDQEJ0aSFTBCRFydcbOcMXcbSDL5RvMiRtz6e2ALtk8D2gyv7xjcmuSIBv2IsnTr3ASV5R2cb5azaUJ533LG3r2kZq5iBCggtimNMywwX2iYegd3m+cJ88vtIp+MTNZ/oy8JHysMx8ypCgTDx7C/n3PhJ+gbhQhgZHbXt2iEZprIHpVZS9tPJ1PZEunXXWwElIqpyj+GCkd9nieB5fOoTpvUsvM3lajbchpeUv0YHZY+fCP89e5y7jiMdhEV/zllxOXItX+9g9PmRJcYBEmQqCj80J1jnlEdIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y5xvW9CPEDcvHH1Exz8erJYFBBnyOFl3GwNa654ZeF0=;
 b=B5jo4sg0KMpVOrroMUbx7Ppy6eFSfCFifquuj1H6HbY+45xNcjWA1f+GV/sVBe2v6xX6pULqRpPoGQEmSMjYMF5ryArw3jikm+c8QsTeicuKJKElHQxGUjXSLtWxWq+q5b67OiGw8lea/frlKvHLwzy/ke7VZMkjNc8ITlB14/5xZOkDVugXZIaR9a2X66+seEsbZullPIGoFUS9nEk8tC+AUAqeCGJyoQ2cVjJLCTVZry/WfD4NZOBbKwanyBKiEloLjTZzMAOwyjuDggaVzr5T1M6Kool76H4xyth4iS73yzvAjinxVo7KMsbpIhpETOPYwUsIjZnkBwGF5UzYVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5xvW9CPEDcvHH1Exz8erJYFBBnyOFl3GwNa654ZeF0=;
 b=W+BV9ZYdBzrMOaztV0iAOL/VN6LEhknqyUFCO/ADwQxrojyMrLlv6Z9BLOu8X4u7KlaA6aQ1hXIkmm3x8qyg80pD/iukyS/6rxqHSKYr+xY4uRQWBHeIjtn0ppnbUrDwCZ/o0IjhXVuHI8s/kD/Hj8CIDp5EPIVB+QzqkcsobzmE11s5w61Y55z15027/RECtoT4mOsSMsmsxZcVLmd7eUBW73NiE/rig/+cyncNFEKugLi0pav6UgLKgxW+23qu/S+Myn/fzvCV8tHH1bEUCGJF9852gISpCAXsfOP65bkyaJlmCDUgfbb+QwGf34JgzIPmZ1Tj5tK0O0UAOSuqJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by BN8PR12MB3234.namprd12.prod.outlook.com (2603:10b6:408:95::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 04:11:19 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef%4]) with mapi id 15.20.5144.029; Tue, 12 Apr 2022
 04:11:19 +0000
Message-ID: <5ff3e414-9c3f-5e4a-8851-6a94f2d6b05b@nvidia.com>
Date:   Tue, 12 Apr 2022 09:41:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v6 3/4] dt-bindings: memory: Update reg maxitems for
 tegra186
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        krzysztof.kozlowski@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220406052459.10438-1-amhetre@nvidia.com>
 <20220406052459.10438-4-amhetre@nvidia.com>
 <3e044f9e-3200-bb26-897d-1977e3825c92@gmail.com>
 <81686bc4-c580-862b-1c29-51b34e419154@nvidia.com>
 <57825f4a-8cfa-ef00-6462-fea37cd4d7be@collabora.com>
 <8930bbfe-2c33-ea90-c48d-c6a00005b6a5@nvidia.com>
 <3c80282b-0d63-1e1f-1036-1c8e79f1cbbc@collabora.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <3c80282b-0d63-1e1f-1036-1c8e79f1cbbc@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXPR01CA0102.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::20) To SA0PR12MB4349.namprd12.prod.outlook.com
 (2603:10b6:806:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92a9cc3c-e6f2-4c13-644b-08da1c3a7ef1
X-MS-TrafficTypeDiagnostic: BN8PR12MB3234:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3234B4927AFF648B8D327996CAED9@BN8PR12MB3234.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FPRmSh2raUWLd6gxPkWZngLSBRKCOCrfYOD+G+wuNFE37bWZ/u+Gm69cYK25oyyFc1M4PHYq9IwnQNrd/YaRoS/la2i/8i6h/G/iWLQYRNFjLCKdiEY2UPkQNAm+c4hUBV6MGDag7GyFWMUEm1VSqL/DSCJEqB47nqvyi8kxNCDThRFghNw7Zb0k4Gb984FW0p+O01+W63rj9hOxPwdneP0mqNd2v8xwgmbW2Tazih+4ciw7l+EshtDtYYNLd2lFbAw52OGU6Zsjz8pMe7lIoQrLeUr7Nx5ObT/krTn7dozeCf/b34TEUl69YVK2sw6Vryd3b5A3+C+Aml5Gt2GzQnggi5Qi/mSqFL9aiNiZ+29UKUXLGDTnVH6URMCMqMLh1RNFiIPDAsyDwqJ69aRSKycumJv/1loCcnml9TPoQYEBESolIud/kr+G/npKSIRujC/3ajIt2/VF5gfgh389zKwFqiDY1pwGzbztmz7WN7+PhHKcW92P6C5rk6hofIm1vqXWrALy44E7aOD+XK/lFplsRcFtBy30iihj+9ONH6RMHRT7YBGf1i3rglBNawG83OsTaRHdlxEgxr36ZUNUMXry3DpL+FSnJ5TkYJDsIU5OFc6c8s6KNzVI17FULZuVgQx4S/mYTPL+dbxtg8KDhchCUWkPJ054Godq4Qb+amwhR6XKxcub5nNH2y5S8BbG5VTD8KAGg73zjpo5hXRy7QKhjeCrGSDPEpygN351ewbp8okHnOPGdRGYjMyLXKOzCsWVfaQD5QpHM2hT8tVLk0iZz1ASpjKfg1wPFey83d8MRPGdvv32DHcjUt6w8Pm6TmC/uG3/dbDwpPllB0kbuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(15650500001)(6506007)(31686004)(8936002)(2906002)(53546011)(55236004)(36756003)(107886003)(6666004)(5660300002)(2616005)(83380400001)(6512007)(186003)(110136005)(316002)(508600001)(66476007)(921005)(6486002)(966005)(8676002)(4326008)(38100700002)(66556008)(66946007)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0xvaDFtRGZNZ1lFRmtPci9YeTBCelRCQmJ3TE9VamQwZmpFeG9PbkJrRERE?=
 =?utf-8?B?N1orNUdrV2VsYWtBcEZXNHF4VFpuRDZCUWlBekNkU2hDQTZsVmg5ajJXVmxR?=
 =?utf-8?B?ZFZqeTFTb0ltdmkyWFFLN0FwQWI2Nll2K1IwWk9zTnhaUWM2WkhrQWdNd0Za?=
 =?utf-8?B?VWdzWlE0dndkZlFsei9Kek42RXdSbnZ5UWRVZlRPUEt3YkErUkkwWTFuNTRy?=
 =?utf-8?B?QW0raExad0NOT2F5R1N6TXhDSkJDd1ViOCs0Zjd6YllzMW8yRHJia3Q5cTdT?=
 =?utf-8?B?TmFCbDlYWkJGL1dYQndvZm96bG1HRzJwM3Q3bG9ubmVDTTdJVTYydkVlcjA0?=
 =?utf-8?B?dktENjZ2SWF4QjRjRDVXWml3dHFEUlhlL0l6d2ZPdHJpL2paK1BsWlErWTFu?=
 =?utf-8?B?eDd5TWlwMyswSVVQMTZBcEYwNTBMMEh0cXAzOUwzNU50ekJ1QkpMVEFSa3hM?=
 =?utf-8?B?Nk1QMWszSzhwTHYxc1ZXTlMwS2NhSElvVzBEam1reHRBZ2N5TzRhVkNBZHdq?=
 =?utf-8?B?QzIxRUZ1QllST3ZEdVVSbExMU0tzSFI1YTdyQjhZODJ6YVhYTXpvM2xEY3Zn?=
 =?utf-8?B?UHBISTV1Ny9HcCsxb2R6NHpFN1BRa2trL1lRRXdDWC9pQlQxcUVqaitremRl?=
 =?utf-8?B?NGpFYjloWUxPSDZtVk5tNi91Z0JwUEcvN0Rad0FuaTZHVW9HVWZWUyt5RG4y?=
 =?utf-8?B?TFIzOHFwY3RvbXR2Yy81U0VJcWZaeHdiajdhaGkrZzMzM1VXVVFQWDJReHNY?=
 =?utf-8?B?MDdoL1BkYldPVEZURzNFNFJxMmIwUFY1UDBJQm04N3pCaWZBWFpNaHdEMVZ5?=
 =?utf-8?B?YXU5TkpkSU9XSVlSbEpLNGN5ckxtTndtVnZuWjNNbDFjOG5UVVlGUytlenYx?=
 =?utf-8?B?Wko1Ly9SRUlEUjBoL1B6LzN4T2s2WTh2NHIwdGg3UzgrcHRIbTdZNmEwUE5P?=
 =?utf-8?B?TTVBTzNJOUFWTk85NkN6aWFLNkJZR0lhTHl2YThWem5MMUNkamxnR1pFekN6?=
 =?utf-8?B?eG5YVFhSazRrNGhKYTJ4eThGcEJ5R2oxZmJPdnRnYmtQaXFocUcxK1hSZHl3?=
 =?utf-8?B?WGc5WUxXOWxhbko1TDNXSnRIWVdUL0t3NFl5MDZmeFoweWZ1Q3RLVEdML2Fx?=
 =?utf-8?B?bjBLN1pXWHVCY1dmeGgrQ0lFVERSRW9SM0xHQVRJVnJmYVhLR2tZN0pySTA5?=
 =?utf-8?B?SEdxSXZ5a2NmWDRCN2c0dGlKVUovSTVtTmptRVlWTGcyUFdVenZ6TGNEOVhF?=
 =?utf-8?B?ODJrcnIvZWc0VGtDN3Q5TzNEVlV2eXljQUExUDVSc2hsYXlaZXloa2hFNm1J?=
 =?utf-8?B?N0IvRldLb2hUdFVtcTZhdk9CZ3NieERVSWhjSnBHaHZwdlBkUFVyS0VxWVNO?=
 =?utf-8?B?amhHbE9nVEI0cUw0SDlxeU03eFdEZ0Z2Y1E5UmZkWUZxdEQ1L1RHcThTY0po?=
 =?utf-8?B?VWM1Q3hvZlpwbXAwd0VuREFCZHZKRFVmNytFQU5YSWcvcTAzNzlLZ3BxSzdG?=
 =?utf-8?B?TzZKVUdOY2dsR2Z1dUNlcXdDai8vcThYYmxMUlRQbzdKcXg4WEFqYXM5bENm?=
 =?utf-8?B?WCtvV2lFQTVQOUg3Z1pNTjZORnMwNlpMc3V3WEI5Vkx6WWIzZDNVVXM5UjhB?=
 =?utf-8?B?ZUd0N2VhUWxLZTgwSUg5bjFGNFQwNy9rc1k3T2hydUMramF4OTNpV09nSnYy?=
 =?utf-8?B?ckkyR0NMWDdCZDNNWkdXZHkzWDRXcklyaFBkNGZkQzU3YkJZWHZ1V2NSSHBj?=
 =?utf-8?B?K01VY2N0K2dDcGdLYzk4VTJpVkJPUjZKM1VRUy81ZEhBV2tJZE9aQlNvSEpk?=
 =?utf-8?B?RFRDTFFFd0lPUXc0dFc5K2FnMHVMbm01YlFXNG1KcjNKcENRd2FCOU5Yc1FO?=
 =?utf-8?B?NUo0ZTlxVUtNOWhqNWtQaTkzN2N5YmhySWpVTVY3b2VHd0J1Wng2SlpXN2NP?=
 =?utf-8?B?TnZOTFYxRlU1ckZOWEZtd1Z1K3JkbWlLUkY4WDc3R2lOdlFRSlYzK0JqR09W?=
 =?utf-8?B?WWF1alo0czJEejlxYTBmRDYwNlFhbWVoRzFjYzlGb0JqTHpwR1B6TTF1K1ps?=
 =?utf-8?B?ZTc0LzN4by9yeHEvakxRN2tXQ3RLZ0l6ZVdJcDB1ODQ0YmF1Vmx3bmtGUUg4?=
 =?utf-8?B?b1FOZGxMRG16SWViYWhBaWhVeldGSFowa21MVlpsV3I5eDdXaTRLQ2hMOWcv?=
 =?utf-8?B?QXJ3UFp4NElqR0dsdTRLUUY5NFdIQzlhYU1JOEFVZWNMTjFvczdxOFlTbDIv?=
 =?utf-8?B?SSs1Z0JpWXQ0VUQvTnBlakRoWXRXbW9zWEYzR2srZ0J3Qk9ERkcyS1VXSFJS?=
 =?utf-8?B?S3NVc21EMjBrWjZIYXRoeDBZWnhSUTN2endlVUREOHBKYzFWclAydz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a9cc3c-e6f2-4c13-644b-08da1c3a7ef1
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 04:11:19.3994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZXsSn8DgYfv7rgMtkJw9hBoKEQGZMSU8NY1uxKqm6IDmRczxPeUEL3xkEiApxtJ9zAtz2rHBJvFAUXlQuSGnIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3234
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



On 4/12/2022 3:58 AM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 4/11/22 18:41, Ashish Mhetre wrote:
>>
>>
>> On 4/11/2022 8:59 PM, Dmitry Osipenko wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 4/11/22 18:02, Ashish Mhetre wrote:
>>>>
>>>>
>>>> On 4/10/2022 7:51 PM, Dmitry Osipenko wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> 06.04.2022 08:24, Ashish Mhetre пишет:
>>>>>>             memory-controller@2c00000 {
>>>>>>                 compatible = "nvidia,tegra186-mc";
>>>>>> -            reg = <0x0 0x02c00000 0x0 0xb0000>;
>>>>>> +            reg = <0x0 0x02c00000 0x0 0x10000>,    /* MC-SID */
>>>>>> +                  <0x0 0x02c10000 0x0 0x10000>,    /* Broadcast
>>>>>> channel */
>>>>>> +                  <0x0 0x02c20000 0x0 0x10000>,    /* MC0 */
>>>>>> +                  <0x0 0x02c30000 0x0 0x10000>,    /* MC1 */
>>>>>> +                  <0x0 0x02c40000 0x0 0x10000>,    /* MC2 */
>>>>>> +                  <0x0 0x02c50000 0x0 0x10000>;    /* MC3 */
>>>>>> +            reg-names = "mc-sid", "mc-broadcast", "mc0", "mc1",
>>>>>> "mc2", "mc3";
>>>>>
>>>>> The "mc-" prefix feels redundant to me, I'd name the regs like this:
>>>>>
>>>>>      "sid", "broadcast", "ch0", "ch1", "ch2", "ch3"
>>>>>
>>>>>
>>>>> You should also add validation of the regs/reg-names to the yaml based
>>>>> on SoC version. I.e. it's not enough to only bump the maxItems.
>>>>
>>>> Okay, I will add validation of reg-names as following:
>>>>
>>>>     reg-names:
>>>>       minItems: 0
>>>>       maxItems: 6
>>>>       items:
>>>>         - const: sid
>>>>         - const: broadcast
>>>>         - const: ch0
>>>>         - const: ch1
>>>>         - const: ch2
>>>>         - const: ch3
>>>>
>>>>
>>>> We will have to keep minItems to 0 in order to make it compatible with
>>>> old DT, right?
>>>
>>> Bindings are about the latest DTs. In general older dtbs must be updated
>>> and you must get error from the schema checker for older DTs. It's only
>>> drivers that should care about older dtbs.
>>
>> On v5 Krzysztof mentioned that old DTS will start failing with new
>> bindings https://lkml.org/lkml/2022/3/22/907.
>> So I just wanted to confirm whether it's fine if updated bindings
>> start to fail with old DTS?
> 
> Since the older DT was incorrect, it's fine that the DT check will fail
> for it.

Thanks for confirming Dmitry. I will incorporate all comments and send
v7.
