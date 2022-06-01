Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA32353A95D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 16:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351149AbiFAOrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 10:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbiFAOrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 10:47:13 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE85506EC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 07:47:11 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id gi33so4282289ejc.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 07:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ib+2pdINzY13tkdFt/33K5unpLr9MXTZJAeLRoX/j+g=;
        b=DROnEQr99X22rbQ1+IN6Bd2hcrecLS98ZlfjXGQrYLXsPHAZUnfNxO3bKavaeYm/ZM
         610HvsocXO9035hSJFF8uSJuRvuvgGENggHH9tC9Bj09gd5Ydr11Nh+sWirHDw4khkhe
         atbL+YCXqWBIkNlbk4xTJ/aQZXq+c7gCOyBcqDygeciNN7ItISmi1Hmkax3WjbEHVHwJ
         1QiEO7qb56NkSbk3RO/cDojFxMjFbv5VJ0xxGm10zeprHsTf+YSNZLCF8CO7GLdT4z42
         K1CCn4IhdxUOsfSuRJYu25If481vgebF7Pyd9/FZdO4tyw87/VBadxSrGryXJ09M3bYv
         1HGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ib+2pdINzY13tkdFt/33K5unpLr9MXTZJAeLRoX/j+g=;
        b=AzMdfI9Lrh/9P5Rclx6DqxA1IFitGRTSgvTV4xA1MMvuQFZmTYfOnvn6Dg6s+7etnw
         537RzlqdY4CbZ8ItHYq9Z9rVVTbRSeBrNIlOaN/vw3w7ewFeRh/E6iQGDr7m+jjr0vGM
         0gI57X2ZbSr42CJJ6BxYw5ktv8JYeYslBb0tVqH9awClGPsOgWZD3sQGBw6A9x0afNdh
         jYP5HNjmMjqMbnOQA9esKWLbrYhBvZnv3DiL9Qds9wLo4X7ncPflzeC7tJMv4EZPI3If
         nMQKLpKr0Z0hnDA3hnNoa4eofXfh2fmIHKfcReip4Xcozs8JEPw6Yk2Zo6w6F5XkkU0R
         rK6A==
X-Gm-Message-State: AOAM531AFfNj/TZETtRow32bPCYBKvV71shXZuYbAgJ7AelpJLMeVZ7p
        jEy88+UQd/fXZtHCZT34JCTMqrHON4Q=
X-Google-Smtp-Source: ABdhPJzTh2kzz8vuZag+D3UadxCCSgbVs/EirqIqMjSCoVPYcUiRIijpnuh+g+g7f7kDT3+EpLmv0A==
X-Received: by 2002:a17:907:97d5:b0:706:76ba:f28f with SMTP id js21-20020a17090797d500b0070676baf28fmr203512ejc.367.1654094830518;
        Wed, 01 Jun 2022 07:47:10 -0700 (PDT)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id qw8-20020a170906fca800b006fed40e5564sm783328ejb.83.2022.06.01.07.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 07:47:09 -0700 (PDT)
Date:   Wed, 1 Jun 2022 16:47:07 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Emma Anholt <emma@anholt.net>, David Airlie <airlied@linux.ie>,
        Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/v3d/v3d_drv: Fix PM disable depth imbalance
Message-ID: <Ypd76wmrBsIgeE3O@orome>
References: <20220601122050.1822-1-linmq006@gmail.com>
 <YpdpCWW9+igsVydr@phenom.ffwll.local>
 <55d99105-8492-e020-bed6-82e52b5fc8a1@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UFHMz0lUhc2lO5hB"
Content-Disposition: inline
In-Reply-To: <55d99105-8492-e020-bed6-82e52b5fc8a1@gmail.com>
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


--UFHMz0lUhc2lO5hB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 01, 2022 at 09:55:02PM +0800, Miaoqian Lin wrote:
> Hi, Daniel
>=20
> On 2022/6/1 21:26, Daniel Vetter wrote:
> > On Wed, Jun 01, 2022 at 04:20:50PM +0400, Miaoqian Lin wrote:
> >> The pm_runtime_enable will increase power disable depth.
> >> If the probe fails, we should use pm_runtime_disable() to balance
> >> pm_runtime_enable().
> >> Also call disable function in remove function.
> >>
> >> Fixes: 57692c94dcbe ("drm/v3d: Introduce a new DRM driver for Broadcom=
 V3D V3.x+")
> >> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> >> ---
> >> Changes in v3:
> >> - call pm_runtime_disable() in v3d_platform_drm_remove
> >> - update commit message
> >>
> >> Changes in v2
> >> - put pm_runtime_disable before dma_free_wc
> >> - rename dma_free to pm_disable
> >>
> >> v1: https://lore.kernel.org/r/20220105120442.14418-1-linmq006@gmail.com
> >> v2: https://lore.kernel.org/r/20220106124657.32737-1-linmq006@gmail.com
> > Maybe a bit late since we're at v3 already, but are there no devm_
> > functions here that would dtrt automatically?=20
>=20
> Sorry I don't see one, or we can use devm_add_action_or_reset() to add ha=
ndling
>=20
> action. something like disp_cc_sm8250_probe() in drivers/clk/qcom/dispcc-=
sm8250.c
>=20
> How do you think?

Looks like there's a devm_pm_runtime_enable() helper that does exactly
that. See commit b3636a3a2c51 ("PM: runtime: add devm_pm_runtime_enable
helper"). I haven't seen any large janitorial series yet for that, so
perhaps it's just not widely known yet.

Thierry

--UFHMz0lUhc2lO5hB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmKXe+sACgkQ3SOs138+
s6G5NRAAm+7+JLpQwcbmQEA9ILZ74xJkjZz+/ZlHJU1BF/IDWqOJWT2fWdrNKS3H
JOYpuq+LENvxoU91xe3d3yXMADFU0/v97apTBB0UJbZZTD9Af5xwhGGziAIMmPdD
6ZMO5Jzq9x/udiLjEdLV1+kNt0RE40MSD/ZmrhxRnFPjrLY/AKN6rsT87BbXCd0j
w0thsxX7OtqSv1ovYD9+aEaKU4ap4ukib0dwwkkyX4pAg2p0O7D+pRk66/BDU4Nd
3iQ3NcuwOQj5ErJ2QysygElOHzk+lhJG4BkLI3IJwFrSqFWNRjrZ1TpHlo2Nt2xO
grlAni/O8erj+EnHk1VabGGmdAEGxtL4dUZmxpZV8w7VQz5ehh/OTpl0JEUJIOCp
U9bAQCqz/9D/xE906HQj2yyCYK0lofORQ8PgASntx4uvte7CD2SorS+9Tp0L//Wd
TlmzW+idcF8/ELfHvhRfyhp/DqGuUh4UI946qmEqEYkW/YWAMXgYm1h4jGwY/HCn
ATw3HDq8IzOuKkBji3ClrsFPw7F8kFSgi5ysouAUeMAz1itZX67TQSPhrw1VporY
zTatyEfZo5aesC5d+E6/d0IdvgidiPVdTDn5mOLL1ceme5umt9zX0Fg5+Avq0M4o
MPnGHIgZR8U72nAqdWQq/c7BsgFJm7SGgIGUIIOmViOn3FN0IVk=
=5P+q
-----END PGP SIGNATURE-----

--UFHMz0lUhc2lO5hB--
