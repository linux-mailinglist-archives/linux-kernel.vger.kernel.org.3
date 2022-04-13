Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675E14FF921
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 16:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236176AbiDMOmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 10:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbiDMOmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:42:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175271ADA4;
        Wed, 13 Apr 2022 07:40:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA78B61C44;
        Wed, 13 Apr 2022 14:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14502C385A9;
        Wed, 13 Apr 2022 14:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649860825;
        bh=78m64rXl3BqnnR/vfXtui5J5LLZFfkI1NSRN1fS+Ck0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D54WqGsxh9YBnBgVmvFtiH5xy6s421ODtURwwd50VnkQ1mXHYGJ+2NWNkXVfQZun6
         Um89dJ+0wbeFbHd3sSL9OoZB6/ZY5yarddaEataYCkikYsyn8eI7/xeCzq+VRRV8xe
         BZGcLMcKA8UBjiGbU0QRPsb6ObofS55dzwMzW99Oi0rFBFu1zhfvS81FAMTyxhutkG
         NKI0fhh2MqANm0VuID9wzWfkhT536p0LR4pZOQgULlpV4jISPYbXfl5zWUTcwNZh7f
         b9siyKpl0nHPTnRLdyWkhzMGHOp3r3auUj1pWuEHuj45bmaIeTgj3nYkCxjnDipmbN
         iVdUdXACq3mCA==
Received: by mail-il1-f171.google.com with SMTP id y16so1234114ilc.7;
        Wed, 13 Apr 2022 07:40:25 -0700 (PDT)
X-Gm-Message-State: AOAM531EOR2kz6q0YaDoaGbVTC2RSx2qodFFyndjP6XyMJaALgSAbcfn
        60f5ghnAPpBgUajB4CwVsfJSbi9WjB4q9LE2og==
X-Google-Smtp-Source: ABdhPJwPF0VHE9D8w/oeESIlTTrvwO1gVXfb+xfx+0hNhkJEN+zqgaOI+EWicwhkoM5T8fMAkoGBIRO6Tom03sqTu+o=
X-Received: by 2002:a92:dd86:0:b0:2bc:805c:23c7 with SMTP id
 g6-20020a92dd86000000b002bc805c23c7mr17523118iln.279.1649860824300; Wed, 13
 Apr 2022 07:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220413115411.21489-1-Jason@zx2c4.com> <20220413115411.21489-4-Jason@zx2c4.com>
In-Reply-To: <20220413115411.21489-4-Jason@zx2c4.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 13 Apr 2022 09:40:13 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ86vZKZQO+9_Kva-EbZrRPMbcgDm+UvjJdnR=GL-qHSw@mail.gmail.com>
Message-ID: <CAL_JsqJ86vZKZQO+9_Kva-EbZrRPMbcgDm+UvjJdnR=GL-qHSw@mail.gmail.com>
Subject: Re: [PATCH v4 03/11] riscv: use fallback for random_get_entropy()
 instead of zero
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, "Theodore Ts'o" <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-m68k@lists.linux-m68k.org,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-um@lists.infradead.org, X86 ML <x86@kernel.org>,
        linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 6:56 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> In the event that random_get_entropy() can't access a cycle counter or
> similar, falling back to returning 0 is really not the best we can do.
> Instead, at least calling random_get_entropy_fallback() would be
> preferable, because that always needs to return _something_, even
> falling back to jiffies eventually. It's not as though
> random_get_entropy_fallback() is super high precision or guaranteed to
> be entropic, but basically anything that's not zero all the time is
> better than returning zero all the time.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  arch/riscv/include/asm/timex.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/timex.h
> index 507cae273bc6..d6a7428f6248 100644
> --- a/arch/riscv/include/asm/timex.h
> +++ b/arch/riscv/include/asm/timex.h
> @@ -41,7 +41,7 @@ static inline u32 get_cycles_hi(void)
>  static inline unsigned long random_get_entropy(void)
>  {
>         if (unlikely(clint_time_val == NULL))

Moving this check to get_cycles() implementation would eliminate the
RiscV implementation of random_get_entropy() if you follow my other
suggestion.

I guess there's some advantage to skipping a NULL check every time for
get_cycles(), but really the register read time will be much slower
than an added check.

> -               return 0;
> +               return random_get_entropy_fallback();
>         return get_cycles();
>  }
>  #define random_get_entropy()   random_get_entropy()
