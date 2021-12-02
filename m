Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C002C465F28
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 09:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356051AbhLBINx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 03:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241302AbhLBINh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 03:13:37 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8FAC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 00:10:15 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id p13so19523017pfw.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 00:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vzt0vc1FGLcHyQtAyTO4rOSF0GuAETX/HuyJW5j/lao=;
        b=XWkB08lWmrH2SQ4esLxVUu3v5FVno5qn5ViFCwXLRAf1VyWqBQ/89rAInKjCntXgKI
         MpBDE6CUSAjXCIgaNslrNGEdTbpsM8cODFkrtPHNXZk00MMItZVvyGoBpNrVW0vIJmBP
         mEEImeCN6fTnhkWqDiUn9VRy5XFEUOHvKBwLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vzt0vc1FGLcHyQtAyTO4rOSF0GuAETX/HuyJW5j/lao=;
        b=V/J/t7JsaPr5FSv+08Yj9gwHFpKTmmb+4Ig/TnWH7laO7UwG8O0CD13rUSxzCZMDHR
         db+QfojhDCiMYsLlaDxdA7X5EjvfW/jhEUUeZnYs5MqruqUPqqbteBtNPJGtu70Azk0n
         FS/1ylOK+Qm/RhWBWZs4MptNuAFjgHs3aDN9tdZlWCdQezFlEIXVvRFyk/pYC6aFg0t/
         KZ6cVdUsrU9amtEdwN1xZ02nWmH2oYK+Eype32WF3Ov1AbfNdIgrQQRKu5fnzXL0XQX6
         fCAcg6HSED4Mfj/7WgHiJ+8CP/3C18JiW6RM/gUAW4zLBHoDLzBrjez2ww/XZb8YAaj6
         55Pw==
X-Gm-Message-State: AOAM532G0bSmrTN3G/munLvLsimQbfTtrW1+SShJHwUSUmvH2EDxN1QD
        9uYiD4vZl39NE6KZcbANa2DVJQ==
X-Google-Smtp-Source: ABdhPJw/sPQlWtsiDdrnHCkQ1KJTOhiMndJZ9z0mo6cajV0qfgkhQZKfdE8UEwXwti2XKg6yid9org==
X-Received: by 2002:a65:4d47:: with SMTP id j7mr467748pgt.472.1638432614306;
        Thu, 02 Dec 2021 00:10:14 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d17sm2157030pfo.40.2021.12.02.00.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 00:10:13 -0800 (PST)
Date:   Thu, 2 Dec 2021 00:10:13 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
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
Message-ID: <202112012304.973C04859C@keescook>
References: <20180802215118.17752-1-keescook@chromium.org>
 <20180802215118.17752-2-keescook@chromium.org>
 <20180807094513.vstt5dhbb7n6kvds@gondor.apana.org.au>
 <CAGXu5j+dPqpJZbO_AuGsNqJzq7XGcB2deXA5RELWv1-Ywi5QOA@mail.gmail.com>
 <20180808025319.32d57wtjpyyapwo5@gondor.apana.org.au>
 <202112011529.699092F@keescook>
 <20211202015820.GB8138@gondor.apana.org.au>
 <202112011947.7FA0A587C@keescook>
 <20211202035727.GC8138@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202035727.GC8138@gondor.apana.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 02:57:27PM +1100, Herbert Xu wrote:
> On Wed, Dec 01, 2021 at 07:51:25PM -0800, Kees Cook wrote:
> >
> > But the scomp API appears to be "internal only":
> > 
> > include/crypto/internal/scompress.h:static inline int crypto_scomp_decompress(struct crypto_scomp *tfm,
> > 
> > What's the correct API calling sequence to do a simple decompress?
> 
> OK we haven't wired up scomp to users because there was no user
> to start with.  So if you like you can create it just as we did
> for shash.
> 
> The question becomes do you want to restrict your use-case to
> synchronous-only algorithms, i.e., you will never be able to access
> offload devices that support compression?

I'd rather just have a simple API that hid all the async (or sync) details
and would work with whatever was the "best" implementation. Neither pstore
nor the module loader has anything else to do while decompression happens.

> Typically this would only make sense if you process a very small
> amount of data, but this seems counter-intuitive with compression
> (it does make sense with hashing where we often hash just 16 bytes).

pstore works on usually a handful of small buffers. (One of the largest
I've seen is used by Chrome OS: 6 128K buffers.) Speed is not important
(done at most 6 times at boot, and 1 time on panic), and, in fact,
offload is probably a bad idea just to keep the machinery needed to
store a panic log as small as possible.

The module loader is also doing non-fast-path decompression of modules,
with each of those being maybe a couple megabytes. This isn't fast-path
either: if it's not the kernel, it'd be userspace doing the decompression,
and it only happens once per module, usually at boot.

Why can't crypto_comp_*() be refactored to wrap crypto_acomp_*() (and
crypto_scomp_*())? I can see so many other places that would benefit from
this. Here are just some of the places that appear to be hand-rolling
compression/decompression routines that might benefit from this kind of
code re-use and compression alg agnosticism:

fs/pstore/platform.c
drivers/gpu/drm/i915/i915_gpu_error.c
kernel/power/swap.c
arch/powerpc/kernel/nvram_64.c
security/apparmor/policy_unpack.c
drivers/base/regmap/regcache-lzo.c
fs/btrfs/lzo.c
fs/btrfs/zlib.c
fs/f2fs/compress.c
fs/jffs2/compr_lzo.c
drivers/net/ethernet/chelsio/cxgb4/cudbg_zlib.h
drivers/net/ppp/ppp_deflate.c
fs/jffs2/compr_lzo.c
fs/jffs2/compr_zlib.c

But right now there isn't a good way to just do a simple one-off:

	dst = decompress_named(alg_name, dst, dst_len, src, src_len);

or if it happens more than once:

	alg = compressor(alg_name);
	set_comp_alg_param(param, value);
        ...
        for (...) {
		...
		dst = compress(alg, dst, dst_len, src, src_len);
		...
	}
        ...
        free_compressor(alg);

-Kees

-- 
Kees Cook
