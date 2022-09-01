Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B997D5A95D5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 13:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbiIALg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 07:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbiIALg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 07:36:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0957139D5F;
        Thu,  1 Sep 2022 04:36:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5074A61DF9;
        Thu,  1 Sep 2022 11:36:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68177C433D6;
        Thu,  1 Sep 2022 11:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662032214;
        bh=ewEocTavTH3WLePXZx0WQKi1iSVGpePM071lhwzenwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kSK4p/lXj05Q+pMU3J2fEreCJ3o+u3JqJj1NnO5KQgfiQWsRLQgzgS0Vl9g7snOqm
         XK3XzY2Lcu8oxeia2I8g2AwxrFl5/F7WHWYCanDC5OUqiTTqZ4WX+oEid2L4q9uCd+
         owyQtj+gx4VuYUOQlK1PuPRIn/O6dXghOPdDayCTQlUI5FtpMNDHpH0duO5gSnJP2s
         JLVIo2U41WbZFkMC2amje8hFjb8A24UC1y8YBEXO6KAIxq6p8iXkn5v1lEcEUbl+w+
         mTJxbYwc4iFIDnQ8mapI24FiM5FyjR++TIrOCY2CObdcm0XDQGztwJebQ4eaFjEc3u
         xL/mZdzJ2fqSw==
Date:   Thu, 1 Sep 2022 12:36:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        shengfei Xu <xsf@rock-chips.com>
Subject: Re: [PATCH 12/13] regulator: rk808: add rk806 support
Message-ID: <YxCZUGPVQwrefLJi@sirena.org.uk>
References: <20220831215437.117880-1-sebastian.reichel@collabora.com>
 <20220831215437.117880-13-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1rNgShYEpulPv2NW"
Content-Disposition: inline
In-Reply-To: <20220831215437.117880-13-sebastian.reichel@collabora.com>
X-Cookie: This bag is recyclable.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1rNgShYEpulPv2NW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 31, 2022 at 11:54:36PM +0200, Sebastian Reichel wrote:

> +static int rk806_get_reg_offset(int id)
> +{
> +	int reg_offset = 0;
> +
> +	if (id >= RK806_ID_DCDC1 && id <= RK806_ID_DCDC10)
> +		reg_offset = RK806_DCDC_SLP_REG_OFFSET;
> +	else if ((id >= RK806_ID_NLDO1 && id <= RK806_ID_NLDO4) ||
> +		 (id == RK806_ID_NLDO5))
> +		reg_offset = RK806_NLDO_SLP_REG_OFFSET;
> +	else if (id >= RK806_ID_PLDO1 && id <= RK806_ID_PLDO6)
> +		reg_offset = RK806_PLDO_SLP_REG_OFFSET;
> +
> +	return reg_offset;
> +}

Use separate operations and/or separate data and decide at probe time
which data to use for which regulator, don't have a switch statement at
runtime like this.  This reduces the amount of open coding in the driver
and opens up more opportinuties for improving things in the framework.

--1rNgShYEpulPv2NW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMQmU8ACgkQJNaLcl1U
h9CRugf+IFSbYZyNpZZAJ0NCoJUOq60Qb6DA8UROFSEA3TkVEQoul5Ham4Yrq7it
FHsju/eJgQi3CQ4N2qArbobHqmpOb71XeSqzDO1k88n8cO8PZnf2RF0abTLWSrt/
OHzjVdsoX2RACLl1yO60Q2qSLXK2/J/txmXjnA2Qpbrhso/dys/WP7dQ5JazLp/P
tWJwTdGN0KU/gnQOHJ5zArfIn0lOAtj6pvm0r+m8/IGt9zqOth7sWnTpv2MEhMIO
ur6TaG6fJeFbL93iSH0aGw2OpDTixVR3OXOtt6zjPbWGCJfepDEQRVQXLzyMCyNd
ASmRWm8owazfYIqvvbLo1NGLW2giug==
=xni7
-----END PGP SIGNATURE-----

--1rNgShYEpulPv2NW--
