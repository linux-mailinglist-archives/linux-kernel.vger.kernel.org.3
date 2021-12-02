Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3928465BEA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 02:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347751AbhLBCCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 21:02:09 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:57344 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242154AbhLBCCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 21:02:08 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1msbMb-000173-1U; Thu, 02 Dec 2021 12:58:22 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 02 Dec 2021 12:58:20 +1100
Date:   Thu, 2 Dec 2021 12:58:20 +1100
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
Message-ID: <20211202015820.GB8138@gondor.apana.org.au>
References: <20180802215118.17752-1-keescook@chromium.org>
 <20180802215118.17752-2-keescook@chromium.org>
 <20180807094513.vstt5dhbb7n6kvds@gondor.apana.org.au>
 <CAGXu5j+dPqpJZbO_AuGsNqJzq7XGcB2deXA5RELWv1-Ywi5QOA@mail.gmail.com>
 <20180808025319.32d57wtjpyyapwo5@gondor.apana.org.au>
 <202112011529.699092F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202112011529.699092F@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 03:39:06PM -0800, Kees Cook wrote:
>
> Okay, I'm looking at this again because of the need in the module loader
> to know "worst case decompression size"[1]. I am at a loss for how (or
> why) the acomp interface is the "primary interface".

This is similar to how we transitioned from the old hash interface
to shash/ahash.

Basically the legacy interface is synchronous only and cannot support
hardware devices without having the CPU spinning while waiting for the
result to come back.

If you only care about synchronous support and don't need to access
these hardware devices then you should use the new scomp interface
that's equivalent to the old compress interface but built in a way
to allow acomp users to easily access sync algorithms, but if you
are processing large amounts of data and wish to access offload devices
then you should consider using the async acomp interface.

> For modules, all that would be wanted is this, where the buffer size can
> be allocated on demand:
> 
> u8 *decompressed = NULL;
> size_t decompressed_size = 0;
> 
> decompressed = decompress(decompressed, compressed, compressed_size, &decompressed_size);
> 
> For pstore, the compressed_size is fixed and the decompression buffer
> must be preallocated (for catching panic dumps), so the worst-case size
> needs to be known in advance:
> 
> u8 *decompressed = NULL;
> size_t decompressed_worst_size = 0;
> size_t decompressed_size = 0;
> 
> worst_case(&decompressed_worst_size, compressed_size);
> 
> decompressed = kmalloc(decompressed_worst_size, GFP_KERNEL);
> ...
> decompressed_size = decompressed_worst_size;
> decompress(decompressed, compressed, compressed_size, &decompressed_size);
> 
> 
> I don't see anything like this in the kernel for handling a simple
> buffer-to-buffer decompression besides crypto_comp_decompress(). The
> acomp interface is wildly over-complex for this. What the right
> way to do this? (I can't find any documentation that discusses
> compress/decompress[2].)

I think you're asking about a different issue, which is that we
don't have an interface for on-the-go allocation of decompressed
results so every user has to allocate the maximum worst-case buffer.

This is definitely an area that should be addressed but a lot of work
needs to be done to get there.  Essentially we'd need to convert
the underlying algorithms to a model where they decompress into a
list of pages and then they could simply allocate a new page if they
need extra space.

The result can then be returned to the original caller as an SG list.

Would you be willing to work on something like this? This would benefit
all existing users too.  For example, IPsec would no longer need to
allocate those 64K buffers for IPcomp.

Unfortunately not many people care deeply about compression so
volunteers are hard to find.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
