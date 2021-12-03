Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4FD466FC2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 03:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240566AbhLCCcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 21:32:12 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:57374 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234029AbhLCCcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 21:32:11 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1msyJB-0008Pj-HO; Fri, 03 Dec 2021 13:28:22 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 03 Dec 2021 13:28:21 +1100
Date:   Fri, 3 Dec 2021 13:28:21 +1100
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
Message-ID: <20211203022821.GA16082@gondor.apana.org.au>
References: <20180802215118.17752-1-keescook@chromium.org>
 <20180802215118.17752-2-keescook@chromium.org>
 <20180807094513.vstt5dhbb7n6kvds@gondor.apana.org.au>
 <CAGXu5j+dPqpJZbO_AuGsNqJzq7XGcB2deXA5RELWv1-Ywi5QOA@mail.gmail.com>
 <20180808025319.32d57wtjpyyapwo5@gondor.apana.org.au>
 <202112011529.699092F@keescook>
 <20211202015820.GB8138@gondor.apana.org.au>
 <202112011947.7FA0A587C@keescook>
 <20211202035727.GC8138@gondor.apana.org.au>
 <202112012304.973C04859C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202112012304.973C04859C@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 12:10:13AM -0800, Kees Cook wrote:
>
> I'd rather just have a simple API that hid all the async (or sync) details
> and would work with whatever was the "best" implementation. Neither pstore
> nor the module loader has anything else to do while decompression happens.

Well that's exactly what the acomp interface is supposed to be.
It supports any algorithm, whether sync or async.  However, for
obvious reasons this interface has to be async.

> > Typically this would only make sense if you process a very small
> > amount of data, but this seems counter-intuitive with compression
> > (it does make sense with hashing where we often hash just 16 bytes).
> 
> pstore works on usually a handful of small buffers. (One of the largest
> I've seen is used by Chrome OS: 6 128K buffers.) Speed is not important
> (done at most 6 times at boot, and 1 time on panic), and, in fact,
> offload is probably a bad idea just to keep the machinery needed to
> store a panic log as small as possible.

In that case creating an scomp user interface is probably the best
course of action.

> Why can't crypto_comp_*() be refactored to wrap crypto_acomp_*() (and
> crypto_scomp_*())? I can see so many other places that would benefit from
> this. Here are just some of the places that appear to be hand-rolling
> compression/decompression routines that might benefit from this kind of
> code re-use and compression alg agnosticism:

We cannot provide async hardware through a sync-only interface
because that may lead to dead-lock.  For your use-cases you should
avoid using any async implementations.

The scomp interface is meant to be pretty much identical to the
legacy comp interface except that it supports integration with
acomp.

Because nobody has had a need for scomp we have not added an
interface for it so it only exists as part of the low-level API.
You're most welcome to expose it if you don't need the async
support part of acomp.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
