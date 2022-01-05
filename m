Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6863485B66
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 23:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244756AbiAEWLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 17:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244897AbiAEWKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 17:10:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9832C028C37;
        Wed,  5 Jan 2022 14:09:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73402B81E03;
        Wed,  5 Jan 2022 22:09:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08390C36AEB;
        Wed,  5 Jan 2022 22:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641420562;
        bh=S+XtvRE89tjU5l89WgMe94h1a9C/AdLNuAKpkHw23jk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a93lWP1be3Xk6AQlYnJLNR6YxCTouuSPyp2fRr8I0LnHejmReYKmDXcW2ZsPAEGbh
         mUn5gfrIi0eLWj63nRzykBWw/2+IessCkznJzLWXJ+Keotm2w6SJQqxktfGNGVcDU2
         BEsDRpg703DrY56pPIxVDvPujTI4cdW4xjzQRXERk7W+FIcOe0C2bPsXKEr7JQpxsR
         E9ou6kTQamG7m/ktgvYRYC8lFPSatGodlOoDrsjxTx3Sv2xykoLDVkdvRL6ZuNfrBp
         gBQBP2a+ZQj3VAEju00SqKu+b9i2fKHdvr0pzIZGxH72hmbXjcNQRY1mYQH1WElUTY
         BKsk0J3Dn1HkA==
Date:   Wed, 5 Jan 2022 14:09:20 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH v7] lib/crypto: blake2s: include as built-in
Message-ID: <YdYXEBhc7vuY+GQW@gmail.com>
References: <CAHmME9oPcEjRnqDesPNKJNOsT+i9vmWRxy9c62t+Xu9Nohsi2A@mail.gmail.com>
 <20220103123152.1043972-1-Jason@zx2c4.com>
 <YdOhMPwL9sXllm8X@gondor.apana.org.au>
 <CAMj1kXFhygHnB12g9MD0wMo_deZ6xd7FMEzbrvEvKVtqYdskAQ@mail.gmail.com>
 <YdYTUCR2GM/6CXmF@gmail.com>
 <CAMj1kXHS8Gr9wbbbzvX+7u7qk0bAhgTpQw-bEB5Y_gmrcJ8iGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHS8Gr9wbbbzvX+7u7qk0bAhgTpQw-bEB5Y_gmrcJ8iGw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 11:01:04PM +0100, Ard Biesheuvel wrote:
> On Wed, 5 Jan 2022 at 22:53, Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > On Tue, Jan 04, 2022 at 06:02:52PM +0100, Ard Biesheuvel wrote:
> > > The only downside here is that the ARM/x86 accelerated shashes and the
> > > generic shash now use the same core transform, right?
> >
> > I don't see how this is the case, given that crypto/blake2s_generic.c still uses
> > blake2s_compress_generic(), not blake2s_compress().
> >
> 
> Ah ok, I stand corrected then.
> 
> So what are your thoughts on this? Should we keep the shashes while
> they have no users?

I don't know.  Removing unused stuff is good per se, but I wouldn't have
expected this to be something that is being considered here.  It's not like this
is a "controversial" algorithm, blake2b is already supported, and there could be
users of it already (dm-integrity, dm-verity, AF_ALG, etc.).  If this is going
to happen, then the acceptance criteria for new algorithms need to get *much*
stricter, so that algorithms aren't constantly being added and removed.

- Eric
