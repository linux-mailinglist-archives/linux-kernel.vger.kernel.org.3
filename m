Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE97B4659D0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 00:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353777AbhLAXbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 18:31:41 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:50433 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240449AbhLAXbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 18:31:39 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J4FdC5Y89z4xPv;
        Thu,  2 Dec 2021 10:28:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638401296;
        bh=HPaSMnBTtztS5JfrpBF/PhbDS6Cv227wx8hQsokeMm8=;
        h=Date:From:To:Cc:Subject:From;
        b=V6j3bspcZjL15KTamk4Gf/txF3wbGHuGYSrOINo3GAbke+5wHVU9rQTVfB5Cj5w9D
         XvNzl6Ze3CCLusuIku6uMSBZPrE7Fpf0fd9eXvhpwMtIlG3uq7KL4Xmd8cKgvtdNqy
         bf9M6Evvq5hes0b41/z0Ea+i+5Mn4+5E6OkhNMJBx1K2mvLC26lElI2XNua4cQH8ZK
         64oDVOBjnOObuLlkgVUSHXg7ijFg4bC/vafRPaLnf/eqzb8onfJ1rcieSV8Rizv8i+
         dDlSxpGmgwQknH+qQhKub4J8PHTXf9V2Q2ubDqOOCWRgRLZRVHeq195kC+z4X42dzL
         Dbm1IE4zWGOZQ==
Date:   Thu, 2 Dec 2021 10:28:14 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the pm tree
Message-ID: <20211202102814.793d2f67@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DOWq+3fcZS+Rz2u=PrO=OW4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DOWq+3fcZS+Rz2u=PrO=OW4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pm tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

drivers/powercap/dtpm.c: In function 'init_dtpm':
drivers/powercap/dtpm.c:466:21: error: unused variable 'dtpm_descr' [-Werro=
r=3Dunused-variable]
  466 |  struct dtpm_descr *dtpm_descr;
      |                     ^~~~~~~~~~
cc1: all warnings being treated as errors

Caused by commit

  f751db8adaea ("powercap/drivers/dtpm: Disable DTPM at boot time")

I have used the pm tree from next-20211201 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/DOWq+3fcZS+Rz2u=PrO=OW4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGoBQ4ACgkQAVBC80lX
0GzD2Qf/cnXtq8RlYCHvb3uXwPjiWTQG1hAoqjyB1QdqrnIMBo7E09RhLNq+/VS5
ORZPWsdnKRXoX+vXv2upapN5ZQOS2voIlMuMMUHWIg7oV+OrM2ZRIqvFzqV8U7Z3
6xqVH8bYIwLk9hdxp92Iv2+6I8Lnxq4BkIczOpnivO8HPdGlD2TaYHfVPpE1zkov
fNawG/ee2X/eZGoUqjCCZ6PxkrwcOk8QAOvgO9shZlgf/6DIoqeDjFP9JZ6MZ3gU
QzRQKEh3nRFkCTxbIqFp+Jsrt0msg+/ra+Y94YMgBV7aRCbcwnP+HLy8TM1mYP73
oE6UGMSyAE89Zf0XdNKwZ8kNzKredg==
=J1IK
-----END PGP SIGNATURE-----

--Sig_/DOWq+3fcZS+Rz2u=PrO=OW4--
