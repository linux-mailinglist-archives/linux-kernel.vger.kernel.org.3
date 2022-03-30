Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A264EB9D5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 07:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242695AbiC3FE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 01:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239629AbiC3FEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 01:04:55 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2526BDCE;
        Tue, 29 Mar 2022 22:03:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKy53V8+RCT3dH/9CLroordQIvrw5TI4Spf+Z+WT0epKR0qx9isiqjWtzL8kKZ8b1Z4AjhE9j1xuL1sqE24eSBSPapGZg8VLoDgYKgiTUvmkWaztVCLdhI5S+wP2pWv4v1DDlf98hupJV3BAIHMhM88Td6scP529TYdyYWIcDqKS4yPy/gEZXsEY81oESy2tsOJydpvFRlZGGctnLdlng/pwkH2tICK8CcGUdXJqK/JrMsgJsbVKPLqN4S8MLUTH7QowzH/adqUrxeA7R8r1J+snUl6ZYzlpo4YdlZaAPLDaRM6w0YZ9k/neGGaSTDqUNKnWh76bgOtX+1Ga4/H1DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwDZDktnBePH0jHW34nCDgOIOrLSGCjHELtPTxQ6JG0=;
 b=csibH5sdSoB7DYAj3hDq3hQQBHJ/XzR7MUzHLuNxlIiP1aQFR3AcS2T7pe/xRCHDDEbp2jHhsvHWVBpPTxix+AB3ffmO31M8zhhfPIIzecu5kx5Z+38mHFXy2CySKeFpI2UstuG+xokPM+hU/UuqlsXlGxwv7mHxvsanfb1rSBLkIknkLWMmhamWGZ+Uo8dMWTa9tUDNltA6kmgNtkJMwMayAkLZY4M3swDTlIHVl3WeCm/AzSzLu/fhhHKM4qJ+vCQ9voSVhX5h5HlNvzEQX8ISdVGmOPhrXqxDvWoRu6NCczpdarhTZWBycF11VQkh932fpqxGLtPOVma1VBU+2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwDZDktnBePH0jHW34nCDgOIOrLSGCjHELtPTxQ6JG0=;
 b=e8qvdf5HrcUpRsd+JvumwnAiXdEK0Tc14rXMukYDGtXYCgJuUH0rTj+PbGw36HNdpdXfFffjbS7WV2BS2vht7fC5iPwYgNAbNkxrV6Qw1yN8IWBOpMCwg/ss4bZkaS6cBFTWxpSW6vzeuZWsXJiBmJlAeStCqmaUJc/17LB9UJDIxoo6eZrZJXeU8zHDEuZVFKJgkh35x0LmxIXnElxhfJc8z4BmXkKZjNUIxy++/BkwJhD/Xb6UxT7bja1kvChNaTDinKBaxVVDVlL5caBlLVEY5PXuynskKVS5RjNwH+owG3SiCU+P2MIdDZeYkIBwPpaqDnyvquCuz5VGw4q+wA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by BY5PR12MB3860.namprd12.prod.outlook.com (2603:10b6:a03:1ac::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.16; Wed, 30 Mar
 2022 05:03:06 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef%3]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 05:03:06 +0000
Message-ID: <1b447612-25d7-77a3-2c27-26d7441dc15e@nvidia.com>
Date:   Wed, 30 Mar 2022 10:32:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v5 2/4] memory: tegra: Add MC error logging on tegra186
 onward
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220316092525.4554-1-amhetre@nvidia.com>
 <20220316092525.4554-3-amhetre@nvidia.com>
 <168cf065-bc17-1ffc-8cc0-75775c7f3bcb@gmail.com>
 <ecdc86b4-c207-de89-a094-6923a5573ac6@nvidia.com>
 <dacf1be8-f20c-de41-5ae5-9dba5e351881@collabora.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <dacf1be8-f20c-de41-5ae5-9dba5e351881@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXPR01CA0113.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::31) To SA0PR12MB4349.namprd12.prod.outlook.com
 (2603:10b6:806:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e6ea454-f020-4228-2fa8-08da120a9379
X-MS-TrafficTypeDiagnostic: BY5PR12MB3860:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3860815B65E98552A00BC732CA1F9@BY5PR12MB3860.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JcXQddJgYEQMbc7raOFEVbfZCsbr9RkXzpyIJ93kE9rnNU+WNmC7+JkgpA+yWNLKoi0LZnO9uVi7ZASGRdbnBuKfiJSEQIF9+4KDqEbaMl1X7CxFbS3XVvfZAy601RKHHl6M+0iP4EfvED0XQR1U606PrjMgvbF8xK/T6YiRuDkHEvsD2HH+V8cKCdmFvBdrh0ccVP55HBHK1zJZzMFe/3SgNZMfcIrGNgTUo6Z4e3hsjudSQRdSqoyitBqZYKab9IvZgBoOwVgaiXOfk5WH661qNNTKU2+jh2IZlN+/aNjI9mSObzNXMWv7TzqiJ2X2fB0nqhowwTVP/ch1BrIgKdZJieMmnhb23OyiMR3UsX0rY3ZrXYF5y/M3GKPLOBUZ/dW8QGwM+Q+PetV8HdagleXsFtn8rlPHxoZmhe/2/8qnA2Lw9k1s5HwIlcIitwuyATU7uhMBerzoNcPQuErlPM53VP1LVC5NabD8/AvDSiE4Mcp90j0VSv3P1izjQeIMZKCmXf52hE8FkIYdS2Bxj4N2pzy4apq47QdOlo0YKJishjaiQorhEybzooVoKIum69yzLjbPEga9sZHPYGHJSklvMgz/N8KhmJ3kwTGdItPJNhYqhbcBO+0fu6wxoETOh7zEg35DvhnEfwnajq+QBgUid8xx75qtdjwoC/Z8EVDagCbD0qn5OUbrBEXtv1l9w5kvWD1OzHDVfY3lA04X3O4/aM98SODM379rrpb3xhI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(53546011)(55236004)(26005)(186003)(6666004)(107886003)(508600001)(36756003)(6486002)(31686004)(6512007)(83380400001)(316002)(2906002)(4326008)(8676002)(66556008)(66476007)(66946007)(110136005)(38100700002)(2616005)(5660300002)(31696002)(86362001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTR5aGlJdWN1Y09RdUY1TW1Sd0dVdkxxYmVDQWRMZ01rbUlUeWJmRjZqdjBX?=
 =?utf-8?B?cXhwektKeEs0Wjh0bEVTSnpOU1grOEd0d1h0c1JnN1QyQUtKeTArRE41ODUz?=
 =?utf-8?B?RUZ2MUYrSDdzU1U1VXVQaDdmUktxcG1GeXQ4b3Vsb3RGeW5yVzVsRUt0MVFj?=
 =?utf-8?B?S21kTWIvbWo0VnZsSFU3ajNCY1pDM3YxczJjV2FQZXVmcG5XVUx2bUY2YzVj?=
 =?utf-8?B?QTMxMzVYM2dVWk9rZ242eGVGR05OemxCZ0RJNGNnQmcydGQySDJYOFhEZDM3?=
 =?utf-8?B?OXZ0YmgwcGRGMnQ2SVFnTjVzZklnQVN5bEg5ZDlEYXZ1QkptYkNWaS8zK254?=
 =?utf-8?B?cjFDeDJDbkxpRDB4SVJIV2NOQ1pYQW5xQUhhT1ptYUYrb0NpS05pZHFrY2Iv?=
 =?utf-8?B?c25va0xOaHJmaWxHMFp6RFVnbDNiK3dHcDNhYzlIanB0cGJ2T1RWR0VFekRs?=
 =?utf-8?B?OVIwMU1uSW8xVHRYcGhZamlIdEdGSVVwcmp0RmVjd2hvM1R6WXpaYUx5SzRu?=
 =?utf-8?B?RnhhbEVPanFxMUhTY2pWR0FHTVhjVCs3SEUwWCtCQ216d1NvNkZGbHZ3TU11?=
 =?utf-8?B?WDZ1UnlxaFFTWDdUR051N0YxZEYxZTAxYWpOaDU0b2daZlQzaUtQYy9sY2lQ?=
 =?utf-8?B?WURRcmdnNDFaYVZUb2lIb21WM0g1V2l2NllDRUwxZklQZDZEcHFvNFBwNzZV?=
 =?utf-8?B?SEV4dEJNS2Y1aGhkS0E1UUxvblVIa1hIaUdUeWhtT3laV0tUS05Zd2hsVnZ3?=
 =?utf-8?B?WEpacEoyb05FZ3U1bHh0d24rQXIwVTRidUtqVkRXOTkrM2hvS0UrdU51RExn?=
 =?utf-8?B?T2VZQy9VRk5FL242WjJIdHpWR1FVNVdkTTdZS2wrUXd1TEE5dUF1NG1EVm4y?=
 =?utf-8?B?R0s1V3Mwckl5UjBtSHNYdjl0eExOMVM1a0JiRndiSEh0bjdlYUlQbWJXc290?=
 =?utf-8?B?dkI1RnlSbUpjd3NnM2sxand1Nk5CMk1BbTBJZi9LbFlpYkY0V0FsUnZqUXlp?=
 =?utf-8?B?OVlPK0ZxTW1WM0R5ZytnbHZQMUJMQWRuazArYmNnTU8zWGIvSHE3amdQMWZs?=
 =?utf-8?B?Z0dlMkNMOVFlem1BZ2F0bzE2TDhZcEJ2WVRPZ3JzOXUvZFZEZ1d0NFRNTHRJ?=
 =?utf-8?B?M1VTdSsyUnV3bVJDek1GeUxjdHQzRFpUN2JyWnBQV2RFTTJycGx2bXVPeHhj?=
 =?utf-8?B?YWdKaHY0Y0Q5L05JRUMyV2oxMjk0ZXF4QVczUEtYMWYzZUloWU9naDNKeW04?=
 =?utf-8?B?OTJJR3orOXppYmNZcytqdWdraGQxejlJeENBWXRXaExnWWFGQ0ZSSHpFU1VJ?=
 =?utf-8?B?MERlcFRFMEpJMFh6eVRuY0dueEI3M2l0cUg1c3ZwUTc2R3hsM2FOeVNxVklX?=
 =?utf-8?B?eEpyRzdjRWRZNzFsTUtmYXAwalhzOUFxdUxGTGpWcERWeDFnVUI2SUNLaGp5?=
 =?utf-8?B?a1BXYU1wMFdzNjA3dXo3K25tSFJaMS82VDl2QlczT0E2emZXcW1IRzhxLzVh?=
 =?utf-8?B?UjBDUjFibTk3WHlobGxmWm5XN1UwUDRwWE5ld1FpdlcraWNYbHJNeVNZQldF?=
 =?utf-8?B?Mms0RWpIOEZIVnlmOUJRN200SDltSXArM3FBWGFHL1lzWFdKV25IVTFpRUdK?=
 =?utf-8?B?bGV6WFlXbGswYnpLRHB6WjVSaXpnZlFSLzkrbEZpNUwwNzlTcXJwU2ZoSHhD?=
 =?utf-8?B?MUJFa2VSRGVaREJRZFpSVzJwOWR1OEtOR3RSL0lrZElUNHZnelNwRkZaUS9j?=
 =?utf-8?B?UTIvTVdOV2dhOU5MandDUDRNSmNBZ0NMOFR2NDN2eURCdXk1blZQZTFVN002?=
 =?utf-8?B?K051K0NONHBMc1lYWG9kWHdBRHRqa1VySlJQYUNsYWcyU25EdHNNL0lyclJZ?=
 =?utf-8?B?UnhWY2RYTVJjbVRkVVlITFR1Ui9MTE41TUFSWXZSZDUyUFpDUXN5WEp4Nmty?=
 =?utf-8?B?UW1kY0VqaWllU2hjOFEzakdCd0ZKVmdabWlkOERkS1hkM1pZYkNKWjVUTTBv?=
 =?utf-8?B?ejdoM3M4a3lHa3VzOUFOSDJ4bzZubnBSNVNEUDlLdEQ3MlRtdjlPcHpydlNz?=
 =?utf-8?B?aWplZ0dQOVZIbGMyNC9WaEQza2FWRVN3d1VCSFp3TlNjYmNkOXJ0b2VQeG15?=
 =?utf-8?B?Q3VweDVlNjBOUHF2a3pabWkzb3JqREx2Z0thOVZBci9ObEQwZGFKVEtCSHRK?=
 =?utf-8?B?cy8rMW52YUh0S3J1WDh6Y01iemtSdG5PUTk0YlowOEtGSHl4a3Qvd2UrOXdN?=
 =?utf-8?B?RzdPSVZuTVlnQ1RhRzBxSVltNVJvRXNZUnZKWTZtVWFNamQ2VHpxcXZVSmI3?=
 =?utf-8?B?MmNIc29YVk10ek5QcGM5ZE5BYy8xMkNnUkYyV3FPQ3FNa0NERU92QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e6ea454-f020-4228-2fa8-08da120a9379
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 05:03:06.3261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ahl1vxzj2KiqeBjZHtvHZNjXmSow4b8m9n9hBx5NNiYFYltx2/3sf3jCr3kXymICYzEmoWwbF1ebPRmNbFzxPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3860
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



On 3/30/2022 5:21 AM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 3/22/22 20:23, Ashish Mhetre wrote:
>>
>>
>> On 3/19/2022 9:29 PM, Dmitry Osipenko wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> 16.03.2022 12:25, Ashish Mhetre пишет:
>>>> diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
>>>> index 92f810c55b43..6f115436e344 100644
>>>> --- a/include/soc/tegra/mc.h
>>>> +++ b/include/soc/tegra/mc.h
>>>> @@ -203,6 +203,8 @@ struct tegra_mc_soc {
>>>>         const struct tegra_smmu_soc *smmu;
>>>>
>>>>         u32 intmask;
>>>> +     u32 int_channel_mask;
>>>
>>> ch_intmask
>>>
>> Okay, I will update,
>>
>>>> +     bool has_addr_hi_reg;
>>>>
>>>>         const struct tegra_mc_reset_ops *reset_ops;
>>>>         const struct tegra_mc_reset *resets;
>>>> @@ -210,6 +212,8 @@ struct tegra_mc_soc {
>>>>
>>>>         const struct tegra_mc_icc_ops *icc_ops;
>>>>         const struct tegra_mc_ops *ops;
>>>> +
>>>> +     int (*get_int_channel)(const struct tegra_mc *mc, int
>>>> *mc_channel);
>>>
>>> This should be a part of tegra_mc_ops.
>>
>> tegra_mc_ops is common for T186, T194 and T234 i.e. all of them use
>> tegra186_mc_ops. get_int_channel function has to be differently
>> implemented for all of these SOCs. So I had put it in tegra_mc_soc.
> 
> Then tegra_mc_ops shouldn't be common anymore?

Yes, that can be done. But the tegra186_mc_ops functions are common for
Tegra186, Tegra194 and Tegra234.
We can separate tegra_mc_ops and keep the callbacks to same tegra186
functions by removing static from them.
