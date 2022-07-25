Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D99257FBA9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbiGYItN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234128AbiGYItJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:49:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC808140FC
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:49:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C9CC6120F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 08:49:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F243CC341C6;
        Mon, 25 Jul 2022 08:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658738946;
        bh=cjzjB+1URjAUpyLs5sc2ikwKmPZiasuZVYvT5zw61Hw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JKinLoPNtLc24WbMkn/724aPsznGQcQ4+C+NOoZtL/3/WoNVzz54rVZwWiJ9atutS
         RqzU84h7UYz2nm490uqblKS1KWfSw9nih2y9Mrx3bkSYQOSH8y3DZL/WzxO62IY3lX
         ad4zqAowEguXfdZ2MgZ4nGNE97nBjaoGx0rVOTXA=
Date:   Mon, 25 Jul 2022 10:49:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        kernel test robot <lkp@intel.com>,
        "Justin M. Forbes" <jforbes@fedoraproject.org>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Jason A. Donenfeld" <zx2c4@kernel.org>
Subject: Re: [linux-stable-rc:linux-5.15.y 6874/8723]
 arch/arm/lib/xor-neon.c:30:2: warning: This code requires at least version
 4.6 of GCC
Message-ID: <Yt5Y/cIKIDlyFWMQ@kroah.com>
References: <202207250449.BYMZbIA2-lkp@intel.com>
 <Yt3KObFVIUI2mFGt@zx2c4.com>
 <CAMj1kXHTf4f+onREnWhYk-vYXkPaQtPpZz+SqFCP+Ey7+bOXkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMj1kXHTf4f+onREnWhYk-vYXkPaQtPpZz+SqFCP+Ey7+bOXkQ@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 07:42:07AM +0200, Ard Biesheuvel wrote:
> On Mon, 25 Jul 2022 at 00:40, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > Hi Ard,
> >
> > On Mon, Jul 25, 2022 at 04:14:48AM +0800, kernel test robot wrote:
> > > All warnings (new ones prefixed by >>):
> > >
> > > >> arch/arm/lib/xor-neon.c:30:2: warning: This code requires at least version 4.6 of GCC [-W#warnings]
> > >    #warning This code requires at least version 4.6 of GCC
> > >     ^
> > >    1 warning generated.
> > >
> > >
> > > vim +30 arch/arm/lib/xor-neon.c
> > >
> > > 01956597cbc46d Ard Biesheuvel 2013-05-17  16
> > > 01956597cbc46d Ard Biesheuvel 2013-05-17  17  /*
> > > 01956597cbc46d Ard Biesheuvel 2013-05-17  18   * Pull in the reference implementations while instructing GCC (through
> > > 01956597cbc46d Ard Biesheuvel 2013-05-17  19   * -ftree-vectorize) to attempt to exploit implicit parallelism and emit
> > > 01956597cbc46d Ard Biesheuvel 2013-05-17  20   * NEON instructions.
> > > 01956597cbc46d Ard Biesheuvel 2013-05-17  21   */
> > > 01956597cbc46d Ard Biesheuvel 2013-05-17  22  #if __GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 6)
> > > 01956597cbc46d Ard Biesheuvel 2013-05-17  23  #pragma GCC optimize "tree-vectorize"
> > > 01956597cbc46d Ard Biesheuvel 2013-05-17  24  #else
> > > 01956597cbc46d Ard Biesheuvel 2013-05-17  25  /*
> > > 01956597cbc46d Ard Biesheuvel 2013-05-17  26   * While older versions of GCC do not generate incorrect code, they fail to
> > > 01956597cbc46d Ard Biesheuvel 2013-05-17  27   * recognize the parallel nature of these functions, and emit plain ARM code,
> > > 01956597cbc46d Ard Biesheuvel 2013-05-17  28   * which is known to be slower than the optimized ARM code in asm-arm/xor.h.
> > > 01956597cbc46d Ard Biesheuvel 2013-05-17  29   */
> > > 01956597cbc46d Ard Biesheuvel 2013-05-17 @30  #warning This code requires at least version 4.6 of GCC
> > > 01956597cbc46d Ard Biesheuvel 2013-05-17  31  #endif
> > > 01956597cbc46d Ard Biesheuvel 2013-05-17  32
> >
> > Does this file need a depends on ≥4.6 thing in Kconfig? Or is something
> > else happening here since 4.6 isn't even supported by the kernel these
> > days?
> >
> 
> Hi Jason,
> 
> This is explained/fixed in
> 
> commit a69cb445f7d129abf7c50d48c8a8eca7c8d5df15
> Author: Ard Biesheuvel <ardb@kernel.org>
> Date:   Sat Feb 5 16:23:46 2022 +0100
> 
>     crypto: arm/xor - make vectorized C code Clang-friendly
> 
>     The ARM version of the accelerated XOR routines are simply the 8-way C
>     routines passed through the auto-vectorizer with SIMD codegen enabled.
>     This used to require GCC version 4.6 at least, but given that 5.1 is now
>     the baseline, this check is no longer necessary, and actually
>     misidentifies Clang as GCC < 4.6 as Clang defines the GCC major/minor as
>     well, but makes no attempt at doing this in a way that conveys feature
>     parity with a certain version of GCC (which would not be a great idea in
>     the first place).
> 
> which landed in v5.18. Note that the patch depends on its parent,
> which touches many different architectures, so it may not be
> backportable cleanly.

I would love to backport this as it bugs me to no end on some various
gerrit systems all the time.  I'll look into it later this week unless
someone beats me to it :)

thanks,

greg k-h
