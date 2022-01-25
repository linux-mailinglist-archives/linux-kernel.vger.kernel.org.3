Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6443B49ADCB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 09:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351356AbiAYIBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 03:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357852AbiAYH7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 02:59:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF43FC0544EE;
        Mon, 24 Jan 2022 22:40:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB3F1B8162C;
        Tue, 25 Jan 2022 06:40:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A039C340E0;
        Tue, 25 Jan 2022 06:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643092844;
        bh=Lwx8mO5mMqVbKGdRGLJ5Wq0V96nxImmH2K5npNDXyPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aDYbJ54OdpYQH01sLWo6acgjo8qZxxsj5hf0BEz/3pM17AdmYDd79I60lzTIhUpBK
         tZ/Zd0fkpj1zZVVnwb8BY7KdPS6sn/d8iGvu3AGEeoa8s5JGpLsc/+8QoBTSn5sy4K
         87ue1vH1zG2J+UYhwUx8uABQlsy4hNN5IXf1XY2azdir6SF+kaA/SlosgGa2efuaF1
         dIS+zic5ikcm9DkMo/w3YJOlOas99uUHjhYpq45XLImKkrP2s48ipbUuHkqZ+T5XT0
         RNiRAINIfyy47CjENgEG8forPLg5AJ7Rng/PFlnhr63dgLAxKNdpQ53/wntdqWq2Oa
         QILBRw3Jb5mgA==
Date:   Mon, 24 Jan 2022 22:40:42 -0800
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
Message-ID: <Ye+bam3aSIjz8n9E@sol.localdomain>
References: <20220119135450.564115-1-Jason@zx2c4.com>
 <20220124192849.14755-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124192849.14755-1-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 08:28:49PM +0100, Jason A. Donenfeld wrote:
> blake2s_compress_generic is weakly aliased by blake2s_generic. The

Don't you mean "weakly aliased by blake2s_compress"?

> Fixes: 6048fdcc5f26 ("lib/crypto: blake2s: include as built-in")
> Reported-by: Miles Chen <miles.chen@mediatek.com>
> Tested-by: Miles Chen <miles.chen@mediatek.com>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1567
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---

Otherwise this looks fine, though it's unfortunate this is needed.  You can add:

	Reviewed-by: Eric Biggers <ebiggers@google.com>

> Changes v1->v2:
> - Wrapped columns at 80 for Eric.

It is the recommended coding style, so not just for me :-)

- Eric
