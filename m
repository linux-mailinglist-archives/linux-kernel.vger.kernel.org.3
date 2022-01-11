Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA4448BADD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 23:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346535AbiAKWlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 17:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbiAKWlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 17:41:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2158DC06173F;
        Tue, 11 Jan 2022 14:41:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA4F86124B;
        Tue, 11 Jan 2022 22:41:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA78C36AF4;
        Tue, 11 Jan 2022 22:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641940907;
        bh=MqmI9+RM/P6B2WHvZ+xN5dZjbIVrdtTvU582BgfMOKo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KT0R3NNF0vM6j4qWUF8MuzUs6c6AZhPrWJie7IBc/kSLbcUlvwsS218ODWmYyS0vq
         pi1F0SQoRpjPbjJl7OwFOUHIpJ7SQUxeH5W8UJJ4fDDJ3N+DdmS3AYyZQ340eTBHSg
         1AAd+KCVfnTR9Fi48wrbEac1Q9JDwL5iy0eEx3mQGjy4kQVSREkdMqVfeRzzx+4SOy
         +oZSSE3L5d3ysWAg4OIFlnBGStsozZZQB3mvorwskg6rUgDf//6fkQBCfTkCQ3WcHM
         qt5lJTp3+fidsvy2LX6gKwWVznlS9owuyJCqfWIKovOQtFGeAGZZ7fq7vVhxV49t9Q
         P6ceuU1lUE1pQ==
Received: by mail-wr1-f41.google.com with SMTP id k30so871040wrd.9;
        Tue, 11 Jan 2022 14:41:46 -0800 (PST)
X-Gm-Message-State: AOAM531YhuiMsjWYqvSr8CA5jkDJ5GpLy50jIBqgKeSVPVfdiMnGAQjw
        mEfHQI6m+pamwXXAnWqol/YRsgJfFHtjaqWjlec=
X-Google-Smtp-Source: ABdhPJwkswYRI/CjfFSGUZbtKPyLoEmlN7PJuZM3THoUb4Htog5ZEwrCjNeoCPx1Y7bctRGHvHRyUgQ79qOX4c2QhT4=
X-Received: by 2002:a5d:4087:: with SMTP id o7mr5586734wrp.189.1641940905306;
 Tue, 11 Jan 2022 14:41:45 -0800 (PST)
MIME-Version: 1.0
References: <20220111195309.634965-1-jforbes@fedoraproject.org>
 <CAHmME9pi1Y7urg1VQeCi7L6MxHRUk5g4wc6VKDywo4yPh9h_6w@mail.gmail.com>
 <CAMj1kXH24ubv7yAqmbnzqe22cGh1L0-N8J6fiCT2NgU2HmeBJw@mail.gmail.com> <CAHmME9qXg3_HdnDwN-LOBJQhxz4acYCjgQhXRovQ6-9TWwHwWQ@mail.gmail.com>
In-Reply-To: <CAHmME9qXg3_HdnDwN-LOBJQhxz4acYCjgQhXRovQ6-9TWwHwWQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 11 Jan 2022 23:41:33 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFybcnneHwpvKYNnK0F3t48kqDpV-RKLgR1A+w4QbUxTg@mail.gmail.com>
Message-ID: <CAMj1kXFybcnneHwpvKYNnK0F3t48kqDpV-RKLgR1A+w4QbUxTg@mail.gmail.com>
Subject: Re: [PATCH] lib/crypto: add prompts back to crypto libraries
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "Justin M. Forbes" <jforbes@fedoraproject.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, jmforbes@linuxtx.org,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 at 23:27, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Tue, Jan 11, 2022 at 11:25 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Tue, 11 Jan 2022 at 23:12, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > >
> > > Hi Justin,
> > >
> > > These are library variables, which means they really have no sense in
> > > being user selectable. Internal things to the kernel depend on them,
> > > or they don't. They're always only dependencies.
> > >
> >
> > But what does any of this have to do with blake2s? These are unrelated
> > changes that are not even described in the commit log of the original
> > patch, so let's just revert them now. If changes are needed here, we
> > can discuss them on the linux-crypto mailing list after the merge
> > window.
>
> The lib crypto stuff moved outside of `if CRYPTO`, so if you add those
> titles back, the root menu is going to be filled with things. I'm
> working on some patches now moving lib/crypto/ things into lib
> strictly, so the dependency is one way. I can try adding back the
> labels there if you want.
>

Ah, right. In that case, can we fold in something like the below?

diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index a3e41b7a8054..179041b60294 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0

+menu "Crypto library routines"
+
 config CRYPTO_LIB_AES
        tristate

@@ -120,3 +122,5 @@ config CRYPTO_LIB_SHA256

 config CRYPTO_LIB_SM4
        tristate
+
+endmenu
