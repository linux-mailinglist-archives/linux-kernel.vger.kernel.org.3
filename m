Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF40A4C3194
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiBXQiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiBXQis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:38:48 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4F61342E4;
        Thu, 24 Feb 2022 08:38:08 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id f11so3675650ljq.11;
        Thu, 24 Feb 2022 08:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HKzxqhI5E0hInxN0B+6sR1bWJjqg6HiuWwnAoTz4dj4=;
        b=DJuDDee+DDCURX0UIukj5cQPc9oTEG0zT+tpAYxK9ESNxmlrUYLCP4f3NKkP5cMl5D
         Fo+SnrpogamdLZTbsL9jR7/9/kvKh05PNsAZH/gScGru1RhZEsErUm8syZZHQE5Jr0/D
         nlj6IbxXpoDgrsbXsGPW5LQBYmGjWdym8/uSdecx34EZTfDzgVeI8qorvDqMYmt5miy0
         11EVy8ALh20uMAxGIn2spoie8Hqze5Uoq42AsL7tUOulFAIrGVO6Adnatt0kUIS3gwuU
         rTi3xeg4GxZ2AMFAK6IjmduZ6vbk4kqLlVawakv93NQqTsSGJyuO3b0wYU5Y2Nrfci/D
         tQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HKzxqhI5E0hInxN0B+6sR1bWJjqg6HiuWwnAoTz4dj4=;
        b=xBFjj2ds2/nqZKNdv4B0RG20nLh0FGmADtGnLti4OODdxZDh2uJoEaf3om/i7hyKOb
         8YneEeBsdhTxy0liLz0mzn+IyvtgHgnHybeUM8hXDW+fSZinfXJLkYblzTn3fWnA14rt
         exDSpR/3MUrkJDx9/3o7HzlO9DduukpEX8o98SYj+h1U/tShMJdRA4rj41VUI7CFa7qb
         fXOgZcUJe6XAQnT2aspatWS/rd6qHoGJonupet4z1WiwPykRpwn4gsl3hwdNqK17rl/L
         fQP9/IhErMEMVN7OOf9Q/lUrMtv6DnvIS6Tl9RQHfXx9Yvi9fDxe5XION5hsbew2tptF
         sFSQ==
X-Gm-Message-State: AOAM533n0dnF/WqwHxjA4Z/OE1HDUHt1xqN8Ij2MG89SLUpAgA738xru
        sXF0rBjtXMYiVVrXM+7vrxM=
X-Google-Smtp-Source: ABdhPJw9JaJ1kjvCUb4y4AB0oU89kshZAxRNFwS/j2Jfr3k5bqBT/d5vxMxfL/zEMZJOyzM9iJed+w==
X-Received: by 2002:a2e:a171:0:b0:244:c2fc:d1d with SMTP id u17-20020a2ea171000000b00244c2fc0d1dmr2369703ljl.159.1645720686690;
        Thu, 24 Feb 2022 08:38:06 -0800 (PST)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id t20sm245402lfk.159.2022.02.24.08.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:38:05 -0800 (PST)
Date:   Thu, 24 Feb 2022 17:38:03 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 2/5] tty: serial: make use of UART_LCR_WLEN() +
 tty_get_char_size()
Message-ID: <Yhe0a0RX8XTBF8BL@orome>
References: <20220224095517.30872-1-jslaby@suse.cz>
 <20220224095558.30929-1-jslaby@suse.cz>
 <20220224095558.30929-2-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bGyWIReJ9zdg8psW"
Content-Disposition: inline
In-Reply-To: <20220224095558.30929-2-jslaby@suse.cz>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bGyWIReJ9zdg8psW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 24, 2022 at 10:55:55AM +0100, Jiri Slaby wrote:
> Having a generic UART_LCR_WLEN() macro and the tty_get_char_size()
> helper, we can remove all those repeated switch-cases in drivers.
>=20
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Laxman Dewangan <ldewangan@nvidia.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: linux-tegra@vger.kernel.org
> ---
>  drivers/tty/serial/8250/8250_omap.c | 16 +---------------
>  drivers/tty/serial/8250/8250_port.c | 16 +---------------
>  drivers/tty/serial/jsm/jsm_cls.c    | 16 +---------------
>  drivers/tty/serial/jsm/jsm_neo.c    | 16 +---------------
>  drivers/tty/serial/omap-serial.c    | 16 +---------------
>  drivers/tty/serial/pxa.c            | 16 +---------------
>  drivers/tty/serial/serial-tegra.c   | 22 ++++------------------
>  drivers/tty/serial/vr41xx_siu.c     | 15 +--------------
>  8 files changed, 11 insertions(+), 122 deletions(-)

This would've been easier to review if I had this in my inbox, but I did
find it on lkml.org and this does look correct, so:

Reviewed-by: Thierry Reding <treding@nvidia.com>

--bGyWIReJ9zdg8psW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmIXtGsACgkQ3SOs138+
s6G8LA//a6T2l7OdGOi6gS4JTGpVy3oswh/dgzFUZyXLfgc/hZ4+XfafpeRT0tHj
F3NYARAAYfXtWh0WXj7scRQd1Kcax8wBO8ltzhUU+Qv/QWzmt3tDhrzD3LqxHoN1
qmI+AEBkfr81HRR/NWnbn1h11SwtEUzPrPaOhSkaGkTZqD2gk8D093cC7YVqB+er
5TvEM9BP9/BGtcLoA+1p/Ir+TIbxUd1fFdGVYsJ32rYBssAtBvn3wiC08oByrOrL
Qx0im6NLDjxffI7Ijxw4257lQy9wSGq7S8HxmPb+gTSn9IYwllo4zhC9A6ZzT643
CheDmqm++kfg5Ijrg8PQmuXzQ2m89Z0b0n3rQA6P/N59hqWg0obU8M8+wTbQfiXw
GPeWHW9iwe+yrcU0B+CjP8uVFCq/6m/JzalevUvP1G2tnIG3At7xL45YpU+YI07h
cdEYQuG5Yom0RCwSX8f4W7UB8KRL6UJclqUbAfUc2h6MReYMkhguxTi7O/Qc7Lkv
SuUJ6765xPhSmqouxo+b4Id0gvCg9AHElyD/q6K4sgEFdFy4NqonAJZJj00YsGVf
BoLZ834npx8Vd9DUgPrGzRzTSOBvPzUAIOli8pk5e2DyvO2fNgg6RJrWESn1U+Ly
vTaLIAsh31wu9T9/E67OBAaohALhLETkgjh5Wed9uBOAwpxFbhw=
=5bfD
-----END PGP SIGNATURE-----

--bGyWIReJ9zdg8psW--
