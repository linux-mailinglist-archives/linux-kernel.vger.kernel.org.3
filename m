Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9874F4F18
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1837007AbiDFAlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355803AbiDELz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 07:55:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB4D13D02;
        Tue,  5 Apr 2022 04:13:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA10460B19;
        Tue,  5 Apr 2022 11:13:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39CB3C385A2;
        Tue,  5 Apr 2022 11:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649157215;
        bh=WzyWWvlknbtKE7RLc/OQ7ymyI3dXgaNvXaCGZ/386MI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AQaag56MPPhFyVS00GeM3mKXkesdU9ZW8V0lVkR1f93TJ+rvZmTGCsSyai7PWg0/Z
         MCo26aHhhaEQPh3rCckIUzx9r9WSx20SBBDk3r1jYU2BySw6T+BsPUm0f00Ct6TGIA
         i8kqXI2PjdBPH5//93z4lCHkrNNb5XmljzBjHGK3VanIk5LA9o8vpXu0r9Jsqz6zba
         MmYG/+wIrud6cdZD/FZe53z/3wmktJYe55ZFFmT6Yujy8G7x+JJY0LNaETSNRarLkh
         wXQ0YNx145l/sgpFXG+TTNRekkFuT43OGQ6t0jGDH8cxGOUQZ7oD8tygt3wC+F7+FY
         Ay1Qyizc4iZNQ==
Date:   Tue, 5 Apr 2022 12:13:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Pratyush Yadav <p.yadav@ti.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        git@xilinx.com, saikrishna12468@gmail.com, sgoud@xilinx.com
Subject: Re: [PATCH 2/2] spi: cadence-quadspi: Add support for OSPI device
 reset
Message-ID: <YkwkWgnDjMST72Tw@sirena.org.uk>
References: <1649156437-15609-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
 <1649156437-15609-3-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qDQ8qUZTwpOi05GZ"
Content-Disposition: inline
In-Reply-To: <1649156437-15609-3-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
X-Cookie: diplomacy, n:
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qDQ8qUZTwpOi05GZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 05, 2022 at 04:30:37PM +0530, Sai Krishna Potthuri wrote:

> +static int cqspi_versal_device_reset(struct cqspi_st *cqspi)
> +{
> +	struct platform_device *pdev = cqspi->pdev;
> +	int ret;
> +	int gpio;
> +	enum of_gpio_flags flags;
> +
> +	gpio = of_get_named_gpio_flags(pdev->dev.of_node,
> +				       "reset-gpios", 0, &flags);
> +	if (!gpio_is_valid(gpio))
> +		return gpio;
> +
> +	ret = devm_gpio_request_one(&pdev->dev, gpio, flags,
> +				    "flash-reset");

You should use the gpiod APIs here which should mean you don't need any
DT specific code to parse the flags.  At some point the old GPIO APIs
will be removed.

--qDQ8qUZTwpOi05GZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJMJFkACgkQJNaLcl1U
h9BAOQf/eBt8mh30Jui36N7l1tgT7w6FO7TQAovlqBcwFgeVRqoF+0wK+H7fk7a/
xGyq9bBpK7E4NB/OV1CW+iDWoCyEmRX+YC7r95vAeAS2O37rdupbCqis78ujtX2F
H5Mn5yaNuuXxF5xHiQttgD3EVg1t/zcKn74xUj3spHNAMypRwsdMe9Iogbuaa+wq
0Yv4jcR60pufVIotI/iwhmECzBhSW6HzqFAp1cDDS+332ecBBxwNDL7jujue7dFx
vMhzVxIRMxqMwPcHvxF6xoHFMBAlbFaQYA8f7gDK423vRcrkF4usCjHoPMBZwy8f
967RQHoDoWJ9NCCUd/nMdQ4j1xuX0A==
=+N0B
-----END PGP SIGNATURE-----

--qDQ8qUZTwpOi05GZ--
