Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D0C511A54
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238622AbiD0OtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238590AbiD0Osz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:48:55 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C3F38188;
        Wed, 27 Apr 2022 07:45:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lk3xp+p1YJbNc5EktM6zbTxqrgrY6JOnEWBQTHV5AWs38CQNa9gRzc50WcxuzhadnTlxiRWd6n2Jsv7k/fYnB+8ZvMWFRuMv5IliOEkw27MXPNJJpcFaMJivrN0+Ygyea+Bqk4/o5lpQU6p/i2Vdh+pcIAr1X4gmGGnJEfggcOCt2319wmfvNUs5VioxYczFvOh6xeArHKGijyAkwLv3OqFTBn03sKbGp7glOA6zltj1cB6DKZYRi0JtUxXcnAPuHhGBMKggEB4whl579zN59FlIZT8ZcUTTkcQgkwICwwjQfFcYvJkCZzjOXFv1RBnunce3/vQpUWUAFVNXVDiYnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KL9RiE3+3WKVAnM6cysIfXopOKj5XfCX33JCXD4t1o=;
 b=HuSIT7VMva7U3CNFeib3NpbEEqexFqGymlkTI8QHckoQ+GeHe+79+BanFgoQLTN7mL3bXw4+OK8RE6n4J+mxDPMG9cX+81jMF7wniLhKgoSoKHTVd57BmxQ4vdayT7uYrS4XFrMWACSf/U+aOwKbD9vKcrcRPojtWWy24Yj95G6GtAkQGdR23fGgytVeT4tjLoMWQvU5DVpkFqras70VEkoYKJF8kxr2jqmfYxXvYw6hGcfUuOEnoOjl/H8IGw5mJCB0EqG59/QCudxgFmA/CXr5nVZW41w8M3cE0qT589e9aPJsdm+UclMjY3qbg8xoR5CZ3rnAedcgrhVeyiiWYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KL9RiE3+3WKVAnM6cysIfXopOKj5XfCX33JCXD4t1o=;
 b=RAeBN0b9Fze06tHFv8hF6Y9XiqGLZpIcZrbhIg7zHP3lf+rr6CYtlNr39Yxq5Gr/V7dTJRYuZPJUV321HqwgsxJpuPvWX3HVhNACY+TmCRnf48/m3ht0FVM3YjXQwsBV4+rpgQT8bo9Dq7qWx//nVOmn/igOZE0GUtDo6LA+eAc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BL0PR12MB2337.namprd12.prod.outlook.com (2603:10b6:207:45::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Wed, 27 Apr 2022 14:45:36 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::b846:d865:5901:f76d]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::b846:d865:5901:f76d%7]) with mapi id 15.20.5206.013; Wed, 27 Apr 2022
 14:45:36 +0000
Date:   Wed, 27 Apr 2022 22:45:14 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/6] cpufreq: amd-pstate: Move cpufreq driver check
 later
Message-ID: <YmlW+pW41WBf0vu8@amd.com>
References: <20220414164801.1051-1-mario.limonciello@amd.com>
 <20220414164801.1051-4-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414164801.1051-4-mario.limonciello@amd.com>
X-ClientProxiedBy: HKAPR04CA0005.apcprd04.prod.outlook.com
 (2603:1096:203:d0::15) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 676a6e63-ac69-4299-a381-08da285c9675
X-MS-TrafficTypeDiagnostic: BL0PR12MB2337:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2337ED5D7E88DFD7F8B3F2F2ECFA9@BL0PR12MB2337.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UdZd/cEPg0ksUOB74s7TmijTunCu1LM0cfJdVzxY/KApHW+O+QSR2zitlGWb7atwzQV6CqlOJLNYLXxFY+vRKtzTb/VVMX56lm1Mp2dQkJ2BR88ZgOBGV1OkyN4o/iRUcnVu2vMgn4UAk9GG56qHMY4NodvcwgwojP3aBVGlkynV+ZmWZeXmc9T1R3sZclaFDMlOaDN3qxDOPIMbd+LFgDIlFsDGcqNtyi3dxG6UpgyLUtlNvGLHgjM3FWqT6jHVQalg0NsGbDgPcE7GQXNdau816JNtapToavlyngvJPYS8NwE1lA2yQTJUwiES5gEqDiq9cCu26PSciRTlbVAkVj+EjoexF6U1qlkB0u/WLSNbGmS31Li6E0Fv7uJzVCYXcj6IwknrhF/JpbJBTVMn4ry7/x6K+W9p2tTTHdARJR2NpZLAPIzMMk8CtsY880N2ROZPwJHZ1lFLXgiUzI7IQBMtlBZmF2tIWtn+xML7umV5jqRl1K2YfRP8ZpAweadNV9/WdsECCEwGfIx7U4jRjoEX9UwWg0CrZqMgGwGUEa/3Do2EZVZbIbMRhzr76XGXAPEfuuqgwTDS+LEWgXIJiY3jrG1obLxr/QZEdVK6YDjs+ftcfke9ZFh3suBftCTHwPv96C+ZdIdNPVvE8AbH4FRqOsQyAR+aXzASZge5Q/6/FcXbgkv49zGsVekLes2lRGa6jZa/Uhf54hVuE5gPLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(508600001)(2616005)(86362001)(6512007)(26005)(6506007)(6666004)(38100700002)(186003)(66476007)(316002)(2906002)(66946007)(66556008)(36756003)(5660300002)(8936002)(54906003)(37006003)(4326008)(6636002)(83380400001)(6862004)(8676002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CBpzaRHXaqJ+YRgBQhQ4mFLdXgtREANSwDZUwne5jZSs/709ujrpXNe+pVBf?=
 =?us-ascii?Q?q3q6O+9Xs77qBClT4Ihp6CLeT9NZ+Lsii1DRiIuzf/YEqObLuOxParvKFMu1?=
 =?us-ascii?Q?axxpipTmk4M5cEtT4FDJs0HGwct5sBL1r7Yie36Z4BQ9IgGfbbf0caCq0hid?=
 =?us-ascii?Q?IsxGedthM3jSMnB/aM6vbDoJrmjlXqDapu1N8hmtthQY+3erdAJ8977gYEHm?=
 =?us-ascii?Q?1OEGLJpbOHRy7leQEwInpO2DFqPpPwTk8cCISzP0iB1vEwqomyl0VOk3BE09?=
 =?us-ascii?Q?6EWMqDs8SoXyeYBaw5VmQFoH2jsJo+kWSSaaAndHtRod+TH7lENSSMFbnTNB?=
 =?us-ascii?Q?Cz6p2C08kroOVjQDaJFkj6HqaEjwM2e6gPgy5MfSwH9TaWH54yCRSRbJL6Wi?=
 =?us-ascii?Q?Hp3gIUwZCKPv0t5m7xLVK3djBQ+anxX4E/puJ6Z6nxf8O5kgPjTmFCl1Zn1p?=
 =?us-ascii?Q?qqyfRt/CZ2IjIB9Fo3MxsysHj/C4JZC0inGpM4M4/hEkx6in/UjVdOzVrkLa?=
 =?us-ascii?Q?Qi8hM+xtGSDAnmgACBF9mI5vpvj2Pgh9scQg19HkWHQI/9w6vW+pEV9y6G3Z?=
 =?us-ascii?Q?DJW0Rv4o9S8juH0ojEZGfxd5yubEQy8E+TAqq8v3lUmW1UfQvwM5r0Seyt5U?=
 =?us-ascii?Q?BZP87wv3ZEwULcS+/X3nOSaJIiDLFLeAhlpsnXNmZAEeo2T3xbDGibOyaEej?=
 =?us-ascii?Q?UycJj2i1o0Hl/RyFGltVZP+ZpsO3z3tB6r5LiP01hjKJZGgpixNrw5vpz9Nf?=
 =?us-ascii?Q?9mz7SrotMy0Btq8JFOvTDvM/M14KuNebrdmLoYnNLZUkXxVkFSUzCqSZns0E?=
 =?us-ascii?Q?0bV0371PTIijvYqKX0bpTz4pDNexfkgotWP3iIDRrE9fQtGz0IqHAqrtXXoj?=
 =?us-ascii?Q?oXo8Q2nEgYUEiyiA6ZG9Pnz9lcr3GQHw+0r1tkrtr39J70lK+5qP3wrAG+qh?=
 =?us-ascii?Q?/W1vLOULxbXUm3cvfoVJ2E++7V0NgssljC/Bp6IvlIVmZG+cp5g2LrOL/GNu?=
 =?us-ascii?Q?yvaW+hsrPGidYYJJVWdRnAnAvxkfGo5qKVUULIb/JVEgGvs5VDXvH962CcZE?=
 =?us-ascii?Q?9qRnG9Q93qie41hYrhfceiToRNkLZT4+4j7skpk3U5M7L743d1LBBPMChYUa?=
 =?us-ascii?Q?goBGviuB12lz+yj4VID+1dX4P4Jwk9VCd1UWmiSP1Rk5uJ1I2AstEGmnq6aG?=
 =?us-ascii?Q?jW+jUbc2kNg/Gyw44a9dp2S56ABqSsNlVp5vAigU4gy9walh9ed5ROgLl2/w?=
 =?us-ascii?Q?Oc85sweaUzEErau8NOf/zBbtJTDnBT6xuL0p7GS7TKbkOmUUM/KsPJKEHE7m?=
 =?us-ascii?Q?moPja3WkUs90sknNKgheAjlBW2sbet7v3g/aJqZmw1oAHRGnWk7xtqXMhrmJ?=
 =?us-ascii?Q?pQG/ufGPe6FxyET/lZKkTKIgG6oEJuQruvVw7w1iZ4a0pAKEvDuEbErJJNfD?=
 =?us-ascii?Q?yBiEvJJtdls/cUbCONuoawRHFTaD5r4X6ZADy5f1IwzXPY0Vd0HfzwJIkhEP?=
 =?us-ascii?Q?ZHNNtLc8vDEJ0Hjwb48ioUjJNSB5oyyW8D+K7lkiQc+3gacrhqv1EggyDuMM?=
 =?us-ascii?Q?+oL5pV+Do8GP6E4W79mB1LzrVoz3apRfVniUAgaYhCpfcvJHnH+xH7q0QPiF?=
 =?us-ascii?Q?O6pCJUSEoolb2ReAdDWrAzFKBP/Ye1Pkr62ZN+MSidpee+sTNUkNoPtubGh2?=
 =?us-ascii?Q?u+oydfr1BanfaPbLgUrhn0nfaGwg6PIBspmZFugXEO5H3JHUiASD0WGaLTOk?=
 =?us-ascii?Q?t99Vp4+3Tg=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 676a6e63-ac69-4299-a381-08da285c9675
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 14:45:36.0552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SzaEDaeS8rlla7TnHHuPvrYofp3Gx11zuk03hMfpDP1o32X/O6+9RdGY/yh7vgMHIt1qaOPCMHXWA03DyAoa7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2337
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 12:47:58AM +0800, Limonciello, Mario wrote:
> The cpufreq driver check occurs before we verify if the CPU is supported.
> 
> Depending upon module load order, this may mean that users are never
> notified they can enable the shared memory solution.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
> v2->v3:
>  * New patch
> 
>  drivers/cpufreq/amd-pstate.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index ecd1fd5e5b5a..d323f3e3888c 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -653,10 +653,6 @@ static int __init amd_pstate_init(void)
>  		return -ENODEV;
>  	}
>  
> -	/* don't keep reloading if cpufreq_driver exists */
> -	if (cpufreq_get_current_driver())
> -		return -EEXIST;
> -
>  	/* capability check */
>  	if (boot_cpu_has(X86_FEATURE_CPPC)) {
>  		pr_debug("AMD CPPC MSR based functionality is supported\n");
> @@ -670,6 +666,10 @@ static int __init amd_pstate_init(void)
>  		return -ENODEV;
>  	}
>  
> +	/* don't keep reloading if cpufreq_driver exists */
> +	if (cpufreq_get_current_driver())
> +		return -EEXIST;
> +
>  	/* enable amd pstate feature */
>  	ret = amd_pstate_enable(true);
>  	if (ret) {
> -- 
> 2.34.1
> 
