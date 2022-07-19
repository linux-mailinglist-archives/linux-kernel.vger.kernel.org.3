Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A25578F6E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 02:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbiGSAtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 20:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbiGSAtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 20:49:00 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2046.outbound.protection.outlook.com [40.107.101.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B0B27FDD;
        Mon, 18 Jul 2022 17:48:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=am6TVF9jQe6zR0PKP8OQMWKfnkyFieOEi9njJ1zpne7EH2GuiTKhVifWeSSIkFCAwursAE19AgOrQXEn+p1yWy0CWpGLWUq75lMFodokGyxTlTpVw+LnlYJd7Cb+q/7E4bGIpVaxtQAK5DaCv6rwe6Qh0yefqGaZyZm2ITE+i1XitBF7mp3/6WGUylyAWgqzzmpDrrZH70I4FXEBLSMUl4I5laYX1PBsqJhFUoTaT47ko8WjdfeWrtUWEhRWe0OX1Nl13AhwVJpNNNiMoEli254FPh82oz/lKi8cOPo+ra7ASI3jFLvVxD5xAw75YqMDjopUjb3Cq6paMU3Zmvfc7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTXXrS6Q4UrmnDi0VjkC+f8XMHgwMjzXla1idkLzGCA=;
 b=dGAjsj2MoqxM2ZNOdDzLeEvOw0cPATAyhovF8wgtM+34fvr5SdEmYAWOozuoRPFzvAplDbc7TQil2Ehxddm4RRzr3qDDu3Trwb57e3mGSd6b2XVqKf+lrFwsp8099wuLhY+3HxKYiwYnfExrVRsGm1A2mXnkbrkB4F5tip4wDwZt25LfO1dS1P7NU8fA4hgUb9oQMSEctp3ONa5IBqcVHid35ceTTikgQGjN8Bpvjfu8PLLidVV24gDN1WNsDwgpkbkVChXJF1h4NsViphW0V0GNDLeTrPZVzf7g5Ng9QR3vXAlDMBl448ynWhn800STpl48F5tkCLOht34ZIfQaYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTXXrS6Q4UrmnDi0VjkC+f8XMHgwMjzXla1idkLzGCA=;
 b=YrdJLXNS4pE0jKE8ADlfJkqmnf1dGjgygYw1jO77pOdYEfBWFT6CtHD5SrQQJXa4kLjTX+dyDz/NVp8kyouk0LUjFbBXpn5sGfM5VObRhcL0t9x3qxANMcEqHV+B08PO7LvS+rtElHfl5GRR1eixAj1bDEmccQw0IsXjIJdFzPE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BN8PR12MB3314.namprd12.prod.outlook.com (2603:10b6:408:45::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.12; Tue, 19 Jul 2022 00:48:57 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::ec80:e3fd:e3e2:605d]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::ec80:e3fd:e3e2:605d%5]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 00:48:57 +0000
Date:   Tue, 19 Jul 2022 08:48:34 +0800
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
Subject: Re: [PATCH v4 04/13] cpufreq: amd-pstate: prefetch cppc_req_cached
 value in amd_pstate_cpu_init()
Message-ID: <YtX/YgJyzG3U8OUN@amd.com>
References: <cover.1657876961.git.Perry.Yuan@amd.com>
 <686bc72b4dc3a663c00126c852e3b4774a280700.1657876961.git.Perry.Yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <686bc72b4dc3a663c00126c852e3b4774a280700.1657876961.git.Perry.Yuan@amd.com>
X-ClientProxiedBy: SG2PR04CA0206.apcprd04.prod.outlook.com
 (2603:1096:4:187::21) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 819aa153-9591-4518-b999-08da69207647
X-MS-TrafficTypeDiagnostic: BN8PR12MB3314:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dTNfUgvNZQtngq3cpTvKPVOI5ta32Oi2NXmOTqUR0adIoETOSY3v+nEYU6LBRY1sVgbZ4oXB/WDhrriOvJsrNlvXBh99KZiCo4SSkpfa+jQU9GfEol9o8fMSLzYtp64VGDCvftZuCptDxCz80/y2o1M9c7iMEFBQua8reMtjCMmDs8NmBHKrWHhanlXOBLvAc4rZOT9Np3nZ9p6j/HQNgPYfIVHgVJh9Ey1+id9PCPw+Qk7m3DMa1v/pu1rK8kvMSWGIiXGh9RnnKz5yqVH4KXK+khjcwAad6YIuv6TQJB1q3bhHuLxRz+UpOipdTO+/XJM70399Z30mtq2JJ5WYp76kgRD7VIlrZ+vtkLOeUDkyA0DnyipQIte10Vrlmg/2T7U9DWoNr/8Xq7x7HPv7nyupwW/v3GW08LxGa/aWriclkTJ9K3VqnFcg04iUBgfTSCsjsuElIY9k6swqd4kuS9WGqHftFgNeJQU+hPPqjfJmefshXQ5kR9QC4ghomCGObSztoae2GWJLxTw4igK/PPbPkxrXx2G/TN6lsypqoAmtj16wtXjXmfAFl1xEmN/pD9fsY+HUJKbcGZZW6OIl+hAAfuqk11R+sumYEBOyOAp7gM93zP3z/W9u6y0ypzyayJEfYfzDTtfGEoRfuNUGNhP5ySCAMFc+JmpRlJ4JnRKueHF94fwefIMuIDi1TwX3gG6bmx3qi473pORI4g/wzyWGBBGVVTzH61H0c9+ej2FOs5BtQ5nlqO2e7xqaeNHW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(83380400001)(6512007)(186003)(26005)(2906002)(6666004)(41300700001)(86362001)(6506007)(478600001)(6486002)(8936002)(5660300002)(6862004)(2616005)(6636002)(37006003)(54906003)(316002)(36756003)(66946007)(8676002)(66476007)(4326008)(38100700002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1kku4pXjy4MhpGLNvKkBSnoujVJc9mFD08Xyl0qUjqiyyARqWkfnUjLbzsWX?=
 =?us-ascii?Q?3pnaxkqzZejalrLsmA1HnFxwPaMDaQQzOANCKg9T0qnyrQ7a8wa4SQdv7HaC?=
 =?us-ascii?Q?Lzde1OvPHAkz/E1Eym20w2/Aj/mEGi+peTMNvB/gV5IvguhVfoTw1NzCKZs2?=
 =?us-ascii?Q?vnPCDh2tLr3ul+qx8WFRaLp2DIQo0CLuH+NF7o73mgKrfrjZCKhYCCNyBHOg?=
 =?us-ascii?Q?OmoSe52vb5XlP1gFGjOZ9E67zgML6jUQ853Bf/enUAgFftQ5Knzft5bE2vS6?=
 =?us-ascii?Q?RRR8/7liUqsTDxZ2m9uel1UX/O0VZnAfrKRdDmeAACunwZVDChVh5b+85R2g?=
 =?us-ascii?Q?yqxexpatsevGfEbdSYhwzjEVU48/PV+c4V17FXM1exHjupMMjlt2ZIJSx3/I?=
 =?us-ascii?Q?mQ8RR7YR4d+a0hyn8Ap2EvrgdEhfHtZl7LgKCKTltyA7ycYJcLoI8/tq5xIP?=
 =?us-ascii?Q?09w0oLPOvTMOfAda/XS0ylzNcBAUqGMUayEw+KCwN4g8TwVnCErPHkRRU7dv?=
 =?us-ascii?Q?YnTRDlF85eec0sumzXVdm2hphNnwBznHNN2wM7gb6LzW+LMKErk8yk8WRs11?=
 =?us-ascii?Q?2J58e0eq4G9sTdJReGenvqBpj6aTderkv4UdRujkWevM+a66J6/0MCc2HxVB?=
 =?us-ascii?Q?GSmeu+j+np7/dLIOUrlE6Pv1ebjDGfc3nLVwcqmMhWnmFfr/+Z8sphcbwR2f?=
 =?us-ascii?Q?jZnW6sMlZtL+kAnXstLEXY+AQ4AgWOk8X/lTJAOMEczf8pRTy9WOucPJLICA?=
 =?us-ascii?Q?ZoB9XjBd/8hyJCVAeTrtKrO90rZcg31qtkzu2r5S2xFcxn+zQ8qrR6leBJgJ?=
 =?us-ascii?Q?bt6UHIEtoUCnBzBVmx+frQ4Jl6A1X7EAaToaEUAXxEuFUcU4eHCjs1ZXZPai?=
 =?us-ascii?Q?8+HHpvLKdXfOwJaiZZez1RhRvngvIeDTB+X5FCqxuj7XydSh0FAgrEhFNfSl?=
 =?us-ascii?Q?7XkgQx22m+2QwE3uFkMCK0GgJgZpS5jk8eik+kmjrA2YYjKRR1JJGxfG680J?=
 =?us-ascii?Q?oRHoZpVZmcMPI8yby2MXznsuOF9N+ocLjx9ifg6K6fxSvNbok897Nss3KF5k?=
 =?us-ascii?Q?ps/IUyF/wIAf17LpkD5CeV71Xzb7QZkQXExgQBorSuVgZdlUikxv9TWNj9g9?=
 =?us-ascii?Q?k1CYAbUq7FVfB/wHInGJiP5hs7HfB22h1dhTzSJGGit37iUrYe8wI/l5TOWg?=
 =?us-ascii?Q?3YiHVRJXyc0xy46/pU3gUo1Dt0P5r6d6YoucN+DWJNoQKBBZqoNaybV8wsUz?=
 =?us-ascii?Q?CAq7YenAIOsyx+aVFAjyHnnbh8Xm1SSHozwdRNg+Xzj2/BWWkA1no9wjh2Qt?=
 =?us-ascii?Q?Joq84pDppA75zCP3qBNsfL5+VhRE2SnA0c3aDB4PT7/gA6ccQunEPcJrsUlU?=
 =?us-ascii?Q?cATKE4SRBJ4KSFACvfh4MtS+Tv4hOlXHu//osmcLCPgRYL6HvZH2lP1IMU1O?=
 =?us-ascii?Q?ko1OnKlHeekAUX1xFV32ZnI1dHa3SlPSoGVJU4H2/ESL/miaPJiey7VMCzjf?=
 =?us-ascii?Q?IBx57NWL5vQtRzKmlmmQKCdW2g2sb1lQx6FWpPdcHArpflqSDYd32wRp9gaE?=
 =?us-ascii?Q?NUpHU+s32sHc06haMqHykOzv8KT/TpiXd8hZkvKm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 819aa153-9591-4518-b999-08da69207647
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 00:48:57.1878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LnfKBxw6GiA8/e4ibNFEPvDenShbGjHRmssnEPlPEZ0WTJk5I609+wUSqsew8WqHWqRTXsPf+E/GQ081vS8+BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3314
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 06:04:23PM +0800, Yuan, Perry wrote:
> This cppc_req_cached valued should be prefetched during
> amd_pstate_cpu_init call period, then the amd_pstate_update() will get
> correct cached value before updating the perf to change the cpu perf
> level.The cached values are read through MSR interface, so here use
> shared_mem flag to check the registers are accessible
> 
> Also the core performance boost state will be initialized through
> hardware configuration register
> 
> * shared_mem flag is used for the shared memory type CPPC implementation
>   which dose not support MSR interface operation

Please check the comment of patch 2.

> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 43e6df9f67f6..d8c4153dbe4f 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -92,6 +92,8 @@ struct amd_aperf_mperf {
>   * @prev: Last Aperf/Mperf/tsc count value read from register
>   * @freq: current cpu frequency value
>   * @boost_supported: check whether the Processor or SBIOS supports boost mode
> + * @precision_boost_off: the core performance boost disabled state
> + * @cppc_hw_conf_cached: the cached hardware configuration register
>   *
>   * The amd_cpudata is key private data for each CPU thread in AMD P-State, and
>   * represents all the attributes and goals that AMD P-State requests at runtime.
> @@ -117,6 +119,7 @@ struct amd_cpudata {
>  
>  	u64 freq;
>  	bool	boost_supported;
> +	bool	precision_boost_off;
>  	u64 	cppc_hw_conf_cached;
>  };
>  
> @@ -547,12 +550,17 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  	cpudata->lowest_nonlinear_freq = lowest_nonlinear_freq;
>  
>  	policy->driver_data = cpudata;
> +	if (!shared_mem) {
> +		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_HW_CTL, &value);
> +		if (ret)
> +			return ret;
> +		cpudata->precision_boost_off = value & AMD_CPPC_PRECISION_BOOST_ENABLED;
>  
> -	ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_HW_CTL, &value);
> -	if (ret)
> -		return ret;
> -	WRITE_ONCE(cpudata->cppc_hw_conf_cached, value);
> -
> +		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
> +		if (ret)
> +			return ret;
> +		WRITE_ONCE(cpudata->cppc_req_cached, value);
> +	}
>  	amd_pstate_boost_init(cpudata);
>  
>  	return 0;
> -- 
> 2.32.0
> 
