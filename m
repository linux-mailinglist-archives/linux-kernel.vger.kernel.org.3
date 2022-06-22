Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00452554B67
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347518AbiFVNe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348154AbiFVNez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:34:55 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4905B2FE43;
        Wed, 22 Jun 2022 06:34:54 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ay16so14928344ejb.6;
        Wed, 22 Jun 2022 06:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OeK/8QdFp7wFBFgH/EC0/Ik73wju5RsZbcSGwadd7AI=;
        b=Cf8RC6oOqOGUqPeFjJriOh4Ys1+puSMMmg/5DMxhlajdhnHGOQFtRPfVxzmmgoLYIU
         yz97RrPSOhFvuxElbuuFWgGkrTZpMpSAW2oA5vAurihaLg7awS+zY129QDE8+PIgGBi5
         v1ndxqg0Y/MDTLG1OkaVVu004y3s46HBOcQZ2SLl+APxoPufF7WwA88Jt/+gkYwT2h4s
         u0Hr6bCrUoptFNhjIw0N1/c4py3CktWBBjDCXbMFxb1Do/8PcBgQLEiK5FMfbRCLFvjz
         beuV8Tmh4wKVlZ8KFWR+w2oiSw8EMMbgB0LDVHEhhKNfHzP+f7rHIgeZk8OlLlJaM/o7
         xn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OeK/8QdFp7wFBFgH/EC0/Ik73wju5RsZbcSGwadd7AI=;
        b=HnzMzzThyEBv0dk5cj4XglWpxU8Oqactz5C373OuZ2TkOHoCV/cQ8VWguneRB0R7Bt
         emis9PCFdtiF4OpEiwYNctUb5yuE7DXV8ED0vmmHJ6Alsg+ZpwwG6xXmWAHmFa4egz5n
         L/D2gR2VIU4mA11QP9VcX5IWz451Dshz/haIehCvB+Q+/JkoajZkfouStCe4RxUnih0c
         yNLl0U7FsnW2j4iTkPYGjdMQ8fLpXuOkybKi7d1g8OwWr3kI8yanC0L/9uWFHUPorfYe
         8VcLeZtkuoah+A3KLT6vw/j/qbj/RaoIFbBuI331oJbXL0Ok7iu06BueeoySMQQ5ydHa
         9OUQ==
X-Gm-Message-State: AJIora+zkaoE7nzNjVCKxTbq0tlCzFs5i7852QhW/Tv1gnZjMFedlLjF
        g8GrK1zSATfGhiwbv/9AEniWIDN8Svk=
X-Google-Smtp-Source: AGRyM1tVL0H123jCdNzFWhBVQeF6U20wV28IcfaXChbqrFTFqTls17qIHZlfxgqyTYxATv2WJfQLoQ==
X-Received: by 2002:a17:906:c10:b0:6f4:6c70:b00f with SMTP id s16-20020a1709060c1000b006f46c70b00fmr3180634ejf.660.1655904892723;
        Wed, 22 Jun 2022 06:34:52 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id eq20-20020a056402299400b0042deea0e961sm14467142edb.67.2022.06.22.06.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 06:34:51 -0700 (PDT)
Date:   Wed, 22 Jun 2022 15:34:49 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: atmel-tcb: fix typo in comment
Message-ID: <YrMaeYDPaoG/VkXz@orome>
References: <20220521111145.81697-22-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AC9xZouUaILMuz1s"
Content-Disposition: inline
In-Reply-To: <20220521111145.81697-22-Julia.Lawall@inria.fr>
User-Agent: Mutt/2.2.4 (c3baa83e) (2022-04-30)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AC9xZouUaILMuz1s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 21, 2022 at 01:10:32PM +0200, Julia Lawall wrote:
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
>=20
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
>=20
> ---
>  drivers/pwm/pwm-atmel-tcb.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Thierry

--AC9xZouUaILMuz1s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmKzGnkACgkQ3SOs138+
s6FEdhAAnmBZFckEPHQ96OmAcrUUC/cjkJx3kAY8USDthta28AyTCiPsXXUYvYwh
yZZJ5/6ooHcsNnT21np02G8MQxkfICDmCrjPXeqRGYDp+VyLyjDUnhahdz88suxO
O7PpKAETxwFVmx6nT4P6PprNoON1VmdymUOGtCryE9RWrHL6idBqt4J39R/ewmfm
vcgWXKV/MQ5iC1vzCKDxBi5AbWKaVoJTeOVsE99F2c9HGXu+IqtaxKuXTDJuPskP
7gCE9N4qAQzuRy2DCrtJFJ++rpXl00uD3jtCBYpAQa6Xf8My9Z4tgsWof9yERcQn
rBxIoxu0Kfpp0NR9PO6DRmhce8xUsp7Muo3KlfnrW4xzEMW2xQ8nBFRDP4ROsEUz
RDnv9KGyb7iKirKkvUYBsr1Jb8offt0pVBi5Is65VCv61fZnGLm6iNQ7a3fAGwGj
/XNFvoZwBzkTxhDLhS/rQasK0QWKu2BO2uO4k3RCmF7bjKxTCe8rhmx7VNVX8LLx
gO0zoP/WAr9FFktyP/afbCe6GFZXB7q+BhaPpjlbdbMDe2Vuu9RnIUfCD3AFgLDG
v3YKEHoXNZLiJSBlsmDLV3GHA72HZ9jy46H3B+CdkmgAFvhuoNzXx5siFs1zIV3x
isEeJOipiHTwmGgWjHPp6AmQ+YPl3WBlbpVDDey3DjdIr4JzyVY=
=DKem
-----END PGP SIGNATURE-----

--AC9xZouUaILMuz1s--
