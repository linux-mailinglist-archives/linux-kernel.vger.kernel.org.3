Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA414D0F3A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 06:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245213AbiCHFhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 00:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiCHFhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 00:37:43 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6634A3B570;
        Mon,  7 Mar 2022 21:36:46 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KCPG268QJz4xvG;
        Tue,  8 Mar 2022 16:36:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646717804;
        bh=Otev4lUDnvLvJDRPR65LdLP6mtootxRKjGv9Rzr4Jgo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=llsYzFlIGVAhDobF/md9DpX8UUdVL2OBnOuujRn6RuFAa3dqE2mXckE8UizcoGtix
         pMe/psdMctRbSwPU8NS5M/JeL7+Z0wBaIzCAWMlGMRweLdhQzawHPE7uogLEfakFsh
         wBRM6BW71Pl0himkIFSUmfIBgrNpxV8TJtO/ycqU6U6Yj/CHex6L2KXqk/zAb5QzRx
         iXd/U8cQC8BMJ+kLPl4mVmeIxEeooaR7yBpC5jA20bQscrHmw/najKXhyRwU6AYFHG
         ICZEe9+4dcB9Cw8JcfXT8lEBClLTnLfErDR6kN0hcKUSOwkNbn0ljUmr3AstjUslaM
         ASJ3mSNnQf0Ig==
Date:   Tue, 8 Mar 2022 16:36:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Xie Yongji <xieyongji@bytedance.com>
Subject: Re: linux-next: manual merge of the vhost tree with the block tree
Message-ID: <20220308163640.42bbcdad@canb.auug.org.au>
In-Reply-To: <20220307153439.191104dd@canb.auug.org.au>
References: <20220307153439.191104dd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vAGwY6F20DaM7h7A7BTBrR=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vAGwY6F20DaM7h7A7BTBrR=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 7 Mar 2022 15:34:39 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>=20
> Today's linux-next merge of the vhost tree got a conflict in:
>=20
>   drivers/block/virtio_blk.c
>=20
> between commit:
>=20
>   24b45e6c2517 ("virtio_blk: simplify refcounting")
>=20
> from the block tree and commit:
>=20
>   e030759a1ddc ("virtio-blk: Remove BUG_ON() in virtio_queue_rq()")
>=20
> from the vhost tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> diff --cc drivers/block/virtio_blk.c
> index 5c636ca7f1a7,8c415be86732..000000000000
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@@ -69,9 -69,13 +69,6 @@@ struct virtio_blk=20
>   	/* Process context for config space updates */
>   	struct work_struct config_work;
>  =20
> - 	/* What host tells us, plus 2 for header & tailer. */
> - 	unsigned int sg_elems;
>  -	/*
>  -	 * Tracks references from block_device_operations open/release and
>  -	 * virtio_driver probe/remove so this object can be freed once no
>  -	 * longer in use.
>  -	 */
>  -	refcount_t refs;
> --
>   	/* Ida index - used to track minor number allocations. */
>   	int index;
>  =20

This is now a conflict between the block tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/vAGwY6F20DaM7h7A7BTBrR=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIm62gACgkQAVBC80lX
0GxgKggAnl5yH6nfBAxD7yrjnVZ2U8ecgDVbTuTVLjqGuyYyNUormLMIgsp322AO
kXhc+9NcjiAZG+B71ERaEfQsKrLs6OOIz7QJwjRoDAfchHrt8/9pB/YLjHGd12CR
TtyaCfuCXt1q0/iHD2ktwXSEDhijfaw6KS0WALR8DNNBt+X8ZlO9ZKqF37tz74V2
O3lFYaRtf2d4PEmQtIwxuYcYHRi+DKHIDE7K1/N2o9dR1EPFydXYvciZMQEbLV6b
NpPOz5dOfiLRSFnXhYaOm3QtiDuo/2oOG5O19MGES0sqqeaQ5JIuApPTUI4atlq4
hx45ZbNl+Fq6CGVPhymSESk9yIV5nQ==
=1iuK
-----END PGP SIGNATURE-----

--Sig_/vAGwY6F20DaM7h7A7BTBrR=--
