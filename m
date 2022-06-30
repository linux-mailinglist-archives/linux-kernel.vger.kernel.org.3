Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6D956186B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 12:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbiF3Kiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 06:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiF3Khr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 06:37:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF1C52393;
        Thu, 30 Jun 2022 03:37:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 109F96224C;
        Thu, 30 Jun 2022 10:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E296C341C8;
        Thu, 30 Jun 2022 10:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656585449;
        bh=iIKs3rpaYPtUZ0eaoQBogoq+V5pKpR1jkSxXnpou/3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ke/h3lcPOMIcjmkXSDygaQX/fBnyA5e1eEEUNs8qdP9Dwt+FEhhFsyDc8q1vNT0Wi
         ZIAz4B4huhN4ynq/IVmE8WlnX4UCtgS1koYpNof7PCbUhFM8wlBkAcGs/ex+wRYFRM
         S92Z1bjJKrpgkGsSruKC+H++8Nm4+A5xlLWUnqFMDshpvkdFrdj8wqY1Lf0kJwYwFB
         C3zKHGEVhlMmTkVPMtdbUdFuXQhh/6kNFUq5m0b8uTvTMmZfw96hg/3oUfCHHasld3
         Ve3kCsGl/H4yqXC4WwkFjIVNwlEYa8smOf70ranpv+Vgr465CwFtphi5HVMHjQx4rM
         eyCO2Y7pbAvcQ==
Date:   Thu, 30 Jun 2022 11:37:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] ASoC: fsl_micfil: Add support for PLL switch at
 runtime
Message-ID: <Yr1842e42P4piYnE@sirena.org.uk>
References: <1656567554-32122-1-git-send-email-shengjiu.wang@nxp.com>
 <1656567554-32122-4-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SDyGFineERFKDrrR"
Content-Disposition: inline
In-Reply-To: <1656567554-32122-4-git-send-email-shengjiu.wang@nxp.com>
X-Cookie: Today is what happened to yesterday.
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SDyGFineERFKDrrR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 30, 2022 at 01:39:11PM +0800, Shengjiu Wang wrote:

> +static int fsl_micfil_reparent_rootclk(struct fsl_micfil *micfil, unsigned int sample_rate)
> +{
> +	struct device *dev = &micfil->pdev->dev;
> +	u64 ratio = sample_rate;
> +	struct clk *clk;
> +	int ret;
> +
> +	/* Reparent clock if required condition is true */
> +	if (!micfil->pll8k_clk || !micfil->pll11k_clk)
> +		return 0;
> +
> +	ratio = do_div(ratio, 8000) ? CLK_11K_FREQ : CLK_8K_FREQ;
> +
> +	/* Get root clock */
> +	clk = micfil->mclk;
> +	if (IS_ERR_OR_NULL(clk)) {
> +		dev_err(dev, "no mclk clock in devicetree\n");
> +		return PTR_ERR(clk);
> +	}
> +
> +	/* Disable clock first, for it was enabled by pm_runtime */
> +	clk_disable_unprepare(clk);
> +	fsl_asoc_reparent_pll_clocks(dev, clk, micfil->pll8k_clk,
> +				     micfil->pll11k_clk, ratio);
> +	ret = clk_prepare_enable(clk);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}

Seems like more of this logic could be factored out into the reparent
function if the target sample rate is passed in?

--SDyGFineERFKDrrR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmK9fOIACgkQJNaLcl1U
h9C68Qf/YX1eL795b+XK2iAIiNLwaLomwMbw0JjNUWxPZS3+wkMhyqOfDxWfq52s
WZkSoJ7vyDPSIr7R5nCH7QFdwdgdLqck/2GSAaPUndpELFvuLqME+nElf2OlYx6l
nq33cMqc0OZlIpM757VsPYN6IPPq87rPXI030XM4lmOxzhvV1gE0195pRFSiyiCl
dWiddG47/R+cRgjm6LaGN0kkVTLWdj16f5E7zlz2VDse8I/CR5w7/U9hQ0yfE/Rr
oJtQi+ybrw26ELGPHDP/2yljgWzaCuc/+BllHMwQeoTYgjuu+nxpX8m6B5ToffUT
RpPmDmKDRpeFSTwxqqUVNwCPjHNjqQ==
=Zj5G
-----END PGP SIGNATURE-----

--SDyGFineERFKDrrR--
