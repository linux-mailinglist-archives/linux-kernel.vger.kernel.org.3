Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2C44D28CC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 07:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiCIGOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 01:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiCIGOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 01:14:06 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0427313D0F;
        Tue,  8 Mar 2022 22:13:07 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KD21W1QSHz4xnG;
        Wed,  9 Mar 2022 17:13:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646806386;
        bh=XqViItOn2ErCKOtc6B8WmgwCnWCFyrtsZ+W9A1X429Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CjSlRilnXoLWHZ34aLJkLA2EUOl9n7fwaFiQOyA//QNeuHkSpaTRRRXL479pK90+e
         Iw0ZemKxJZVxVrYoOLgYOg70V8sq+WUzJY855qBrqwjYbWwvyKrmXbAjgya96xylTb
         52tCSVBJ1DwK4LfO8kvxDpIzQUNlEW/CJUcp+nSoLCMJwA8Z91nZaKaroVFI2VC2Bo
         f79FyU7CBMcii4Uw4EYtGe3AdvR/U1T3Q9QBEH+5yEEsTKz7a8sDl89wOIexeWYjvk
         1eey7yB4qF2oE12HOy1L2awh6p4pQgq+MxQH+1JRcTC6/zlfLd231No6t7b+LWMLS8
         0pshHzn14RVrg==
Date:   Wed, 9 Mar 2022 17:13:00 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the vhost tree
Message-ID: <20220309171300.0500a07e@canb.auug.org.au>
In-Reply-To: <20220307060012-mutt-send-email-mst@kernel.org>
References: <20220307154011.6d456f28@canb.auug.org.au>
        <1646635600.9436276-1-xuanzhuo@linux.alibaba.com>
        <20220307211242.59fc0f0e@canb.auug.org.au>
        <20220307060012-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/z0Z3u/r4NsQg0OpZwH2n+re";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/z0Z3u/r4NsQg0OpZwH2n+re
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Mon, 7 Mar 2022 06:00:27 -0500 "Michael S. Tsirkin" <mst@redhat.com> wro=
te:
>
> On Mon, Mar 07, 2022 at 09:12:42PM +1100, Stephen Rothwell wrote:
> >=20
> > On Mon, 7 Mar 2022 14:46:40 +0800 Xuan Zhuo <xuanzhuo@linux.alibaba.com=
> wrote: =20
> > >
> > > Can you help me test this patch? I don't have an arm environment arou=
nd me.
> > >=20
> > > Thanks
> > >=20
> > >=20
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 1fa2d632a994..4d629d1ea894 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -1820,7 +1820,7 @@ static int virtnet_rx_vq_reset(struct virtnet_i=
nfo *vi,
> > >=20
> > >  err:
> > >         netdev_err(vi->dev,
> > > -                  "reset rx reset vq fail: rx queue index: %ld err: =
%d\n",
> > > +                  "reset rx reset vq fail: rx queue index: %td err: =
%d\n",
> > >                    rq - vi->rq, err);
> > >         virtnet_napi_enable(rq->vq, &rq->napi);
> > >         return err;
> > > @@ -1870,7 +1870,7 @@ static int virtnet_tx_vq_reset(struct virtnet_i=
nfo *vi,
> > >=20
> > >  err:
> > >         netdev_err(vi->dev,
> > > -                  "reset tx reset vq fail: tx queue index: %ld err: =
%d\n",
> > > +                  "reset tx reset vq fail: tx queue index: %td err: =
%d\n",
> > >                    sq - vi->sq, err);
> > >         virtnet_napi_tx_enable(vi, sq->vq, &sq->napi);
> > >         return err; =20
> >=20
> > I had to apply that by hand, but it does work.
> >=20
> > Tested-by: Stephen Rothwell <sfr@canb.auug.org.au> =20
>=20
> OK, I squashed this into the problematic patch. Thanks a lot!

The warnings have reappeared today :-( and this fixup is not applied.
Something got lost in the rebase/rewrite?
--=20
Cheers,
Stephen Rothwell

--Sig_/z0Z3u/r4NsQg0OpZwH2n+re
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIoRWwACgkQAVBC80lX
0GwvvAf+JiZtIPumBs9xmURkDKuL8Yxm54lmJ81HoeYHzgI+nOrfEKjz+Hs5iQ+W
pSK+0rMq1kQeOgbsaCWIPjQJxv3ZCjg36rGjynjyfKMe7eD9SF5d9tvwPqnNF340
6wgyAJzpwrS+HF02fNSR1/5sTrB1uBAYqsl5Ti1JvRaH/ZHWJwkmNQlzChZ7EPPn
c04nI883inhkiVzHpFe5k1WTzKhF0HyYu1G1eyR+pQ+MGH/pktC1ZPdSS6e8Y2Il
8XVlt8K+qpCO1qWYK2+odwz0AsG/80fu8dLflXqqrZz+lp0oCnTdSYobWzwOcLva
Y+TaccTI2GKY1PE8mG0ewJPCKfrrJg==
=6W6U
-----END PGP SIGNATURE-----

--Sig_/z0Z3u/r4NsQg0OpZwH2n+re--
