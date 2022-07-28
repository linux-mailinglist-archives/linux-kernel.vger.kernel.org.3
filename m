Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960AA5844B0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 19:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbiG1RP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 13:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiG1RP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 13:15:56 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D64A5A2C3;
        Thu, 28 Jul 2022 10:15:54 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z22so2986295edd.6;
        Thu, 28 Jul 2022 10:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kzxkcoZRRL9rOm88Cmu3gObIZ4ByC/bqi9jRPQofGU0=;
        b=mA1g9jERDTuXB6CIUzwheMHBNODiEGENbo+7PFcbstZJMzV1SVB6J7wTVUXl3AWB8j
         ivmIr18bObn8snEts21XSsJ9/9kR/j5mXowkVHf+dMo9acZzMjym03+syxKTqz/m9Kb6
         nuLIwdQfnydSj5ucudwy/eJEPu+GcAdOuDLksXUSan3Qav96jOBpMSYMw43A0ImCHRMU
         3HW2rOt2CTjjJzWItKRjE0soDz1xjLrLhoearwoY6gA9s8yZXS/lbe1uLRnTZGMzmMSA
         JnV6ANCvFAAAEUxvOKxd5c5x4m8VDwCWLjkCoGElzxv6bqkkxTZkkHcvgaOTNpsmIlJf
         GRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kzxkcoZRRL9rOm88Cmu3gObIZ4ByC/bqi9jRPQofGU0=;
        b=2TQ30Tj5jg4JtCbBwhJ3zNeqH6nBDHGN+xu29DNTPITqfb2pTpdU3wfJdkPxyfjGPD
         94Hyf6tBxFuUAT0OrWz2AufSyleV9/RxJDdnQHHIVZCsRK7XUaYRLkjmXs9CBc9KKL2a
         Kz/0ldOY5K7t1VQH937ZjjypTuD0bAeV8huFvzjnLzN3UtDyGqZ7AJ8k3DKGgrR/1wBh
         iqP4g3Yp+lI5h3U6QdoopWQWgtnaoQcjnROWVl4i1PuXB58Jtxuuyp0umds09WV5ORYR
         huv+Q6+gBtTfiXrbhckncDdOWGjAHTWn+me4iM6SptVancPDgyeDZwMZrhz1HveChqsf
         qEPQ==
X-Gm-Message-State: AJIora8JLoAoPHKde5uNhxnUeUNl2pzoqfz1Q9F2si/nv7t7hS21pz91
        P/vxVqtLgfH6YVSy+7I5ghM=
X-Google-Smtp-Source: AGRyM1sDiTz75TlHkXcEShLFlmR6ExyZ/xiXbbavvqsS7gF2u/acs7y8LRP86s4jS3LpUpQ3R7qwlw==
X-Received: by 2002:a05:6402:1859:b0:43c:b0db:3f9a with SMTP id v25-20020a056402185900b0043cb0db3f9amr9142788edy.120.1659028552917;
        Thu, 28 Jul 2022 10:15:52 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id o5-20020a056402038500b0043cfb6af49asm924040edv.16.2022.07.28.10.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 10:15:51 -0700 (PDT)
Date:   Thu, 28 Jul 2022 19:15:50 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: pwm: mediatek: add pwm binding for
 MT8195
Message-ID: <YuLERvcbXvsMDf2u@orome>
References: <20220531114544.144785-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="syglkuQTbgvVyS97"
Content-Disposition: inline
In-Reply-To: <20220531114544.144785-1-fparent@baylibre.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--syglkuQTbgvVyS97
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 31, 2022 at 01:45:43PM +0200, Fabien Parent wrote:
> MT8195's PWM IP is compatible with the MT8183 PWM IP.
>=20
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Thierry

--syglkuQTbgvVyS97
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmLixEUACgkQ3SOs138+
s6Gkrw//QwT81sw2csc+jMi4Ltarg0gFGzww9HzroGs9JY38usGngwiffJ2quEQ3
A58xi/nlafncbOJr8tOxv6xJ+QOWo8GBrysXJ3bPczuSf5wMddhYVJo0DLldtNlH
rT3YUELO6B8EhEqJY3alkr6fybxYVefwHn5oXmtK3O37MnD9Yh+WiSGFfGAMTdpo
W17Ue84+WQYk/pVR7NIN/CsevP/PejYeJAooA1+VxtLRAIeP/pHPe4AsDRb0Uuri
A8pPKmxBk+pcnhsISZDHTwS9BzpYCqcroy9qm4dQPHkycol7fMu4yZWfsKdPNEod
SvMORne+ZQnM9HeKOeA+7n9V/8HxQ4u54L6/c72+Zk7O6afWMBxhw6qNQWDibsFZ
Q/h0zSZDpSbr1fZ9zr/fjyGNu7NFZj9+1RgZGRZdyBHVs3KZMD3ZsTZ0k4gWpjgu
W/kzbvbMoX3No93uSA0/S1c5fuor2udWQrhu3Fe81KkWEXGJfptCOgR6yrKu7TNl
M2hWpcr7/78ayDMxBOkzWCxmqKLb4vq/QwJvHoQcSFJPaWq9FYPdrm+8rIe4Ls5e
ZGZZjQF25lYwRkXk5I/ZjXujAlhCGjN/qP+ifCNiy9ceFyoP9DqG83rSYOy8+eE/
Jj5DNH72fa/gPBjfFH+2VHoLHPglJffUyj1RvI9IuByhT8jO7zI=
=Ok+p
-----END PGP SIGNATURE-----

--syglkuQTbgvVyS97--
