Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C9C4C2DA2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 14:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbiBXNx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 08:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235084AbiBXNxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 08:53:54 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3B51592AB;
        Thu, 24 Feb 2022 05:53:24 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id h15so2934493edv.7;
        Thu, 24 Feb 2022 05:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nHQBWT7bMR5wypBGm4JCUtTL/BMR7BEQzX7N2vOiRk0=;
        b=MHyCpqm7LhNeCcxt7BnxbZIoCSpP08dDsWnxcgDlnQ8t3BQ/qTq1vIiuiJdh88bHoc
         tPdXdvmcNj0qunMPd6T9f+SuT80LI58qO2hxrTqt0IdSNZ2rxfd2mnA12G8QAdEPtczi
         FGxpnVBiWAGm5XzNJox1k0S8z8qKhPjX1YTGTker3+lamzvsLDqcDWY1cnQjlvY92M5c
         5/6jTWs64KKuTmnELTP2Og1U6gTfxKFwfEGBX7q4P2fAOqsbb2rOKKiQUY1+3IC2kJVc
         Pp7SqJPDlNW1RfJYxxpFK0uMZeAFyIjslsasUsEZF5qIdAlAmCyKqtu1KL1/tffmfwQk
         yELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nHQBWT7bMR5wypBGm4JCUtTL/BMR7BEQzX7N2vOiRk0=;
        b=H0ti8jfoYjEmgDtkkcLV33PIisjVmUmd0uOPWodUury7EBfjR41j7tgO5E2GMzLLMi
         QtpJzNJkqHs3MfHQefRbqKVfWSr6oG9rPqpib5VG27WSv7gN3bt2ClWse0/CFJTzf0CF
         iCzc3qFirZl67Rl1cv7pe8DL/bE+EVkTKH2t14c3jvVw7bGlPjBbqAfHSj0YYbh3jiTQ
         fOoY2YuI4aypiTU3q/Ie9e2PDFAouzCL7SqzfOJliRSPi2tBt3G9LHWrdfaShKkp+Xwb
         aqRIE9aD9GvtIROYpj1sWSi6WuHJlpY6asbAOLjGqy+9xs3RbX8DKJ71iaLIJbTMRD6E
         DGGQ==
X-Gm-Message-State: AOAM532ebD5rNvHYupVzItBb2byPzoGpYpr5Xp9koNVHAAoCgAA3+M4S
        S0rLF5E8Fba8c6Tt8gO4LJA=
X-Google-Smtp-Source: ABdhPJxO6b1Qr2Vfnt0T48wlIO/dpQickLsxM8qwxaA/5Ymic1hJ3VfNTRMVwTwNXSfyQsmfdnPDFQ==
X-Received: by 2002:a05:6402:b37:b0:400:500f:f26 with SMTP id bo23-20020a0564020b3700b00400500f0f26mr2339621edb.301.1645710803013;
        Thu, 24 Feb 2022 05:53:23 -0800 (PST)
Received: from orome (p200300e41f0a6900000000000000043a.dip0.t-ipconnect.de. [2003:e4:1f0a:6900::43a])
        by smtp.gmail.com with ESMTPSA id a10sm814444edf.14.2022.02.24.05.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 05:53:22 -0800 (PST)
Date:   Thu, 24 Feb 2022 14:53:20 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        matthias.bgg@gmail.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 2/3] pwm: pwm-mediatek: Allocate clk_pwms with
 devm_kmalloc_array
Message-ID: <YheN0IM8IhkMODU4@orome>
References: <20220214140339.112500-1-angelogioacchino.delregno@collabora.com>
 <20220214140339.112500-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="abg3CG3+/zIlkHwK"
Content-Disposition: inline
In-Reply-To: <20220214140339.112500-2-angelogioacchino.delregno@collabora.com>
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


--abg3CG3+/zIlkHwK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 14, 2022 at 03:03:38PM +0100, AngeloGioacchino Del Regno wrote:
> Switch from devm_kcalloc to devm_kmalloc_array when allocating clk_pwms,
> as this structure is being filled right after allocating it, hence
> there is no need to zero it out beforehand.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/pwm/pwm-mediatek.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Thierry

--abg3CG3+/zIlkHwK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmIXjdAACgkQ3SOs138+
s6E1sRAAu21195xMimQ2VWJzDrxG2ALsrIkkP1uWHyhSlzDSXfiCuUVHy7Fc5Gwd
cJTyXtpyIKLbS/5IPW4KbZvT6OSiUS34LD+pmutmhCOGs/xJ1Xp/+MR5cEBjMAWE
yVEovbAfpH36HARFwmypOPzi1jfgoj1TU7HF5ZXCdpRtzCxw1Yfq6d/9Z5p3ojN0
BoahKlQMja9vI8DkCNVWKOnMaKdIMuoEUHJIZTO0PEPyRfMm6FWWwTdEu4iEM4VZ
PJR0LIaYixQzvnr7XYaQfiY5YQWTiYDJpXI9zQEhpc5XA/m/RXdRqfmKFH9WedMy
odT//Yi5Ul+AmqU03cd5pBO6yB6fpAI3dv4X/LXifru394Penpr5rpT6Ds9fpyBX
x+phot/Vrw4Gbfk1OsQi7hDnWe4+rTC6O1dNPcMw+AKLZ2M5jQva3Pg9HBPqFq7u
a0RB+bPGoCmE5uBFpl/ra6D8SXDpioKbcF2WDUjgiUq+n9OZv7KCP3mowu46n1/Y
fCNi+27JRKDoScNTFzTujSFiDYBchRx212tkG2/FYQMFCed6xli6UEnHFGZuXuEY
uObog37ey7eGC2xI0+lU14PIpaUwo9DDpvfzdKFbiZ6N/ikm+TebMaLvphGkQfyH
uUt+cLuHT0OIOvNujBAwQDcd49ux+1qeIgV4O282f1CN4OtZeRY=
=t7QL
-----END PGP SIGNATURE-----

--abg3CG3+/zIlkHwK--
