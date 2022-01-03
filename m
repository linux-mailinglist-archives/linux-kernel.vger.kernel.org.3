Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1B7482DB8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 05:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbiACEHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 23:07:05 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:58844 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229515AbiACEHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 23:07:04 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1n4EcZ-0006hc-Ll; Mon, 03 Jan 2022 15:06:56 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Mon, 03 Jan 2022 15:06:55 +1100
Date:   Mon, 3 Jan 2022 15:06:55 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v6] lib/crypto: blake2s: include as built-in
Message-ID: <YdJ2X+aEOTmRCq1w@gondor.apana.org.au>
References: <20220101155937.381821-1-Jason@zx2c4.com>
 <20220102204203.521148-1-Jason@zx2c4.com>
 <YdJsNrsXqPf0CNEc@gondor.apana.org.au>
 <CAHmME9p+-TMR4mywPH2wasY52fyBVGPpYmBwmn9aF0MF+14W8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9p+-TMR4mywPH2wasY52fyBVGPpYmBwmn9aF0MF+14W8Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2022 at 04:45:10AM +0100, Jason A. Donenfeld wrote:
> 
> Ugh, can we please not? That will really make things much harder and
> more annoying for me. I have an early pull planned, and you'll quickly
> be able to rebase on top of it. It also doesn't appear to conflict
> with anything you have queued up. Please, I would really appreciate
> some straight forward linearity here, and I don't think my taking it
> will negatively impact the flow.

Your patches as they stand will break the crypto tree.  So
that's why they should not go in without the proper changes.

> That snippet is inside an 'if CRYPTO' block, so it can't be selected
> without CRYPTO being enabled.

No CONFIG_CRYPTO is not the issue.  This depends on specific
bits of the Crypto API such as CRYPTO_HASH.  Simply selecting
it is also not acceptable because you will be forcing all of the
Crypto API into vmlinux even though none of it is required by
/dev/random.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
