Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203255840FD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 16:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbiG1OWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 10:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiG1OWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 10:22:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6306A46D81;
        Thu, 28 Jul 2022 07:22:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0BC18B82460;
        Thu, 28 Jul 2022 14:22:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4054AC433D7;
        Thu, 28 Jul 2022 14:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659018156;
        bh=1ZLap4eGsbbvgt1gdvMRC3A6YG6dEbs+KXGpBQ82L6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y5HXFfFEczrHiYs6Rl6biGP/3nCuiwwHhNo5YOCtuOoUXlh+PjOtaQvXtoOkqxEy/
         i1kASCXtevXkWsrAGL0cxLUWWREmlRmXZY1WbeqcUG8VJnmZrGEqioo4nk+iAPOQck
         AOYV4w1LOL/5SQKe9uWRhVHfF8SdK8J7GxXOrCCEpmHY1HC/IocRZQHLQEWh95XwY8
         lAJ83JrcqscTu9NY7kk1EBShHN3GDH7SbGq0lUUS/pqOlYpb8/j/wRoGvFJhTkh1+5
         AnYoV1tbRWgRTeRLTcHWbtgmw2auX5VDc/xWKUNGTXcEczX56KitMzAMmRHGtSIEWk
         PjpcEfcl4u7rQ==
Date:   Thu, 28 Jul 2022 15:22:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, quic_plai@quicinc.com, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        quic_rohkumar@quicinc.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: qcom: SC7280: Add support for external DMIC
 bias supply
Message-ID: <YuKbpXVOeGn2l2gd@sirena.org.uk>
References: <1659016789-9933-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MxtsZ/7dcBrss2UQ"
Content-Disposition: inline
In-Reply-To: <1659016789-9933-1-git-send-email-quic_srivasam@quicinc.com>
X-Cookie: People respond to people who respond.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MxtsZ/7dcBrss2UQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 28, 2022 at 07:29:49PM +0530, Srinivasa Rao Mandadapu wrote:
> Update SC7280 machine driver for enabling external dmic bias supply,
> which is required for villager evt boards.

> +++ b/sound/soc/qcom/sc7280.c
> @@ -356,6 +356,7 @@ static const struct snd_soc_ops sc7280_ops =3D {
>  static const struct snd_soc_dapm_widget sc7280_snd_widgets[] =3D {
>  	SND_SOC_DAPM_HP("Headphone Jack", NULL),
>  	SND_SOC_DAPM_MIC("Headset Mic", NULL),
> +	SND_SOC_DAPM_REGULATOR_SUPPLY("DMICVDD", 0, 0),
>  };
> =20
>  static int sc7280_snd_platform_probe(struct platform_device *pdev)

Don't you want to connect this to something?  This won't do anything
as-is.  I can't see any references to DMICVDD which might be failing to
resolve in the current sound/soc/qcom.

--MxtsZ/7dcBrss2UQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLim6UACgkQJNaLcl1U
h9Dk8wf+MsLnuYuJIjjPKX84On6/bVQTcNFnLcE6zWzTDjoWVmdWlUpcngQ1j7I4
mW5T0pKVL53Y8VcFCFuY5+awvsL3/tfCfKLpRjoRAhd1rG9kApq3RpgVyQ2OIR1A
ZbzfRK363FCoo/7EmnenWk/QH9u8jlNU7G5vfBcf8C2VOBwepUHt15YdW3xvHDtv
J0OyhPXNMuVCAGmhxTRc6ZbAxTbSu7R6u5aW0RquI+Ovfu6G/Hkcf2Yw0NYAd/Kb
RUP0UjIwsek2lGqM366yItV2PGLDjKNMHDtCZ7i07otKl5TrG5q2DsmY1M+yhnHF
2U9y6ryaWhXclqdx5B0vtki6mnCf2Q==
=Uifj
-----END PGP SIGNATURE-----

--MxtsZ/7dcBrss2UQ--
