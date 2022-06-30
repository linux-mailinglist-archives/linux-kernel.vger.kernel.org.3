Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D8C561080
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 07:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbiF3FPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 01:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiF3FPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 01:15:17 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22071CB2E;
        Wed, 29 Jun 2022 22:15:15 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LYRNd2w2Yz4xRC;
        Thu, 30 Jun 2022 15:15:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1656566113;
        bh=ZQv+wLBSU6RnRAVqdiHCzda/kP6b/kTLaNcNGfOuLZU=;
        h=Date:From:To:Cc:Subject:From;
        b=AtXynY3rrXIfjGlqBjiSB9m4cE2DgeH7rTNrlUiBYIfPS3+3WlC3xt9Axf3PAIunF
         MKQJeghEjAFmB0lKR3fTADixTU8SJXG7qidRvgVav9E/VFKZW0PqUWZuxha1f3RdUm
         ePaZp7x7C/NILiLo8yqysiMDJu5Ewq27tAwhnR216Q+KagJYMwD9bFj1/RPH3+w/N1
         edCgMnq5JIYPACZZkh+VnQ/qyDtlwHxEn9pEQOm2r/XYRtNjObPCW5SFzrWkgSAElV
         AkpP+Sc5JKjsbYnvOcIHxx0LF3q9YFdrBNCXaAPQg8NYIDIxGj23i7FI0jjRstPbXg
         YXIbMHbgDMwjg==
Date:   Thu, 30 Jun 2022 15:15:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Phil Edworthy <phil.edworthy@renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the pinctrl-renesas tree
Message-ID: <20220630151511.58281e52@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Sc/Tj+FssHOhk5XcHCHyM+5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Sc/Tj+FssHOhk5XcHCHyM+5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pinctrl-renesas tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/pinctrl/renesas/pinctrl-rzv2m.c: In function 'rzv2m_dt_subnode_to_m=
ap':
drivers/pinctrl/renesas/pinctrl-rzv2m.c:37:33: error: implicit declaration =
of function 'FIELD_GET' [-Werror=3Dimplicit-function-declaration]
   37 | #define MUX_FUNC(pinconf)       FIELD_GET(MUX_FUNC_MASK, (pinconf))
      |                                 ^~~~~~~~~
drivers/pinctrl/renesas/pinctrl-rzv2m.c:306:31: note: in expansion of macro=
 'MUX_FUNC'
  306 |                 psel_val[i] =3D MUX_FUNC(value);
      |                               ^~~~~~~~
cc1: all warnings being treated as errors

Caused by commit

  1e18476c392f ("pinctrl: renesas: Add RZ/V2M pin and gpio controller drive=
r")

I have used the pinctrl-renesas tree from next-20220629 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/Sc/Tj+FssHOhk5XcHCHyM+5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmK9MV8ACgkQAVBC80lX
0Gx++ggAgyA4Zxyrf+FOItez8dws4o8w4fUixQ9Z2VX4QEbymYV4kODUMbcgKGxs
CeVdlDfCRaTrnqTIKhqMJA50m1WHFFWnEolrC/SUPr4va5w9b4ds2HTuEPmS89yd
w58wgprLrPX6g/ryZ5gz+Fnnrx1cQrJcT3NxVqW+/5f88n7bDw0Jtal5LCnAFwLm
vZOVMCTWJp9PwWkqU64YwR5W08OUIXq07OF7rbzfzvXqofLGxBMozC+6jelVlJLe
elKHDEvHaALIe0sRAiHGKbenKGP/7PByBIMA0lwCxJLAFRaSVkpylv6wIOH6KFXV
Dt469lZfo7qDm+w1/LMX8LGSVWNgRA==
=pEqB
-----END PGP SIGNATURE-----

--Sig_/Sc/Tj+FssHOhk5XcHCHyM+5--
