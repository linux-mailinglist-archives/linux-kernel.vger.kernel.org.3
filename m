Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D675A4E4400
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 17:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238981AbiCVQPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 12:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbiCVQPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 12:15:36 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568DF49CB7;
        Tue, 22 Mar 2022 09:14:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4/nv3AlvFd3o16+0nxS5E7hHExSqEGVtcYKGGr60weGOp7Q428x010Dt8/4hPbRxrXxM3D9qbgRBUXp3jxcN+24zMdR3jr/8Wo6QVa4+ik3lU//2YQxih3Mjl1WLGEvCYoFE/Yy9feAU0+QEiXtdWu7txY3YUT5zrjeDiGPDpU0OUJfg3rxzFbOayvgBH3EGN1OoIHk4TwMRJb8R9+7GuyeLwdAWnkTGh9jC1vbl3YKkO/04bjaBTFVCgmxxw/w2rgKwPp2ZsZHwiBQOEUwejyaG85++XyyfBI/3O7B8VWoIrr+yrmm+koDHL9xC7ReigHXIDDI8/uc8NasjiZP6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9xET6mUzfWozV/f+H+x6SHFPsUUjfZkVxSQUYtZSmQ=;
 b=Doi5vsffUHci0n29cvMiLNu/eQCfbIFIxxrjvk6oaVRbX9NFp3ldTOqLvNDt9M0nIZ73m6Wo/ZNyx6qS5MdYgZ4BWWZt1760x3Cjtgh0vS7ab/GL/rrGOnbYnwFwcw1hVWIT2LbjNjE35E5ClWVTpZUHDiunJUxHg4jowR+8k5jcdHq1raNyFkyF+OU3VXPXmFSeX17JQest5uVlxgTC3F284GOjcp7SL4F/+0xAUlvB9oiVc+WxJ+xPyK+uvcsBv4KULGUcGkje94JHs3Fdr0B2Ymbq75IaVmsIWXJJpyeUcZZxsAeSHzNw/B+2VYSK1gZZ8AIUBxSGytpl9y+q5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9xET6mUzfWozV/f+H+x6SHFPsUUjfZkVxSQUYtZSmQ=;
 b=VpxU4zoT1PWtaxfot3UlZNaaypiAmMlkP/IMeNCqzCSvkvSsTAGhNkO9SpLi+J6RAe3859u63HPAxn+UcubC6u1UWCLDNnOalR0JxOPCD/2ZtFhRw3koURFMn84OX65T5IPoUHtifh6wFfu1x2SDCXTyrXpkOKzRVwmnoymy1mqNBaBbw3XVKH8jfoWcWUnnvQslvqDknY3KJTty+Jp5O3Tpzg0h+mZUKPyXayPavBVNtDI1Xpy2gh4FVtluc0noOFzvBCDFNW6CdNHixk1ELeAOEU7ndNlzjAVdctiBz8/4/UrRjnhaSGDGSBrym3zQlwUHRljIggswX82B72w1NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by MN2PR12MB4989.namprd12.prod.outlook.com (2603:10b6:208:38::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 22 Mar
 2022 16:14:06 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef%3]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 16:14:06 +0000
Message-ID: <051e316d-c89e-2b7f-63da-c96026fcb671@nvidia.com>
Date:   Tue, 22 Mar 2022 21:43:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v5 1/4] memory: tegra: Add memory controller channels
 support
Content-Language: en-US
To:     Dmitry Osipenko <digetx@gmail.com>,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220316092525.4554-1-amhetre@nvidia.com>
 <20220316092525.4554-2-amhetre@nvidia.com>
 <83bc4c12-13e3-d239-3845-a3541b1fbb2a@gmail.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <83bc4c12-13e3-d239-3845-a3541b1fbb2a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXPR0101CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::14) To SA0PR12MB4349.namprd12.prod.outlook.com
 (2603:10b6:806:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c82eaf8a-bb08-4520-a72f-08da0c1efcb9
X-MS-TrafficTypeDiagnostic: MN2PR12MB4989:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB498979CBE4533581D66501AACA179@MN2PR12MB4989.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tleke+y8jF840/C4ZNZ+KgIJY07vMbyMULsxEyg0fN94g8+WctG5IAZUblhQNLGPkufpVwb+EQO3O7hiV2oY0tR+TGhCBvuuo2L4CcqHYfYtPo5lBMUwsss2cch8ZKETHsZej6MNJK9B7AW7U8jiZbKo84OuAYeTEs5qUCnukch1kMxrGCxw/sXlQu8NPv5lTLuxYoOL/EvW/TPoifC6mMhZDmvhRQLw6XY9Y3nnYyvQ8FLDmmb8ABtJJXf1Dq+Xbg3NZZrpR7nZEdi+Fp3hlvhdyT0sKp9FfKSBfzAJAh8xuE9rbwblPeH9N4pLNB15+tfhEXLrWkVhzDbA16U4q5gaNE76FQW7pwyxXF4JSBzlfCbn54eDBCZQrOWt5dclFAv5n/e2I0w2SBV3oQOC2Ex0BWXs87/Fa5Ng9U8lM02oZyT9V8xg0KSgyssUFAP3EdrObJqn478Nb6MLIO+gdtO9Y20hOkPE42/367keS46bRZCnCGmGZcOvECjZOHy+X+kewjwmoDSwNden1KZwSFk9lHEwEC3zupkmT2J/gW7Jr/j1aTqUAIpyfDwbJT01NGM5bE01oE0doSOBRTZVQKtpA/qMy4T0kPH/8NE8W58a50/JqaAvRbfs1i1z9xn80dS2wc9U2Q2gQAAeA4RZXusjpfotOdilrbulR39UTkr7eD2p0atHFN71RACOjnusz1bVKN5P7+d2GOO2wfPQlPtzI8P0oF1+vBe91heaTmo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55236004)(53546011)(6666004)(6506007)(6512007)(8676002)(66946007)(4326008)(6486002)(107886003)(508600001)(66556008)(31686004)(66476007)(186003)(26005)(83380400001)(38100700002)(8936002)(36756003)(316002)(31696002)(86362001)(5660300002)(2616005)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3dDeENicHF2WnR3K21ib3A0ZTFYTmlPZ2IyNTNPUmlBM2YvTWU0dm56alU4?=
 =?utf-8?B?U21ENUFsTjVBWGVnM1RCWVJ0MEc2NURMZW1TcjFZSDlvVFUwbG42Rjc4OExL?=
 =?utf-8?B?U1ZZWi8wTjNNYnRyblJYRER1N25YcFJEaGlWalFETGpWYThsKzF3TTdxR1lz?=
 =?utf-8?B?VWg0TTk5bTZzUmxycHZydVpKRjJ5SGxiSW1ta3pqVURXUnFaS2hIbnpVUHBO?=
 =?utf-8?B?MXlXcmdhRUhIR0M0TVo4ZGdieWY0VEl3dkFicHZPaFR5ZlFldTNDT0JkM0I1?=
 =?utf-8?B?d0tOMm9sVTY0NHpFSWlSN0J0RW5XSmw2N2M1YlRsZFVJZVYzUkUwak9Da2sy?=
 =?utf-8?B?SEhid3NCWGFRQXVvS0F3cllRV0kxdmh4cG1KbGhMTktMeTA1VThwYlNweGp6?=
 =?utf-8?B?UUpPd3B6cVJsTUV4SDlJQ2Q0dC9PUENsUHZ3amNoa0h3L0VYaHYrdUpGNmpC?=
 =?utf-8?B?MkI4emNIT1NrVjIxUWZOM0RwUlZCUWJrR2x6bXVzYjIyRTRLL3lIaDI4NTdt?=
 =?utf-8?B?a0RWaXRZYlJwMXcrQlk3TktSZ3dNQ0VZeHR5T1ZSMHFvOHk2cUZVcjFKbG5j?=
 =?utf-8?B?SEk5REpOYXI1SFR0WThuTy9jcTNldkpGRDRwbEk3WTZRZURTSkVnaDhKNEpP?=
 =?utf-8?B?UmdzeGNuYXpQWTliUWF3WmdubmlSUDFzOFpKY0JpU3BteGFUOFNvMERkaXVS?=
 =?utf-8?B?VUlVQjBkNzlwRUxRVHVjSlpMN3ArV2U3MFl6TEdWc0h1MUtUeC9zNmdieDNQ?=
 =?utf-8?B?SnU0T2NsZG9vZUYxSGFTWHBML0g0TVkvZElOdGJscVBWUkg0Mzk4WFRBaCtW?=
 =?utf-8?B?dDRDUXZ5OEd4cmNTdVBBVFZwTUlKblVaYWpUOXI0QmtsRXptTkZaaUttd1VD?=
 =?utf-8?B?bFROSmdqMXdQNkFiM0U0akViQjN3Z0JnYXpyUVdoemM1MmNlWEdLcDBlRnY0?=
 =?utf-8?B?M2RGenErRWcxREg3bW1sL1dmeEpnSmd5Y3YrUW1zSHFTTmJDa0pZVTVRUXRs?=
 =?utf-8?B?cEZBRytVc3BVNDhSdXF4R0FlZzVtdXlCcG1Eek45ZkZmenNXWEVnbm9Xb3Fw?=
 =?utf-8?B?VEozYU0zOTJ6N2hWZDBiL3RZN0x3bE10ODUxSFpnTndjL2NWRXViU0gxclVD?=
 =?utf-8?B?eGp6dmd5ZjJQZ1QxK0MwWGV1bWdYOWVpM0g2RWNmaXRnSVNwTUk4Rkh3NTVW?=
 =?utf-8?B?T00zQmt2NGxtdHF1b0JCOEVXbTNERmQ1MkYxTjQyK3haWW1UcEFZMmVwMHJz?=
 =?utf-8?B?WWdCcXo2U2FQbzY5aVduYmJBUG1zYjd6VTYvbVR6WE9FNGJRYmF5bzZpSVla?=
 =?utf-8?B?M2FTTzhmT2JBZ3NTTGdreWlXcUxENXlMNFE2U1dZQzNWelJ5RlgxdGhOYkFj?=
 =?utf-8?B?ZDB6ZjhxODJOM1pHaHNFYVdHSHkwVjNFWFZjNFYxSmxNcGxIQ3NONTIvR0hm?=
 =?utf-8?B?ZWR1MzBwanJyZFlnbEtQblZIRXRCWlZlLzJRb3M4LzZnRm9rSWh1MGRsZUpW?=
 =?utf-8?B?YlFsVVBTTm1NbmZPSVVQdHRQOHNKT2ZpWm9Qalc1eDl4bW5YbDM3cG8zcEZv?=
 =?utf-8?B?dVB2UG15dTlQWUc0TGlGcjNGc2NLcnBsMlRLYXJpY0VNQk9FVk9Salo1ZmVu?=
 =?utf-8?B?SzlMcnhtdHdtS2I0MHJFem9jNHpqODlqRXJrSFA1WkJPWXptQ0RYV0VpZkV6?=
 =?utf-8?B?azhvQk12ZkxqQm83RnN4azE2VCtpWGRYYjFDM1EyZjJmN2NUMmxKY0ZIRlkr?=
 =?utf-8?B?VHUwblA2NGsyV3ArekxrT1pKRXN2dDZQV1dmWXNMTm9Db0pqOVpBR2JPdVFI?=
 =?utf-8?B?M1phU2RtOW1GbE9rYmgySjFQbEQ3UkVtZ2JuYzA0ZHZ5NU1LTmVsUnhiSEly?=
 =?utf-8?B?dzZFdjl5Y2hLTGFwWjliQlAveWZ3b2dZejZrY3FkRW1ka2dyVXhiaXFMLzhj?=
 =?utf-8?Q?FrkexrFjc66khbbKB+OYmY6wOZIfvfcT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c82eaf8a-bb08-4520-a72f-08da0c1efcb9
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 16:14:05.9142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: osELJvvlOC0NQn1UBcAerpU5vGywpeHaK3xLIp0r56vDjVg9xCwBKIk/Hj+tk1t816SBpUY6zBRAOdw54rCiHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4989
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/19/2022 9:12 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> 16.03.2022 12:25, Ashish Mhetre пишет:
>>  From tegra186 onwards, memory controller support multiple channels.
>> Add support for mapping address spaces of these channels.
>> Make sure that number of channels are as expected on each SOC.
>> During error interrupts from memory controller, appropriate registers
>> from these channels need to be accessed for logging error info.
>>
>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>> ---
>>   drivers/memory/tegra/mc.c       |  6 ++++
>>   drivers/memory/tegra/tegra186.c | 52 +++++++++++++++++++++++++++++++++
>>   drivers/memory/tegra/tegra194.c |  1 +
>>   drivers/memory/tegra/tegra234.c |  1 +
>>   include/soc/tegra/mc.h          |  7 +++++
>>   5 files changed, 67 insertions(+)
>>
>> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
>> index bf3abb6d8354..3cda1d9ad32a 100644
>> --- a/drivers/memory/tegra/mc.c
>> +++ b/drivers/memory/tegra/mc.c
>> @@ -749,6 +749,12 @@ static int tegra_mc_probe(struct platform_device *pdev)
>>        if (IS_ERR(mc->regs))
>>                return PTR_ERR(mc->regs);
>>
>> +     if (mc->soc->ops && mc->soc->ops->map_regs) {
>> +             err = mc->soc->ops->map_regs(mc, pdev);
>> +             if (err < 0)
>> +                     return err;
>> +     }
>> +
>>        mc->debugfs.root = debugfs_create_dir("mc", NULL);
>>
>>        if (mc->soc->ops && mc->soc->ops->probe) {
>> diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
>> index 3d153881abc1..a8a45e6ff1f1 100644
>> --- a/drivers/memory/tegra/tegra186.c
>> +++ b/drivers/memory/tegra/tegra186.c
>> @@ -139,11 +139,62 @@ static int tegra186_mc_probe_device(struct tegra_mc *mc, struct device *dev)
>>        return 0;
>>   }
>>
>> +static int tegra186_mc_map_regs(struct tegra_mc *mc,
>> +                             struct platform_device *pdev)
>> +{
>> +     struct device_node *np = pdev->dev.parent->of_node;
>> +     int num_dt_channels, reg_cells = 0;
>> +     struct resource *res;
>> +     int i, ret;
>> +     u32 val;
>> +
>> +     ret = of_property_read_u32(np, "#address-cells", &val);
>> +     if (ret) {
>> +             dev_err(&pdev->dev, "missing #address-cells property\n");
>> +             return ret;
>> +     }
>> +
>> +     reg_cells = val;
>> +
>> +     ret = of_property_read_u32(np, "#size-cells", &val);
>> +     if (ret) {
>> +             dev_err(&pdev->dev, "missing #size-cells property\n");
>> +             return ret;
>> +     }
>> +
>> +     reg_cells += val;
>> +
>> +     num_dt_channels = of_property_count_elems_of_size(pdev->dev.of_node, "reg",
>> +                                                       reg_cells * sizeof(u32));
>> +     /*
>> +      * On tegra186 onwards, memory controller support multiple channels.
>> +      * Apart from regular memory controller channels, there is one broadcast
>> +      * channel and one for stream-id registers.
>> +      */
>> +     if (num_dt_channels < mc->soc->num_channels + 2) {
>> +             dev_warn(&pdev->dev, "MC channels are missing, please update\n");
> 
> Update what >
"Update memory controller DT node with MC channels". Yes, it's unclear.
I will update in next version.

>> +             return 0;
>> +     }
>> +
>> +     mc->mcb_regs = devm_platform_get_and_ioremap_resource(pdev, 1, &res);
> 
> Can't we name each reg bank individually in the DT and then use
> devm_platform_ioremap_resource_byname()?
> 
> ...
>> @@ -212,6 +217,8 @@ struct tegra_mc {
>>        struct tegra_smmu *smmu;
>>        struct gart_device *gart;
>>        void __iomem *regs;
>> +     void __iomem *mcb_regs;
>> +     void __iomem *mc_regs[MC_MAX_CHANNELS];
> 
> s/mc_regs/ch_regs/ ?
Sure, will update in next version.
