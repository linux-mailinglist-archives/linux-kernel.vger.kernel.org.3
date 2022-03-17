Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754994DC00B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 08:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiCQHTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 03:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiCQHTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 03:19:37 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2043.outbound.protection.outlook.com [40.107.102.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB5F8FE72;
        Thu, 17 Mar 2022 00:18:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxCVQ8saUVu3ECPdHsl4GQQVcL9c2RMKtzM4ZvmGsJAX5RoKLzZH1LQnJLfmu7WJf+QZUxoSVcHC54Rjd+ahm8j6c66aYLPW3UjBh+HgNNrX5rIXDpWEzKvEHiliUxxih0bdMAWWCVfZAJdj5vQ6xucczEeInELbpg+Yowq7ySBKQRa1sYGSHh7QCR+rgonjkMCGjTYNbMOLgENYoqtvHHISl0Btis4DYF6adRPJ0eYpFnh44jR7hgD49ebvJbDmVdyaClY7QZ6y13USXZjiD5lTmVaz8LKJ9TmIhW7yUdQZsc/gXpJe8eV2OV0Uj7KPQJAYqL2THxXb1D6CF1CkKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVrF50R+d5MaV65Uzst74+24sPle1k66AAk9Dh507h4=;
 b=NtOx//ENyFAWXQEPCd/1Cxg5t9XqpZ3uU823JNi3HzsNtSqKwvGu6+1jRd8DWhTvrf2+ut89oqGL6wfX6knrsuo/2lFxUqvOVZTV2BWXMZNeRmG7O2JjAOubaPkOAAIz5Pfr3i4Yb0pQ4s8PPPksVFmWmfbughaMxK6mdzZ0zLMNLPvJ2NCG604/xmH6zHYOln9fXFgOOyGrAHRLkZgCspjlj7chatqzDUu2xa4fVAhWlPKVBQs1Sp7OCInjD46YzMGszAcHn4f9OsSLHogWr6UvMcGDImkWVbkoiLadxF924S6qkGniT4fv58DyVYp5wC5Sadux9s7u2wZhMEeQxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVrF50R+d5MaV65Uzst74+24sPle1k66AAk9Dh507h4=;
 b=WBYCGwaW4d+8x3v46H9LyrWjQTTHJEv4xBFUa4xx4MbSXuCf0gZXHzTH5tMtKkFX/D4cHvETpon06N11OwePH4V8BaWvWhWMRCzt/IkqWueFD7lc3WLk2Wj820zia7J64pABPacSU2tJ/UBLiZisZRcIJUkXpRLlw8OiUc3Iu5A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BN8PR12MB3140.namprd12.prod.outlook.com (2603:10b6:408:67::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.15; Thu, 17 Mar 2022 07:18:18 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::38da:2ef6:d863:3c90]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::38da:2ef6:d863:3c90%6]) with mapi id 15.20.5061.028; Thu, 17 Mar 2022
 07:18:17 +0000
Date:   Thu, 17 Mar 2022 15:17:57 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:CPU FREQUENCY SCALING FRAMEWORK" 
        <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: powernow-k8: Re-order the init checks
Message-ID: <YjLgpbLfcHVD2PJF@amd.com>
References: <20220316215548.6013-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316215548.6013-1-mario.limonciello@amd.com>
X-ClientProxiedBy: HK0PR03CA0105.apcprd03.prod.outlook.com
 (2603:1096:203:b0::21) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fbf2143-acd3-4d8e-9156-08da07e64eef
X-MS-TrafficTypeDiagnostic: BN8PR12MB3140:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3140B215533684F1E6D0D82CEC129@BN8PR12MB3140.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +iOTwvUXoDjIAP5PDzDQAMe6jc0Ef92he/R8TvLSkKEogrB0n/SAVyyOYWcL7jby4Ks3YiqaPxAAhxRi5K6NTimfY3Yd1/rMMsSHKpgF48S3XFp2Nc/RKzXKOoB1GbWDmPVjMRuwzPGl8xIrYiCpqPIDlWt8SfWiA1vB28VEHAD7MQTWLQ/xTMsK7fZtZSDqoEvb5b7aK3K8iVlayBUr9y7L3GFWCQk0MDHv17/kVUPBPG845Y1wzmj3YH9Yp8pfdW6JOIpaP0DRF1vXuY5tSqhTJav/AdMck5pJthcvOsmuel9eGjYjXqm3uj+wZeCcZdHTx4sRqtZXesYuo92D9UGJhJHK5/xGWlViYeLcQMSkhTKaCPO5l8PPXFq5VlI1LEnXQYLIRqY2RW2UBY/r+QaeoijvIuv4Kca9ZSwo/2JkrzhRrifL1gMUn75faJaxh4x1wdzerVxTe23ozTrfzmkrFjEBqAi3hlJ6GLqqHogQ04rdTt5lrLgmgRmLVGgFcJO3nG/J1x9+dnJR+sUNWdKXo2NeP5OYLLRju7dUYdxX5BZYSu2avGXWFhfuZmzVvn/S6K0u3zT+vSipBLbOiChWsCbs9MTRlGpNw5tvLN8jQsaYfLK1xmvID72g2IoNIJ9fB4gWPQ9qLd43ZzqqESlFNhixHCRkaz4eRiVBcq7sIUkKctn+76M/sJqEfjUnqo9m7JOxzPzjPdjLRdGFgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(38100700002)(2616005)(6636002)(316002)(36756003)(37006003)(54906003)(2906002)(508600001)(83380400001)(4326008)(8676002)(6486002)(86362001)(5660300002)(8936002)(6506007)(186003)(26005)(66946007)(66556008)(66476007)(6512007)(6862004)(169823001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y3xmYWCfRyNzhZFU4bMRKbDxXWP9i4NaPaWD8R9fpkaTCYgJ0o0xln02A7Xz?=
 =?us-ascii?Q?QdO10yy1uHm5pie0gwFuwHQ9uwscNhESYNZI11L9U4aYo0AoknDM6hfIppVk?=
 =?us-ascii?Q?uv3+Ni6D+m3VwfzOo9NrYMu5kUDhEpbtOR0M3uCJRwZ3iZvzBRAQRi7+O5TA?=
 =?us-ascii?Q?bkEsJjJSnoIAk0UnuOirRGX7dR74KuHQ3winTDMgpd7H3VzAUpj78fY/h1cg?=
 =?us-ascii?Q?9FU5IzETUAGW1ygnmFajTNxY2ArODdBknH1nM+T3kZ1L3zPF2XLuapRXbG3v?=
 =?us-ascii?Q?U/NHN+4TUE9M5XOPtxNCmKgSQP0UB2VO6Y0adHE88nMbnudb7VS05fNsgSvK?=
 =?us-ascii?Q?sh/YrkJnohE+ZD6Jwv5HhXSMf++RMKgRQoy98Lju2csP/CsDNArgg/Lr+jva?=
 =?us-ascii?Q?OKh3mU8xIui0dSZ/9nHNKX2BBdjquVzBTs5ZHw1MYW9SGezZfLN9S666XD50?=
 =?us-ascii?Q?g+QSVmB9ZaQfFth+WLVb+PGPsJFlSLZ8zuKXN0+PtLE85YJ17p5a1WVu/l1n?=
 =?us-ascii?Q?Z6bnFchhv161f2FUX6hECGov41evD8sZ72c3DughT7s6O20EvAwaHYKo1IFR?=
 =?us-ascii?Q?O9UffuLFdOzXCFqmhzaT5ItoXvFOJKOIEVEiLKtHDiS4p2eYkny5Rw9Axcts?=
 =?us-ascii?Q?MJufOtCLUbrtxhzfw0qSFocStjdCHS4zN8FbmRZfRRmJkp+Jab+PRSbrCDYF?=
 =?us-ascii?Q?rLTgahjdBlzPp6KCEIOT1Y3WzpsAbzlaMp37UOPcrwPpvRstDkJJyYVmmhwB?=
 =?us-ascii?Q?WFiNX8uque4LIHRyNhiGHuolGc771QxuSF2WWm/qaMjdg2OwTjinIGnxYeYK?=
 =?us-ascii?Q?O9BqjNaXELdHElrtAdtYLabeNvAuCrYTDbIP2cvW4uKAlP764Xsp7+ohFllY?=
 =?us-ascii?Q?S1a6R8eQ1e0yQpPzH+8m2VVN1gVZrjll2arZy88UAhvuNLOCsphuvwRJW17f?=
 =?us-ascii?Q?cvXfgfxOTk3UyOkn7tjn6rFYM4lQw7QQ/MkuubBWolzBaqmvZstJTe20pdne?=
 =?us-ascii?Q?b6GSEY3jWkMeDbysv3bDFkH3LXRTLp2tLGSTebYFXqLj0eAUWplPHX0jVGqK?=
 =?us-ascii?Q?li8GWS7j25fCs9O2+ykPBSufxUD0DcvnxvXAIi1gWROv1M7eFLMxs52UU1Rg?=
 =?us-ascii?Q?bV6P4qB1hJQerja8QtSUVJN5i6pVZ8aIDcs4WsYkTBJvzrfyq3wraXHxYs4E?=
 =?us-ascii?Q?8XlXD6lXINYERSLIcGHUUbJBmf7UqO0UsTE0wkhGTjnECmBIZNNFgm/8hrIv?=
 =?us-ascii?Q?QahGzyr6Z2Frkz1nEz/wJG3XS+w384yh9cegkLpYK5A/YRdQeX1g/htTeuiZ?=
 =?us-ascii?Q?z2SjAMQMz/Vsuav3BNv5itRC1Lg56N3/ZnG7cVSLhYnUQcbg6JGGVj2wN9WK?=
 =?us-ascii?Q?4TguPOv6JDhD8Ywwde73knDrN38b19d+fNU9DPKQLs3dfQgpB7KwBofq1JbN?=
 =?us-ascii?Q?VF4gvupjkHaehCBjtJGP8Op8Kdh2rQnZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fbf2143-acd3-4d8e-9156-08da07e64eef
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 07:18:17.7510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7w17kiCH4xn0VjsAepRupc5pKFQtoZshHoYvby0xElV//4Pyv/UxYcELSPhuKX8fqYsUSy/H0KwSq8kpnpdQow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3140
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 05:55:48AM +0800, Limonciello, Mario wrote:
> The powernow-k8 driver will do checks at startup that the current
> active driver is acpi-cpufreq and show a warning when they're not
> expected.
> 
> Because of this the following warning comes up on systems that
> support amd-pstate and compiled in both drivers:
> `WTF driver: amd-pstate`
> 
> The systems that support powernow-k8 will not support amd-pstate,
> so re-order the checks to validate the CPU model number first to
> avoid this warning being displayed on modern SOCs.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/cpufreq/powernow-k8.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
> index 12ab4014af71..d289036beff2 100644
> --- a/drivers/cpufreq/powernow-k8.c
> +++ b/drivers/cpufreq/powernow-k8.c
> @@ -1172,14 +1172,14 @@ static int powernowk8_init(void)
>  	unsigned int i, supported_cpus = 0;
>  	int ret;
>  
> +	if (!x86_match_cpu(powernow_k8_ids))
> +		return -ENODEV;
> +
>  	if (boot_cpu_has(X86_FEATURE_HW_PSTATE)) {
>  		__request_acpi_cpufreq();
>  		return -ENODEV;
>  	}
>  
> -	if (!x86_match_cpu(powernow_k8_ids))
> -		return -ENODEV;
> -
>  	cpus_read_lock();
>  	for_each_online_cpu(i) {
>  		smp_call_function_single(i, check_supported_cpu, &ret, 1);
> -- 
> 2.34.1
> 
