Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF5850F272
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343971AbiDZHdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343975AbiDZHdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:33:43 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3387CEB15F;
        Tue, 26 Apr 2022 00:30:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2N4ds3xrMiKYGRHf1f1xhNta1S+mqhtBIuVe65dXWtkG1x6qFvtCz/ZDi95FjspvY31rz81LF8RH350XR6H4+6w8NSy6eOZnKUg4yTMhDP1vArFFcIHIr6TxhqT765/5VmFOJFNRPcNKvtLuQRauf8c7IXvELO8YBiaM+ChUJayLctMzK72n2aMdwP8ZLw6ZCYpWG8jM2y/G5XUmAtsg9TNOnnUE0SEpX3V2kv91spT5dks/nWzvzCGuV6Hudhujukk4+2+5R4m1mSYMVfJ7jC0B6lPpsf/ZPxM9Rk10P4BFZVjaE98hnNLiTvIR9UVm45FVXMMmsS2JwaKaeyTTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gd1sE0AHTrgZ/w6KiHsEZvG+2EYLn/xGlSDFWkkrxqg=;
 b=aU6QFk0JjBgjAaQSo3MwUnMiBVyFcymBS64pBm/1wyDyHWU9e0lzs7sXSGtzEXez/G//TGQaSvZxmvXUl2IFrxwd04yHQwyIkeSvMUS03QQwtJaqgSir6V1MJV1EB7bpHdZLLAFScUXwSnvQ7BVtL2weP8A9t87iBc5M6LYa+EZaDBhP8XC1kJZ6e82VO/4AYWeij1hu67plT26b9W3HPqBi7VhzbYpshE919ev6EomtGHyC7EvN+HRQyV0EEYeJ8TjRKMWAgMCsTKAx3vcJ/A9QU5I8osan9PQExrZ8DnT/nBKSFP2ymg5i4XZ/EDl1im2vaCkTT74HiN49vmPeog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gd1sE0AHTrgZ/w6KiHsEZvG+2EYLn/xGlSDFWkkrxqg=;
 b=V1IN/B0LSPAwwrGpgrNotCaUGrKiLQbvUp+KFr1iV4VqiSfZ4GTU7Kga0zwdglLMnCfZtl4XAA0JYmEN7VaK6LSQGUEUy3ZNor/IhZ8mXjpqtyyQ1Z+TmoNRg+sSTAHllqXUITWG9JxO6T8htBIdD9ei3Ik4p68vnuuVgTqSY/2NllQ9zKKqzo5RzlyVVuIOj4dRjhkrtd4fIn3cqrzXeae0s/R3X7MH6jmqFgcPnVG+qQ4XgVhB5o6+Tp8pPbCXAnpBn2/leCridFz6q9dcc9w/C6JLsRN98JSzYc6Q2MmGcgl3HBVoadrU3MXMROOPk1PH7+BI+GvVMuaMU8uyRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MN2PR12MB3629.namprd12.prod.outlook.com (2603:10b6:208:cb::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Tue, 26 Apr 2022 07:30:33 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::a4b2:cd18:51b1:57e0]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::a4b2:cd18:51b1:57e0%4]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 07:30:33 +0000
Message-ID: <0a33c287-3394-c3df-9bee-ef13fe3417e4@nvidia.com>
Date:   Tue, 26 Apr 2022 08:30:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v2] iommu: arm-smmu: disable large page mappings for
 Nvidia arm-smmu
Content-Language: en-US
To:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        iommu@lists.linux-foundation.org, thierry.reding@gmail.com,
        vdumpa@nvidia.com, Ashish Mhetre <amhetre@nvidia.com>,
        joro@8bytes.org, robin.murphy@arm.com, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        nicolinc@nvidia.com, Snikam@nvidia.com,
        Pritesh Raithatha <praithatha@nvidia.com>
References: <20220421081504.24678-1-amhetre@nvidia.com>
 <165053012237.502660.4418683392126519698.b4-ty@kernel.org>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <165053012237.502660.4418683392126519698.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0301CA0017.eurprd03.prod.outlook.com
 (2603:10a6:206:14::30) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfb1ef70-2ee5-4ac0-4c66-08da2756a5bf
X-MS-TrafficTypeDiagnostic: MN2PR12MB3629:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB36292C43DC2B4A5423BD357ED9FB9@MN2PR12MB3629.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QN3G/5GDnT5DoR+48kUBp9eIANv6GJBTaLrEkaRmHkHQbljcnXRx857sS3XgT9QUCXGQJ9eeqhr04xO6Q/ApCdo6kQ7fMgYxZhjQ4oGDiReBecFOjIAakDCnHH3J1rr5lO8BL2W6yQXyoQeD8uT2l11O1CkWWKQYSevbLqTkgeg9Bdt4Zxp2y41oR+xDv7LF/4f323EwTYsKQfHFjkte0hWXEjnCQdUWsgUNJ9FYmvCbZ2uNPaVJbO1G2+70CuqYSsVrnr7iKtUi0WqGVH1nXQAOGXskNfT14UnHg1zHbGsdmyyCInr6GvNA1zYGXFELB3DdQUJ6sKKHQqFJpDbk31VQL256q6o4A9luTHDKDXAqN4pRhJLN0r4DJnX4doY3iyuX5+HPW8R3VpSWrggnc/ZTQwjIs1DdW+kaPfgiTN5FYLARKzGXzHRM3L33y7Z8dbf43ebaOgRkw4cMtsX9j9UMUTO7HYPr9KEPBvzYrRQL1hLwdqS0LGUT9TLRyZ9ApFNSTGUwr0tC/HRhT/wpoTLSdqPvQkAvl4na9XSyaq/vrh/JkTII7mA/J69ZXJptKp7myaP9oBTsCWuG2yk5b7DUzzIMCzOz7Kz7h6VQJ2sze8NO32LGqch/TxwQqShFAQflfVkPLXxBdclOoA2eOT9w3qTc8YQuyXXSR+26JiIZh1FlPfOnRR8f1uyToOmiFMW5h3pDFkrWsuttmLCCXs3J2p8EeCa/btViofTRZGtj1BVpqgA/1JA60Z/8q9IUX+1Cm2bloHTAINdpXdxn4+6W6ZbQveIOsgQSKCUrg61CgCwRPacihBLh7ErPgtR1LcQMXB/LuFqd3YNYIt0+eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(6506007)(508600001)(53546011)(8676002)(921005)(55236004)(2906002)(66946007)(107886003)(66476007)(2616005)(66556008)(26005)(6512007)(31686004)(4326008)(36756003)(6666004)(316002)(38100700002)(7416002)(5660300002)(966005)(83380400001)(6486002)(31696002)(186003)(8936002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm9BVmcwSDhmaG5PSzZVOGU1cXkybjVmdUFyaGtsRVRQbWlNQm1wMCtkNXJZ?=
 =?utf-8?B?U29FL3hydFl1TVd2anZVcGJiTTBMblF1MU1Qd3J4VTgxUG85WkF0K2kvblRS?=
 =?utf-8?B?Q09UN1dhRCtGMVR1c3FVeC9HWmVldFcxRkU4aUpYOEZ3YVFlL0UxbVJhYU1K?=
 =?utf-8?B?bzY1eWRydVBTcmhoTG14d3VIK3ovTFE5ajFkWE9rL1RET3J2V0VNTmVoOVY0?=
 =?utf-8?B?eW5nUWQ0Y1R1eE9jQ1Y5RCtpditKUWYvdlIzZDl4V1dTNWFlUjA4cXZWTzRI?=
 =?utf-8?B?NVNKdm13NmFxSlNmR01BWG1SK0lrcmRxcXdGbldrUHU2Mmxua2pqQzAyVlNQ?=
 =?utf-8?B?L0RSOXRGN2kyT21VK0ZQZWNuTWtZSGVNVkhrZFRjUVpEZEY3cjlzd3BzdmVI?=
 =?utf-8?B?LzJpWWJ0QURSNGZxZjZ1MktyYndHdEpjS012c2JVZ2hIN2FJOXl6OERONjJF?=
 =?utf-8?B?UXE3YnhGRFFGc01UaDUvdHJuanV2OHo2L0NxYnZxSlp2R0N5VmpvSUpVeU9y?=
 =?utf-8?B?N3Y1ZEhuV011MkFMSkxFcUhmWlRCTVZ2U1pQQXZ3eURxZitLbnJFbW43M0FO?=
 =?utf-8?B?bEhKWm9LNFlnNzMva1ZBRE0raFhvTGVpRWl3NURna25ZOHE4YVBoY1cxTjlo?=
 =?utf-8?B?Y01JZ0hyb2tKUy9WRXA0cnFIdDZKRHFxWEcxUWVSaWcxOU4wcWdZblZhYVpx?=
 =?utf-8?B?RmtxbURaWVZSY3VzWDhRdlJVZlNxYU16bElUZ2YxL3ZiZkVuQ2hlRzhKMGpv?=
 =?utf-8?B?YTluRHJsR1k2eFNrZEZ4Z2x3R2lXd1RqSnlMZUU5V2FVckJIQnlXTGJMYjh2?=
 =?utf-8?B?YjhMZVRhWTJ1Uys5eE1nMC9JVnV5Z2c2S2xDS2V1Nmx1Uys1aGo1T2dTbnQz?=
 =?utf-8?B?UEorMmlxMDF4QTFTM2hBcWphWDgyZlowZEVaUDJLd0s1bVk3NlRBSSsyeGdE?=
 =?utf-8?B?ZzRXemFJVCtQVmdkMDAybkdxdUVKWCt2c0dJellwTit4QUpsK24vckpaeS85?=
 =?utf-8?B?c2N4ZDV6OWlmSDJGSkZZdkJOazMycXIvemlLT1lCa2tsWFRxcTRQS2JnU0o3?=
 =?utf-8?B?QkkxWlczaHNrREJ2VWpEUmJzWFllY0ZCcVRHSVBBRDQ3UFZlRU5nS3IwMGFa?=
 =?utf-8?B?Zmp0UkhkWGo0OVl4Qjc3OTdNeEJ0MHZiZ2FhTXRhbmlVYW95VjZ3dWpQazVN?=
 =?utf-8?B?emIyanNrVmhyWWVQVDFGTXduVTVoSHIxekYvZUVZenpsUEYreXFobnkyWWZR?=
 =?utf-8?B?dWZta3RXeW1oY0FGbW01V3MzOTN2Q3lmeGd0ZEFXc0JWYUNjMFl2NUd5a2dj?=
 =?utf-8?B?YTlWOElHdVp3elloYVFXS1FlVVVjVEZaSENMcGNJNlg0ODFwUjE1UFM0YjdC?=
 =?utf-8?B?R3FORlNlZnpzNUpZWlVTZGpjVzBXREZLanc1WnpjK3BpeWZpU2t5TUJtczc5?=
 =?utf-8?B?L0l6aEkzL3NlR1BpR2FDRGlwVGhxeGlkRm9FR1JGSU1vL2x6cXQvd0Y2aDZB?=
 =?utf-8?B?eFNZa2YvSkpZK1pUb25GMmJWdnZKRVNIN2FhcjVqaSsvaUFWdEIxSUMrSEFG?=
 =?utf-8?B?a3FVanB5QnJCQTdTbDhkRHowYzR4TDJYUUcwUk5xeEcyLzZuN2VKb21YZnNC?=
 =?utf-8?B?dWZnWStNeFZhM1paaDRhUVZ5Z1k4YnJmNHhCVGxYUUVscVQ1RXpsc1BaTk1D?=
 =?utf-8?B?bzdEM09ROWpoSzFwTExRMG4zY1E2M3c3QVovYjFXTHpMVlNLTWwzdlgwOXFZ?=
 =?utf-8?B?bldtL2NwSFBaNWJISUkwNmgyT1c3VnczV2JxU1pUeWZtVC9qcUw0VmNvRGNz?=
 =?utf-8?B?MitXc3BDU24zSEVyNndZWGQvTDI1ZElhOUFvYURMajF5SHNmTmcvek9ZUXJG?=
 =?utf-8?B?dkVjVmRNT2pNZFh0dXdHN3J2dlN5T2JZdlpyL3loL3J4clZvS0QxRERiZG5k?=
 =?utf-8?B?VDV2bkJqMUpCbDJyS1JIbHAyQm1aZ0ppZVFCRU8xU1h4aktnQmowd3hpemt0?=
 =?utf-8?B?cW5RVktLaFdWQjdma3lHa3czODdyb2dFSVY4enV3eGVTeUxTL3lUbVVEeTI0?=
 =?utf-8?B?eUdGVjlGemgrY1Y5Q2xSckV4OUZkbHZITzQ2TDBuRzRIaVhJbERRamlJa3hq?=
 =?utf-8?B?UjYwcTBmbzJ4LzNPUytkU1kyelAwZ3VtMUZqZ1hzL09QdlptbHBtNDY3WFpS?=
 =?utf-8?B?Z3RrZE9EUVhESlNLM3ZHa2hRSElUN2lORWw0aGZKQXRNUndhT1d3M2ZBRWJB?=
 =?utf-8?B?Y2lkWU1xWklsYkxjaHNhUXJGU2NHdDc2ajlTYis1MjJzcG85ckl0QytXUytH?=
 =?utf-8?B?dEMxUmJ1UFcwOEdNeXdVM3NmMjBhcFI5SXBiT1l3RVNnYUcwYVdXblNLTEJv?=
 =?utf-8?Q?90ERtWiY2PKCzBng=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb1ef70-2ee5-4ac0-4c66-08da2756a5bf
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 07:30:33.0619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+8Lhez1yRFzCgAshkgAnslegGwIsv1bdrayvZ8zWSl2uZ6QHTx0Q5jZpsEqg/UhTRHgxLSbuoQNhglSYtNJbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3629
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 22/04/2022 11:55, Will Deacon wrote:
> On Thu, 21 Apr 2022 13:45:04 +0530, Ashish Mhetre wrote:
>> Tegra194 and Tegra234 SoCs have the erratum that causes walk cache
>> entries to not be invalidated correctly. The problem is that the walk
>> cache index generated for IOVA is not same across translation and
>> invalidation requests. This is leading to page faults when PMD entry is
>> released during unmap and populated with new PTE table during subsequent
>> map request. Disabling large page mappings avoids the release of PMD
>> entry and avoid translations seeing stale PMD entry in walk cache.
>> Fix this by limiting the page mappings to PAGE_SIZE for Tegra194 and
>> Tegra234 devices. This is recommended fix from Tegra hardware design
>> team.
>>
>> [...]
> 
> Applied to will (for-joerg/arm-smmu/fixes), thanks!
> 
> [1/1] iommu: arm-smmu: disable large page mappings for Nvidia arm-smmu
>        https://git.kernel.org/will/c/4a25f2ea0e03
> 

Thanks for applying. Sorry to be late to the party, but feel free
to add my ...

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Also any chance we could tag for stable? Probably the most
appropriate fixes-tag would be ...

Fixes: aab5a1c88276 ("iommu/arm-smmu: add NVIDIA implementation for ARM MMU-500 usage")

Thanks!
Jon

-- 
nvpublic
