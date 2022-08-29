Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394065A45F4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 11:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiH2JVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 05:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiH2JVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 05:21:08 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3C954CAC;
        Mon, 29 Aug 2022 02:21:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0lqCtAua1wSq9PpVPTCxkifA8E5reghOd+IRG9wNAOqmpb4E2Ns/HFbhtOTTNWn410Bu97hckCqJCceKMJM9+MPbqaJkXIS1PTjyfWI3T9E3D2YWPwRln+BrjrROUvINMntsgOaidqhZucwFsWmJHXZp9sPC18xMhBW380JCQCwF5FvluNdSHZ0tG7rdFlEcuAA2wlf9xHYxTuHWZnEkkKC1N2cUBmfW1AIW0yFwPAOmygGwSZ5T92oM3X9ALYR40o9hn32dwpGe9Zjrqvcr3HEe3sAsJH99AN2aSMCPfWInkE3/rj4ffZO+9FAE+mtSfhWXJThctRW/xU0Jh0DpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2mMQHV4zfxseO6vW48cEkZwrkilUJnqLxwiiYc9og0=;
 b=e6O2KBeBA7e3SDHQc6CNiNyFt29pgTJsqfzuC8dSLJ3HjUpDrY4Dpabb1ff6lQAj+QG8CAzcQdJNJ5kpw1AJFg3/HZks3m0JujFiVazIKaJwWUqZ3RP2TICdLRFPOhwkM4gEjFfIwxkiLFV48FHERiMQfQ8LzXn4rCAZgNZKz2ve6soVb7Iz7EfPMc7aHgMwSw0ZDsmvpo0qelxhV1K9I5vM0Z8vD7S9/vKN1jY0q34cvqCoyYdvk+jS02LeJ2y+TsudHSRfmkK+z70ar+VX5cshvD+Me/RJ0I/xfwVg88FyAIaeBiyNrQZu653T1eIA3rkA+ZipgG3tE4bRtfDu/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2mMQHV4zfxseO6vW48cEkZwrkilUJnqLxwiiYc9og0=;
 b=KnoSYeRwmsdCdBqgfDvH8LooQvH/4sDNh1p+Pxdr8bgNqrKdu/PLlZtpX+VPooRU8cWkpCulNhhXwghXrW/KYvZYYwRI86q66bCXyf1W6nTGoJyMVbCkoaUz0Kk68ZE3mpw+scyRGFm7cGViNVE9/xnkg40rtxhjdsSCq2+0Jxs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 MN0PR12MB6269.namprd12.prod.outlook.com (2603:10b6:208:3c3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 09:21:04 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::cfb:b63:3255:646c]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::cfb:b63:3255:646c%5]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 09:21:04 +0000
Date:   Mon, 29 Aug 2022 17:20:37 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>
Cc:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cpufreq: amd_pstate: Fix initial highest_perf value
Message-ID: <YwyE5UygDEhfPDVY@amd.com>
References: <20220829055901.24593-1-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829055901.24593-1-Perry.Yuan@amd.com>
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 515891fd-c9b5-4681-f82c-08da899fcc4d
X-MS-TrafficTypeDiagnostic: MN0PR12MB6269:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F3wxPSyxnJlBsdxqb1MIryxSENzp8OillI/lwU2bXM2S+glL6kLjYgfDshuA1OYStKg5cmsum4poZHNwQWIfThjOvBMYdwaayX35TRwcNkPCyDqZFAZvmPqmntJz58r6qJa7COel0OYXYgV6yaFCbJEDsa3mowBaJM5SpnUedLxIeNWM6PpbGWdNDQPwcBvOM47IwQzJLxeokXT/ILShyXzoNlzlytxAVUaVE3rBfUiAo0wRTPiVBIlQFNmzSFgaJ1diJgz3b2/2om1FdZpRjQZbHhxcYJ36CFmrrjHoPDUoMXvhtaDdlSG0T+2A2ByPq4Od77XvpZkUh+4jqLae7n7cq+Zq0P8UcezpvmugvkuQ8dEjkpaIdCI80uHl+XWot30sytsz04PULBzzTgsRbLsislOeTbnZL2whoczODrpt1djvYCNA1b2Xxltbv21nBB+ABrtBvuU6GzOFHkN/21rPsR5AOLvFl3RkrAJCfAG2MnTNDpMIDNc/d8+fdtbItXWz5joxU9fo5hA4A+M54GvYrhnYuuCH4Xl9IlCvT8chaVNX4ui/u0zeVu6sBmw3ATELS10xu2yJTM0onLEMWBMsaI4lQCgIivZ24YNrH2TEsrWuPzAXODE2eN143VO8ljuDwflmzXXOxTOInbTftFY1B9Uel2EchyO2ov/zL1SPGPQLfgEjQELyP6PndhDDGDdZfeoWW9PDAdOrtDUPrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(5660300002)(6666004)(41300700001)(6506007)(66946007)(66476007)(66556008)(8676002)(4326008)(478600001)(6486002)(8936002)(6862004)(86362001)(83380400001)(186003)(6512007)(26005)(2906002)(38100700002)(36756003)(316002)(54906003)(37006003)(6636002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pyNOE/2CFwP351mYsZpiyQ+RRkc97gWBX3hQ/SnVyK2IMxTiBXuiKEhuqsxD?=
 =?us-ascii?Q?2yx/ShlGbsjpCnnVjqduoJ/ybJsxxttC4Md7258zpDAzaCyBXrztJlBvps8Y?=
 =?us-ascii?Q?BnWzeX+MzbGa1NwCnzfQE1yuD4M58GY9VuinnYigAPtDKPM6L7Z0+37l0OKP?=
 =?us-ascii?Q?Ck9cfne+jzDtOcRZxkf6quj4zVZHS0Dbxkj87AUwyi8M7+oHrNhXzq25QupV?=
 =?us-ascii?Q?tE5JYpVL3V9p8bkhn255dbotE+ON5A81DKDXMetyczrrownDUP9DOefq2NF0?=
 =?us-ascii?Q?YdzoOYc2otfn2hVPly36QJ/L3Td+Vu2AHcZqlr1UycOOnNcPExbZblRiSGL6?=
 =?us-ascii?Q?6XMyTWX1EfamJ918jhNn95mPf0zrdiAzHTRpBDhdB0uC97l+Q5VUDr2uKcjj?=
 =?us-ascii?Q?zs6gbw+1GmApfP6a+ZXvtchcQurTa9ccZF6rXj7c9Q4mrduu+BYW5BpIynZu?=
 =?us-ascii?Q?bZ9P+LinpzyYfnXJTgYcFX5shqWWsANpXlnyeCZlKecjYP73Wn5Ydf5NhJbB?=
 =?us-ascii?Q?TPCRYqaUxDzG0SUSM28JuLMPHnbpS4iaQnYSs7MqFLvwoVzKYFeM79jO9JA8?=
 =?us-ascii?Q?b9oD49MmEm36mXVfFua35cn3uJ1rL2M/Kc6J7XN89N9fhKxmwVR47a4c7V6i?=
 =?us-ascii?Q?e1+TBisVKynCWEN5BRJ5LVLVdMmrzT2n1uapFk1VaH0AEVyv4ZsQqbiroHtV?=
 =?us-ascii?Q?Nl8eN7Kd9+dL10WnO8EJrr3n2Or237K0lvWIBmTLvHT73pjOY7KIlgk/wrUE?=
 =?us-ascii?Q?3Go7rOuA36OdwHpC/mvB87BJIZ6WxodDB0U7hln8/eCh31g1vt/mOy2JrjWQ?=
 =?us-ascii?Q?ybnlQr9Jw8GCJ7vHUXZmGhiAEVckV0EPc6+EIL6Gs0P8x5Sq5QDuSY1BUiUr?=
 =?us-ascii?Q?xQzWL2GbT9YOUWpLtYyakw6mZPVDlDHp4Dlxys3kovN3bkZYjKoJT2tdKUBi?=
 =?us-ascii?Q?2ajZ2LSDXzbjZHpcFy9OsJHyHbVKDtZDDD+xEG8oKBJJ26MfOvBstaUOoczZ?=
 =?us-ascii?Q?2uVpQgxwMuxpFrovpHMPAqAglmlE4wkkQ8MvyE7uxS/yzpcf+mffgxGPhOPA?=
 =?us-ascii?Q?jBH8uThyF0Rc/VHQaPdTVzYEt7RPmJrd48mTv3vXhpbOmByjE8npEjTdOnS6?=
 =?us-ascii?Q?7D/GpFcPAfyxBfOiPCk8+jNKQac5D7ezbNQ36FbO7uJhpUU0Fc3DgUdL90vf?=
 =?us-ascii?Q?AXaUiVEFsXgpWx4/Wr8rjBnZoK0NCQe41X/pzyagCWkXb4+/sjrzCpZ1gyUP?=
 =?us-ascii?Q?itBXr9bv29HeNsgiDsp7e0iQb06cDrUGIfVAjft489esXXk/EgyhMiOEyNpS?=
 =?us-ascii?Q?W3ziVDaa+9KDGBWBvpsJ4XAybPlVeUdsKtYthYvxzV1x1tWclmMUEFfCniWm?=
 =?us-ascii?Q?XYPE/2pV+QnxF/UQiHDRlH9+j6RD3jThTkzhZHedbNTMLBZEmHliZWDVOA3B?=
 =?us-ascii?Q?3SohhO3fG8FWzclhtVWE1lk+nqLqjiu4r+WxYxYMQ0/CrFjz9+SWCt7sYSHp?=
 =?us-ascii?Q?hmudjHmEG2gz04GobyD1oQ4bd1+G55pbTCqx7k0GFwZ3eXWWKfXx94XPYCGp?=
 =?us-ascii?Q?TzWC5XfaP+t+eaZbx7HmkYG3/iUV8lbjrLj9dGS6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 515891fd-c9b5-4681-f82c-08da899fcc4d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 09:21:04.8376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VWyT/5QiTToBSibjtA1vhB1i3o+9bO+s6QWXe0jWrZCILo2wauZHKdpvByCcYe430LXIsANRi/Jt4J7eNZUvdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6269
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 01:59:01PM +0800, Yuan, Perry wrote:
> To avoid some new AMD processors use wrong highest perf when amd pstate
> driver loaded, this fix will query the highest perf from MSR register
> MSR_AMD_CPPC_CAP1 and cppc_acpi interface firstly, then compare with the
> highest perf value got by calling amd_get_highest_perf() function.
> 
> The lower value will be the correct highest perf we need to use.
> Otherwise the CPU max MHz will be incorrect if the
> amd_get_highest_perf() did not cover the new process family and model ID.
> 
> Like this lscpu info, the max frequency is incorrect.
> 
> Vendor ID:               AuthenticAMD
>     Socket(s):           1
>     Stepping:            2
>     CPU max MHz:         5410.0000
>     CPU min MHz:         400.0000
>     BogoMIPS:            5600.54
> 
> Fixes: 3743d55b289c2 (x86, sched: Fix the AMD CPPC maximum performance value on certain AMD Ryzen generations)
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/cpufreq/amd-pstate.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9f4375f7ab46..30fbd30c0949 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -354,6 +354,7 @@ static inline int amd_pstate_enable(bool enable)
>  static int pstate_init_perf(struct amd_cpudata *cpudata)
>  {
>  	u64 cap1;
> +	u32 highest_perf;
>  
>  	int ret = rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
>  				     &cap1);
> @@ -365,7 +366,11 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
>  	 *
>  	 * CPPC entry doesn't indicate the highest performance in some ASICs.
>  	 */
> -	WRITE_ONCE(cpudata->highest_perf, amd_get_highest_perf());
> +	highest_perf = amd_get_highest_perf();
> +	if (highest_perf > AMD_CPPC_HIGHEST_PERF(cap1))
> +		highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
> +
> +	WRITE_ONCE(cpudata->highest_perf, highest_perf);
>  
>  	WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
>  	WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(cap1));
> @@ -377,12 +382,17 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
>  static int cppc_init_perf(struct amd_cpudata *cpudata)
>  {
>  	struct cppc_perf_caps cppc_perf;
> +	u32 highest_perf;
>  
>  	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>  	if (ret)
>  		return ret;
>  
> -	WRITE_ONCE(cpudata->highest_perf, amd_get_highest_perf());
> +	highest_perf = amd_get_highest_perf();
> +	if (highest_perf > cppc_perf.highest_perf)
> +		highest_perf = cppc_perf.highest_perf;
> +
> +	WRITE_ONCE(cpudata->highest_perf, highest_perf);
>  
>  	WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
>  	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
> -- 
> 2.34.1
> 
