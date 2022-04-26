Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C51650F605
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 10:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347158AbiDZIpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 04:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345739AbiDZIj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:39:27 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050C3403CF;
        Tue, 26 Apr 2022 01:30:50 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KnZpJ590lz4ySW;
        Tue, 26 Apr 2022 18:30:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650961849;
        bh=czivHZ+lHH63w67c3ZACNKHQwiMOwH0QCqtUPgwwvkY=;
        h=Date:From:To:Cc:Subject:From;
        b=O0ddEM8aWOARzU3HQ4thaICH0oW6pKC0o1Wx3m353ZeRhbk4GF520x/4x0+CblV7u
         U5VQ09sni2bDzd4CCUzCX4aHTD7mt7hZIC1xsB9aTe3sDVqlyz2mydn0GrjFxREaVB
         EZwS1avtkOEcfxCE9WHDT9NTBsILOVa2kbwhbRZaFZJCxXpZMtqEatWeis156gdTYQ
         guzV2la6qSMbaTFZBz7uWLWlLBdtL3wHy8p4J78ax3pYhO5+rdn4WxIe/sQSb0JbVL
         mpKpK5aBFpaYJpMRXNvnQCzbFk4/HU/taJLoXO+rSxG+zyvR0WopkAYGnuU12eQlRs
         VFTsRznQpyabw==
Date:   Tue, 26 Apr 2022 18:30:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Amadeusz =?UTF-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the sound-asoc tree
Message-ID: <20220426183048.5f1cb899@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//xfg1wYZ3AWTI/N/W5SjHei";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//xfg1wYZ3AWTI/N/W5SjHei
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the sound-asoc tree, today's linux-next build (powerpc
allyesconfig) failed like this:

sound/soc/intel/avs/path.c: In function 'avs_copier_create':
sound/soc/intel/avs/path.c:186:31: error: invalid use of undefined type 'st=
ruct nhlt_specific_cfg'
  186 |                 data =3D ep_blob->caps;
      |                               ^~
sound/soc/intel/avs/path.c:187:36: error: invalid use of undefined type 'st=
ruct nhlt_specific_cfg'
  187 |                 data_size =3D ep_blob->size;
      |                                    ^~
sound/soc/intel/avs/path.c:210:31: error: invalid use of undefined type 'st=
ruct nhlt_specific_cfg'
  210 |                 data =3D ep_blob->caps;
      |                               ^~
sound/soc/intel/avs/path.c:211:36: error: invalid use of undefined type 'st=
ruct nhlt_specific_cfg'
  211 |                 data_size =3D ep_blob->size;
      |                                    ^~

Caused by commit

  274d79e51875 ("ASoC: Intel: avs: Configure modules according to their typ=
e")

I have applied the following patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 26 Apr 2022 17:49:37 +1000
Subject: [PATCH] fixup for "ASoC: Intel: avs: Configure modules according t=
o their type"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 sound/soc/intel/avs/path.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/avs/path.c b/sound/soc/intel/avs/path.c
index 3d46dd5e5bc4..6f47ac44de87 100644
--- a/sound/soc/intel/avs/path.c
+++ b/sound/soc/intel/avs/path.c
@@ -9,6 +9,7 @@
 #include <sound/intel-nhlt.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <sound/intel-nhlt.h>
 #include "avs.h"
 #include "path.h"
 #include "topology.h"
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_//xfg1wYZ3AWTI/N/W5SjHei
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJnrbgACgkQAVBC80lX
0GwRlwgAhchvrLBL9nPU25RzDVnerN3LCUd0syA1/9xlw4aig7ZRj7V7+XuBKKr0
oIbDDP6EjODXIz+LeypGGMDcBD5wzpaDtedCY6mdV8nrsGK7DYmnv1lLW4uPF4GC
G1BWKzvyAavdjscXRLBLOPgebYUV/NI9SQyf2jhmr9yWolcFw5SfRK7kH0+ra92+
7R5NH6IU1i//3fty567PSYauKeVTB2/5GCl7ISO/hsYiLvu8QPo9ssTwJ35M6cl6
AlhmH5ZjaFsWxd+D7niu7Vxyyu2G6x7ZjEtHxR2soXrdclRpQazwVBPJvo/5kU+u
matStPxcUJmx2AwqEsHGrf5tNF55fA==
=zCsj
-----END PGP SIGNATURE-----

--Sig_//xfg1wYZ3AWTI/N/W5SjHei--
