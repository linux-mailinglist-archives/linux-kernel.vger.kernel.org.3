Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22640562E3B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235337AbiGAI3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235928AbiGAI2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:28:55 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3061EB88;
        Fri,  1 Jul 2022 01:28:54 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LZ7dc1Qwjz4xRC;
        Fri,  1 Jul 2022 18:28:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1656664132;
        bh=Vd2cdSFDHZEZx66FyAPMxjsbD/k2inzch+DwnzCClVI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jc1az3VuogEsnRDjsPkjnVjBF1neaY7ZYVHa6hNcsmYHHGtf3CXSugcs5DgxZ/Jku
         WLNRFbiuwlTee3CWHOATbuCjMqK6uFFnKGwhkYnsUe3Jci+lwF824BEdNi/Il7i35W
         MnMWnLqvfMhvg8vSqnGWIjlVXcDqYpvLebg+t9PXce+9xT7hRUoP+tAxj5Vh1dv3Vg
         n8sRnxhNtjwrCdGfHzo/HnbpYlSorAEPv/pWsWkMngSxWADlSAs9wJOE/m0cTgH/YS
         +qqZjZ3AID2vX0xFLK4xNTEoGg6uiR4tk3m4ib045XRR+3u4HT5UMFRPMyh8on38e8
         R/6pHub9cq/5w==
Date:   Fri, 1 Jul 2022 18:28:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the iio tree
Message-ID: <20220701182849.124d8cd1@canb.auug.org.au>
In-Reply-To: <20220701152944.27539407@canb.auug.org.au>
References: <20220701152944.27539407@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OiQI/TeD8owvQP0Gg12OcP4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OiQI/TeD8owvQP0Gg12OcP4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 1 Jul 2022 15:29:44 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
\>=20
> After merging the iio tree, today's linux-next build (x86_64 allmodconfig)
> produced this warning:
>=20
> WARNING: modpost: module qcom-spmi-adc-tm5 uses symbol qcom_adc_tm5_temp_=
volt_scale from namespace IIO_QCOM_VADC, but does not import it.
> WARNING: modpost: module qcom-spmi-adc-tm5 uses symbol qcom_adc5_prescali=
ng_from_dt from namespace IIO_QCOM_VADC, but does not import it.
> WARNING: modpost: module qcom-spmi-adc-tm5 uses symbol qcom_adc5_hw_settl=
e_time_from_dt from namespace IIO_QCOM_VADC, but does not import it.
> WARNING: modpost: module qcom-spmi-adc-tm5 uses symbol qcom_adc5_avg_samp=
les_from_dt from namespace IIO_QCOM_VADC, but does not import it.
> WARNING: modpost: module qcom-spmi-adc-tm5 uses symbol qcom_adc5_decimati=
on_from_dt from namespace IIO_QCOM_VADC, but does not import it.
>=20
> Introduced by commit
>=20
>   ec9b269f61cc ("iio: adc: qcom-vadc: Move symbol exports to IIO_QCOM_VAD=
C namespace")

This became a build failure in the arm64 defconfig build, so I have
reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/OiQI/TeD8owvQP0Gg12OcP4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmK+sEEACgkQAVBC80lX
0GxixQf+MKEsnWUTxwOjjV1OWp7ZHyrFoagrpW4eor5jSMiiULV94QQ7oxn4tcdw
+EOf0OrMyJW+UshiZTZFrD587pTZNBvUANHvjxNhreQ9WMEaiiLU3EBX6vJ+Z7LA
GJMtwKHs7dH96W+bBA73lLFBke6yLjuWjTwfsL3m8jK4fu10azRg3YI66YX8nD5N
igaShHH2bpB+PCDdft7UvnZ0TBmKXps7Yoyhv9CgmWlqOd3qa+dNJB0spuZBdl6c
SnTF4puaLXQdj5xk2wxp2XPwmJ65w/f34XARRB1vnFGFBh053PvckMoKLO9ohtlV
xOxLE+KE8jR5LkFhRTU2A/N3roN2gg==
=KqBo
-----END PGP SIGNATURE-----

--Sig_/OiQI/TeD8owvQP0Gg12OcP4--
