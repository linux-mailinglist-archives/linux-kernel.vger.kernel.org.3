Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828FB4B243B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 12:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349400AbiBKLYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 06:24:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbiBKLYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:24:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7978DE5D;
        Fri, 11 Feb 2022 03:24:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E109616EF;
        Fri, 11 Feb 2022 11:24:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144C1C340E9;
        Fri, 11 Feb 2022 11:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644578671;
        bh=kgjamcWZJRnrpWcKV4c05OC6uDAyQHhZAjqdsl9DYiM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qDstbpDgj5EaBkwYW8RU14zD613j8a7qUPIXbUSYIGe3IFJTNkigkeTZpfE/VwakJ
         avs2nhUSR+xULtnq08pOjLaaDkQOKPaCj/S6prT54TqSPVG6QKwzVPvMOr+QNIqRh4
         lNtlUh94Jsz43zRr//3XjfBjAhQKr524MTjsbY4UYTJ4s3NDVnelgAwnOKzMgDIV8K
         ucdVy+9AVXhaj7Yklz8mncqrJFMzntZeksj9UOak0Jlm1NTYzBBZAQBnlPCcQxVucn
         3Dp2t0V51EL3I3m4SecrUM0/4FO5OdlOhDzuBzvMfVT8Q51nzIyJ8gbAEnSfiOSC2V
         UxtZnAUTtmuyw==
Date:   Fri, 11 Feb 2022 11:24:26 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jon Lin <jon.lin@rock-chips.com>
Cc:     heiko@sntech.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] spi: rockchip: Preset cs-high and clk polarity in
 setup progress
Message-ID: <YgZHalrdhhilxROt@sirena.org.uk>
References: <20220211034344.4130-1-jon.lin@rock-chips.com>
 <20220211034344.4130-2-jon.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lAF4Pc7uRcV0XAJA"
Content-Disposition: inline
In-Reply-To: <20220211034344.4130-2-jon.lin@rock-chips.com>
X-Cookie: do {
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lAF4Pc7uRcV0XAJA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 11, 2022 at 11:43:38AM +0800, Jon Lin wrote:

> +static int rockchip_spi_setup(struct spi_device *spi)
> +{
> +	struct rockchip_spi *rs = spi_controller_get_devdata(spi->controller);
> +	u32 cr0;
> +
> +	pm_runtime_get_sync(rs->dev);
> +
> +	cr0 = readl_relaxed(rs->regs + ROCKCHIP_SPI_CTRLR0);
> +
> +	cr0 |= ((spi->mode & 0x3) << CR0_SCPH_OFFSET);
> +	if (spi->mode & SPI_CS_HIGH)
> +		cr0 |= BIT(spi->chip_select) << CR0_SOI_OFFSET;

What ensures that this read/modify/write doesn't race with a transfer
running on another client device in the case where the controller has
more than one device connected?  Similarly with the mode, though it's
not great to have devices with different modes connected to a single
controller.

--lAF4Pc7uRcV0XAJA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIGR2kACgkQJNaLcl1U
h9BfyQf/exE8+iCXNV1fW3KseTOTWzPwI1YKjOVKpLUK5KiyNUWaF/i9rC5TRKq6
DYL//DLorpWKPt16bQTJUITGV4n0Me0ps0mgpCSFUBcWNknN6ZhGRoopU+YtYsqq
JuUyZ4IXQqa+2FD8PTKZYNYYi1KwYpD/95NwyzhxtqjFYleINO64dcFpzz6kuOzG
2eluAh49aSNJmPS8z8/o/CI8rjMWkB+JioGo5yTTHoG41pK5mXsxVwBcxihTISkV
yK9eLoFZ/wTwC9sTQUnxMZvedvHQbIN1/ZUkeL3dRa7mkduqQwAHgOy+9FRu8Yu1
UEDeO1CtCL19tCK5ONwNoA2vEMN8kA==
=zClG
-----END PGP SIGNATURE-----

--lAF4Pc7uRcV0XAJA--
