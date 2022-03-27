Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B99A4E87DF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 15:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbiC0N3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 09:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbiC0N33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 09:29:29 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7846A36E28;
        Sun, 27 Mar 2022 06:27:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLLH6yYx/+gGAcndC3K1aS96b0rk2M/4aPP22eYbPDF4UM9au54lUrFkFs+Oh2swvycU2v5tKWBq3FBDvsJWHZbQFsMk9jh3gffL8HiST09k7wui97FR5IndFeB4lJN3oOBmtkJaIMv/n2tMkTrEJ/VSRGS4Rl1BzaWxEZeGiI/2mQlCCGI2YgzTAs3s1lJ9PktGg5uOX33vJn5By7lDIf7yaX2hgmJR7GuMX1OrQL5n3BB8oH9ov7x/VGj/wioRXNVlydqWqmYEXvGbktp8ZzV6bZBDw4+JVByXoSf/MEzlMcuZSwDzGabqG7JcG8Wypac9hCSqUn1e1RJmTAA1lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYAhaGy6ULD9sa0Gb7f6cuZNJgxN5ur+V0MZTVJc6KE=;
 b=IflmRhMtiv48DBjJeOCWO5NP7uqHHXkUXr8siP9n8612ahTdrt3X56JZS+apSn850XdOd0neaXZVT+xxU7UoW31y6bTjqu8wwYQ/Wn+jiW5zomVaRIZ65weOHkajw3A7JIthn63c4fOwn7leNKn1ksrvwwlGcZtZt6wNbSxLmGv1jvesqVVhen3/XsP0bt4tkz5njWIfxsikZQYtzyy7I1xj6JrlIA6Mv/jU8KYPVJ7DLkQpQ486D/DJl0p/LF7x1Ss9T1Nj34NcgE5LLTe/iYOuQdlPl2a3tT63Ksdcti3EoGqvHrcgIH0tg6EsW2g0ObiIi+r5kdBQdQTeiff05g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYAhaGy6ULD9sa0Gb7f6cuZNJgxN5ur+V0MZTVJc6KE=;
 b=eMCTIlC0+moaEx5xPQueZFH2wa48ilxkKWtRto8gTh+RVzL6PHnUxp2lBTNsqtYlx/SbX7HlHjdSSUX8nWwPLhwaxahfUK7poSKp92PzR7nEMJphoVd7MWLSYpPrbuksix6OfUk/xqR/lztohTJM3aYdPLUmZJaYKgULi0YLRqc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BYAPR12MB2853.namprd12.prod.outlook.com (2603:10b6:a03:13a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Sun, 27 Mar
 2022 13:27:48 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::38da:2ef6:d863:3c90]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::38da:2ef6:d863:3c90%6]) with mapi id 15.20.5102.022; Sun, 27 Mar 2022
 13:27:48 +0000
Date:   Sun, 27 Mar 2022 21:27:28 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] cpufreq: amd-pstate: Add a module device table
Message-ID: <YkBmQCWnM3T53fEr@amd.com>
References: <20220325054228.5247-1-mario.limonciello@amd.com>
 <20220325054228.5247-4-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325054228.5247-4-mario.limonciello@amd.com>
X-ClientProxiedBy: HK2PR02CA0139.apcprd02.prod.outlook.com
 (2603:1096:202:16::23) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9eac4fa-e4d2-4df1-6b7a-08da0ff595b4
X-MS-TrafficTypeDiagnostic: BYAPR12MB2853:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2853E81591398FA9F03597CFEC1C9@BYAPR12MB2853.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xkYNV75gjzsfQUx2TsQYwEL0mwSNrzgffTi+tEr9bPsJD1RkXqaTY7uqs+ee/16PyNvhwCd0WxiKd2oIjI+7DdhkZYG72+EG9a2CuziJRkKJEc6UHzXxbuBqET+gvrKyVoRORvmC0Z1tHmhUUsQziaLq/tVq6gnckNYBY7ztoCJXGr28AVjenxjj7j1QwW8RIlx8q8EhW0CGdrjI7v7jBqoE32th+yc0wWVZD7mTW+hwpuox+bRnHdCKi1LG45c6wLbPzc6B0fbG9pQmajivYiIrJCJ8CYkB/XJVNztJasLTVg8rT6ZSgKbBqCbcl7rsceF5RoPZYh8dV4TLet9HnrCTXSt1vfGGZaobcr1uGbw51RhuYwhzg9wgQfRuvAB2yBnQRxa5k7gOBaMzk1c4nBFTCNEjVsm/2TZ3/gdkZDwCNl1MknfiUpEc4WyOi016+odAtBVxXUuFZ6XFEOMcGlZcBOwqsPTDQcCF0tTurV0rwkv1klr4F9PYN/JYshfkr9oaAQd1xxQl7yhqyfEEreH2saRasbd66MeIdp7k7wId1dkFnFoLaMVvINtOiiCAB4KMXKA9EvVpDDhCO9CksxH0a80lzoXh89qhK+ACTG2WOO7oLLxqpGjJ73GOzJ6SHkmwm9sjF1dFWhOV3eUoOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(83380400001)(6862004)(37006003)(66946007)(54906003)(66476007)(66556008)(8676002)(508600001)(6636002)(86362001)(36756003)(4326008)(5660300002)(26005)(186003)(6506007)(316002)(6512007)(6666004)(8936002)(2906002)(38100700002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1nGFzppxoWwiMMBUrADPh5UJ6CsJlCaiwIgMtAqNmhRBVqcdRIxy20CvxzZq?=
 =?us-ascii?Q?yl/5Xr34IePUZUNC7GNqFeZycx1xUm27gF1o7RxT++fzrYGD/K+oufi76kYv?=
 =?us-ascii?Q?Rr+DGSRGBBD58cXNBItc5UE4Md38zaGgJdPWBWfRwoDffvSy2BAbJmZx5UX2?=
 =?us-ascii?Q?kmspmV/iG25Kck+xuNwHxeQuoW8MweaBsjWlyYW1ohRwEtzeOMCLkjYmHmay?=
 =?us-ascii?Q?8MXHXLYHFz1lGxCl0S7z81ST7qxWV9nghvr5f4hwQ9nRqeGetHY6gpAJRxNS?=
 =?us-ascii?Q?B0CkYY3Z5V0lfWmCBjd+N4zbQfrxt87mBZEbpy+hHoqE/D1wyDcFscmqcaXg?=
 =?us-ascii?Q?mwbYCOzwyDMcrLVgp10+aB+jE8YmozfMsoWmusI1n+eAG4rSNbc6eg18Z2s1?=
 =?us-ascii?Q?65dWVmLVnr1hrhMj/XvbooQmkXFJ3RLDY4umHx3cB1J4/W23TIf2IQb2nXB1?=
 =?us-ascii?Q?2HbPK6KUUFHs1YsCm1jwxL6EflMDNUSpmVO9kLDvEO2biTrPtrvdVZ0yHuMh?=
 =?us-ascii?Q?rPHXvADB/WACkr7wU6Dmn7uE92fzJrxadGkt4ycx3TK2S9529Kk47ZT3zYta?=
 =?us-ascii?Q?fNp65fj8z13bh81TlyGxItcmJKy3TQrcc/zirmJDPkaLr0gXjPn2+hYSTPXt?=
 =?us-ascii?Q?sv+J64SQGjlN9/bRYXTEGgnShlL16gNqrByRNLJDX0tfiH94U94ATdquzGA+?=
 =?us-ascii?Q?ohN0V216qEsN8HGORNEOe5XPRLJA3k3jvF8p2tkOpAbJ4ScGAxi6Y8AivJfD?=
 =?us-ascii?Q?XueW+x88lhTEeRVejjt/58EEZotNPVZTf/KNU21oOYpyD/ru7jCcxy+A0W86?=
 =?us-ascii?Q?LaloXxpE/HO+o1/gSE0vTjermwzOG32l/et0a64KPAa/6PpV0WzctKw+/iYq?=
 =?us-ascii?Q?fBaFE0hCwAaAnAhoh6rl6R9eHslH8DMV+qtSdnyDsjtijCSJhY26yTtKZlAD?=
 =?us-ascii?Q?W3sPwrPA5075Cps6mr9UPc2VMG7nP6SThEMTtTivRdmXDhy8h6NEi8AtyoJY?=
 =?us-ascii?Q?SaZCQNNtccYP/f530ln/DbuzzqcMe626L8maVZZexyJcOjQ/PSd4hPGCTZ2d?=
 =?us-ascii?Q?jPDDwWYjS3BzxwweSyYjny9N4uX0PrXYa+UJ2NfXm/Sgi9H1MP7PsrmPcBGw?=
 =?us-ascii?Q?Ltekp4splGTCfYaDZaFzx2ZaszaK5zV7aSxHqLxwISJks/zmxZZvSqCI38U0?=
 =?us-ascii?Q?16mxZrNjWx2i2Gr6pfNNM465R5KjL1ZVPvoEDjjWPxG0knD2QYc2gA2ZzoN/?=
 =?us-ascii?Q?3on5u3lBBA8nD/BtrixYuoTXIwfhfJqN0h7wG/jLElOBfGGnPL517wikjtHa?=
 =?us-ascii?Q?De2q/QasN5sZHqNfAngrTwYdbS98hY5KhhOPlcwpn432DVd9gyUfec+Y/Msw?=
 =?us-ascii?Q?pJWuSp3mAFtFrGr+ujUNm0B2Xmj/lxiPwUzU9Zmc66FdrF97J8H2jIVZc4Qa?=
 =?us-ascii?Q?M5cJR5UfeKvW3RUyqs06PTm8v6VnHCdHVLdr2Y4thtgZ447jWEV2BSdAkwm1?=
 =?us-ascii?Q?X/MTUWVIKOP35ViSO7xgYMBqPHsF1Flwv68yHKOfzCB5Cn64s2nJYn21XxQk?=
 =?us-ascii?Q?nPV78V7nVbYhURiD86CQ/ZxMZSpQ2Q/uYogXwMPT5/ajqsMy3QOZ+6Mj5Uty?=
 =?us-ascii?Q?owEuqj0i2c2R3TH5gJ+PyTQ7BgYZt4ga44qPyb8ma0JSyd4QCZ0xq4n7akrD?=
 =?us-ascii?Q?1PhxA+eKCmANjbZSe+vMl1qM0SPVTzNsmEkNQP40sUYD4Pn/SnRF5HsK9NIA?=
 =?us-ascii?Q?LKwrFCdsFQ=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9eac4fa-e4d2-4df1-6b7a-08da0ff595b4
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2022 13:27:48.0473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5GF7tJY+gblwc1vg3SPQOLl2ZVOdNk70GlN5PB2oOsclib8e7OaESZHGQlVC/E8iMCJ0NRilKPxaaWx5WDF/tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2853
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 01:42:28PM +0800, Limonciello, Mario wrote:
> `amd-pstate` currently only loads automatically if compiled into the
> kernel.  To improve the usability, add a module device table that
> will load when AMD CPUs that support CPPC are detected.
> 

There is one AMD semi-custom processor which has the CPPC feature flag, but
the SBIOS doesn't support _CPC objects.

Thanks,
Ray

> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 31a04e818195..44490292fa72 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -644,6 +644,12 @@ static void __exit amd_pstate_exit(void)
>  	amd_pstate_enable(false);
>  }
>  
> +static const struct x86_cpu_id __maybe_unused amd_pstate_ids[] = {
> +	X86_MATCH_VENDOR_FEATURE(AMD, X86_FEATURE_CPPC, NULL),
> +	{}
> +};
> +MODULE_DEVICE_TABLE(x86cpu, amd_pstate_ids);
> +
>  module_init(amd_pstate_init);
>  module_exit(amd_pstate_exit);
>  
> -- 
> 2.34.1
> 
