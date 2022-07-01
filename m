Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3282D562ADC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 07:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbiGAF3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 01:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiGAF3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 01:29:51 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A7E237D4;
        Thu, 30 Jun 2022 22:29:49 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LZ3fz3hyGz4xNm;
        Fri,  1 Jul 2022 15:29:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1656653387;
        bh=yO7U50FuGxvQ+IJZE2lrmewaL76MQKHJCUlBhtTpdx4=;
        h=Date:From:To:Cc:Subject:From;
        b=g9x5m5YwfgYrT6TcWSCqGfnSUGO1P8zOFU++1jhjh5PhMoxBDx2ZpL/Ygzf+pVBSB
         NLIY/LRp1+tv0ZWF7eQN6+DrYbO5eMbhHCoCR1VGFegDrW+/kaSYekjJ681Zx98Kfc
         CTTvNGeMzEMzT6T4LfQBcvjrtPGU7BC1zKizlO45Gq8pMTvnkJnq9caAmDO73oYjHs
         FGULmL9k91IbYC989/nHOAxni1eJGB+md0gEWPTyvFhxGVrx05YsxAvwn8RZM0+Dm3
         6OzdLobQjxqhDLiO3Xk0rUl0H1OkS5hC+Mcs+/c8LMNi7IUWL19I4ziW/JKrla2hR5
         E9M7RiAACZWVw==
Date:   Fri, 1 Jul 2022 15:29:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the iio tree
Message-ID: <20220701152944.27539407@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PzvbuER6KufoY9yXlj6Gzkp";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PzvbuER6KufoY9yXlj6Gzkp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the iio tree, today's linux-next build (x86_64 allmodconfig)
produced this warning:

WARNING: modpost: module qcom-spmi-adc-tm5 uses symbol qcom_adc_tm5_temp_vo=
lt_scale from namespace IIO_QCOM_VADC, but does not import it.
WARNING: modpost: module qcom-spmi-adc-tm5 uses symbol qcom_adc5_prescaling=
_from_dt from namespace IIO_QCOM_VADC, but does not import it.
WARNING: modpost: module qcom-spmi-adc-tm5 uses symbol qcom_adc5_hw_settle_=
time_from_dt from namespace IIO_QCOM_VADC, but does not import it.
WARNING: modpost: module qcom-spmi-adc-tm5 uses symbol qcom_adc5_avg_sample=
s_from_dt from namespace IIO_QCOM_VADC, but does not import it.
WARNING: modpost: module qcom-spmi-adc-tm5 uses symbol qcom_adc5_decimation=
_from_dt from namespace IIO_QCOM_VADC, but does not import it.

Introduced by commit

  ec9b269f61cc ("iio: adc: qcom-vadc: Move symbol exports to IIO_QCOM_VADC =
namespace")

--=20
Cheers,
Stephen Rothwell

--Sig_/PzvbuER6KufoY9yXlj6Gzkp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmK+hkgACgkQAVBC80lX
0GxlLgf+J0xlGuVhnfZidfTbrm4YIO17I37D2vGzpGRTKf+ggym+TNTsRhY9yUjw
K6EZRCU9VCkAi3LuHy7CQld6iwbZRMQ+bc/WWFUnTKuBsb3RAKOly1KA1KTpAkcI
7Yyw5nUUnbC01cdI/ENDz92Opy0AhB2FRyOJFO5GaBoKh1Cf94GNKVKYwq+jIEKe
sy5wvTrTfL+UvjNxCp5Qu60COIU9R8vOUXvDGhZbNfTfj9fjjOMw+BoywmTy6mF6
XdJ83O8k9WOjMNLZPFhiwUOSVQDEogTwAqUBEvSMcW1dqUOWqTfYfn0j/iFJoLjn
p03KP+syb7JJqwXpgRkwhqtSgScspQ==
=7qls
-----END PGP SIGNATURE-----

--Sig_/PzvbuER6KufoY9yXlj6Gzkp--
