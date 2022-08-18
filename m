Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFD3598727
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 17:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245314AbiHRPO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 11:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344220AbiHRPOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 11:14:07 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5EE7677A;
        Thu, 18 Aug 2022 08:13:59 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id s11so2257286edd.13;
        Thu, 18 Aug 2022 08:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc;
        bh=ak6VoRWkdz0wAJRTZihWKmIAiUucPH3suzIC7xhPgBg=;
        b=YhwF5my8oKHAKgLjVrjOXhNO1mO6H9mxRYS3RnlXaHcoBxDYUYs3lMnnV2iPJiofNj
         dnf/ZQ0wkWemACNxO6imWAszzi8y0q8WJYK5dCpjnYmfbSwh98N/k+URs1w+BgweX0pJ
         zhkHpnCb1EbeJaSxd/R1ClRjjjOXGG+iZ1e5VOIS/LVkEt1tc0s1f22JpBjY2iwAnZOa
         eoDbuehpyoegqyO+w7vNC0cK5jAIqfLiEistO39UXxGwDERJUzqMjYB8E+9CSHNr1qwC
         ld/h8WaeVOXUf4/87xDMZSqy7jq2mtCNZYcwxNmadePwM0OE6K9NT1JnFlIvsgadikw9
         VENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=ak6VoRWkdz0wAJRTZihWKmIAiUucPH3suzIC7xhPgBg=;
        b=cIO7R7kJg+y13TjMUHAh6aA3h3TpBsLsPQrWxQoZpxF7Y+hZ1LwPpqL/CCpLvjs6Gp
         VTZB/yrOyHlCgOTHVfh3DlrzVxIbYtTeeZWQwO+uyhahdxB54o1vXKMeE1KUU0vfM10+
         wRvesk0CSIpLYh9BEOtfVc+9uOm/krf4zFFCnwhEDUzK4vNG1kuCZxthR9+Kh+xbMI3I
         SbaTDGcHO0MYhWnhabtqOF4bhmp3pjcpvFkFQJJQtR9unT5oGvwhub+VODiVg9CCTgE0
         E2zqbmOMUIQf6aFuUlKLYkYq0NllB6hEPZohbkF17dGMtOwK2Vpgw0JZxx+0r5LbeUq7
         w9Rw==
X-Gm-Message-State: ACgBeo0d7KTCm575Tac8lQlZmL5ObxaKXsZQxvtnBjeCKVFjbowZS5CF
        fz+2I5oMJDYdvQY4k4brvJv/bf/+QkI=
X-Google-Smtp-Source: AA6agR7T5+XMSmyFLhCUexA63eyrSoX/TBnjRlKlpHoEJvTg6dviMeuqWl/1ihBenXDlkOH2GMc0PA==
X-Received: by 2002:a05:6402:5202:b0:43d:d2ff:5109 with SMTP id s2-20020a056402520200b0043dd2ff5109mr2621404edd.88.1660835637903;
        Thu, 18 Aug 2022 08:13:57 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id bv19-20020a170906b1d300b0073923a68974sm936864ejb.206.2022.08.18.08.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 08:13:56 -0700 (PDT)
Date:   Thu, 18 Aug 2022 17:13:54 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Petlozu Pravareshwar <petlozup@nvidia.com>
Cc:     jonathanh@nvidia.com, p.zabel@pengutronix.de,
        dmitry.osipenko@collabora.com, ulf.hansson@linaro.org,
        kkartik@nvidia.com, cai.huoqing@linux.dev, spatra@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] soc/tegra: pmc: Add IO Pad table for tegra234
Message-ID: <Yv5XMt5M7IGm4/Gx@orome>
References: <20220808201420.3451111-1-petlozup@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GqRZS6dITKd9nBWe"
Content-Disposition: inline
In-Reply-To: <20220808201420.3451111-1-petlozup@nvidia.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GqRZS6dITKd9nBWe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 08, 2022 at 08:14:20PM +0000, Petlozu Pravareshwar wrote:
> Add IO PAD table for tegra234 to allow configuring dpd mode
> and switching the pins to 1.8V or 3.3V as needed.
>=20
> In tegra234, DPD registers are reorganized such that there is
> a DPD_REQ register and a DPD_STATUS register per pad group.
> This change accordingly updates the PMC driver.
>=20
> Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 109 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 105 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index 5611d14d3ba2..34d36a28f7d6 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -266,11 +266,22 @@ struct tegra_powergate {
>  	struct reset_control *reset;
>  };
> =20
> +enum tegra_dpd_reg {
> +	TEGRA_PMC_IO_INVALID_DPD,
> +	TEGRA_PMC_IO_CSI_DPD,
> +	TEGRA_PMC_IO_DISP_DPD,
> +	TEGRA_PMC_IO_QSPI_DPD,
> +	TEGRA_PMC_IO_UFS_DPD,
> +	TEGRA_PMC_IO_EDP_DPD,
> +	TEGRA_PMC_IO_SDMMC1_HV_DPD,
> +};
> +
>  struct tegra_io_pad_soc {
>  	enum tegra_io_pad id;
>  	unsigned int dpd;
>  	unsigned int voltage;
>  	const char *name;
> +	enum tegra_dpd_reg reg_index;
>  };
> =20
>  struct tegra_pmc_regs {
> @@ -284,6 +295,8 @@ struct tegra_pmc_regs {
>  	unsigned int rst_source_mask;
>  	unsigned int rst_level_shift;
>  	unsigned int rst_level_mask;
> +	const unsigned int *reorg_dpd_req;
> +	const unsigned int *reorg_dpd_status;
>  };
> =20
>  struct tegra_wake_event {
> @@ -364,6 +377,7 @@ struct tegra_pmc_soc {
>  	bool has_blink_output;
>  	bool has_usb_sleepwalk;
>  	bool supports_core_domain;
> +	bool has_reorg_hw_dpd_reg_impl;
>  };
> =20
>  /**
> @@ -1546,6 +1560,14 @@ static int tegra_io_pad_get_dpd_register_bit(struc=
t tegra_pmc *pmc,
>  	if (pad->dpd =3D=3D UINT_MAX)
>  		return -ENOTSUPP;
> =20
> +	if (pmc->soc->has_reorg_hw_dpd_reg_impl) {
> +		*mask =3D BIT(pad->dpd);
> +		*status =3D pmc->soc->regs->reorg_dpd_status[pad->reg_index];
> +		*request =3D pmc->soc->regs->reorg_dpd_req[pad->reg_index];
> +
> +		goto done;
> +	}
> +
>  	*mask =3D BIT(pad->dpd % 32);
> =20
>  	if (pad->dpd < 32) {
> @@ -1556,6 +1578,7 @@ static int tegra_io_pad_get_dpd_register_bit(struct=
 tegra_pmc *pmc,
>  		*request =3D pmc->soc->regs->dpd2_req;
>  	}
> =20
> +done:
>  	return 0;
>  }
> =20

All of this looks "bolted on". Can we not instead rework the existing
register definitions to work with the new dpd_status and dpd_request
arrays? It means that we'd probably need a bit of duplication of data
since we would no longer programmatically determine the register offsets
like we used to, but it would save the extra flag and make the code much
more readable, in my opinion.

Thierry

--GqRZS6dITKd9nBWe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmL+VzIACgkQ3SOs138+
s6G1Uw/+Ifn5D/RMqFUWRn+dGPtPI7RrBqU6AfT+cwbtE1d3lT6RNgVpj+h+iZBI
B6JmgjQlIyfQQq22JCK78bQ8pwW6GXSCU1yvatJPYiwfzEu/w8lsZCCG4RkhYsjJ
1FNs+vIqnHvCu8/xOWiCbKwYjBX1xSndUVUeOcrJKpezNdC+KPjM21wavJsGUGFW
KNzR4kwpTBEdJ1Vb2CsI7qu2f7wy9DN34giYy2LAbyNQe/PYqVXffli2W9mSFXir
Qmr8PzzldfW41vJnbLp9FDIHOm5I9vjEVtQNKJhMfGEwLNYQJ4uuk2HU2yTE98yr
/i2SOlLi73oLoXHGfzwYeJBvkBr/8XlTpEqSX6RpaZBAVtfAkslVmWEQpubxN2u8
4DTd33Qzo9/ZNe3D4s1H8nFeadN0FpJmLbUC0Gzs2V7zR6U+ExTeg7o9u525lm8z
pRypv0n3BFI9YOu6AowgYEMaMIGTMNs+maQDyQUp2q7RS4G5KXeeDXdrPmv2hTwz
neMPtDqSKfL5NnTK35DgG6VK74O2wa4Z66+AvH52W5+C7zKt+VQ8muQdwmVpyUnK
lduzHIXbSBTEolP8TQQCgJEPx/n2DOh5bTitbQ8uBXbwKinKUHUhbIMUmKrEPIuX
lStgJQA8nlPmzh3myIIpc6DPFHApoGWyH4ikT8kMlrvCxQ8wcVA=
=61el
-----END PGP SIGNATURE-----

--GqRZS6dITKd9nBWe--
