Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859014C7D40
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 23:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiB1W2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 17:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiB1W2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:28:16 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4831009;
        Mon, 28 Feb 2022 14:27:35 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K6w4334nhz4xNq;
        Tue,  1 Mar 2022 09:27:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646087251;
        bh=BNxDQe5VTzqxcywd6eToBVSDG4uIxuEp5NhVFGmx2z4=;
        h=Date:From:To:Cc:Subject:From;
        b=OgfAaj9F+5sIkGhDruQtLfCygWBHX7+1cbarvgf7JMBRkppJbcDL+nQrx45yveJNa
         ZFrWBcDF4B/TzPwLXNXTRkBSc7SzyJ5mPE9+GvEZXI13avJQ12mEBbRYb762yutbiu
         aQPaQ3eFtRueQOsDJT9Xw67k0khzJ1xGFPM4TDDjsIoSSFitvo+tyTh77JYQ9YM+jN
         HPWxsQu1a+zZqgBjXmumRgvLwpTFc+i6AFQaUGfjLNWsTIe5u1Woh1CQylsiEpn0LY
         PT4PqV/tmhml1HGp2k69W5bUjz+9IS5oFYA8y1IJI2Xe2FiLwqw0VYOquZd6srG0nz
         0OgkTVwa77/Yg==
Date:   Tue, 1 Mar 2022 09:27:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the kspp tree
Message-ID: <20220301092730.10de23c5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pfqV5CKsIcM+XrwHc7zQGP_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pfqV5CKsIcM+XrwHc7zQGP_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kspp tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/gpu/drm/drm_dp_helper.c: In function 'drm_dp_pcon_dsc_bpp_incr':
drivers/gpu/drm/drm_dp_helper.c:3130:28: error: array subscript 12 is outsi=
de array bounds of 'const u8[12]' {aka 'const unsigned char[12]'} [-Werror=
=3Darray-bounds]
 3130 |         buf =3D pcon_dsc_dpcd[DP_PCON_DSC_BPP_INCR - DP_PCON_DSC_EN=
CODER];
      |               ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
drivers/gpu/drm/drm_dp_helper.c:3126:39: note: while referencing 'pcon_dsc_=
dpcd'
 3126 | int drm_dp_pcon_dsc_bpp_incr(const u8 pcon_dsc_dpcd[DP_PCON_DSC_ENC=
ODER_CAP_SIZE])
      |                              ~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~
drivers/gpu/drm/drm_dp_helper.c: In function 'drm_dp_get_adjust_request_pos=
t_cursor':
drivers/gpu/drm/drm_dp_helper.c:59:27: error: array subscript 10 is outside=
 array bounds of 'const u8[6]' {aka 'const unsigned char[6]'} [-Werror=3Dar=
ray-bounds]
   59 |         return link_status[r - DP_LANE0_1_STATUS];
      |                ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/drm_dp_helper.c:147:51: note: while referencing 'link_statu=
s'
  147 | u8 drm_dp_get_adjust_request_post_cursor(const u8 link_status[DP_LI=
NK_STATUS_SIZE],
      |                                          ~~~~~~~~~^~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

I can't see what in the kspp tree suddenly brought this on, so I have
used the kspp tree from next-20220228 for today.

In case it matters: x86_64-linux-gnu-gcc (Debian 11.2.0-9) 11.2.0
--=20
Cheers,
Stephen Rothwell

--Sig_/pfqV5CKsIcM+XrwHc7zQGP_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIdTFIACgkQAVBC80lX
0Gxk9gf/U8p/6zXUjBhT2tpqL+4KZuXPKciGwjI8N3UxEXk0Tp1uAFLP+qQnqcMT
VOfDSTFcErYXOqJNgLez8M4BDK+LG+d0DnKoD+yH/Ioww93lVb0ivUvQKyCD7df5
N1SEVCmEaUlL7u3eEbZ5Mgb8gfxX+SS9WLqhHWM2LVEoty/oUqoufnNewTc8HWWW
xcsSnIr4eBExC6Y6Y1tbXNtQ/3ZPCbrYeSg68C0vCxIaZT/qBHfPi1QGaEA1Yokk
6A6+6APAUP47XuSu7HNZgl02lnpe6gyLj971u/F+Fw1M4OLjXLyukoIr35xhuiyP
po4x3meJa0naeQFDfaFN6B2jgIE+Vg==
=2pJJ
-----END PGP SIGNATURE-----

--Sig_/pfqV5CKsIcM+XrwHc7zQGP_--
