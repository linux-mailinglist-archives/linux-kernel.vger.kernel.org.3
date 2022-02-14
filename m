Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48754B52B5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354886AbiBNOFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:05:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbiBNOFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:05:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7263EB66;
        Mon, 14 Feb 2022 06:05:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CDF260F89;
        Mon, 14 Feb 2022 14:05:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E44C340F2;
        Mon, 14 Feb 2022 14:05:23 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bUqw6ue4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644847519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QLgXSQB9b7XXmln9u8fQm/jVMLmkRr2wWxHA9OmWt1Q=;
        b=bUqw6ue42avgTupnGw+h3faOhezXLsRWTERXCZkTjiWU3EWGaqVZsPu+EWoU5dYsEG+yLv
        +R8ELL3RtI+O5xzed/w6dCHENmSJY17DIsFCz4wh50dQ8yEejNWROH1hC18dE+D/kbmxlB
        0GQjkMV/rWNUQPZtVmTX+sAiVbwU9yg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 578f523a (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 14 Feb 2022 14:05:19 +0000 (UTC)
Received: by mail-yb1-f170.google.com with SMTP id p19so46358915ybc.6;
        Mon, 14 Feb 2022 06:05:18 -0800 (PST)
X-Gm-Message-State: AOAM532F4gfGjOq0Z0C7uMF+EaCAGDjZwE7npd1i7rNqJHyOKCrro5MX
        V7OL+97gtZ82qD92WNwnonghT/03r99Yb0W7B+c=
X-Google-Smtp-Source: ABdhPJx1rAQYW+BsQ/vOucuTQJhI9pVZ01yF0DPyTFL1e5L2Bmfiie7EtWck0pGXAqYbtpOZPqa2kzjO14vEvrtdV/A=
X-Received: by 2002:a25:4144:: with SMTP id o65mr12095580yba.113.1644847514782;
 Mon, 14 Feb 2022 06:05:14 -0800 (PST)
MIME-Version: 1.0
References: <20220211210757.612595-1-Jason@zx2c4.com> <fcab986b-d0bd-c798-de17-266abcdc7da2@gentoo.org>
In-Reply-To: <fcab986b-d0bd-c798-de17-266abcdc7da2@gentoo.org>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 14 Feb 2022 15:05:03 +0100
X-Gmail-Original-Message-ID: <CAHmME9ooEbgiv3DRk87ei+rUoVNMJthY7UuG_xCgm=kfMZAajw@mail.gmail.com>
Message-ID: <CAHmME9ooEbgiv3DRk87ei+rUoVNMJthY7UuG_xCgm=kfMZAajw@mail.gmail.com>
Subject: Re: [PATCH RFC v0] random: block in /dev/urandom
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joshua,

Thanks a lot for the historical background.

On Sun, Feb 13, 2022 at 12:06 AM Joshua Kinard <kumba@gentoo.org> wrote:
> The R6000/R6000A CPU only ever existed in systems in the late 1980's that
> were fairly large, and I don't think there is a complete, working unit out
> there that can actually boot up, let alone boot a Linux kernel.

So from what you've written, it sounds like MIPS is actually not a problem here.

So the only systems we're actually talking about without a good cycle
counter are non-Amiga m68k? If so, that'd be a pretty terrific
finding. It'd mean that this idea can move forward, and we only need
to worry about some m68k museum pieces with misconfigured
userspaces...

Jason
