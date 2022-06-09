Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CAD545629
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 23:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245598AbiFIVIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 17:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbiFIVIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 17:08:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC78110193B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 14:08:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 846D861F02
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 21:08:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1716C34114;
        Thu,  9 Jun 2022 21:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1654808887;
        bh=gw5w9Zi/b4hhpFd7zPux8o9Mo31iCPCxXXFvUUpBU4Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WbDDAmQzlN02eF46/pFOQtoYvpK/66Qv9jRt9nVfBpreIv2z1xcrrqCVBele48gHK
         22FvR/niUs5sgsZOkvZYDbXVNDjXJQ+Y0lfUt6THnNl3ZuVPaS0SgGo9brgDddexIR
         itfpvg66DQRBtMKufkasXrIJqVMiphb9U6nazL7Y=
Date:   Thu, 9 Jun 2022 14:08:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        nathan@kernel.org, jstitt007@gmail.com
Subject: Re: +
 include-uapi-linux-swabh-move-explicit-cast-outside-ternary.patch added to
 mm-nonmm-unstable branch
Message-Id: <20220609140806.f741aa8c01426d46beb8f762@linux-foundation.org>
In-Reply-To: <CAKwvOdkV12Wg_dHp-_YDG8eZ3v9y1ssh+hXv9aNNv9rR9=3Gdw@mail.gmail.com>
References: <20220609172933.D8187C34114@smtp.kernel.org>
        <YqJbMzUnzF2WEmU5@localhost.localdomain>
        <CAKwvOdkV12Wg_dHp-_YDG8eZ3v9y1ssh+hXv9aNNv9rR9=3Gdw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jun 2022 14:01:17 -0700 Nick Desaulniers <ndesaulniers@google.com> wrote:

> On Thu, Jun 9, 2022 at 1:42 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > On Thu, Jun 09, 2022 at 10:29:33AM -0700, Andrew Morton wrote:
> > > A cast inside __builtin_constant_p doesn't do anything since it should
> > > evaluate as constant at compile time irrespective of this cast.  Instead,
> > > I moved this cast outside the ternary to ensure the return type is as
> > > expected.
> >
> > > --- a/include/uapi/linux/swab.h~include-uapi-linux-swabh-move-explicit-cast-outside-ternary
> > > +++ a/include/uapi/linux/swab.h
> > > @@ -102,7 +102,7 @@ static inline __attribute_const__ __u32
> > >  #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
> > >  #else
> > >  #define __swab16(x)                          \
> > > -     (__builtin_constant_p((__u16)(x)) ?     \
> > > +     (__u16)(__builtin_constant_p(x) ?       \
> >
> > This cast is necessary.
> >
> > >       ___constant_swab16(x) :                 \
> > >       __fswab16(x))
> > >  #endif
> > > @@ -115,7 +115,7 @@ static inline __attribute_const__ __u32
> > >  #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
> > >  #else
> > >  #define __swab32(x)                          \
> > > -     (__builtin_constant_p((__u32)(x)) ?     \
> > > +     (__u32)(__builtin_constant_p(x) ?       \
> > >       ___constant_swab32(x) :                 \
> > >       __fswab32(x))
> > >  #endif
> > > @@ -128,7 +128,7 @@ static inline __attribute_const__ __u32
> > >  #define __swab64(x) (__u64)__builtin_bswap64((__u64)(x))
> > >  #else
> > >  #define __swab64(x)                          \
> > > -     (__builtin_constant_p((__u64)(x)) ?     \
> > > +     (__u64)(__builtin_constant_p(x) ?       \
> > >       ___constant_swab64(x) :                 \
> > >       __fswab64(x))
> >
> > These two aren't? typeof(c ? u32 : u32) is u32.
> 
> Correct.
> 
> Neither are the casts on the return values of the calls to
> __builtin_bswap* in the cases where __HAVE_BUILTIN_BSWAP*__ are
> defined. If you want to send a patch on top of Justin's/on top of
> mm-nonmm-unstable, I'll ack it.  Or Andrew, you can drop v3 and Justin
> can send a v4 with Alexey's suggestions?

I figured we'd leave it as-is for simple symmetry.

If we're going to have one implementation different from the others
then it would be good to have a code comment explaining why.

