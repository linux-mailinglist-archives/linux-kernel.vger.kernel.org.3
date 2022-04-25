Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7CD50E665
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243710AbiDYRFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243336AbiDYRFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:05:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C2D1C11F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:02:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DB9F614F9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 17:02:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDDFC385A7;
        Mon, 25 Apr 2022 17:02:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="BjcCxH1g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650906122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3bT9S+VY2i3onixTKTaTwovdaV7rvNqFw7jUDNK3p/o=;
        b=BjcCxH1gRx+XRu/oEPKS12iawQoa7VkVfSZYS/6iYyY8vZEaWIS2w+yUHhqPYhNIPFCA2q
        224GimbDT7u0I8jZbx0tCBLASmPOQeOaH53zbJZEFyYByqiX1d4hdDtL8vq7yar3VrxjgV
        /XuavYSenfNrBYFbhOy2DWSk0X4vB5o=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 36a3af82 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 25 Apr 2022 17:02:02 +0000 (UTC)
Date:   Mon, 25 Apr 2022 19:01:57 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: odd endianness toolchains for crosstool
Message-ID: <YmbUBZg/nGV7gLyy@zx2c4.com>
References: <YmX7z+BirkA3VAfW@zx2c4.com>
 <CAK8P3a3Af5FBx-OnedHPrf28ikX4DZK1d0ERLsV+oKyBHyCXiw@mail.gmail.com>
 <YmaJUvg6hmekvkXE@zx2c4.com>
 <CAK8P3a3FZeXzBJKyTEvmvw_DaHGQFf5rQKs=_wBW=GZ2+=rJ_Q@mail.gmail.com>
 <Yma8OQ3zY3PzY87T@zx2c4.com>
 <CAK8P3a0Y3BFCkg8e-o5i6xPfb9WVQzOQOACXtrH1VmQJkSriDQ@mail.gmail.com>
 <YmbD/oPIUBvJ/YjQ@zx2c4.com>
 <CAK8P3a1kRXQrmNg4eQw0-P+Fzz_AvFooLg3=nQNQKMRwvL9DWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a1kRXQrmNg4eQw0-P+Fzz_AvFooLg3=nQNQKMRwvL9DWQ@mail.gmail.com>
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

On Mon, Apr 25, 2022 at 06:15:07PM +0200, Arnd Bergmann wrote:
> On Mon, Apr 25, 2022 at 5:53 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > Hi Arnd,
> >
> > On Mon, Apr 25, 2022 at 05:39:34PM +0200, Arnd Bergmann wrote:
> > > I can probably do that before migrating to the new machine, but I can't
> > > promise how quickly I find time to start.
> >
> > Oh awesome. Will keep my eye out for it.
> >
> > > > (And also, build ppc32 with --enable-secureplt --with-long-double-64.)
> > >
> > > Can you explain what those are about? Is this related to the ELFv1
> > > vs ELFv2 difference or something else? Is this needed in both the
> > > ppc32 and ppc64 compilers that each come with both targets?
> >
> > For 32-bit, it is required. From
> > <https://wiki.musl-libc.org/supported-platforms.html>:
> >
> >     powerpc (needs gcc built with --enable-secureplt
> >     --with-long-double-64, and -Wl,--secure-plt to link dynamic
> >     binaries.)
> >
> > And from the INSTALL file it says:
> >
> >     * PowerPC
> >         * Compiler toolchain must provide 64-bit long double, not IBM
> >           double-double or IEEE quad
> >         * For dynamic linking, compiler toolchain must be configured for
> >           "secure PLT" variant
> >
> > For 64-bit, I'm not sure, but I know that at least -mabi=elfv2 is required,
> > and I think --with-long-double-64 too, according to documentation:
> >
> >     * PowerPC64
> >         * Both little and big endian variants are supported
> >         * Compiler toolchain must provide 64-bit long double, not IBM
> >           double-double or IEEE quad
> >         * Compiler toolchain must use the new (ELFv2) ABI regardless of
> >           whether it is for little or big endian
> 
> Ok, I see. For all I can tell, the toolchain I built already uses both
> --with-long-double-64
> and --enable-secureplt, as those seemt to be the default for Linux.

For ppc32? I'm unable to produce working executables with the toolchain.
And looking at the target info, -msecure-plt is missing, while
-mlong-double-64 is there:

$ ./powerpc-linux-gcc -Q --help=target | grep long-double
  -mlong-double-                        64
$ ./powerpc-linux-gcc -Q --help=target | grep msecure-plt
  -msecure-plt                          [disabled]

For ppc64, I see the same. I'll try to look into it more though.

> Regarding the the ELF ABI, I'm not sure how to check, but I think it
> only does ELFv1, which is the default for big-endian glibc.

Yes, it only is doing ELFv1 right now. musl checks this in
<https://git.musl-libc.org/cgit/musl/tree/configure#n689> with this:

    trycppif "_CALL_ELF == 2" "$t" || fail "$0: error: unsupported powerpc64 ABI"

Jason
