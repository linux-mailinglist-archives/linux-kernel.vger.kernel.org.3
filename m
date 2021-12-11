Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7674347120E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 06:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhLKF4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 00:56:14 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:57712 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229711AbhLKF4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 00:56:13 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1mvvMH-0004yB-FI; Sat, 11 Dec 2021 16:55:46 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 11 Dec 2021 16:55:45 +1100
Date:   Sat, 11 Dec 2021 16:55:45 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Nicolas Toromanoff <nicolas.toromanoff@foss.st.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Marek Vasut <marex@denx.de>, Ard Biesheuvel <ardb@kernel.org>,
        linux-crypto@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/9] STM32 CRYP driver: many fixes
Message-ID: <20211211055545.GB6841@gondor.apana.org.au>
References: <20211130075501.21958-1-nicolas.toromanoff@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130075501.21958-1-nicolas.toromanoff@foss.st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 08:54:52AM +0100, Nicolas Toromanoff wrote:
> Hello,
> 
> This set of patches update the STM32 CRYP driver.
> 
> First two update about EPROBE_DEFER management.
> Then many fixes to success the cryptomanager EXTRA_TESTS.
> And finally we reorder the initialization to set the key as last step.
> 
> This patch series applies to cryptodev/master.
> 
> v1 -> v2 :
>   - use crypto_inc() in "crypto: stm32/cryp - fix CTR counter carry".
>   - more explicit commit description.
>   - with CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y all tests pass, at boot
>     if built into kernel, at insmod if in module. (as v1)
> 
> v2->v3:
>   - fix smatch warning (that was a bug) in "crypto: stm32/cryp - fix bugs
>     and crash in tests" add missing parenthesis in mask/shift operation in
>     stm32_cryp_write_ccm_first_header(), was only visible in case of aad
>     buffer bigger than 65280 bytes.
>   - add a new commit to fix lrw chaining mode
> 
> v3->v4
>   - Fix sparse warning
>   - Rebase on cryptodev-2.6/master
>   - rework 0004-patch: with v1 correction, the xts extra tests using
>     stm32-cryp were still broken.
> 
> Etienne Carriere (2):
>   crypto: stm32/cryp - defer probe for reset controller
>   crypto: stm32/cryp - don't print error on probe deferral
> 
> Nicolas Toromanoff (7):
>   crypto: stm32/cryp - fix CTR counter carry
>   crypto: stm32/cryp - fix xts and race condition in crypto_engine
>     requests
>   crypto: stm32/cryp - check early input data
>   crypto: stm32/cryp - fix double pm exit
>   crypto: stm32/cryp - fix lrw chaining mode
>   crypto: stm32/cryp - fix bugs and crash in tests
>   crypto: stm32/cryp - reorder hw initialization
> 
>  drivers/crypto/stm32/stm32-cryp.c | 987 ++++++++++++------------------
>  1 file changed, 404 insertions(+), 583 deletions(-)
> 
> 
> base-commit: 330507fbc9d8c3bc4525ea2ae9c3774738bc0c80
> -- 
> 2.17.1

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
