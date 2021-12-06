Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198A246A628
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 20:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348996AbhLFT7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 14:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347815AbhLFT67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 14:58:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FBFC0613F8;
        Mon,  6 Dec 2021 11:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gIbS5FSar7i12DL1+IR2L/XBznRwEatqcC55spZYsY4=; b=ffnY2ArLJpjKnZ/NSlwIltn10n
        ytryU03hef2WwP1gz4IaV93YkzAeymGtTxZqRfjF2+9CkvPq0LWJ90Dy8Yfsqp06o+XMZ/EBSlKI3
        gW9F5VBqVXBF9YteU/ECWwHNJzjvgkqJyXT4slqA0SNyX5QZb1vX0eFG23JqOsQpMl+oZzYLSAKIV
        fpJl+i39LIjSuimJ4174GjqsNsuS54z8jRgrRhu0o/G70TiGyQKne/1ik+3Ji/3PiqDqxoxV8Ta6E
        De5kEsFvtv+rKY+Nfb9v7Mp7uQx+/SgLN6MV1ilNFjqvz+Y1dwGCl5GMw52koab4G5BEn4A3taTDl
        r/YHQMEw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muK58-005zH6-J2; Mon, 06 Dec 2021 19:55:26 +0000
Date:   Mon, 6 Dec 2021 19:55:26 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Gary Guo <gary@garyguo.net>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: Re: [PATCH 11/19] vsprintf: add new `%pA` format specifier
Message-ID: <Ya5qrjabKMM6sPr+@casper.infradead.org>
References: <20211206140313.5653-1-ojeda@kernel.org>
 <20211206140313.5653-12-ojeda@kernel.org>
 <Ya4mAqoOa8zIeZGZ@kroah.com>
 <CANiq72kCmLgrv++mFygR6dt0xOhfv04o9j6jYLQ1N+zLNvqohQ@mail.gmail.com>
 <Ya40Bcv+eFkqc9jv@kroah.com>
 <CAKwvOdkLF_DPP1FF60720q3zxZG2qaSNTthxJPxLb4Bj=AFE=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkLF_DPP1FF60720q3zxZG2qaSNTthxJPxLb4Bj=AFE=Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 11:52:09AM -0800, Nick Desaulniers wrote:
> On Mon, Dec 6, 2021 at 8:14 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Dec 06, 2021 at 04:56:32PM +0100, Miguel Ojeda wrote:
> > > On Mon, Dec 6, 2021 at 4:46 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > That should be in a .h file somewhere.  Remember, don't put #ifdef in .c
> > > > files please.
> 
> Why not put #ifdef in .c files?
> 
> > > Will do, thanks for reviewing!
> > >
> > > > Same here, this should not be needed if you put it in a .h file
> > > > correctly.
> 
> I guess IS_ENABLED could be used in the .c code, but I don't see how
> they could move the dispatch to rust_fmt_argument to a header without
> moving the definition of pointer() to a header, which they probably
> _cant_ do because it's noinline_for_stack.

In the header file, you put:

#ifdef CONFIG_FOO
int foo(void);
#else
static inline int foo(void) { }
#endif

and then in your .c file, you call foo() unconditionally, and everything
works beautifully.

