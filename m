Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD73E4908F1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240037AbiAQMo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:44:58 -0500
Received: from mail-eopbgr140117.outbound.protection.outlook.com ([40.107.14.117]:52711
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240007AbiAQMov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:44:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nODpUDDlXmotwOL5xybCdUYHOJN3u7F+6tVq2eprW7q1q9PM0EiPVjP7xbCBVotGi0HToDimkNQY51rGEXbYDWa2f/0mLPTbmCCM/yvqFgf/5RyTMBiCePH8YTOTV20VxDa2F1NA8MK+4e2WDS+AsKPbOZ/cr9+nQsiUcKmQ/gYPaMK5rIlbLjeGJIKM4fIcRaB2FvweHdmzDZf+ZIszFaklzgt6CWF3SkV/bixnKwVlTGIujtrRlhSJ/nZ42UBwH+MNvkirmJfCxpvOb2Q5/XdJKiyrtSz/kLqp/Ckhq5/oR0niZJVLWFtOL6CVXWHuaU5qt9E8uEd/4QWJnwsdhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lw54/Cj2W4TuWgXUrzuGcMVdDwqlsVEwuSXh355TPrI=;
 b=I3aOHy+JNX0DmrLwGM6PjvK6e7nBr09DrxHsfz0W7HTl2V3Y40vjukdPqqQLHXipYXeB2Auc5toruDHaZaORY9U9IVbnx+rCXKxlEAyg86npzdBPlm3xziqJHCWaudxKKx0TAdi0k6jiVLRAOZqAuXEqY88JH62p8DDf6/KmDhGhtoiXJPAl8aYAcg/RQQUuZXiYzLdKyG/mhbyAEJBl8CQh+EGvqhfpguc25+prxphPmEOMjlfotaLekWS1uHSBu/CVbbIoz1dbF6NEpiuWUiuE3176bCQpnuYs2F4N2ZVNHyeKH2x0rKUHnUWz1sL8+rN775wkr/RMpL2vLxKk8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lw54/Cj2W4TuWgXUrzuGcMVdDwqlsVEwuSXh355TPrI=;
 b=Beiwf9nE/Kg1FnSAbFOsh/YH/VPOHwpTna54Fyjl2mrWNZQJYTbK+NrCDZIA9BNz5/MZtDJvBD5AjcffH/Ta7sqcFafolkSEMLvSztSo/VBs7KlC2olYTsqf7IfGRwwYkEFv1mjVbUaXlVfiTSViZjpF8kFlYSr2YxS/p4tW4gI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com (2603:10a6:208:6e::15)
 by AM5PR0701MB2961.eurprd07.prod.outlook.com (2603:10a6:203:47::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Mon, 17 Jan
 2022 12:44:48 +0000
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::6008:d588:5745:4877]) by AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::6008:d588:5745:4877%3]) with mapi id 15.20.4909.006; Mon, 17 Jan 2022
 12:44:48 +0000
Message-ID: <c92e2db9-00b4-8800-e800-046d564f52d9@nokia.com>
Date:   Mon, 17 Jan 2022 13:44:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] arm64: move efi_reboot to restart handler
Content-Language: en-US
To:     Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Matija Glavinic-Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <YeVhtL2gCLkhTPdv@localhost.localdomain>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
In-Reply-To: <YeVhtL2gCLkhTPdv@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0202CA0015.eurprd02.prod.outlook.com
 (2603:10a6:203:69::25) To AM0PR07MB4531.eurprd07.prod.outlook.com
 (2603:10a6:208:6e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50970c0b-ed31-416c-a361-08d9d9b725d4
X-MS-TrafficTypeDiagnostic: AM5PR0701MB2961:EE_
X-Microsoft-Antispam-PRVS: <AM5PR0701MB2961D0F2CB8BD55D138AD3DF88579@AM5PR0701MB2961.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kk0AxtL6L5G72QvZsGuNojsMyJxYb7+6d1oLMp9AA4+4JLw422g6kpudfYcINnfOrhFkp9LYuKwF/xGFnlLXLRBfgp8OqryKCDFxmtLGVvtlUXR/8Qwa+/e4x3uqzD8elHVbJBQaEIJ7XhYdvPWYBV3Jpo6Glvwz9BUrCQms9qcSJPFXsHUhEXcPJWfCzqIeeECjpujPFcwKrtX2dOKzPh5qObMri7xdXbd1ikAe//Qt2Noh+g1RGsRRNATRnXZjm1YwobcNs4+lU8NHcfQy5juXQCGmnZZxVGPWhOB5dvEg827SF0RYF2lyBzXNVgbzbyrxfj1Ab3qemVp/c0RpPYuzNJM+TnNAUFAzZPm5viBrgAU3unbm/21w+815xF27zKGQyZYeczFsF98qMoN9J8ugmoQjXXus8Pq5xqc9bvGRUhIqygE8F4W6C9/McmqEnY+klIBX/LxdDyHA8QkCAHjWxVmQ/F+Ou7nSoDP5ClgVaYCnEkoDJuSBlHeIHM39G4BXAiWrsNREmGdfXfePTjcT4a+pPE374DB6PB9jYPEgd+091+EC05AbzgbP9z+XmqXrEjQkfH2Yd4nxJL3i8GGNl/8SjNRSQ4nGzcJl6xXFB0Q1E5OU2RYZiC5feYpmK6IO7bKjDXnWVIek3UDRt0yK/iAyp5aKEZxziWlPj7mb06KJAwvxU82Fnd3NVcJWXo9jDEernsmTX8aFRwS86AY4Wo9cozHUmIwg/2B+wy1O73s503kD3kK6Ov8z8p+3k5dY6Z8mnHPmf6RFqtosAVr4bECFg2BQxVRxqd6VsioJxj+cVCT8eHoZ6Rq6Bjbc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4531.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(508600001)(6486002)(82960400001)(31696002)(83380400001)(38350700002)(86362001)(53546011)(52116002)(2906002)(2616005)(4326008)(186003)(26005)(44832011)(66946007)(6666004)(6512007)(6506007)(316002)(110136005)(31686004)(5660300002)(8676002)(36756003)(66476007)(66556008)(8936002)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTVTZE5WQktPZVZQOTV1YWN0Vm92VnhkcVAwTnJGSGdLb1JiZlFScll2ZU11?=
 =?utf-8?B?WHlPK1VPZzIxNktibUNqUFRrRVA2a1dtSy92NmcvUE5HSHRUbENlaUdqYnBF?=
 =?utf-8?B?TWFCd0RtQkhoc2p4SEpQSmtuVll2em0vYWs3YzBMU3dieWovSk0yMndudkNC?=
 =?utf-8?B?VWdHV1pXQWpFY2M0VGY3SURjamFDMlZzMU1FOWI3b2lQOVI5ZGR0NG1XTGVR?=
 =?utf-8?B?SlNYNGJqNVQyNDdhVHBiS0NSakh4S0hLSlgrS2dsZWlJY0g0QlZXbDM5Umx5?=
 =?utf-8?B?K1ptSnpMWXJsL0p2empaMTBnQ3c3dTl2OE5icC9IT3dqZ0hyTlY1U1JkVWpG?=
 =?utf-8?B?Qkp1bXlxdEI1czByd2Zqb0tMSXQzc3pMdENPczFQdnc2OEE1K3ZXKzViMlFY?=
 =?utf-8?B?ODEzY2xlWHhHL3JqOWJrdkg2b0dSZWhJYUtFb0tTeFpCZEVUVEgyYUFXL3ZU?=
 =?utf-8?B?c2FVK3BxelpibmNyOGtwUWhOQkQrV1FMdUhKOVlsU3o5dzkvSEJxblpQM2Yw?=
 =?utf-8?B?R2ovZENkVjlrS3hzT1k2UHBFVVV5RS9Kek9ISDVrU3JxcHZFTE1JSitxSEhk?=
 =?utf-8?B?SmZoUlpPNGp1TU9keDliS1ZSTllDczE3bFk0QXpxYlV2OThkWlhCMEYzcCtF?=
 =?utf-8?B?V3lBQ3BqRUVyTUpxRHd3TWtXU3RaclIxZmNGUEhyZlYrMWlXbWtBUWhxeDR5?=
 =?utf-8?B?dlRuTnZQdlovWUVZUUxxZ2xTUVFyck4zRWFKY1JGQjNCbmRrUzQ3UFQrMit1?=
 =?utf-8?B?b2QwN3R0bHpQVSs4MDZJd2w5VnFxTHhmMUdTL29FRGRGWFJLN2xGbHdGd0Ur?=
 =?utf-8?B?M0tialEyaHBvclJxSTYrWlBEeGZpSVl5WWorNzhxcDhZaEg2aExqWTdVdDNV?=
 =?utf-8?B?dFdHbi93ODRBUXdDaVdBNHRmbEo5ZnRTaHpXOVpzd1dGM3h6cjE5N1FRVUZU?=
 =?utf-8?B?d2J5cU9zTDdZcVdlVDVwWmk5VzFmNEJBeWNsZnRCUld5YzJ3ZG1NQW9NclQ4?=
 =?utf-8?B?TlpjRTJpWHBXN3BzWFlHTzd6c201K3pTTU1TV3Q5RVZpby9rOXBJZElURkhl?=
 =?utf-8?B?c040OHBCVk5oeHdHQ3BVbXBVMWI4Q2ZIY3JWU1c2T0M1MGoyRjd3WWZzNXBk?=
 =?utf-8?B?WnNqYXJiaFlIamY1c3p4QWdBaHZHb3FudEV6dlVHa1BUcE1wamNEUlMwbjF3?=
 =?utf-8?B?NEg1WFNHNEJsY2lVOFhleFVVb3BCOHc0eHJOcUVjTFcxWlNKSllTbWdBVXhG?=
 =?utf-8?B?VGMzYkl3bWZrTE1XSzhya3VYNVo3Z3VPTDJJUkRaTXlQeHBndTFvNnUybXg2?=
 =?utf-8?B?dGdGck9EMUxvckw5dTl5VG5vMitBa3lzQnp3T0xZVG11YTZOS2gwSlFUc1Ew?=
 =?utf-8?B?R1luNE5IUytsV3NSajAvR3Q0cUZ1b1B0em0wOTRSWGprT2JrVStIY3FwMnM1?=
 =?utf-8?B?LzZhOTVHZG5sZ29TVTVuU2tPOG4zUDFCNlBmQVFFRXZNVXVBWG9SZFdNd1lY?=
 =?utf-8?B?a1RPZkdMRmZoUDhaV3NjbXFlUUdadWtnTGxiL1ZMUE10dUErbVJKelJXNXRj?=
 =?utf-8?B?UFR4TnREeU4rc2lyZkpyVlA1SUFGenY0cUJkOG1KSzc4SGc1bWVJK2VGM2lH?=
 =?utf-8?B?dkY2cUo0Y01rUUdlOVpKSkFxdFBQdG9uc0ZRZU8zMnV6WjBpaWdtWWZwcHhP?=
 =?utf-8?B?RGViakM1V0hyZE43ZTQwcG5LcjgzMEs4cWJhNnBXNVBMd2RSZG83RVk4cTla?=
 =?utf-8?B?bHlZN254enZOVkEwOFUwNmlzcW9NN3RWTzRSMFBCbzBRR1dEM1F4ZHljbUE1?=
 =?utf-8?B?NG13dGp1MjQyNXl4U0NWWFdxWU1jRFE3UVJ4ZWRqa1NDV01GaW9NN0hzbFFE?=
 =?utf-8?B?Qlg5YVFJczBoQ0l3aWNzd2gzWkN0MTNpRW95WXFVczBOSmdsT21nSVFWMXlB?=
 =?utf-8?B?WGNWQkl2a3B1QWltWjk1VTQ1TlBUNlFJWnVwNEdWL2Z5VGtmUjc1K2pyR1JY?=
 =?utf-8?B?dG1aSlhnaFBMUEpsK1JqU0tibXB6V0JrQkFab1BnUDF4bG9xeGQ5OFNPM09T?=
 =?utf-8?B?VHlHb0lYVjNNTXdUeDRzais2RG83cVZ1M1lzYVlSS202SCtSeWFSMllBMjZB?=
 =?utf-8?B?VTZEb2h0aERpbUNWekVBZnJJV3h0TmNPRStCd29rN1pISzRTeVBWTUd6U3ZJ?=
 =?utf-8?B?NWVOLzNUdTNnNjVuaS81VjBhTzNJMXlhS1NZaXJGVlMzV3JKS1o2Smk5Rlcz?=
 =?utf-8?B?U0RaOG0yclBXOU0wV1lvQlFrVjJnPT0=?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50970c0b-ed31-416c-a361-08d9d9b725d4
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4531.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 12:44:48.8289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aH7tg0DeeJ3HfZ2DEPdhnfXc1JdKf2/vKx9OvM3+qI/zu6QvC4yH5rFJ7pPMjk+7SJdTdXBjwKbrRES9gKM1kS68XmqxK4ArxtyOBmrGcHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0701MB2961
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 17/01/2022 13:31, Krzysztof Adamski wrote:
> On EFI enabled arm64 systems, efi_reboot was called before
> do_kernel_restart, completely omitting the reset_handlers functionality.
> By registering efi_reboot as part of the chain with slightly elevated
> priority, we make it run before the default handler but still allow
> plugging in other handlers.
> Thanks to that, things like gpio_restart, restart handlers in
> watchdog_core, mmc or mtds are working on those platforms.
> 
> The priority 129 should be high enough as we will likely be the first
> one to register on this prio so we will be called before others, like
> PSCI handler.
> 
> Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

> ---
>  arch/arm64/kernel/process.c |  7 -------
>  arch/arm64/kernel/setup.c   | 21 +++++++++++++++++++++
>  2 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 5369e649fa79..b86ef77bb0c8 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -130,13 +130,6 @@ void machine_restart(char *cmd)
>  	local_irq_disable();
>  	smp_send_stop();
>  
> -	/*
> -	 * UpdateCapsule() depends on the system being reset via
> -	 * ResetSystem().
> -	 */
> -	if (efi_enabled(EFI_RUNTIME_SERVICES))
> -		efi_reboot(reboot_mode, NULL);
> -
>  	/* Now call the architecture specific reboot code. */
>  	do_kernel_restart(cmd);
>  
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index f70573928f1b..5fa95980ba73 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -12,6 +12,7 @@
>  #include <linux/stddef.h>
>  #include <linux/ioport.h>
>  #include <linux/delay.h>
> +#include <linux/reboot.h>
>  #include <linux/initrd.h>
>  #include <linux/console.h>
>  #include <linux/cache.h>
> @@ -298,6 +299,24 @@ u64 cpu_logical_map(unsigned int cpu)
>  	return __cpu_logical_map[cpu];
>  }
>  
> +static int efi_restart(struct notifier_block *nb, unsigned long action,
> +		       void *data)
> +{
> +	/*
> +	 * UpdateCapsule() depends on the system being reset via
> +	 * ResetSystem().
> +	 */
> +	if (efi_enabled(EFI_RUNTIME_SERVICES))
> +		efi_reboot(reboot_mode, NULL);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block efi_restart_nb = {
> +	.notifier_call = efi_restart,
> +	.priority = 129,
> +};
> +
>  void __init __no_sanitize_address setup_arch(char **cmdline_p)
>  {
>  	setup_initial_init_mm(_stext, _etext, _edata, _end);
> @@ -346,6 +365,8 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
>  
>  	paging_init();
>  
> +	register_restart_handler(&efi_restart_nb);
> +
>  	acpi_table_upgrade();
>  
>  	/* Parse the ACPI tables for possible boot-time configuration */

-- 
Best regards,
Alexander Sverdlin.
