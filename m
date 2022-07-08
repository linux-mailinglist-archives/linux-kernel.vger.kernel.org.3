Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140F156BCB6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 17:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238729AbiGHOo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 10:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238564AbiGHOom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 10:44:42 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A035073924;
        Fri,  8 Jul 2022 07:43:57 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so1310436wme.0;
        Fri, 08 Jul 2022 07:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LTk8O11zcqX6zMh/4qd+EknA/JMTcDXb+8WtvC4PeXM=;
        b=M/F+AA1qBkzX8XJ3tbqDvQP/qr+XmJ9HoG+ZgIBy1fX2Dj72peZ6T68tXKk/NKKjPD
         IKprTDQFrnaTpagJ4T28NJO27goeWVK1JNfxpx5jXtMB6jDVb3TWZA4WCP4jr5FKozh0
         ItlTUs2fdyf1SPxoFRAqRC71N9b4vJBfvQaj6anxnpXQcYIr0BYAbv+APjZ7uFxBNDvI
         A6EhJsSMhf9eEzGatjZDTCOCWUNxslX/gCV8hmQL3R+BfvcHeof4X49QMZC+3BMkrBYD
         nEmfg0Mo3utSSl4TruiqHUYmzZa5eEUfMztlQn3eJM5MXbaWTnHpe3kWjtfeLvnfaLoi
         Q//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LTk8O11zcqX6zMh/4qd+EknA/JMTcDXb+8WtvC4PeXM=;
        b=D+e80C2o6EBfxVROtRGcaX4uK9Artrc2/f74+wEI0vco17C+kmBKVTvlf1Jyxy5yTG
         XuNvs71mQUyy3Suxsyeleu/hYqNJ+k+AFTC68bhYR1xmL5FJ3wf7kWG9tto03DGwX3i9
         ezBpNUJRGLrrtOfcHPQMzpdzByZUurVC5BZOa80HRrmr9bIG4qGqbRqpFMGHDL9jg+9T
         06kmQjDaxE8NGplstsieYqa3pehQeScTvSkIpfaDQLWBJKNLW4o1GH/3jfurim5MaR9O
         KUfxUuAF+2+gXC1b1Hh+3WAvivxGTEQQSMdMKYL0rdzUlT61z3w4AlUSzt3iCOtktZAp
         XJ5g==
X-Gm-Message-State: AJIora+BnQj1HzpGeYzlnp3iU1O9tH3JxCpJ9+WSghtLiIgEQ+87Zy/n
        zQxgw/lNnk4aN2sBI43o91s=
X-Google-Smtp-Source: AGRyM1vcXfc6q6N58ufbqwN0zs+6fYgo6VLtsDzOCVHyAMmVRQywBHO7DrkvNMWKK9bUFC3pGYt2ig==
X-Received: by 2002:a1c:7310:0:b0:3a0:5580:fbf with SMTP id d16-20020a1c7310000000b003a055800fbfmr148126wmb.109.1657291429075;
        Fri, 08 Jul 2022 07:43:49 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id f184-20020a1c38c1000000b0039c5642e430sm2420077wma.20.2022.07.08.07.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 07:43:48 -0700 (PDT)
Date:   Fri, 8 Jul 2022 16:43:46 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Kartik <kkartik@nvidia.com>
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jonathanh@nvidia.com,
        spujar@nvidia.com, mperttunen@nvidia.com, rgumasta@nvidia.com,
        amhetre@nvidia.com, akhilrajeev@nvidia.com, pshete@nvidia.com,
        vidyas@nvidia.com, sumitg@nvidia.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 3/6] clocksource/drivers/timer-tegra186: Add support
 for Tegra234 SoC
Message-ID: <YshConNfgdX3mhXY@orome>
References: <1656922422-25823-1-git-send-email-kkartik@nvidia.com>
 <1656922422-25823-4-git-send-email-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZFYjFOs7LxfZ/TlR"
Content-Disposition: inline
In-Reply-To: <1656922422-25823-4-git-send-email-kkartik@nvidia.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZFYjFOs7LxfZ/TlR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 04, 2022 at 01:43:39PM +0530, Kartik wrote:
> The timer IP block present on Tegra234 SoC supports watchdog timer
> functionality that can be used to recover from system hangs. The
> watchdog timer uses a timer in the background for countdown.
>=20
> Signed-off-by: Kartik <kkartik@nvidia.com>
> ---
>  drivers/clocksource/timer-tegra186.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--ZFYjFOs7LxfZ/TlR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmLIQqIACgkQ3SOs138+
s6EMhg//UWlFxQFYz0Mui/Hn0fQ+52PUl07Xd8zBW9TGJwjBW9lurGUlWTm03upI
4lB8rW2XYeLQWgtDAUwyj0w9pL5svT30XGNKy5+/L8bGICrsZCfh9tLMa60h2aSz
SKjovemleKXtHttWuAtSVkGbNuBZJBZgHN+ULBJkRxQMt8E9swAysa7eP5mDw4i0
OYt0N5bjhbRQFcFW/7u743ppnxd93U3DAs13rK5yczKex4mXtWOLNMYyQPPQspre
ZWho47WGZjj2fQS2+phetav8kuKTVrcTp4THve6xDvgBn67HuqtwfSedLol1+411
t0r4/Bcfh4v6uZKnD8wPz5GIzg6LMVGpH+RzSjJ1korSBCSCAzXKguQ1wxrz/uo8
qQZRckoLZzvsxrCURfShWhOJGeEkHDtulGPrrBReWIu50+bwrQvYK4Z7Nx2Zg8zt
w6nX/W8xon3rcvvreHg5rF+6pn4ORdT5ujeEfH1uEmWACxDcT2QKv1/UPQiJ4obS
/RE7+LQ8ufHToTZEk/r24Sx4ySdQlnzN1zV3B+Tocu/VUmqLcaWVdF0ximBHuWGP
21fJpBLnkfDzDYdApsf5K/SRSTvSK5bai+ScuvS3MYRq1HDnZyXmJ1fliSeASu9e
Nh/3IYjQ/4ZOBCH2Ut72rkFw9+PhJArBTuoROFfHqNwNfZqCEME=
=9e7F
-----END PGP SIGNATURE-----

--ZFYjFOs7LxfZ/TlR--
