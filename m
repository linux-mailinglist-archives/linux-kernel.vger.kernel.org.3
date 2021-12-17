Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD414783E6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 05:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhLQEOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 23:14:17 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:58054 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229874AbhLQEOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 23:14:16 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1my4d9-0006M3-Vp; Fri, 17 Dec 2021 15:14:05 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 17 Dec 2021 15:14:03 +1100
Date:   Fri, 17 Dec 2021 15:14:03 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Stephan Mueller <smueller@chronox.de>
Cc:     Yujie Liu <yujie.liu@intel.com>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com,
        "Sang, Oliver" <oliver.sang@intel.com>
Subject: Re: [security] d3b04a4398:
 WARNING:at_crypto/kdf_sp800108.c:#crypto_kdf108_init
Message-ID: <20211217041403.GA19847@gondor.apana.org.au>
References: <20211130080419.GC29514@xsang-OptiPlex-9020>
 <3438006.aCxCBeP46V@positron.chronox.de>
 <766e5415-cc94-1b46-2326-d55343a80388@intel.com>
 <3737408.Lz6Wf2Li4r@tauon.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3737408.Lz6Wf2Li4r@tauon.chronox.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 03:16:34PM +0100, Stephan Mueller wrote:
>
> Herbert, what is your preference in handling this:
> 
> - we could SELECT CRYPTO_SHA256 when the KDF is compiled. This would only be 
> necessary to satisfy the self test. Yet, there is no guarantee that SHA-256 
> would truly be needed because the DH code that calls the KDF obtains the 
> reference to the hash from user space. In the end we could hard compile a 
> crypto algorithm into the kernel that may never be used.

...

> I would prefer to consider the first option to also statically compile 
> SHA-256.

I think KDF800108_CTR should select SHA256 instead of HASH.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
