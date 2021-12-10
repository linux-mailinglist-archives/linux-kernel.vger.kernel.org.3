Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC59D4709CE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242169AbhLJTKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:10:12 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:57576 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhLJTKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:10:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 51551CE2D10;
        Fri, 10 Dec 2021 19:06:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F23C00446;
        Fri, 10 Dec 2021 19:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639163192;
        bh=a/eOKH9jFHnWsEPS7CpsX8vzNK7X917Ezfg3GYiV0zY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=as5br9jZ1hNRbJKnPfhz5/64PfYz3Pevbna7XhaZxnMZT1bKKSDgkrF58xqS75otx
         hBekW7imCkqTpMPlU3frScUWscSyPaiPFT1VmuUusv3IPfvuFYnbVZSTwkVS88Re4j
         rFPvqxPiWw4xVieHBDgptNtoB/7xW+Dzu7K+REAApLeuf/SajD2Iu3ivIInJcBEspu
         L/vk8KS3tka7Xll6EAQc9AShPtA+qRPvUg3vsXJ/gl2goxh6yC+8pPrQp94Cvgo4r/
         Gh6pgd+IF//r1znw/oDUpnlRnp6qlh1vAo7MOCatCXWRbCPunM7dvaf2naCANtBIw4
         DJwVbpgzypT8g==
Date:   Fri, 10 Dec 2021 19:06:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [RESEND, v9 06/10] ASoC: qcom: Add regmap config support for
 codec dma driver
Message-ID: <YbOlMdiRc0Xirajz@sirena.org.uk>
References: <1638800567-27222-1-git-send-email-quic_srivasam@quicinc.com>
 <1638800567-27222-7-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WSzyGP1U7OF5nLGs"
Content-Disposition: inline
In-Reply-To: <1638800567-27222-7-git-send-email-quic_srivasam@quicinc.com>
X-Cookie: One picture is worth 128K words.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WSzyGP1U7OF5nLGs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 06, 2021 at 07:52:43PM +0530, Srinivasa Rao Mandadapu wrote:

> +static bool __lpass_rxtx_regmap_accessible(struct device *dev, unsigned int reg, bool rw)
> +{
> +	struct lpass_data *drvdata = dev_get_drvdata(dev);
> +	struct lpass_variant *v = drvdata->variant;
> +	int i;
> +
> +	for (i = 0; i < v->rxtx_irq_ports; ++i) {

> +	for (i = 0; i < v->rxtx_rdma_channels; ++i) {

This is looking relatively expensive to run with all these loops -
there's a reason these are normally written as switch statements, the
theory being that the compiler will generate something at least as good
as any data structure we're likely to code.  It's not a *problem*
exactly, but if you're doing anything that ends up querying properties a
lot it might be an issue.

--WSzyGP1U7OF5nLGs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGzpTAACgkQJNaLcl1U
h9BOWAf+MVXmAYTXdCSSLIWm9urbvgPo+9iMFnLJXtBKu9dWuX1r3zSzZP9eO4dJ
MGGQvq0wylkBP+CxyNf8IrJX0YN/KUnh/C3pE21qQj6VQkBjUlIs6MWkGqXsob7r
zICYs1btoqDSkkOsnlvpjoWLROOX6egusSYw7p02SaA2hKfSQfoCcGLP5GSZiiF6
2TwHuFDB2Iu9qT+hf7BBHNAHDFU9BJJZB5EJwXdjC538fI/QlCKk4ARDllzVMk8H
oy3Enodc2t+Xgg3E7r4Ea/7BE8sSex8zFHaoyNMlYpYelFzBFIPuiAw1SH5sN3I1
Sh9cfGTfvBJ1VVRedUc0Ly4ssXuj0g==
=inw7
-----END PGP SIGNATURE-----

--WSzyGP1U7OF5nLGs--
