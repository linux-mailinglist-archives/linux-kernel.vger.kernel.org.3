Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988184B2DED
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 20:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352952AbiBKTnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 14:43:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbiBKTnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 14:43:16 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DB113A
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 11:43:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJNKANTKaw+w++Z+LlAwA5MjPYAfvKMuJbconRvoy3NFi3AY+DfzJXUJmHXbyi3qP9wkfHgj1T4sZl/UN3zsbiu8BkmSg7ZQDsfBR2yBV9r+tD6KCNtGzQJzDx0ec5dHOy0nw2I+Yr+T3ex8pHEsPUpIUieD7g6x72/HFmIqebygO7Sojb1B6TCCiPvxNBS4tuxoA2xzK8NCNrNTFAfgr8Hu1CV9EjAzxy6n6nUEEl51xEY+TZUNxlOQVG+CzCQYUvzObcEywBFSRKo/WZesJ3IYJWkXZ0pgt7gC7CyWJ4QTw7SWBug/jwIa7b1kkLUDkAvpskDxTD/OtONtcYzQ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3VBpBKneRVKwCK7tGYYfjdL5Ho30whqZ+RFeK1incI=;
 b=W9YIOn462Vit+XlYqbGMsNb/4lulL9FsTL/7JA/p0hGNa1fJe45ImlS6Pk+JuNRU2odanjeKdpOdLepVc0I43WQIReknUA41RdOIn561X6AQriyHYNaHOen8cZKMlirSto2grNtQmV0KfHUSkAIyKn8f/msgpjeOiAeNMJclwe4rND5Y78eoiCGr+ZjgLA1iKVINTRDovP0moWnn5N0WBb6Q0xDumNFexVpyBPzCu9VeRtZzMpV5Qqk6K5e9T3IQtfY/UfFGHzAvcR1H56OYpCaWnz/k0lBdM57ERC5b5LcjHa33oM8rMaRnznscaGJQxL1pQQKWJ9F+dCusNLw0OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3VBpBKneRVKwCK7tGYYfjdL5Ho30whqZ+RFeK1incI=;
 b=fb+3cXRLytFkLrtZrvv7tPILUblVYvkBIc4LDVCTv/70wXgaChagz2tKYw8xY5HItvCoF/i8+J0emscLPWEqHLwAbourrvT1HwpBsV5It4uWIdY0//pHHgdojyKBSGE1adTtLpmt76BNBCkjh/Hf2/DductpbG8yk3m47aGJI2Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by MN2PR12MB3455.namprd12.prod.outlook.com (2603:10b6:208:d0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Fri, 11 Feb
 2022 19:43:12 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f%4]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 19:43:12 +0000
Message-ID: <45d57d25-8fb3-fced-57f4-68680eb451e3@amd.com>
Date:   Fri, 11 Feb 2022 13:43:09 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 2/2] x86/cpu: clear SME/SEV/SEV_ES features when not in
 use
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>, hughsient@gmail.com,
        Martin Fernandez <martin.fernandez@eclypsium.com>,
        linux-kernel@vger.kernel.org
References: <20220211053652.64655-1-mario.limonciello@amd.com>
 <20220211053652.64655-2-mario.limonciello@amd.com> <YgYe1V0ViPYoB0az@zn.tnic>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <YgYe1V0ViPYoB0az@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0106.namprd03.prod.outlook.com
 (2603:10b6:208:32a::21) To BL1PR12MB5157.namprd12.prod.outlook.com
 (2603:10b6:208:308::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40baae59-0c9a-4985-97d3-08d9ed96bcfe
X-MS-TrafficTypeDiagnostic: MN2PR12MB3455:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3455897B67D4A5447D623CD7E2309@MN2PR12MB3455.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xr6FUkZe3023fIfbqIbBlaOxJ+EG18cfrIpKZ5YD2qh0DMAfkCV9mvnTzs93mtmvmakkaPLeudNI7wKDF9T2YpTWrMjO070tLUmJX1PrUMMlPN8vD8g4Z0t6A99sywB7ZtiUx/aFuxx0gNX9NfMIqTJaWkE3L/hCpm+Ue6nTVf3xI4MSzaI2yCSw4wAST/OoFZX01Ra87LsHe7XKzGu2zPoLA2JtT8UxQFGmXZas0Yb2MLtGLE8gUvPYjnXPfjdh5NthNXMuunqmgXBiR99sOWqzRyG2XYlrKpYnvzvFpMYjDkdlnE6KViHdYy5nkmzET1axlqpYMoXneVbEZCSBDzkiKF1S2oSok5W+eJhumjmKi2JciQaDhKd0nVHJ7VJhYRNHVk/8FEWOn6Iek5Mk60mQQ19/XaUgyqfazDTJudjGl5WlHYpauVw4Vd1qdwgT3Z49YPn3/MEKvlF05Kl2ltfB/jVmR1tMlMieAuv+eP/Qc9+2hN+jJkUahy7F/7Dg9bLqhUcK3wUiterphOmYbzOj34qzt9R4qSIjpV0hMMULQMTecDos6zyNtbqGEGh6dH5hlThMf/1QoM7dEIAZ0WpPxJ9KIGR4pPFgmhujFyiQNraFbMCetqMk0shcfm3lyffdirKudqWp1GfFPbz80nCIQiPMYr0K6bD3bYEQai6FRGlM1CV2q9VHJbRY4JyfzuyGZNZ21avsDfKYPwcwCdPtbDf+ILDQQSHYMXBFKFk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31686004)(6512007)(66946007)(316002)(2906002)(26005)(186003)(54906003)(38100700002)(6916009)(8676002)(86362001)(5660300002)(31696002)(66556008)(508600001)(6486002)(6506007)(4326008)(83380400001)(2616005)(8936002)(66476007)(6666004)(36756003)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2NxWWNaWDN5a0dHb2ZlbzJZdUtSTlZDY2I3dFhXUnJTZDdsRmYzSjBQRVVU?=
 =?utf-8?B?RjlZNEMyNDlScUZMZ2ZPTEU2RTZlVGdDaFl3cjk3enU0bGVXakdCQlFiQkZB?=
 =?utf-8?B?UEJOZ0pMRG90VEs3WDlNOTY3UWh0TXZGVkFlUlZQdHduU3lVZjZxTE81ZEZD?=
 =?utf-8?B?bE0rMmtJUk9SeHZyNC9TaTIySVg1VmMyd2hNd0h2Q2cxYWNVdkQ4UDk2UzRU?=
 =?utf-8?B?RDdjejhYNEMvaDhDV3AzTnVicDNPaFR0dGIyUTVEQlRXcG85NWlmVFRJSVFk?=
 =?utf-8?B?SEhFOTQ3UDhQRVZsZjNxTmsrVVk2cGh0dmpXTGpBRi9FZXpYRmhNcCtudTFy?=
 =?utf-8?B?bXliL1BGQzRqTUtoTTlPM2VFQnJzbFM5UGtza3F5TkNQVm9RdG05QSs4alE4?=
 =?utf-8?B?UUs3REE0UkN2RlBWUDB6WHpVcDBmNE81MmN2NS9qeVg3OExvaTJxQWNyK0tv?=
 =?utf-8?B?d3pJeFFTSXV2RVNsbjh2ZlVkTGNmeWJDMXovTUVqMitUdXluV2VXemR3OThS?=
 =?utf-8?B?TkUwUXNKZ3lPTW5TYVFBb0RkOXVJYkIxZ2ZLWkg4K3kwT1BiQlBsVGRUMURn?=
 =?utf-8?B?aCsxRHk3WDdCRXNmWklWNndOdXBSZjFsV2RwK25jSnBMRHYrL29rOFpKUHZu?=
 =?utf-8?B?eS9lMUdoMFVTYk9VZWFTcUpTT3FQWTk0Z24zR1BDdWwyZzNRYjcyTGFrYzhK?=
 =?utf-8?B?NWZBVnhNWWZyY3FzTWVITkFLTVRaRUxpLzV3TGtBYXBhQjlyV0dkRXZqbUFv?=
 =?utf-8?B?SDIva3lISittSzgxSVJ4VWhQdnhHMDNzRXoyRkZpZk9OVTB5dm5CdHFGbTFu?=
 =?utf-8?B?K1pMMHlmMWtOS0xRRFZGTm5EMHMvN25DanlJZjJ3Qk8vSG9Pd3dxVHhTTHpU?=
 =?utf-8?B?MElKTlZYRTdtOStDRGhSZUZnVHJrUStWeE4rdGQ1YzVYTTJEMDBmUXhwMjhK?=
 =?utf-8?B?NUhvYnRJckxRVnlVYnpLUU92MHBYdXVIZlNQd1M0NGhUa0RsNndhbzRxSUZL?=
 =?utf-8?B?MEV4c1BvdjNUNEhUaGhwSXlrdEI3eVJsejlWenQ0cU9ZbHFyeTVKdFYydVlp?=
 =?utf-8?B?d3pnUmFYS3RuZ05PQWU5MGdBSUdlUTdYcFNna0ZLMEpIQkpwOG50ZG1oRGRU?=
 =?utf-8?B?Q3prUHM2UFJrbXVybW56QS9WZklnanBiTjQ1bHBNbDd6TTcwRG1KTXBGTTJZ?=
 =?utf-8?B?Z3E5am42djFPUFhrZ3RrZVBMSUJaVHBXdGZOVUlvYnFRYXdKQ0NpS2RZNGRE?=
 =?utf-8?B?OFgxTVdRMFhRZVFlTTU2OG9KWHBqeHpqclZXNkZ1Rjc1VXROSGNudTFFa2hX?=
 =?utf-8?B?RjR5LzZkQnFtaVdFbVJZQ2lwRTNNemhFQXIxbzY3TWpNeXB6WTErclcybSs1?=
 =?utf-8?B?NzM3N09Pckgyd1pFNjNGazdKZVRIUXFLL0RUL3dGMkZGNFJLWnV3RjdpR0Va?=
 =?utf-8?B?UFJMWitZOVdKOS9nMlpyT2xrTElkRDN6ektoSGdrZW5PZ2ljQ21Cc1JQdncw?=
 =?utf-8?B?eFZrZng4dkF3TUJ2OTI3V0E3RW9qYWhrWlJOWHJtSzVqTTJEU0t3MlY5dms0?=
 =?utf-8?B?NkdrZ1JMNXJVT1hPQkZFV0QxbDFBeGZ2L0JFUWg4dnF1YzR0dzBNeklsU21i?=
 =?utf-8?B?Vm9XNnVBR2h6eEhIaDFjV1B4NWtUNS93b001bWtBNnF0MGJpKysvYU1WYlJL?=
 =?utf-8?B?SnJOcHh5TEcvK1pOY05FNEIwVldaTVBUNnVyL0FLNW1jNmcwQS85OExoNzl2?=
 =?utf-8?B?WWozMXg4N2grK1dlWTBoSlB4blZiYUgvWUl1TXY0Kzl3dHVUbkVGVWRFYU11?=
 =?utf-8?B?b0FYcTdlVUV2MVVITHRvYUlmUmVmT0FLVnVZUDNDeFR3WHY2RVNyVTNlaWxq?=
 =?utf-8?B?NE9HSUJEOWJKZ0hXSGJoQVVpTnVMblFUUERkQmwyaWFrSnpNeEI2UVZYRHlY?=
 =?utf-8?B?ZVlGMDFBTFBZRlpKWmZSQk5hK0lkcHEreG9RSWNmWm0zS202a2llSE1BeWRU?=
 =?utf-8?B?NDE0bi80QTR0Y3lpYW9KQW9tTmNCYzB0LzJBUEFUdTY5SS9jUldodTNVUWpT?=
 =?utf-8?B?Qno4Vy9kM0NJMDEzMFBsNCsxWGMxcUtVWGdNcTRxdkdVWUlDTFh0aXpXMjdv?=
 =?utf-8?B?bUJDLzN0YzlqNVRoQWc5NDVCNnJ1S1BGdTdGa2RnckFpZWxVb2RCWjhWa1BB?=
 =?utf-8?Q?syTcKa4z8h7H0/mB3AUJ//s=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40baae59-0c9a-4985-97d3-08d9ed96bcfe
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 19:43:12.3345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wsEWxI2oN6FUToLIhEEeeSzEH8zclOXTeYepXVdulQsAfsKAwZFBidyeuASa3NED6qkM0u0wKRlyvqaTcE3Pxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3455
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/2022 02:31, Borislav Petkov wrote:
> On Thu, Feb 10, 2022 at 11:36:52PM -0600, Mario Limonciello wrote:
>> Currently SME/SEV/SEV_ES features are reflective of whether the CPU
>> supports the features but not whether they have been activated by the
>> kernel.
>>
>> Change this around to clear the features if the kernel is not using
>> them so userspace can determine if they are available and in use
>> from `/proc/cpuinfo`.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   arch/x86/kernel/cpu/amd.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
>> index 4edb6f0f628c..4a7d4801fa0b 100644
>> --- a/arch/x86/kernel/cpu/amd.c
>> +++ b/arch/x86/kernel/cpu/amd.c
>> @@ -611,12 +611,20 @@ static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
>>   		if (!(msr & MSR_K7_HWCR_SMMLOCK))
>>   			goto clear_sev;
>>   
>> +		if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT))
>> +			goto clear_all;
>> +		if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
>> +			goto clear_sev;
>> +		if (!cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
>> +			goto clear_sev_es;
> 
> The cc_platform stuff is to be used in generic code - I think you can
> safely read MSR_AMD64_SEV here and look at the bits, just like the rest
> of this code does.

Yeah I was just looking to avoid the code duplication in multiple parts 
of the kernel.  If it's preferable to just duplicate the logic that 
cc_platform_has here for the AMD platform, I'll do that instead.

> 
> Also, why is this a separate patch? I.e., one single patch should be
> just fine.

Very well, will squash them.

