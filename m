Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF700585ACA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 16:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbiG3Odk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 10:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiG3Odi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 10:33:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3BA15FFE
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 07:33:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65AF4B800C1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 14:33:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4000C433D6;
        Sat, 30 Jul 2022 14:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659191611;
        bh=qP+ZmXCmCszG5bZ9pMTRnwel5mdgn0rwYD/fDV9DBII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yjEJhsfugBLmSGV1zi/iolAlgSXjiPuhiUBfdAs1EPMyjJ3C0gOY+7UIGTMBRR82+
         0YY8FHl4PP1hC9Pfw4ODO+wCR4qV7IhBbhCeTQnE0pRjkvf/W7cd6prFP50XFm+0FT
         c/xvkIYoa5qYaL/DrVfl5vX0oYWp3p35ae4yEwCU=
Date:   Sat, 30 Jul 2022 16:33:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        kernel test robot <lkp@intel.com>,
        "Justin M. Forbes" <jforbes@fedoraproject.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Jason A. Donenfeld" <zx2c4@kernel.org>
Subject: Re: [linux-stable-rc:linux-5.15.y 6874/8723]
 arch/arm/lib/xor-neon.c:30:2: warning: This code requires at least version
 4.6 of GCC
Message-ID: <YuVBOOrdoBDUhRxJ@kroah.com>
References: <202207250449.BYMZbIA2-lkp@intel.com>
 <Yt3KObFVIUI2mFGt@zx2c4.com>
 <CAMj1kXHTf4f+onREnWhYk-vYXkPaQtPpZz+SqFCP+Ey7+bOXkQ@mail.gmail.com>
 <Yt5Y/cIKIDlyFWMQ@kroah.com>
 <CAMj1kXGPjFAY0y-SPZv64CRhpo9s1+__z4bya86aMcTs9=f8pw@mail.gmail.com>
 <CAK8P3a0g4NT1oDW5gq7YO540Eo0UDoqbK1tmtb8QHteiDNXj5Q@mail.gmail.com>
 <CAK8P3a2ZfEr+4OWWteZHpDYGw8U0dQgMfF_OFwQDEtY=GaTfQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2ZfEr+4OWWteZHpDYGw8U0dQgMfF_OFwQDEtY=GaTfQA@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 04:35:38PM +0200, Arnd Bergmann wrote:
> On Mon, Jul 25, 2022 at 2:55 PM Arnd Bergmann <arnd@kernel.org> wrote:
> 
> > The other easy workaround would be to just turn off the xor-neon code
> > when building with clang, e.g. using this Makefile hack:
> >
> > diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> > index 6d2ba454f25b..8e4fe6421dd2 100644
> > --- a/arch/arm/lib/Makefile
> > +++ b/arch/arm/lib/Makefile
> > @@ -43,8 +43,10 @@ endif
> >  $(obj)/csumpartialcopy.o:      $(obj)/csumpartialcopygeneric.S
> >  $(obj)/csumpartialcopyuser.o:  $(obj)/csumpartialcopygeneric.S
> >
> > +ifdef CONFIG_CC_IS_CLANG
> >  ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
> >    NEON_FLAGS                   := -march=armv7-a -mfloat-abi=softfp -mfpu=neon
> >    CFLAGS_xor-neon.o            += $(NEON_FLAGS)
> >    obj-$(CONFIG_XOR_BLOCKS)     += xor-neon.o
> >  endif
> > +endif
> 
> Nevermind, this does not actually work. Just turning off the warning
> is probably best then, as actually disabling this code would still
> be invasive not do much beyond saving a little bit of kernel .text size.

Ok, if it triggers again, and I get annoyed, I'll write a patch,
otherwise I'll just leave it alone unless someone else wants to send it
to me...

thanks,

greg k-h
