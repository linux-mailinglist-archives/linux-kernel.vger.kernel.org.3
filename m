Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832D147EF2C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 14:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241910AbhLXN3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 08:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235765AbhLXN3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 08:29:05 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E366EC061401;
        Fri, 24 Dec 2021 05:29:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C9035CE22C2;
        Fri, 24 Dec 2021 13:29:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1579AC36AE5;
        Fri, 24 Dec 2021 13:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640352541;
        bh=UoajXc+CrR3PRknu7vySK5yIyh1YJBGaJyOtLXOzKGM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VY2cEJRMR/FqszYdH46i/IcbzJjXbzRFxvm67I4wcZogI/x1PCQ4tRx6H6S8F12yR
         Sw8qpqFmBL8l+x5SG/vchXb75Od27/QRQ8ZsFZM4gTMtDKtNaf98MF0hcHbOhcMgGM
         EsqYZFB7l4IAFL9K6FmQishn700Z45I9uz1MYR9JH10TOvlQE6FZa/G5RDpU5dtGns
         6gTZMf9Av5XRrIIylR0k4c+kTJz4uDI6Svzly6SUbamBxyaS7KbSOOdF1lNyK8j8Yc
         4+Sa0kt+HGL17b7stSuFoR12QfbjwUQS3vgmKE8lVBse4JeikaYsGgRNF+vE5PgnnB
         s7Z+mI1aLilcg==
Date:   Fri, 24 Dec 2021 13:28:57 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Quan Nguyen <quan@os.amperecomputing.com>
Cc:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        "Thang Q . Nguyen" <thang@os.amperecomputing.com>
Subject: Re: [PATCH v6 6/9] misc: smpro-errmon: Add Ampere's SMpro error
 monitor driver
Message-ID: <YcXLGYWx4gYq/Y+J@sirena.org.uk>
References: <20211224041352.29405-1-quan@os.amperecomputing.com>
 <20211224041352.29405-7-quan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p1TkcOZIYZMx6FNy"
Content-Disposition: inline
In-Reply-To: <20211224041352.29405-7-quan@os.amperecomputing.com>
X-Cookie: I brake for chezlogs!
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p1TkcOZIYZMx6FNy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 24, 2021 at 11:13:49AM +0700, Quan Nguyen wrote:

> +static int read_i2c_block_data(struct i2c_client *client, u16 address, u16 length, u8 *data)
> +{
> +	unsigned char outbuf[MAX_READ_BLOCK_LENGTH];
> +	unsigned char inbuf[2];
> +	struct i2c_msg msgs[2];
> +	ssize_t ret;
> +
> +	inbuf[0] = (address & 0xff);
> +	inbuf[1] = length;
> +
> +	msgs[0].addr = client->addr;
> +	msgs[0].flags = client->flags & I2C_M_TEN;
> +	msgs[0].len = 2;
> +	msgs[0].buf = inbuf;
> +
> +	msgs[1].addr = client->addr;
> +	msgs[1].flags = (client->flags  & I2C_M_TEN) | I2C_M_RD;
> +	msgs[1].len = length;
> +	msgs[1].buf = outbuf;
> +
> +	ret = i2c_transfer(client->adapter, msgs, NUM_I2C_MESSAGES);
> +	if (ret < 0)

regmap already supports bulk data access so it's not clear why we
would open code this.  Given that this is a single I2C transfer
it's also unclear why we'd need to export the regmap lock - a
single I2C transfer is atomic at the bus level so the regmap lock
isn't providing any additional concurrency protection.

--p1TkcOZIYZMx6FNy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHFyxkACgkQJNaLcl1U
h9DP9gf/Q0bcZ3lkRyxjxhgET9fowIKusHVDbL3su16XSlv5Rt4Tih9Rf9nu8FBm
oHmRlAtBCP9ZuA+7I743tz+/H2BeISzoGI8aF3h+MPdh2darno04pVGedC2XR1jn
9Q9cu4/TZhXOt7pazpkfUCmxHT4kn3tMDZ8u9XSWHpDX9mh80/IHwyZ6NFgMruKF
RHWAu9RjAeUCOy8tlembNTm+G9EMDKFS2XI44T3/BtW8u3c7WyiMqdr3EICCyHbd
PjXo5uAjGCljZoVoJ7L0+zUYjzvdQvYuRZ+kQfXEX8MPnE7WyV1MREkMSwl/dqXN
0M6wsXHhdztUM4b2EtWrp6M0kem1tg==
=hzut
-----END PGP SIGNATURE-----

--p1TkcOZIYZMx6FNy--
