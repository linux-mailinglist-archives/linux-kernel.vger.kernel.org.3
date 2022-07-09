Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9789E56C5CA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 03:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiGIBv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 21:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiGIBvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 21:51:55 -0400
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D3E71709
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 18:51:54 -0700 (PDT)
Received: from [IPV6:2601:646:8600:40c0:425:cd56:6750:e1bf] ([IPv6:2601:646:8600:40c0:425:cd56:6750:e1bf])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.15.2) with ESMTPSA id 2691pLJW2002161
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 8 Jul 2022 18:51:22 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 2691pLJW2002161
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022070501; t=1657331482;
        bh=dPzbUbU2KTNW1KlzlD3Fu+Pwv5VzHijL+VHbQPZN/88=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=12p46JWhFkklwYxQSRDhwe+rcEsnfPufbXLyzzSgLmeFoZoAXt3bm35A2816AKZEs
         EMf8k8qPAojkMPOBAVXHti92SxoGZULCMbeRNO44Qp10skQNUkPhPcY29nVuAmK4eG
         mtSNC3Lz6ZXOByLZ3dZA/gVkT9AoAddhwRar5W+2xZJ1tlEjgF2TQVEA0r52F2oK5X
         lSJ65K3bvYBm7pA+p4mpXDDfTe1iVHpCar5MY7uDn5f7Ez/qVQXOG4WIxQmgHiPWWE
         ThCO0Moc8Ln2KHX56YepHAepxj6uHcUApc0Qgx+Dx4MTNZq6z2qsOYSTh9UoRS7aLd
         9SkKKEPIf5C0w==
Message-ID: <ddba81dd-cc92-699c-5274-785396a17fb5@zytor.com>
Date:   Fri, 8 Jul 2022 18:51:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH tip v8] x86/setup: Use rng seeds from setup_data
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
References: <20220707000852.523788-1-Jason@zx2c4.com>
 <20220708113907.891319-1-Jason@zx2c4.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20220708113907.891319-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/22 04:39, Jason A. Donenfeld wrote:
> 
> diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
> index ca0796ac4403..2cbfe630230d 100644
> --- a/arch/x86/include/uapi/asm/bootparam.h
> +++ b/arch/x86/include/uapi/asm/bootparam.h
> @@ -12,6 +12,7 @@
>   #define SETUP_JAILHOUSE			6
>   #define SETUP_CC_BLOB			7
>   #define SETUP_IMA			8
> +#define SETUP_RNG_SEED			9
>   
>   #define SETUP_INDIRECT			(1<<31)
>   

Just one miss here: you need to bump SETUP_TYPE_MAX. It is a bit more 
confusing than it needs to be that SETUP_INDIRECT sits in between, and 
honestly I think SETUP_TYPE_MAX shouldn't include the SETUP_INDIRECT 
bit; however, this is uapi and so we can't change that per se.

Perhaps we should do:

#define SETUP_ENUM_MAX	SETUP_RNG_SEED
#define SETUP_INDIRECT	(1<<31)
#define SETUP_TYPE_MAX	(SETUP_ENUM_MAX | SETUP_INDIRECT)

	-hpa
