Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0587D50E43D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237702AbiDYPXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiDYPXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:23:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C402B822E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 08:20:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F227DB815E2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 15:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B81C385A4;
        Mon, 25 Apr 2022 15:20:31 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JnGRaUGf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650900029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AtXYxoxurgVSo3CaX68xSK3Nxjuk3GGkga1qWcCUL/s=;
        b=JnGRaUGf3h9PnJvj9whZD4f73bceBwzAN0b0BV7mLe4f3zrZY7mb911HhA+tq+sS9KctSg
        OjyQdhH9GQYu46IDnRPsUaLxJ0EV65ZOsfxqvf2slRDGfLebFQZ4a0HQ+sizF7/zaNOHyt
        5EGv2T2wAmi0m/5Ik3U59+85r74kDrs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9eae9dd0 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 25 Apr 2022 15:20:29 +0000 (UTC)
Date:   Mon, 25 Apr 2022 17:20:25 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: odd endianness toolchains for crosstool
Message-ID: <Yma8OQ3zY3PzY87T@zx2c4.com>
References: <YmX7z+BirkA3VAfW@zx2c4.com>
 <CAK8P3a3Af5FBx-OnedHPrf28ikX4DZK1d0ERLsV+oKyBHyCXiw@mail.gmail.com>
 <YmaJUvg6hmekvkXE@zx2c4.com>
 <CAK8P3a3FZeXzBJKyTEvmvw_DaHGQFf5rQKs=_wBW=GZ2+=rJ_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a3FZeXzBJKyTEvmvw_DaHGQFf5rQKs=_wBW=GZ2+=rJ_Q@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Arnd,

On Mon, Apr 25, 2022 at 04:55:20PM +0200, Arnd Bergmann wrote:
> I suppose the only thing you are missing is libgcc (or libcompiler-rt)
> for those platforms. I had a closer look into what is or can be included
> here, and I see that my builds include multiple versions on some of
> the  architectures, but not on others:
> 
> aarch64-linux/lib/gcc/aarch64-linux/11.1.0/libgcc.a
> alpha-linux/lib/gcc/alpha-linux/11.1.0/libgcc.a
> arc-linux/lib/gcc/arc-linux/11.1.0/libgcc.a
> arc-linux/lib/gcc/arc-linux/11.1.0/hs/libgcc.a
> arc-linux/lib/gcc/arc-linux/11.1.0/archs/libgcc.a
> arc-linux/lib/gcc/arc-linux/11.1.0/hs38/libgcc.a
> arc-linux/lib/gcc/arc-linux/11.1.0/hs38_linux/libgcc.a
> arc-linux/lib/gcc/arc-linux/11.1.0/arc700/libgcc.a
> arc-linux/lib/gcc/arc-linux/11.1.0/nps400/libgcc.a
> arm-linux-gnueabi/lib/gcc/arm-linux-gnueabi/11.1.0/libgcc.a
> ...
> powerpc-linux/lib/gcc/powerpc-linux/11.1.0/libgcc.a
> powerpc-linux/lib/gcc/powerpc-linux/11.1.0/64/libgcc.a
> powerpc-linux/lib/gcc/powerpc-linux/11.1.0/64/le/libgcc.a
> powerpc-linux/lib/gcc/powerpc-linux/11.1.0/le/libgcc.a
> powerpc-linux/lib/gcc/powerpc-linux/11.1.0/32/le/libgcc.a
> powerpc64-linux/lib/gcc/powerpc64-linux/11.1.0/libgcc.a
> powerpc64-linux/lib/gcc/powerpc64-linux/11.1.0/32/libgcc.a
> powerpc64-linux/lib/gcc/powerpc64-linux/11.1.0/32/le/libgcc.a
> powerpc64-linux/lib/gcc/powerpc64-linux/11.1.0/le/libgcc.a
> powerpc64-linux/lib/gcc/powerpc64-linux/11.1.0/64/le/libgcc.a
> mips-linux/lib/gcc/mips-linux/11.1.0/libgcc.a
> mips-linux/lib/gcc/mips-linux/11.1.0/n32/libgcc.a
> mips-linux/lib/gcc/mips-linux/11.1.0/64/libgcc.a
> mips64-linux/lib/gcc/mips64-linux/11.1.0/libgcc.a
> mips64-linux/lib/gcc/mips64-linux/11.1.0/32/libgcc.a
> mips64-linux/lib/gcc/mips64-linux/11.1.0/64/libgcc.a
> 
> So on powerpc, there are already both big-endian and
> little-endian binaries, but arm and mips only have one of the
> two. I asked our local compiler experts, and they suggested
> that one can add further multiarch-configs like the one
> in gcc/config/arm/t-aprofile to allow building for a different
> subset of the hundreds of possible configurations.
> 
> the t-aprofile builds libgcc for a couple of combinations of
> cpu architecture level and FPU ABIs, but they are all the
> same endianess. gcc/config/rs6000/t-linux64lebe is the
> corresponding file for powerpc that enables all combinations
> of 32/64 and be/le.

Right, exactly. So if you simply add little endian libgcc to ppc64, ppc,
mips, and mips64, and add big endian libgcc to arm and arm64, then we'd
be set. (And also, build ppc32 with --enable-secureplt
--with-long-double-64.)

Jason
