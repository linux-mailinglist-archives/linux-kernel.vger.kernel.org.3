Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0834B5360
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355160AbiBNOc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:32:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbiBNOcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:32:23 -0500
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B4A41991;
        Mon, 14 Feb 2022 06:32:15 -0800 (PST)
Received: by mail-qk1-f172.google.com with SMTP id m25so14460832qka.9;
        Mon, 14 Feb 2022 06:32:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+D9TDb8zgo7SYyd9U66f/5PMXdHiP4mRfXaTW0S+zdU=;
        b=f4byYKflNUzTLr72E+3GStpf2gLhBp60fh42HnSbM9yTeLwE4rotE2d60zbRyHg8dS
         dhpQWJycSL2RwO/tAg/lei1hUhQJOVrOF+AzZOsan1EzLCx+Rwvfot39CEx5EOBLUeA/
         r35BFZGmHVoNdZchrCO+fNjPw8OeU3C6qD0oRswRI1kHxF6HODPk8Yzu/kjuSdSTP4NN
         IMXshtVgMZe5FS8NCv2jMIH9+BdQR3HjXhojK+MD5T2GBu6Ifsk2b4f8pby89Xo3ITVd
         CV4xLIaHslCf/DScQE3AyaN0i6kP6hTdpOph694CDPB8juBYOkgHfF2hG66e2ihanuTz
         dG/g==
X-Gm-Message-State: AOAM5329TfO2xG30G4w9phlV1ZBz2fejt+yU0OD8AvU0UijIZUjjmeET
        dao24ATtBo3xkKiyc1Kv1B+CrcYq4YWhKsuP
X-Google-Smtp-Source: ABdhPJzgHQw0kWDsRpHgdImRm6LVfnu2ylZ8LNmFcGR9mbXut5XGz74HRkaaBhWodGcWtPvpF+3P6Q==
X-Received: by 2002:a05:620a:24d0:: with SMTP id m16mr7167670qkn.558.1644849134281;
        Mon, 14 Feb 2022 06:32:14 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id f20sm18099940qtf.39.2022.02.14.06.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 06:32:14 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id p19so46606414ybc.6;
        Mon, 14 Feb 2022 06:32:14 -0800 (PST)
X-Received: by 2002:ab0:384c:: with SMTP id h12mr3670905uaw.122.1644848795466;
 Mon, 14 Feb 2022 06:26:35 -0800 (PST)
MIME-Version: 1.0
References: <20220211210757.612595-1-Jason@zx2c4.com> <fcab986b-d0bd-c798-de17-266abcdc7da2@gentoo.org>
 <CAHmME9ooEbgiv3DRk87ei+rUoVNMJthY7UuG_xCgm=kfMZAajw@mail.gmail.com>
In-Reply-To: <CAHmME9ooEbgiv3DRk87ei+rUoVNMJthY7UuG_xCgm=kfMZAajw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 14 Feb 2022 15:26:24 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXDj+BVCs4Syg39vjnHGKcwJnCgDxrGoOiEFM_T4ojwPg@mail.gmail.com>
Message-ID: <CAMuHMdXDj+BVCs4Syg39vjnHGKcwJnCgDxrGoOiEFM_T4ojwPg@mail.gmail.com>
Subject: Re: [PATCH RFC v0] random: block in /dev/urandom
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Joshua Kinard <kumba@gentoo.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>
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

On Mon, Feb 14, 2022 at 3:05 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> On Sun, Feb 13, 2022 at 12:06 AM Joshua Kinard <kumba@gentoo.org> wrote:
> > The R6000/R6000A CPU only ever existed in systems in the late 1980's that
> > were fairly large, and I don't think there is a complete, working unit out
> > there that can actually boot up, let alone boot a Linux kernel.
>
> So from what you've written, it sounds like MIPS is actually not a problem here.
>
> So the only systems we're actually talking about without a good cycle
> counter are non-Amiga m68k? If so, that'd be a pretty terrific
> finding. It'd mean that this idea can move forward, and we only need
> to worry about some m68k museum pieces with misconfigured
> userspaces...

I'm afraid you missed one important detail.  You wrote:

> On every platform, random_get_entropy() is connected to get_cycles(),
> except for three: m68k, MIPS, and RISC-V.

The default implementation in include/asm-generic/timex.h is:

    static inline cycles_t get_cycles(void)
    {
            return 0;
    }

Several architectures do not implement get_cycles(), or implement it
with a variant that's very similar or identical to the generic version.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
