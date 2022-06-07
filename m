Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E9753FFCD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 15:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244526AbiFGNPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 09:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243382AbiFGNPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 09:15:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694D4F339A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 06:15:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0598D6136D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 13:15:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7292FC34115;
        Tue,  7 Jun 2022 13:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654607739;
        bh=Q9UeMbuKcKnRdtyrMieim/ypoyUhBKdyyKwPXKj3lTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oby/+sOw1HInv5QZ1mo40ncr/xAA2B89dlGQSSow4qzgfeooVsGwkWOQnrUCxC/TX
         c6FfTMIbXi4GFz9PfolKB1zYtDTOe/lmy93tOQfbXIKhhC4mHypmaIxzlYmrMx/IH4
         v/ML84/GqicbIkY2WUsb2KuW811IM/GH1ygzuG2r07k5TfmbgpQPvBLyrACaDz/RPT
         N5c/U5fJGE+n38hzkztR21iACLq2t4hPjeR0L7zCjQSwy9k1uawy2nrtL0eKgz7UYP
         DHn74UF1XXopEJRiZ4nN2ig6dlQ+LgoGfgCn2MgU7o8qybJuNrG9BjBn2n2E8QR/JR
         s8zcDYzuH87AQ==
Date:   Tue, 7 Jun 2022 14:15:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tianfei Zhang <tianfei.zhang@intel.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, hao.wu@intel.com, trix@redhat.com,
        yilun.xu@intel.com, russell.h.weight@intel.com,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH v1] regmap: add generic indirect regmap support
Message-ID: <Yp9PdZn2Xu/oqiA8@sirena.org.uk>
References: <20220607013755.594554-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ud64OMVfP0hcRpQO"
Content-Disposition: inline
In-Reply-To: <20220607013755.594554-1-tianfei.zhang@intel.com>
X-Cookie: Where's SANDY DUNCAN?
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ud64OMVfP0hcRpQO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 06, 2022 at 09:37:55PM -0400, Tianfei Zhang wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>=20
> This patch adds support for regmap APIs that are intended to be used by
> the drivers of some devices which support generic indirect register acces=
s,
> for example PMCI (Platform Management Control Interface) device, HSSI
> (High Speed Serial Interface) device in FPGA.

What is "generic indirect register access"?  I'm not clear what this is
intended to support...

> +static int indirect_bus_clr_cmd(struct indirect_ctx *ctx)
> +{
> +	unsigned int cmd;
> +	int ret;
> +
> +	writel(0, ctx->base + INDIRECT_CMD_OFF);
> +	ret =3D readl_poll_timeout((ctx->base + INDIRECT_CMD_OFF), cmd,
> +				 (!cmd), INDIRECT_INT_US, INDIRECT_TIMEOUT_US);
> +	if (ret)
> +		dev_err(ctx->dev, "%s timed out on clearing cmd 0x%xn", __func__, cmd);

=2E..and this doesn't look particularly generic, it looks like it's for
some particular controller/bridge?

--Ud64OMVfP0hcRpQO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKfT3UACgkQJNaLcl1U
h9BidQf+IkIlquE0S6OoW3iH1zUA7CLH2gTDIlN6mRlexJIF+FySYkuqKFEklPWb
ZLgnPTZACw1QW9kMna9oNRltHCL/6/M8d+tnD+wYAwHBWWCcX86td4i/iini59ad
dL1eTnaSR5C6uba0ArBuCsr4zHI0aCQgIKJTf2lJPt+aaAcGPdOEanLQjBkDh0vu
GLQHpsVvV1myPuSMXZncUIeK0x7f6PXBESELsnxcB/RdnnD2+Rrtq+KhwQ8mCZmM
l+y/Hnyts/aMsKzQ1L7YHdgAXT3Lx85j+QdQNWuNjnh4oJSDqlJiAxTqUhQy2Lne
vNJRYefW76T3bVHcG7izYWwEXq8Bfw==
=CMt6
-----END PGP SIGNATURE-----

--Ud64OMVfP0hcRpQO--
