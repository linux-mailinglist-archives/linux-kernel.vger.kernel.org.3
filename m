Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39305500575
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 07:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239902AbiDNFem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 01:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239924AbiDNFee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 01:34:34 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D601750045;
        Wed, 13 Apr 2022 22:32:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CeNQoSfb4zXePDdPgJjraIDjy2+oM5/7FJfWNc69B/J8BM3KXzICON0aJ1V5hnQ97MMy9wtoP5Kf75U1JRgdD5Z1Sc3kPbSmfKT7vjRZbBHMc8SYk/dl8HTZ89RTR3T+o+d9/gSfFulXwLiZIUWLPPGcbbp+yP9XTLW11CpzLWYDhALfRmpQMtBJc12iI7PmOO0TuEmlkjynUazfSPs0SrYuNbVeb3y7qoDrdCcmf8RTTCpgMCSwvYgKt9f+B4jW5U3OJkkGLbpSqSI2xUs/jK+BhDBU48zOG9DbzaRkmhE0umtFX6rwtP2b3xS0BRY3Db3puysDeBy0tSHOF3+vXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mqif92MfYTlPvptzYuSDkSBYxU4sVQFrR7Zlx0PHHvI=;
 b=OkUXqJjyO1oSSO5l8E2+k3HLFP+5rZNc8HT313zvitanreFfb2vf0odTGYpZKipT+GxpHqh03DBQ5EGxUfwqdyJytT15TKhNSItF6nyDUBCbqBiZdn/0ZH10CeMFf3X6hd8N7nyBLxHgtdNsS/gDYzZLc9JknTv252V9qZgV6Aon7SkvVazEY6X6b/u7j1KWNJGo7DcN7FNk+I/3z/RASWwzAlCqdpguNDWzbN/RxZcHPzhAI5C3lw8qBzIC64RdN5tMoScBW7XvPRiDUQDsE91GCQsl2nf7bagqnHeti99pCmanD3tlOYhHvKEcQNzHAeBiQhKXQpxEUijsiIRkTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mqif92MfYTlPvptzYuSDkSBYxU4sVQFrR7Zlx0PHHvI=;
 b=eNMsAdwi637zrs4s5PUFXOJ+QNDQbLDYqG+HswdcGrmybhija4+ZJzRVyqxdOUp6coWz1bmVlU7sSx/8hwlH0DlpaWAa2/LeFHP2Y/GL3BeMdmTe92FhXknuzOvwOr6xTUszVltLqCX/64yvpUCCPlyiTfrPkQgLkrPHdaLKpM5KmtsDejZrWsMri2Wc1KWHLz97aaGZDBf4uTjXRBl1uIVcNVm2hPTdMAds0E5NzTXuH0qlGi85qlc+cH6QdqRNi+1FAzZ5tJfMSFG3YhV/8A/dEH1WJVmTUIbCnZgl7/t7n+aiLGlw9KHHSH3v3f7bk00aJoJcqost6FFEDc5I1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by CH2PR12MB4646.namprd12.prod.outlook.com (2603:10b6:610:11::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 05:32:00 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef%4]) with mapi id 15.20.5144.030; Thu, 14 Apr 2022
 05:32:00 +0000
Message-ID: <534dbd19-b43b-63e6-69e0-3441dd224ef0@nvidia.com>
Date:   Thu, 14 Apr 2022 11:01:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [Patch v7 2/4] memory: tegra: Add MC error logging on tegra186
 onward
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>, digetx@gmail.com,
        krzysztof.kozlowski@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220413094012.13589-1-amhetre@nvidia.com>
 <20220413094012.13589-3-amhetre@nvidia.com>
 <eeb513c9-f010-c45b-bca6-a10c96691147@collabora.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <eeb513c9-f010-c45b-bca6-a10c96691147@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0117.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:1::33) To SA0PR12MB4349.namprd12.prod.outlook.com
 (2603:10b6:806:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09022302-0a69-436d-5ff0-08da1dd8190c
X-MS-TrafficTypeDiagnostic: CH2PR12MB4646:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB464665D65275D0A21727DFDACAEF9@CH2PR12MB4646.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2anA9ldN0z5IDCOfTWtQ+aVDKhUkCEQqLex6q2RntDUPg0Cv0yqPhfOm+NEJkH3g14jE4ZUGgehxnmE571kpRmfVnsV+mdiEGyS9BA7CsQln0aqy6rNwzsjDKgmwF7gnM1tClrx3OidZfbOPzl7MuWLuUVSfsjOBBkBK6j9kSqCMlptk/EV/u4+6mly/8WdyFJ33CUiVsEbaM7AoWXjxY38E/SWTsVhpvV1rn2bj4wSJIvwcUsUQLxI5KMwxpvx/kQhaJj9km3LXhVFydsT/vhU4Vh1eV06bjUZ12k+auvxgBWixfNQGGricpZ/gHTvm7Ry4lw3Rb7sTiHjLlpeJGT4UeMAR8t7rRDUPITvDcKYWtoqbzEgO+rEj1QqltbXMGJAvmjW6Vhbw3D/e8ErledHcJJdVCLec10h76Us4GzoGsgisP7Ff384IoOfQY+4AwNlkkfXTBfWmJuiZRClW0l0OItGQo3Z9B2YRyAhEATYjGq1dfPXWe9xWVyaYL6doopyPBPY33HuOmEr4iCUts/qKpPNqfYUIBIy1YgZae92Qq2uPLUPkaaqeFams5h4RYPJ/6wX5EMhBtycUG2wk381R4p9bV7NRehRqu+0fo4oyxPuZZoXyP6ktKZnkjK5A4Ue9/HcIic8/hhmJdw+h2fnbIH72FnM0BHVn+7ZHzXZOCQTe+awIULngSHbnEiEAgvPofarFD3Bu2A6hCfhK07O7Jut908kb9s3KiC1ET/7GzragF6WGWC9nIZqZBn+dUh9B9Z7SJJqi+d3hPGClpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(921005)(86362001)(38100700002)(5660300002)(31686004)(53546011)(6486002)(66556008)(66476007)(31696002)(6666004)(2906002)(8936002)(6506007)(55236004)(508600001)(26005)(186003)(107886003)(316002)(8676002)(4326008)(6512007)(66946007)(2616005)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1NjSnlDQnYrUWRRVzRRZ3YxcXlieFVqOWtKZC9XQ1VyRjZIMDJBMVozLzVE?=
 =?utf-8?B?QlQ1d0x3cHBHZCtqV0RtNkpTaVc1RUFoMWlqdFkwd096U203MmpHaGxxcGdD?=
 =?utf-8?B?ZWJrZkFxSVZMWUdTVkttaS8ycWowSjJsbXlKa29Sb0NSNHVDSkI1QVF4TFNW?=
 =?utf-8?B?Zk1acmdhZU5iNjJoTFY2QWhoODBuRWJGbWlnRXYzNjB3TVAyeGp0N09kNmpx?=
 =?utf-8?B?SjZ3WWNGUkRHRVNqdjJrTnZQSk9JSDNyN3JzVWxYZGNNaStWejRmbDljZGFP?=
 =?utf-8?B?RytiT2JJYTNUN3JUUkZyL1J1THJFTFpKV3RqNHRjbjFQZnFKN0loUm1iT2Jm?=
 =?utf-8?B?a3J1ZWJLQ1JXdEUrd3RPSXF0SVdDd1ZLeGhQdmQrMnNJaENsUnN1M0tnYmdp?=
 =?utf-8?B?ZU5CYXgvYU9zZWY3T3BsbE9CNlYwSWZheTJIdVZXa1Q2Q2g0R1I3a3dUdUFu?=
 =?utf-8?B?dWdHdjladE5iMVo1aWZWTndzTUt2d1cxeTRFUUphLzFwSFp5ZkoydkpqRzdr?=
 =?utf-8?B?Ym14STZWUjRLQTE4LzNPZDByczFFQlFsVlRNaFZmWHBuWnVMdThPamk3cFgv?=
 =?utf-8?B?V1BXY2ZoQi8rNW5veTNvNjJCV0M1V2RJSTMwb0tLbWtGZUN6Y2RTTVMza21V?=
 =?utf-8?B?OGQ2QkpDYTk5ZmdEdUdHK3AzSmx2aGF0dmxKM3dOcnVRRHFSYUlXSnVmZm9D?=
 =?utf-8?B?L1VjQUpQYnRCSGpPSG56UE9tV0FJSnNoN0pRQVNTMzdKT28ybmdwK3Q3SGpU?=
 =?utf-8?B?UWFGMU9UY3pFQ2ZuYjVsMWNpc243a3RDVlQvQ0FiUytoRkVNSng4YmxRb0ZT?=
 =?utf-8?B?eVZXUitOb2hLc1QrUkwxb2J0OCtVMHd4bitpczNHMnZTTjlwMjJHQ1QzM05v?=
 =?utf-8?B?UTRZRXhlbG5lZFlvdiswd3BhdERVV0tFMU02Uy9mWTJNQ2N3Mm4zQmpoU1da?=
 =?utf-8?B?elNhMDZsZzMxWk1tREtQN3lpb2Zkc2s1TnNYVkU3U2Mvd1dMQWxuUnVkSkd6?=
 =?utf-8?B?WHFHNVMwZTVNK2NuSFBUMEt0V0ZRTGRiYWZ2cGIxWUxGVkFHVG5HclJaR1M1?=
 =?utf-8?B?TkIvVEoraFZMYnJXTFJaL3J2cmtVNHhFUlJENFhkVlU2QTRzNDE4Nm13TGJ5?=
 =?utf-8?B?YmhKdDlyeVdOR0o1SURXckJJMW8xNXBadnVGMWMvN2Zhb25GNzJ0TDlxb0N6?=
 =?utf-8?B?aU96eGVsM3JoaUpWYStOWFlWZ0hVWTc2Y1gzTmNyZ0RqalNwU0FPR0M0a1J1?=
 =?utf-8?B?RVI2amFKMVR1ajhicm4vdXVkQWFBSFM0c25EeUx3aFNsdVNxSEV6ZzJZb0tu?=
 =?utf-8?B?TysxRXhXLzIvTERTMkxWSW1mbWhzVXRUa254OGYza1NOK3Qrb1Q3UFh3ZVVD?=
 =?utf-8?B?RTFiL2xYdVhyYjEwQm5MZEFlNFFFOTIrejFuZTVaTE4zck5SSTAzekpzNm93?=
 =?utf-8?B?MFNRT1ZNWGJPL0g2Rk5LaGJ5alZvOTBJRmU0alZITTBFV1FHZldoU2FoOTdh?=
 =?utf-8?B?QjE5U1pJRkhqUkxETHVERlFpbTg0MnpXNHFWNzNBTjJQTGxXendaWFR0VWwy?=
 =?utf-8?B?aXJCRm1WWVVxVE11R3VadFdYYmxPTTk2M1pGdEFDbFF6QWhNTHFUZmYyaUFv?=
 =?utf-8?B?Qzh5S3FkMUdXZnN6VXFER0ZIZmdLZXRtNm5wRk9ZdVlHem1XM0V6SW5leVY2?=
 =?utf-8?B?SXlaT25sRExLNHdSMjgrbExUZkJrWDVOc3ZwYnZMcEc2QkRIR1dUWE12M20r?=
 =?utf-8?B?WlBLSWJ5dGx5RUNwcmxOWldnbEN1d1lSOUhPa1ZveXMvS2VlbWJOMm9FbFBq?=
 =?utf-8?B?ME5Tb28vVUJWSHhhc2M2dHdxVkZYb25zZS9oRUk5WEQzcENpUDlpL1EzZG1X?=
 =?utf-8?B?V2dNVVlJMXoxSHVLN2ZwL1k2a0F3MFJFQi9KV3RZZUJyckJoZFFtM0pDekMw?=
 =?utf-8?B?K3ptZHh2MEFFUmhkQ09nd2RGSDlkVWFIRUJxeEs1dVZ4Nm1RK0RnMTRtTTJj?=
 =?utf-8?B?cXM5K3FXYUpHUm95R21GTjZIRVJzekdpRnNicXdVcEFJSkNhMnRLRUhCK3BG?=
 =?utf-8?B?Sm1YeVJlTUtSWHhqMy8rSExRMUhSdmJGajVsSHNIVWsxYUc0UG0zRk5kbnYy?=
 =?utf-8?B?cmRXMnhSdHdSNHlOK0hRVGtGK3FqMVdZZXJlS3YrbmxWbWo5TU4rWU5BZFpp?=
 =?utf-8?B?NytkVnZnOUtSTURldmJXMW1vanpzUmdLRVJOSDhEcDhqcTR1ZUFHdjdjc0JR?=
 =?utf-8?B?U3RwNmVHblJycXFQWFQrb055WDVoNDhIbTJrUUNseWhXVjc4cGxVb2orRVpF?=
 =?utf-8?B?NTNCa2YxSUZRUFYxZzJRaVpBYzZKRElNNVNMRjF1RDlGWjZ3dlFxUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09022302-0a69-436d-5ff0-08da1dd8190c
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 05:32:00.0791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6agOgQTox7QqC+dO6Cyw2lLMlVZ5SsPXy8ZAEAmYI8V+Zq382qRSi8CTgMPLDy81wG0hFGPAo5VIPLaacZSFeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4646
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



On 4/14/2022 2:43 AM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 4/13/22 12:40, Ashish Mhetre wrote:
>> +irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
>>   {
>>        struct tegra_mc *mc = data;
>> +     unsigned int bit, channel;
>>        unsigned long status;
>> -     unsigned int bit;
>>
>> -     /* mask all interrupts to avoid flooding */
>> -     status = mc_readl(mc, MC_INTSTATUS) & mc->soc->intmask;
>> +     if (mc->soc->num_channels) {
>> +             u32 global_status;
>> +             int err;
>> +
>> +             global_status = mc_ch_readl(mc, MC_BROADCAST_CHANNEL, MC_GLOBAL_INTSTATUS);
> 
> This will crash if mc->bcast_ch_regs = ERR_PTR(-EINVAL) for older dtbs.

Actually interrupts won't occur till we write MC_INTMASK register from
broadcast channel with appropriate intmask value. I have added check in
tegra_mc_probe() while registering irq which will write MC_INTMASK from
broadcast only when mc->bcast_ch_regs is initialized i.e.
!IS_ERR(mc->bcast_ch_regs).
So interrupt handler won't be triggered at all if
mc->bcast_ch_regs = ERR_PTR(-EINVAL).

