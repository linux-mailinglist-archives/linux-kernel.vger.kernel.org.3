Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CFA54C7A1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244420AbiFOLkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239495AbiFOLkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:40:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D223BA75;
        Wed, 15 Jun 2022 04:40:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CAD7CB81D3D;
        Wed, 15 Jun 2022 11:40:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5434C34115;
        Wed, 15 Jun 2022 11:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655293236;
        bh=c9LwFamlPa1D8V1sZLBEkf4pM/MqJNHV89bpUyEU7uA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H+RFRPppcy1a28sljuQ1Co2c9ibvyU/sWSg8nlItYnctF1OdfXwHftQhEs+qFAwQW
         IGEFDOvp7Muc1EKOwaR4zPtdq1pS+sXGX3purxr9xPgU5TzmfRc7vdhl2Os7wHryOM
         8fcLT6SxChIT0uAcvgWkn9hturu1pOi5lnfB+cG3lHQOvcRw9QCOHv6GbtVlYLPqXl
         lu5AMgm/2oBwOBbZoJ8fAPAkaDk8J1ymmO4QfdFL8kOC2pjA1GX//v/RTYsS0qCu/s
         l6Gof/hBx2UWum6V5+L4S/z4nY9Wcv+r91/ZHexP8N1lGwKaMW7zWGmpupu6mZPUKk
         PYnfJbqhg/GwQ==
Date:   Wed, 15 Jun 2022 12:40:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        Lewis Hanly <lewis.hanly@microchip.com>,
        linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] spi: microchip-core: fix passing zero to PTR_ERR warning
Message-ID: <YqnFLCbvrTxNbG1+@sirena.org.uk>
References: <20220615113021.2493586-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8+J4iCROf2wQYOpl"
Content-Disposition: inline
In-Reply-To: <20220615113021.2493586-1-conor.dooley@microchip.com>
X-Cookie: byob, v:
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8+J4iCROf2wQYOpl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 15, 2022 at 12:30:22PM +0100, Conor Dooley wrote:

> -		ret = PTR_ERR(spi->clk);
> +		ret = !spi->clk ? -ENXIO : PTR_ERR(spi->clk);

I think you're looking for PTR_ERR_OR_ZERO() here?

--8+J4iCROf2wQYOpl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKpxSsACgkQJNaLcl1U
h9CxIgf/ZBgBD/a8d3ZYTzeipg8kZos1C5nMoiIH0fuch+YgZYCYBW0Icy3Vp34p
skKNBOlfkNEIRJ6TsbBSdPYsw6nIa3VNBfEDZxhEw06al/UOkFtgJS37koJ84AqT
C5RPaINztbs/cty23aLR2d3HTTzhpGJn0u/87wR924y6XA7RimsmcXXfxn6dVzq9
n7qlX5OV/XQaaeNkR0h1vhCHipEr2TmUroJnzPliCLUk5/wqIiRO3SDMxr/dhAae
QnxfgMXFjfmoKwAuAKyn8Q9FbeOe2jsUqvk06EWMEgeQXGm4ucvMMT8dDXDoFoDD
9lVReVb05x71sJsOhIkMp9Fz/tIQaQ==
=N5A0
-----END PGP SIGNATURE-----

--8+J4iCROf2wQYOpl--
