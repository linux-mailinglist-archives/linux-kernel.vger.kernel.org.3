Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1626485B33
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 23:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244676AbiAEWBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 17:01:21 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34034 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244642AbiAEWBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 17:01:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69124B81E1E;
        Wed,  5 Jan 2022 22:01:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19CDDC36AE9;
        Wed,  5 Jan 2022 22:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641420077;
        bh=fGwTRDuVF+fKROM7EVE56WWnOBQmtM9MvKOiwSb97EU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kKMNYrQoE/kJKn7YgT4SuEu2Ihru/LMcoIqTYdl5SYtDpDKjvWz3iLeBiAIM4tUZu
         GSROL5U0sEuC5Qg9DMR1Ic8Acps1SvmLR7fEceTxE2S/0OEFBcD8xo4V34ScATZltY
         LqFZSTn9hnt3w3j89LPYIJU1G4RnIS1e2yoz2jMU08rK0P/QQcD9rlZ6YaTCW1TpYF
         9jRjr0KlDTPRwG6FLZXWC78Vu1Dc/nhdo7nSet9IVaDbJEhtmfZ0Bz2FZyapk9LK3H
         dTWUdhNgRjsPl/HCa9HHS/B0aZSLbOatwee5dnLCgyrfZHoRpp8l0xe4q0mLfXetRG
         /VgJlJ4C0QbDA==
Received: by mail-wm1-f42.google.com with SMTP id l4so576101wmq.3;
        Wed, 05 Jan 2022 14:01:17 -0800 (PST)
X-Gm-Message-State: AOAM530u/AZtvoKnqaIRbjvrw/mvSzIxdn+NXLxzrLAgUC8iYycgRoV3
        oPD7Qz0M3sNJQgzHf58KdnvSU8njC3U+TWxkKTw=
X-Google-Smtp-Source: ABdhPJxzvAuf64nd+pKFSeKKJjOM9uB1guqN3HkcOSX+PZ+qq8aWvjetqRzveAEsdlJiXdsoDnRlWaMb/udbrs97tAw=
X-Received: by 2002:a05:600c:1991:: with SMTP id t17mr4568252wmq.25.1641420075501;
 Wed, 05 Jan 2022 14:01:15 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9oPcEjRnqDesPNKJNOsT+i9vmWRxy9c62t+Xu9Nohsi2A@mail.gmail.com>
 <20220103123152.1043972-1-Jason@zx2c4.com> <YdOhMPwL9sXllm8X@gondor.apana.org.au>
 <CAMj1kXFhygHnB12g9MD0wMo_deZ6xd7FMEzbrvEvKVtqYdskAQ@mail.gmail.com> <YdYTUCR2GM/6CXmF@gmail.com>
In-Reply-To: <YdYTUCR2GM/6CXmF@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 5 Jan 2022 23:01:04 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHS8Gr9wbbbzvX+7u7qk0bAhgTpQw-bEB5Y_gmrcJ8iGw@mail.gmail.com>
Message-ID: <CAMj1kXHS8Gr9wbbbzvX+7u7qk0bAhgTpQw-bEB5Y_gmrcJ8iGw@mail.gmail.com>
Subject: Re: [PATCH v7] lib/crypto: blake2s: include as built-in
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jan 2022 at 22:53, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Tue, Jan 04, 2022 at 06:02:52PM +0100, Ard Biesheuvel wrote:
> > The only downside here is that the ARM/x86 accelerated shashes and the
> > generic shash now use the same core transform, right?
>
> I don't see how this is the case, given that crypto/blake2s_generic.c still uses
> blake2s_compress_generic(), not blake2s_compress().
>

Ah ok, I stand corrected then.

So what are your thoughts on this? Should we keep the shashes while
they have no users?
