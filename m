Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35707465D34
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 04:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345134AbhLBEBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 23:01:19 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:57346 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345082AbhLBEBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 23:01:17 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1msdDr-0002ql-U7; Thu, 02 Dec 2021 14:57:29 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 02 Dec 2021 14:57:27 +1100
Date:   Thu, 2 Dec 2021 14:57:27 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     Geliang Tang <geliangtang@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Haren Myneni <haren@us.ibm.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/9] crypto: add zbufsize() interface
Message-ID: <20211202035727.GC8138@gondor.apana.org.au>
References: <20180802215118.17752-1-keescook@chromium.org>
 <20180802215118.17752-2-keescook@chromium.org>
 <20180807094513.vstt5dhbb7n6kvds@gondor.apana.org.au>
 <CAGXu5j+dPqpJZbO_AuGsNqJzq7XGcB2deXA5RELWv1-Ywi5QOA@mail.gmail.com>
 <20180808025319.32d57wtjpyyapwo5@gondor.apana.org.au>
 <202112011529.699092F@keescook>
 <20211202015820.GB8138@gondor.apana.org.au>
 <202112011947.7FA0A587C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202112011947.7FA0A587C@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 07:51:25PM -0800, Kees Cook wrote:
>
> But the scomp API appears to be "internal only":
> 
> include/crypto/internal/scompress.h:static inline int crypto_scomp_decompress(struct crypto_scomp *tfm,
> 
> What's the correct API calling sequence to do a simple decompress?

OK we haven't wired up scomp to users because there was no user
to start with.  So if you like you can create it just as we did
for shash.

The question becomes do you want to restrict your use-case to
synchronous-only algorithms, i.e., you will never be able to access
offload devices that support compression?

Typically this would only make sense if you process a very small
amount of data, but this seems counter-intuitive with compression
(it does make sense with hashing where we often hash just 16 bytes).

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
