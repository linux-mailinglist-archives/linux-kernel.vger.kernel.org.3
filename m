Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AF853D5DA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 08:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242221AbiFDGnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 02:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbiFDGnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 02:43:08 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629492DA96
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 23:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1654324983; bh=qB+KW58ZEQfzMJToUWG5TcuxrusU03zuZZ33bh3iuIM=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=ZCnOrwgfiq6O1hPhQ5BCLiFTJBrOjHq5rAFtRdHspzAZmsdb77K2/BypZlpwEK4kX
         9uKFWxQudSLmMxBQAMGzjtwq56dddNKbd8yZZw2q1AHEU06F4C/bYdzhfed4uW6V+Q
         ZSMeupU6ZsBhOIXKbj1by2tSMtRH2TEihwMksGUY=
Received: from [192.168.9.172] (unknown [101.88.28.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 2743C600FF;
        Sat,  4 Jun 2022 14:43:03 +0800 (CST)
Message-ID: <18ffcffb-1335-03ec-ac34-f75264460e13@xen0n.name>
Date:   Sat, 4 Jun 2022 14:43:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:103.0) Gecko/20100101
 Thunderbird/103.0a1
Subject: Re: [PATCH] LoongArch: Remove MIPS comment about cycle counter
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>, chenhuacai@kernel.org,
        kernel@xen0n.name, linux-kernel@vger.kernel.org, arnd@arndb.de
References: <20220604063525.397826-1-Jason@zx2c4.com>
Content-Language: en-US
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20220604063525.397826-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/22 14:35, Jason A. Donenfeld wrote:
> This comment block was taken originally from the MIPS architecture code,
> where indeed there are particular assumptions one can make regarding SMP
> and !SMP and cycle counters. On LoongArch, however, the rdtime family of
> functions is always available. As Xuerui wrote:
>
>      The rdtime family of instructions is in fact guaranteed to be
>      available on LoongArch; LoongArch's subsets all contain them, even
>      the 32-bit "Primary" subset intended for university teaching -- they
>      provide the rdtimeh.w and rdtimel.w pair of instructions that access
>      the same 64-bit counter.
>
> So this commit simply removes the incorrect comment block.
>
> Link: https://lore.kernel.org/lkml/e78940bc-9be2-2fe7-026f-9e64a1416c9f@xen0n.name/
> Fixes: b738c106f735 ("LoongArch: Add other common headers")
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>   arch/loongarch/include/asm/timex.h | 7 -------
>   1 file changed, 7 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/timex.h b/arch/loongarch/include/asm/timex.h
> index d3ed99a4fdbd..fb41e9e7a222 100644
> --- a/arch/loongarch/include/asm/timex.h
> +++ b/arch/loongarch/include/asm/timex.h
> @@ -12,13 +12,6 @@
>   #include <asm/cpu.h>
>   #include <asm/cpu-features.h>
>   
> -/*
> - * Standard way to access the cycle counter.
> - * Currently only used on SMP for scheduling.
> - *
> - * We know that all SMP capable CPUs have cycle counters.
> - */
> -
>   typedef unsigned long cycles_t;
>   
>   #define get_cycles get_cycles

Just as previously discussed. Thanks for the quick fixup!

Reviewed-by: WANG Xuerui <git@xen0n.name>
