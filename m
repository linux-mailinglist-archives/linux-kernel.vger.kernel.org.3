Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC515221B9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347682AbiEJQy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347693AbiEJQyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:54:50 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B76F21240
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 09:50:52 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id qe3-20020a17090b4f8300b001dc24e4da73so2032711pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 09:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+OrGejelLd0/r3wyZ5B1hnRpKSyjyIABgvgW47LLooY=;
        b=Gt3pUi+fMXEx3yt2N7YDLecB+fh8bnsLUAhNGUelGqYArf8brh67ItBKmaEnAgRcJZ
         Xn0T4bUlGe+xa2Q61dbd1UN2FxULHx3pyMndliDEIMP27wn1EQOW7+KCOIZCsvJeBMyq
         2XF7RfKJS4EUpzD9NKR3C7JBY30zzrejdnYVVu5ztvIJBW4OvjIlkwg5vVRtViCmSuaW
         E3KMSYj3+0wXUIm7Mi6iNv083gU+nI64HjxkquUcTG3XfwIqFihSO/nHoKEXIMo8wOKt
         Z7Ufq5YVcpRQc7kOVM/cW5bAA2pX+FHJK9wkUK3GsyEHYrWOVxot2YGDtoXUT8P4+QC4
         PiKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+OrGejelLd0/r3wyZ5B1hnRpKSyjyIABgvgW47LLooY=;
        b=69m9ew3UAcnk2c8nDRQfoJa1xWSmXrrPyF7U6hcZsVihMFwPpH1J/Gan7Nnvy93KZO
         h9KkieDbTLIOaJXcIOl6j8J+W/Qtcg76CYUqEobzWx/q01usSov4cmgpBTZgTsR1vkDM
         X9eGgT8isMfLX/pTkorFodER/6JDRtqrFAg8RifnoWNLVvA110EKbaSW9qUSyQytv8YA
         TNcABhIddoAwM0b0GAam9BZ87UNhaZQUWsyaPl8Ml698Zy5x4E4ug6PRaxoWhoRVTX/9
         w5e1CGhXSJjIuJG9JQs42LRdLc1K1SJOp1y99D9kQuj3haITB0+m+kyyGohfj2z8ojfy
         4vaQ==
X-Gm-Message-State: AOAM533kQRAeMckLuUmjGEEgnH0G3z0GedLYcM6Dpv5mKL0U9zdNbVfr
        QU02M5nQDQMe0fc+q8df0L4GxS6icUsQQh/r60c=
X-Google-Smtp-Source: ABdhPJwffULAkMAIgasr7aNCVYP16kgnCweiJCKt6lygDrJlUDTcxhAsvV/eEsmYgsYZy1m3uAjEKYK6SpK8RmgIbKQ=
X-Received: by 2002:a17:90a:8591:b0:1b9:da10:2127 with SMTP id
 m17-20020a17090a859100b001b9da102127mr818585pjn.13.1652201451374; Tue, 10 May
 2022 09:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220510154750.212913-1-yury.norov@gmail.com> <20220510154750.212913-9-yury.norov@gmail.com>
In-Reply-To: <20220510154750.212913-9-yury.norov@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 10 May 2022 09:50:40 -0700
Message-ID: <CAADnVQKcX2xEWCHu-DX0Cy_mvCL6E0aE_BF1Wo+U-vy_Bi2-3w@mail.gmail.com>
Subject: Re: [PATCH 08/22] bitops: introduce MANY_BITS() macro
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Laight <David.Laight@aculab.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matti Vaittinen <Matti.Vaittinen@fi.rohmeurope.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Zankel <chris@zankel.net>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 8:48 AM Yury Norov <yury.norov@gmail.com> wrote:
>
> arch/xtensa/kernel/traps.c and include/linux/log2.h define very similar
> functions with different behaviour. XTENSA defines IS_POW2(), and
> log2.h defines is_power_of_2(). The difference is that IS_POW2()
> considers 0 as power of 2, while is_power_of_2() - does not.
>
> This discrepancy may confuse reader. From mathematical point of view,
> 0 is not a power of 2. So let's introduce macro MANY_BITS(), which
> returns true if 2 or more bits are set in a number (which is what
> XTENSA actually needs), and use it in is_power_of_2().
>
> CC: Alexei Starovoitov <ast@kernel.org>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: Chris Zankel <chris@zankel.net>
> CC: Christophe Leroy <christophe.leroy@csgroup.eu>
> CC: Eric W. Biederman <ebiederm@xmission.com>
> CC: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> CC: Max Filippov <jcmvbkbc@gmail.com>
> CC: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> CC: linux-xtensa@linux-xtensa.org
> CC: linux-kernel@vger.kernel.org
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  arch/xtensa/kernel/traps.c | 5 +----
>  include/linux/bitops.h     | 3 +++
>  include/linux/log2.h       | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
> index 138a86fbe9d7..040ec38bfce2 100644
> --- a/arch/xtensa/kernel/traps.c
> +++ b/arch/xtensa/kernel/traps.c
> @@ -203,10 +203,7 @@ static void do_multihit(struct pt_regs *regs)
>
>  #if XTENSA_FAKE_NMI
>
> -#define IS_POW2(v) (((v) & ((v) - 1)) =3D=3D 0)
> -
> -#if !(PROFILING_INTLEVEL =3D=3D XCHAL_EXCM_LEVEL && \
> -      IS_POW2(XTENSA_INTLEVEL_MASK(PROFILING_INTLEVEL)))
> +#if (MANY_BITS(XTENSA_INTLEVEL_MASK(PROFILING_INTLEVEL)) || PROFILING_IN=
TLEVEL !=3D XCHAL_EXCM_LEVEL)
>  #warning "Fake NMI is requested for PMM, but there are other IRQs at or =
above its level."
>  #warning "Fake NMI will be used, but there will be a bugcheck if one of =
those IRQs fire."
>
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index 7aaed501f768..96bc6a2552d6 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -21,6 +21,9 @@
>  #define BITS_TO_U32(nr)                __KERNEL_DIV_ROUND_UP(nr, BITS_PE=
R_TYPE(u32))
>  #define BITS_TO_BYTES(nr)      __KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(c=
har))
>
> +/* Return: nonzero if 2 or more bits are set */
> +#define MANY_BITS(n)           ((n) & ((n) - 1))
> +
>  extern unsigned int __sw_hweight8(unsigned int w);
>  extern unsigned int __sw_hweight16(unsigned int w);
>  extern unsigned int __sw_hweight32(unsigned int w);
> diff --git a/include/linux/log2.h b/include/linux/log2.h
> index 9f30d087a128..335b9dbd302d 100644
> --- a/include/linux/log2.h
> +++ b/include/linux/log2.h
> @@ -44,7 +44,7 @@ int __ilog2_u64(u64 n)
>  static inline __attribute__((const))
>  bool is_power_of_2(unsigned long n)
>  {
> -       return (n !=3D 0 && ((n & (n - 1)) =3D=3D 0));
> +       return n !=3D 0 && !MANY_BITS(n);
>  }

Please don't. Open coded version is much easier to read.
