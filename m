Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BAB4A9AB5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 15:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359142AbiBDOJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 09:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbiBDOJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 09:09:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E988C061714;
        Fri,  4 Feb 2022 06:09:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E89A8B83742;
        Fri,  4 Feb 2022 14:09:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 554A5C004E1;
        Fri,  4 Feb 2022 14:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643983766;
        bh=0Uun2P4TB48A1jqJfMKkkYNWDxl6cd7nzbvPWMj5TEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XPui98YVAgK0vBO5CTHh7ceNAxtmay7KvmcVs0vev5W1dgzvqD4pfTGgf/Ym8X5Kp
         uC1r/vT7gRFYUzq+61s1jtZsTH9xLMO5nsTuT7uVkFc6Bm8aBGP2e6zd0JOV/G5tfM
         u0vk/GLCJeLfCT/dHRA0ySQH2PRR0p/oL94eimjr0ViJKlXrr7UwKGjz1OChRbnqhu
         6CuzEa6jVzClu7EF1KI6VSmdmsxOpV6lspveiDZRaVHIoCTtohrN/jdzaQ1s5R6DnZ
         mT12qVrhpkHZ/J9Y4sMkMHnGEJqzrKxjZhyfThMeuotDur8cfqDQeDyhxYvwNTTspL
         Cj+C4RBRZf0GA==
Date:   Fri, 4 Feb 2022 14:09:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        skomatineni@nvidia.com, ldewangan@nvidia.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de
Subject: Re: [PATCH 6/6] spi: tegra210-quad: combined sequence mode
Message-ID: <Yf0zkdS2nqHOZjMG@sirena.org.uk>
References: <1643970576-31503-1-git-send-email-kyarlagadda@nvidia.com>
 <1643970576-31503-7-git-send-email-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a24AQkG5lH/zcdwt"
Content-Disposition: inline
In-Reply-To: <1643970576-31503-7-git-send-email-kyarlagadda@nvidia.com>
X-Cookie: Torque is cheap.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a24AQkG5lH/zcdwt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 04, 2022 at 03:59:36PM +0530, Krishna Yarlagadda wrote:

> +	/* Process individual transfer list */
> +	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
> +		if (transfer_phase == CMD_TRANSFER) {

> +		} else if (transfer_phase == ADDR_TRANSFER) {

> +		} else {

Looks like you're writing a switch statement here...

> +			/* X1 SDR mode */
> +			cmd_config = tegra_qspi_cmd_config(false, 0,
> +							   xfer->len);
> +			cmd_value = *((const u8 *)(xfer->tx_buf));
> +
> +			len = xfer->len;

> +			/* X1 SDR mode */
> +			addr_config = tegra_qspi_addr_config(false, 0,
> +							     xfer->len);
> +			address_value = *((const u32 *)(xfer->tx_buf));

> +			/* Program Command, Address value in register */
> +			tegra_qspi_writel(tqspi, cmd_value, QSPI_CMB_SEQ_CMD);
> +			tegra_qspi_writel(tqspi, address_value,
> +					  QSPI_CMB_SEQ_ADDR);
> +			/* Program Command and Address config in register */
> +			tegra_qspi_writel(tqspi, cmd_config,
> +					  QSPI_CMB_SEQ_CMD_CFG);
> +			tegra_qspi_writel(tqspi, addr_config,
> +					  QSPI_CMB_SEQ_ADDR_CFG);

It looks like the command and address have to be specific lengths?  If
that's the case then

> +	if (cdata->is_cmb_xfer && transfer_count == 3)
> +		ret = tegra_qspi_combined_seq_xfer(tqspi, msg);
> +	else
> +		ret = tegra_qspi_non_combined_seq_xfer(tqspi, msg);

This check needs to be more specific.  But like I said in reply to the
binding patch I don't see why we can't just pattern match on the data
without requiring a property here, we'd need to check that the message
is suitable no matter what.

--a24AQkG5lH/zcdwt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmH9M5AACgkQJNaLcl1U
h9CHWAf9Fv7WpqdKpI5qGpLRrspS+onHqhjxBDK3qP8XYNE8GGIoewvk/y93TrmP
PT7a/zw1UGFtvHomlXqcnvm7KxGfbsOr+JfBbWQ8hrddfbof84GSaWNyRiJl80Y7
gmMNPp1WfNen9c5z0wwyH0LS2c+6W4PdOwgipGoGQd4gh1vVzM1zRCja47CM1BD6
r8WiE3UnnBch6gpC20Ggrb4qjb2piUie7wAdBcvf8Ol9CCU8olylsE9mkE8yTPXR
5LJ02ayJG9HxTRxlhTG8zEGlhXTq/MI/is7a14BFQt2E3r92WqQBt26dp3jKcmlS
k9jlTRaQCxNF0WpexPzjM5jpjPZefA==
=0qb3
-----END PGP SIGNATURE-----

--a24AQkG5lH/zcdwt--
