Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2555911C4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 15:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238549AbiHLN6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 09:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbiHLN6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 09:58:23 -0400
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EED39D8CE;
        Fri, 12 Aug 2022 06:58:21 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id m10so654714qvu.4;
        Fri, 12 Aug 2022 06:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=d7r3RnctDfwx/VdWd1r6qoq8F6MrjhkzcAY+2hCxdkY=;
        b=mO8De3TFqfcCfR+6S0AfTHxy5Vb8xMXDzGh0HKlABGaoHCopQQTjqJHnwKUVD05G4u
         Ly7qJJce6BdYzUYcEDcMlKC5p3hXtFiOOxs48/mkNEB0g07WqbZ8SPC2xq3OFLJXqTXD
         S76MU0GvwmfX1gcob3j6of+aPvBfmyYSV9QfPy64cNW08fhIWncBxYcuNeINEtwBjYn5
         Tw6d0qNMVJlv7tIaaXJLTdUqGg1aNnRXOtFnGvTV7ZdG65ZRxTYyigoDMx1QJnZgnxfP
         EwKe4p4kPHiyM9EMv2upDXW3HHywTV36h45oOPbqtGDW9WunHnuCpyYBkrmKd0CPCW4E
         HZAQ==
X-Gm-Message-State: ACgBeo2OYEnIqHmZlYnLvpt9ALMuIV0eVPvpJz+G+hX95A9TrtrbDz/4
        lyVlXLmGmKOjmKM6LVBtSJUUAsRucj/kSQ==
X-Google-Smtp-Source: AA6agR6yGJ2GGQL+2k7aUzgGKP8H2d8+YJ65r06Ln0Z5hgE6e2vSGqZ9OUDNEDzIXw0y/ny1E1HDnw==
X-Received: by 2002:a05:6214:62a:b0:476:8cb6:2b2e with SMTP id a10-20020a056214062a00b004768cb62b2emr3751068qvx.62.1660312700378;
        Fri, 12 Aug 2022 06:58:20 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id h1-20020ac87141000000b00342f5408ea5sm1820753qtp.49.2022.08.12.06.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 06:58:20 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 7so1656458ybw.0;
        Fri, 12 Aug 2022 06:58:20 -0700 (PDT)
X-Received: by 2002:a25:6890:0:b0:684:2c5c:1bd8 with SMTP id
 d138-20020a256890000000b006842c5c1bd8mr850130ybc.604.1660312221067; Fri, 12
 Aug 2022 06:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220706143521.459565-1-Jason@zx2c4.com> <20220708004032.733426-1-Jason@zx2c4.com>
In-Reply-To: <20220708004032.733426-1-Jason@zx2c4.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 12 Aug 2022 15:50:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXnF+ArtzgVH+rEKXgcujrwW2nfyMwaKB9UYf-GC3OT_w@mail.gmail.com>
Message-ID: <CAMuHMdXnF+ArtzgVH+rEKXgcujrwW2nfyMwaKB9UYf-GC3OT_w@mail.gmail.com>
Subject: Re: [PATCH v5] random: remove CONFIG_ARCH_RANDOM
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Fri, Jul 8, 2022 at 2:44 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> When RDRAND was introduced, there was much discussion on whether it
> should be trusted and how the kernel should handle that. Initially, two
> mechanisms cropped up, CONFIG_ARCH_RANDOM, a compile time switch, and
> "nordrand", a boot-time switch.
>
> Later the thinking evolved. With a properly designed RNG, using RDRAND
> values alone won't harm anything, even if the outputs are malicious.
> Rather, the issue is whether those values are being *trusted* to be good
> or not. And so a new set of options were introduced as the real
> ones that people use -- CONFIG_RANDOM_TRUST_CPU and "random.trust_cpu".
> With these options, RDRAND is used, but it's not always credited. So in
> the worst case, it does nothing, and in the best case, maybe it helps.
>
> Along the way, CONFIG_ARCH_RANDOM's meaning got sort of pulled into the
> center and became something certain platforms force-select.
>
> The old options don't really help with much, and it's a bit odd to have
> special handling for these instructions when the kernel can deal fine
> with the existence or untrusted existence or broken existence or
> non-existence of that CPU capability.
>
> Simplify the situation by removing CONFIG_ARCH_RANDOM and using the
> ordinary asm-generic fallback pattern instead, keeping the two options
> that are actually used. For now it leaves "nordrand" for now, as the
> removal of that will take a different route.
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Acked-by: Borislav Petkov <bp@suse.de>
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Thanks for your patch, which is now commit 9592eef7c16ec5fb ("random:
remove CONFIG_ARCH_RANDOM") upstream.

> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -431,7 +431,6 @@ config ADI
>  config RANDOM_TRUST_CPU
>         bool "Initialize RNG using CPU RNG instructions"
>         default y
> -       depends on ARCH_RANDOM
>         help
>           Initialize the RNG using random numbers supplied by the CPU's
>           RNG instructions (e.g. RDRAND), if supported and available. These

This change means everyone configuring a kernel will be asked this
question, even when configuring for an architecture that does not
support RNG instructions.

Perhaps this question should be hidden behind EXPERT?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
