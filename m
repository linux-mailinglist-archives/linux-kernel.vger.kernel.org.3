Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1884EBEDB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 12:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245425AbiC3Kgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 06:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245410AbiC3Kgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 06:36:49 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166652BB19;
        Wed, 30 Mar 2022 03:35:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tjv68QgyoP/dOTlsWQiBoU3oTsDDCFtbOCpxxWLDNNwiP4SLefvaDJT5NxSixnJRCHDkmFJZYuo3eJgqD7chUq6GM8LdYo0KHLCRAWpXC9Pk0b0HZs/XVH4aDg80CB/3D1a5lJVoYUAAdDWt4Nb6n08gajOgUEuSGFlIhgw8d90O5bqTOw4G2XUdSa0bqGLwWv/W1rH6A9br9GbqTHEp6mfMDUXOuTo5PCui3eAE1PsXDL0z3AMm2WJwZJkY3X8WokeKoYT1mQnyAf9725qVpglsCgyDOsWzUZUIW+BJ1bfG2ydg3cmznDMXtdmwt3VPaZNrkTch2iG9GbRRmXbLjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOoH/cBXVtnocJGjbdAKeqS2vG8m7EvFCkuZQ3rMNcE=;
 b=J9uDqSm8feGRE7LYWDI7uhr8YSlPYBw64MR5Xmyj2m82NCv5xa2OfwQS6Y5D7BXWYVQYS5kUL0MX61+fufK/p08t9Eb90bVKN5eKhczRqAOI335RNt95NHozwVKrnWrFMTVy47ijoHIq7aj89dKHPWju8nnfNQNrMHjmdOyhiN9Tz3otKZBl0t306IFOcGGZQkvRF9kzna/vM9WtdZxIW9PhbNviAp25FgNAPqPzmUheSm/BeD+gfJJrGXrp4beE0qkiFlR44b08/BSJTcTHUCcmdAbtwwdRLhE/aHAwwP+5Jbi81rUi+3ESMmZ21ybtknqYoUCY8HHjJp6RngcHYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOoH/cBXVtnocJGjbdAKeqS2vG8m7EvFCkuZQ3rMNcE=;
 b=g9l4CzfZPXnINLUcdJZ2NhszEB1bImAqJezsaxiR3DYNF8tBkBtNrrnQwppAxjteUltP+BbsrWjK2jHfwzduhY54aOnDqrqjI2ade2gdziQqtvkNm1gnRwvXLVv0MKPztftZzy4yYZuTjJkWkh0jnkhmVPxOSy0TyHy5TPq+v1Yx8nk/6BfayN4J+pFRPts2u+9SX622rfLS0Rycg8aCQoU6RhlbnZWk9stKyjUIYyJC5Huwmf3NU67wA2IhlNCwFOeTvUohAcBuxPwTUc5n3jRyf04l/mUz9FNB4Y8EZ6UcHyT3BAGxKi7Wg0namM3aeYsVNc0bhrjHSpInYfKFsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by PH0PR12MB5632.namprd12.prod.outlook.com (2603:10b6:510:14c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Wed, 30 Mar
 2022 10:35:03 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef%3]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 10:35:02 +0000
Message-ID: <204b0b14-6e21-e5a9-4d71-4691ba12097a@nvidia.com>
Date:   Wed, 30 Mar 2022 16:04:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v5 2/4] memory: tegra: Add MC error logging on tegra186
 onward
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, digetx@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220316092525.4554-1-amhetre@nvidia.com>
 <20220316092525.4554-3-amhetre@nvidia.com>
 <04bb5ef2-15c3-d561-3572-76dc803275ef@collabora.com>
 <c5341578-e0a6-4ad7-5b6c-95b31b16faad@nvidia.com>
 <2ba661b5-a59b-89f4-7ad7-5eee4da4ce96@collabora.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <2ba661b5-a59b-89f4-7ad7-5eee4da4ce96@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::17) To SA0PR12MB4349.namprd12.prod.outlook.com
 (2603:10b6:806:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f57ef637-3331-45c2-11f1-08da1238f2a3
X-MS-TrafficTypeDiagnostic: PH0PR12MB5632:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB56328EB138DE6C0B5A4108BDCA1F9@PH0PR12MB5632.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: omXPtOeeFC423Bl9vm2Jp0vAbupazNmmi70JWxVFx8BBW3cFMMdjfxgsGj01CX9LFMSaoXxZHrIUS7e+bfN56mKYm2Bpf0kha7eI0q8ZWTnrUYew5igaJOmw7TGX1Y1ga5xdEfn4CjB7QbmojiSS1o13OseT9wpFfenIo4BzFfDuTtDatM7/n2VGc89KhxIe9KK3XMP9Y866sZA4Ffl/MwjK1k337ZUkKsd2LGNGscODNKvZu4Zvc6GY7JdykPrkBEGOUfTUF3jXg63KI28tXscMzqm4+KzU3pM1jv7XrzuSZd4ZwtRb2bGwSnJNI1ke/+Bt9/TyaAf3eIWP7CT6GPCzZThoKwA53cXUWmPOWaTjYkVYoqT65w4ShrzHsP2DgUJM/dTi2lcIuA1Dk7t9ZYUYIwKOVwaeOAsqM12RVYZlUbmdWp/Iv5eIyl6qGLyWTwg3K6ApNDLySNl5IAm5J2cFHa9tpLPflKxjpY82MSjzPf78SdAIESafBE81+sGjPJVwtiCu83ybSrE8UkcFO4+9+w1wlwmempPlcH3d8SOHair43epM/eyKkBnYEnicr8Si5Z5J5x7TrfsiCG9BrvuuHW6O9kEizLR03luDs913Qdgc7llgUJW5Pxv6U9Gf2BS1T/xqc5NnRnjSMLVVzkaFnKSX1CKMA6DDRbW9SVoR3tXBcruW7MkNLcfZctxs+DulrCb6sT8W3zjlbl08lhy+rIjtCBnda0PuEgCgGeg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55236004)(53546011)(6512007)(8936002)(31686004)(107886003)(6666004)(186003)(36756003)(508600001)(2616005)(8676002)(26005)(6506007)(38100700002)(2906002)(66476007)(66946007)(66556008)(6486002)(4326008)(316002)(5660300002)(86362001)(31696002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjVBNU14WUdlRnl0UXgrbkFjVFN5Vmh3aW9xK1BndXI5R0NEK2Z1QXpxRzFi?=
 =?utf-8?B?UXFKT05FT0dXRDYzOVVhU0FaL2hKK1hWZ1BqVkVtWWgwY21yS3F5dWVhcEN6?=
 =?utf-8?B?Ry93SVE0M2s4WmRvNVNVVXJCM2h0U1ZzQ0RqOVdCMzdNcHB6WHBBMytrekFy?=
 =?utf-8?B?Y0crUzkwK1pSTHZ4TWRaZWw0Rmt4N1k3YkFJRkdYWFVNTThaNFYxL1RzMGk5?=
 =?utf-8?B?Yk9UUk1rczdyZXM2aWNFbDBlcXJBdVpBOHdEN3B3UlNnNGhZSFJGOE5QSDV6?=
 =?utf-8?B?Q1U5MXRiQWxLM1dpMHhINGxwVjNIRm96WkVCdjNoUGpsY2NmTEN4MnJ1b04v?=
 =?utf-8?B?cFZ1WHlKb2tUL1ZBSEluSjRCMGQ4SElCT3plN0hQT2ZGWkJMbzZUVHg0ZTBZ?=
 =?utf-8?B?RUJ5ZFYyZFhBSDYxNXVSMnRzajNvUkdvMURFMkt5THNvNGxFQlBnWTV1R21v?=
 =?utf-8?B?a1BITzVIbFhmdzhPc0tHM0g3NCtocExHTUNYSjdOcVp5MzcvYnRldElNSHJB?=
 =?utf-8?B?RVNkeEhwcGVkU0h5dSt4bExPaE9jNG1BU0NubDNVcFF4TEp3WGcxOEhlU0tt?=
 =?utf-8?B?ZDA4UGFnOVpQT1hoeGlxSWJUQzFrNGdkNUt1T00wUUkzd0xEejNaV2QrWnJD?=
 =?utf-8?B?RTNpVGZyblBNVmhRYU5UNnFjNGprSVhOZm9VbHJUTFZEbVNBT21YRnY3T0Fz?=
 =?utf-8?B?empkQkxHSmdVRFlkL3B0MDVBWStmVi9aZWVtRGFWTFdZK1hDbGJRbnlBZzVp?=
 =?utf-8?B?MFlaMzRWTitjR0NadURWY2tTYmR3NzhGL3kwZ09oU01ta24xalp6TGNDQm05?=
 =?utf-8?B?bG40Y0pzeXdTS1ZCS2RNYXhmQ1FPQ0pROUZ4cFNaNFFlZE9LYitXdFF4VENI?=
 =?utf-8?B?bUJ5L29QM3g5RHpWdDFwdGYrUkxxaGxiMWo4UWs2Si9jVUhjc3dGNlRRdFM3?=
 =?utf-8?B?dW56MUhTamtGTFNwKzZKb0ZTRThpZU51V24wVkowQXVBOHM3ekxrb0ZscWxB?=
 =?utf-8?B?aFpDbVJBMllqVzVibkIzRzFUY25sNGI3MnJoUTFFY29WNVAwdWM3TVo2eEU5?=
 =?utf-8?B?WTZicWZpNGw4SFZoR09MeWxDZlZ6eW9ZTnhLbjRxS2VRTUFXT3BydG5mYnVG?=
 =?utf-8?B?ek9SSmRoN1ZoOGhYQldUVEQ3T2VKTWZsQUxQY1NId1hwY090UFZZaWdVM1NM?=
 =?utf-8?B?ak5DSkNqV1ZoWjEvWXFST003R3MxdW96eHk2cHZNYVltSURRaEhkVUovbWVJ?=
 =?utf-8?B?WEZmMmZuRjRoTHFFL0dKRTN5UFlsLzdoR0Y2ZG94RE41eUlRM1E1akZnM0hm?=
 =?utf-8?B?dGYzZ1R3aTNsYldoVVFNYXpKR2dtaDhhZnd6MDE0R0lrT1pDSnE0d1B0WWF4?=
 =?utf-8?B?QXAyd2N6M1Q4TmRnaDlmSVIvSENUNUorY3FwSlQ5bnk1TzIzTEdSL1d5Mmhw?=
 =?utf-8?B?K1Y1LzlqdEIxeHhYSUJEK0ViNjVNWVh3TGs1Q00rcGNXNTZGRG9wenJkUDNW?=
 =?utf-8?B?OUtzOXdVcktTbEVCL1o4NHVNVDVtRytkZmRXZ3JZUTRLZmp1dGx3NzRvZllx?=
 =?utf-8?B?ZXczNitZZ2ZjQTJjM2l1ampzdHFSVVFDMldEekw4a1pJSlV2OHUybG9pYndO?=
 =?utf-8?B?V3VmR0tGc0NNbGpacHFGSGJoa1BaRjBvWUg4WTFTS1RDekptOG5LTm1KRHdP?=
 =?utf-8?B?eXlld2YzR1cwMWo1TUhnNHJSbUV4ekZ3MTd3bStyNmUyTFNFb1A4aFJZSzZM?=
 =?utf-8?B?ejJqYm5ZVGRtektZQVVMUjdhOXBaRnNhekFOVUpCaTl6RTErQU1JTWZPZW9K?=
 =?utf-8?B?Y2c4YjdUU1BjaVFWZ3pqSVJ4ZWZCbjh3RHRIVGZGRTVtZnRUZXFnQTdCVElx?=
 =?utf-8?B?OXRxczVIMW8wVkdPT09CTDVmVHJpazBmVUZqS0NDbjd6RUZqZFZJVUI4dWE4?=
 =?utf-8?B?ckZ4a0QvamVQZTBndGRYR1Y0V3JkTnVYYURKbDIvdkc1V3hDTjQ0THFRM0s4?=
 =?utf-8?B?NGY0SkVSbjhtVnZ2VHZpWTVWN3JyMERZNzBRUURTZE92Z1NpSFZPQldDNlg5?=
 =?utf-8?B?ek9FM1lXeEQvdzl3ZThqL3VlTlNiaTZlRXNaK050aVNsRzBQS2F5dC9YNnhi?=
 =?utf-8?B?L0JDdlZ4ZU1yTnlzaXl0NGlZTGxJMmdZcFd5dnpWYitDNlIrWHJDN3ZYUnNV?=
 =?utf-8?B?RGcraDZIVHhiMTVjY3RQTURoZDU4ZlhWNmR1cWNET3pqY3N2N29tY1FYK1hk?=
 =?utf-8?B?dkFpdjJ1cWt0c0xuelh0aW9VaFc0YWtVcHRsRHNhNmhwS21CZU5NMTd2cHph?=
 =?utf-8?B?cUpaOU5LWUxXd3A4UEJpaVgra3ZvZXFHeVQxRTlwOVUxVXhkWFlwQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f57ef637-3331-45c2-11f1-08da1238f2a3
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 10:35:02.7882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TyzaqNaQ6YtJUoUP75GrDIUAGVRlKV/B4D/K+KM1UOrC10gSOnnpBzIWMGuHDVktnnnZqdf6lHVoHtL9QvSVhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5632
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



On 3/30/2022 3:49 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 3/30/22 12:03, Ashish Mhetre wrote:
>>
>>
>> On 3/30/2022 5:36 AM, Dmitry Osipenko wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 3/16/22 12:25, Ashish Mhetre wrote:
>>>> Add new function 'get_int_channel' in tegra_mc_soc struture which is
>>>> implemented by tegra SOCs which support multiple MC channels. This
>>>> function returns the channel which should be used to get the information
>>>> of interrupts.
>>>> Remove static from tegra30_mc_handle_irq and use it as interrupt handler
>>>> for MC interrupts on tegra186, tegra194 and tegra234 to log the errors.
>>>> Add error specific MC status and address register bits and use them on
>>>> tegra186, tegra194 and tegra234.
>>>> Add error logging for generalized carveout interrupt on tegra186,
>>>> tegra194
>>>> and tegra234.
>>>> Add error logging for route sanity interrupt on tegra194 an tegra234.
>>>> Add register for higher bits of error address which is available on
>>>> tegra194 and tegra234.
>>>> Add a boolean variable 'has_addr_hi_reg' in tegra_mc_soc struture which
>>>> will be true if soc has register for higher bits of memory controller
>>>> error address. Set it true for tegra194 and tegra234.
>>>>
>>>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>>>
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>>>
>>> Reported what? You should add this tag only if patch addresses reported
>>> problem. This patch doesn't address anything, hence the tag is
>>> inappropriate, you should remove it.
>>
>> Okay, smatch warning was reported on v4 of this patch which is fixed in
>> v5. Then I understand that we don't need to add Reported-by if we fix
>> bug in subsequent versions, right?
> 
> Right, if the report was made to the in-progress patch, then you
> shouldn't add the tag.
> 
> If report was made to the patch that was already merged, then you should
> create a new patch that fixes the reported problem and add the
> reported-by to this patch.

Got it, thanks for the explanation. I'll remove tag from next version.
