Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171D459529A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 08:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiHPGhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 02:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiHPGhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 02:37:07 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9554A1AB883;
        Mon, 15 Aug 2022 18:13:31 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M6Cny4fhGz4xV4;
        Tue, 16 Aug 2022 11:13:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1660612406;
        bh=snNpycHxM/XQfHLoQriesMPQxXB226j+ksKeX43PHSo=;
        h=Date:From:To:Cc:Subject:From;
        b=ZGvCq3/YwHAtG2mgItxXvv1hOqdoQ/x5cK6sefPTJgi1kh1MG7IGPp+53tBaYEnBx
         8/jM8sa+EIitvNDyTpT+d4ZpDlMBQGSyg2sKNb/XHsXswS9A7Z1Mtag4vqWnn3VlxD
         6I/tBDsEAI8s2xk2R1YQ4QrEJQJ3/rrNZU/Y3AxpcGw1OcFBSxsDSuPipouE3kA1yC
         vg5UHZaooVm72Ccxvo+St9fjNP+oy/eksutb9ATqOF40kqrvul2EfYwHLFX+XRnfOu
         r0zP62nHYE3ySR1Nt1/q7aDWq2Xs8UHFiwEE05IOee1igf5Dwe/6v3bQkWJ5DE1ZSI
         09kIOlvVRtkDw==
Date:   Tue, 16 Aug 2022 11:13:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the vhost tree
Message-ID: <20220816111323.05b3c314@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mHlB/mK8Z7Pj/FFx6gwWY99";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mHlB/mK8Z7Pj/FFx6gwWY99
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the vhost tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/virtio/virtio_vdpa.c: In function 'virtio_vdpa_find_vqs':
drivers/virtio/virtio_vdpa.c:291:61: error: 'sizes' undeclared (first use i=
n this function)
  291 |                                                   names[i], sizes ?=
 sizes[i] : 0,
      |                                                             ^~~~~
drivers/virtio/virtio_vdpa.c:291:61: note: each undeclared identifier is re=
ported only once for each function it appears in

Caused by commit

  71545b3c933a ("virtio: Revert "virtio: find_vqs() add arg sizes"")

I have used the vhost tree from next-20220815 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/mHlB/mK8Z7Pj/FFx6gwWY99
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmL67zMACgkQAVBC80lX
0GzZewf/cit26uB9DjYtXsiZ5fyyM1b+GdHipoLVZiHJyE9BHSuJAjWbI5FN109k
I/jCcfUS2vaBH2aRHOnNTfEKTjOOSg1o15SjNMIXMTWaYnPoRFCubLY/MsbmUo+9
91J1y3pqlCAfGafxL9Z94dWZeTABtH+CexLS9zn1ImsVEqLNRIoQjubUvW/n3DK7
E31RcqEJgaBbBMvnFKjvnw1BXq7ix6zWslJov7/VobtrwBZl676U89PbIBDJjdod
4/qwTrh6JVG41ArFb0OyuWEcdKLK5fPvG0Lmv95/O7z62RnYlsgltHxQWui4s0zp
kcp61wSirNx8XbpNHGXtOvJrykPhKA==
=lOQF
-----END PGP SIGNATURE-----

--Sig_/mHlB/mK8Z7Pj/FFx6gwWY99--
