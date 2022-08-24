Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E46159FAD4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237887AbiHXNEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237618AbiHXNET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:04:19 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2105.outbound.protection.outlook.com [40.107.20.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DC497EDE
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 06:04:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gg1UnnHvsM1gWQs3UCkAl9FB7VU4+t1e6I99Nh5yI/ErsDifQ/WLTosDoxBAkIMlyyWW14C6mH/HdqXlvySJJb6g37YlRfsDH9Y9FMXszzRnajw21YdiPFooSe8vEXD99lYmejddLtMDk4WySfHkUEQd9a0mOPl9gbzplhJy7QCVC1ZLcVh+Ie5BcmpZXppFhGp/+Emu6+m+ZYmH7Xo3HtM6QyfLnAJVjo/Sf/3biGYMS2cBskDKV5XE2cdMHr/LGLj/D3nXbHnbpcmYjDvI3tUDAlHjsaXMTaHX7vzAmRYEoAR0wfr7c1kfLije/CPn0rFIz5/LKyQlosGmiVJ9TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryYOvQzln/nmUXXw2vAXmm2r7k8FZ/Bc9UEurylfkFs=;
 b=HTfhZLMDWpeiPMqr0v1dmhCbG8tXX11ygdSqpR19rcoKh6Akn7lDuryVT3c4eK5MFHk+pst59wqceSeFdQcABLuh2zo1iMUhclCs7MAC3oCWzVYb06Rh4qjeX/rynEN5TmCTFJ6mTwCazNeZJyea+u13Jr9gFaz/BgoVL5fDwHDFHcOPIACZbNLw5owpW+pFUZIP3CPpzlW11sWuWz6Ye3jvLgj/AhdjY3/UU3z/ydyfPYDJ6BDzVJQEAaLhHpN8la0UV5v5ZOP5/WUeVSjNB2zwcKUe5TKWNiJN0U61WObQwOgCXyYYFyITvSIxcD7SqOUoyTTcsBmVPdr4D98BTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryYOvQzln/nmUXXw2vAXmm2r7k8FZ/Bc9UEurylfkFs=;
 b=W/M4wntPlRfWcYSyjwaZu+Aekv6o2uXfS8E15uNPbUENbMwZmNOWeoTlMz0ilyKc+t2Cy5sednhXqo4/kRFDftrYrOLrmTWOPQ9q/4+qBDneM0sR701jyDg3iN4hY49tm/JTDM/UbETPExVpFnoQgjOuFuQELZlpzrsJbWYZcj4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AS4PR07MB8658.eurprd07.prod.outlook.com (2603:10a6:20b:4cd::12)
 by DB6PR0701MB2373.eurprd07.prod.outlook.com (2603:10a6:4:5c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 13:04:12 +0000
Received: from AS4PR07MB8658.eurprd07.prod.outlook.com
 ([fe80::4582:5119:51fb:4037]) by AS4PR07MB8658.eurprd07.prod.outlook.com
 ([fe80::4582:5119:51fb:4037%3]) with mapi id 15.20.5566.015; Wed, 24 Aug 2022
 13:04:12 +0000
Message-ID: <e4fb6847-2d17-fed9-bda4-092ea581072f@nokia.com>
Date:   Wed, 24 Aug 2022 15:04:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ARM: module: Teach unwinder about PLTs
Content-Language: en-US
To:     Russell King <linux@armlinux.org.uk>
Cc:     florian.fainelli@broadcom.com,
        Kursad Oney <kursad.oney@broadcom.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220706163135.53874-1-alexander.sverdlin@nokia.com>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
In-Reply-To: <20220706163135.53874-1-alexander.sverdlin@nokia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8P189CA0007.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:31f::23) To AS4PR07MB8658.eurprd07.prod.outlook.com
 (2603:10a6:20b:4cd::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae5e158e-bfe7-4786-5eb4-08da85d123f7
X-MS-TrafficTypeDiagnostic: DB6PR0701MB2373:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MrFmjwp6bgJJOELxgC06XQNoV4ub8GWvEHCnpnv4wQ4326nxEHMIlQfCRKFCT26vIHkR8UEXw6Ps7gUJ54dVqKC3psan7Uq3h+DxxRZ+P3viOwX4GpHLHO8B4QthJPV6LPerjFfCqnFk2m93ncgceujaDr5ghkUG5V2pwJlxz2eQ5Bqaygb+fKxoYg6aNbMxAL9Gde650HMrDi3jrxHON9uvg+GFmTqvNWR8JjsQwNm+PXgLgjPVmkVFVyNMSJb+8LoqhKC4kjmDXeVCBRE61I0mR99/G6uwgjTxb88RTvYEMNzJiKykFeyUESSdYtntqJGofQzOuMXEnkes6LMyE8s/pPQ2uVbPiFVAVJQCNkfzTTxp+sKMR8+hR7pYX54YTVwOllR/0IDRsYXLH+ZrrX7bvm04kaDDt7zG+ujc3fpCOkp0myz63Jt4XnkJ2yQ89ryg2Dee2OwEUA+DZr/m2+nyZ948Yq6rKWSghOvBl/s/YZ7v8KgdGFynAyFqrOziu6XTuriOuR6csSi60UT2KVidJe1VMae0KyFfQgkBUpnrvdrlmVBai2q7THbxGS2HSNLykJ10ejelSh2oLmEDasErDu6VemSxD0dSvcLfwSzDjf+fZXEEKs307jg6pi/mlml9Q90Zn27WMgh4eX/vzncypV88QY22akKw1N4w/3bhPlLLyN1Xa8enj7sURB3HPjMtpMi4x7G4KILH3SUNSSH7v43S4iR8TkyW62grFcrD0gD1/CrXCQhMfNRk26EBGvuPyvfcwRDPFnNdzTS6WDAs7L12mA8VwW1IfmvfmVYiH4NvrDR78Ed1y8d8mCcALz2DSe/lHfK7OSlkwsaJ12VKNBQoAPk/RdUo/xhNqb4NTgIvZs/8X9EeTG60zh57
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR07MB8658.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(36756003)(44832011)(41300700001)(6512007)(26005)(54906003)(2616005)(31686004)(83380400001)(186003)(38100700002)(6916009)(316002)(6506007)(2906002)(66946007)(478600001)(86362001)(31696002)(4326008)(6486002)(82960400001)(966005)(6666004)(5660300002)(66476007)(53546011)(66556008)(8936002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGJhVThXcDRLVUx6Vlg3NllBT3pYQmc5UGZDT24zT3pKeWR0TVBwL3BDWDRI?=
 =?utf-8?B?bmYrY3p5ZVI2K2o5bDc1MkJFK1o3U1VOenl2b2J4SjI2bElHZTk0NjYzRTA5?=
 =?utf-8?B?bCs1R21NV3l0T0dsMy9yQTdKL1VYcHBWTkNPUklvMU44cDdsbE95YjlKQkZD?=
 =?utf-8?B?K1YyWnJoQm1WdXNTMmxHV0ZJRDQzMnFYZ2J3VjdrcVhUVytYblN6MlgrSkN5?=
 =?utf-8?B?MUFNRWlLWmU1ZkREZGRwODlEZVhydWZNaXlzbnZwSUk5Ykh6cS9MMGE2TlNK?=
 =?utf-8?B?SkxtUTNEN20vYStqNStaY0JPa3pHRjNQWVJJZGNNTk95dFU0Q3I3RkJnUVFZ?=
 =?utf-8?B?V1BHaGN2VkRHNFQyMmcxZ0Y3cDFyZTg5UU43NlZGQ3hjcW13aDljSkVoLzM3?=
 =?utf-8?B?TDY1UFFjT1c2b0tjcjRsazNtVFgwSytmallIaitFZjl3L25Sb2Z6cUs4aThQ?=
 =?utf-8?B?MndYaTFzd0hYbkNJWTlOZ1Jod2tyQ2pyZ2libm9TSGJYUGY4ZEhwaFNnMEN1?=
 =?utf-8?B?OWVhSzZ4d2V5b0U4aHB2QXFrUEg1dEdGSDNXSkszWm91QlBGamZVTldnZTR5?=
 =?utf-8?B?ZWZ3K3hkSkkxTTZRekY4Z1lVTzZKSzJWSGxDYnpzUWRCR2drNWRWK0pWWDJE?=
 =?utf-8?B?Z2R1NGxRQU1wMnJvd0V5bVBONTE5Y3VWc0NLWjVhdGt5ODZIck41dXQ2ckNY?=
 =?utf-8?B?RDBHWW9CWTBHY1dGMlB4b0VWdUNqV1hqbzVEVm9rUkQzUHhvVFdmcTZnR1lr?=
 =?utf-8?B?Y3pxQXYxL285Y2VsLzRTSHI4NFEyd3pFdGpvQ0hQMEUxQzMzZGl6ZlErMUVo?=
 =?utf-8?B?TFlFczhIbFZCalBpYVlPVXhLcmUrbGFaVXMvUDFnR3REZWZVaVA4bmtHQ0Jy?=
 =?utf-8?B?c3pqRnhVUUZVdWNNdVVIWlRhVTVxUzE1VUcrM0pyQmIwUHBkNzdsMW5ma2Rh?=
 =?utf-8?B?c0RRaXVHSFdkdHlLeHg1YmpVaVp3RnNqRUdlb1pCQTNCZjVDYmVmUGlQczRo?=
 =?utf-8?B?VTdTUTZxMmluQktlQUZGeVNKcVF0YVZEdWNwaFZJeHJMQlFDUCtxLzlFYnBF?=
 =?utf-8?B?Sm1TR2QrZFI5REZ0bkFpQWtjaXIrYklRR3R6OGRJRHNoNXp0UE1XNFhweXRx?=
 =?utf-8?B?czlEU0lvTkFuYm9ZWXRpazdJRHBtbXlDWUpwSFJzaXZ4Lys1bURuSGhaZ3RE?=
 =?utf-8?B?WGNMYXhRUjJqUHJ2TjF4REtZbmM4K3lOTEgwZkd5aEhmUE9oL3BCdDduMEU3?=
 =?utf-8?B?dVE0dSt3MVk0RU9ROVJaVnQ5dEpqNFQwaGlBSVNUSHJVeks5aGw1SVNRQUF0?=
 =?utf-8?B?cXJDWE5GN2xpUzFuZkl5NGwxbWtyUEpYK0tIako4UktaVGp2L1d5amR2M2FZ?=
 =?utf-8?B?RGk5d29UelkreHByd2FIbmdKY3JHTTQ0ZXExalh0NDdoMDNLWXlXUVoxdDFP?=
 =?utf-8?B?R01sSWpsMmlleFpiY0lsTE9PRVZqaDlrMlh4bUVUZDZ5engrRG1qam1kZkdk?=
 =?utf-8?B?MkpPSGZtTXcxZkFad2tLMjJJYnZlNklJQyt5UzA0eE1zRkk2WEttcHViUUR4?=
 =?utf-8?B?S2gycFR3VVR4NEFhV214UFduTzFxOE85L1V3ZVZlMHhRZGV2MzJzazNHQ05J?=
 =?utf-8?B?MFlHYWJEME9KWEhLaFFWUVUyTlF2MXVwVXZzU3NQSVhnd2Y4bm9qa01ic0VD?=
 =?utf-8?B?WEZQRkpvbFRQbTJ2MzBXM3Bidm5RQjBuQytacmhBRXlKdjk1RFZBVGhqUGVr?=
 =?utf-8?B?YWwwZnFNZ3NaMEUrVkRVSTArZi9ZbDJJZlY1NnIwVWVJYm9kczB2aDZOZTdp?=
 =?utf-8?B?WkszRHFuMTZRWGJtT2dLY0NHYmN5OXNPRDdTWnM3d2VCd1YyWlpjVXJhc2hQ?=
 =?utf-8?B?eG4zc0JNVDhXYlNMNmUxWEtNTGY0SmR4bXN2TlUrcG5vR25TbG9UbVdkWEhJ?=
 =?utf-8?B?MjFlcGYzcDBEeTNNQ3NFQ2YycFpQUEVQRmpGMGZsT2pNTkowdWJuY1ZqelV2?=
 =?utf-8?B?d0M2bmtuczlmL1gwSWtMUnVnQWRiV1RWUXFCWWhuMFoza1hkVGRDcFF3ZWdo?=
 =?utf-8?B?cEVtT2ExanZEa1BabXNwQnJYLzhnUUJCTHpHWXlUY1pQOWdmNHY5eDB5SW1D?=
 =?utf-8?B?cXlMQWtVUnpMYU9mUjJ0Z2NVVlN6bkFvUUFpUkJMa3Z3RzNSLzdpeXBibzNX?=
 =?utf-8?B?MWc9PQ==?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae5e158e-bfe7-4786-5eb4-08da85d123f7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR07MB8658.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 13:04:12.6451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 61ydGgaH5UVJ+8MKvPsRnVhMb2ouizHem4fx5kDjD82LiEz+ffWPHMVl6R2/Uq/Nh2bWZZOgxw+jLIJqkdSI4Zmpbu+45vVsdYZ7hUQsl1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0701MB2373
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Russel,

shall I add this one to your patch tracker?
There is little interest to this patch, but also no complaints, as I can tell.

On 06/07/2022 18:31, Alexander A Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> 
> "unwind: Index not found eef26358" warnings keep popping up on
> CONFIG_ARM_MODULE_PLTS-enabled systems if the PC points to a PLT veneer.
> Teach the unwinder how to deal with them, taking into account they don't
> change state of the stack or register file except loading PC.
> 
> Tested-by: Kursad Oney <kursad.oney@broadcom.com>
> Link: https://lore.kernel.org/linux-arm-kernel/20200402153845.30985-1-kursad.oney@broadcom.com/
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> ---
>  arch/arm/include/asm/module.h |  5 +++++
>  arch/arm/kernel/module-plts.c | 14 ++++++++++++++
>  arch/arm/kernel/unwind.c      | 13 ++++++++++++-
>  3 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/module.h b/arch/arm/include/asm/module.h
> index 5546c9751478c..07c51a34f77d5 100644
> --- a/arch/arm/include/asm/module.h
> +++ b/arch/arm/include/asm/module.h
> @@ -37,6 +37,11 @@ struct mod_arch_specific {
>  
>  struct module;
>  u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val);
> +#ifdef CONFIG_ARM_MODULE_PLTS
> +bool in_module_plt(unsigned long loc);
> +#else
> +static inline bool in_module_plt(unsigned long loc) { return false; }
> +#endif
>  
>  #ifdef CONFIG_THUMB2_KERNEL
>  #define HAVE_ARCH_KALLSYMS_SYMBOL_VALUE
> diff --git a/arch/arm/kernel/module-plts.c b/arch/arm/kernel/module-plts.c
> index 1fc309b41f944..af7c322ebed68 100644
> --- a/arch/arm/kernel/module-plts.c
> +++ b/arch/arm/kernel/module-plts.c
> @@ -284,3 +284,17 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
>  		 mod->arch.core.plt->sh_size, mod->arch.init.plt->sh_size);
>  	return 0;
>  }
> +
> +bool in_module_plt(unsigned long loc)
> +{
> +	struct module *mod;
> +	bool ret;
> +
> +	preempt_disable();
> +	mod = __module_text_address(loc);
> +	ret = mod && (loc - (u32)mod->arch.core.plt_ent < mod->arch.core.plt_count * PLT_ENT_SIZE ||
> +		      loc - (u32)mod->arch.init.plt_ent < mod->arch.init.plt_count * PLT_ENT_SIZE);
> +	preempt_enable();
> +
> +	return ret;
> +}
> diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
> index a37ea6c772cd5..53be7ea6181b3 100644
> --- a/arch/arm/kernel/unwind.c
> +++ b/arch/arm/kernel/unwind.c
> @@ -28,6 +28,7 @@
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/list.h>
> +#include <linux/module.h>
>  
>  #include <asm/stacktrace.h>
>  #include <asm/traps.h>
> @@ -395,8 +396,18 @@ int unwind_frame(struct stackframe *frame)
>  
>  	idx = unwind_find_idx(frame->pc);
>  	if (!idx) {
> -		if (frame->pc && kernel_text_address(frame->pc))
> +		if (frame->pc && kernel_text_address(frame->pc)) {
> +			if (in_module_plt(frame->pc) && frame->pc != frame->lr) {
> +				/*
> +				 * Quoting Ard: Veneers only set PC using a
> +				 * PC+immediate LDR, and so they don't affect
> +				 * the state of the stack or the register file
> +				 */
> +				frame->pc = frame->lr;
> +				return URC_OK;
> +			}
>  			pr_warn("unwind: Index not found %08lx\n", frame->pc);
> +		}
>  		return -URC_FAILURE;
>  	}
>  

-- 
Best regards,
Alexander Sverdlin.
