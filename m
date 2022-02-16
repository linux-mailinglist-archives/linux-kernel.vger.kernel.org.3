Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808414B7FF9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 06:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344584AbiBPFRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 00:17:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbiBPFRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 00:17:40 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978DD2BB1D;
        Tue, 15 Feb 2022 21:17:26 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jz5mw2cLbz4xcY;
        Wed, 16 Feb 2022 16:17:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644988641;
        bh=ZPDaBiJk/Ek5Bsq6D2wt0Lqku2nuzyvwJLp3pCK+//g=;
        h=Date:From:To:Cc:Subject:From;
        b=D053Ti0g+iUW4Upo0l3eOJYpfny7eBOeWqK5Xc8V5cvqDee3CE//eu/kCuEUJQxMX
         EgTKW4fNkYEpmV+HH55Q3E+/kEjvdFrGt9cV/44JIis9PcKsWDsMkc4Rkw+XvYYeXI
         R7UE6kQnPDiQUgxkRtjjsth1Z7aztSA0hY5nI0FBs+tp/vSiTCq3ltRQG5CJG2TpiH
         qRPPbsyUUbFBjp7kkut55lY9CoJj+6dQOkXLz6bUfFjGN7PxHiL7HIs5K1e2zqr6cV
         2BsKHGgoR87OmP7vyGzGFyY8ck0oN50D3QFeAIROxprZZ6JeU+Zkvp7V+hpGDzCE2e
         mVzcFFUMpWT6g==
Date:   Wed, 16 Feb 2022 16:17:18 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>
Cc:     =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the spi tree
Message-ID: <20220216161718.2c094b08@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FGvvKnNVsJrqZ.k9wFXcCc+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FGvvKnNVsJrqZ.k9wFXcCc+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the spi tree, today's linux-next build (powerpc
allyesconfig) failed like this:

drivers/spi/spi-amd.c:333:37: error: 'spi_acpi_match' undeclared here (not =
in a function)
  333 |                 .acpi_match_table =3D spi_acpi_match,
      |                                     ^~~~~~~~~~~~~~

Caused by commit

  209043554915 ("spi: amd: Add support for version AMDI0062")

CONFIG_ACPI is not set for this build.

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/FGvvKnNVsJrqZ.k9wFXcCc+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIMiN4ACgkQAVBC80lX
0GxRUgf9G99HdntgwV9aFHsLULxCpRx8owCEIJt/ldzMbedfHKGoTz/IZFbSe1tD
6/GEFzIhJdMth7BBYTCLnqxSeMNqmzes2n25pkFa/gaYTN1tG4W7X5tojtRLTYbj
O6FFmF1TfbM4FDlhW/+zJ8v3L15d9Wm3ha/2KtM4DPUOEnaSZt5QR3I7jgOJCrVJ
I1CKSoyWhvqN+XDYt0XjiVuz4tkR1CP0rjQwNqGVeFyNDvDyYkOVw4uXDPgHNs42
HdlgNDW4+KpL6tw7NlphXmhMXWQY4VimLiDlCoHA160FGoUjxPWeKMRNRMDSHY4y
0IFsuUXQ8kMG/z6fnC45JHKQyp1/Tg==
=DsNP
-----END PGP SIGNATURE-----

--Sig_/FGvvKnNVsJrqZ.k9wFXcCc+--
