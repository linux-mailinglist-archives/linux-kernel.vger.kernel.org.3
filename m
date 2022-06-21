Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD7C552971
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 04:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243210AbiFUChW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 22:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbiFUChS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 22:37:18 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA5B1580C;
        Mon, 20 Jun 2022 19:37:17 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LRrJR2N9Fz4xXj;
        Tue, 21 Jun 2022 12:37:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655779032;
        bh=E2bt6Hqtp6F5DJLwZ0iF2cXMIpskMQ1W7uOyDJJZhrs=;
        h=Date:From:To:Cc:Subject:From;
        b=qLwfmR/5EaWCtqQfwoLOR69le/bV0Civ+NfNfAKOAZulNmdf1AoBr3AEng6tr1LNb
         +cvvXGlqU/mCp0+7AHyH1+seV2dI/SnaBk8oNmNZl0z1BYXwXyR2+ka47S60fKQrql
         nbblfV5IuQKpNc1KrXa8gZjIOSsM+IxxG4roQ4b6Hb7gDacGN8qqLC0FMsgWRy71uB
         6r7nmYloBTfItf8rCvmRtyntRVt7HWvCZ8Qu7uyAeXGRw2hxzx3BBCqf4E3HF2e+Vu
         qkczqAg9R3fdzfAZnx4/udrqhokHp74UtsOjvBT68qL74SkfElcQV0aBIf45vuTW+9
         1+7/PYbKDD0wA==
Date:   Tue, 21 Jun 2022 12:36:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the drm-misc tree
Message-ID: <20220621123656.7a479ad9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gVQErqL6wYsDqhSe=SaTGRP";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gVQErqL6wYsDqhSe=SaTGRP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-misc tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/gpu/drm/xlnx/zynqmp_disp.c: In function 'zynqmp_disp_create_planes':
drivers/gpu/drm/xlnx/zynqmp_disp.c:1260:17: error: implicit declaration of =
function 'drm_plane_create_zpos_immutable_property'; did you mean 'drm_plan=
e_create_scaling_filter_property'? [-Werror=3Dimplicit-function-declaration]
 1260 |                 drm_plane_create_zpos_immutable_property(&layer->pl=
ane, i);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                 drm_plane_create_scaling_filter_property
drivers/gpu/drm/xlnx/zynqmp_disp.c:1262:25: error: implicit declaration of =
function 'drm_plane_create_alpha_property'; did you mean 'drm_plane_create_=
color_properties'? [-Werror=3Dimplicit-function-declaration]
 1262 |                         drm_plane_create_alpha_property(&layer->pla=
ne);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                         drm_plane_create_color_properties
cc1: all warnings being treated as errors

Presumably caused by one of the commits that dropped includes from
drm-ctrc.h.

I have used the drm-misc tree from next-20220620 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/gVQErqL6wYsDqhSe=SaTGRP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKxLsgACgkQAVBC80lX
0GxVBwgAmClKyEbVOckxAjfBs5vNr2SJFtdNCTsAESyYKFo6OehLESFMGM4PYowd
1qIVF0LV4+ei7tqzU7v78DqJeYPyhhP378ZKVUPVePyFTCeCl0XoF++mseQPhsSL
vVVrK0fPvn7IQYnZ2D3xDd6x3EdWgTb4c6Pzgws5FfttFs6kywz2ovX5M0a5/SIP
nN4Y0Hgss3Yuz4N+hBiIBLFwQ7rbe7mgGOYXZGFLqqHtcHX0kbyDEtK5AIYU38P0
JuxtMGFceec+eur+VpKMuBt3ZcCeTseOTatwQaqQJV31w42+MqIaXfsq42XHAoii
x864eJ112U9CjGfohugEwax5baZcbQ==
=UKNF
-----END PGP SIGNATURE-----

--Sig_/gVQErqL6wYsDqhSe=SaTGRP--
