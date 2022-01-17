Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1820E490FFC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 18:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241957AbiAQR6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 12:58:35 -0500
Received: from mail-eopbgr60114.outbound.protection.outlook.com ([40.107.6.114]:28950
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233365AbiAQR6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 12:58:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlKu57I/FubDJc1b1nAJq8EJJv9vzH8DHQAHacljTZMhZqZchpnxGoQgSPmCz8ZguUXO5H4Av8v4YmGCkL2D84HIArjfCbiWzvlslbsaZbAJPNBxOHmvNrzYcCt9pHooIqK2+zzjb52s1tfFMgp2mSEaXAjYfvLPw0snQl90sb5w0wi7Xq+mjzF3VwEs/cs1fWSfsM/OliUmLCIJNMFPOJkDnDMDbuCLqoBncaADJd/NOHJM5PmFVRs+SKTpIU9+XaarRYKUGFbdJgbuvWQZxreMHmButZmgBP2NL2Wbxc78WDydLmLF0cenLABiXivxPL1iWV2XmsHxFmUOdmaY9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSGrO/bv44DA623PSDCEWuM2s1fQDwC1PjrhVe+FyKc=;
 b=SukXP2xDwr3/izuP4aWonYGbrBteIHgJyDd3nEU4oUGMqJJk2KdtCyfPBefoHROpHEPgwZDtsNXDQhpKSdr6+KQSpo5t27rV8WMRm40EaGuS+Ux8v4z6RvN2iqdrBtHC713UGkFKHwsN+FKRm5aAxO/TrW26pgOIFTweUApGFMdvWWBkj7PK83lE/HLdz71m/WVJPhJUc6MakUVkQx2ic3fzuHteiFlnfrUBX3APQYrWS+gXrfawTbfedhPpquRhPmMrI/aFzCg2y7fuU0TcFarxPSo4nb1NYT6Q7BMCQBazyKBP381x0e0bTb3S4H7gpSub1Mfq3oQ8UAHaBpeFeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSGrO/bv44DA623PSDCEWuM2s1fQDwC1PjrhVe+FyKc=;
 b=Os/g6qiASYdZpFJ18hmbHJwDkUX3LUrqPRcHEn7TOExl/xc4jGycC+/cTLi9M1mlSeO9EwYILQv0EYLxK2j7R9xtcQ8L2juT8CTR6tJcExAyKsIdpJCtmTe4qVNGznyPwqwc+UZM3YVI3QkTfGpKoSbLvpxQL114tuBEfw7ViJc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from DU2PR07MB8110.eurprd07.prod.outlook.com (2603:10a6:10:239::15)
 by AM8PR07MB8309.eurprd07.prod.outlook.com (2603:10a6:20b:328::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.2; Mon, 17 Jan
 2022 17:58:32 +0000
Received: from DU2PR07MB8110.eurprd07.prod.outlook.com
 ([fe80::9d2:7ba2:9045:2acf]) by DU2PR07MB8110.eurprd07.prod.outlook.com
 ([fe80::9d2:7ba2:9045:2acf%5]) with mapi id 15.20.4909.007; Mon, 17 Jan 2022
 17:58:32 +0000
Date:   Mon, 17 Jan 2022 18:58:26 +0100
From:   Krzysztof Adamski <krzysztof.adamski@nokia.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Matija Glavinic-Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: move efi_reboot to restart handler
Message-ID: <YeWuQh6+OC02nbsg@localhost.localdomain>
References: <YeVhtL2gCLkhTPdv@localhost.localdomain>
 <20220117131056.GC87485@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220117131056.GC87485@C02TD0UTHF1T.local>
X-ClientProxiedBy: HE1PR05CA0255.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::31) To DU2PR07MB8110.eurprd07.prod.outlook.com
 (2603:10a6:10:239::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6813e59a-8859-4d73-d248-08d9d9e2f915
X-MS-TrafficTypeDiagnostic: AM8PR07MB8309:EE_
X-Microsoft-Antispam-PRVS: <AM8PR07MB8309312170D1CE4BC954F0E1EF579@AM8PR07MB8309.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bFx07zYyfQP2/SxU0qxO47ukQCSQOQLez+Dc0YXzvy+m+C0DZJ2zzG25/PRCgIEPOJO151embxTORHm56vf3oxnqLJLAjSQUwzjh9JxIf1+bvZlU6XJjX5uKokMeRrAEflypBQvhn8TgZsxjiAdAAbuM9wr7u5rjZOtGbaVIBrJmHyPENzqbqFNXoVu/Qn7YA3+V0vX4BorWaGipDox9XWmWHPBnTajdzw7qU3M+BKYWyITEqbS/RuMbpo1K4ISLlEwWmbZM/FSK+PsQpS9mmzKA+2tgxF62Pm/WRU+dCaeCOigyWJVlm3CiIqz9L5HbEey4hy2HX/kiIkUOG2fDSnYNgsPEIhfbkvtjoumGxKXMx942Wdaot70OslBgyaNeHsDAqbEclFnJ4CERPDwlSbJlYxAEu3aURQG5h/eaquyW6xd4x+4IuKYhbNaWvt1h4f45ZdzrcLzG4F8wqanGeMSh4QXFW6ZkLLIInoiabJptQ+lQm+9SRKLBkxrmuVWx6AcYbgOGSlBcDLQoYTj8UHnN8o0XdwRATee/oLdw137/By6ifzu6cZ6vq5yWpJ+3H+hlSQf8LyhWhVc+OXF0gna+yB3+GPvE5PUIChye2QN+qYwGHZyvKDZQZgzNLrs91tIWRTor21/WqXSpyc4CMIgCFX6K2S61XFlmTPwnLzjsS0O1XFUAVtid5EnRNS6nCtMehyHRN5Cd2KZVenWnADxBbhMra72zBwkKuFkIwPU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR07MB8110.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(6506007)(54906003)(44832011)(2906002)(6512007)(9686003)(86362001)(6666004)(316002)(508600001)(6486002)(5660300002)(52116002)(186003)(66946007)(26005)(38350700002)(82960400001)(8676002)(66476007)(38100700002)(66556008)(8936002)(4326008)(83380400001)(67856001)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzQ1Y0FKZ2NCb3pob1B5bmg4L0ZvbTY2U011dnpHUHZ5ZjlYUUJtQ0VCTjBC?=
 =?utf-8?B?cWNpU3VHYXoxK01IVVZ0bzRYMHc4RWtXV0dIWm8wN1lyemYzNzVScERwdnpq?=
 =?utf-8?B?bnhxQ3BGNnNTdUMzdHpXZTNxbm9EV0VYV2hKZlBieWg2VzJHYmh6VnQydEZC?=
 =?utf-8?B?TW45QmVvS2NLUmdnUy9BOFF5dmZRUUZxemtqdm5YMzZ6Myt5V3ZiZnpBaDdG?=
 =?utf-8?B?VTV0NUI1ZXJScWwwck9zcXh5QkVRdFdJWmhqcWhuRUdyQml4L0szZDg5cVNO?=
 =?utf-8?B?YjZuQ0lTdVAwVmgwakFEOWl0YTBadUlYM0dQbnFYNWdSblMxcHpVcGV3V2t2?=
 =?utf-8?B?aC9xYWJDcGl0eVk3TzVJKy9nOTN6QzBac2duVFg2RCtxQnNqam00RjZ4TmZj?=
 =?utf-8?B?MGRXT1BmMGZobGMxd0MxQmdSZDRDVFB2aDZZOG9HR3plL3ZucDJTQ2Rva05o?=
 =?utf-8?B?VUVtZUh1NXVURlZBc2U2ckQrTzV0TTBTR3o0VkpxV0ZTSG5ib0ZCZEpjOFh6?=
 =?utf-8?B?U25Mdmd2R1dGc1NSaEx3VnJ1Q20rNGZIK21FQzc5SkFXL21rek5YcWp0YStN?=
 =?utf-8?B?eWhPeGNwSlppUmNtNVhTTi9ZcUxLNnNoczdNcFljUnpOaHcvNWkyR3hkQms0?=
 =?utf-8?B?TWQrY0VlSk9lUTBQYnZMUWU3dUh6SXNaZ0lheXh1Y2xpWTh3N0I4bXIwZ1po?=
 =?utf-8?B?U3h1UWs3a2tkNkJ4b2w1LzFwRHBGSkZ2U1B6Y1QrT25XWTc1VDJDWm04OUFq?=
 =?utf-8?B?T1FXUDN1aVYvYWVWaDNJS2ZsUFRtSFAyeU85SFlCbWNGRFJGenJ1dlNHUEh1?=
 =?utf-8?B?bmV5MmdUSWF5aFZTdmNrQ0VpYXhGZ2wvUFQ3cW12NjZITzNzMkZGaXhvUGll?=
 =?utf-8?B?VWVvSnRQcUluY01peWx0c0dQaEpFbUVxSjZHdmZxOFdPb0ROSlhsc0xhVDIv?=
 =?utf-8?B?WkRNOXVSNDJyTnY0QkZHS2RrcG42S0ttaHVBenV6dld0bHh6VVd2R0Zqa3B0?=
 =?utf-8?B?Rnk2YVpQbTU2SzdtdGFtMlczMGZzUzdBK0VtSGRpMDVxN2thVlpjU3BHRmFu?=
 =?utf-8?B?UzBTKzdpUm1EajRDMjJNcmpxV2MzaVFPMGhzT1NHM1F0Tkt6WXRRdTR2Nlp4?=
 =?utf-8?B?UlBkbFBaTlhUVXJZbzlEUThPcFl2RHptQlNRWlVBMDZ1eU91bUVrZmMrSG5h?=
 =?utf-8?B?Y3MzMEJWOS9kYTRkNzJPajF4am1PWXFoTXljN2t0UWo2dy9kRU1zVnpjSmo0?=
 =?utf-8?B?cVF0K05WelZmbC9EMUJyZ0k3SWUzUHBYRzY4WHEwZE5US1M0aHUwZ3FtZ3JN?=
 =?utf-8?B?NW1lWnZXaUJuTzgvUm1pd0RaRFpoNkg5VDFnejkrMTQ4L2NORlhMY1RBZEw0?=
 =?utf-8?B?ZVJPeVRHZ3o3elpoUG9mZTJ4WU5OTHNhWE1PRitmbkZmSSticmg1OHZDd01Y?=
 =?utf-8?B?RWlZaWFrVEs5WGk3ZE1zc0g4Mk50VFZzWUJVdXI0REZCd0N6YjhXVHAxSXAz?=
 =?utf-8?B?UnBKUEVNWTJHYTRJbEZMZ3NOMW4wd0ZHOW16SURyUkVNWTZ0VFg2eFhBcnFa?=
 =?utf-8?B?eDh3dWhoQ0dMejV0NFVQVzdDaElsSjB0NGdkUGNIV3N6VytkUWl2Kys2WnVZ?=
 =?utf-8?B?SGYxRzhERHhNQzA0dnZXcGd1UG41ZnVFZlN1Q010TENTbzIrSW56dUhoUXdC?=
 =?utf-8?B?UmpaMXRidW5rSlMvejZCU3RGQlk4N0FXZ1FDNmNrYWpUSDJYOWZjQUllNWFB?=
 =?utf-8?B?RHpWQmlQR3JBQ3RwdDMxb1MyenRvaWZSMlpGLzdtcVpMNFpNRUgvVXRUb09C?=
 =?utf-8?B?c2s2Z1lGd2YxeHdSWG5hb0Q4NVI1NThsemgzSEpQbFZncDJPakF2Wm56YVN6?=
 =?utf-8?B?SUQwWTlxQlZ3a0tWK1FQd1ZzNU1XUVB2REt2Vit1UTBBbEJoVmQ3NDBiMDFh?=
 =?utf-8?B?ZVEvUExIUzB6U0JtM2NJeDhQTFMzbHhEc0VWcTI0OGJKZzBXc21pK2IyK1RZ?=
 =?utf-8?B?T2tpRDlPVDdDaTM0NjRYaHFEY2pFQ2ZjUzhhSktTU1ZQSFR1d1IrZHYvRmFS?=
 =?utf-8?B?bEVnVmhvZTNKWkV1NkdyYWhvczdyRjhBWSsvU3BkRnhCRHdsSExBdnA4ZW9j?=
 =?utf-8?B?a21FaWVNUlVZNUwyUExJSlpxUkJ2Q054RnVzdS85QlVmcld3TllDUFNYck90?=
 =?utf-8?B?Wk80L3lUSmtWR3ZGSjlCMHIrN3R1b3hhRmRYVFFTdnU2YmlESHpCRjIxUWF3?=
 =?utf-8?B?QmEyM0NxNUEzeEZIOFZ5dHc4WGdRPT0=?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6813e59a-8859-4d73-d248-08d9d9e2f915
X-MS-Exchange-CrossTenant-AuthSource: DU2PR07MB8110.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 17:58:32.0535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4YT0y0sTMfhHTnCDBs3vb5OgyyvHJ9vmRVf3P70N921QftTUVdC5vCBX8N8vKKhyyihVbUU7pkgGW76yQ9ldknupP7pzz26YdpVEBHO6SU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB8309
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia Mon, Jan 17, 2022 at 01:10:56PM +0000, Mark Rutland napisał(a):
>Hi,
>
>On Mon, Jan 17, 2022 at 01:31:48PM +0100, Krzysztof Adamski wrote:
>> On EFI enabled arm64 systems, efi_reboot was called before
>> do_kernel_restart, completely omitting the reset_handlers functionality.
>> By registering efi_reboot as part of the chain with slightly elevated
>> priority, we make it run before the default handler but still allow
>> plugging in other handlers.
>> Thanks to that, things like gpio_restart, restart handlers in
>> watchdog_core, mmc or mtds are working on those platforms.
>>
>> The priority 129 should be high enough as we will likely be the first
>> one to register on this prio so we will be called before others, like
>> PSCI handler.
>
>I apprecaiate that this is kinda nice for consistency, but if adds more
>lines and reduces certainty down to "likely", neither of which seem
>ideal.

Well, my choosing of the word "likely" might not be ideal. What I meant
is that it is unlikely that anybody would ever add another restart
handler with priority 129 in earlier code, as it would also have to be
done in arch setup.

We can, however, bump the priority to a larger value, of course. I just
wanted to use tha smallest sensible value. Choosing the right priority
is the hardest part of using reset_handlers mechanism, though. The
direct mapping of the previous code to the restart handlers would use
the maximal priority of 255, but this wouldn't make sense as the whole
point of using restart_handler is to be able to register something with
higer priority than default (in this case efi) reset mechanism.

>
>What do we gain by changing this? e.g. does this enable some further
>rework?
>
>Do we actually need to change this?

Well, it is not just nice, it is very useful. Without this change, the
whole mechanism of restart_handlers does not work on a whole class of
systems. We use this mechanism to inject our custom handler that should
run just before restart but this is also used by a handful of mainline
drivers that I mentioned in my commit message - none of them is gonna
work in EFI based ARM64 systems right now - this includes the MTD/MMC
drivers trying to do some work just before restart, gpio_restart driver
that is used in many systems to trigger some external events just before
restart, etc.

So, for everybody who uses restart_handlers mechanism, this change is
needed.

>
>>
>> Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
>> ---
>>  arch/arm64/kernel/process.c |  7 -------
>>  arch/arm64/kernel/setup.c   | 21 +++++++++++++++++++++
>>  2 files changed, 21 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
>> index 5369e649fa79..b86ef77bb0c8 100644
>> --- a/arch/arm64/kernel/process.c
>> +++ b/arch/arm64/kernel/process.c
>> @@ -130,13 +130,6 @@ void machine_restart(char *cmd)
>>  	local_irq_disable();
>>  	smp_send_stop();
>>
>> -	/*
>> -	 * UpdateCapsule() depends on the system being reset via
>> -	 * ResetSystem().
>> -	 */
>> -	if (efi_enabled(EFI_RUNTIME_SERVICES))
>> -		efi_reboot(reboot_mode, NULL);
>> -
>>  	/* Now call the architecture specific reboot code. */
>>  	do_kernel_restart(cmd);
>>
>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>> index f70573928f1b..5fa95980ba73 100644
>> --- a/arch/arm64/kernel/setup.c
>> +++ b/arch/arm64/kernel/setup.c
>> @@ -12,6 +12,7 @@
>>  #include <linux/stddef.h>
>>  #include <linux/ioport.h>
>>  #include <linux/delay.h>
>> +#include <linux/reboot.h>
>>  #include <linux/initrd.h>
>>  #include <linux/console.h>
>>  #include <linux/cache.h>
>> @@ -298,6 +299,24 @@ u64 cpu_logical_map(unsigned int cpu)
>>  	return __cpu_logical_map[cpu];
>>  }
>>
>> +static int efi_restart(struct notifier_block *nb, unsigned long action,
>> +		       void *data)
>> +{
>> +	/*
>> +	 * UpdateCapsule() depends on the system being reset via
>> +	 * ResetSystem().
>> +	 */
>> +	if (efi_enabled(EFI_RUNTIME_SERVICES))
>> +		efi_reboot(reboot_mode, NULL);
>> +
>> +	return NOTIFY_DONE;
>> +}
>> +
>> +static struct notifier_block efi_restart_nb = {
>> +	.notifier_call = efi_restart,
>> +	.priority = 129,
>> +};
>> +
>>  void __init __no_sanitize_address setup_arch(char **cmdline_p)
>>  {
>>  	setup_initial_init_mm(_stext, _etext, _edata, _end);
>> @@ -346,6 +365,8 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
>>
>>  	paging_init();
>>
>> +	register_restart_handler(&efi_restart_nb);
>
>If we're going to register this, it'd be nicer to register it
>conditionally in the EFI code when we probe EFI, rather than having the
>arch setup code unconditionally register a notifier that conditionally
>does something.
>

You might be right, I did a 1:1 translation of the code, so to say. I
will look at the alternative approach for registering.

Krzysztof
