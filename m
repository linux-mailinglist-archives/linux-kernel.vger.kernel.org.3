Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D3B56AC0A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 21:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236396AbiGGTqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 15:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235994AbiGGTqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 15:46:22 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2F632EF3;
        Thu,  7 Jul 2022 12:46:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPiyQlKwW7jmJ+XxgPmLDF1vaV6ixIyIwISchuJb+SBT7n7H7r2nPJmvFxwCq0QOCNCvuGrUmrws3H1rGP+K5ihSWZJLMmgy1EAm/r1OEfXoTzUbvK5RdoxK8Iupa6dbCdYZCsK/q+6/+8CuGwvCEB6ssG0YRs6kIC5RS+P3ZnFuaLk1eiI/w45rZoNpvsXrpdGtPwD+NEqswJS0v/Gj/wz9+iEbi81/5Q3s8shsnVTNjFpZyhX2m91OezYx0pkiTOxJcs5i0T1F0Xz8gaTeQfv5gRVU6Z6G9jTgvxonJBETf2M7+Q3NxvVR3mtU1QmVuzGkyV22OpCIj6PqnCAlpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=df2rFbwdC9wwKLpm2P8SkhYr/176yFg2xA+M7AuJyyI=;
 b=KBdV8MNafAp0jGI06PcAe6x+kc+sKfmWBhKo0SYrUQYBViXlGUPjKKs8nxGKtnVNUobkkUoNdFcw1IOrSpR3/ntkHL84pEvzpIXNqc1pHtvdLEM7mb5du4CP44qyGVkjgl7lr6DFfQcUfXRP5Xa4Td8XFusXwAdokMql/XNBAYAPzjAujWm/qOaCbl5P5YdkXh069cYscm6PdPahzV/IjyTcfLBeoJEEW6c1m6tFiGP2fTWtj/gDi/CVQQNr5SGpDh24j9dKBDhfR8Ne83xjeIE2lyJIeuBbnykubnI5J/rMZb2yUNSFZqBBCfUg5QRWQW9A2Z36PxVguNAIzTXaQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=df2rFbwdC9wwKLpm2P8SkhYr/176yFg2xA+M7AuJyyI=;
 b=VQ35mtNg59Cyf5cwSK2Rh1ItGlixQo/hoNn1IK5uKuwPz1LJ1+LrU62t+zCIXq/LyP668uqBsWomR0MnodsbwK03jsV8k9iml9v6WCYy5nn1rySNSf8dTyOb8qXl9PkfMzqUHBSZ+oNoaqY5bPCVt7LGz0EyDP10aK05CI9ORHU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 by DM6PR12MB3291.namprd12.prod.outlook.com (2603:10b6:5:186::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 7 Jul
 2022 19:46:15 +0000
Received: from MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::ec96:60a2:ca21:17d1]) by MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::ec96:60a2:ca21:17d1%3]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 19:46:15 +0000
Message-ID: <e07cfbfd-da96-1251-4d17-2e4bef64e355@amd.com>
Date:   Thu, 7 Jul 2022 14:46:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 11/12] cpufreq: amd-pstate: add ACPI disabled check
Content-Language: en-US
To:     Perry Yuan <Perry.Yuan@amd.com>, rafael.j.wysocki@intel.com,
        viresh.kumar@linaro.org, Ray.Huang@amd.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Deepak.Sharma@amd.com, Mario.Limonciello@amd.com,
        Nathan.Fontenot@amd.com, Alexander.Deucher@amd.com,
        Jinzhou.Su@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
        Li.Meng@amd.com
References: <20220707170116.216912-1-Perry.Yuan@amd.com>
From:   Nathan Fontenot <nafonten@amd.com>
In-Reply-To: <20220707170116.216912-1-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR19CA0005.namprd19.prod.outlook.com
 (2603:10b6:610:4d::15) To MN0PR12MB6222.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69ed68dd-8d30-4bde-7241-08da60515a22
X-MS-TrafficTypeDiagnostic: DM6PR12MB3291:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rWd0FT2bkrE4WkIQlaBaO1cah+Lqq4j8k1HI8d57Epf7Iu077i1WU8UAH7DXW1H9LflpIsnbUNnObb4jDddgOoGD5CmbgKGkEylhKqKDDNerBgkMSaeZiDmgxDLqU1VzJ0sYTvT06kfW3HOLF8mmu7SG+R0Q15XI8XeP6eSW58PNUQWlZ7L7UlU8wjizD9NgVie3W4zCFJP9LTQ4YckiplA55jzYt2lKno+ACr2nQc/sRioy3LWTbGfS6t/Sl/Pkfbo74FTdQUXYIcTNJmA23cS1yaU62VNDgPV85fCmEp4rRnZE9tU59fvXJQ92cpQFNur1jzcigLAOLo7dLo/WSt8rUzAGvXTqYhsihU1EgM708Z+JTlalYtBBxFAfUzFGV70H6U7StclJ+KWcywz7MibtwqT49Spo9YdkaZIH7WCnRQRnpRU/WCUF3sXBec8EjaT3Dd7eZREfNccFLtvd3sRGe3+eaF0gEI+f/nxql57oW/0xtCvzgqFWGe6/jetB0qXXyL63mnBKOCBJxRLHmep58WH60zHDCUdcjtDRHjPxMF5neS698yHevHl09FHnfymoHWHdM0QTYqPaFFYcHs46y2iFIyNue0gCWoAcw+Bs8a/6+m5J5VvNWVcdD2AqIZiq4OdupgadLXbm19yNpYbmNaQcdB/FgblHNDcEsJP8C6WAMTa6DuT9U9ja7iBDNLUw0zcIxI7ppwfR1Guc+9y0TtoQwp8ZLFRlLemia8iJ9u+l40L4T9pIqzXYIRJplI+5J0vxqaTIbZIR52wbPmkqeTGNMP5injNColwattrDC2urKkLb92B5RS7LXoZSFKYKZ2qUfYogIZLPZ2JDkHiNynRQdeMx5Z+egMd+Nc8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6222.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(376002)(396003)(39860400002)(346002)(5660300002)(41300700001)(31696002)(8936002)(478600001)(26005)(6512007)(2906002)(6506007)(53546011)(6486002)(38100700002)(31686004)(6666004)(2616005)(186003)(83380400001)(66946007)(8676002)(66556008)(110136005)(36756003)(316002)(66476007)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1UvQXJ6L3A1UkZEVGFuZStVYkZEQ0Y4RlpUOS9iVitIWmEvaTVMZ25jalhr?=
 =?utf-8?B?aTJWVDA4Um83OXNUSWZWMDhDS2hZcmRoNkxBanZoRWE4Y3dEMTgvamJIbkRE?=
 =?utf-8?B?MCtHZWF1TXR6NTREK0gyMHpCOVI3UjJuZTRiZlFnRTBmVGlFUEdHZFREWkdN?=
 =?utf-8?B?YjZ6Y3M5a1BQZFdUOTVmSXBQNEtxMW9YNXB0QWxaMUp0TmFiNzg1dFpJaGZw?=
 =?utf-8?B?OURVWkdIRzlGZjJ4T2hMbEFjNnFyMmNpaS9rVC9vUTJITm04MmF3M1RZZkQ4?=
 =?utf-8?B?UFZxSFZ4L3cxRmRkMXM1VUFPZ3prcnVsbzEyNzFpVCtBd1pwdVVBWHJucWRt?=
 =?utf-8?B?VldDVlJwaitaWnltSXRiTktSZ2h4eTZJc2NQU3MrWVRTWGhsSG9BVGNHMUlN?=
 =?utf-8?B?WjNhNEEzYkxYRU1qZFdwS0prbjNuZHF2dDdYeU0rU3grRmlBY1NzWHVJaUh5?=
 =?utf-8?B?TXdBalZYT0tLcjkyZituNkIxOXpoT0E0ZXAzM0M4Nm5ncHV3OGQzQnJrSWpn?=
 =?utf-8?B?KzNQZFJxdkxxL3dyNkJRRE91VVMrRkpZS2p4dzNMR3kwMHVyWWFhaXZZc1BU?=
 =?utf-8?B?K0lFdUFrelVMZVJvUlc4THR0NlFiM1ZRajVWMXo3UGtqcFEzWFpKWUhGM2JK?=
 =?utf-8?B?YWFOTFBQcUM1ZlNOdDYyMXBLK3gwWS9ab1R2aDBFR1hIdTkxUHZ2dkFNZ2g3?=
 =?utf-8?B?OVZuMVM3V1N2b003eHdSRVM3SUQwQ1o0N01XREZXWUxkTlFGYU4rdjdXMGlq?=
 =?utf-8?B?U0grRTV6dC83Zlh5N2hFdWpPWHFWREJjenVLdGRRZ0JSeW4rWVBSYmVsUWxN?=
 =?utf-8?B?dS92dVpUdnlEdy9tcEh3Q3VGU01KNlEwdkRSZ1BoOVNoUks5YWZXTlZvSlZS?=
 =?utf-8?B?dFV6SWZsRUJuVWVlY2ZHMzdYWkNVYnV4R3hBUk9QdnhJSmZyY1JYSURaM0t6?=
 =?utf-8?B?VWYyNWFLOUpMQVA2bkRhdWh6eCtkOUdmdUNrSnU1ekNWSmsrZXBEdUpMaXUr?=
 =?utf-8?B?d2xtWjQ5WFFWYUtmSXNWSkVpYVN2Zk1NLzNHb2dzSXdHRUJQMWpYQ2JRcnox?=
 =?utf-8?B?dk5tdnQxWFVvYUNxSlY1REwwN1JsWE5tVkN2Nkt5RHlEYzBoZXNNWGxSM3lD?=
 =?utf-8?B?clI3Y0ZnNXAvUldUMitjZnFwVEdoU0NEQzVraWY3bldUSDlTMUZLYTM1NGdQ?=
 =?utf-8?B?Njk5eUJHaEVVZERPazVLUnpLZUFaYmg2VCtDNkFWb0w3aFBvYTZHNXhpUFlW?=
 =?utf-8?B?MkFmQmpqL3d3R3FCZGF6N0hrSEFCUnpwQXg4TjlpK0EzaVNXSkZiWDhDcWJE?=
 =?utf-8?B?S1IrNGppUmxMYllUbU5SaDZHV1hxcnRnR1ZEc3VuV3VDdFcyWDRETzM0bFlY?=
 =?utf-8?B?M1BkSDlyem1VQ1JMQjlZT242R0VRTE82YmpzTFRQenZBSWhlQVdLZXAya3Vk?=
 =?utf-8?B?QS9xZ2RYVUVjZjdCb3gyYVFOclpIRTBEb0ZQUFFJMDZ0aVZEdHBLUWNPZGdN?=
 =?utf-8?B?YmxRZWIyTmd6N1VyTWE3d3JkUVpVUXQyK3k5blE0NXlMeHNETURJbmRwMld0?=
 =?utf-8?B?b2RwVms4bFFCMEpZNHM1M0t5WTZlQ1lyK2I4VDl5UG1Ic0NnTm00dElPNC9p?=
 =?utf-8?B?NG12SXoxQTROTXI5M3dVdXBGckFOaTVzT1dCb2hJVHlKaHVpN3ExYWRPbDFS?=
 =?utf-8?B?OTRxTENWZHFqdEJDdTBadnpFWlltOTA0cTZ1UERXZFVvR3R5SEZpNnIwZkNu?=
 =?utf-8?B?UzgzbnRob3ErK0c4eFFseFMrQlA2cm1ZVEFxd0VxUHVtU0lQcSswRWpjZTMz?=
 =?utf-8?B?WUZpd0ZJaDlBRk1TUzBWTG1FbU8vZDlSRGVxMml2UUk4cURqeFVBQ1lCYUlL?=
 =?utf-8?B?dWM5NUl0WXF2ZytrM0k4SmVlK3pqTEZqRSs4alRrcXdUaCtuekhsSGMvUzdD?=
 =?utf-8?B?QTJxT3BwWW9ORk9IVUsySkZCMUZOTTVDdTRoNmtPL0c4V29nckdlNmNxZ0Ns?=
 =?utf-8?B?N2pjcFU4cXlNVnllNHFZck1NR2ZCUW5OQUZ1MHB4aEt2QmdnNzJMMFE4UmRE?=
 =?utf-8?B?eG1zT21xQlJzK0JhWkVmWGxmMng1dHRUNEs1RktFU1RaNUNUUklkbW52bXIx?=
 =?utf-8?Q?s6qW2OtpIi1Fi9R8EkfBTgt74?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ed68dd-8d30-4bde-7241-08da60515a22
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 19:46:14.8732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hkmGYDILQVP4tl0AxpcYXQYGBauU9TpOEw+mcQnJRbL/pNSR6AJVBNpsFpZcsnfMZsuBW5ma2XHoN4Db3RvuqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3291
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/22 12:01, Perry Yuan wrote:
> Add acpi function check in case ACPI is not enabled, that will cause
> pstate driver failed to call cppc acpi to change perf or update epp
> value for shared memory solution processors.
> 
> When CPPC is invalid, warning log will be needed to be printed to tell
> user what is wrong.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/acpi/cppc_acpi.c     | 3 +++
>  drivers/cpufreq/amd-pstate.c | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 6ff1901d7d43..17d67e3ededf 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -424,6 +424,9 @@ bool acpi_cpc_valid(void)
>  	struct cpc_desc *cpc_ptr;
>  	int cpu;
>  
> +	if (acpi_disabled)
> +		return false> +

This seems ok, the only other places I find that call acpi_cpc_valid() also check
for acpi_disabled.

If the acpi_disabled check is added to acpi_cpc_valid() the other calling sites should
be updated to remove their check for acpi_disabled.

-Nathan

>  	for_each_present_cpu(cpu) {
>  		cpc_ptr = per_cpu(cpc_desc_ptr, cpu);
>  		if (!cpc_ptr)
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index b54b3b559993..6d81a9a94dde 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -684,7 +684,7 @@ static int __init amd_pstate_init(void)
>  		return -ENODEV;
>  
>  	if (!acpi_cpc_valid()) {
> -		pr_debug("the _CPC object is not present in SBIOS\n");
> +		pr_warn_once("the _CPC object is not present in SBIOS or ACPI disabled\n");
>  		return -ENODEV;
>  	}
>  
