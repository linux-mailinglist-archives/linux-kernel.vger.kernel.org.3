Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0F44CFBF3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 11:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiCGKx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 05:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241706AbiCGKwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 05:52:55 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615003E0DE;
        Mon,  7 Mar 2022 02:13:00 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KBvQz09nXz4y0c;
        Mon,  7 Mar 2022 21:12:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646647963;
        bh=43avDFrDr9aMk2gpa2YriZ716cDuLQIlsBGqwkqyvng=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hKpt6FyD9K1wiajWtnGGwLYg7bCUmiDyEFL9SJlUuHRm/sgfTYJlD7sfhJtEFMsZ7
         m3ApyphiC5n51R6j8Z8L6hu7DBVa1CWQku2cNTGhJOGar3XMRc/0II4c/cU+4z7oAD
         6sFa+IMJWMYjOJ4NYhQxqxv9xMfvdzcv7YADczfM//DVl9l+9QB6nT62KQMQnFIaMu
         guGBaheOJKWy0V0/qmfitMR4QWwvG5s8DOIDNa8vJJX8kodaVSZmyb5lS/GzTGZsUV
         Z0D/kmKPHosGsVEPBmpr5AQX+bt1z9pmPSE0gQ+rE2PkIbd5cnAFnlxAM/GqLhMeYI
         g5S69gcevt1Kw==
Date:   Mon, 7 Mar 2022 21:12:42 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: linux-next: build warning after merge of the vhost tree
Message-ID: <20220307211242.59fc0f0e@canb.auug.org.au>
In-Reply-To: <1646635600.9436276-1-xuanzhuo@linux.alibaba.com>
References: <20220307154011.6d456f28@canb.auug.org.au>
        <1646635600.9436276-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/T5RRt1xHG.xnLDS8d/AyZoI";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/T5RRt1xHG.xnLDS8d/AyZoI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 7 Mar 2022 14:46:40 +0800 Xuan Zhuo <xuanzhuo@linux.alibaba.com> wr=
ote:
>
> Can you help me test this patch? I don't have an arm environment around m=
e.
>=20
> Thanks
>=20
>=20
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 1fa2d632a994..4d629d1ea894 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1820,7 +1820,7 @@ static int virtnet_rx_vq_reset(struct virtnet_info =
*vi,
>=20
>  err:
>         netdev_err(vi->dev,
> -                  "reset rx reset vq fail: rx queue index: %ld err: %d\n=
",
> +                  "reset rx reset vq fail: rx queue index: %td err: %d\n=
",
>                    rq - vi->rq, err);
>         virtnet_napi_enable(rq->vq, &rq->napi);
>         return err;
> @@ -1870,7 +1870,7 @@ static int virtnet_tx_vq_reset(struct virtnet_info =
*vi,
>=20
>  err:
>         netdev_err(vi->dev,
> -                  "reset tx reset vq fail: tx queue index: %ld err: %d\n=
",
> +                  "reset tx reset vq fail: tx queue index: %td err: %d\n=
",
>                    sq - vi->sq, err);
>         virtnet_napi_tx_enable(vi, sq->vq, &sq->napi);
>         return err;

I had to apply that by hand, but it does work.

Tested-by: Stephen Rothwell <sfr@canb.auug.org.au>
--=20
Cheers,
Stephen Rothwell

--Sig_/T5RRt1xHG.xnLDS8d/AyZoI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIl2poACgkQAVBC80lX
0Gxhwwf/Yoy/Fx2MA3XKvHLKbSEO4haeLV/jiLTn33CCDtpIM0xqcZHR4Vdrx/iC
eQeqrko2lzE9eH63myQI9aIrd8xpLBovdfuUlRzC9HpVlkhrrqf6+f70Y9RVSKa1
alh98ccERL91LF1163puCeDJFaEHZb8ImHjqK7C1BjNssjnkOD62uGnajm8wFARu
zPv054ntn9F2IIHKAntn4L5gEiMjlB7LAhoziVSWINvh9fjsQBgkv2UPXWcq46LM
YGbHkKepzS+LANbKJ+Oiw3mgFD8+p6UxuToz6KtG5Qd7H0ZJRDs17tXi9WLSKmhB
w9kWMEPual3nH7Np64LDGxCuTjhOBg==
=Jcmj
-----END PGP SIGNATURE-----

--Sig_/T5RRt1xHG.xnLDS8d/AyZoI--
