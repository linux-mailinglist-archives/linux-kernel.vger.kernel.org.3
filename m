Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCBB7483971
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 01:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbiADAPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 19:15:55 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:37929 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiADAPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 19:15:54 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JSY6w5LK0z4y41;
        Tue,  4 Jan 2022 11:15:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641255353;
        bh=BkGjYzrwCeaT9F8zSkNUuvWI/Njr0yVkcljfWHn7nBU=;
        h=Date:From:To:Cc:Subject:From;
        b=XEmtNenXI71epZxNhwuN5LYhL7ugzDxLGYq73uEGVow3OGqfL6LS8iuJcr26egbkf
         S/Ng955xXvt1oAn/8cKNK+whe5D2T+IAyJyhTghfJ+9bZlZhW8MAd64pWm2LBza2T/
         8aPaxdFX35JHe6mBZLXDEucMubBNu2Ezp85WXWJfM/gIoX0sV3z3/WJ05Tjo4TMalG
         iffWRXuMG1f/lIYp5SuPtXBrd/hsdXGOu7oy71nKi2gZ91R65IbMhNFlNr2Tk2OlEN
         ahq3eGrAB/bO9bGhaGAR8TN7iNhZnC7uUeLXzE5/RTkju7hp8V54AOHUo96AT00JjF
         MYmqTgxHzsVow==
Date:   Tue, 4 Jan 2022 11:15:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the pm tree
Message-ID: <20220104111551.7f26e893@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8rVNh+u5XBEjZLUpjZfghpN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8rVNh+u5XBEjZLUpjZfghpN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pm tree, today's linux-next build (x86_84 allmodconfig)
failed like this:

sound/soc/sh/rz-ssi.c: In function 'rz_ssi_probe':
sound/soc/sh/rz-ssi.c:1023:2: error: ignoring return value of 'pm_runtime_r=
esume_and_get' declared with attribute 'warn_unused_result' [-Werror=3Dunus=
ed-result]
 1023 |  pm_runtime_resume_and_get(&pdev->dev);
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Caused by commit

  877d952c261e ("PM: runtime: Annotate pm_runtime_resume_and_get() as __mus=
t_check")

This also produced the following warnings in my arm multi_v7_defconfig
build:

drivers/crypto/stm32/stm32-hash.c: In function 'stm32_hash_hw_init':
drivers/crypto/stm32/stm32-hash.c:816:2: warning: ignoring return value of =
'pm_runtime_resume_and_get' declared with attribute 'warn_unused_result' [-=
Wunused-result]
  816 |  pm_runtime_resume_and_get(hdev->dev);
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/crypto/stm32/stm32-hash.c: In function 'stm32_hash_import':
drivers/crypto/stm32/stm32-hash.c:1003:2: warning: ignoring return value of=
 'pm_runtime_resume_and_get' declared with attribute 'warn_unused_result' [=
-Wunused-result]
 1003 |  pm_runtime_resume_and_get(hdev->dev);
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/crypto/stm32/stm32-hash.c: In function 'stm32_hash_export':
drivers/crypto/stm32/stm32-hash.c:965:2: warning: ignoring return value of =
'pm_runtime_resume_and_get' declared with attribute 'warn_unused_result' [-=
Wunused-result]
  965 |  pm_runtime_resume_and_get(hdev->dev);
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/crypto/stm32/stm32-cryp.c: In function 'stm32_cryp_hw_init':
drivers/crypto/stm32/stm32-cryp.c:545:2: warning: ignoring return value of =
'pm_runtime_resume_and_get' declared with attribute 'warn_unused_result' [-=
Wunused-result]
  545 |  pm_runtime_resume_and_get(cryp->dev);
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I have used the pm tree from next-20211224 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/8rVNh+u5XBEjZLUpjZfghpN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHTkbcACgkQAVBC80lX
0GwBKAgAkP9MzfHPRwpQs1r8tZP6C1JB5PmQJgtIzu/74+p5IDCdI2ps/Vjpe/z8
89cP3Y99d1hsinQytnX/fBouU8Nf3FrCcuHrvfROJ37bzyzXpH0P8SugmuyslvRW
iiJAccgMl9X1ltuU60leQFU/MtbC/67q+tQIsV4DyFi2qnYFnRQYFQ6TP49d0VHo
x2j03dCVQc4iq+QjLyHUmfe6AdrRzNQU6oDAObZsJZ95nS0tK9LVfxeb8jOrq+l9
z2QRBIM+jJE6CtCO/NecSQuoaoXSz1IokUF+3b3u97aRzju0DLFNBOSQYOgwolp7
nnVmcdqrqFR2bR6f0dp0F4zLtFNhGg==
=n7yp
-----END PGP SIGNATURE-----

--Sig_/8rVNh+u5XBEjZLUpjZfghpN--
