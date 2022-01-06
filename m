Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8E44865D1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 15:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239961AbiAFOIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 09:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiAFOIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 09:08:41 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A2DC061245;
        Thu,  6 Jan 2022 06:08:41 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JV7Vq5DfNz4xsl;
        Fri,  7 Jan 2022 01:08:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641478116;
        bh=xpa4HuxahcJeJ7kdyszJCdHOV8qVdz1/q8Vq33o/r3A=;
        h=Date:From:To:Cc:Subject:From;
        b=oYqrc975rkvP7mQYxJsNSoPrlulySf/O2EkVE/P4doRDUWgIwdd8BqINdCIJA25QZ
         IuAHRauADD4PYiS8HW/tZyd/svvv+Vy7xTB5WGpQdpgTkjjuDBTceyiBU1nHHpwf1O
         20oVzShSa1PfdFvA7ChpJkhLYLNLVNdxFUmJIA3w+NVbsl9ZB7+ZixeJKtJiXUaI0C
         ZFUlpX9rclGXrRGYrzkARSYD1ehg0Zu+CO6ReIjEtdoWUY8mvm/byJwi9esWFR9CRU
         BTvaAMRED1oMRAFfEj7zIad4WPeyvWnHl3h1llRCtg7UiIgu7qshAE7GVlQBMmhoXg
         6G+EKzMjUKjDQ==
Date:   Fri, 7 Jan 2022 01:08:32 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the libata tree
Message-ID: <20220107010832.42c93c30@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ywAMgQktLBaHuCw80U9bZ4R";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ywAMgQktLBaHuCw80U9bZ4R
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the libata tree, today's linux-next build (powerpc
allyesconfig) failed like this:

drivers/ata/pata_cs5535.c:26:10: fatal error: asm/msr.h: No such file or di=
rectory
   26 | #include <asm/msr.h>
      |          ^~~~~~~~~~~

Caused by commit

  39d0a5fc445a ("ata: pata_cs5535: add compile test support")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/ywAMgQktLBaHuCw80U9bZ4R
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHW9+AACgkQAVBC80lX
0GyBRggAixj6r+7ph6qGXZRuRuiPpPehHNwzjswxdFj1z77gxYKhGkEzpUhrtTbt
rp0GogXzzdqdfJ8tySck4+8WozH7YIcV28nEkuPcBBQlj5tSub8GqAhbvlTkEYW2
2QRz30KFuZFWwubgX4FCJ7wAMkW9IQ4w7sjKSkun0EkqWUzEYQRbsPxP/SSUeyRJ
vDPxxBg0dZAIrNuR/RuIK7/p92PhtjpVTaOTzmey95ZSLbPWdpnnpmXRyFb6UJ06
BhDYIutPmdRp5KtA7EqoO5QNzGC9hMCbY4AvMG1gtczCwh4Pe3OoMt6R27+G3jcW
C9QGRDSdnN2NwzvovTba0J+5pZtvCQ==
=7wsr
-----END PGP SIGNATURE-----

--Sig_/ywAMgQktLBaHuCw80U9bZ4R--
