Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C554C46E7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235566AbiBYNvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbiBYNvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:51:11 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DD21DA440;
        Fri, 25 Feb 2022 05:50:39 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id b5so4669148wrr.2;
        Fri, 25 Feb 2022 05:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ATbGzyh3Nal8Wuh5ClbaaT6PS0PYPkn30M5mIo7tHlA=;
        b=eHwfx0elT0X2NkL9uZ0Nx5YpdEwcwV3MvfmoZzOcHPMysBfwnN9bQ8totyEwfdnOTH
         h3fdfuDwaEZti3nCN2aRrp22fgLYK8J+hzaRxRZ0n73i1aK8TFAJ9BOTyItMO7nx4Nxs
         IEIZxvAIsAewPVjM8h1Efr+nGXBHdFTJXfJJmw3c4xHg8rwYJiCIiBcJS+8b9aB1qgG0
         QmkS/hHGv7NbNksohZm0DYUVbxCIc3B07nxkd+I2MrX5K6l+OQtowoSFzMKqCIOs3anL
         JIQgt3NgeiaY86OR/QQvsJ8/3oG33Q/wNH67cTjEdaw57uoK9GKvf6ejsDrMwx/Woxed
         /rIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ATbGzyh3Nal8Wuh5ClbaaT6PS0PYPkn30M5mIo7tHlA=;
        b=bcJ6fHMzU8gIKUJmLNn8gq+xUqyDZBkVagj5skYb5HHsCStKDX3pmPSvIbRvFoguxB
         sf24tZycoIt4OA4WLRXoerSxlIXqES6d/ObaQoYkcAmblwiDPpf2pwOrzwmcag/TUlDV
         NQNBAlDBsmNPSpL8lY9W+DnfsARy/WzHQozqy4ELNmjLcBTFbDxEetWjvZpTABGD2m2Q
         jRr5dRkh1CHwVxxe/+bm79CVw6dP9Ol1Eoevq9MOdpebEQGhw0RZQxoFs7yAJlbbe8rJ
         74vC1Nmth7i9pKCz1dpduVPb6lU2kzF4ZmrEUOTJjq8F9rBfnKC4mRKxjZ8BlNJYDEr0
         3aOA==
X-Gm-Message-State: AOAM531k+Trt3YsSsU42bKz5B2syTXoNkX7CpCrvTdwLJo0osj5s3Gmk
        byyB/gTTzfftwwe3IRAvR/a/olHOGrc=
X-Google-Smtp-Source: ABdhPJw5fB4ALqWPdoEsUzsC/EipwrABWUhkidfssIRytK5jfvKZotEhlxoW1j6QMSoUcsjLGy2QbQ==
X-Received: by 2002:adf:f049:0:b0:1ee:7523:ed53 with SMTP id t9-20020adff049000000b001ee7523ed53mr5195669wro.586.1645797038349;
        Fri, 25 Feb 2022 05:50:38 -0800 (PST)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b0037bd5fabd10sm2896563wmq.48.2022.02.25.05.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 05:50:37 -0800 (PST)
Date:   Fri, 25 Feb 2022 14:50:35 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     airlied@linux.ie, daniel@ffwll.ch, linux-tegra@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/2] gpu: host1x: Fix an error handling path in
 'host1x_probe()'
Message-ID: <Yhjeq0yIjq0knq8I@orome>
References: <05c1932b66048ebf6742705e2ab16eea852c46d9.1636319710.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vyHKb89PagxoToVb"
Content-Disposition: inline
In-Reply-To: <05c1932b66048ebf6742705e2ab16eea852c46d9.1636319710.git.christophe.jaillet@wanadoo.fr>
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


--vyHKb89PagxoToVb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 07, 2021 at 10:16:25PM +0100, Christophe JAILLET wrote:
> Add the missing 'host1x_bo_cache_destroy()' call in the error handling
> path of the probe, as already done in the remove function.
>=20
> In order to simplify the error handling, move the 'host1x_bo_cache_init()'
> call after all the devm_ function.
>=20
> Fixes: e3166698a8a0 ("drm/tegra: Implement buffer object cache")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Untested.
> I hope that moving host1x_bo_cache_init() is just fine.
> ---
>  drivers/gpu/host1x/dev.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry

--vyHKb89PagxoToVb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmIY3qsACgkQ3SOs138+
s6FT3Q/9F6ouUGIx+ao9mlUapqMP8vnTVr9d0cxp5t28yWE8LlqPzzPSxyxomgUn
mowdGHqZHQily8pApgMRGONs4pdgmIiyGcvlcBgcY5Iby/PXHjupQL/bvkv732/w
pg3hzpTXauvOnTvfhhphqVkg2NSONrSW9i/TVx4Qik5vG3c4K35khMpFzy58xvsh
8ejhPJpwo800XNlFZelmOLgurB0wk3TBTPDLLgkBveQGAjOFmjuJObE9TqnLXcJd
h1Fd42Upp6OD3Fnpht7EoDKeXlQAJCT76yYCfIl50oFv1+UVp6CURk7v9vg8beDz
dEIFSswA6qUOYE1/l9GvY/I8uaqPO8N+1kYeUxQ52sNQrwU0dDRbsgw/xSihZ+uC
wrIrkOOiM+FExKzPzyxAunJP5ywayyjXFdbJ87XuCY3C1/EJMoqDs4ln/j23m33j
Sz+3qWMCbuABwjePdUloBcbVaeaJFAuE9tIeVaA5EMPmw0v/DnNOBRzJTr8N9dQX
zooNMwZqCXIdYisT+5AovG8pGTSnN/WQ5tRdME6qlPTDhjnlsmJbtjcgX4vb//BL
0y3lKvbmAw+qGmSVC7VRYteW4TQrmo8g4CKYQqhFAnWk0YtME+MBGX08ri7gY1Ck
okeFaTvJk6CAG1orZTRdokMiRgnW+sAzg/3TF9YUdLoi0/9WXLw=
=WtCw
-----END PGP SIGNATURE-----

--vyHKb89PagxoToVb--
