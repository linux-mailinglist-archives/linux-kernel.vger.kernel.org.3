Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C78514762
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 12:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358282AbiD2KwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 06:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358238AbiD2Kvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 06:51:49 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DFABF6D;
        Fri, 29 Apr 2022 03:47:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THmVAcSAQ1FtyYLCjs0Pi5usGXLRj6STyXnCRBeiP/7oLd8oKLjP4nk0s7ShtctX0pBCAxyRyuiqSh7EWQ/rs/0Pudg7RM/erjLU1V9oM8IC+Ti3Mw8Bv3ZY6hBw6RIkhlSL2aSd+2diYIaCvh9k9LgCU1ycGDAq6pFqlc9IV+C+EYiE7pqI5yrjE6f56PiUP9kB2THU3eKz8kC51NC3+eVE0248kQJB/CMZ1o0rj7hKN1wrn2qW6JvmOUTSNu1Q40zH5z1UP1q56Tzdl1GRF7kwh+ANlCFDiS1Ov1DWgrZkDhShyjWNn6mVcYJNUZqNhPWjNxLk0/P21KHcop256g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHrYOXcI81LdcS51k6zxQvjD/gpn8w9pPKGiD4MuAKE=;
 b=XwG3cTPedhBZrbQ0VfY3u9u3i+0GJSiDJfW8bKIzID1EwmTHoZRL0mhHMs1rnz7/mtGUubPZfzvgssOAcJTAUI/jXUAir8fbOqt3yzYjCuP/erqjDEHue2LBrwnUjV/JJdrEQmhGe3gbJk/4aHxwNgIboiTH32VLxzTJY6ZhPxrbJ41MUzSjUO0Az3RVk1YGGvmNaiewbu34J34QiQ0210zF7RZ3XafUBk1pKIb0M8ycXs38sraMPra/Xo3fMGW5/Cb11YYuOqBrU9orCXKlqGs6lmzL8LaZzm3SH81WkACYsGVPwEPSS4fhU48oWo1YlRvxXeHnxeqPOkkNFWukHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHrYOXcI81LdcS51k6zxQvjD/gpn8w9pPKGiD4MuAKE=;
 b=eQ9frgVW6akWHp20sEZWFwZsdg1nwkQSbUPeqQ430z/6r1M9PXlsRIynHCQ2nllVghqcWYXmTK5aVzlW2Lc94pYmkOhJvIYNyqrSDsDwKwaUNrzguL4MngykXN0xNujPtOxE8aHEhIoTaSa1vh+5PJxqjfiiPnyV723I6jWSwO45bXEuq/Rm4gwFQeNTp46DgfWT+4Mv7RvgN74+YLmmOosMTR9pubn5EkFFsi+/4RgbWLpt6xbIf+wQY8zv8iaWheCoJ7wc8y3CY3pRuhlQS99AZsyCL9GsrmfHElWQ255RqYg8lhO1qU2sfZVyueDbko0M0HEMcdcveJJtxCsJTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by CY4PR12MB1574.namprd12.prod.outlook.com (2603:10b6:910:e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 29 Apr
 2022 10:47:38 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::4d90:3332:acb3:395d]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::4d90:3332:acb3:395d%5]) with mapi id 15.20.5186.026; Fri, 29 Apr 2022
 10:47:37 +0000
Message-ID: <416a37f5-92fb-8b34-3597-32daeda33a24@nvidia.com>
Date:   Fri, 29 Apr 2022 16:17:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [Patch v9 1/4] memory: tegra: Add memory controller channels
 support
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        krzysztof.kozlowski@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, digetx@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220426073827.25506-1-amhetre@nvidia.com>
 <20220426073827.25506-2-amhetre@nvidia.com>
 <8fc06781-72a0-9f86-e9cc-6af2425f2077@collabora.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <8fc06781-72a0-9f86-e9cc-6af2425f2077@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR0101CA0022.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::32) To SA0PR12MB4349.namprd12.prod.outlook.com
 (2603:10b6:806:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 406950aa-c29e-427b-ae07-08da29cdacfc
X-MS-TrafficTypeDiagnostic: CY4PR12MB1574:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1574CAE529911B520E8DBDFCCAFC9@CY4PR12MB1574.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4dFcFyZaEUoesUKKWfylACf10Lzi+b93rpnmAloSZlfMe2r/CLYAN6oeLfXHLt6MEhkK1CNygg6YMn4AhNqDqL/FAipt//p8723mbRg5+RSgQYpmUu1R4Ws2TDO1DbtlQDUHedGnQMPOa81DsPbCWmYV6Fvqm3s1x1//4w0+iSaq83gos1zUUliEqFBpPh8fseDRgS/TP6XvBQhp6VF6pYo/jiw14WsQ/sisObHqdITkRAfmr+QF/GisYt9uwXWshkxMm13gNjfKjacGi+y8B+NDVKUA0ZMU6Cl4v8eWQXSA6sh6AiEhAxd6zOs6e5WHkk1TyJ3WZktoci5wNvR8izM3ShSa6vaNAhso3zhTbesPor6B/HlxvBXOWe6fByVxE/T8DL93A4kAz6gwyBnxaG91PhNUvPlzWqO3lpWTR4+WluZ1FJjzDn/k2S3bLJrmhVm0B+SnXwgt2hbkRAQ0nt4Dd/t4/73RUpROZYoQ3qRgDlQbusIzvUVomRPICuxV3WzTogKB6DzOONEonR1y0Y+WtpnytSvEN6aQKmIN3FmLp0R8S6AwyHVg24MlB0aafnQcYOlkgV+imkPZMLtWYOyCbswtEMBibzapqQsBdZA7MIskMetTIxaFT3paO/gKXH06UHzmPe2EP7w4B6PPmdjTUWmOWpU38A9VmIZKO+GgzpyXfU7aWDTRrtFHmZxJPPUv2gTV1aigBb7RIo5scA/AsfCjA7RHlcxPqoQf9PXLEp+BWqkECNtHpro/BB22
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(107886003)(2906002)(2616005)(31696002)(66946007)(36756003)(186003)(5660300002)(4326008)(38100700002)(86362001)(8936002)(31686004)(8676002)(921005)(6666004)(66556008)(83380400001)(66476007)(508600001)(6512007)(6486002)(316002)(6506007)(53546011)(55236004)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmltd1UrREowS1k1UTU4bittUzdDaWp3ZVVvWlhJaXM3ajY5ZDU1VWhUdjR4?=
 =?utf-8?B?bEtNSGRxaW5Id0RtaFhZeHJuUG5WSFpPS0cxMlM5MmZoU2ZTYStHRXVOdnN5?=
 =?utf-8?B?bmNLOU14WlFwNEJoWjVwY04yaW9DV2JwT3NHa0hpRFhpcHVwTkpYYWJ2di9v?=
 =?utf-8?B?MW5wY1hqQWJsa1VFQW44VXM4U25peWY3c3pQUzMrOEppYzljMnNaZlpoT1Rw?=
 =?utf-8?B?dGVoZXIxUEJlaDczUUpDSWpSSU1MdW1WN01aRDlzdlJBYi9aNmFocmd0RXI3?=
 =?utf-8?B?MnZZOWx4TE1oZnhMV1FYbVhvemtmSmZscnA5ZXRDZzhGNGR3azdnNlNQd0Nl?=
 =?utf-8?B?YTQrN2wxT0VlQ1VkSEhoV0JhK0tuWU9DNDI3TmxIWXNudUNuNmdiQnBlaHhr?=
 =?utf-8?B?eWgxZlJ2WExZRVZFMXJSek95bTdVR0pnWXg5TFo0Mm5RQzFlM2o3UURRenBU?=
 =?utf-8?B?U3J2TVk4aDdMNzk5cG1lZnJSQ2RGZnR2MGdoMjZBb0pyeFRiYUhZRkQrQ2Q1?=
 =?utf-8?B?b2UwRittNi9kZzkrd3FnOHVTbGFMNWRXZUhqajRnN2dTeW1GRCs5a3dDeklm?=
 =?utf-8?B?MjFHVi93a1FkZzhSR2huYm56bUFvZzdyRUpXdkJvUWx0Wk0zejVrR01ISkdL?=
 =?utf-8?B?cy9rcktBMlV0UmUzU2xCT2I1bEpsMWZPODFsOURmM1VUdFlaTHZhYkFucXJU?=
 =?utf-8?B?U2Q4N0VWZkhaZzNDY1p0cnFjRzJWL01lUHNZQm9kTUE5U3VPODg2MFl2YVdv?=
 =?utf-8?B?ajhVNHN3RjM5M29BS1ZqK0JoeG16bTZDMWgxS3dRckV4azg2bWZZZmNQRkQw?=
 =?utf-8?B?ZDdHRTRJMGhlbWFuZ1VFa203bmhlbkJjcExmMVlGcFREWUltd1hMdXNrZ1k1?=
 =?utf-8?B?OXZBbm42NUJRL1FmRURtMWtMc0prcTh2OUVxd2VoVjJEZ2svZnhqWG1jV1k1?=
 =?utf-8?B?WU13M05QT3JnUmxhRDZ5L29kVkV0NGl5cGl1ZFN2SjA2NFJ3d25YRmt6UVJm?=
 =?utf-8?B?bXBjVEw0Tmp3a0pFR3NTL2NydDliUzFyNjV5YnpuSVM3OU5yaVVhcmNBMW5B?=
 =?utf-8?B?UnFYbFlEbnhJTjB0OU5mWVZ5UUE2ZGE2eFkwekxQUEM1dGU3VmFGK1k2WEM1?=
 =?utf-8?B?TVZ4RnJIN1FqN3M2UmJzMWNPQTJGR3RhYmp0NUsrYVVXcEdzSHl6dG1RM3gz?=
 =?utf-8?B?UmFwNko2VUxUZTdDQnNpWnk1UkpGNjhSMEF3MHZvVGw4d0tsMFZqbmgwUGZU?=
 =?utf-8?B?QW5JYldzY0t6RnNuWmtDL0dGZTZWM21kaXRla1B6cy9MazJvK0FJbnl3MSth?=
 =?utf-8?B?bG1oRExuRjgxSkZHTU9zTnlTWWhKdzV4eUlyTDF3SkxKanJ1U3Q4SGU0UUFh?=
 =?utf-8?B?UHQzdG1CZU9CemVyODQrN2lhOXBFVTlVc2RleGV0Qk1GaUxxdlNwMDJPMUUv?=
 =?utf-8?B?blFKemVCalgyRTByZ2pjaWRPSElZeFVBZVJ4SFFZVk9UZU5vYlQrLytGb0ty?=
 =?utf-8?B?dEJQcmJncVFESEVyZ0R2YjRmUUJHUEE5S3V0U1pXZ0cvTVBQZkxFem1COHVq?=
 =?utf-8?B?Zzg4ZGlEMFR3SHg5bnh2amVUS1laNWo0UDFtZGhmdTVkY3BISEM4ZE9Wbzlr?=
 =?utf-8?B?MVhOa3k2a3ZoMjkrUGZFT2Y1TWtNeXZrb2pEM0I3bTBLeVpIMm5rdExxak80?=
 =?utf-8?B?U1ByMThjTmZLaHlQZnhVR0s0N1F5TW5QYi9TbVJrRjkwcW9EUmdDdW12NHpB?=
 =?utf-8?B?aVJaM2txVXJHRjh6T2xGaFNBRlRmdlRaSXBTTTI3RFA2MDQrdEtzSng0RkFw?=
 =?utf-8?B?a0tMaXZSWWdNMVZ3M2RMdkJhbUxYOXF1cWxOVlU1bGJuYzhwTHdlYWlQVmhv?=
 =?utf-8?B?bzV3eHdpVXlwbm54SGFZbEpzZFViM0Zwa2kwRjU3ZmJtSkRhMzhHdEJPRXY3?=
 =?utf-8?B?NmNyN3MyOUduM3N2YU9HYXFpc0hmZm5WeGxLb05iVVdvNGcwaTkzYmZGZWty?=
 =?utf-8?B?N3krdWFQOFB1NUNiak0rYktMempHMnc1VGNoQ0VrcHREQ3pYN2UwZDVFSm5a?=
 =?utf-8?B?cHVFdzBlUTRVdFBZVlQyaEFmT3pDS21lZjJuZk5pQjJ5S1FCaGpXeHEzelB3?=
 =?utf-8?B?cDk1UjFqaUNxSThEMzJSOW5TTGxTSUV6SGdma1FjNnAzMms4c2hzYlhZWnF4?=
 =?utf-8?B?V1RsMzEzaWZTd0M0TE1ucXdGVEpRY0tJZWtDNlhHMnZVUFhSN1Z1ZE1wSExk?=
 =?utf-8?B?U3BGUUNqcjNQU3p4QnBtMUVlNHdLclhvNUhvR2FGbHhMRW9rVnJyRzIwMjhO?=
 =?utf-8?B?aW1YeG9oU3gweDRUTFdHVDJ1TVNKN0lONDA5dCtKclhKVGs0enZxdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 406950aa-c29e-427b-ae07-08da29cdacfc
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 10:47:37.7839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jTYUne7XaEOzIYAfh7jguNybaOpru+aMZdni20Gne3OQ3Iny3RyuX/mCQ6mGEv4uzJX0MULj7Z81mT7Zt58FEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1574
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/29/2022 2:20 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 4/26/22 10:38, Ashish Mhetre wrote:
>> +static int tegra186_mc_map_regs(struct tegra_mc *mc)
>> +{
>> +     struct platform_device *pdev = to_platform_device(mc->dev);
>> +     unsigned int i;
>> +
>> +     mc->bcast_ch_regs = devm_platform_ioremap_resource_byname(pdev, "broadcast");
>> +     if (IS_ERR(mc->bcast_ch_regs)) {
>> +             if (PTR_ERR(mc->bcast_ch_regs) == -EINVAL) {
>> +                     dev_warn(&pdev->dev, "Broadcast channel is missing, please update your device-tree\n");
>> +                     mc->bcast_ch_regs = NULL;
>> +                     return 0;
>> +             }
>> +             return PTR_ERR(mc->bcast_ch_regs);
>> +     }
>> +
>> +     mc->ch_regs = devm_kcalloc(mc->dev, mc->soc->num_channels,
>> +                                sizeof(*mc->ch_regs), GFP_KERNEL);
>> +     if (!mc->ch_regs)
>> +             return -ENOMEM;
>> +
>> +     for (i = 0; i < mc->soc->num_channels; i++) {
>> +             char name[5];
>> +
>> +             snprintf(name, sizeof(name), "ch%u", i);
>> +             mc->ch_regs[i] = devm_platform_ioremap_resource_byname(pdev, name);
>> +             if (IS_ERR(mc->ch_regs[i]))
>> +                     return PTR_ERR(mc->ch_regs[i]);
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>>   const struct tegra_mc_ops tegra186_mc_ops = {
>>        .probe = tegra186_mc_probe,
>>        .remove = tegra186_mc_remove,
>>        .resume = tegra186_mc_resume,
>>        .probe_device = tegra186_mc_probe_device,
>> +     .map_regs = tegra186_mc_map_regs,
>>   };
> 
> Do we really need the map_regs() callback? Could you please move it to
> the tegra186_mc_probe()? .. Sorry, I haven't noticed this previously.

Okay, I'll update this.
