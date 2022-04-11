Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE154FB3AF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 08:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244920AbiDKGWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 02:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244879AbiDKGWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 02:22:44 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EA03CFFE;
        Sun, 10 Apr 2022 23:20:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGMUQiDwst/nGEntSV0RdbV1TyBGiK/AvvZyZoy2JIsxCdkGeZrb6FhCk/Jci7xdWETl1o3qwGquBro0vIg9yNRSFn8i+b7RmUwEoVFlBj8Qj6+TWsMkXV3vHxEiYH+plw5XNUDU6gRg9ZK+K/rPAcJsvYjqvj82UY6mERYDqs/5k1ZUAwK56eIqmsu2rTZMXvIJ7ASEbArZxx8fvpK+ap8iKswLl7X7YtCBTpVAWuEP8FOpOCerFBbp+w5ZQsNj6mQliKrCRsc8tv8QApdvgFtv/24LCm6SM32ajCedgSv3WNpjExwGq4WVLM4pLRqcGcq96d356HsKbO8G1vsn9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekQje0vr6x6L3tsTd/meNQjPoBcIcYG5ev20jzUt198=;
 b=g0M7zC3WdcPHiXv2Ms/jAErSI7a4NuZZTaEH5R8Mf2DR+qVgtp4NYP4YYI+GsVucf2ztoa+7sGbRM6kkvbxKoxBEqWgvk49eDlW7bj44ChLjGtqxtY90IoaoXTfHbhRmf5aXTzvMaigDNaMGGPU7jZN954VNk7fFJiCeNCW/YJFL2XflcrgM/SZjroYHNvUUjRmsOn8pCCI6YyXjSiaqz7e8X14WRzN+iVpLYjN3NtMQ9BS8Wn79+RO5WTKkDITu8KjmCC+vYhF5stG3+ohYqMB/QeMviAeZQ38MkAd7FGa9YWN01eDqmog0YOXfi3XN+Le6ycTtpvV+8vaE8g+mGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekQje0vr6x6L3tsTd/meNQjPoBcIcYG5ev20jzUt198=;
 b=t6BCaGLLfKVDjsXMCX2TebxHk0Q0f5M0oQxnWpJlL1LmxFuZD/f0F32kAMxxIrmBsPT0o27ospF+JXhomdgbcX9fXwRm4zXzF0oMXUe5t8mzaEGb6NDsObdMjBE4JeyJNguyeqDXI4thj8uVv+1Y9Doz4lkyPjkSLRmc7xkxvFeUy9ZHp2ubThN8WAP9gCDKOl+QlBAUv2whvLi3hZ5FbPfNfYoYcf73VdCtAZ5VfIvep/Pzbj0Y0ujtyztK2L99RZE5KPFg72i96dt44DUPheH7EvVD5MKHlW+gkWUmb1uHCbrc+SiaH0WrK3N9IMyWwvWngKzT5CgxOO9RohpKyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by BYAPR12MB2872.namprd12.prod.outlook.com (2603:10b6:a03:12e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 06:20:28 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef%4]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 06:20:28 +0000
Message-ID: <eac41cf0-6057-2f52-26fd-50a0fbecd7a8@nvidia.com>
Date:   Mon, 11 Apr 2022 11:50:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v6 1/4] memory: tegra: Add memory controller channels
 support
Content-Language: en-US
To:     Dmitry Osipenko <digetx@gmail.com>, krzysztof.kozlowski@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220406052459.10438-1-amhetre@nvidia.com>
 <20220406052459.10438-2-amhetre@nvidia.com>
 <bf23e357-1e74-6bbe-7f37-11147654e5fc@gmail.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <bf23e357-1e74-6bbe-7f37-11147654e5fc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0013.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::13) To SA0PR12MB4349.namprd12.prod.outlook.com
 (2603:10b6:806:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fccd836-5757-4b08-382c-08da1b835f23
X-MS-TrafficTypeDiagnostic: BYAPR12MB2872:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB287239CCBDE9CC9E5780186DCAEA9@BYAPR12MB2872.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jsN5PCXa6ukSX8rq86yW+Cm5023nV8Ro8u/x9ejqWtBQK6sP7wOI4NYFHe7KhBh6gD5UK+e77Shn/rb5qj6iiQ8d9FQ9S56KxZoi4ibSVZUv3pg3/jyYdhtmmG3ZvHZgeNCUZ4TwsUzIgbQt8i1msaOiQMG3MHGGl3X5IwMwcPJxWRtwGHTCMuPXU1ZN8Gnt55PVG7IQnrVKUA8htcSF3rIVwNLziBg6yn3+DksSdKc8cgsyP+WV4LsQjUCh7m+Wge0JQUyCE9bsl64KopdQTN8EDosWGdRbkxUzDp6wxBjuQpWBIbg+ArYn1T1CjtMeXAAe0oQ3cJYqbwKAZ5c9auIOSg1k1zT166/+y/CQrJf7m4MPCxXtFR8SzyVGxnWvkL2iwr3yVz1JZcLeQMp5W40I1YT66jomQrCl0caSqebp9tj2zQR/UnPQYpD+YCGfK6v6wOxowy51tdTjDsmweuRQ7nKtURfEkTkEgTbdy0HZgfQbRcSA1hNkp4myF9afbn6lfooWvQQWInC1NC03l0GA6EM15Cyn+Yp5V/IUEGqjYEBt2B7nH17AIrfSZnsOZoCuOhD2yvBy5xo36ein82UYL3VuTDdE9X2MAyzsRM9NO3guD8Ks06Z9WGIKI3FuizoWZUOoNTxwX/F7OR8sf/SYHsFPGo0z3Ale/VyBOx27IaSlDeC8kG5tGYecpOQh95X+WSU0MnAcuxIzOnTbrWln1/SBdRONEFIa/dCU9lw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(86362001)(31696002)(186003)(38100700002)(53546011)(2906002)(5660300002)(316002)(6512007)(66476007)(55236004)(26005)(6506007)(2616005)(107886003)(36756003)(508600001)(6486002)(6666004)(66556008)(66946007)(4326008)(8676002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHJyMlROVW9qSTdWOGRBUE9iTHFRRHBGVzI1RzJuR3o2RjFwNExtVUVKUERq?=
 =?utf-8?B?a3lUNzJiQkhCUjdEYU1RekRnanhnVDdhay92R3ZvRTRidjZSOVBqaUM1YXJU?=
 =?utf-8?B?WWRlRmsydjh1N1NGbks4a2Q5RUdBWGsvTHo4LzlrV1FQWUFDZWRQSy9YREJt?=
 =?utf-8?B?dUF0dzFTUHhXRHdzbExCNlBaOHdCekZCbmp6dnNDa244YUxnNkRqaE1zeHlh?=
 =?utf-8?B?ZWhDbStFQzFEaWdhVnE2ZkxJb0RSWDBoYVNDdXpjQWp3dHRPcEpyeWtRcjh5?=
 =?utf-8?B?eVpnckZhbUN1WXdoK3B3M24vSzRpeDFKWjRGb2R1aWZWQmVqa2NCVjFxcHZ4?=
 =?utf-8?B?RGduU3p4WWIwaEZka01mUWpvVG5tb1JSUytpaVA3UlhpZ2k0UmR0RHpBNVhj?=
 =?utf-8?B?YWc4NkpNdUVEcjk3WnJFVzJlUHFZSWx2a1hFUjdSWGs2QkJuRmdkb1RkRTNX?=
 =?utf-8?B?TDhxRGk0OTYrdmFpUE5PcFFwRmtlSWt6MFVraHJ4SGFxaW4ycHNVODZ2Vm10?=
 =?utf-8?B?bW1VQy81SFZMa2E2Zm96NGcyUG9ocWZldXl5MWtNL1oxREhnWlJ6NU9LUjRo?=
 =?utf-8?B?VGF6ZENtTE8ra2RCbWlDdGhaWWJORFp2aTFVTDZKd1RwU0hYL2JPSTlVa0Ry?=
 =?utf-8?B?LzJKN3BUYm1WYWlwTThranA1SlQ4MmxhRmRDV0dkVXczc1EvUTlRUVhSRDRZ?=
 =?utf-8?B?RU1lRStTalhPNmgrWm41NFdOV0RZN09HZWNnRjlTQUNhbkxKQ2x1RXI1aWdT?=
 =?utf-8?B?WGdYSWgyakxYaDhiSDhVVHRkUXNEQXp5Sk9XVnBGeDdEbER2ZnZVR1VqYjkv?=
 =?utf-8?B?YWZJWnZZQnVCYnpBL1hpbTk2WG15bEE2bS9vQ2ZNZ2tuUUFaSk9VdHRiVXBt?=
 =?utf-8?B?UGFtYWo3bll6ZUhTaGl5aTZMWWZXQ01jaVlpQ3BlU3duYnN1Qkl4S1ZNWHZk?=
 =?utf-8?B?ak5ubDVJckpOL2V4TGUyN01vbm5JcEpNRnNKNzZHNGRVaXI2bTYvREJSSFhi?=
 =?utf-8?B?dzhrOEJVRTRaRlZlTEU3dE42ZTdGc05BS0E0TkJiRFZPNFRPalI2clU4Q0lN?=
 =?utf-8?B?MGdmT04rYkN6OHErS2xXeVBvZFZWeHR2MGJ0VjZoOGlsU0FlSUxqaW9Na1ly?=
 =?utf-8?B?bjlnUmg2QVdOLzMyTVF1dzhZZXRDL2NJb1JaNlNodTR4TXlnRGF3am0vZE5h?=
 =?utf-8?B?TStsVFU4dnczK2FYTm9zcnkrLy9hWVd3M2hVeE5ZK2RUb0RPTTN1NUVlVmJq?=
 =?utf-8?B?QXgyNE8vVXFaL2lmU2hYZlZwZUlvK3dUYnVLNlk1aUhtbmdhNTlleGg4ZkE0?=
 =?utf-8?B?TUkyTys3QUFyTjNjQ2FDVEZMVHZaWE1rSnVVemlKejF6U1NxRFNWOEM1K1N4?=
 =?utf-8?B?QnhBSWczYmpZQnprZ3lXMDRDeDF2aVgwVVZIbnV6YkNiRmNQaCtkaVVrYzZU?=
 =?utf-8?B?cklJSyt2TVhKZ3Y2OWtzSmRuYzA2YUxGWng1eDd4ZXBqNUxmclppcFBmU3FN?=
 =?utf-8?B?cUhpeGMxQU9HODhuVGNKZTJ4VUk1U3RIeEtyOG0wdm51eUE0eHNkNW80d0h6?=
 =?utf-8?B?QWJaZmJCMEgvTVdQR2hQNGhPNUsxeUZzUWNWOWZqNVZWUnFrN3NzZzhJUUhO?=
 =?utf-8?B?U1NpOXZ0YzNhVUFhLzA5VWNZb2dncU1heHJTT3hVZ1lTVmpDQWVQWTkxYWNI?=
 =?utf-8?B?OVRyaS9lb2FQaC9LL3VJYnNVQmxkRlBLQ043aTEwNUU1R2hObkxIRzFaSEtW?=
 =?utf-8?B?TkhiN2QvMUdxVzlkTGNWMkluYmdUeWljQWZnTURxK05rYXhQZmtNeFhOMnJH?=
 =?utf-8?B?bG9ucWZDblJBa0Q4VmQ5K0pBT1JnYXdTOVVCMm5TMlFMaGdtUUo4Z3c2ZjBU?=
 =?utf-8?B?VnZiNUhLUEpYdnBSMFYxQjQvbThraDNIaGJoUWJSbzhxZnpqV1NuMzRXMWYr?=
 =?utf-8?B?MDRGUUJrYk9ILzdwUUVqOVJZU0lDVXBoTkhBNU11YzBOWXp4YS90MStIRDRZ?=
 =?utf-8?B?RjQ5dFR4WGxVdUxqVldvL2Faa1lFNHN6SlVEc2M2aDNQY0c1cGJBTllqL2ll?=
 =?utf-8?B?UTJNT3JMcnJ3UnFyV3greU9jMm9GMU91eXhtSmtxTXZtRTdNeFdtcEU4djZx?=
 =?utf-8?B?M2xYZG12SWQ1dFU2am9XemJ5Y1VFeDlBOWxqc1NINGRIV0dhQzhVdFdPcDFi?=
 =?utf-8?B?aCtaWjFzdnQ1anVLcmlhYVJ0K2V6QTNGamFIN0VnWFRiY0dDTm9SWDNSYUsw?=
 =?utf-8?B?SHh3a0UxTXlOdmlSbVRudUUyaWplcHpIS0VuMTJFc2R3WVdsUDdCT2FkZzY0?=
 =?utf-8?B?eEtjQzI0MUVnbnlXdFdBdHNxYUZlWHg1aFoxbVhsajIxWkkrb3VTdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fccd836-5757-4b08-382c-08da1b835f23
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 06:20:28.0606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vy6T6LpTi1OX3wWrfW4VHJNaFTZ1UZrcBtSLsyNEoRvlQ3KLZr/alxKFhUe6UtzbmgVmYrSZYNnwe24NWqcC6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2872
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/10/2022 8:34 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> 06.04.2022 08:24, Ashish Mhetre пишет:
>> diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
>> index 1066b1194a5a..c3c121fbfbb7 100644
>> --- a/include/soc/tegra/mc.h
>> +++ b/include/soc/tegra/mc.h
>> @@ -13,6 +13,9 @@
>>   #include <linux/irq.h>
>>   #include <linux/reset-controller.h>
>>   #include <linux/types.h>
>> +#include <linux/platform_device.h>
>> +
>> +#define MC_MAX_CHANNELS 16
>>
>>   struct clk;
>>   struct device;
>> @@ -181,6 +184,7 @@ struct tegra_mc_ops {
>>        int (*resume)(struct tegra_mc *mc);
>>        irqreturn_t (*handle_irq)(int irq, void *data);
>>        int (*probe_device)(struct tegra_mc *mc, struct device *dev);
>> +     int (*map_regs)(struct tegra_mc *mc, struct platform_device *pdev);
>>   };
>>
>>   struct tegra_mc_soc {
>> @@ -194,6 +198,7 @@ struct tegra_mc_soc {
>>        unsigned int atom_size;
>>
>>        u8 client_id_mask;
>> +     u8 num_channels;
>>
>>        const struct tegra_smmu_soc *smmu;
>>
>> @@ -212,6 +217,8 @@ struct tegra_mc {
>>        struct tegra_smmu *smmu;
>>        struct gart_device *gart;
>>        void __iomem *regs;
>> +     void __iomem *bcast_ch_regs;
>> +     void __iomem *ch_regs[MC_MAX_CHANNELS];
> 
> Why not to allocate ch_regs at runtime?

Yes, we can do that. I'll make necessary changes in v7.

