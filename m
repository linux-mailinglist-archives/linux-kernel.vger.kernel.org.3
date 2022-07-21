Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66EBC57CA8E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 14:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbiGUMUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 08:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiGUMT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 08:19:58 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70098.outbound.protection.outlook.com [40.107.7.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02E67FE67;
        Thu, 21 Jul 2022 05:19:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SP8XJW14hHZjIT8ip8WDgghIxmpJ6RQKk95q9F2IwWn8DwYUbSDo60YKnekUJ1eRj93qt+IAhjTdslla2Wu06GWKwm1ckMmQpxQxqZdoStSSAz+kOcOJv3oXj2lUa8c9fOs9nMa8/jI/696aOoboID8QSuftnX4+OrQhLCC6rQStUdMR7ttygXMI8jrCTrx/f+EPfV+bzHSKYOl++P32w2RdVkJ1tdFiTngYtelO6c/777c7IlWq66WqjTi8c21ifWdt7rFg+VvYZ5fPXHZw5PyIMCN9XpAjt6za90W9Ja/6aogcRhhyI1H+jxqttxLyPS1XPqpKALtGJHOAsSbKbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+i1hrj2segD/Te2YIbr/9y9HWqZ3Xc0qb86uKqmbwQ=;
 b=E9MAvKYtRC17qoY4XqtjLZWHeFLEoizI7C6tCJBaLat+OAUCh6Ulxd8cexEQSYwvjMbLfVY571oBn7Y+w7Q9xSElRBULMJThhzswY4saBcxtPFIf4jzj14rmoTHewipWYd7GKk5HNQJM/vQ7zYi+yFHfQ/abgKE5sBn/opSpzy+jhiZPZVMrbYJmqLI1jD2EbglrLUJt/6fnafd0UWDlheae3trS0bNg9vr6JpbaRIf6zn6nHGKmPVu7/Ga/vPURTFW8Kev2gr6bdaj8+qVsTgmd9iOOV4+GqXNRitl6sWYYN9akuvytdj6xuGYFGHmyMIY/Bxq6rC9dKLv4DTCiRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+i1hrj2segD/Te2YIbr/9y9HWqZ3Xc0qb86uKqmbwQ=;
 b=RmSCYmoTacN5FrYwCyXfWfiCH8N5frwiRAXMzBd7ED7LE0uJT38nzcpD2oPFmhGj6rRFRY/41LgO40WSzmY9qza+GLaBsZiHkfeWHofh/aLz4gxni9FC58BdbYDRB8YWE+wXnfuoV81QOpfBHGmgYw3gXyMLDFedM0o//LlLKI8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AS4PR07MB8658.eurprd07.prod.outlook.com (2603:10a6:20b:4cd::12)
 by AM7PR07MB6628.eurprd07.prod.outlook.com (2603:10a6:20b:1a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.1; Thu, 21 Jul
 2022 12:19:54 +0000
Received: from AS4PR07MB8658.eurprd07.prod.outlook.com
 ([fe80::d58d:e18d:afdb:35b8]) by AS4PR07MB8658.eurprd07.prod.outlook.com
 ([fe80::d58d:e18d:afdb:35b8%8]) with mapi id 15.20.5458.015; Thu, 21 Jul 2022
 12:19:54 +0000
Message-ID: <6878a4d0-a12d-ae8c-f5b1-08147203cd7d@nokia.com>
Date:   Thu, 21 Jul 2022 14:19:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] MIPS: octeon: Remove vestiges of CONFIG_CAVIUM_RESERVE32
Content-Language: en-US
To:     Joe Perches <joe@perches.com>, David Daney <david.daney@cavium.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <997c0cdbd57752252d87129185a973c7d42e491f.camel@perches.com>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
In-Reply-To: <997c0cdbd57752252d87129185a973c7d42e491f.camel@perches.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR07CA0005.eurprd07.prod.outlook.com
 (2603:10a6:7:67::15) To AS4PR07MB8658.eurprd07.prod.outlook.com
 (2603:10a6:20b:4cd::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6316b86f-e4c3-4bbe-a531-08da6b13511d
X-MS-TrafficTypeDiagnostic: AM7PR07MB6628:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Th9WJzDxvHUnpbsIzcIoikQK+3CLsDxnhjJ02mCfXSIyZLhiOe0PDhN8BplwLzGj3ZGJVG0LM+66+HCNISCELMl8i6n3y0LESyqnFxPIKiJHe1stRwxNcQsblg1AYTsckL+zZpXLD4zqjCRoWskkuwpVPo4XgPQpl9AFJ8anPz451fA4IMXLz3e0MS6V1vbHkhNhr52noTkcMbbcd8HJkCxZvG23L402iznoVoD+VHMxufk64WuBJiapHEugzzBvQBn/lVhmS3Qy9nfVKvjcXF6W6U7sg/1yJRAA8xDZMKYopsw1cLJ7zZ8kjzSe1zeviZMfSE5qm0vJglogF1rm1Ae/aiK3PNgYzdJRjC0grAghkO7YHGXgLee4q0Jvhy+E24tOS2xsRqWk8kgiUUoMQtSPCAxfP+MtJDO4jPZPRHBJG6Ty5taFJ9sfz2pbfFgBB+jXzZhK37BNocGN71+nrAjltUeIFaTyBa4J2JVJ2D0DXaH92l6Gy5vhBhFgjA/K/OtxqHCiII20O3ml/jm+biBPj2BdL47tyI233uldJx2qKywmrapZwDVauYJS169ZvtSUq1tlzNBbMqVpKn91VoLdutYqyLX0UwdfBEErXumeJeN5Wz+Ovby3+K1YNvGV3PGIOglpHVT8eNiVpdz39cjLVrFAj0KxDdTYCJR5gHP4FriuHFoy+yCY1kyQ1hCEMKWC3+YCIKGi2ku5Eq7uzN7jryMcikzcujq0DYaQixbRdBsPtkU7yQ4aVjH1lqgg27CynGctMVOsnops4TUomgBUQ185ViBDp6gSKorvMwcmAbUE5zhEw6gsm/iMeT7GMzCSVcOIwgEyxCKrtUYzs9wH97WmYRUhPQRwUW4yz8q6bgqoCLWeswnoyIOzNPc8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR07MB8658.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(110136005)(83380400001)(186003)(54906003)(316002)(36756003)(8676002)(4326008)(66946007)(66476007)(66556008)(31686004)(31696002)(6512007)(6486002)(6666004)(53546011)(2616005)(86362001)(6506007)(8936002)(41300700001)(2906002)(82960400001)(26005)(44832011)(5660300002)(38100700002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkNQZWdQcXhmdWpNMjNFU0RGcHlIUDVBUDEvQnc0NVRsczdRNlUwVmM3WUxY?=
 =?utf-8?B?R2dYUDduN1VxRXYwdXF5dExtRGNvSXBINm9hOTNRWjVvZzdsMGVFWG83Z05W?=
 =?utf-8?B?d2MvQWlDL2VSV0ZUM0VPU2t4MHZOV0pHN1IvZzRuM0xmcE83bHJMbnU5WGhK?=
 =?utf-8?B?VlZoMHRmSFVONTJ2VjZnT2VsTW1DZlZXa2JCQjZQeGNuaTZ1OTN5YUFNZU1l?=
 =?utf-8?B?ZnRuS3RERkVzNExVajFuTW5OenNSbmQvcDRIQXdoSXQ1NVcrRVRjOTh0MTNK?=
 =?utf-8?B?M2xDencySDhoRGVSRkZWMHFWZDUrV3JEVW9tU284VXM1TW5FQU5zRTBBVWtx?=
 =?utf-8?B?VnFidWpYUnZSMmh5R2MwYlNiS3dpbUt4dEkvblRwWnFkNmpadE1TNGRSTVEw?=
 =?utf-8?B?cE1mTUZsNy8xUUsySFRMcU5CZFB0ZzJHenFVdUdzTGYrcVlBRHU1NUlJbmhQ?=
 =?utf-8?B?UkNnUkRtT3RCYkRGRCtEQThXamZ1WTBlVXl4RTdvSUt6UTNMUTlUcENNRFZE?=
 =?utf-8?B?UW9BS0RvcmJKYWpZb0JXSGd4L0NwWmVydjJHcWZXQVcrM1RrU08rOXl2Wnhs?=
 =?utf-8?B?TWdDTm1NMmhaTjFWdURSMGd2Uy9UOEJaSkNteDN6TWY4QUxhSTVIOVRKR3Ix?=
 =?utf-8?B?cjJOK0N3bkJqVVMwc1NuTmJ2cEtGRktWSlpNbjc1SHJZWDZVRnpDODB3djVo?=
 =?utf-8?B?OHF4YjFZbHBLVGllOEFuS1ZyUm1CMCtRRElsY2dZN2VJZ3FUcUtIcU5aUEdG?=
 =?utf-8?B?Yk95OHhVakQ4UDQyYVRQS090TGptd0NPeWFHcy9MdERlcHNDTnRYU2ZVUCtq?=
 =?utf-8?B?bHVha3VkT2Q3RmdwSnRwanRNdkNFNHdHMWYrc1F6eG00TmFJbzNYMnVZazJh?=
 =?utf-8?B?bTNWUERyZDZLMFRRVVM0UEpBRDJDWWh4K0FVYmI2RWc4NTNPc2pBRkV5ek1P?=
 =?utf-8?B?QTNhZ3c1UmtHWXFpKytacWdaM3ArdzJiMHNySHV3MUV0QUlnRXM0NkJSdWpO?=
 =?utf-8?B?OEpQOWJxY1lLT0N3YnFsR0JhQ3hveU9GWlo0Y3N3TVlzWUNGaEZpc3VNTUVh?=
 =?utf-8?B?YUZhaXZUL2JoUlRTbFJXYW1QRVZIWVhLNm9sQ0JPZUxsdnZaekJOTjdwV3N0?=
 =?utf-8?B?R1d0K0sxVU4yVWl6RHZ2ZldNOWJOMVNKR211TGU5aThsMklBZVNYTUtmdEZi?=
 =?utf-8?B?UUpjZlJVOWVrRU9EeUNoNjZhb0hTTHIvcExHRHR5UDZwaC9FWDZPL0xSQUtv?=
 =?utf-8?B?cmwyQzlkTi9CVDhnaDBPVUFUNWI1SXhMZ0U0cW1ka2grWXpDZ0ZuelJscmF4?=
 =?utf-8?B?Q1plcXFPc0k0Ui9ibW5tTlR1U1JHSnBDRzdnZEFyNzhGd2dHbk5XdVR1OHdv?=
 =?utf-8?B?QUh5TmZRRFNyMzZUOVNRbDFtSjB5NHBITzdERW0raFRNdzdrQzFMSVU1TTU2?=
 =?utf-8?B?MkxmaDljTElEcDRPc1VFTWJYNlNuUFhVTmhFVWR2VUdwR2MwenVIUjRJVitz?=
 =?utf-8?B?aUZSU2xjcFRNcm45V2FRankzeVY4K2VUWnM5MmoydC8welpNLzBnZ3BNcmp0?=
 =?utf-8?B?eWNmRDFnUnQrb2R2MitES3NTMUt2U2t6S1VwQXVJbk55cVRYTEZ2QmlxTXY5?=
 =?utf-8?B?K2ZnY050cW5vOWM5UjRCckl4RjRUQkhIU0RJdStHMC9PNU8yQ0lpNitXUXVD?=
 =?utf-8?B?Y0lxTGZlWFR0NFBlbnVHVFQzbFo2ZjZjemhkNFcyaE9mVUFMdi9mN2xXUnE5?=
 =?utf-8?B?cFpvR3hzQXBvd3FENVlBTDZXOWowUGFEcmJJOU5XZEFPbmtVMUlraXJTUThx?=
 =?utf-8?B?MWRSL3VrNm55K1A4VVFRdmtTNkZHUDg2Qm9Pdi9lcGxiQ3VYekJaUXg0N1o2?=
 =?utf-8?B?RFBWZ0NjZlkxbUMvWmlMNHlhVmNhVlJObk9IQkQxcWt6UmtSSkpGVlhxdUFM?=
 =?utf-8?B?cFExREh2YzF4SVJkZG5UZDZ3TjV2bW93cTZUcWpYcXVwREFYNlhZMSsxKzAw?=
 =?utf-8?B?SU1zT0tIdzlUVnBrSUQvTWpCalprU0hWaXZIWWZNNnNjK1VzS3lZd2pqSzBt?=
 =?utf-8?B?RlhhL3JtUnR2OUZCR0s1NEdHZHRSZFcrOUV6eUYzb21zbWVkUzJJVFhvUW9O?=
 =?utf-8?B?d0d5aEg0enNzSTF0N1dNRGhRMTVWMDJvS1EwMFdIeEViczU4K0dSdExYZ2xO?=
 =?utf-8?B?cVE9PQ==?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6316b86f-e4c3-4bbe-a531-08da6b13511d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR07MB8658.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 12:19:54.0168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jrd52akt0Pf4DOZzhSGOmHm7+jRcf/KfCH1sxJI4V8A1ce0AFvYWTCnMng87UsbYDaNgQ0iUK08/Nj7tKRrhPNscLpgq24dnesFtxnIcyEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6628
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Joe!

On 13/07/2021 19:49, Joe Perches wrote:
> The config option CAVIUM_RESERVE32 is not used.

We use it. Does it make sense that I submit a revert and a patch adding the option to Kconfig?

> Remove the dead code controlled by it.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
> 
> Uncompiled, untested.
> 
> Found using a grep for unused Kconfig entries:
> 
> $ git grep -P '^\s*#\s*if(?:def\s+|\s*defined\s*\(?\s*)CONFIG_[A-Z0-9_]+' | \
>   grep -oh -P '\bCONFIG_[A-Z0-9_]+\b' | \
>   sort | sed -e 's/^CONFIG_//' -e 's/_MODULE$//' | uniq | \
>   while read config ; do \
>     echo CONFIG_$config; \
>     git grep -w $config -- '*/Kconfig*' | \
>     wc -l; \
>   done | \
>   grep -B1 '^0'
> 
> with some additional inspection of the kernel source tree to verify.
> 
>  arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c | 21 +++---------
>  arch/mips/cavium-octeon/setup.c                    | 38 +---------------------
>  2 files changed, 5 insertions(+), 54 deletions(-)
> 
> diff --git a/arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c b/arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c
> index 3839feba68f20..fb42e8e21ea0d 100644
> --- a/arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c
> +++ b/arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c
> @@ -57,27 +57,14 @@ EXPORT_SYMBOL_GPL(__cvmx_cmd_queue_state_ptr);
>  static cvmx_cmd_queue_result_t __cvmx_cmd_queue_init_state_ptr(void)
>  {
>  	char *alloc_name = "cvmx_cmd_queues";
> -#if defined(CONFIG_CAVIUM_RESERVE32) && CONFIG_CAVIUM_RESERVE32
> -	extern uint64_t octeon_reserve32_memory;
> -#endif
>  
>  	if (likely(__cvmx_cmd_queue_state_ptr))
>  		return CVMX_CMD_QUEUE_SUCCESS;
>  
> -#if defined(CONFIG_CAVIUM_RESERVE32) && CONFIG_CAVIUM_RESERVE32
> -	if (octeon_reserve32_memory)
> -		__cvmx_cmd_queue_state_ptr =
> -		    cvmx_bootmem_alloc_named_range(sizeof(*__cvmx_cmd_queue_state_ptr),
> -						   octeon_reserve32_memory,
> -						   octeon_reserve32_memory +
> -						   (CONFIG_CAVIUM_RESERVE32 <<
> -						    20) - 1, 128, alloc_name);
> -	else
> -#endif
> -		__cvmx_cmd_queue_state_ptr =
> -		    cvmx_bootmem_alloc_named(sizeof(*__cvmx_cmd_queue_state_ptr),
> -					    128,
> -					    alloc_name);
> +	__cvmx_cmd_queue_state_ptr =
> +		cvmx_bootmem_alloc_named(sizeof(*__cvmx_cmd_queue_state_ptr),
> +					 128,
> +					 alloc_name);
>  	if (__cvmx_cmd_queue_state_ptr)
>  		memset(__cvmx_cmd_queue_state_ptr, 0,
>  		       sizeof(*__cvmx_cmd_queue_state_ptr));
> diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
> index ce4e2806159bb..0ddd3cc16ee47 100644
> --- a/arch/mips/cavium-octeon/setup.c
> +++ b/arch/mips/cavium-octeon/setup.c
> @@ -284,11 +284,6 @@ void octeon_crash_smp_send_stop(void)
>  
>  #endif /* CONFIG_KEXEC */
>  
> -#ifdef CONFIG_CAVIUM_RESERVE32
> -uint64_t octeon_reserve32_memory;
> -EXPORT_SYMBOL(octeon_reserve32_memory);
> -#endif
> -
>  #ifdef CONFIG_KEXEC
>  /* crashkernel cmdline parameter is parsed _after_ memory setup
>   * we also parse it here (workaround for EHB5200) */
> @@ -665,9 +660,7 @@ void __init prom_init(void)
>  	int i;
>  	u64 t;
>  	int argc;
> -#ifdef CONFIG_CAVIUM_RESERVE32
> -	int64_t addr = -1;
> -#endif
> +
>  	/*
>  	 * The bootloader passes a pointer to the boot descriptor in
>  	 * $a3, this is available as fw_arg3.
> @@ -782,25 +775,6 @@ void __init prom_init(void)
>  		cvmx_write_csr(CVMX_LED_UDD_DATX(1), 0);
>  		cvmx_write_csr(CVMX_LED_EN, 1);
>  	}
> -#ifdef CONFIG_CAVIUM_RESERVE32
> -	/*
> -	 * We need to temporarily allocate all memory in the reserve32
> -	 * region. This makes sure the kernel doesn't allocate this
> -	 * memory when it is getting memory from the
> -	 * bootloader. Later, after the memory allocations are
> -	 * complete, the reserve32 will be freed.
> -	 *
> -	 * Allocate memory for RESERVED32 aligned on 2MB boundary. This
> -	 * is in case we later use hugetlb entries with it.
> -	 */
> -	addr = cvmx_bootmem_phy_named_block_alloc(CONFIG_CAVIUM_RESERVE32 << 20,
> -						0, 0, 2 << 20,
> -						"CAVIUM_RESERVE32", 0);
> -	if (addr < 0)
> -		pr_err("Failed to allocate CAVIUM_RESERVE32 memory area\n");
> -	else
> -		octeon_reserve32_memory = addr;
> -#endif
>  
>  #ifdef CONFIG_CAVIUM_OCTEON_LOCK_L2
>  	if (cvmx_read_csr(CVMX_L2D_FUS3) & (3ull << 34)) {
> @@ -1078,16 +1052,6 @@ void __init plat_mem_setup(void)
>  	cvmx_bootmem_unlock();
>  #endif /* CONFIG_CRASH_DUMP */
>  
> -#ifdef CONFIG_CAVIUM_RESERVE32
> -	/*
> -	 * Now that we've allocated the kernel memory it is safe to
> -	 * free the reserved region. We free it here so that builtin
> -	 * drivers can use the memory.
> -	 */
> -	if (octeon_reserve32_memory)
> -		cvmx_bootmem_free_named("CAVIUM_RESERVE32");
> -#endif /* CONFIG_CAVIUM_RESERVE32 */
> -
>  	if (total == 0)
>  		panic("Unable to allocate memory from "
>  		      "cvmx_bootmem_phy_alloc");
> 
> 

-- 
Best regards,
Alexander Sverdlin.
