Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9C1539AD9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 03:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349007AbiFABmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 21:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbiFABmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 21:42:49 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830FB69B50;
        Tue, 31 May 2022 18:42:47 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LCX2p2B9Mz4xXJ;
        Wed,  1 Jun 2022 11:42:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1654047762;
        bh=siGya32yABE06OPBh8rD0LfumbDaJXyKE6rA7GhzRLI=;
        h=Date:From:To:Cc:Subject:From;
        b=pRNROhzQFTSlxgkixk/RLD3flanipsyJQcEt9d1B7qHe6xsD60CD7qwp6EysdPGjM
         OOFeT5zLkZrL5OBXkpnnWtYufSHU25giFSQ20LD9rTyE6C77xl/osOy8N4Pt/3L2VZ
         aqa+WCSjVrzfC6ArJ0eg9Qqyotlu73jAq/CRpG1eGQ1T2xv5vtWt+DbwrtqK0OPKMX
         zqXXximBR6FO//JEHecYBy2uET6vXdtzC60fGO8AabhNmr+1307x1PLGysl9IQZZFe
         shxGX6pvlVY8c0TJ6NaEawJSvbH9UlqB7XhwSs5R7rGN0WpI93lLkF60SOpCuR5X2a
         VpV5kE2F3exwg==
Date:   Wed, 1 Jun 2022 11:42:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Bo Liu <liubo03@inspur.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the vhost tree
Message-ID: <20220601114240.1dafefc6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lhaLPNCK4pASe4+RX.9ttxE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lhaLPNCK4pASe4+RX.9ttxE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the vhost tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

drivers/virtio/virtio_ring.c: In function 'virtqueue_add':
drivers/virtio/virtio_ring.c:1783:16: error: 'vq' undeclared (first use in =
this function); did you mean '_vq'?
 1783 |         return vq->packed_ring ? virtqueue_add_packed(_vq, sgs, tot=
al_sg,
      |                ^~
      |                _vq
drivers/virtio/virtio_ring.c:1783:16: note: each undeclared identifier is r=
eported only once for each function it appears in
drivers/virtio/virtio_ring.c:1787:1: error: control reaches end of non-void=
 function [-Werror=3Dreturn-type]
 1787 | }
      | ^

Caused by commit

  a50f09346a34 ("virtio_ring: remove unused variable in virtqueue_add()")

I am sorry, but I expect better review and build testing than this :-(

I have used the vhost tree from next-20220531 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/lhaLPNCK4pASe4+RX.9ttxE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKWxBEACgkQAVBC80lX
0GwA7Af+LZt1S294FZe5clfzMjmWLa1YBEtsHA456ozl9p7EP738LjANHXomOKmJ
KZEHTbHuMulxGHlubL4aEi3OuEo6idIy5SOnXtQ6gkyR3uSen+T1xfmnW2/bSw1t
5dqtL9hHckll6LKXAOmt3IdP9Lh3YThetu0xFrvDs9kRUnhMEll83ftiYpnJJc2H
eTlcpqstfHI+wO5Alpq894RHrcXglTRVBQ65JV3lmlJDbZP3K2/3Y00eElQF3jLL
08NyUD/TBljqppOBA9dNEYdf3uJcLm5CAGzEUSgLxEfLYPOle71ZFnZE8pmEXUMC
psg97RCsGwtFoymGnBsYQHl7A/UcyQ==
=o4BZ
-----END PGP SIGNATURE-----

--Sig_/lhaLPNCK4pASe4+RX.9ttxE--
