Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5BF50DF19
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 13:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbiDYLqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 07:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbiDYLq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 07:46:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24F73F33C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 04:43:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CEAC6122E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 11:43:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EFB9C385A4;
        Mon, 25 Apr 2022 11:43:18 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JUlHQGsN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650886997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dFQFgLKIXdwpC7gw7HWki/oynZMfFAMX97C9xQNgYAA=;
        b=JUlHQGsN1c2HUeF9GTU57/ZeYwM8zz9eemO1doVPELkwBqEG2tJz6U83/8Sj/BUdcG1gPX
        LHnR54uCJV1bsOoEiTJjuchZZbJWVHswDe6ggdslT4SEPKe/owpwthK23usIMjI24/XwNB
        mIzzO5sb8PHqUn/b0IzIFaH/nhUEP7E=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b1555fd5 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 25 Apr 2022 11:43:16 +0000 (UTC)
Date:   Mon, 25 Apr 2022 13:43:14 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: odd endianness toolchains for crosstool
Message-ID: <YmaJUvg6hmekvkXE@zx2c4.com>
References: <YmX7z+BirkA3VAfW@zx2c4.com>
 <CAK8P3a3Af5FBx-OnedHPrf28ikX4DZK1d0ERLsV+oKyBHyCXiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a3Af5FBx-OnedHPrf28ikX4DZK1d0ERLsV+oKyBHyCXiw@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, Apr 25, 2022 at 10:46:45AM +0200, Arnd Bergmann wrote:
> The situation on my end is that I'm planning to migrate my main workstation
> (which I'm building the compilers on) to an arm64 machine soon, and
> will then need to set it all up again. I don't really want to change much before
> then to avoid changing things twice.

Ahh, okay, so probably crosstool won't be viable for me for a while. Are
your existing scripts fairly reproducible and easy? I suppose I could
just build my own if I can't find another project supplying light
compilers.

> I've added Nick to Cc, as he's experimenting with a clang based toolchain
> that we can put on kernel.org along with the gcc toolchains, and that
> would probably include a musl based sysroot roughly the same set of
> architectures that you are testing on already. Possibly we could reuse the
> same user space between clang and gcc.

I personally have no use for compilers with user spaces. My test harness
builds musl as part of it. It's really the quickest part of the entire
harness to build. I also probably won't switch things over to clang;
Google has the resources to do that themselves. Basically all I need is
the boring nolibc compilers for a few extra platforms, and for the ppc
one to build with the mentioned flags.

> I've also looked at other projects that do qemu based testing, everyone
> seems to be missing one or two architectures out of a common set,
> https://tinyurl.com/linux-architectures is where I keep my data.

If the compilers are there, and they can build a working musl, and QEMU
will boot it, and I can work out a minimal kernel .config that doesn't
take a long time to compile, then it'll get included in the CI. So in
theory, I should be able to expand the portfolio of architectures I'm
using.

> building and running the most common subset of these in one place
> in the kernel tree where at least wireguard, kunit and tuxrun can
> share the setup for qemu.

I have little interest in that kind of abstraction unfortunately.
WireGuard's test suite is optimized for building minimal kernels that
exercise its functionality. Tons of emphasis is placed on those kernels
being minimal. And the userspaces too. The whole thing needs to compile
fast and boot fast. Perhaps megacorps can afford to throw massive
clusters at this, but I'm trying to test every single commit across 10
or so trees on every architecture that I can, from one box. Plus, I use
this when developing on my laptop. If it takes forever to build and if I
can't iterate fast on it, then it's simply not useful for me (or for
other various contributors who have been able to quickly pick up the
WireGuard test suite for development without a lot of futzing). So for
that reason, I don't see a lot of promise in making a monster
abstraction layer that does all the things. Plus, the more people who
invent the wheel (which is not even a particularly interesting wheel)
the more odd configurations and bugs we'll surface.

Jason
