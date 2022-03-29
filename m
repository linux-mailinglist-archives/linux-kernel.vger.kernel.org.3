Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE8E4EA791
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 07:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbiC2F6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 01:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbiC2F6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 01:58:10 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF1D23D588;
        Mon, 28 Mar 2022 22:56:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1gRiMRbVHDMTs67IfogUm7PEZQkCVQ8Oqa65rDG+L89JFRkcc9yoM+Rg8f9zpoYs7c58bzkC20byA2QZm5fx9tM1W00nIyGJN9bbxIVgMGfZCz7mdvnrj16BTXt5dM1sIjK9lNCRw/PObhPN5dnKCStrgmT1aH9+5qJdnRzOK8Ovw96xzAYMZO9O9KOwAr69wInnfVHql4Ly9/2BuRPUnYlzmbUQ5ao6n8Ma7c0gE3bGTrQe5mNQqY/Zma3yi5o11JVKbPskH4MVrJZDERzbnN/POveMDEwE9WZjCjMJceWCsMZMVA6gn1o4CUmatB7TbqGA75iwTrlGIBvVPdPLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjusLDKXQwWJ32yeFZ6nR/pm173GiXGQIaIOLYfWmO0=;
 b=F9CF8Ca6w68FSGoevhqxwUkxbJlgMv/PlVwJSVIwe4jTLRrjIk+6/g3OCfPKl6mfgTCHg1WMSskDhNBsZJ7QKYdA+hncxr7itENH3MxegN+pi696s+29gp8L0qtyPMqKop87eiRGeyDmJuxZxJu6nNRRBV9zO4FTIhKFouIDRETiOGYsnorZUhjWDcK9TEtPCFDqVCeTVtu86rVntV584zUhctsloJt96PQZ8H0wBsL7K2GjITp2JMrcQVLC6elH4n2wkoWsFENxuH/odAhLLz5ErW8w6OJzmBz7RKeC0YRE4WngI3kIUdeLZihNv6TqJP8oE+zJnGLWoTo17/8Nww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjusLDKXQwWJ32yeFZ6nR/pm173GiXGQIaIOLYfWmO0=;
 b=0baKgGxTjBA59yewFNacL+CCcMRkciRlTKcAT3J1ds2cPv3Bkk4NByUgIT7F7wg9cf23rkHcTB8kOk2PnuCQS1+z1YrVxwr6MdxYHNoLaIfQmaw1EuTw4HQVmInenfHLuzxnthoXzV96+PYJRh5pGr+b/ujizekce8L5h3NN2so=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM5PR12MB1386.namprd12.prod.outlook.com (2603:10b6:3:77::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.19; Tue, 29 Mar 2022 05:56:26 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::38da:2ef6:d863:3c90]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::38da:2ef6:d863:3c90%6]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 05:56:26 +0000
Date:   Tue, 29 Mar 2022 13:56:05 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] cpufreq: amd-pstate: Allow replacing acpi-cpufreq
 when loaded
Message-ID: <YkKfdRGD1jcIx+Im@amd.com>
References: <20220329015947.565-1-mario.limonciello@amd.com>
 <20220329015947.565-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329015947.565-3-mario.limonciello@amd.com>
X-ClientProxiedBy: HK2PR02CA0152.apcprd02.prod.outlook.com
 (2603:1096:201:1f::12) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a059a9e1-4eef-46dc-a1da-08da1148dc84
X-MS-TrafficTypeDiagnostic: DM5PR12MB1386:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1386AD4545062C7A4B393C16EC1E9@DM5PR12MB1386.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: duB5gV6361fDsI2zcXza8r6FzUx1f558PznGRTykeBuJJM6FBu5VdUqAhwwAMC3WcvqiQNHRaacOgxsrq9l/3kXpwtGumBSWwp8qkNOfCPZReZQrZXtjvpVI+y4q5hL47lLIg/Sc2xSqCvkkjRdTw3Fqaqdjbc6oyoZQBsDg4ErCEFTrHmC7p/wctaPPTEofMS36tvvo0FNhbpuRQYikmMwUuwWRam6joxrwsMpAQk8p0lBtowUtsXSvO7U7Dm4zdtmfy6qGX5lHMNH5FAcUHj2McJSJBoQqXRfb9JcY1qWRMKHHtTO3srunuCmTK960lfop6XZYysHLrzQUHoIXwz65OFVuqkHOv3XyXTx8htmeVtM2BBDd5FQjzoZWFWNzVEVrE9Kj5KH3Y07932UlS1O2wjwSizlw9y8frLdT8qxBhAX46keNVNdxNYGjq1TJOT/cFEK4cCQu1N5XThKTgcPOrMtqHfvUczsAjxfJ8c6Nzh5MrF8pIjiEl0HhJxNZ/hrMlQRybBHl03lRUUttWbIZkvJSWFAu5ufBa0KQNyzQeXbTUOccD0fNeS6WTvkEfj18OJARPcEECrnrBlUT4j6+h1htGxoNP/JL4nMP8D7VUiT6jqSrEgV4pxaF+jRzzlKC71XYT2StO34/O1A+S0rNqROZvmPq7wjEA+6txI24sji/Dnb3+6+qb0D5bKWzR9FZ9N+g7gUkOfpBHxZQPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(6486002)(2616005)(36756003)(508600001)(26005)(6636002)(54906003)(186003)(316002)(37006003)(8676002)(6506007)(66476007)(83380400001)(2906002)(6862004)(38100700002)(66946007)(4326008)(5660300002)(66556008)(6512007)(86362001)(8936002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5xK/RWIwJAp/f+tJ6v3a6dGrgCs3NnVz8hcflVG24ixCLX0+qZafVNX62sMy?=
 =?us-ascii?Q?y5MUQeQB2CR0uxuahANy04dOl88B/yq5pF4Ec/0XZGE6mauh/8uasFtszv2m?=
 =?us-ascii?Q?jg0Uw0no8umejca34n/gEtzMXcnAoN3+MzyI24biOruVK20bSKp4ocyDAYUb?=
 =?us-ascii?Q?BuYZBoXu6Qp6+bJaUWPAWwhtTRbX6WdQVf3CpgK2Wmmk+ufpHLdZNkLL40EB?=
 =?us-ascii?Q?Aesz24+FREmEKXWUQ6r6kv2qfyr+I6sNoHLDES7yx9k3JKLBxl+yBSNUt52X?=
 =?us-ascii?Q?eO8m3rQ1fWPkc/tVsiPywjaKNpk5pchLfq8QHRYQrzsMdRXXGQoiiIpOE+GX?=
 =?us-ascii?Q?HpyLAvDU/EP0+m/JesKG51OSe8ZgJMpdmeLIdESKbn/Dpa5mEGg8py8F5s9K?=
 =?us-ascii?Q?akcb9FSF4nOzIHMHlIa9+gz9J5ILCw63rj4sTSUuWqaD+YfYIrKThF4aHRP+?=
 =?us-ascii?Q?Ja81uHG4SUNhI18mWEUODsnWnUnqpRXeHL40CBW2o1v5qcGnEK2YwiVyIwNI?=
 =?us-ascii?Q?/crUVPn03zfnc/3DiWQB4HR0T9WrzSCkq4L6fqMRP67yasy2I5R7yCWbaXX2?=
 =?us-ascii?Q?bkIhES1Ux76pny9o7pyAEMZpnA9L4ubFctf4d8OdONtCGJXoiST90mz+9Xs8?=
 =?us-ascii?Q?GouvwdZPu+liyOLbBNdxw75ubXVrLoc8pWiFKbQa4PWMjQ51gEQJkH1JGdng?=
 =?us-ascii?Q?byphuLY4JEz50HEGP8F7sUtxBwSMDVAyT49oL427KXA0zj2x+yZQiNQtu9k5?=
 =?us-ascii?Q?O3MC3eaPvNCVnoVQzclY/BxT0dzGaSpsOLXKwKIQFueJQSdnVDCbb9PYkLz+?=
 =?us-ascii?Q?sQgWLohcWsjYH/f2CyvJv7yofLG3gCt48TfGxBLgXBZdU1ALW8fKnJHd4dTz?=
 =?us-ascii?Q?NytOfBQ2vZ1D0B3E2asMXp1n+xQ/Mmb9z5Gw+pHTh0iDwO9nr8cbsnKdbqZe?=
 =?us-ascii?Q?8Wn9ngsbCVoubVNMy8+TZ/z+lDAQgF1+RrawpcCL6JLA9Y5ZetLrX42TIKGd?=
 =?us-ascii?Q?HwJU7/tJ9dFDK1i9w3AWJkgnu/GH0dln+WdlLXL57PEimUL97AaowG/Jckc9?=
 =?us-ascii?Q?Sp4DlDp6BnT0TPo/BBZa9HVA4ianCLG+PKwvXEi+vSG80ILavRaAiChKeBis?=
 =?us-ascii?Q?1mkPMTivEOt7hsuo41etEFHoEhTcfrXVT/NI7qnHar3lkh+W9l1tn3rlI9lQ?=
 =?us-ascii?Q?KZpacBO0mdzQ8/NGnrR+W8EOJ8PR/sJgrghiD/iZtt2QniS49i9/RYFqKUNz?=
 =?us-ascii?Q?DuKmP9SCdQ/DUvtZf31q2dFYgIBXW6BrXK38J+7ow+eC9HogU/I2Pe2+HfUX?=
 =?us-ascii?Q?Jd2kynJNOPUjmXy+fg9SQ4260TswOMvD8TTZTy0ZY0QFBjYO2Zyxamim2NB+?=
 =?us-ascii?Q?aOthpIl6/KlZ7NKewtH5/XfrTZ1lisehE+tWZU7aUphafmNWYvp4rUqkcP5b?=
 =?us-ascii?Q?EFlvH0uAGNrvZt+1NpQopOFj6mIO9Bl/CbJr/6uosqwpA8k7MJ2GKQbbmI3a?=
 =?us-ascii?Q?Wl/A0mylmPqGNRQg8Nv+wRMGltapZUo2X91Vg/vp9vhsI5aWBBp+9Tz1MPY3?=
 =?us-ascii?Q?G1+nseMA5Oj2aXN3sbKP5fV7dI11jf8UdqylA2wVPLcQDoEoFa1e/f9GzUOz?=
 =?us-ascii?Q?BovsWbLofQashNXXpDeRcDDJyIjtU25soPqkGkqozxHMdGenJqxlCeGhUOTD?=
 =?us-ascii?Q?W65IF/e/XHfqNctQeLx7WUSERLgAWPjtMymNccLbytKpoPrTCf6JDSvzk8U2?=
 =?us-ascii?Q?PnIuoI3+iw=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a059a9e1-4eef-46dc-a1da-08da1148dc84
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 05:56:26.3218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xomwR6M/T/+Jrr7Kut03piqrF4yKpbigXOA5vuCh5O1xVlAeTpfoEasJNh6GaOGK9n0JfPTvGESkeoVGkWY67Q==
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

On Tue, Mar 29, 2022 at 09:59:46AM +0800, Limonciello, Mario wrote:
> `amd-pstate` can be compiled as a module.  This however can be a
> deficiency because `acpi-cpufreq` will be loaded earlier when compiled
> into the kernel meaning `amd-pstate` doesn't get a chance.
> `acpi-cpufreq` is also unable to be unloaded in this circumstance.
> 
> To better improve the usability of `amd-pstate` when compiled as a module,
> add an optional module parameter that will force it to replace other
> cpufreq drivers at startup.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>  * Update to changes from v1.
>  * Verify the driver being matched is acpi-cpufreq.
>  * Show a message letting users know they can use amd-pstate.
> 
>  drivers/cpufreq/amd-pstate.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 7be38bc6a673..7dc2e344f222 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -63,6 +63,12 @@ module_param(shared_mem, bool, 0444);
>  MODULE_PARM_DESC(shared_mem,
>  		 "enable amd-pstate on processors with shared memory solution (false = disabled (default), true = enabled)");
>  
> +static bool replace = false;
> +module_param(replace, bool, 0444);
> +MODULE_PARM_DESC(replace,
> +		  "replace acpi-cpufreq driver upon init if necessary");
> +extern void acpi_cpufreq_exit(void);
> +
>  static struct cpufreq_driver amd_pstate_driver;
>  
>  /**
> @@ -643,6 +649,7 @@ static struct cpufreq_driver amd_pstate_driver = {
>  
>  static int __init amd_pstate_init(void)
>  {
> +	const char *current_driver;
>  	int ret;
>  
>  	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
> @@ -653,9 +660,15 @@ static int __init amd_pstate_init(void)
>  		return -ENODEV;
>  	}
>  
> -	/* don't keep reloading if cpufreq_driver exists */
> -	if (cpufreq_get_current_driver())
> -		return -EEXIST;
> +	current_driver = cpufreq_get_current_driver();
> +	if (current_driver) {
> +		if (replace && strcmp(current_driver, "acpi-cpufreq") == 0) {

#ifdef CONFIG_X86_ACPI_CPUFREQ
> +			acpi_cpufreq_exit();
#endif

We need a kernel config checking here, otherwise, it will be built failed
once the acpi-cpufreq not set but amd_pstate is set.

Thanks,
Ray
