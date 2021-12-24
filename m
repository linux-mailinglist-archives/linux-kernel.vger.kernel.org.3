Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5737647EF38
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 14:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352661AbhLXNfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 08:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234576AbhLXNfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 08:35:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97489C061401;
        Fri, 24 Dec 2021 05:35:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 628A46206B;
        Fri, 24 Dec 2021 13:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F333CC36AE5;
        Fri, 24 Dec 2021 13:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640352930;
        bh=C0Ei2STE2Eswy4QsYT97mZyVXgT9au/IrEwQygw0g4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a+0mBKZhgOVLSuIvKb4xawquloUPrnJnIL1kyUMPmVeEV38pg0hFMGy7DsuRkduZA
         Ug9fjSc3CrXmZK6ow7w96yxKDwJyAPLk/K/gp3i7OkQTIBhWuY4FYGnenc5pJeooXb
         xZmHEbjClzkw9jdtvzD1SUwUhtIjr6F9/KIm30Nk=
Date:   Fri, 24 Dec 2021 14:35:16 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, tytso@mit.edu,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 1/2] lib/crypto: blake2s: include as built-in
Message-ID: <YcXMlPc0Fs55cdsB@kroah.com>
References: <20211223141113.1240679-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211223141113.1240679-1-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 03:11:12PM +0100, Jason A. Donenfeld wrote:
> In preparation for using blake2s in the RNG, we change the way that it
> is wired-in to the build system. Instead of kconfig mazes and ifdefs, we
> use weak symbols, so that an arch version can override the generic
> version. Then we include the generic version in lib-y, so that it can be
> removed from the image if the arch version doesn't fallback to it (as is
> the case on arm though not x86). The result should be a bit simpler and
> smaller than the code it replaces.
> 
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: linux-kbuild@vger.kernel.org
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: linux-crypto@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> Herbert - I intend to take this via the crng/random.git tree, since it
> forms a dependency and I'd like to send a pull early in 5.17 cycle.
> 
>  Makefile                          |  2 +-
>  arch/arm/crypto/Kconfig           |  3 +--
>  arch/arm/crypto/blake2s-core.S    |  8 ++++----
>  arch/arm/crypto/blake2s-glue.c    |  6 +++---
>  arch/s390/configs/debug_defconfig |  1 -
>  arch/s390/configs/defconfig       |  1 -
>  arch/x86/crypto/blake2s-glue.c    | 11 +++++------
>  crypto/Kconfig                    |  5 +----
>  drivers/net/Kconfig               |  1 -
>  include/crypto/internal/blake2s.h |  6 +++---
>  lib/Makefile                      |  2 +-
>  lib/crypto/Kconfig                | 25 -------------------------
>  lib/crypto/Makefile               |  7 +++----
>  lib/crypto/blake2s-generic.c      |  6 +++++-
>  lib/crypto/blake2s.c              |  6 ------
>  15 files changed, 27 insertions(+), 63 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
