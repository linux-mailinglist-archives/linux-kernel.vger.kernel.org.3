Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4AA855B46B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 01:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiFZXP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 19:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiFZXPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 19:15:24 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED9B2BD6;
        Sun, 26 Jun 2022 16:15:22 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LWRXm4yzvz4xD9;
        Mon, 27 Jun 2022 09:15:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1656285321;
        bh=IgefZHhFuM9sbkBISfbpAynRkxG4jpozZiSwolv7ZaQ=;
        h=Date:From:To:Cc:Subject:From;
        b=EaDT/iUjbgPd3Ini6wFSpjWXiiQREdArs+neNqr93JUxG4rSFTa7gAUq86NUmDbyH
         0DjRBcSqW/loqoOKFe5j2aeA4mzcV5EFDQnAS8yfeEdicfHA4Vaj3B9p/h2KR3m3Wt
         Vfv7VXg4AD/xy2pjAn+O4Z1EDKchjgL+cfYVHLfoUFnx37bSWGnA/2n34xBDPmXv4S
         AWQYIg2cpPeLUOiEZMPNNMw5/EQIyfj9aXZUcW9EHAcBmL4Sye3T8KjX6GbHD+pal2
         x5UoDHLtMPxNMjGj0xCaY68MWQJwU2uEodqZs/l0YjvRb+1nDDk2cFxzrbhwj08dVY
         +2CjZphdnjruA==
Date:   Mon, 27 Jun 2022 09:15:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Colin Cross <ccross@android.com>, Olof Johansson <olof@lixom.net>,
        Thierry Reding <treding@nvidia.com>
Cc:     Bitan Biswas <bbiswas@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the tegra tree
Message-ID: <20220627091519.323d5a82@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VYf1j_4Pda_vtrnQvZlYQDd";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VYf1j_4Pda_vtrnQvZlYQDd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tegra tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

In file included from drivers/soc/tegra/fuse/fuse-tegra.c:7:
include/linux/device.h:136:33: warning: 'dev_attr_production' defined but n=
ot used [-Wunused-variable]
  136 |         struct device_attribute dev_attr_##_name =3D __ATTR_RO(_nam=
e)
      |                                 ^~~~~~~~~
drivers/soc/tegra/fuse/fuse-tegra.c:441:8: note: in expansion of macro 'DEV=
ICE_ATTR_RO'
  441 | static DEVICE_ATTR_RO(production);
      |        ^~~~~~~~~~~~~~

Introduced by commit

  2258fe488a20 ("soc/tegra: fuse: Expose Tegra production status")

--=20
Cheers,
Stephen Rothwell

--Sig_/VYf1j_4Pda_vtrnQvZlYQDd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmK46IcACgkQAVBC80lX
0GzuHwgAolcXRGX3E8lcPbENno+c7gK0zaI/OKlslrIOCpu4M/kDeUol3WXNzvKD
5RHQ1TvrI8N6O7vC4UsHVBlyb9Q97Og+8kAi8/UB9aBuO1v2hNN/mzsXCTR7JNNM
iSckR+j/FeevB2ZTmASG3dUOvY3RF1cMCFj7A+x1dCiGoNog3abyMLpLXTPxtu/2
bdt+Rkv3d7pcNRKzavLpwl97Rq8jq8xP0j07vpY9/WMCrZ61ZUmotlfcck9RliLG
41UhJAhOIPkIZQxFEJfoYZ75+9bMRd1ZBKaveWz4I3ZuT6xcFsWe9eCkhehRF+uI
GDWSEI/S1W4qeloZxIk8SsB3iugLoA==
=Q1ux
-----END PGP SIGNATURE-----

--Sig_/VYf1j_4Pda_vtrnQvZlYQDd--
