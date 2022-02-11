Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A314B2908
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 16:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351365AbiBKPYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 10:24:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235355AbiBKPYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 10:24:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695EBD82;
        Fri, 11 Feb 2022 07:24:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2041CB829EF;
        Fri, 11 Feb 2022 15:24:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D89C340E9;
        Fri, 11 Feb 2022 15:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644593069;
        bh=XDskYT+gPzjRfk5oDbdrltedXVUeMzqmkjFFDGb6NLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BvpT7Oqvcfj4W8XiGWUycZmHiE3+Etza3fUd5xp8iddyoLealvqndsADzP2UgqpxZ
         gXh2j2xq76OojNzT7LTqG+HJDWzT7czRxj/id6794sYd6ipF26w03Zvgz8cneDMpGf
         9D2NV2IqSLW75FxIQQ4JAsazmCe5Lf80UZVOcMuDPfWoJQMUB+9ebkeyXT28ez2uPh
         zcAM7L1dsH/QiSktz4EXbvfPF27xiI6bG72oKHQsrq10o695oU7PlFeNTBWb7NF2lb
         yKEeRP8Y2nD1WJCYlf+J9H8pS+MGs+PGZxo9RsGaN6PSuuJ9bMigy/7usBecHoXVyd
         mD87gCcsvogcw==
Date:   Fri, 11 Feb 2022 15:24:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     lgirdwood@gmail.com, tiwai@suse.com, robh+dt@kernel.org,
        matthias.bgg@gmail.com, perex@perex.cz, p.zabel@pengutronix.de,
        geert+renesas@glider.be, trevor.wu@mediatek.com,
        tzungbi@google.com, zhangqilong3@huawei.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/15] ASoC: mediatek: mt8186: support tdm in platform
 driver
Message-ID: <YgZ/pzrJqvcAuzmE@sirena.org.uk>
References: <20220211103818.8266-1-jiaxin.yu@mediatek.com>
 <20220211103818.8266-10-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="N3h3NzMMytsYzN3d"
Content-Disposition: inline
In-Reply-To: <20220211103818.8266-10-jiaxin.yu@mediatek.com>
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


--N3h3NzMMytsYzN3d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 11, 2022 at 06:38:12PM +0800, Jiaxin Yu wrote:

Again, mostly looks good just fairly small and easily fixable issues:

> +static int mtk_tdm_hd_en_event(struct snd_soc_dapm_widget *w,
> +			       struct snd_kcontrol *kcontrol,
> +			       int event)
> +{
> +	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
> +
> +	dev_info(cmpnt->dev, "%s(), name %s, event 0x%x\n",
> +		 __func__, w->name, event);
> +
> +	return 0;
> +}

This does nothing, you can just remove it.

> +	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> +	case SND_SOC_DAIFMT_NB_NF:
> +		tdm_priv->bck_invert = TDM_BCK_NON_INV;
> +		tdm_priv->lck_invert = TDM_LCK_NON_INV;
> +		break;
> +	case SND_SOC_DAIFMT_NB_IF:
> +		tdm_priv->bck_invert = TDM_BCK_NON_INV;
> +		tdm_priv->lck_invert = TDM_LCK_INV;
> +		break;
> +	case SND_SOC_DAIFMT_IB_NF:
> +		tdm_priv->bck_invert = TDM_BCK_INV;
> +		tdm_priv->lck_invert = TDM_LCK_NON_INV;
> +		break;
> +	case SND_SOC_DAIFMT_IB_IF:
> +	default:
> +		tdm_priv->bck_invert = TDM_BCK_INV;
> +		tdm_priv->lck_invert = TDM_LCK_INV;

You should return an error in the default case rather than just picking
one of the behaviours to help spot any configuration errors.

> +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBM_CFM:
> +		tdm_priv->slave_mode = false;
> +		break;
> +	case SND_SOC_DAIFMT_CBS_CFS:
> +		tdm_priv->slave_mode = true;

We're trying to move away from these defines and the master/slave
terminology to talk about clock providers instead - the new defines are
_PROVIDER_MASK, _DAIFMT_CBP_CFP and _DAIFMT_CBC_CFC.

--N3h3NzMMytsYzN3d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIGf6YACgkQJNaLcl1U
h9DaCQf/cvTLimeQ43iRd7ilDTcJcq6Hgfgbl+cTNCLiaWII83oyeXd7E9t7kCj1
yTaVBO8XyWDCXM+lr20knToRa/o/RCYIRdIa4LB6fu5N320nPDlo6CVRunRk0mMv
CEReCuzQdXSuXB5ai3QIwPHSTYE8yPrc3Pf8+bCjJB1ZtyIBnVgk/LWg306IehOt
Xbu8BhYTof0YFIBtFsP2zpoyoUbchd3qAVlRX6TW3s2bwGDzpufHPKI+Kh6pzsc/
GBZN69zzjoSbFCCvGEp9E/5oC1DwbooP6sGa3lHTtHOQH9GP6MWJP3nSK0Uw+Qio
+YgeERJyMEZuXJEFexP5LD4mqotXGA==
=YiTK
-----END PGP SIGNATURE-----

--N3h3NzMMytsYzN3d--
