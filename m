Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C470650E073
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 14:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236695AbiDYMiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 08:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbiDYMip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:38:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E147523A;
        Mon, 25 Apr 2022 05:35:41 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650890139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/vQEOmjYp5zP3gjuT7wBOaXzYSIrBxAEj5YMTlb1R/I=;
        b=o8c/8ctOn3hRtpFuQcOaom9ezcvPGYpfBCedt3LDDBiWCdrikhwQMmQok9kmSWJgMm9e2p
        adq4gdCZSy/rh4tiGFbyD6TOOe9Z84qMVEm+Q1dYVHWaJhNoAF5PhrDyqWS20kmAdXZ+J4
        p1PdeN6p5K2/KGjdVIfvt6WDK13l9hoPjdzNDIz5QY3NkKYFJJCsneTL3GpscfecvEgTjn
        nKmZahwLJcGkBQhsJuoBt9KcC10LQC+PB1sDMSwMfUIJ805xYM+n7r6AlJRtJwAMyVWcKz
        UnK/OvszVnCVg3XFOS2aoQ5CPwWr0HhMtfpON3D9HGGdaxb1nj9wEdjTw8ZzVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650890139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/vQEOmjYp5zP3gjuT7wBOaXzYSIrBxAEj5YMTlb1R/I=;
        b=cS3qPcRZ0So1KrcHk5gzjNJs+ZNm2h/e8l2sD2C8LPM3215wPbDQwTJECbmyTA+CBR0vZN
        224jNe/Xnz5WRXCg==
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        arnd@arndb.de
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org
Subject: Re: [PATCH v6 13/17] x86: use fallback for random_get_entropy()
 instead of zero
In-Reply-To: <20220423212623.1957011-14-Jason@zx2c4.com>
References: <20220423212623.1957011-1-Jason@zx2c4.com>
 <20220423212623.1957011-14-Jason@zx2c4.com>
Date:   Mon, 25 Apr 2022 14:35:39 +0200
Message-ID: <871qxl2vdw.ffs@tglx>
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

On Sat, Apr 23 2022 at 23:26, Jason A. Donenfeld wrote:

Please follow the guidelines of the tip maintainers when touching x86
code. https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#patch-subject

> In the event that random_get_entropy() can't access a cycle counter or
> similar, falling back to returning 0 is really not the best we can do.
> Instead, at least calling random_get_entropy_fallback() would be
> preferable, because that always needs to return _something_, even
> falling back to jiffies eventually. It's not as though
> random_get_entropy_fallback() is super high precision or guaranteed to
> be entropic, but basically anything that's not zero all the time is
> better than returning zero all the time.
>
> If CONFIG_X86_TSC=n, then it's possible that we're running on a 486
> with no RDTSC, so we only need the fallback code for that case.

There are also 586 CPUs which lack TSC.

> While we're at it, fix up both the new function and the get_cycles()
> function from which its derived to use cpu_feature_enabled() rather
> than boot_cpu_has().

Lot's of 'we' here. We are not doing anything.

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog

> +static inline unsigned long random_get_entropy(void)
> +{
> +#ifndef CONFIG_X86_TSC
> +	if (!cpu_feature_enabled(X86_FEATURE_TSC))
> +		return random_get_entropy_fallback();
> +#endif

Please get rid of this ifdeffery. While you are right, that anything
with CONFIG_X86_TSC=y should have a TSC, there is virt ....

cpu_feature_enabled() is runtime patched and only evaluated before
alternative patching, so the win of this ifdef is marginally, if even
noticable.

We surely can think about making TSC mandatory, but not selectively in a
particalur context.

Thanks,

        tglx
