Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F3E5B23B0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 18:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiIHQgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 12:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIHQgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 12:36:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE10D570E;
        Thu,  8 Sep 2022 09:36:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 957A6B818B5;
        Thu,  8 Sep 2022 16:36:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8FEC433C1;
        Thu,  8 Sep 2022 16:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662654994;
        bh=z+EAy5tr+0u3cXH5bl2QTwxzn2sBd84H77A80gvaElU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=alCtEdhdRgiGW9ouvPeAWzLHKBgiFcKflgrGN4umL8ZgvwlCt/vuOHyxMsZlaOknf
         6r9awQI3KJ/7JMagoAP2TYbUZN+ihpRJrrqBzXa0775dC/zJbek88ugWWH8ijBKMDC
         SUC1n4tLJ6YaGJCuyYtOMcnKMI3iUxNLqChE4V+nIxwxlaG4jwtRkgHCczbCOAEqhJ
         JjMm9OSWn4KDv5OWHKig1nleHbxkCmn3AcoAW7Wg6MUXy6vvE+a8ecf7NZ12roYK26
         S6toLc9x/ERxzgQLxng2NdgAf1E69bbExqT0yMCbsK+y0EZw6pF++kBtjsMRAhrnVB
         MjlSz3kQONVtA==
Date:   Thu, 8 Sep 2022 17:36:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     luca.ceresoli@bootlin.com
Cc:     alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 5/8] ASoC: rockchip: i2s-tdm: Fix clk_id usage in
 .set_sysclk()
Message-ID: <YxoaC5OAv/oES+jQ@sirena.org.uk>
References: <20220907142124.2532620-1-luca.ceresoli@bootlin.com>
 <20220907142124.2532620-6-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n9PmSJv+Ru1ZxyoW"
Content-Disposition: inline
In-Reply-To: <20220907142124.2532620-6-luca.ceresoli@bootlin.com>
X-Cookie: Metermaids eat their young.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n9PmSJv+Ru1ZxyoW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 07, 2022 at 04:21:21PM +0200, luca.ceresoli@bootlin.com wrote:

> -static int rockchip_i2s_tdm_set_sysclk(struct snd_soc_dai *cpu_dai, int stream,
> +static int rockchip_i2s_tdm_set_sysclk(struct snd_soc_dai *cpu_dai, int clk_id,
>  				       unsigned int freq, int dir)
>  {
>  	struct rk_i2s_tdm_dev *i2s_tdm = to_info(cpu_dai);
> @@ -978,15 +981,18 @@ static int rockchip_i2s_tdm_set_sysclk(struct snd_soc_dai *cpu_dai, int stream,
>  	if (i2s_tdm->clk_trcm) {
>  		i2s_tdm->mclk_tx_freq = freq;
>  		i2s_tdm->mclk_rx_freq = freq;
> +
> +		dev_dbg(i2s_tdm->dev, "mclk freq: %u", freq);
>  	} else {
> -		if (stream == SNDRV_PCM_STREAM_PLAYBACK)
> +		if (clk_id == CLK_IDX_MCLK_TX)
>  			i2s_tdm->mclk_tx_freq = freq;
> -		else
> +		else if (clk_id == CLK_IDX_MCLK_RX)
>  			i2s_tdm->mclk_rx_freq = freq;
> -	}
> +		else
> +			return -ENOTSUPP;

This should be a switch statement for clarity and exensibility.

--n9PmSJv+Ru1ZxyoW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMaGgoACgkQJNaLcl1U
h9AUXwf/Ybq47bEk4QDfoPEAToGlvieUKHsFJ8BDFyusjrLmwXm1GWgzWOuF7VuB
rAHrRYsRWOIXHMW6oVOf+Zlll9w1n292d2eyelotnTsvAAgBi/vG6g4OmOtTD3I9
W9rPB2x+xkR2rz/sQd/hbGxPxa6sU0ymEX5ScOuA9NejRSr3Y0t/GgY3LWOCKJsC
2U9Oj5P/qX4qPDo/6Qf7ybfVr7jXwWsatgIzX5DyRpbKbvk9JbDMv5dssp9VStUU
Q998qqb8+Reec2p62tuZd8JpotC3OVhkiSTcHeO0UCgcuLCz+QQ3PPxgESe9BQWG
wUSmVEs8J1Ushh+d+5shIT+ZQyBApA==
=MFhn
-----END PGP SIGNATURE-----

--n9PmSJv+Ru1ZxyoW--
