Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F14513367
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 14:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346071AbiD1MRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 08:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346043AbiD1MRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 08:17:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AE6AD11B;
        Thu, 28 Apr 2022 05:13:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35F48B82BBF;
        Thu, 28 Apr 2022 12:13:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D50C385A9;
        Thu, 28 Apr 2022 12:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651148034;
        bh=vxjMPjiYyFGhSMcGT25wyA/WTwatpL4xQZLW21y1LrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CZ6V0X68DhdaTkp6BMzGTX1rWbkZ1DzkL2YhYLd502WaLC5hwoO4uMqjMlVQlu898
         yTH+GdehFwnErraXDMs8PVMX4Ha7/ae6hCmg8SHgzegUoSqyvR7RBqyoEq4QZo31zL
         2PVwD+W7KLhSKfZW8BxscVA/BHixp+9TiSPUUBvcJ4PZP7u0b0z5zUHdWq+gGArmoF
         kcs73wCOduTNJz5pS2rtOBXp1/eEd0ykp1evkbcjfN8BAUC3UiiZktAJWVeIEpuC5a
         0OzZZsLv0dTEuYuSJUffm9lb6Gr1CT/f+naBJKllxKJED3w2hUgx0b4PkL2nFRArvv
         PLwyVC3QwZCnw==
Date:   Thu, 28 Apr 2022 13:13:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     robh+dt@kernel.org, angelogioacchino.delregno@collabora.com,
        aaronyu@google.com, matthias.bgg@gmail.com, trevor.wu@mediatek.com,
        tzungbi@google.com, julianbraha@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [v4 07/18] ASoC: mediatek: mt8186: support i2s in platform driver
Message-ID: <YmqE+80xyBoIJvto@sirena.org.uk>
References: <20220428093355.16172-1-jiaxin.yu@mediatek.com>
 <20220428093355.16172-8-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qf2Y0CXE7QOl/F3W"
Content-Disposition: inline
In-Reply-To: <20220428093355.16172-8-jiaxin.yu@mediatek.com>
X-Cookie: Bedfellows make strange politicians.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qf2Y0CXE7QOl/F3W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 28, 2022 at 05:33:44PM +0800, Jiaxin Yu wrote:

> +/* clock source control */
> +static const char * const mt8186_i2s_src_str[] = {
> +	"Master", "Slave"
> +};
> +
> +static const struct soc_enum mt8186_i2s_src_enum[] = {
> +	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(mt8186_i2s_src_str),
> +			    mt8186_i2s_src_str),
> +};

Not clear why this is user visible?  Shouldn't the machine driver be
setting this.  Also please use more modern provider/consumer terminology
for the clocking.

> +static int mt8186_i2s_hd_set(struct snd_kcontrol *kcontrol,
> +			     struct snd_ctl_elem_value *ucontrol)
> +{

> +		return -EINVAL;
> +	}
> +
> +	i2s_priv->low_jitter_en = hd_en;
> +
> +	return 0;
> +}

Same issue as on the other patch with the events - like I said there
mixer-test will find a bunch of these issues for you.

--qf2Y0CXE7QOl/F3W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJqhPsACgkQJNaLcl1U
h9DxEAf7BCZnRGuhD7QVceeLK9ft/+r5G6bcDYr/AzaD0m2ib8uHS9gAD2tNCPzS
hqNii0XqfHOk8qRHngTUCf2jArvOxs/04PUbVN9osjE3US4GasV3r5A2mjdH5Xjb
YfmoJbCF/LDmP3if9QwJkJEPJ13sqaEQLbO6MKBn9H/iMDXQGzXtLT+A/7vFmnlz
5Z4kFX2c+4/M3Kkh/tL+5mAWE42SYETASHjOFnvFvK8EyRsHraxWahmN7Q1ZlcIb
O/hK/hlH53YEyBysNZ4WG7U3CHHIJdf7XUN9/akMdwFo69exz+qHy2PItw6cix2Q
B26GhDB6BEav6uk7TLEz59R0iKw+eQ==
=QnX1
-----END PGP SIGNATURE-----

--qf2Y0CXE7QOl/F3W--
