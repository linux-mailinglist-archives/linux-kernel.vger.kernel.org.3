Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50DB048C471
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 14:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353389AbiALNL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 08:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240733AbiALNLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 08:11:52 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4873DC06173F;
        Wed, 12 Jan 2022 05:11:51 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d19so4267995wrb.0;
        Wed, 12 Jan 2022 05:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7f+ic8TxlFUKFnOCkZFKPq8TQyP8w+H9m7F2OJNGJIU=;
        b=RVMUTjFa2UESa2BHtCcnl158JFKhuK2xO1kpBSTZ0X0bo61yvjOQY44KawcWNL8w0M
         nNZwpYIaDYS0HoTBxoLPTjfZcHOKfsSuuUbbaD0bGx9VpnpuQT+a1g+GgHuFPhnLtaO5
         D/Tk0P1D3ZnOUFToCEqm4X0zOXu0fjbFJ7bb1GJuib0N6GPonyLT8pJxmkvaOz/GMhq8
         YmY4y5+ozBBzlcxFLeRqOZjEHRpUFokRSzOIwrNDMGBfg8q7m6/2y5Sj+HgQ6EC5Y92q
         RED3KO1imjeMSnf4WEiwDT9l/rIxcDYz0/9kJOG9DEb2yDhv9XWCIu4Gn3Eh9DM9vKSb
         hr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7f+ic8TxlFUKFnOCkZFKPq8TQyP8w+H9m7F2OJNGJIU=;
        b=XplpaBffydWeHB/BXJTticVxX/nO9ldkz1EUrKKYuUCfE2n3+i8Yy00wJPvsaRmgm6
         mSwBJ9N14d9HpoKWK9yL2jKK2n8I5EiJ4LwA1dSbFlb9Bsl1m+vRFe/WNmQU4Bz8P1JA
         rX9oTaikwbMV9pAWD6IO9oM/Brln4MWY1KOuAcgQGcz1FkP2EIyPpwNvaiC0cjNqNNlt
         5RwY9xCJttsZvf+gooEduDXKYFKx/ivOW9OvYuxi33SQgRZeJA2n6mOEdiT4IuVONZ/4
         m/d7tvwP6WOHRofVa2P1sA6f88C6LQm5oC13K9DCNRGqbdPXncWloXJyk031QJ3pgH3C
         w5Mw==
X-Gm-Message-State: AOAM533bT+4JJOS+q89J9AAwVw76//0sCnYGcESULQl9p+RrAigEoOC6
        K7fGJhoArQGsj9bbSeuwH7A=
X-Google-Smtp-Source: ABdhPJyAmRIUsejPaQWvBKGx7Z/IESGUrX9XZF+BHeFnFeTxc+qlqbVlguYwFdSdKkBuTyGtqoDwHA==
X-Received: by 2002:a5d:6881:: with SMTP id h1mr7871866wru.250.1641993109742;
        Wed, 12 Jan 2022 05:11:49 -0800 (PST)
Received: from orome ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id z7sm10125751wrm.117.2022.01.12.05.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 05:11:48 -0800 (PST)
Date:   Wed, 12 Jan 2022 14:11:45 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thierry Reding <treding@nvidia.com>,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v1 1/1] gpio: tegra: Get rid of duplicate of_node
 assignment
Message-ID: <Yd7TkUKo2g2Asbna@orome>
References: <20211223122639.86923-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eS9Bqgo09E4YMHL2"
Content-Disposition: inline
In-Reply-To: <20211223122639.86923-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/2.1.5 (31b18ae9) (2021-12-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eS9Bqgo09E4YMHL2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 23, 2021 at 02:26:39PM +0200, Andy Shevchenko wrote:
> GPIO library does copy the of_node from the parent device of
> the GPIO chip, there is no need to repeat this in the individual
> drivers. Remove these assignment all at once.
>=20
> For the details one may look into the of_gpio_dev_init() implementation.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpio-tegra.c | 1 -
>  1 file changed, 1 deletion(-)

Yep, this is indeed not necessary (anymore), so:

Reviewed-by: Thierry Reding <treding@nvidia.com>

I've also given this a quick spin on a Tegra124 device (Venice 2) and
everything seems to be working fine, so also:

Tested-by: Thierry Reding <treding@nvidia.com>

Thanks,
Thierry

--eS9Bqgo09E4YMHL2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmHe05EACgkQ3SOs138+
s6FIEBAAjnCefZf/TmXMbRK8YKO2zooLOhkybC1j9ERVbbd/smfeyQoyKxCqIm5M
hejWChgrfuYDoiWv+Mi1BnTZOz0vTRNo9Dbnsi7izpin+IQAufYosObqf/AMn8E0
dKrEOZLgyIT9fBla17Y8mXTgt9RPoVFst4aKI3oPibWBc1TJQa02967JSbVzm4FZ
13U02UIg7JYeb5MKjAl2bz0INiU+t3Solc4t3NZelsbOwMgOCA7Kntg9LZAYXkfJ
hg4TNLxOQZuK6wIoDXxsW60p+RRsrbwjJuuYwF13Dj/JOX8SDH0JGThEM7RwDpyk
SWvm2UMB1UVlSi6Rxk8RRoZ1BW0WYDdQdKKHZJWtXZP2xsVXQopL0rLx74U97hwW
d/zm5prIcM4fDU03g8Z0KCFUbjKmrc3Hk7mG9Yc0KF4uL/bYcNCt/9DxGVxV9PWY
MJasmjFaGrt9Xox6ZPOQxgFez6uaEIN1b9rYEiKa2yK50od5JKsqAqtSVynZPmwY
22apy+LvILhB4vchrOwWTMkgQNXDwqqC3DEFswl2uLMLfH9h5iNa6yX6nW157aGp
tpg1viE44QXtHz/+mby3JY6VAJO46ged+gG92kj1WTJqOZxiCwQG8t4OY687fkkJ
wNQvAbiRMPZPn5SMpNxT4l/O7hNEzBDRxtUwmVHjz1lLZSOUlQ8=
=v1tj
-----END PGP SIGNATURE-----

--eS9Bqgo09E4YMHL2--
