Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E4C49FB87
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 15:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349055AbiA1OVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 09:21:42 -0500
Received: from mail-eopbgr130113.outbound.protection.outlook.com ([40.107.13.113]:40566
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245136AbiA1OVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 09:21:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmD9AUy1eu60dkws6fIYdri4m39WVuzd0hnu5sXpAuAx1fTYhtwQGDCW/doszZ/spCyCEtT8Kescb5Xop1XX0uCPPiXtZLGs8MHmCvdK3jfvdXjBEpWOT4zIdMb1hYn6oOv6cXfEGcOlh3j41AtiBJX5IWhWJdobQv3UlApksuwAgVjv28wXMPyLuytmgunqtFun1FoBIChm9ClElJOwu+r60RB/WbByUc3mAdpDQMpKNtpwAr55uPPk6QoM6Qkh44dNTVUOCPi3coRE8QQMPr9RjUcHR/Ks4sdsP0xPseeoJXdguRD9PqNiKPeSeob/bASbDuqxG4WctkjATc1Ylg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMyOTMCxnh4OQPROyddIIZnzyn8jFTfcj1CYbGw4/wo=;
 b=VlOWfDMnqoQoa95g3GIQvkPeYEPvtkpFqdcYFCi1YjnG0rElbdr7a6Rh2PxkbGfzyzZ6pIv9/EntSH8ogRqJwZGe5EkVmA6EgUO9pwcWqePLLQdOeQ6UnoqM72sT9xWQb5J4CPP9aV/BA58AjQTTqh4wMOUewZ0fANYcikeBVO93BJ3bRbjwh7WSRCNICauf0I2TMfg9QI4B3t64b1DFrzlXGO5b6bj+OJ/w2jMRvxMxCXCKp0vl7lPEiGxPkvR5H8AdgH9Gk5M3VHja7PWXAQ1wxgvkaRLhG3SQ+3yMZ7qBwOc2p9+BUgtHd3wSfP8rY7m9AISPU7s/QQx/okbouA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMyOTMCxnh4OQPROyddIIZnzyn8jFTfcj1CYbGw4/wo=;
 b=s7PFjL0DZqs5kCWBYQtzASElQPNoE4UXZtE2hj0i3ceCQ9s6KduVzDEVlE8spN181wr2EQBAMzSB9cRfLukKe7Fx5FBGKzeSuzCAcWU88j0AQQWXi2DCRRAOUPuxzvdQzAiQYTwGGEUicgnweJEEKggMEkaGE3dWUZ6r2tzA5Wo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com (2603:10a6:208:6e::15)
 by AS8PR07MB7591.eurprd07.prod.outlook.com (2603:10a6:20b:28a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.8; Fri, 28 Jan
 2022 14:21:36 +0000
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::7c27:bca0:d64:d78b]) by AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::7c27:bca0:d64:d78b%5]) with mapi id 15.20.4951.007; Fri, 28 Jan 2022
 14:21:36 +0000
Message-ID: <f0575d3c-15a0-8a33-9fbd-8ebe1be33034@nokia.com>
Date:   Fri, 28 Jan 2022 15:21:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2] arm64: move efi_reboot to restart handler
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
References: <YfP0osb45uJldtM9@localhost.localdomain>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
In-Reply-To: <YfP0osb45uJldtM9@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0254.eurprd06.prod.outlook.com
 (2603:10a6:20b:45f::29) To AM0PR07MB4531.eurprd07.prod.outlook.com
 (2603:10a6:208:6e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6052a97-9fb8-4b84-ac07-08d9e2697dd3
X-MS-TrafficTypeDiagnostic: AS8PR07MB7591:EE_
X-Microsoft-Antispam-PRVS: <AS8PR07MB7591AB59F5F5B1BAA21E59D088229@AS8PR07MB7591.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K41iprmasxgtfNMYT2MYxvib42M/8a9lPGGJtrklYDgh9PETyGL1DFau+3CSHevHQUttMPjMgjQsa3Y19f4WsKpHwrn12Hr93zkGQai2LRMtnIWyrDcq7eb2+RXkant9M2wyY5+uSxIpJRw5mGWSkmWriers8ME+xKYwXgjm6Sn4GUF/+cFTLZxy4QM5z6qIUwhsFbhszjgdi4CWnTYkFcHMnt5YQSoU15PrqK5aFzkdbgqVMGUc8Hut1vKNPoffYQHmmnPcYkPm0j5ThR0lbdh5Dci3gBpZxJBzdFXJ6XHGNtVgITfZX+s9TjPEV97Qi1OmdKv6ZNJxI2tML/bWrjk2+RMb2ZXBorDeWW6m03rkZaHjTRPGKHqmSzCKEv9FulHCh2OGaEDqlGRU6L5mJKyfJ+BfWv/X4hCJJsm67Ay9JHWSrvDlKnhMlTvADAczL3pBmDPYGWmJX5z9dY6xu9YY9OQA3nmDhPrVF7eo1bchtEU2bHTJD9jjNZmk/LsXIG/jBPgy1eqSjGgO+RvBH7ndIrTaCpRdcnjymG9ZemFD42iF82PlDbPUj5oTIEE7ElId2f1NwqLuC4Lr3s55s/DfMRcUrJTr24i3LOTFtHexhF2wGU4l/R1S981jwWcX5URf+MipdeLdyeuhixZYuhMAqI3aqQ+YO2mUao6f5gLP9Y7/yw8AaTmczOWFGcEgZF0amXOtVU7hDiWgNnFkGMDW5DLZhx87uMSU8K6mibKmEP3OyFTD22gLK9i/xRxZKvd/oG0CoF5bvoONLWjMGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4531.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31696002)(2616005)(6512007)(110136005)(26005)(186003)(6666004)(83380400001)(6486002)(52116002)(86362001)(2906002)(6506007)(508600001)(53546011)(5660300002)(82960400001)(66556008)(44832011)(38100700002)(38350700002)(66476007)(4326008)(8936002)(8676002)(66946007)(36756003)(31686004)(316002)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THRBbkhyMzR6S09vbVRlcWUzK1R1dmQwQVBYUHhLTjFYRHlWWElYcTJTa0lz?=
 =?utf-8?B?R0pPTEUvNmlDTDBhL0x2eHdYR2xIWXN2a0RsSlRiL01JaWhQTkhwcjNTNUhI?=
 =?utf-8?B?M1dwQ0ZsRGl5L3B2TXYrSVlUODBsZHpNaFc4OFdGaHV4NVJGR0FXOXpDSElE?=
 =?utf-8?B?R2lzejhteENYaUdEVnFFU2FzaXVlOHhFb1V0bUpqeEpWeTdNRCtvN2hDUm5k?=
 =?utf-8?B?MGJsUjVROHNjSHEwMnh3YXp0OVJGdzRRTm53OFRCRU9kSkZiVVFnZmdkTWVx?=
 =?utf-8?B?ZzQ5NmdJblBEYzBGSGdXVU5yTjRtc2J5SkRIWG1GR1F6VmR6ZzM3azBmMEZp?=
 =?utf-8?B?a042NGRyTTVZMUIyREwva3hITW9MRU1LUjZWcEw3aWxrdFdyUWF4REUvWmEy?=
 =?utf-8?B?cUJMNThUZ05LVmtCdWlmZG5aSDRPY3lHZjNjMExaNHN2RGlFWU96VWhTSmNG?=
 =?utf-8?B?NjR4TndQOGhzRTZqWmFyelpuRHJqR3B3UWF4ZzB2TWxORVdnZ0dmQmk4UkxI?=
 =?utf-8?B?NEtxaWh5QnkwSXBjbVhWbXJnZkZZUHpZd3E5bHhYM3JucUNEQko4VnFQbG03?=
 =?utf-8?B?aUViNjFCcVlkTG9zNVoxMjJHSHBVWXg5TzhWbzVOMGE4NFM0dzVPWDBpQmg2?=
 =?utf-8?B?ZUYrcDZBTG12NWsxN0NqYkJaS3lrRjBSelBiMDc3RFo4dWhZbVFrVG4wbXBz?=
 =?utf-8?B?dzM1N0VjSnRnSWFQYndFODYraUpHZEY3R2dlTW5obzU0TloyYWZkK0dONnln?=
 =?utf-8?B?S0p2LzlsVC8yWkFhNFFjWmhhMW5iSjlsbGRDWFlOT1NjNVVzYWU3a0ZhelpC?=
 =?utf-8?B?R29PNjN1czlFOFdDYkROZ0dUQjU4WVBMUURHNFFGbWFSaU9NR2lybVpUbW5j?=
 =?utf-8?B?bmgrYlNSZlhiSXF5WFUyZnlqOTQyT1BuK2ZTcTlqQ1gwYjZuTWgvZzlyMjFi?=
 =?utf-8?B?WGZIQXRpME5nbDlpWGVSVWQ2SnR4SzJaTnBHck51ZWFBQWJHM0U2b3Q0UXNt?=
 =?utf-8?B?cWplVDhwTHVaZ0pocHZTR3dsNHN3K3p5S3h2eisxRjdOT2loYWFnWWlWeUxV?=
 =?utf-8?B?RmNFVklKZWJjVm9MeG5aN3ZRL3lKd0xEMGYyVkZrRjZyaFlabS9kMU9rcE5C?=
 =?utf-8?B?N0Z3dXZRc3hPd21oUmppM25ycmk3UkRQUFgxOHFhMmtUNXZJZG5uaS9Zd2py?=
 =?utf-8?B?TWYyaDZvT1RmVWFCdkFkaUVRMmIwZy9qSFRBY1hBVkdwWm95aWNXSGQ0UGVJ?=
 =?utf-8?B?UTQzUWE1aE9hT2NrRlFoZEpqNldZbE1hb0ZMQytTakZCYVVhTHRDUm12YmdE?=
 =?utf-8?B?T2hWNXN2L2t6bHhhKzBPa3VEMHFvTUw2NUNNR3dJcDgyZ1RTVW9Gc2xTL3Va?=
 =?utf-8?B?b0hWcDJ2REFzREtIK2dOY0pBVDN1ZVNzRWdQb2J6RzZSZURkdXhDTDIwWmNX?=
 =?utf-8?B?amtqUUM3RHlIVHdHQkhVQlZZTUpnN3lDenluT1grRldNZGNadzNObnlpZlJv?=
 =?utf-8?B?c3llemFGaEFka0JKSEVNUG1TSHhZazNLbnZCRWNvNkVMWngzRHdpdWx2YUpN?=
 =?utf-8?B?dkVMaXEzQmExZjd3dEI0bGYvSUgySGRzR2w0Z3EwRnF0N2s5M1ErelFFdVJh?=
 =?utf-8?B?di9zaDhSYmtPbC9sc3FIc29INFBBZm1OU0s0MFQ4cnQveC8rN2dpOXRPUXUy?=
 =?utf-8?B?RThKZDhNb1FJV3UvN0FkLzd5T3duMmZ1S09ML2dMZ3ZCVnhwc0NMVjh0RWwy?=
 =?utf-8?B?SUh0MjRKdUdHOWludEhkTDFjcU05TzJiZHJ6VEtobFRaTFdiaU9UNkNuaW1T?=
 =?utf-8?B?R2RvRWlpOC95SU4raGN3ZXJLODIzbndRcWlTdEpUa2FDYkZsZE8zay82em5B?=
 =?utf-8?B?K3dOTU40NktBZTV1a2M3V2x6QVJtSkxncjRKbkU4Z3Z2VkJNdm5VemE1dWlz?=
 =?utf-8?B?NGNyeHQxeHB3S3JKdi9GbExXaFhkV09Eb0N6cmQrbnA0OHZzR2JWcXhWSTRk?=
 =?utf-8?B?UlMwRFlLSEp4OUpZY1hTVWV0bG9ObUdQdWNLdG14Vm9Ub1llVVEzdHJPcXV6?=
 =?utf-8?B?M21xNFhtTnFReEMvc1hFS0E2VWJRNmZNdmcyNjlJNERycHlTemJkRldSWng4?=
 =?utf-8?B?MlVUL3BsNDBSM3U2YUdUZmF5MGM4cDJOdUFOdVIyYWZjSTRWTGFIV0RWSmpG?=
 =?utf-8?B?bWZUcmhaajhaOWhTWmtDUUdXTUt2aUR5azhWMnpKd0VFWlAwUWlrTHNMZktH?=
 =?utf-8?Q?fNyfFZU40eYIs8a8FGSCg2EPhIOqO/6/XJaG7XTRTk=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6052a97-9fb8-4b84-ac07-08d9e2697dd3
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4531.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 14:21:36.1665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m29u+ALdTfnae9pla49gvqdO12Q/qpyuOqWHjXeApSabg7THMq1nyGDYOE2S8YNt0NR61e8JOS7pa9yo+yQ12AwwEb9EY3yVgXqPZwlNEzI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7591
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 28/01/2022 14:50, Krzysztof Adamski wrote:
> On EFI enabled arm64 systems, efi_reboot was called before
> do_kernel_restart, completely omitting the reset_handlers functionality.
> By registering efi_reboot as part of the chain with slightly elevated
> priority, we make it run before the default handler but still allow
> plugging in other handlers.
> Thanks to that, things like gpio_restart, restart handlers in
> watchdog_core, mmc or mtds are working on those platforms.
> 
> The priority 130 is one higher than PSCI, to overrule that but still
> allow to easily register higher prio handlers, if needed.
> 
> Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

> ---
> 
> Changes in v2:
>   - Register the handler in EFI code, instead of arm64 setup.c
>   - Remove the contdition from the handler - it should be run in all
>     cases when it is registered
>   - Bump the priority to 130 to make it completly obious this should be
>     run before PSCI (which has priority of 129)
> 
>  arch/arm64/kernel/process.c        |  7 -------
>  drivers/firmware/efi/arm-runtime.c | 21 +++++++++++++++++++++
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
> diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
> index 3359ae2adf24..b9a2cdbe80b4 100644
> --- a/drivers/firmware/efi/arm-runtime.c
> +++ b/drivers/firmware/efi/arm-runtime.c
> @@ -80,6 +80,24 @@ static bool __init efi_virtmap_init(void)
>  	return true;
>  }
>  
> +static int efi_restart(struct notifier_block *nb, unsigned long action,
> +		       void *data)
> +{
> +	/*
> +	 * UpdateCapsule() depends on the system being reset via
> +	 * ResetSystem().
> +	 */
> +	efi_reboot(reboot_mode, NULL);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block efi_restart_nb = {
> +	.notifier_call = efi_restart,
> +	/* We want this to take priority over PSCI which has priority of 129. */
> +	.priority = 130,
> +};
> +
>  /*
>   * Enable the UEFI Runtime Services if all prerequisites are in place, i.e.,
>   * non-early mapping of the UEFI system table and virtual mappings for all
> @@ -148,6 +166,9 @@ static int __init arm_enable_runtime_services(void)
>  	efi_native_runtime_setup();
>  	set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
>  
> +	if (IS_ENABLED(CONFIG_ARM64))
> +		register_restart_handler(&efi_restart_nb);
> +
>  	return 0;
>  }
>  early_initcall(arm_enable_runtime_services);

-- 
Best regards,
Alexander Sverdlin.
