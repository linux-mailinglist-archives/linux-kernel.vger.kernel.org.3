Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E9648C59B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 15:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243380AbiALOHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 09:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242320AbiALOGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:06:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AC8C06173F;
        Wed, 12 Jan 2022 06:06:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2F13B81ED1;
        Wed, 12 Jan 2022 14:06:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7BEC36AEC;
        Wed, 12 Jan 2022 14:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641996411;
        bh=XeWqqmHv7DaVDwvPm45183RGLYC5+G8jXC9gcgvklT0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BmAMgoEyRHOMBJTdG81NR7h0+4zORv3xaXLPHSiMgWs06Yvemej245HrP16P2yi4A
         HLEPclYkljVwx7IPGCLkE55OmonO0IixKxNqK9w+5hED+CQTx59OA21+2/4H7/4kBN
         ZU5c5QRDuiq+S1+EQCYXiCm7jhi4fn61IP1XZ0Z2ZwBiDwnhE4PKSwOe+BplHXKcMq
         w2oi2iUJ8y5P/JSwRhJVH5qNCfuJMjzKGWjuA80JZ6YD157Q6t7DVKPfPg9KZV65BJ
         Yk5lsDhVw0itcq1t80uTK5XH2u4MY29UshSUBlt5jBCIbWJkeg/opxWijNnP2EKhbe
         APYgRz8AGyYTQ==
Received: by mail-wr1-f43.google.com with SMTP id o3so4419638wrh.10;
        Wed, 12 Jan 2022 06:06:51 -0800 (PST)
X-Gm-Message-State: AOAM5305HJw2289rNTx53FgyV44HhtCVUarkeNw7Z9PrvUEpn6MY+LGF
        Adoh9W/tTTWgr0vnAX4rq6UtCPYcKmcHIxtWFa0=
X-Google-Smtp-Source: ABdhPJzMg/dYqM+qFxN69BHU93/XPfoqB+ISoSFHB3s9PJqmRrnr2z4t/8deOXPBIuvvHkZdMLh837Tk+4TyZkCNtcU=
X-Received: by 2002:a5d:4087:: with SMTP id o7mr8248312wrp.189.1641996409856;
 Wed, 12 Jan 2022 06:06:49 -0800 (PST)
MIME-Version: 1.0
References: <20220112140137.728162-1-jforbes@fedoraproject.org> <CAHmME9rJFVeWL=SFTkM8=+2te_GnH4n-THH+F3p5mnHfCkhZ4w@mail.gmail.com>
In-Reply-To: <CAHmME9rJFVeWL=SFTkM8=+2te_GnH4n-THH+F3p5mnHfCkhZ4w@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 12 Jan 2022 15:06:38 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHubNk3gRTOmD1rOCifCUE4O6=TvNr_XhP1tNcCBuzfBQ@mail.gmail.com>
Message-ID: <CAMj1kXHubNk3gRTOmD1rOCifCUE4O6=TvNr_XhP1tNcCBuzfBQ@mail.gmail.com>
Subject: Re: [PATCH v2] lib/crypto: add prompts back to crypto libraries
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "Justin M. Forbes" <jforbes@fedoraproject.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Justin Forbes <jmforbes@linuxtx.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2022 at 15:05, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> This commit also needs this snippet:
>

Why?

> diff --git a/crypto/Kconfig b/crypto/Kconfig
> index 94bfa32cc6a1..442765219c37 100644
> --- a/crypto/Kconfig
> +++ b/crypto/Kconfig
> @@ -1928,5 +1928,3 @@ source "crypto/asymmetric_keys/Kconfig"
>  source "certs/Kconfig"
>
>  endif # if CRYPTO
> -
> -source "lib/crypto/Kconfig"
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 655b0e43f260..c20b68ad2bc3 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -122,6 +122,8 @@ config INDIRECT_IOMEM_FALLBACK
>     mmio accesses when the IO memory address is not a registered
>     emulated region.
>
> +source "lib/crypto/Kconfig"
> +
>  config CRC_CCITT
>   tristate "CRC-CCITT functions"
>   help
