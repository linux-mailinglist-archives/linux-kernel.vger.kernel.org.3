Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214484E44FE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 18:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239570AbiCVRZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 13:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239560AbiCVRZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 13:25:01 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C86A14033;
        Tue, 22 Mar 2022 10:23:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3wxabyCosk7XPM7dVZtE9QgM2pEAkNujqr+9Xva4cHBbwpnRZB6hlgQ87JezIkUDL0sHeIsSY3xblbvRbzcIdsv21Jr5VTnvkvJDm9DfJzM3C9p8KGLyO88Y1mzFtHmleAErcVSsspQ9l08Mu45a9sIL/B/T4m8bc+O2a0DmzfDfHYlDgP4wYIl4ueGRwZs7Y8uXT+Kh0xgkCpH6yrL740v7AnQ3DM2oNNgweB2XqFgeX8tF4k2mKB905nuPNz/voQ8W57iMvmlc6u76G9sqEgk5/YmyIdsVSkOCLrxo+bbflfqYcxQ+6dQtCG/sb/T4dcHyDhZMAl7+3ShgjhpZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHECv5EI76nUZwsIDPnPOmPSSr/poRwFxJcFMj3I45U=;
 b=STlcJIu0j2v6q8qTgwQP/a223UiwDW1/Ig5kpIOZuRXXiyW/A8wDDDp3PAnmhBhObigqB+A8Bts1EcDu0tG54XfBtEhfc7Pc03H7AVESrq83gKuXHId/0SySx+YcBEJTHiUR4UcIE6jlRsO6jz7gH4VTFC3y+INZHbv9GtCKzHXam1cvTy1eB7ktmPesI2p6/cNvxhysXjEIkLOOVRh0cj+rl/yFRkuJPo8UfW/o4JN6NOhfWeSZgTolIUkmmNnliW9b0Ak2pR9NmN10eaFnlzT0qoKINSpMrI+Grkk2cztBF48PJtthir+/P84zauNL2COLGQMkOsCZMuIhEvQKOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHECv5EI76nUZwsIDPnPOmPSSr/poRwFxJcFMj3I45U=;
 b=JFkQtQad8Ko2YERLza1FcJVXySoEZehiXoOQj+aXEaWzkjgiUmTiazglC3Bsexpz0L6VWPqyz2EFOmkmzk2vbDNBFySzflWXcMXCjiUNj1yScJR9sxoyWMyIh4VnhBCmsiWvWdBrwUadHK6fbb5WFdLKJfEFS9c+0lvorGlVymDqc3/m+gqw7gioIuuFbDeR96BWoveGJG0+LUv01m+Xba3XRzeuy567BEOGl20Fo68Sb4PC2i61lsd8ysLZWjYI3NWFW8YnaQCGlT1REIycHHX8GNc5Ha1tohVSmucj5zEEWDriQeQ24NmTEhgwY/IyQaQF4mHKUqy3fifNYchd9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by MN2PR12MB3488.namprd12.prod.outlook.com (2603:10b6:208:ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Tue, 22 Mar
 2022 17:23:31 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef%3]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 17:23:31 +0000
Message-ID: <ecdc86b4-c207-de89-a094-6923a5573ac6@nvidia.com>
Date:   Tue, 22 Mar 2022 22:53:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v5 2/4] memory: tegra: Add MC error logging on tegra186
 onward
Content-Language: en-US
To:     Dmitry Osipenko <digetx@gmail.com>,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220316092525.4554-1-amhetre@nvidia.com>
 <20220316092525.4554-3-amhetre@nvidia.com>
 <168cf065-bc17-1ffc-8cc0-75775c7f3bcb@gmail.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <168cf065-bc17-1ffc-8cc0-75775c7f3bcb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0161.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::31) To SA0PR12MB4349.namprd12.prod.outlook.com
 (2603:10b6:806:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1f7da0b-5ec6-488f-dd30-08da0c28af98
X-MS-TrafficTypeDiagnostic: MN2PR12MB3488:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB34887884F02360FF3E284CF5CA179@MN2PR12MB3488.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CE8PSxK83Syhtyd/KxTf9K9x5jNS7Xjp+BAsiWsXF4LRyXVO9ja70nruEJRBqcySoU8nnUcumy1pl5pB7k5RHeRIFzd03c/8+xhZknHgmKaRXybCcAv0UVuQx1t8HnUljjlyCKiZhSyl7qgTbnvj/rfRezkHh9WchmlaBRpOFfb3RyQkH/BILxbttecyvCbfnftbqZTPSCfdq3rmmUfgwE87aZCVqXCl7pfTnKx4l+/L8wGMtQu3Q8EC5+p7vL1JmKznqocUIm50mHfsp3w0aqqJArFS+vdjLIxJAla1NgGcrSkvTSqJkasg/6G+pa6q6wseAwAaLcA52E+ScO8a+dD8DNscgnzhRxhKiSBtRjCOFmjlxX8oAmAsOOVm7BVahW0kX157pASm7+OBU8Qpvr88r1l0KPX3FYSGBLbYW2htb0PvTZhoE1uyS5vEJX55WxsPHWW0tlmB3HJSB3vZhLlCs9wMDexnsAvSKBgMdRxf4fiuMzwDhiRA8tsos/4Dl2sRdrERZ4siWMIwIv3GgC3UaVAN2wd2iA6DXvjTl7Pbcp/ODOOZwqFRLgkXMhT9jJ/KJCtzffJnNGM+niF+hC46S97Snr6sPteO63V/E1Nt4bpXQgW7Weuv3GUqYcyCfy7767zLk5jHO68Mnoz8bpneyD3b0ggygSIEzFMMonZRruP21/+m0jT57L24+1tzTRwhtA/7sOuXtvkzouUgNSwFDk+O9rPX24bk3F/fgFs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(31686004)(508600001)(31696002)(86362001)(66946007)(66476007)(36756003)(66556008)(316002)(8676002)(6486002)(4326008)(26005)(186003)(55236004)(6512007)(6506007)(5660300002)(6666004)(38100700002)(107886003)(2616005)(2906002)(83380400001)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlZvakE5cHhlQ3RKeWtKdHl6b3RPUnZ0NEJwTWR0d0U1OVlFV2E4Q0o3R0hC?=
 =?utf-8?B?anVZMWV0MHd4dVMwQytCM0NaWU9sbEQ0L1VrNDRFUWNoVGx2WHMxUTBvTTZh?=
 =?utf-8?B?QTNVNnhMd0hwMWpNREpCYWl3ODlBM09vcVN1QWVrUEhkUlcwMGRXK1JHRnQ2?=
 =?utf-8?B?UUZ3VG4ybUZXWGF4ZzhDc29xeUNFK29BMmE5SVhLMVpnRWtsV2V2QmRSRm5r?=
 =?utf-8?B?Q01vb2M2SXNtNXVCcy9BeEdCTXJ2NTFDS1ltT2pVcS9hS3lyYkMybkRIWldi?=
 =?utf-8?B?WWpYNTBVVUt6Y2JRR3JpcTVweHViMThENjc5WHVqQ2xWV3QyMWg1UVBxWlVX?=
 =?utf-8?B?SWZLTmVnNzFrWFVMNHV2WHI5TG5LUkZkdjFjRy85bC9qc1c1VVMvdTFpTkd0?=
 =?utf-8?B?NThJbnpidXdXQWcvUVNMV1BIeTAzN2k4WDlaY0J4UlVZNk1EWjNtTmljM3ZM?=
 =?utf-8?B?RFhZdlZLRXVHZE5TL0lOTXoxOWtDZWgrQzBrTDNMRzA0UWdCNkpEeVltSkta?=
 =?utf-8?B?WFdkMTRNYzNGQW1LeTMvZXFnOVhSNDRuM2N2ZTZYVUtKWG1lRWR4d2lpYm5v?=
 =?utf-8?B?VEdEK0dMZVdBVFNuVDY1dkU0Z1Uvc3QvRktQb3B6NGQxUEZsMGpBMTB4c3RI?=
 =?utf-8?B?NUN2K1k4TCtrTnZKcWl0TDVhS0R4aGRQZmI2VTJkTkhPR2wyd3FZTDMrd0Fu?=
 =?utf-8?B?UFpJMVE4a2k3eWVJNVdJT3BBeTRsR2RjSlROZ2VwK1I5VlhPMHUwdjk2bUNH?=
 =?utf-8?B?MXNwaFZpNjFpVW8zRElrV3h5NWJna25ib3pZdGYxVjdJNlpYSll5L2p2UDdC?=
 =?utf-8?B?U0RjUkhnQ05WZ3Z3WGdDdkVkOG9iM1FqYVhTWTROTzhxTkJlWkpvdlF5Sytz?=
 =?utf-8?B?emlKRG1EbXhJNStjaWpNSUZrRXFYWVJCMzVYejlqVVdRVVFxSExnUEs3Q1M2?=
 =?utf-8?B?K2gyc0dEOENjQUllSy8vNWVUUGhkTi9tQ1UxRGJLRDFjYklDbFB1VlpFRlNq?=
 =?utf-8?B?QmU0blQwWXc1Y1pzQ2VzbXc3WlRTMlFwRlNkekRsTVZBOXBaejc5RHV5Y2p3?=
 =?utf-8?B?RHZUcyt6VjFkbVY1cDZXZmNuY2FUeEtLV0ZXWmZ4TytRclVocWg3Wk1KL0sr?=
 =?utf-8?B?VEpzQzJ4QXdlRCtONFI3QWtuZXBFMTNzdVlTVi9VUm9ETmRvK3ZmMnZ5dlpm?=
 =?utf-8?B?TVNPMGx3aFB0RzJYYWZhQ2t5M2FYQ1lOZm8vT1d5SUZVUENpSldoZ0R5R0hk?=
 =?utf-8?B?THR4M3U5YnNBNlFqWDNQVDBsY3Z2YUJ5Skk3bW83Zm1hellnTjZuN0JiVlRk?=
 =?utf-8?B?dFlSenlLcVFiQ3ZWOFdiTi9kT041bXZLVUpITkNTTUlLVUdDZjFDdmRQdEVU?=
 =?utf-8?B?ZnZGQVRTa3lQNlV3MCt2cGRtaWRxVStGeFhiR3pERllwbTU2aU5LVjlEaU9E?=
 =?utf-8?B?bmZQRDVtWE1tM0dBZHpYODJXdnZxY2hUQitNOVhESzFvRUsvVGRiWUxoUm9i?=
 =?utf-8?B?NXE3R2ZsSkJPUHZqWDZBM1o5amtlSHAwTk1tUHZacHFKL2t3N3pmY0JNUmFj?=
 =?utf-8?B?endBTUF2blpyL05jTGpkcVJHUDJ6RlBCODUyMWdtZFZNeTYyZitIaytzZ3h5?=
 =?utf-8?B?aTFUb0plZVFHS1h5ckx3ZTc0V050QU1neitGL1YwdVlhN1Q4djB2TFRKZUJE?=
 =?utf-8?B?UC9jSmhvUVl0QUJMN1hMSEV3dk1BcnBpajhGRWgrc0IvZjgvSUlaQTBvTlkv?=
 =?utf-8?B?V1NuQkdmMzJZSHpZTmVjYXF0WG0zWmlzQW9OeWpyWFRPdWtsTFdPaE81Y2dn?=
 =?utf-8?B?K0ZIaE5UYWxQQ1V6NEVMei9weDhEU0xNMnNYUzMzNzczOGtjS1RLN3hkdHZH?=
 =?utf-8?B?SUZmQjQrZSt0Y3hXRnZwVUhsWkpaQllDbmtLU0dhdzJ5ZDJoYkRMUWorTi9B?=
 =?utf-8?Q?jYr33fpbmgLZHe8B3qLCXCEC7du1K6mH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f7da0b-5ec6-488f-dd30-08da0c28af98
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 17:23:31.4810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2OqQSpNQj5QBI01QFoK2eO+D+7DYBQFlRYBa8QM/dD1hb7/QZm1di4LLiC6gfJYdG6vY7PCMG/9Phzsqkmnp9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3488
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



On 3/19/2022 9:29 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> 16.03.2022 12:25, Ashish Mhetre пишет:
>> diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
>> index 92f810c55b43..6f115436e344 100644
>> --- a/include/soc/tegra/mc.h
>> +++ b/include/soc/tegra/mc.h
>> @@ -203,6 +203,8 @@ struct tegra_mc_soc {
>>        const struct tegra_smmu_soc *smmu;
>>
>>        u32 intmask;
>> +     u32 int_channel_mask;
> 
> ch_intmask
> 
Okay, I will update,

>> +     bool has_addr_hi_reg;
>>
>>        const struct tegra_mc_reset_ops *reset_ops;
>>        const struct tegra_mc_reset *resets;
>> @@ -210,6 +212,8 @@ struct tegra_mc_soc {
>>
>>        const struct tegra_mc_icc_ops *icc_ops;
>>        const struct tegra_mc_ops *ops;
>> +
>> +     int (*get_int_channel)(const struct tegra_mc *mc, int *mc_channel);
> 
> This should be a part of tegra_mc_ops.

tegra_mc_ops is common for T186, T194 and T234 i.e. all of them use
tegra186_mc_ops. get_int_channel function has to be differently
implemented for all of these SOCs. So I had put it in tegra_mc_soc.
