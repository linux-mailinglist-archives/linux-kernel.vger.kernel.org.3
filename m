Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC34949D5C3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 23:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbiAZWyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 17:54:31 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:53302 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbiAZWya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 17:54:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A263761A0C;
        Wed, 26 Jan 2022 22:54:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1EC5C340E3;
        Wed, 26 Jan 2022 22:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643237669;
        bh=55iCsDTeS4TYYqiGASJPJulq2w6UsXoqvp8QlgU+8lU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bQ4pdCQIUH35jlLiU8KlpqtJbUegpHgOPu4nVq4HLkdBpcZ+ZcsX6eUFpZN0YuGEM
         iWLP41LksYa/t/u7pZDbX4pWxd1IIyzGfBclRlG5h+lRbDdwNyCQ7xfRNf1eeX+7lj
         xn8InPfOiEBMXiJpLowr4QBoGDovWzMDQahuS5Yq1diqHw4Eufvp541Lg0Xk9r9R1F
         evQ2/FTYxqw/iAgKxfaWmBq/YtZPortMAfnFIhMkgrMMawVqvpSKYUZDMyEa4l5V1Z
         zzahVIQzk6/g3g2gC9NBVvzhXNXYcpYqssVcfmJa0I3Yw7x8beFxSH4643qPI7dxzf
         K2zcrTZTeJViQ==
Date:   Wed, 26 Jan 2022 14:54:27 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Miles Chen <miles.chen@mediatek.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2] lib/crypto: blake2s: avoid indirect calls to
 compression function for Clang CFI
Message-ID: <YfHRIw9aFwCYaXh7@sol.localdomain>
References: <20220119135450.564115-1-Jason@zx2c4.com>
 <20220124192849.14755-1-Jason@zx2c4.com>
 <Ye+bam3aSIjz8n9E@sol.localdomain>
 <CAHmME9oQuKLo2D_OGMy-8PS-u=a-ERvP+1L7RvpjJ2_xBaM5eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9oQuKLo2D_OGMy-8PS-u=a-ERvP+1L7RvpjJ2_xBaM5eQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 01:23:34PM +0100, Jason A. Donenfeld wrote:
> On 1/25/22, Eric Biggers <ebiggers@kernel.org> wrote:
> > On Mon, Jan 24, 2022 at 08:28:49PM +0100, Jason A. Donenfeld wrote:
> >> blake2s_compress_generic is weakly aliased by blake2s_generic. The
> >
> > Don't you mean "weakly aliased by blake2s_compress"?
> 
> Grrrr. Thanks.
> 
> >> Changes v1->v2:
> >> - Wrapped columns at 80 for Eric.
> >
> > It is the recommended coding style, so not just for me :-)
> 
> I was under the impression this increased to 100 mid-2020 or so, and
> checkpatch.pl now makes noise at that width instead.

From Documentation/process/coding-style.rst:

"The preferred limit on the length of a single line is 80 columns.

 Statements longer than 80 columns should be broken into sensible chunks,
 unless exceeding 80 columns significantly increases readability and does
 not hide information."

It's not as strict as it used to be, but checkpatch seems to be overly-lenient.
I always run it with --max-line-length=80.

- Eric
