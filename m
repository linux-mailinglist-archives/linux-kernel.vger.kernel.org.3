Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04E048BABC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 23:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346322AbiAKWZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 17:25:13 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49318 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiAKWZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 17:25:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71643B81D54;
        Tue, 11 Jan 2022 22:25:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19949C36AF7;
        Tue, 11 Jan 2022 22:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641939910;
        bh=bdl9ZWUE2YFPQAPy5Zln5X8OLbawG1tjQrF/OlhfxS0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qgaKKZDIT7rGpPuCD86aQkMKqBHupAztHDc1vFnPJYtSaTKzjua7iCvhHguQTKOx5
         RdgSRc8v9lJY+kDklooFT5zGtZvpz+hoLirxshyS+HfpcjOkxpXrZnDsbkXpZeXRDf
         N1OM6G9eiR0Oi+352bnmjo3TeCsLIhRYKL5Ywyq4KFixcbd+HeGH+7naUbi8qIPZs5
         YSLT+8gsIOb/y76PxNiJdXaZ7STaBkYu2Wc6OLv0evWX8U/pvfR+/PEwURW2Zxu7lj
         IvPmgZfUj6LWxuEXiNjC33lfre/qMen2F3oUf/Gu7rAV+gREQ3QCDflNp5hKq6+vsq
         pKOaFUEHYgwtQ==
Received: by mail-wm1-f42.google.com with SMTP id e5so334563wmq.1;
        Tue, 11 Jan 2022 14:25:09 -0800 (PST)
X-Gm-Message-State: AOAM533hZY+mBcoGNA3Ntc5oQQGrhBhNgRcU8uJ3cs4Erkc9JWBg5vc2
        //qOcdieNJAIeHfVBbeK9ePDfP1cOyL/q9EPDuM=
X-Google-Smtp-Source: ABdhPJy5gKoxJDNSKdsiVY5adN7z3x/9LXm/afgsLqkRSFvPL04IIWdIe0cwHy0e81EVKSCMpUSI9WNdIVmrqn6rsLI=
X-Received: by 2002:a05:600c:3ac5:: with SMTP id d5mr4242329wms.32.1641939908284;
 Tue, 11 Jan 2022 14:25:08 -0800 (PST)
MIME-Version: 1.0
References: <20220111195309.634965-1-jforbes@fedoraproject.org> <CAHmME9pi1Y7urg1VQeCi7L6MxHRUk5g4wc6VKDywo4yPh9h_6w@mail.gmail.com>
In-Reply-To: <CAHmME9pi1Y7urg1VQeCi7L6MxHRUk5g4wc6VKDywo4yPh9h_6w@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 11 Jan 2022 23:24:57 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH24ubv7yAqmbnzqe22cGh1L0-N8J6fiCT2NgU2HmeBJw@mail.gmail.com>
Message-ID: <CAMj1kXH24ubv7yAqmbnzqe22cGh1L0-N8J6fiCT2NgU2HmeBJw@mail.gmail.com>
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

On Tue, 11 Jan 2022 at 23:12, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Justin,
>
> These are library variables, which means they really have no sense in
> being user selectable. Internal things to the kernel depend on them,
> or they don't. They're always only dependencies.
>

But what does any of this have to do with blake2s? These are unrelated
changes that are not even described in the commit log of the original
patch, so let's just revert them now. If changes are needed here, we
can discuss them on the linux-crypto mailing list after the merge
window.


> It sounds like CONFIG_BIG_KEYS might be declaring its dependencies
> wrong, and that's actually where the bug is? CC'ing David Howells just
> in case. Maybe things should be changed to:
>
> diff --git a/security/keys/Kconfig b/security/keys/Kconfig
> index 64b81abd087e..2f1624c9eed9 100644
> --- a/security/keys/Kconfig
> +++ b/security/keys/Kconfig
> @@ -60,7 +60,7 @@ config BIG_KEYS
>   bool "Large payload keys"
>   depends on KEYS
>   depends on TMPFS
> - depends on CRYPTO_LIB_CHACHA20POLY1305 = y
> + select CRYPTO_LIB_CHACHA20POLY1305
>   help
>     This option provides support for holding large keys within the kernel
>     (for example Kerberos ticket caches).  The data may be stored out to
>
>
> Jason
