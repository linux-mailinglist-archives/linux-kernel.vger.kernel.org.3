Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748C650E667
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243677AbiDYRHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiDYRHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:07:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5123AA46;
        Mon, 25 Apr 2022 10:03:56 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650906234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b+OWVO0fzMR/trFOharRDcyH34U+0AZn+XGudcUzuxs=;
        b=NIjSrnIuuue52fS2iY5thz6ZGwoLoNSt77GrW3duDJAEyNu/ck+xSkAbs9QkcP8Pl1wgxs
        ZYtI9sShSLJ9ruzN+fyaUln5s22nwGb0i3TQ2KuqGkf2b8f6wVTq2485AdI/rwKsUKhJS3
        +FewYMu9wO1yrD9ev4/dYR2onXh9hPrD1Wvs0PGcE69aUNP9kJSOTt1ErAXtACzBFMhCRd
        L2wFkn4LNOJOd9ojGHrIBijKn3+ZPVc4FDhhKCjEcY/LKXjDV+1j81N4ZSmp9hlvOsoqHH
        aXMS/c76R0iuuuCGCUS6mfgv+AL0Y9TRqW6+NKTUvAeXbCpp6I27u/IyWkwhYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650906234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b+OWVO0fzMR/trFOharRDcyH34U+0AZn+XGudcUzuxs=;
        b=WKm9lUZQI3KLyUQHB5MnOvY4PfJWBIypTavG6wmYMz/WZMGX8yIbTgVB5LiFZuBQ4aeXA/
        0uK2i+N7KN5WOlCQ==
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        arnd@arndb.de, Borislav Petkov <bp@alien8.de>, x86@kernel.org
Subject: Re: [PATCH v6 13/17] x86: use fallback for random_get_entropy()
 instead of zero
In-Reply-To: <Ymak7LJd6GnFxsOo@zx2c4.com>
References: <20220423212623.1957011-1-Jason@zx2c4.com>
 <20220423212623.1957011-14-Jason@zx2c4.com> <871qxl2vdw.ffs@tglx>
 <Ymak7LJd6GnFxsOo@zx2c4.com>
Date:   Mon, 25 Apr 2022 19:03:54 +0200
Message-ID: <87ilqx14ed.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25 2022 at 15:41, Jason A. Donenfeld wrote:
> On Mon, Apr 25, 2022 at 02:35:39PM +0200, Thomas Gleixner wrote:
>> > +static inline unsigned long random_get_entropy(void)
>> > +{
>> > +#ifndef CONFIG_X86_TSC
>> > +	if (!cpu_feature_enabled(X86_FEATURE_TSC))
>> > +		return random_get_entropy_fallback();
>> > +#endif
>> 
>> Please get rid of this ifdeffery. While you are right, that anything
>> with CONFIG_X86_TSC=y should have a TSC, there is virt ....
>> 
>> cpu_feature_enabled() is runtime patched and only evaluated before
>> alternative patching, so the win of this ifdef is marginally, if even
>> noticable.
>> 
>> We surely can think about making TSC mandatory, but not selectively in a
>> particalur context.
>
> This would be a regression of sorts from the current code, which reads:
>
>     static inline cycles_t get_cycles(void)
>     {
>     #ifndef CONFIG_X86_TSC
>             if (!boot_cpu_has(X86_FEATURE_TSC))
>                     return 0;
>     #endif
>             return rdtsc();
>     }

Bah. Indeed. Misread the patch, but yes, if you are at it to make that
cpu_feature_enabled() then change the config thing to IS_ENABLED() too.

Thanks,

        tglx
