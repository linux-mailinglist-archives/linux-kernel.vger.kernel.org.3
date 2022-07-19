Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14B8578F7C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 02:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbiGSA7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 20:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiGSA7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 20:59:20 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F274DE9A;
        Mon, 18 Jul 2022 17:59:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQaYKgwM8GA6Xnb5iXxfXqz/9pa3m6TXOk+QfPV4US+biUh8eGrrRNWrJ2pz6iTbPc2ofh3/P2MIGmfEuMpaWh462Nd1a+0XjIZ9esacmZ7Gj2OWv09dDCaY+Qig2FDsDTe6L/s8jbfv4RyiFq5mvDxE0AYdwmhELVCvCa2AdduAn4fXbuIN1vj1jWz7u0EpNFafD5yuw0VldG73j05BGtDS73rXf4izMJPWKQdP9oytwZSWZG+5SzdR8rMjEo/33/oqHnsRxy/+inNMzo9AZ5NjKaP0IUM6UGrifeKqX0OyyG+9o9GaMnhGfqG7hYvhSPr2IzlTtgvA1mt7mbGGWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KCwqZ/xB9F6stJJos4NTog2L5+RU7czTj+XqZGQgGE=;
 b=h191C+QWE7KaG0KFDOQeWt2gi0aKDdrplyQVm7cTwzTJno1NcG2Re5SQ11b0JUHQFdfHP+/Srg/5CsxBFnCVF6w6Cs1V9CD+OpS+zG1u1Tm6kJ3Z/VJ5/LfqshwMwbf5l3fvuO6ZiZoRNXYAL5fo2LuQLq4LaybY/9vfX0c+Bj1UeHeeTciRFwKLE3pzfnNcNSalqDS25xxWbfLFiabuueeAU3WidGM95hVYEix849iP2L3TDjDLtBXcUOeg4Q0VURSH92fQqErWlLkR/fRuFN+rmu770vnnn7JYledMOa218qzgBW7hDHu5nEKRypgDJvjrCgCeZcXArt5bjLJMiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KCwqZ/xB9F6stJJos4NTog2L5+RU7czTj+XqZGQgGE=;
 b=cNz+zNFpOTbD9VuVZko+qUa9fgzNtxDuBVdtF2aa7CoELY6dHPrrDVKfAxHUjhe8N7b+/1TKkBt/tJ9kOgZW4AW8t8BZsHdXwo9GV577FxwRy9Fg1a9TIRC+sKwFdyZ57OBmYmxjiwWJrkm6USh5JUDqCxufZAgNwIe84U/M6Jg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM6PR12MB2890.namprd12.prod.outlook.com (2603:10b6:5:15e::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.19; Tue, 19 Jul 2022 00:59:16 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::ec80:e3fd:e3e2:605d]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::ec80:e3fd:e3e2:605d%5]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 00:59:16 +0000
Date:   Tue, 19 Jul 2022 08:58:52 +0800
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
Subject: Re: [PATCH v4 08/13] cpufreq: amd-pstate: fix white-space
Message-ID: <YtYBzFem+7SrhvqO@amd.com>
References: <cover.1657876961.git.Perry.Yuan@amd.com>
 <3ef38105e85e6527d14d9d0e2f969fe2ff86ce45.1657876961.git.Perry.Yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ef38105e85e6527d14d9d0e2f969fe2ff86ce45.1657876961.git.Perry.Yuan@amd.com>
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73f0b956-d721-4322-47ec-08da6921e73d
X-MS-TrafficTypeDiagnostic: DM6PR12MB2890:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PzMezxxH8aUlTuQSPlR0ibked7X64obmpQTk7vD4YfL48+q2Lo8w7PlMOVuJbv8tFNs2haVmpGJAG3m7px8zciiMM+DsoyyWSMlnqq2LeBe86jUh2k2DFVARDh24OaNLeV/7mGn3liqUcGT4ZXTToMuChL2Bw+Dd376auHSFlOfIq7BhJm0kfs3Pz8jAr7acmtVRefhWUwVsrMmFy8zsi/P2zTyoqKc+EP3fHyEolIpCHZrJyIQcZ6d/Ac61PVrynQtfVgi4InJ4ud/RAhb0+mi61WGm3Das27umFyA7b3tkR2yHFLSrsgXTsC2cmluTwLRdwY+Nl00Yfp1GZ2YDMWaLqFMhkkxE5GyUCQP7yvvqj+iSfTM4SsSoKgKXsowItvMFLO8/s601bSR0gJDdxzl/R7xRgRbdZN6gntzGyuRcM93Hpf9TIsuJdr79/H3DkR0giStrqUnvyY5/zfmVY1c8T69OpGzy36Wfoq3LCxVpbt8qynLqgQ3dJ5/6Y7gdM3b8bRVElTr00ARhO3Hvmit+rY4wV1mJACVVYxGOZq2iRfttSlahxX4jJvzDEXuhPxGW/4Xbjd3o/8pkFf43cd9jdVWNuRzzJu7iUFSYp8bBazJY+89pC0Ys8LMSv8nIL1aJeWk7zIr1ueKzG7E+JnZAZ+/0GbfdXA2AJ8pdUZDHyP4MheaBHsrn+jWKzW5KF6mW2zBWUGYj/haAUHFMzl/eVTk+fysMEu4ORHJUscCbo43m8pvq/odgtlCfsXJB4IQSx5bPew09V4kpcr76FugJgcEoNFbbN2OdaqSuJbQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(478600001)(6486002)(86362001)(8676002)(4326008)(66476007)(5660300002)(41300700001)(66556008)(66946007)(37006003)(54906003)(316002)(83380400001)(6636002)(26005)(6512007)(6666004)(38100700002)(186003)(6506007)(2906002)(2616005)(6862004)(36756003)(8936002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/aakNLMflXWk8FSCW/+dKEcVI4KcEIKRDbwymZ8LVoxU018MEkVNzbpVllGT?=
 =?us-ascii?Q?c2aiUR8OD1Xr8j56w+M1eQTdBeiXUKfzwFygXyGpnicayJzQiYfDcno5o908?=
 =?us-ascii?Q?1BeSs5IWdHir82vstXiesLbuV6jN1AxS3MCcBMo8wvo0FwQI5od8RQ9NDUfw?=
 =?us-ascii?Q?4VKClHYn73r2Y0ebuU1/xpSpcPmeCbdC5/5Q+QGJEZ+yOJ2Z9e/Oxt/vURkn?=
 =?us-ascii?Q?y72Bbjp68nuKAdypgLQ4O32fpnciWgkEh/kInqnhByk+poqLaJ+7Fo5Z8M8j?=
 =?us-ascii?Q?EwL7TRE59dAL69YRfyzCqDY9M+ih3P3tv7/KnW+Q7CWdAijgYphNmvlKG/cR?=
 =?us-ascii?Q?v4OFfW9R614aMOsyT2iRavrbhooFnoA2C5dvIpcOlxkZrBXY6asbQSbzE5hf?=
 =?us-ascii?Q?TlMXe8zALkOT6nL3C7sM7ExQB9ITSn+HYIKrLeSXTdNXmUWRWVPl4pP+yGyS?=
 =?us-ascii?Q?jNNkwiJzj19/XCCDVrG9BQRQSmqIc/hj96Fp2e/L7dHqBDWNCT0w1N/Qiviq?=
 =?us-ascii?Q?+HpRCs62SA9NuS6yg0VZryecA86oz11vBh+SkGiSMSCHf+Rg3qdX0rM/gegr?=
 =?us-ascii?Q?9TRy/X93wYYwiSYzJtpq8D5iH4EOYak0Pbk0GT0NjEPVJVrmxFgGDlYGMHfT?=
 =?us-ascii?Q?e3QZW52UjRnNiFa128ooi4f/FttIrmUL6mjgGayFW1Rtb6v8S/evn1vYNlNx?=
 =?us-ascii?Q?Cx6nIMqi0TPV7Zp9lj27puPLakvCqcRPRePgSKz2ezhixJrd3vM1olE1nETJ?=
 =?us-ascii?Q?jwkcyGP/DmxxON6lMFlsCPJUuipa/WKy1eM0QytQVQ5sBFUbyUt6tMmJMuK3?=
 =?us-ascii?Q?KRxHisuh75OoIShih7M/uqcBQk9D3JqZWJFNLDkfDjjk3VKt2s6QfRfjrJ67?=
 =?us-ascii?Q?Q78d3h7FksKYHaxjh9GveNiCLiot6md1bJs3YIga2Bb/+fcdMZomz76RJNvS?=
 =?us-ascii?Q?+s9YB6vAxvjn4y6hm6DBeuEerI8Yq4oNJCSuV/TccE/9Em+On5k0yptO9+or?=
 =?us-ascii?Q?91n/iKr16WkAB8GkwDwmyqBqfOgLXJ9dA+8IuC5+n0NcGyWdZH7PWQ1tVCud?=
 =?us-ascii?Q?K+W7fHZqFJdn6NqPv4QggQp2jB+2ymtnm2MsPWpZJZRB48Ii4HOoyBjVMiO9?=
 =?us-ascii?Q?uHth+sV45HaNs2ooXaRUZZikcSMqnn0b6JpGEH+eVqmhe3Iq2EccMBRH1wx0?=
 =?us-ascii?Q?8xOqoenKM3DLY3Ef+cHNbtUgKNvPN4eFgdV2MusSiCHT24P2kyxK/8tOeV6E?=
 =?us-ascii?Q?ADbH5EdTgmDa0975beuNGy1G9EIyCXlHOKwAp0gKSJW6LLpzVKld2CfRZ/Jq?=
 =?us-ascii?Q?HVU/paf+gADRNyV6b6fDpT4IouyX9ZjluaNHq6gnxy9BQxoqzFu9VaKFMdtr?=
 =?us-ascii?Q?x9cuz4As+L/A4LIqo6FHxPcTlheqvJ/uNslB++JG5laMAeVAxDVQCS6+mL4K?=
 =?us-ascii?Q?DNV3wqDgNm5W29xnOSNRY0kEVrNG6YyCrwj3DsBsYx1Trwp5BAU9Go964CjO?=
 =?us-ascii?Q?qHGlEFmpJWU4emKhi1JAGgVTysJLf8gVByjqLGEX+qKi31dWXPG0SvTe6d4k?=
 =?us-ascii?Q?znRILXbsR2vjzs9zoYjGjY1zjJDaz4i+zD+DqVFA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f0b956-d721-4322-47ec-08da6921e73d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 00:59:16.1986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t795GWQaYSRyvbvRcRHBfx8md4+nx2/ruBhpRhvLINEzjoF4PEzOfucRm88OQugdNODc9r6smrf5mk6ZyO0Kvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2890
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 06:04:27PM +0800, Yuan, Perry wrote:
> Remove the white space and correct mixed-up indentation
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/cpufreq/amd-pstate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index ebc7c6d389be..acb62ec5ebab 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -117,7 +117,7 @@ struct amd_cpudata {
>  	struct amd_aperf_mperf cur;
>  	struct amd_aperf_mperf prev;
>  
> -	u64 freq;
> +	u64 	freq;
>  	bool	boost_supported;
>  	bool	precision_boost_off;
>  	u64 	cppc_hw_conf_cached;
> @@ -674,7 +674,7 @@ static struct cpufreq_driver amd_pstate_driver = {
>  	.resume		= amd_pstate_cpu_resume,
>  	.set_boost	= amd_pstate_set_boost,
>  	.name		= "amd-pstate",
> -	.attr           = amd_pstate_attr,
> +	.attr		= amd_pstate_attr,
>  };
>  
>  static int __init amd_pstate_init(void)
> -- 
> 2.32.0
> 
