Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D395798AB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 13:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237358AbiGSLl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 07:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235080AbiGSLl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 07:41:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587EF3F304;
        Tue, 19 Jul 2022 04:41:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE9A8615F4;
        Tue, 19 Jul 2022 11:41:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87CE0C341C6;
        Tue, 19 Jul 2022 11:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658230915;
        bh=v8PeHN2Ygs1u/dbSFwAhEUja3BF2PY9zOYVkyVdHkxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o6MNwPLlI3Ub9l2pHHovhTKP+I7WcOFoGXkzad+taoDaiJCfuEfnzALN3hRxXABao
         wozsBjs/4s2UdYn/+F4uOg84mWsIwPC8xTVVc7twH3IFUy37Qiv1jws9GJlfvBfYkG
         i2WYhyLJgVuRtB0rYLIEfPradMwFDelXJJAas0nWDA6qORk8BuvCGUnk7PORrJTAOl
         7vQWOKbMwF7YSPp4DLuL8byoxNFiNt6yM67UDQ8w3aU7ujvnQvB2gPGSfcKGxKXPUp
         +Hb6lI/2dCiiUunzHRCzVa9uJzZ0rV0VRMIZdZx2JE0M4/UPfWJk81CfhT+Uxsu70y
         YwH+wXFjBgAoA==
Date:   Tue, 19 Jul 2022 12:41:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, perex@perex.cz, tiwai@suse.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        shengjiu.wang@gmail.com, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] ASoC: SOF: imx: Add i.MX8ULP HW support
Message-ID: <YtaYe58xS4ynZ+A4@sirena.org.uk>
References: <1658208367-24376-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Gfkuz1LFkvb5qJgu"
Content-Disposition: inline
In-Reply-To: <1658208367-24376-1-git-send-email-shengjiu.wang@nxp.com>
X-Cookie: We have ears, earther...FOUR OF THEM!
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Gfkuz1LFkvb5qJgu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 19, 2022 at 01:26:06PM +0800, Shengjiu Wang wrote:

Not a thorough review, just a few nitpicks:

> +#define MBOX_SIZE		0x1000
> +
> +struct arm_smccc_res		smc_resource;

This should be static shouldn't it?

> +static void imx8ulp_dsp_handle_reply(struct imx_dsp_ipc *ipc)
> +{
> +	struct imx8ulp_priv *priv = imx_dsp_get_data(ipc);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->sdev->ipc_lock, flags);
> +
> +	imx8ulp_get_reply(priv->sdev);
> +	snd_sof_ipc_reply(priv->sdev, 0);
> +	spin_unlock_irqrestore(&priv->sdev->ipc_lock, flags);

Minor nitpick but a blank line before the unlock to match the one after
the lock would be a bit easier to read.

> +	regmap_update_bits(priv->regmap, SYSCTRL0, EXECUTE_BIT, EXECUTE_BIT);
> +	usleep_range(1, 2);
> +
> +	arm_smccc_smc(FSL_SIP_HIFI_XRDC, 0, 0, 0, 0, 0, 0, 0, &smc_resource);

You need linux/arm-smccc.h for this (as 0day said).

> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to init reserved memory region %d\n", ret);
> +		goto exit_pdev_unregister;
> +	}
> +
> +	priv->clks->dsp_clks = imx8ulp_dsp_clks;
> +	priv->clks->num_dsp_clks = ARRAY_SIZE(imx8ulp_dsp_clks);
> +
> +	ret = imx8_parse_clocks(sdev, priv->clks);
> +	if (ret < 0)
> +		goto exit_pdev_unregister;
> +
> +	ret = imx8_enable_clocks(sdev, priv->clks);
> +	if (ret < 0)
> +		goto exit_pdev_unregister;

We're registering the platform device before we enable the clocks - is
that safe?

> +static int imx8ulp_remove(struct snd_sof_dev *sdev)
> +{
> +	struct imx8ulp_priv *priv = sdev->pdata->hw_pdata;
> +
> +	platform_device_unregister(priv->ipc_dev);
> +
> +	return 0;
> +}

Could we just use devm?  I'm not seeing an ordering issue but I might be
missing something.

--Gfkuz1LFkvb5qJgu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLWmHoACgkQJNaLcl1U
h9C2gQf/cgh8vX+NSAVJKcFpo8TGYQkH6ILglXaaVQyN7G9PGgvBvaMK7gyCH2PS
eidTok4O5f6KCB3wDcLc9wIzO7M6K6iAlU/HTphK0wCizWtpEMZ+N9Hv20w141kx
O77/69rr687IfYRekqkka1438ED2L1AMYz/4bt3mDD/9XxuxLmKkZCvcCfyzgn8q
WyhbDCKNOgswfgyxEwMJecQ8wCS1amf99hx103P0xAejrT4V2uwdqptJ1AOz9dL0
iEp79naTEpE0uBX/4LM3bOTLaim1AOMOk3yPPaCBOIX8lu0QmapcXgigVt8iaQCM
PhxtfFs93bcc32VrmeqIXvWsCRF9fw==
=RXwS
-----END PGP SIGNATURE-----

--Gfkuz1LFkvb5qJgu--
