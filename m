Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2ED506821
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 11:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241367AbiDSJ7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 05:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiDSJ7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 05:59:36 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189082127D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 02:56:53 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5EC0F240004;
        Tue, 19 Apr 2022 09:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650362212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mq8173Yhb7PWseSDb2n4pQrTc0Fh+GdWcB9T/uTdM2M=;
        b=HpO7PHrughSJxpPdJhGONJgxyf/vZiM5hnkdHg2WbBKu/FgmsuQ4mxb7LXxMz7f3DhyuEN
        OTiDujbFsmL3Cu2rxisww3BxUdCbsTiOIs6J31m4sw3Uz5F0Y40B/XzOW/yP0QWwNNH9Ok
        uZqVLxS9/yCfLkhWUCUqiGC+QZp7pbAGqELsIbrnQ7DOd7NvBBs/eBKjwF/JS1Q9VsfscM
        eAtqgharoXWYaS+2+HR907QYRSIbXGf2gx99+xWVsGxpA1V24Wv6kqpJfagspDObipq29r
        GuKPPZFaXyCSYJ1gz9N1KRGml+dxDafact1+n36DXtCK4cGP5YNKpH1AzcERTg==
Date:   Tue, 19 Apr 2022 11:56:50 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        jagan@amarulasolutions.com, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, thomas.petazzoni@bootlin.com,
        tzimmermann@suse.de
Subject: Re: [PATCH v3] drm: of: Properly try all possible cases for
 bridge/panel detection
Message-ID: <Yl6HYke4dJsrq9jj@aptenodytes>
References: <20220329132732.628474-1-paul.kocialkowski@bootlin.com>
 <20220416222141.72321-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XgDB20WdwLjkKw76"
Content-Disposition: inline
In-Reply-To: <20220416222141.72321-1-paul@crapouillou.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XgDB20WdwLjkKw76
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Sat 16 Apr 22, 23:21, Paul Cercueil wrote:
> Hi Paul,
>=20
> This patch breaks the ingenic-drm driver.
>=20
> It calls drm_of_find_panel_or_bridge(np, 0, i, ...) starting for i=3D0, u=
ntil
> -ENODEV is returned, which does not happen anymore.
>=20
> The idea is to probe all the connected panels/bridges, should it be done
> differently now?

I've sent out a different patch which restores -ENODEV at:
https://patchwork.freedesktop.org/patch/481135/

Feel free to try it and reply with tested-by/reviewed-by there.
I've also made a proposal in the thread to skip the "child node" mechanism
as soon as an of graph is present, which would allow covering more legit
cases with -ENODEV (the patch linked above doesn't cover all cases that
need -ENODEV).

Ideally we'd like to remove the child node mechanism entirely, but it may
already be part of a device-tree binding spec.

Cheers,

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--XgDB20WdwLjkKw76
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmJeh2IACgkQ3cLmz3+f
v9GBKAf8DA/g/QCGdK6HmqooGT+X0CNX9NbaVBgCVkWL/wnG+MEsNTNY0g54m8h/
yQexs7+ZudJ19RzZAtJFgj3zcc9u/VXYxipI5Q+zFp9Q7UEuNDfZLS1yxSN+hfr9
fEK1YarFnb/uo/mCWiP2SAJiDtipJe+flEzyutHK6Jf1p2jyAbED4DlZTED8fN1X
uBkMw63pnPdzJcdx0+sm8xLnbY/bkaMjJasIjmfiimQsI09g+TCu5bBlEJIuMDG9
2XrTsUWWN7kex6f+cMakL4nhwL8EM1Hmysga6S4cODnhzJqEODXjMiKtCI+yB+hP
UEUj0lqOrQcgo/RpuKQiFQZxCSkhFA==
=RY5S
-----END PGP SIGNATURE-----

--XgDB20WdwLjkKw76--
