Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08F2578F70
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 02:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236402AbiGSAt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 20:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiGSAt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 20:49:56 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2059.outbound.protection.outlook.com [40.107.101.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBA42A70B;
        Mon, 18 Jul 2022 17:49:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXj/zw8z6C8sUsOXnT5c2LQfE10mWh5zyFWlg/l0lsRmbzUozA1YIepnlywm1QtsZdOcQxuOtcd+sewIzLO0i+WxNot2j+su35ATLdGaC2YtWh7VNZo17wN16qur2bHCchiuq1t3obik29xvtgwJ49MgprZ9OTem5LWrVYqVhCdDhZ47WpGLm4hGETQGF+n2GuHkNZEJ/svgxG/iAhiXGGKq1z+ObuR7uoWA7ZUJhT+nC6i/6+RdmpQ4YKwXgf1jugXtpuCovhVv/C0yzZz9fKReYXSnp/Np0OW58ZwAcG4Eyl6bGk0ajyjk/fSLlnKDh40pGcnM9Mo0SbWxBUKbSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxDUEQB08Zs/aj5kVZlDdfGbj25ZGL1gvrwwhRCqNKo=;
 b=NMvfxR5DBL+QmIZjvkLvsm4KSlXva/I7irvlvTdaNA2rqRhHWik7oCF7mR7tzD5rtVAemaLhJ/42JX1Eqf6KztFT/MTmPIm6TQtPG5p2OGHHaIA0lZ7fmo9CIzknp7lE3Gs0Wzb6Ouf6UKHhlmWmeHmrbUUgPtaKwO3tX4JPVJ9BHOdZvsDvd/7uS1ipK3ZJVN0ElN5QozY45Z+CXjNBuaeSTmFJFWEt+ZhmAQiG3mPu00pfsR1HrRbRICqcyqASJR8p30EUzUNKV/qflRYWd8lOBGKzqEX4cg+IvCm8ky6DNe4MuN0Pqh3jpJiCqP/naBnD8Std3sqVu9xiUWAMbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxDUEQB08Zs/aj5kVZlDdfGbj25ZGL1gvrwwhRCqNKo=;
 b=Z39ZNjHCaQjC3bUdp6ua/QiaWLQjX+LD2G2ixdzvYPRq/NXLFnvWzCmeJ+gwLvTK4p3xXwGJBmwjJ6nQSSjAgZnJqBiWvlyJ2JQgGlO9hPfBSLpLMtLQjaPdPWMB5K8oy7ow7wraAFuQwTN/0DCFU3UFV6TMdMkDjE4WC4HTpls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BN8PR12MB3314.namprd12.prod.outlook.com (2603:10b6:408:45::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.12; Tue, 19 Jul 2022 00:49:53 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::ec80:e3fd:e3e2:605d]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::ec80:e3fd:e3e2:605d%5]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 00:49:53 +0000
Date:   Tue, 19 Jul 2022 08:49:30 +0800
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
Subject: Re: [PATCH v4 05/13] cpufreq: amd-pstate: simplify cpudata pointer
 assignment
Message-ID: <YtX/mo8XmX+eODQF@amd.com>
References: <cover.1657876961.git.Perry.Yuan@amd.com>
 <e75b941f2c994d5b52cb42cd31eaf90d24efb73e.1657876961.git.Perry.Yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e75b941f2c994d5b52cb42cd31eaf90d24efb73e.1657876961.git.Perry.Yuan@amd.com>
X-ClientProxiedBy: SGXP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::30)
 To DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6fce565-d659-453b-faaf-08da692097fd
X-MS-TrafficTypeDiagnostic: BN8PR12MB3314:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TQmk0pxuYd05F2J+6duNv+zWQIzlxJcqKFJ1Bi9+hoIpjKU3W/OmB9g9kteRpG8FGld7nZSZPX7xGJX9NVQq+XcLO4cvMcna2pN7LWpq+KiIWAukzbF7pf1ouyuAF+r6wvYKildQm9xgGYpXY3qv0ROqxKnCToKgqud+MVGJpdpl9QA8nboNmJtzLnkb3e/IQlu1HQ74zMhYWnRAepl16ixe+kEhoZh6XiOugKAEVNRowP6O0376VDBnVx/j1ui5GgYGztvZqCYFfvsqxjTor8v/9mI3IvpctiYkK/CMvmb/Q+9ZbWP+PcZotVoA1GLfN1Ct2pC6YlsOf8i/dBwNcu+v5HkVtK/ts/X/SHht4MdKaOjnWp1m91n4DRd6sCe92q5nVUTcDVQFLT8uNJe2IsIMD1W6xa46ERclL1ZjzQm1JPD+ZEIh4c0GdkpUakXlw9LGtf+DmSYqju6C8VLpzwezkcuEnF4vp5TcA0YTtRaUFK5RE1LS15o+QAr8uAmoKNXmdLpOyqdkaqxsD9vZq+aGTz0qU9bvGgqrd43rW0zeNxyZ19m3DfQigZUWtHFKEl/Z3SEIoYSGC7PMyuGqUaJ/kNqh32jx87qpNkdBS1DW0TGSDVbHCx0bB9lR5mwqvmUnNPfxuV4R17H64tfYbQut01Tb9/Q7ry0/sHtxIOsOBpzASK7xOpJtPQUwiDmm5qs9drbI+sck+rtocddmNYZk8vcwVvrLVM7FZH5gfglv+x+lGsbTD5KmFWFjVBn2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(316002)(37006003)(6636002)(54906003)(8676002)(66476007)(66946007)(38100700002)(66556008)(4326008)(36756003)(2906002)(6666004)(41300700001)(83380400001)(6512007)(186003)(26005)(5660300002)(6862004)(2616005)(8936002)(6486002)(86362001)(6506007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l1WUWJNN1l4m5mytLrpLwzGSczFtHDgJo8QybSRN/Z9GUnma3hE0A1WDxEP7?=
 =?us-ascii?Q?vyX78Qoec17UpwZx9TXocDwyu1TEB/HkUoiLUDjcnbSGAekkHb/DYH/qnece?=
 =?us-ascii?Q?AGFwmPqkt4uOOpD7FFJeTfktlsGZqwKpBRURkNuvm5vJREF0kqKEo+R0dm3r?=
 =?us-ascii?Q?DPkyIm7SveQpXjoQDQCEGNlk1o9fiHjnUbAoXBX3ul6Yc5B60fBdwtSAHxdx?=
 =?us-ascii?Q?wfkfZetyKCOr8bwdynLL1Rlg4tlqmJ9cRqa76SxqUxtN7r4f70OktshW9z+B?=
 =?us-ascii?Q?M0u4SDwH9DcGQI9Bs3Ilz8UUPwKGQ3BNiwtU+hDigRQqk2BGlt0BW+evu4rN?=
 =?us-ascii?Q?UqJgGaX14cl13HUaMQGZfonrxG6y5vzOM3vldfSgK4H7pze/B6bYIX8kXZ2B?=
 =?us-ascii?Q?sq5t9yVEjPAtmmVhrcohPdl3XUtFH7qqU5Sg6z4Yeb1UKrQZNNVpjmgBngjx?=
 =?us-ascii?Q?TcKa2AHwtF1JxTaCJY/DCPOKOJVE3BEgQx63KL7tF0EuCL6UYfbzgtF2slmP?=
 =?us-ascii?Q?qOfpjuRk91qbJecj99lz6+oMs7Folw7E081/MWGGKFCanoqbwwJ5yYNn+WMj?=
 =?us-ascii?Q?4I3+AlL4+3EJTyGw44wTIT5TpBfFQ0q1y35Z3OhUASxlXLaIh5nop14tAgH0?=
 =?us-ascii?Q?UOssK7zkncAAZbsbGNN0k1p+J3nPvOqy2wYpPM3m+k/q2nsIvU2mbboCnf71?=
 =?us-ascii?Q?Mei7scY4fTr1wf2apHAkkDEfr3b4xKFXwJW8bP4YEARoQgBHJFOEEaVd/aH1?=
 =?us-ascii?Q?thx7MbE31MCwA/BsAclBQRasL8JCFjES7+14NqqdH21fwgtSdjpS9l5h/mlu?=
 =?us-ascii?Q?oj5ri/sAvF6xqNWcukiWBC1SaBC/pfFi3VN+pqFoaRf7MBjuRE2nZtUFsC4E?=
 =?us-ascii?Q?vKKS++NEkFl1iS5Tk5HHPsu5pOJWi7+cj0KfsZ9YWqGBJw0IwIuYZmXZ0HDv?=
 =?us-ascii?Q?s9awzXyWpUahivZ37fjBN9pAT3FqWSEENpCChDXskaK1Zmpt3OMrFO+LUSEg?=
 =?us-ascii?Q?tA4pCAFUFjDwcVufueR+pcn60XW8zUWLABsyheSpKeMHSww2IgOkPiVnyXDo?=
 =?us-ascii?Q?szsUhXR9NmrJoqZHfmt5GOFaRiwZs8FHpSeoQ2VUVj/JJbvU7SyZTsWHhDTo?=
 =?us-ascii?Q?hF2eiAlXI/8wQGpdO1B4M3ejTpgKl7mRFRmWHa7pw8PHV1RQpYU5WzNtf57C?=
 =?us-ascii?Q?YwHvdUTztZheSMIAVshFhNYOoM5Soua4lZjRY80Aw/nX9Bqk+xx/r0Hu3ADg?=
 =?us-ascii?Q?gd8eEessiYrYYQDnyOYWC++ahHYDtAve7L+f4XWTCvJk2ibq/hrEwHITp87f?=
 =?us-ascii?Q?ncoXT+jLF6rAwSSgWlvZCyO7599/26uI6dEAeEle47Byviuh44z9f7sAc+3F?=
 =?us-ascii?Q?88QGD6PmdIn/rjbFhRgE9o8Ue2dyvsv+pySLtCAAwmsU5nnTGWVnRVHNpNd3?=
 =?us-ascii?Q?haZ6V0oZuXVcELBjksmlNIOOQH8c0XKgaE7hptgcnllJ5l4WryqNIzE8wZqf?=
 =?us-ascii?Q?u0nN06AY/jgBu25LbQX7g4YXlWd1lNNDha4Xeegn0FHh9N02QL3Ja6xyH2n+?=
 =?us-ascii?Q?F1LRKQUiK/hTDeSbI64hUY2bKYochuhhowPPFaTn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6fce565-d659-453b-faaf-08da692097fd
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 00:49:53.7158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NHxtnMdIzQ9eIS24h7EjWLY0YghhVvsTKO5plPtG6UHhRFBU/EiubfPnrM8o58GL4ou6AlV/h7osmxWpDEpIxQ==
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

On Fri, Jul 15, 2022 at 06:04:24PM +0800, Yuan, Perry wrote:
> move the cpudata assignment to cpudata declaration which
> will simplify the functions.
> 
> No functional change intended.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/cpufreq/amd-pstate.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index d8c4153dbe4f..0c8256638ed7 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -574,9 +574,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  
>  static int amd_pstate_cpu_exit(struct cpufreq_policy *policy)
>  {
> -	struct amd_cpudata *cpudata;
> -
> -	cpudata = policy->driver_data;
> +	struct amd_cpudata *cpudata = policy->driver_data;
>  
>  	freq_qos_remove_request(&cpudata->req[1]);
>  	freq_qos_remove_request(&cpudata->req[0]);
> @@ -618,9 +616,7 @@ static ssize_t show_amd_pstate_max_freq(struct cpufreq_policy *policy,
>  					char *buf)
>  {
>  	int max_freq;
> -	struct amd_cpudata *cpudata;
> -
> -	cpudata = policy->driver_data;
> +	struct amd_cpudata *cpudata = policy->driver_data;
>  
>  	max_freq = amd_get_max_freq(cpudata);
>  	if (max_freq < 0)
> @@ -633,9 +629,7 @@ static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *poli
>  						     char *buf)
>  {
>  	int freq;
> -	struct amd_cpudata *cpudata;
> -
> -	cpudata = policy->driver_data;
> +	struct amd_cpudata *cpudata = policy->driver_data;
>  
>  	freq = amd_get_lowest_nonlinear_freq(cpudata);
>  	if (freq < 0)
> -- 
> 2.32.0
> 
