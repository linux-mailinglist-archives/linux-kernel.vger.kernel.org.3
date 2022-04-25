Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8830050E4D5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243050AbiDYP4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbiDYP4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:56:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD4F3A5D1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 08:53:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A69761142
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 15:53:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC13C385A4;
        Mon, 25 Apr 2022 15:53:40 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="CDuL4RLG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650902018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TYv02nqT8LcvMlXJxnWlkxCIRFVS6R35nISm2N1D/HY=;
        b=CDuL4RLGyZ7VLwzmCoz+E+9yeneOLARHep/mZG8bYZZbYgLm4jYFeO1Upbf+ZL1mrm8WHD
        +65bni3Fgc9uise2MPPTDbelMDc+9qBBvgzEYIE+FpaBQIESoGHzw6eqErisxDORGuAxAz
        oXi6xk1XjYM9QSMxlgN9sxs86gOvNB8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 01f09244 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 25 Apr 2022 15:53:37 +0000 (UTC)
Date:   Mon, 25 Apr 2022 17:53:34 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: odd endianness toolchains for crosstool
Message-ID: <YmbD/oPIUBvJ/YjQ@zx2c4.com>
References: <YmX7z+BirkA3VAfW@zx2c4.com>
 <CAK8P3a3Af5FBx-OnedHPrf28ikX4DZK1d0ERLsV+oKyBHyCXiw@mail.gmail.com>
 <YmaJUvg6hmekvkXE@zx2c4.com>
 <CAK8P3a3FZeXzBJKyTEvmvw_DaHGQFf5rQKs=_wBW=GZ2+=rJ_Q@mail.gmail.com>
 <Yma8OQ3zY3PzY87T@zx2c4.com>
 <CAK8P3a0Y3BFCkg8e-o5i6xPfb9WVQzOQOACXtrH1VmQJkSriDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a0Y3BFCkg8e-o5i6xPfb9WVQzOQOACXtrH1VmQJkSriDQ@mail.gmail.com>
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

On Mon, Apr 25, 2022 at 05:39:34PM +0200, Arnd Bergmann wrote:
> I can probably do that before migrating to the new machine, but I can't
> promise how quickly I find time to start.

Oh awesome. Will keep my eye out for it.

> > (And also, build ppc32 with --enable-secureplt --with-long-double-64.)
> 
> Can you explain what those are about? Is this related to the ELFv1
> vs ELFv2 difference or something else? Is this needed in both the
> ppc32 and ppc64 compilers that each come with both targets?

For 32-bit, it is required. From
<https://wiki.musl-libc.org/supported-platforms.html>:

    powerpc (needs gcc built with --enable-secureplt
    --with-long-double-64, and -Wl,--secure-plt to link dynamic
    binaries.)

And from the INSTALL file it says:

    * PowerPC
        * Compiler toolchain must provide 64-bit long double, not IBM
          double-double or IEEE quad
        * For dynamic linking, compiler toolchain must be configured for
          "secure PLT" variant

For 64-bit, I'm not sure, but I know that at least -mabi=elfv2 is required,
and I think --with-long-double-64 too, according to documentation:

    * PowerPC64
        * Both little and big endian variants are supported
        * Compiler toolchain must provide 64-bit long double, not IBM
          double-double or IEEE quad
        * Compiler toolchain must use the new (ELFv2) ABI regardless of
          whether it is for little or big endian

Taken from <https://git.musl-libc.org/cgit/musl/tree/INSTALL#n35>.

Jason
