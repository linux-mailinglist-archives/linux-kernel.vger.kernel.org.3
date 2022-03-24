Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052D54E5C74
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 01:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346894AbiCXAyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 20:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346883AbiCXAxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 20:53:53 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE6090FDF;
        Wed, 23 Mar 2022 17:52:21 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KP6BT5RN5z4xn3;
        Thu, 24 Mar 2022 11:52:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1648083139;
        bh=gwwRG04wYByykVxvO7c+65Q9ZZ2jrq3N3cl8WkxKtwU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hOCv32yngct3v8H7zb7LGyEK5YISv5LUoN0fV5CqaDgh3cZ4r2dZMXDgRklBTO1zn
         03FnJKio0u7SQMTHJnmGSM0iNGaR88vVkMq7zHaujW9ZOnKNNtWFYqPR3w7zRSWMRI
         VgXhcAh/hOgrKcIwwwd7uxPEKV89MnF+xC82+GvC0qNd6NN04WLyLB7a63mJRitM4O
         7S286Sra80Xb/hQ8+FqyL9By26b9jWyTStzmIJS7rYK7sJcN0fre09qiohg9pBOOBy
         V52F7QoTGvE/31rzjDB0uozKZo0RVaFCc3EaUNE71vHo5X7fiwddbG3g35BKNAJ3iI
         eqZEkqhfOITHA==
Date:   Thu, 24 Mar 2022 11:52:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>
Cc:     broonie@kernel.org, Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: Re: linux-next: manual merge of the folio tree with the drm-intel
 tree
Message-ID: <20220324115217.21e58afe@canb.auug.org.au>
In-Reply-To: <20220222004147.3360596-1-broonie@kernel.org>
References: <20220222004147.3360596-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/k35jsNPZoGhmICH0bXEzu3u";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/k35jsNPZoGhmICH0bXEzu3u
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 22 Feb 2022 00:41:47 +0000 broonie@kernel.org wrote:
>=20
> Today's linux-next merge of the folio tree got a conflict in:
>=20
>   drivers/gpu/drm/drm_cache.c
>=20
> between commit:
>=20
>   7938f4218168a ("dma-buf-map: Rename to iosys-map")
>=20
> from the drm-intel tree and commit:
>=20
>   96160c2f78bd1 ("mm: don't include <linux/memremap.h> in <linux/mm.h>")
>=20
> from the folio tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> diff --cc drivers/gpu/drm/drm_cache.c
> index 4b0da6baff78e,50b8a088f763a..0000000000000
> --- a/drivers/gpu/drm/drm_cache.c
> +++ b/drivers/gpu/drm/drm_cache.c
> @@@ -27,11 -27,11 +27,11 @@@
>   /*
>    * Authors: Thomas Hellstr=C3=B6m <thomas-at-tungstengraphics-dot-com>
>    */
> -=20
>  -#include <linux/dma-buf-map.h>
>  +#include <linux/cc_platform.h>
>   #include <linux/export.h>
>   #include <linux/highmem.h>
>  -#include <linux/cc_platform.h>
> + #include <linux/ioport.h>
>  +#include <linux/iosys-map.h>
>   #include <xen/xen.h>
>  =20
>   #include <drm/drm_cache.h>

This is now a conflict between the drm tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/k35jsNPZoGhmICH0bXEzu3u
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmI7wMEACgkQAVBC80lX
0Gxa/Qf/VnXsZKvgl/bI1rEvPZt+BreSKMmiOT/+UmTQFGSgNc2m3y7qCnSzzhHr
REw4CamkUm8XwNeCPFMp1xrnxl51o48L5sod56c513ObW4LwY0qypxPuR/fO1bKm
Cw3sJkbVXZ3QKYRP8iodp36KV/BOyp29UaXcn9i63rzq4zNeGZ8w3GUHgs6zNs0J
TOvXJ1cMqS9vS3uLBftlDEALcX+x1MhNh44qbrWizhusL45aW1CQR78G6hjiyT3I
Yk7UAhzAiy/P84ZluaCWqp2mT9R993QOu/TrnA09TTkSSBKfu7eg60/u29Dr2sFe
4+qzGCMhJmMwQDwJOQos/y3ZVF4JQg==
=0ADK
-----END PGP SIGNATURE-----

--Sig_/k35jsNPZoGhmICH0bXEzu3u--
