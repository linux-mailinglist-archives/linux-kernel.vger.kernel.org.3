Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1402E4FF8FF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 16:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236055AbiDMOfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 10:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbiDMOfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:35:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE895676A;
        Wed, 13 Apr 2022 07:32:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38CA661BA6;
        Wed, 13 Apr 2022 14:32:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA83C385A6;
        Wed, 13 Apr 2022 14:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649860366;
        bh=y/gFQs+hgHZ3/vvOq41ylGPCtjhP53O/JBKcPRIcQfg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c6zZdWDOUnHSGNHfBTXEBVZObxER3VgBA/8QflX/jfQ5RRQ8Bxgqk2eFNQ2MXzEuy
         jSkpa6Jwc1N4IvWLMHH+Zt0+XCE7tpnn8KFoIgvwAN4tQB93mzX7TE3tlvhL6XG/Fr
         WTnRTPKLKs7TxKy144wJ8pe88A68vmmh5K4rknhCaZes7AxMngvMVG8iLOIfcPhXiw
         fEpxXUDgzsVLgt2eQn6aeFnaL7eLX0DZMkr1aWcOFtdc0XWBwsSNtD31Y7tfNtZO5t
         Xo068bQO4+veX4gUup6qM1r8ayg9R8rjAguYKzFRRu+kP9M7+oBWwfwk7CyrX1OCiG
         araLq0MFphDFg==
Received: by mail-io1-f43.google.com with SMTP id 9so2089173iou.5;
        Wed, 13 Apr 2022 07:32:46 -0700 (PDT)
X-Gm-Message-State: AOAM532oM5Vh0Qd7XdCfuH6CoK5N2MVtuwPHjv6/LRkBqhWrj1MlUJYp
        QYh7hTQdm4Tcv698Oz3OhrZSVXTfqwcWDWchxg==
X-Google-Smtp-Source: ABdhPJztV5+8KEJ74WCQvEE2mueV1uP9FdDpJontci3NKw8uFVcyU1+ScsVCAwrzKj/88xIwClDnzYiNbkHkece/VFk=
X-Received: by 2002:a05:6638:24d0:b0:326:34d2:5c22 with SMTP id
 y16-20020a05663824d000b0032634d25c22mr6761858jat.91.1649860365852; Wed, 13
 Apr 2022 07:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220413115411.21489-1-Jason@zx2c4.com> <20220413115411.21489-2-Jason@zx2c4.com>
In-Reply-To: <20220413115411.21489-2-Jason@zx2c4.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 13 Apr 2022 09:32:34 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJYq5Oe_zBbcwYNMpfpqGLGCyaSfGqOrPjZ_Pj=nF73mA@mail.gmail.com>
Message-ID: <CAL_JsqJYq5Oe_zBbcwYNMpfpqGLGCyaSfGqOrPjZ_Pj=nF73mA@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] timekeeping: add raw clock fallback for random_get_entropy()
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

On Wed, Apr 13, 2022 at 6:55 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> The addition of random_get_entropy_fallback() provides access to
> whichever time source has the highest frequency, which is useful for
> gathering entropy on platforms without available cycle counters. It's
> not necessarily as good as being able to quickly access a cycle counter
> that the CPU has, but it's still something, even when it falls back to
> being jiffies-based.
>
> In the event that a given arch does not define get_cycles(), falling
> back to the get_cycles() default implementation that returns 0 is really
> not the best we can do. Instead, at least calling
> random_get_entropy_fallback() would be preferable, because that always
> needs to return _something_, even falling back to jiffies eventually.
> It's not as though random_get_entropy_fallback() is super high precision
> or guaranteed to be entropic, but basically anything that's not zero all
> the time is better than returning zero all the time.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  include/linux/timex.h     |  8 ++++++++
>  kernel/time/timekeeping.c | 10 ++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/include/linux/timex.h b/include/linux/timex.h
> index 5745c90c8800..fbbe34226044 100644
> --- a/include/linux/timex.h
> +++ b/include/linux/timex.h
> @@ -62,6 +62,8 @@
>  #include <linux/types.h>
>  #include <linux/param.h>
>
> +extern unsigned long random_get_entropy_fallback(void);
> +
>  #include <asm/timex.h>
>
>  #ifndef random_get_entropy
> @@ -74,8 +76,14 @@
>   *
>   * By default we use get_cycles() for this purpose, but individual
>   * architectures may override this in their asm/timex.h header file.
> + * If a given arch does not have get_cycles(), then we fallback to

'does not have a usable get_cycles(), ...' as clearly some arches have
get_cycles() and yet still need a fallback.

Why not handle the 'if get_cycles() returns 0 do the fallback' within
a weak random_get_entropy() function? Then more arches don't need any
random_get_entropy() implementation.

Rob
