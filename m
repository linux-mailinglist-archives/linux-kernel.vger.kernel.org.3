Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10800577FA4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 12:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbiGRK2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 06:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbiGRK2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 06:28:21 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5614F1ADA9;
        Mon, 18 Jul 2022 03:28:18 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LmdTX4ThSz4xXF;
        Mon, 18 Jul 2022 20:28:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658140096;
        bh=pvOgH7ZbBTZdm/4ySthuDSGL/yInS95AxwvDByXaZiY=;
        h=Date:From:To:Cc:Subject:From;
        b=phyN9po1LgQuT8Kaz7W4l5FRMy2BnhG9wUxxUuOkN0WnxrndWWgeGFug/bELCeGqd
         NSX1+goaDExZ46iUMJa8ndD4djBlyB11ckat16RjeEu524It1bYrgvPpod1grK7au8
         DoUvDBseYf4bFPwyMrVQL9HhNfbTGrAISvToQKpLDYVr+4dvPodu7iByg0cr36gsGl
         lYfyfdTV3r/e3unYRlLAsqByqFpxD/DEwW80yA/Wzy35+nNJTn3AU4XVRARyUeQS6+
         Sf0xRGEnrsBa8+oREwGS4Run0GVq7SIy0OTUM/N2CgstYtLZx7C6kOl5PAmD+TEhSI
         ghZW0lSzexHOA==
Date:   Mon, 18 Jul 2022 20:28:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the mm tree
Message-ID: <20220718202815.11807e92@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/I=yWAnpJfSPqRrzXEM2Dfjl";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/I=yWAnpJfSPqRrzXEM2Dfjl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (powerpc
ppc44x_defconfig) produced this warning:

mm/shmem.c:2848:12: warning: 'shmem_fileattr_set' defined but not used [-Wu=
nused-function]
 2848 | static int shmem_fileattr_set(struct user_namespace *mnt_userns,
      |            ^~~~~~~~~~~~~~~~~~
mm/shmem.c:2839:12: warning: 'shmem_fileattr_get' defined but not used [-Wu=
nused-function]
 2839 | static int shmem_fileattr_get(struct dentry *dentry, struct fileatt=
r *fa)
      |            ^~~~~~~~~~~~~~~~~~

Introduced by commit

  8673852551f0 ("mm/shmem: support FS_IOC_[SG]ETFLAGS in tmpfs")

--=20
Cheers,
Stephen Rothwell

--Sig_/I=yWAnpJfSPqRrzXEM2Dfjl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLVNb8ACgkQAVBC80lX
0Gwohwf/a/Q2Cqv2JiQqNxLeMKaUD++c1Eo9ivurXb8IU2MB/uTjq848H2pWmiHp
YDfx1WPusFVOIcaQYKzWeuD4LBiC5l6NA6g3VvUGRihuxxUys0XyfoZOIeHcRjmh
7hDxvWjzkcYcp8IONdNGiDRxigNb3ad4PQmo+doVe/TsxvaGP+Y0CSiN0AOJgK9O
XMS0L51SNL2GgwVFcskEB2q6ttKL70imQRkXs2ChMfTZJnA5zLFZN9DEHemBCuMN
zFfeBGpFsym2ZAMHhChr+w1pimpYDau24hjg9WdjnpsCInanvODxkRiR7Gvf7GaY
x/cI6MkSqt1o3HsgUwydNk1gxBFaHw==
=4ECN
-----END PGP SIGNATURE-----

--Sig_/I=yWAnpJfSPqRrzXEM2Dfjl--
