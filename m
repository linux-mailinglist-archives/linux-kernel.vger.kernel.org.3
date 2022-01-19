Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A1C4936DF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352855AbiASJKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:10:21 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40662 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352746AbiASJKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:10:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7BA9614F1;
        Wed, 19 Jan 2022 09:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC70C340E6;
        Wed, 19 Jan 2022 09:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642583414;
        bh=WDNHgCq1Sifyl65SzNP7dhJXzUA+KcGSqB1STBpal/o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ak4X7XB7uZSGxPLHzqT/QXn42qKgsLVbs8uG+kewTlvVrlDl92zFFe4y58KwWDLHT
         f44qHyq5PPPHZeeUaP9l6bFhkZ0KYdEgrfaItVstIwMLINaFygpYqzP2EhtEHEOEwu
         il87cFjjgMG738RjYKKmF8wFOk0h/rYUErjNFc6R71BKzZrrEJ0Ez6VusIKV+gGzA1
         h0ePyVKLFxET5XWPSQDkiyK36hYZ6nktY37PR3iBWeRUkwIkN5n9CzsaLCNPCesZ7q
         hHvpNi3va5mgodYDODW60+y0to9IqOGRGZaXgMNkTfAeJ/9pqwBJLXJf316Gd7U8Ss
         1uEUJ/JwmByBQ==
Received: by mail-wm1-f45.google.com with SMTP id l12-20020a7bc34c000000b003467c58cbdfso12791200wmj.2;
        Wed, 19 Jan 2022 01:10:14 -0800 (PST)
X-Gm-Message-State: AOAM530qmRy5d8UXCpFyn1Jc6XVWwz5wWS/bTTZtDOgZowGA8vhIwqBN
        9dIN+wbJzBurx1Tj9CxZilnak0DaKsaRxvY2LfI=
X-Google-Smtp-Source: ABdhPJwrsNn68dd2N/CGBv72C8COqRD7ZHZNGWiesAEQwpW2p4EomFBwRkEKZFhiJvyQFSzoSBrWBu8nXTs8AuHJmJo=
X-Received: by 2002:a5d:4087:: with SMTP id o7mr27561730wrp.189.1642583412437;
 Wed, 19 Jan 2022 01:10:12 -0800 (PST)
MIME-Version: 1.0
References: <20220119082447.1675-1-miles.chen@mediatek.com> <CAHmME9pv4WWATjdqZgwrtHDmq3sX4ABfB9PoNT9Z4tSEduR2Lw@mail.gmail.com>
In-Reply-To: <CAHmME9pv4WWATjdqZgwrtHDmq3sX4ABfB9PoNT9Z4tSEduR2Lw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 19 Jan 2022 10:09:59 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEuWRUbCqDBnxiWRaERt6OGL8ufQ1Q7naAGHqKK1oQB1w@mail.gmail.com>
Message-ID: <CAMj1kXEuWRUbCqDBnxiWRaERt6OGL8ufQ1Q7naAGHqKK1oQB1w@mail.gmail.com>
Subject: Re: [PATCH] lib/crypto: blake2s: fix a CFI failure
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     =?UTF-8?B?TWlsZXMgQ2hlbiAo6Zmz5rCR5qi6KQ==?= 
        <miles.chen@mediatek.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Eric Biggers <ebiggers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+ Sami, Eric)

On Wed, 19 Jan 2022 at 10:00, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Miles,
>
> Thanks for the patch. Could you let me know which architecture and
> compiler this was broken on? If I had to guess, I'd wager arm32, and
> you hit this by enabling optimized blake2s?
>
> If so, I'm not sure the problem is with weak symbols. Why should CFI
> break weak symbols? Rather, perhaps the issue is that the function is
> defined in blake2s-core.S? Are there some CFI macros we need for that
> definition?
>

We should try to understand why CFI thinks the prototypes of the two
symbols are different. There are still a number of issues with CFI, so
papering over them by reverting stuff that we want for good reasons is
not the way to go imo.

In the short term, you can work around it by avoiding the indirect
call to blake2s_compress, e.g.,

diff --git a/lib/crypto/blake2s.c b/lib/crypto/blake2s.c
index 93f2ae051370..fef2ff678431 100644
--- a/lib/crypto/blake2s.c
+++ b/lib/crypto/blake2s.c
@@ -16,9 +16,15 @@
 #include <linux/init.h>
 #include <linux/bug.h>

+static void __blake2s_compress(struct blake2s_state *state, const u8 *block,
+                              size_t nblocks, const u32 inc)
+{
+       return blake2s_compress(state, block, nblocks, inc);
+}
+
 void blake2s_update(struct blake2s_state *state, const u8 *in, size_t inlen)
 {
-       __blake2s_update(state, in, inlen, blake2s_compress);
+       __blake2s_update(state, in, inlen, __blake2s_compress);
 }
 EXPORT_SYMBOL(blake2s_update);
