Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C2A48C1EA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 11:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239681AbiALKDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 05:03:44 -0500
Received: from ivanoab7.miniserver.com ([37.128.132.42]:38190 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239166AbiALKDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 05:03:43 -0500
Received: from [192.168.18.6] (helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1n7aTb-0000Pp-57; Wed, 12 Jan 2022 10:03:35 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1n7aTY-00Bvyg-Bo; Wed, 12 Jan 2022 10:03:30 +0000
Subject: Re: [PATCH] um: fix and optimize xor select template for CONFIG64 and
 timetravel mode
To:     Benjamin Beichler <benjamin.beichler@uni-rostock.de>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>
Cc:     johannes.berg@intel.com, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220111200507.1445489-1-benjamin.beichler@uni-rostock.de>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <1b6de9af-905c-1416-1fd3-f22748befa60@cambridgegreys.com>
Date:   Wed, 12 Jan 2022 10:03:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220111200507.1445489-1-benjamin.beichler@uni-rostock.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/01/2022 20:05, Benjamin Beichler wrote:
> Due to dropped inclusion of asm-generic/xor.h, xor_block_8regs symbol is
> missing with CONFIG64 and break compilation, as the asm/xor_64.h also did
> not include it. The patch recreate the logic from arch/x86, which check
> whether AVX is available and add fallbacks for 32bit and 64bit config of
> um.
> 
> A very minor additional "fix" is, the return of the macro parameter
> instead of NULL, as this is the original intent of the macro, but
> this does not change the actual behavior.
> 
> Fixes: c0ecca6604b8 ("um: enable the use of optimized xor routines in UML")
> Signed-off-by: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
> ---
>   arch/um/include/asm/xor.h | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/um/include/asm/xor.h b/arch/um/include/asm/xor.h
> index f512704a9ec7..22b39de73c24 100644
> --- a/arch/um/include/asm/xor.h
> +++ b/arch/um/include/asm/xor.h
> @@ -4,8 +4,10 @@
>   
>   #ifdef CONFIG_64BIT
>   #undef CONFIG_X86_32
> +#define TT_CPU_INF_XOR_DEFAULT (AVX_SELECT(&xor_block_sse_pf64))
>   #else
>   #define CONFIG_X86_32 1
> +#define TT_CPU_INF_XOR_DEFAULT (AVX_SELECT(&xor_block_8regs))
>   #endif
>   
>   #include <asm/cpufeature.h>
> @@ -16,7 +18,7 @@
>   #undef XOR_SELECT_TEMPLATE
>   /* pick an arbitrary one - measuring isn't possible with inf-cpu */
>   #define XOR_SELECT_TEMPLATE(x)	\
> -	(time_travel_mode == TT_MODE_INFCPU ? &xor_block_8regs : NULL)
> +	(time_travel_mode == TT_MODE_INFCPU ? TT_CPU_INF_XOR_DEFAULT : x))
>   #endif
>   
>   #endif
> 
Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>
-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
