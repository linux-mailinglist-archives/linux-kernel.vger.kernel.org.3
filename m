Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E1D542277
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441823AbiFHB6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1835791AbiFGX5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:57:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61B5FC839
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 16:21:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E951B8246D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 23:21:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180CBC3411C;
        Tue,  7 Jun 2022 23:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1654644089;
        bh=ymIo+kLBAAc0OcbtfNyqfVnFABqcw4XNx0p6uN0nCIg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CBxSOnoO0TAC1DtNHY8cqYCZ7pnePew9ByeYmSBHi3RynjaUzxzf0OdKKjT1iV23y
         I4yjFKLKiC8t1e/9qdw1EPVb2CihwC42WgtTFgrVtDoj23B3/UISgAP7XsZejFRvmo
         xhoIlR5qXfUYDXrIaRv2tanEGqC+A+xlRumFJDt0=
Date:   Tue, 7 Jun 2022 16:21:28 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Justin Stitt <jstitt007@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Richard Smith <richardsmith@google.com>
Subject: Re: [PATCH] include/uapi/linux/swab.h: add __u16 cast to __swab16
 conditional
Message-Id: <20220607162128.b5d4aa70f4a8a7610ce29250@linux-foundation.org>
In-Reply-To: <CAKwvOdmXeRbFjkHgFXps4pLH6Q6pGWRNOqA85=h2aFnR=uaggg@mail.gmail.com>
References: <20220607222006.22719-1-jstitt007@gmail.com>
        <20220607152744.d7c801d092529309500ac9a6@linux-foundation.org>
        <CAKwvOdmXeRbFjkHgFXps4pLH6Q6pGWRNOqA85=h2aFnR=uaggg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jun 2022 15:42:56 -0700 Nick Desaulniers <ndesaulniers@google.com> wrote:

> On Tue, Jun 7, 2022 at 3:27 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Tue,  7 Jun 2022 15:20:06 -0700 Justin Stitt <jstitt007@gmail.com> wrote:
> >
> > > if __HAVE_BUILTIN_BSWAP16__ is defined then __swab16 utilizes a __u16 cast.
> > > This same cast should be used if __HAVE_BUILTIN_BSWAP16__ is not defined as
> > > well. This should fix loads (at least a few) clang -Wformat warnings
> > > specifically with `ntohs()`
> > >
> > > ...
> > >
> > > --- a/include/uapi/linux/swab.h
> > > +++ b/include/uapi/linux/swab.h
> > > @@ -102,7 +102,7 @@ static inline __attribute_const__ __u32 __fswahb32(__u32 val)
> > >  #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
> > >  #else
> > >  #define __swab16(x)                          \
> > > -     (__builtin_constant_p((__u16)(x)) ?     \
> > > +     (__u16)(__builtin_constant_p((__u16)(x)) ?      \
> > >       ___constant_swab16(x) :                 \
> > >       __fswab16(x))
> > >  #endif
> >
> > More explanation, please?  Both ___constant_swab16() and __fswab16()
> > return __u16, so why does this patch have any effect?
> >
> 
> See this example:
> https://godbolt.org/z/fzE73jn13
> And the ImplicitCastExpr nodes adding to the AST:
> https://godbolt.org/z/oYeYxYdKW
> 
> Both the second and third operand are promoted to int.
> 
> C11: https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1548.pdf
> 
> 6.5.15/5
> >> If both the second and third operands have arithmetic type, the result type that would be determined by the usual arithmetic conversions, were they applied to those two operands, is the type of the result.
> 6.3.1.8/1
> >> Otherwise, the integer promotions are performed on both operands.
> 6.3.1.1/2
> >> If an int can represent all values of the original type (as restricted by the width, for a bit-field), the value is converted to an int; otherwise, it is converted to an unsigned int. These are called the integer promotions.

Geeze.  Can we please turn this into English and add it to the changelog?

Is it saying that an expression

	int ? u16 : u16

has type int?  Or something else?  What did we do wrong here and is it
possible to correct our types rather than adding a cast?
