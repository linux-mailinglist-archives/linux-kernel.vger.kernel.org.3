Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D664EB59D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 00:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbiC2WIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 18:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbiC2WIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 18:08:53 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D2FDCE00;
        Tue, 29 Mar 2022 15:07:08 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KSkF63bNSz4xLS;
        Wed, 30 Mar 2022 09:07:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1648591627;
        bh=BHFYfTdTXAPoemnP9hx5LDEK3j9UzDVYSVRmfTfJ/ro=;
        h=Date:From:To:Cc:Subject:From;
        b=XnUSsdmLOA0avIfOKd9KHy/xquvnL+Of0SRQ+sVxtDy14lpP97zzVDlfH10Tcrk4p
         m3q/TxUmyNKugoc/tAR+1/51e2RJbdZRAIQZ256c5kOFTB8pt/rY5Xo4FyjFfRK4ay
         BwT1Su7GslgH8UpXcpPR5LQAXrbdUB9V5U7SQF8E+nfNpILtiz/ry/Hv+WbiMq9Jbm
         XsEBYiGCvQ/ibYORPWomp5gdQ6kd0ZljnuHQGE3oWo3gJxns2fQsS5x+ZhmgYk9YIV
         fB9clgE6u6oOU1A5w3dI5j4ECgVBJYL6Is8uNH/Nc6SqwKRhnoeSUq4yA+OXd9xgIV
         PCoJbTLT24H7w==
Date:   Wed, 30 Mar 2022 09:07:05 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the clk tree with Linus' tree
Message-ID: <20220330090705.1c9cbd0b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oaI4RK8f3ITm5UJd6ExZsV2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/oaI4RK8f3ITm5UJd6ExZsV2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the clk tree got a conflict in:

  drivers/clk/Kconfig

between commit:

  aa091a6a91df ("clk: lan966x: Fix linking error")

from Linus' tree and commit:

  7cd5c56054f8 ("clk: COMMON_CLK_LAN966X should depend on SOC_LAN966")

from the clk tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/clk/Kconfig
index d4d67fbae869,d8c5f30487a9..000000000000
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@@ -231,8 -241,7 +241,9 @@@ config COMMON_CLK_GEMIN
 =20
  config COMMON_CLK_LAN966X
  	bool "Generic Clock Controller driver for LAN966X SoC"
+ 	depends on SOC_LAN966 || COMPILE_TEST
 +	depends on HAS_IOMEM
 +	depends on OF
  	help
  	  This driver provides support for Generic Clock Controller(GCK) on
  	  LAN966X SoC. GCK generates and supplies clock to various peripherals

--Sig_/oaI4RK8f3ITm5UJd6ExZsV2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJDgwkACgkQAVBC80lX
0GwbbwgAgQZHJUIooxD3egXnSZz8RY09LRsKTvpVKb88olAEGjJvEOelt6bw8M/h
m+S3/WSP/2it3OvKlAsJtAI5WmzMsHouwivycr1i1lPOpstuYWhhF8K7m3LhnXpZ
DRJ0XL0Q1tit7uDJKE+kgpQZ5Qjx/sAQHakWH317YXKzMaginVOSSHVfazqj3eX8
ExK3LXu2ALwnWewZy+FVFFOp1VYcdryNcMZo5q1kmkYEhgmoMU9Vi7k7QAl3fFvT
PxPALQS7psxtZkpBi2Q87Pf50W9vQ34z/lRQKSqfH+00H77P7Rx+elEZ0na/hOxQ
CYKdOynmntnLZR2DYQ0xOzxzhNG23w==
=8M+O
-----END PGP SIGNATURE-----

--Sig_/oaI4RK8f3ITm5UJd6ExZsV2--
