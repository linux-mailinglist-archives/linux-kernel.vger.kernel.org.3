Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27911545758
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 00:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345692AbiFIWWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 18:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245339AbiFIWWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 18:22:43 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135F6C3644;
        Thu,  9 Jun 2022 15:22:43 -0700 (PDT)
Received: from mercury (unknown [185.209.196.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C83A86601752;
        Thu,  9 Jun 2022 23:22:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654813361;
        bh=4ojQfcR5z+/HTet3CnjuXgxWI97MSwy0zDx1guio4o4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dbpQyQKM0jn2E52HdL9hUg4E2MXxfmoWAAf56+lpAhywa1pjncgkEn2hvkEeeOJBG
         rv8+lkUEYIQbcq+8Cm3vjhj7l8yMRW7Xoqg3RRKOTnpzdWwlOfO7SOSrg4R9/LYzr0
         +N9wI+pIik1xE9Rz9CKIIJdfM/h342lhCSByWbzCS0rX4+qo+6pBJsHi7LDsqZFwSs
         0S5EZT8+XLwVBs9ePdTx2XVaUqndkElMhfXoWdl/M6LTlENPz424DyECKT8C4Fvq7c
         8DZ0kIIuHMvjZ1N806aDkU/NGalt3QqE2n0yKBBgPfs+W3uXIKU8ueARckkrnxnhw8
         qtoLhMbj1WYPA==
Received: by mercury (Postfix, from userid 1000)
        id 1DCE110605B9; Fri, 10 Jun 2022 00:22:39 +0200 (CEST)
Date:   Fri, 10 Jun 2022 00:22:39 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Zheng Bin <zhengbin13@huawei.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gaochao49@huawei.com, Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH -next] power: supply: ab8500: add missing
 destroy_workqueue in ab8500_charger_bind
Message-ID: <20220609222239.5fssqczkdqy4inoz@mercury.elektranox.org>
References: <20220512093844.1109923-1-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="njbu6seuv6gscm5c"
Content-Disposition: inline
In-Reply-To: <20220512093844.1109923-1-zhengbin13@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--njbu6seuv6gscm5c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 12, 2022 at 05:38:44PM +0800, Zheng Bin wrote:
> ab8500_charger_bind misses destroy_workqueue in error path,
> this patch fixes that.
>=20
> Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
> ---

LGTM, but adding Linus to Cc and waiting a bit to give him time to
react.

-- Sebastian

>  drivers/power/supply/ab8500_charger.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply=
/ab8500_charger.c
> index d04d087caa50..a5d055a628e7 100644
> --- a/drivers/power/supply/ab8500_charger.c
> +++ b/drivers/power/supply/ab8500_charger.c
> @@ -3378,6 +3378,7 @@ static int ab8500_charger_bind(struct device *dev)
>  	ret =3D component_bind_all(dev, di);
>  	if (ret) {
>  		dev_err(dev, "can't bind component devices\n");
> +		destroy_workqueue(di->charger_wq);
>  		return ret;
>  	}
>=20
> --
> 2.31.1
>=20

--njbu6seuv6gscm5c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmKicq4ACgkQ2O7X88g7
+poAkg//Z0Z4+2U4rbm82Kb9faRGI41hH9iWXmcaQPtxIL/7eT5sv/15vghXtfua
Oy5Ubsepr22BDo/RPt5HRget2ByyMPzp8YCY6/n2L4sOgOFPGAeksInKhPHvEUA8
b8RfjOC8zivfuo+OcseOErHD1KK3vNoY8oL/wLdnhPwedQGQchG6tAEvJAp20FL/
C21L/27qmW4vVJ0CDiAlvxZ+3w3uXI4lCrnlpQ8Aq5Jo6RSOOPtCW11AEPWNVI7f
uVC/YiSyAihR6FFaMg6QQvJ7mwrC6fnfmm0e+fecwDcalpR+0smK19ScfY1QIOOr
jqGdtX8071LVsav/0ddk07VSc69DztcSUZvChpMDrfh8kE7oCVixGrqzQS9ONeVx
bwpo3HJpk7jYDSB0JXcV+//BIk1OikDCYgnB+Zl30GZIJsq9Q3qL7X4/spf6fsLA
ifA2atSwDXlhgHdX0P7c0a8jsCba70stxUkJa7I9rwVQffGTrGDZwzwwOKYq2aL9
e3fHH4qHD2GcOABJAblAXFI2ncuq/VHCLYVskPdFjRNQpbM8Tw7a5UrJR/D0FNj4
phCGzljQZtSvrHWwQv56g/qyFtHBm/DvngGbhZk+ZvvVUarhgio4g2KuOoI2lsiS
/k0pLNaKZUYDvmBhhz8GYzdPF0vXGhVSArX7wv7qRMNpvTgJvd8=
=sJbO
-----END PGP SIGNATURE-----

--njbu6seuv6gscm5c--
