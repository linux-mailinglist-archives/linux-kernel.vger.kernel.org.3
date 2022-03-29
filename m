Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115434EA793
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 07:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbiC2F7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 01:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbiC2F7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 01:59:02 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AB223D588;
        Mon, 28 Mar 2022 22:57:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FsYcJTekQdvCM+tKyt0y1D+6yt1bmH/44iJXz8xQIps604tsxVzQIePz9WBcveqHGjEhNdGAmW414YPcsrZ0bo4pSfMLPjz92/idMGG7FadSE3rDCmSwatl3lDbbOLNJjUmqvxyv8BK215LfD+xx6tEDYlHHEdOnYGXa/Sy2wKchvj2aZ5xdtlh/pz4PiS2i3jOA4CZc1nsyzptY+XCyRDL4R8Q/7xmcE3hyk6N/Cb+r+8KMpyB7D4XwQjDL0v9QrX3Y7GHSyp5QC/SCG28t+QH2jIOQFXRVXAMM4jaZ0NsKW47gZY1IGB4fblAj4301fyK5PCXfkdzHM1ZarJf/Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFIsUgWz1SI+UcqsGUShhfM5AC1SAO3XSFh4T1BO+sE=;
 b=DdlEXPyh9Cs0S46Dz7jVtXKHa6kmM1hTrItGy62vnWNNnvnQP4eX24QqNpKgC/JBM5dvv//Y7R3RRfLxcLEezacSdNF3Uh/f99MX5XJ5HaE+CGpxaCCgNH+Xa6bjZRgxKO+W8MIwNYGOi/DpwHtFAQynErau6YeCGMxTKs65PAIxCmRW33EtDU+Pu6NoH8eIClCdK67NoXn9XQf28PXeTq8TcV7uAHnyGIlVCKooqQz8G9yIWNb+9knFf3T8Wz6oOMMnoXkzyCIkLCMW4jHMT5QtlD/p/PdB+QU+huUpFoQEiklenEJv9FPdHY0nyCWGFWS83X1cR88+iddm8eBIeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFIsUgWz1SI+UcqsGUShhfM5AC1SAO3XSFh4T1BO+sE=;
 b=222LlacGmZGMnqv3y1VWKD+cqwHeJfr+X7wez2Xd7Q5uitmAAM8HjhBsOzmk+LZ0vYWA9w5WPW5RWlO6VeW83cb8Fce8Ybknojn+hnlX2LbxSZH3QNrooukiqlmOzzhdTgB61nKDHW1E8P9lNwuEkcYWhLIVw+RPhHbxB8PvDNI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM5PR12MB1386.namprd12.prod.outlook.com (2603:10b6:3:77::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.19; Tue, 29 Mar 2022 05:57:17 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::38da:2ef6:d863:3c90]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::38da:2ef6:d863:3c90%6]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 05:57:17 +0000
Date:   Tue, 29 Mar 2022 13:56:56 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] cpufreq: amd-pstate: Add a module device table
Message-ID: <YkKfqFqmKWMUAvBF@amd.com>
References: <20220329015947.565-1-mario.limonciello@amd.com>
 <20220329015947.565-4-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329015947.565-4-mario.limonciello@amd.com>
X-ClientProxiedBy: HKAPR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:203:d0::12) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 940496fb-7846-4447-be3d-08da1148fae7
X-MS-TrafficTypeDiagnostic: DM5PR12MB1386:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB13866BBF8E5E119A77D68783EC1E9@DM5PR12MB1386.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yGZF6Ezozg2awwOu2tCbjBphqXCzvEEPSqvtVVxjboHkp2o+tFlycjKrVAeu6Ggv+z7AxkStgJCZWq0EKGYHxUqLFviWeum21+fgBiDlGH6j52/OBGV7lP4GExaqnL8c+RhmBS1yLIsbfCSC9FIM5a0yuClq4LncN8RBw+9+SR7DLCdYrBnK7Ir845tCEV9RrebGJL/2+EM4M5pASFNm+QwnF0qs9OSslwrQ5VvAZ/SRLtZw/UV6DAtyn6i1wuGm7AWEORRUTbmm8tMTYL82wp0mTLMW7799HPbGDWOAmLEte+kAvk0FFcdvSUECOeDXzL8+HvwDByGs06n8Yd1IESqfMyxzzVC+a3UWlKwvqImCuRbKxqsgwXyeYGsyFzVN9qihjfidyvYYreinVO/H4Rxk3l9pgnTJUPIGHUsjB7cNkIcRTUkKt/0M0Xsg6NfgsYfjxD9GqhlFrt6rVQGakmBTRI2orZaMRsFHnf0qaLwSc8yyeI28xT9Fs3UtD5xzDocg42vKH/lERReLJWCjw90Eui1nR8+bp+4cYgyU7aD9dY5srhWBa6ti7CW4dkok9aMXnJCGfOYC5ymb8Zr3CWqA7ruU8cOCdUDUKarYA6vO4ZP22shMzhie87bXpfClAL/i/MRnhgHPaXKJR2G59A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(6486002)(2616005)(36756003)(508600001)(26005)(6636002)(54906003)(186003)(316002)(37006003)(8676002)(6506007)(66476007)(83380400001)(2906002)(6862004)(38100700002)(66946007)(4326008)(5660300002)(66556008)(6512007)(86362001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e/AowTLuqDYogEaBCq+EJcLIQkxo2cjOtZ2cmupEUOTUlzMrPGA1V4Di+Wsq?=
 =?us-ascii?Q?1DJEsLsrsjBFpGp0/1k1vjJ/VvOtOxo8L3G8HHKn1R+l1UZvYYibR3/SJnDI?=
 =?us-ascii?Q?Vk6TA2yosIH8DxOsVEON3eZp/ALQ3vKuZ2dNGyIvZWcCfm9tNElwvvPEUxLl?=
 =?us-ascii?Q?AOtZC+5FOHAVZ4Z9s9ssHQbtQoOrQZKjrlETjm3PrQxpC6rsPXrRKq14ukSm?=
 =?us-ascii?Q?5p17MxQvje7Fcov6uuJi34M2p/6IwPezpN3u1+rCIgj8srveaU1L7kWP+W8c?=
 =?us-ascii?Q?slH7CKgiiu4/4Pe/d5/gGWms4RCDSXaN6x9yOgWKQUAvOJ0/ZbSatEuVJiYG?=
 =?us-ascii?Q?JCUpBlSQYvqdxE1Cx6Q9i8TzbseSYD6ya5zAzzW/NW2B8N/LddtuxRAiB4lr?=
 =?us-ascii?Q?j13vhgFwNo/FE+vpZgeoEnyTA6lsACPfUr+N5dzTLDTm2T/hXnGcwDyZJItH?=
 =?us-ascii?Q?WHyjJ7yxIRU9hyzYDG++rBvWGL9y7wioescNQ6DIajTFy+XpsZ/NHm9KGXoA?=
 =?us-ascii?Q?q4yiRTj6P6HAgK4a/zN9DXr4pvDoOVJ3ljL3PRAMB0X+k06lYLIxI3RKdF5R?=
 =?us-ascii?Q?oKEGULlCaTTHCbRc9MQCgpALcYG4iiHIJX+PoVldaCNrAD2bYfKmUio+0XHH?=
 =?us-ascii?Q?HLQLNW/zAaitttGpl0Q4DRqk+TmpOy+7mJLjOZURw0Qvx1COM1elnXZyuLfB?=
 =?us-ascii?Q?f5hFGhory/Nj3VtHJ+Uh1tbZrRAdQDJ7fnrwrW9WaVxvJpRdRcDumLJDvczP?=
 =?us-ascii?Q?wST8E4RaslN7G1+p4AyIZrRxME45f9Qq7QyBBzBNUo9QrVkqoThHYbH/35bN?=
 =?us-ascii?Q?BkBbLGXj6rgq/8YD+SOXSTFRnh9TmRD9CZqIo3TphEHPh+qLIG7LDQsitW6k?=
 =?us-ascii?Q?kBOW0TOBuNINmtEvvWS5TEU66qfVZbAlbtabCo520r9TJFEHoOPizY8dXHgC?=
 =?us-ascii?Q?hSAfECkESWn4rhXS3ZkKZk8EW3UAFWQRCf8UKcdxEJfbYbL2pEvFWTiFICrN?=
 =?us-ascii?Q?SAUQnelEAhgOpcrVNIMPROPkylz6/O3qagPrjv22O0TwaXVewoEhgsh92uaV?=
 =?us-ascii?Q?mwO8LPvImjsUqcd3cZR75cpqHAhK4Au179/Yl/lfX2yRjQHaGSK50EKtFPbV?=
 =?us-ascii?Q?TSYNJzXhlCenikG+zU1UISeuspfoW5S+W9R3ldWP1IvzFPSQvRsCIj6nSbW0?=
 =?us-ascii?Q?3sdEnuCUVp93pUDjvuYo0f+G7OFS+iHGURkPxxMf/NK4F1GRwYBs/0hSYNEq?=
 =?us-ascii?Q?93vH4KTiHCGszIpqrvlGGsVPLKeBeLUCkV1gFwzrqwwNzuG9Eltvexlc+UZJ?=
 =?us-ascii?Q?qcTgA2M7PdOUlgLhK6vHqE8MEWrcsPlNeH0gvdkHveyzrxz6E75siOu4OrB9?=
 =?us-ascii?Q?matybcOSgi2+RTMln92pULzwn3mpz1tJd/b3LJilRWyYek6JYgyhk8OZgP50?=
 =?us-ascii?Q?u8/j37M8qrD2GuvG/qA/06cixJxLzpN2z5MTLC3WIQz3s6pQUtKhmsCxOI1b?=
 =?us-ascii?Q?NgXv19xIrg5SirN4SeC7/KrcxX1B9itpy3Kz6NDCKGSq3LLWwDCxumP/LYP/?=
 =?us-ascii?Q?BllF7kb29yJnd7EnLZ2bzPLpMJThCZ5mi1Mo0jYdspOPc4pHxQ4+ZhKMwewy?=
 =?us-ascii?Q?BmUlMWR9ouXifaH3zvZMh6hS8buTFl1dAfmP3Yk0BDsam7LdXdOe77jNkLZH?=
 =?us-ascii?Q?LXQyiAMXcm3KqYsBwPAujlBKp4EFUyUfCb7XCG3kyq1VX1jeuZFOdfk+1Khg?=
 =?us-ascii?Q?ZlOQxmP8kQ=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 940496fb-7846-4447-be3d-08da1148fae7
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 05:57:17.3811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 47OWQanMnJF1NkpuqPNFXwz7UYyf0puU1sYztGglLPCRJCd007aYjT94fT4F3+iVTdx9Sm9akqgQ7zHstGMUEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1386
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 09:59:47AM +0800, Limonciello, Mario wrote:
> `amd-pstate` currently only loads automatically if compiled into the
> kernel.  To improve the usability, add a module device table that
> will load when AMD CPUs that support CPPC are detected.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
> v1->v2:
>  * Add comment to indicate need of SBIOS support.
> 
>  drivers/cpufreq/amd-pstate.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 7dc2e344f222..9f78849654e7 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -705,6 +705,17 @@ static void __exit amd_pstate_exit(void)
>  	amd_pstate_enable(false);
>  }
>  
> +/*
> + * This will only match the HW feature, there still needs to be appropriate
> + * SBIOS support, so it's possible that in such cases this causes a module
> + * load with -ENODEV as the result.
> + */
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
