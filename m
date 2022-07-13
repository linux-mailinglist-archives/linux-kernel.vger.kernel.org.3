Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C74157362B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 14:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235887AbiGMMPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 08:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiGMMPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 08:15:05 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E2983F1D;
        Wed, 13 Jul 2022 05:15:04 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ljc4w07t5z4xvg;
        Wed, 13 Jul 2022 22:14:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657714500;
        bh=uDhVXiqCj/rhBJXlqy337qGKpkTPsz6WFevTk5S1V0o=;
        h=Date:From:To:Cc:Subject:From;
        b=mXAxKtYg4H+GX8fk8PJZL5lIHkhQ+hbjy2si+rcjdyb0cMWT3t2IbgWifsmxALyWF
         oXm9pxQrPDf5EYY4+ot8ZvhlJU1NXHRH0bwfLEQ5YR1u8vGnFOeYAjux1utTDYOf62
         GJ+ULsOLMBauNOTuC4ga8hBvWBJy6sWjUGVBBAyRCdMHzt/b4JMH+B0riECVg51EBf
         lvX92TvwSnQqsPYlt/CmFfibS9lZaACPkXNfpguLd/O5l+21CN5ksAy96g9aI6Jqig
         neP23S9bq0Gs54EZGQ4e5Dr/wZxHQrVvXIDzI3eMlHG64HXLtm46eFJJeBbrvqiJZW
         oo5xwJVf/+x3g==
Date:   Wed, 13 Jul 2022 22:14:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Matthew Auld <matthew.auld@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the drm-intel-fixes tree
Message-ID: <20220713221454.67bb20df@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eJxh_gAMEwDnUciW=_vQR2V";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eJxh_gAMEwDnUciW=_vQR2V
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-intel-fixes tree, today's linux-next build (i386
defconfig) failed like this:

x86_64-linux-gnu-ld: drivers/gpu/drm/i915/i915_scatterlist.o: in function `=
i915_rsgt_from_mm_node':
i915_scatterlist.c:(.text+0x196): undefined reference to `__udivdi3'

Caused by commit

  aff1e0b09b54 ("drm/i915/ttm: fix sg_table construction")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/eJxh_gAMEwDnUciW=_vQR2V
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLOtz4ACgkQAVBC80lX
0Gyu0AgAidtC+1SSKr14X+YbGBrvCORn0Pbc4VOBJgd/ET7eHhGwXO1XXW6G7Hfz
Qm5TXiKTu76MXBcfja8Akh1yvVD3m6m5rIAQMn93ZmE+Cw5W5ROxku7pq1DZ1oKR
h47QFCM0WdBCbF3jVtYX6XTflvQL9Pj5L9bUrgJNscPh48Nsu22eOcXBRsOQdKg7
AmLjf6muUc5pLwsh3Dx3TlPLMrvpgyTVZUxQ0q050JxIPSOh/j9nx7X+CFweQjx0
CrxCazdLAX7kZ73hoaVevmMwQ84UI2kIKOdkLL5McsmtgFwQBchcVw0C+Xw4Tdgq
/gbu/YO0mwC3BQ+dlL3gz3ERyZuuvQ==
=aURU
-----END PGP SIGNATURE-----

--Sig_/eJxh_gAMEwDnUciW=_vQR2V--
