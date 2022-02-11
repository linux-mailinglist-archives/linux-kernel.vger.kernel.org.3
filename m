Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B684B2FE9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 22:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348558AbiBKV4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 16:56:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiBKV4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 16:56:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25507C70;
        Fri, 11 Feb 2022 13:56:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2679B82D52;
        Fri, 11 Feb 2022 21:56:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4705BC340F6;
        Fri, 11 Feb 2022 21:56:12 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="PsRBXKJf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644616568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wn24kWnhRMz7wCnTG05HI8Xbl+b42NDa3gFb52wsv9A=;
        b=PsRBXKJfH5RqlIMBXOkPjesPQceucl07PK/j9G44t8haPMmU9gm7hP66U1xaY4WNL5RYb1
        VwbeurBi9e/m+y+kJf1cD6C/7bT0TWTVhPPx6sDWUTfSNH4IF8wx6cADgCpX8l9Fpv1/CG
        FV5PhqLWZCaQ2JkkeWfk6bxD/ju10A4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id af6fbfdb (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 11 Feb 2022 21:56:08 +0000 (UTC)
Received: by mail-yb1-f172.google.com with SMTP id y129so28844205ybe.7;
        Fri, 11 Feb 2022 13:56:06 -0800 (PST)
X-Gm-Message-State: AOAM530Qd6xijRiIZZSe85h/2t5Vjyey3CdJbTYZEYll7a0iHQMBUw4M
        g7/uR9YU+VmW6EfPnGeynKmRf7/C6zwTH7G1TyQ=
X-Google-Smtp-Source: ABdhPJyLM10LzwsaLFF87ZQ4YUx93mMzQV3dO/cqY5dqC5tAVZVk44GPnZhXNDL2xtDy3O4jiKmSiH43QZq5HY35AvM=
X-Received: by 2002:a25:dc14:: with SMTP id y20mr286266ybe.115.1644616564021;
 Fri, 11 Feb 2022 13:56:04 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7110:888:b0:14e:cd6d:454f with HTTP; Fri, 11 Feb 2022
 13:56:03 -0800 (PST)
In-Reply-To: <CAHk-=wh+2jokbr4tpHA=ExebWKr=qp9RJ_uFrG2gYG4ChAjitg@mail.gmail.com>
References: <20220211210757.612595-1-Jason@zx2c4.com> <CAHk-=wh+2jokbr4tpHA=ExebWKr=qp9RJ_uFrG2gYG4ChAjitg@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 11 Feb 2022 22:56:03 +0100
X-Gmail-Original-Message-ID: <CAHmME9pkhqjLtwn2kt5SkSWBQ9UW+2WLGL9momZUmY3L2wDryQ@mail.gmail.com>
Message-ID: <CAHmME9pkhqjLtwn2kt5SkSWBQ9UW+2WLGL9momZUmY3L2wDryQ@mail.gmail.com>
Subject: Re: [PATCH RFC v0] random: block in /dev/urandom
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

One thing I should clarify is that the GRND_INSECURE stuff for
getrandom(2) is a bit of a red herring with regards to the primary
intent of this patch, which is making /dev/urandom, the old char
device, block waiting for entropy.

Right now, we have:

/dev/random = getrandom(0)
/dev/urandom = getrandom(GRND_INSECURE)

This proposal is to make that:

/dev/random = getrandom(0)
/dev/urandom = getrandom(0)

Along the way I also got rid of GRND_INSECURE, but arguably that
should be a separate patch. This here is mostly about making
/dev/urandom block.


On 2/11/22, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> When try_to_generate_entropy() doesn't work, I think you now removed
> the possible fallback for user space to say "yeah, just give me best
> effort". And you might re-introduce a deadlock as a result.
>
> Those systems are arguably broken from a randomness standpoint - what
> the h*ll are you supposed to do if there's nothing generating entropy
> - but broken or not, I suspect they still exists. Those horrendous
> MIPS things were quite common in embedded networking (routers, access
> points - places that *should* care)
>
> Do I have a constructive suggestion for those broken platforms? No, I
> don't. That arguably is the reason for GRND_INSECURE existing, and the
> reason to keep it around.

It sounds like you're proposing a middle way here, which would be to
just call try_to_generate_entropy() (the "Linus Jitter Dance" code) if
!crng_ready() in /dev/urandom and getrandom(GRND_INSECURE). That's
actually a pretty good idea. It wouldn't break anything and would only
make the situation better on most systems. I think I'll probably take
your suggestion there, as it seems uncontroversially to be an
improvement.

Revisiting the original proposal though:

> I'd be willing to apply such a thing anyway - at some point "worry
> about broken platforms" ends up being too weak an excuse not to just
> apply it - but I'd like to hear more of a reason for this
simplification.

The justification for always waiting for randomness and never
returning insecure randomness to userspace isn't so much about
simplifying the code -- this patch isn't very large anyway -- but
rather for simplifying userspace crypto footguns. After several
decades of endless user confusion, we'd finally be able to say, "use
any single one of our random interfaces and you'll be fine. They're
all the same. It doesn't matter." And that, I think, would really be
something. Finally all of those blog posts and disagreeing forums and
contradictory articles would all become right about whatever they
recommended. So the one side of this is, "misconfigured userspace in a
computer history museum might run into trouble." The other side is,
"everybody gets good random numbers always." Today's thread's new
addition to that old argument is that your jitter dance makes the
downside a heck of a lot less than it used to be.

What do you make of that line of thought?

Jason
