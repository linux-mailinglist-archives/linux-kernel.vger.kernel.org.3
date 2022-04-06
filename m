Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAB64F63AD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236684AbiDFPs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236981AbiDFPr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:47:56 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D9A1777D3;
        Wed,  6 Apr 2022 06:05:43 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id c42so2554402edf.3;
        Wed, 06 Apr 2022 06:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rRgvDvUl61lh/9aR+IEBANuvNM3XJ42a6XvezLdfwRU=;
        b=lixNMfphu5wieSYGl6MVv8y2FmGyKF+QcsLRnOA39qbrvyRaZZiPTBPD63KdIh0XF9
         Q5OFTMVs2UwQV4H8lGygQfhlRCHyqOoXqjG0uTrCzH6am5wZuYHwq30vataSspRkw8wk
         GfEzJa+pYbyR07MrrFHtTogDceGeDDMpxCdRK1k3IjBBGm4sEMF/1/d/ed1QSgCvL+Fy
         x1jQhISCNhFS4k6JmeW/Ab7F3tpNF1zFR7VfQVYm4oqQmOG7jMbgpCtrKpkn3fUHa1Ah
         Xwbt+NGGGTPO4hQBlf9hgCD7ajwps0XGrKXgrhwfIMep1jVaVqvbFn5VoKomgAYqrpk1
         tFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rRgvDvUl61lh/9aR+IEBANuvNM3XJ42a6XvezLdfwRU=;
        b=Yuf7aZDmy8Z93pdX3xK/VV9Z/Eu3l1BkjTzRJA3o0rzHMCqSw3cr5NAwDzhS+MT9Yg
         O8wgjW6kz4dIqld7Rl+DQrNgJcLuQT3V/tf8BbYQpVD+sTantRutVbviE+2KcWAwUSAB
         eEOS4dSl6Jxu3MuQS2ffjR7eC4DKfhpd85fj7CCJdbh6TH0UHOkMBWJMnuMnoU4JM2EO
         lnK/bgUYc9l4pNm/S2qBcwARAdvAzGfUDjKoF5MvblCha99RuVqFQLbCT6lFNJ6GqxPV
         Ol6rzY7auxPw9enUBeFyY72PrmUguaMzyhbsJKMoyEIP2Ah0llIUkxrrpFNsjvP1BHVS
         Ieog==
X-Gm-Message-State: AOAM532Wko6rA0uNQt0iwxZDeFGhWjc5cteDpa8YjbyzKBzAdLZouc+o
        nHQmTK6QqqbrTjPpL+10YP4=
X-Google-Smtp-Source: ABdhPJxfGL+4HXovbKpvohbOmZMjgz8AFTIA1Few84ESiJrv1iDbviCKpGxfjgCU+0BVrRfnvH725A==
X-Received: by 2002:a05:6402:27d1:b0:419:1b02:4a04 with SMTP id c17-20020a05640227d100b004191b024a04mr8629924ede.218.1649250342056;
        Wed, 06 Apr 2022 06:05:42 -0700 (PDT)
Received: from orome (pd9e518f7.dip0.t-ipconnect.de. [217.229.24.247])
        by smtp.gmail.com with ESMTPSA id p13-20020a50d88d000000b0041cd1a083f7sm4409601edj.1.2022.04.06.06.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 06:05:40 -0700 (PDT)
Date:   Wed, 6 Apr 2022 15:05:38 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sandipan Patra <spatra@nvidia.com>
Cc:     treding@nvidia.com, jonathanh@nvidia.com, digetx@gmail.com,
        ulf.hansson@linaro.org, andriy.shevchenko@linux.intel.com,
        cai.huoqing@linux.dev, bbasu@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch V3] soc/tegra: pmc: update Tegra234 reset sources
Message-ID: <Yk2QIgXZ4PJqRUP4@orome>
References: <20220401143343.31989-1-spatra@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MfVVcTOm47LLmQ57"
Content-Disposition: inline
In-Reply-To: <20220401143343.31989-1-spatra@nvidia.com>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MfVVcTOm47LLmQ57
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 01, 2022 at 08:03:43PM +0530, Sandipan Patra wrote:
> Reset_sources list is updated to add all reset sources
> and removing ones that do not actually exist.
>=20
> Signed-off-by: Sandipan Patra <spatra@nvidia.com>
> ---
> Update on V3 patch:
>     Added more frequent comments to specify every 8 offsets
> Update on V2 patch:
>     space inside comment and
>     Changed decimal to hexadecimal notation in the comments.
>=20
>  drivers/soc/tegra/pmc.c | 33 +++++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)

Applied with a slightly reworded commit message.

Thanks,
Thierry

--MfVVcTOm47LLmQ57
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmJNkCIACgkQ3SOs138+
s6HEjg/+Mywelqh3TVqCKMxiiUC4Nm4Ez4n8yJAml+HFmLDyiz0BewvBI328BwgK
AF3hUfZvAZN3Czotjy7MijRqdkX7V8OYiAPjf3WlbJ9BAl8RXLFImh0FoXjvlXOZ
fgTexk+1b3i+eGUQYkEvvD+CCS1EDdXVquiolp/A0bQm5GEEaOK0M1n1sC5rc/5r
ubrxUF/dNz++Q/DNRzl+xzt63uqhBCu4c19VMMcGpdj+vCBmjX47zWmkt1Ol0aHV
EEG43nzEXDw2VawgHJGGsksaozeiGFwXZz0pYEfzgcRgSbjsw3AGrr2obG6pX6pE
/6wUs0U+UA4hVi/QMFNUhuuLyI10Tcy6r2zH/03oh8L13+dhzj+3KdOdgVPNhDAf
JqF4xBJm5ZIuU5TvxspbVlEujeVL/7+hDDLhfN2y7F8ASNhtNAyJEFLWPzDmDYGj
+EsV6MkE85MN2UYHyKTceNMvNZZa8Lpv7X2C8Iv0Bsv336Quc3fissM4bU9DRrTC
Wz4UWzk3h5H1O6l9tZAnySZUppDwMX6K6+bmAiOCGpH+pPMLgilS8g0TXaQ2o1Va
MzJ+bGxjV2DzfMMLUMB85ZvV0Snrx1ScfgdGpGVSyfeiiaail76xtVF0w0V0WKHC
/PjKw/BK9txMlOg+404ltVTwC5+1iugKdXTJkXirziib2lY+io4=
=luRr
-----END PGP SIGNATURE-----

--MfVVcTOm47LLmQ57--
