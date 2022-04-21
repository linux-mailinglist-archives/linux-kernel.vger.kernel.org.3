Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EAB509A15
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386319AbiDUIDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiDUIDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:03:38 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA2926F5;
        Thu, 21 Apr 2022 01:00:49 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ks6so8381139ejb.1;
        Thu, 21 Apr 2022 01:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IvbH4EZL+5AN5QzEHqEkY2O3ivfSAm4vpHw9+hhvBhg=;
        b=l9A2zxVr+iaQxUxYrdl2Ms8QPgKKprVPWu836jDS1a9kDgOF87eiKg/WQ2Pp7p0uU5
         2yNRXou7K8UFGozJ+zY/Z4nvAWfNQL2rfMjP+xXVlPOuM9uOjKLpuuReXJ/1yNQdQwuh
         j0rwMLAJikQsK++NSTkjAZZIpdlqPGGrisobY6AkDBUSn+EF1pPZ26RV1iYw2+CmyG9Z
         D2LmcczIZ72xeD8VaXUH0mDdLEb2aoTOXjcPu5w7P06BXPfBaOVOvqtrL86fe03Il6B4
         EOW8KU+HycFTbAN4tLYJDkZ3tbTG01Z6v9mMOvBRakLpz/3LsxFq95QSfevhyaAXz0Qd
         bVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IvbH4EZL+5AN5QzEHqEkY2O3ivfSAm4vpHw9+hhvBhg=;
        b=mMPZHqY1pPIrpZpVe91YkXlWi42EV943ExfwYrB94+eLM+JHhgYYiLUWa6wjXQg8Al
         iEdywdl0d4/O85cxNP9CrMfgunEr0so5FPn9VsMvihlhaXyIyGav2w3Pz8hKIdLofSGP
         sqDCo49Cdf+BMHN2HPtr97VVyWbBbqPEJ51vjmqNa5nTEJyoDhHK7oVQIjqfgp8YpOS0
         LjJDFKdb8qC3TPE1ilQsx7xAk6LAWhCVcrvUNOiTVfgGcdBraWzidRBKmqFpwbirl858
         dGp206r/ZOscDjBrkHknCvp2iE/lhcx2aDA8S1VQjjmbrXg6u+78a6wIx0xciaoV+8l0
         JdHw==
X-Gm-Message-State: AOAM533SzGKV58ctiNpXlv1n0+2cwj9xTh4jrMlCnFkSrH+dT2JiUB/6
        RCDpVcjScpNVJ8RUvsWJXTffBt0W0YJz/JJvArI=
X-Google-Smtp-Source: ABdhPJwZVRm8KFRbk9B79qovRjYyl5U7m19/ioAtyBVJMdSRPYNtjRxgrnX2fTY7SlA9nxFEZPk7MVR3ZDEQhaVY+/E=
X-Received: by 2002:a17:906:5e17:b0:6e8:b6b8:2b09 with SMTP id
 n23-20020a1709065e1700b006e8b6b82b09mr20915528eju.477.1650528047664; Thu, 21
 Apr 2022 01:00:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220419111650.1582274-1-Jason@zx2c4.com> <20220419111650.1582274-11-Jason@zx2c4.com>
In-Reply-To: <20220419111650.1582274-11-Jason@zx2c4.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 21 Apr 2022 01:00:36 -0700
Message-ID: <CAMo8Bf+ox2MQRkqsTaOOXOchOWpb+7P8GQ1c-TjwSpDgttXoFA@mail.gmail.com>
Subject: Re: [PATCH v5 10/11] xtensa: use fallback for random_get_entropy()
 instead of zero
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-crypto@vger.kernel.org,
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
        Stephen Boyd <sboyd@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "open list:SPARC + UltraSPAR..." <sparclinux@vger.kernel.org>,
        linux-um@lists.infradead.org,
        "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 4:18 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
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
> This is accomplished by just including the asm-generic code like on
> other architectures, which means we can get rid of the empty stub
> function here.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  arch/xtensa/include/asm/timex.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
