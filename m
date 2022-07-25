Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C8A57FE3A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 13:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234676AbiGYLUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 07:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiGYLUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 07:20:21 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485CD2AD7;
        Mon, 25 Jul 2022 04:20:20 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id b16so5075083lfb.7;
        Mon, 25 Jul 2022 04:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1nXWYVScGrrgl5QUSeVrq++Y1dz2v1W+VupFYq9G2nU=;
        b=l+gbL0eBM5wqoNTL6mU+nrtKXkIJ2wCFGRnv0j164oXGtbbjLxTdUex4a4H08B+Xxb
         pWszEQ8HLZHD6CygmWDRj3ZS9EAwE7DMvRFUCh/ZjT8CPDMZ5wLwh47lzBlUDG7MRJDZ
         UHTwX0+ReDGIDTrnfkvWE8ysZNmMN3N7Ci6wpAqqj1mp3f6QF4mUcpd9WzfCZQCk7Dg4
         nf/BKpk5AfpOPfLNvaUDuOejJO2NXlEHuRz+7VzAHiABwXy2JsX91ROkusG7mKWzH7SL
         qqa5A5jnA/DXLrZmuLftop7niajI1zbxKxykG4wxNk6AvgqlBbhO4E0hCBt0odwLKh3a
         3D3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1nXWYVScGrrgl5QUSeVrq++Y1dz2v1W+VupFYq9G2nU=;
        b=EB725B654ix+dyOaSVJC4G/tIH/IECLvzOuwozVU6+EiyN8O4CuXrxQiGMPLag9aXt
         LHI+ytWVvElMzFxPDwGuG4XQTo2xgnD+NZSRaaMrprRBtyfGTOwxWZ6eenXeIBqKeuwW
         MeZ3FBSOYEaFg9aeLhuflRh6NNrxWSdGinJLoMzJ9el8oPM4TPzW1Mi1TlG6qSsb7BQ+
         Lg8NIh7323790t/lVwxf6UzSZBht5LKn/nUNVavGtinpqlAMU6ISirAdhuRyZtt7YvBk
         +rAPwHUyjW+ub4yu8DY2b2JVclljB6Rmm8+cbantezJLOYvClcv4tc5vxZnHJNT9CSkI
         nyNw==
X-Gm-Message-State: AJIora/Zgyj9O39kx+3Al7K8ZHsVPlYl7xHQJiRmWKH1iNKvc4oW8Kaf
        53WukFYYa2CLu8IhEjLiXSxzmjZH9gvMOQ==
X-Google-Smtp-Source: AGRyM1v6nkCkmmz3xiWYb1U+IEgV4y7BsBHxkT+qPwT/VDX3hlxyeTxLPogLvIsyiimxmX8OVi4/2Q==
X-Received: by 2002:a05:6512:39d3:b0:48a:7ce3:512e with SMTP id k19-20020a05651239d300b0048a7ce3512emr4581238lfu.112.1658748018372;
        Mon, 25 Jul 2022 04:20:18 -0700 (PDT)
Received: from gmail.com (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id g24-20020a2eb5d8000000b0025e0e9d2f1asm135093ljn.29.2022.07.25.04.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 04:20:17 -0700 (PDT)
Date:   Mon, 25 Jul 2022 13:24:13 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] gpio: gpio-74x164: add support for CDx4HC4094
Message-ID: <Yt59XSTaJUvThJli@gmail.com>
References: <20220721093422.2173982-1-marcus.folkesson@gmail.com>
 <CAHp75VddBhc9peHXfNfTyTNni246kC8CyLqCrMFadn67LGDarQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TLJ8iEYt1e9qWIkZ"
Content-Disposition: inline
In-Reply-To: <CAHp75VddBhc9peHXfNfTyTNni246kC8CyLqCrMFadn67LGDarQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TLJ8iEYt1e9qWIkZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 25, 2022 at 11:32:16AM +0200, Andy Shevchenko wrote:
> On Thu, Jul 21, 2022 at 11:32 AM Marcus Folkesson
> <marcus.folkesson@gmail.com> wrote:
> >
> > 74hc4094 and 75hc4094 works similar to 74x164 but has an additional
> > storage latch associated with each stage for strobing data from the
> > serial input to parallell buffer tri-state output.
>=20
> parallel
>=20
> > Add support for an optional strobe pin.
>=20
> Sorry for my absence of understanding, but why?
> SPI has MOSI, CLK, CS, where the last one is exactly for that. No?

You're right, I didn't think of that CS could be used for this.
The additional compatible strings is then superfluous, so I will skip those.

>=20
>=20
> --=20
> With Best Regards,
> Andy Shevchenko

Best regards
Marcus Folkesson

--TLJ8iEYt1e9qWIkZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmLefVkACgkQiIBOb1ld
UjJImBAAq42Hldd+6vNfeKVKIBCQSyENS7qZdpjBM6KLFHnao8Blgtp/SwCNS1WY
0tXK2+FvZUYppLgswbg7Y9ZpdTWg71ch3Ej5d+Qv+mq4GcRkPGcdUgsQlc17h6nm
2Dgzj2jbNgvIDH1OtX1JPnyBXN7q32lZ5sryJCOFJO15HwkRZ7OCn0H8FtrHtlqe
v2X3TTCPErCmfru4wMnoovzJdjshOZDPWnh3UiO4eyyREHhb5MUdXPCE+v3lteG1
Guvsqv6gsVIApCa1MlB2voTpXUwOt1k7W+fgDCKgDVeG5W49OIbIGusaqSXQ/qrq
MgTFvcEni/Iu8fEk0dX7pzYmZbxcLXDvQZVp86/F6Uiw2YYeTC1KL4ElT6Ts/qQt
iFwY9efkjNocI5xQQKijMVvvOmDjnDO95Cwfit1xVejVa2u2maMaEcSTLFkIz575
cpFuHd+LGD8GCbWDBTWYkPAb5MAT/TPcmWbAelrxRjEGwXTjDeiIU6/jbOJSbqE3
yikHSMC/6jvAgC9+ir1rqAlwfA87ZZ8V3ScROHBdJ9cQVhx7UJmBrZqVocxpTnNE
YIndne1pmxMuzWPwRQqdhjTkQEpS4Puxd/vsLWtK6lKy1ZZm6qVbK+UXqEirDbo5
fsn5x/AcYBP/J/sWSq/pKmamB4Ln9GICzf73jp6VHRZPFEznLF8=
=8pgl
-----END PGP SIGNATURE-----

--TLJ8iEYt1e9qWIkZ--
