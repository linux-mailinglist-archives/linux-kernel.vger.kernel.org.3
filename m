Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67F4583112
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 19:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243098AbiG0Rpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 13:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243181AbiG0RoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 13:44:25 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C89A8B4A8;
        Wed, 27 Jul 2022 09:53:07 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id q23so14745423lfr.3;
        Wed, 27 Jul 2022 09:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k5oCcGPDr0My47uLGpFUyO0yVBgIsd/UrNxst8O80Sc=;
        b=g+5t+zT1mFjw8xi+wQ9FTZBLfKWrtIEhZaRRjKjE9njUNeSQvc6VkMhzuMtF+hoClF
         Dl3odeB6zqmqnAUHy6SmqfowXnKcKEu7IR+b9NoXdTD9TSnrZphJMCtVF/TDYHgjdVY7
         ieDhfNA5NBxRHlPq3h3Uqp1UvqmjJ0isDsplrMCc3grkSP4gXJux4E5s2FaXdRFodevh
         Xpxgh7fKGVXyudQyXKRVJcjcIqisXVOVkKOMunzwmb7PjV+EzgxGkdcL9gPWzLi5lvgq
         3/p6S64i4klmhUSQAWW+f006hEdXKhvlbk7F2TMArydlrUBp61kky4TQwPEKnmQf6Gr3
         Ixcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k5oCcGPDr0My47uLGpFUyO0yVBgIsd/UrNxst8O80Sc=;
        b=DgFmsL9J2wViodJ7FisiMI+UxCOWUWLAj9MUL+imPrNZLrQYInBnn878FcGP0fVTJb
         4BbC+pBpfNKKW7FpVzk5vCNrbF1/fEMfs4eyTWrNaNb3XQAID40ix2052BLXDL2Owe81
         Cg8UsUMNODeawTCnRMfAOl/qQesSb7Emyvf/5jfArsCzQ2RIBxruv725YjyXVBKsiP7M
         lHYDOzfwF1yeVgV+zEJHDKGFyod/1w51q722bEucnlwqp9Nq2vDl9QtmWJlc5m+W3mas
         9hNQqyxAw0BTAw6XzroE+qhhOL1XwhhmcWfBuvxbWGn0bM+VvCTbH4TEXJGXrbcuJ5R6
         uPOg==
X-Gm-Message-State: AJIora92cMmXeYaJgMGrztiXKeH1br2p81HwmL78Xyp5S5iGGfa9PcPZ
        ut2dIygQcDDeB8G+jrbjT98=
X-Google-Smtp-Source: AGRyM1uS6YZG984glPCZhSncSiUhGHQNNybnJZZ603ln2wunorQ1ShlgPtDZ7WAOt2NA20TTKiQKEg==
X-Received: by 2002:ac2:4bc1:0:b0:48a:ad3:f90f with SMTP id o1-20020ac24bc1000000b0048a0ad3f90fmr8279804lfq.91.1658940783813;
        Wed, 27 Jul 2022 09:53:03 -0700 (PDT)
Received: from gmail.com (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id k1-20020a2ea261000000b0025d75995a07sm746769ljm.24.2022.07.27.09.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 09:53:03 -0700 (PDT)
Date:   Wed, 27 Jul 2022 18:56:58 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lucas Stankus <lucas.p.stankus@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Tomislav Denis <tomislav.denis@avl.com>,
        Oleksij Rempel <linux@rempel-privat.de>, kernel@pengutronix.de,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Stefan Popa <stefan.popa@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Joachim Eastwood <manabian@gmail.com>,
        Tomas Melin <tomas.melin@vaisala.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Beniamin Bia <beniamin.bia@analog.com>,
        Patrick Vasseur <patrick.vasseur@c-s.fr>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexandru Lazar <alazar@startmail.com>,
        Oskar Andero <oskar.andero@gmail.com>,
        =?iso-8859-1?Q?M=E5rten?= Lindahl <martenli@axis.com>,
        Bogdan Pricop <bogdan.pricop@emutex.com>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Dan Murphy <dmurphy@ti.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Phil Reid <preid@electromag.com.au>,
        Michael Welling <mwelling@ieee.org>,
        Lukas Wunner <lukas@wunner.de>,
        Robert Jones <rjones@gateworks.com>,
        Chris Coffey <cmc@babblebit.net>,
        Slawomir Stepien <sst@poczta.fm>,
        Sankar Velliangiri <navin@linumiz.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 01/10] dt-bindings: iio: adc: use
 spi-peripheral-props.yaml
Message-ID: <YuFuWnvMm4tMLs7/@gmail.com>
References: <20220727164646.387541-1-krzysztof.kozlowski@linaro.org>
 <20220727164646.387541-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YEGndTYCRLH9MHD/"
Content-Disposition: inline
In-Reply-To: <20220727164646.387541-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YEGndTYCRLH9MHD/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 27, 2022 at 06:46:37PM +0200, Krzysztof Kozlowski wrote:
> Instead of listing directly properties typical for SPI peripherals,
> reference the spi-peripheral-props.yaml schema.  This allows using all
> properties typical for SPI-connected devices, even these which device
> bindings author did not tried yet.
>=20
> Remove the spi-* properties which now come via spi-peripheral-props.yaml
> schema, except for the cases when device schema adds some constraints
> like maximum frequency.
>=20
> While changing additionalProperties->unevaluatedProperties, put it in
> typical place, just before example DTS.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
[...]
>  .../bindings/iio/adc/microchip,mcp3911.yaml   |  5 +++-

FWIW:=20
Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>


--YEGndTYCRLH9MHD/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmLhblQACgkQiIBOb1ld
UjJDTw/7BqHthBsEkYP0xMrkv3QyiojmRM/dm9DBpE2L4Qm9tgzjky8eHTeJdrGv
wKJBUdlXF4ztcEev9olQs6iTZ+0mVNxh6jk5vzfO7nudKnEaoG2tgZWdZJHRHGNv
gBeqqDHwGSv6dqIYA/DePu1RNbFqkhuzQCm+vUMg54E1dBuHLouvlB9v3rxz7YIB
Q77AilcHt5SyFdZJayjN7YXoxJV0VKj7urCL44t2PKQnXAClErO4dICXxMP9w3O8
HUGkSmvXWkXEKtXv3S2iF0sKTQMs3loJOtRBdRpthyNL26z114aMGuyUtufa10GA
BuTLi+ITx1sW10g3ZHnlOhuxBOI3GkxT9bGIMm3bFBmtbAioUc/qQ5oDoBqBJNys
24fKJDhHWn5brqSyES3hdiut1zUDRdaEzEkLXbYvCp+/sqAIRxjlimzQYwAkhjzO
divUqxRvewwGsHiC6L3+spvWwt5VjeDhiV0VOtSS1Ws8IbmFDklGMArZqUHOOCAw
MKwzho/muVqynERURzuzSouNuFOlWrNQozSQjZB8sd9NFHptTpNNUklPQd58O20O
F3Pyclu2W+8JEOEJa3pZVD8XwEu3KOisUp2U4c9CUbSKCuTVLlCai0ukbC65IV7j
f4vRdY9Apcwvw4ovK9awFC28RyZB/CJSC46TpjERIGxUeb3huVY=
=kMsI
-----END PGP SIGNATURE-----

--YEGndTYCRLH9MHD/--
