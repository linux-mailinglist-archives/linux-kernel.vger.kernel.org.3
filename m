Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E17567BB7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 03:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiGFBzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 21:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiGFBzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 21:55:42 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BD6F5A7;
        Tue,  5 Jul 2022 18:55:39 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ld2gT1CJjz4xD9;
        Wed,  6 Jul 2022 11:55:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657072534;
        bh=mazlfcTvHDFdNxv/WJ27nG9eAXcn0s8xLMFVyimG1WU=;
        h=Date:From:To:Cc:Subject:From;
        b=EUfUiGCAvodUOjzeDFdT6nhshGqvcbvXwjDfv53XpEn74FKfsth8NhjUCkd4ebXls
         V5vMerl1OJOoHyeUaUFiCIdnT+ejo6KBUnJrVsAhRj8+CKr3Q/ZF4PbNTtlcXxeK+U
         YNxtFKc/mYFHRDgT6Y+hgKtwnYFxhx/u7aQDgUTFENv1YGzEO9MDqfxpx5PbaQEyoi
         0dzftqW2mO0DdMG0VymHXTtc01wdPw0GpmNZFu9wzenruPIO3j5JtG6lCWs7GiYyBD
         RDWB4gjlYoGmCnvVgvkD/SstS5jqtBCVy+m30la40neyPUnJ7uJPTHic5eXqvBy/JB
         FcZ44vBIZOFRg==
Date:   Wed, 6 Jul 2022 11:55:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Amadeusz =?UTF-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the sound-asoc tree
Message-ID: <20220706115529.7deea289@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VFzInB2RX5dS4iDcD.IhnYZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VFzInB2RX5dS4iDcD.IhnYZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the sound-asoc tree, today's linux-next build (x86_64
allmodconfig) failed like this:

sound/soc/intel/avs/boards/i2s_test.c: In function 'avs_i2s_test_probe':
sound/soc/intel/avs/boards/i2s_test.c:130:60: error: format '%ld' expects a=
rgument of type 'long int', but argument 4 has type 'int' [-Werror=3Dformat=
=3D]
  130 |         card->name =3D devm_kasprintf(dev, GFP_KERNEL, "ssp%ld-loop=
back", ssp_port);
      |                                                          ~~^       =
     ~~~~~~~~
      |                                                            |       =
     |
      |                                                            long int=
     int
      |                                                          %d
cc1: all warnings being treated as errors

Caused by commit

  e39acc4cfd92 ("ASoC: Intel: avs: Add I2S-test machine board")

I have used the sound-asoc tree from next-20220705 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/VFzInB2RX5dS4iDcD.IhnYZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLE65EACgkQAVBC80lX
0GzS0Af/YSwIFMvvWYfFz6A4lqsFBy75/UVdGQ/xGjEej28WnHpTsiLLvOHIu/xg
3DOGtdk3Hk0ze3XeV/b1w4xovV/qIb2maCFPxqxHCsxDPGP8QvjyKI20FxzuJhyi
XvDVDcAYgjKCZ0ub/v5x8xGzS57j4friorhPDjVZ9RYb2ZdPmJrGMrviLVCT2t0+
d1eIHYFxkF4/SW/psM3J86B/uw61uHl/cP6XjOcgxUiJaKjNU1zwjND1IH5sye1K
jhQX5NJ4NoUYsusxvJ3oDYiryPERNhKPsBSyxwWsOawbjWZZ1yR6TmStZe5ymf5u
/FNdcxVmtyWmw1Ea6xLFpvpI85fPjg==
=ByeV
-----END PGP SIGNATURE-----

--Sig_/VFzInB2RX5dS4iDcD.IhnYZ--
