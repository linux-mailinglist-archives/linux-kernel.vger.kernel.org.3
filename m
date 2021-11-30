Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC845462AE2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 04:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237758AbhK3DJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 22:09:46 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:48711 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbhK3DJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 22:09:45 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J36Yr0RJFz4xR9;
        Tue, 30 Nov 2021 14:06:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638241586;
        bh=9Fto66dktm+JaJ90zXYiLrZbQU8DLYWBo+foV4w+9NM=;
        h=Date:From:To:Cc:Subject:From;
        b=tEZfI1K/tOL3V3GZoo+lLIu/oYzHDPzP85Dv9Fp0hSWeeAzoPEEjojnBWwoCAH1/7
         EbOxKZLYTTS0z8ol+Nf2WsqL/9zZ0WWrEPGzDAy5NwQJzcHMASBtlo0b0PnpjcDI5Y
         tshP0H0h0rdgsFLnOnlmvlNfBWkVonJ4GqvViTHrvTFzHQqqw1M4y5pQ5Lsxom1tDP
         gpgxXavGnpSSFfc4JjxG+V7Gt35zg400eDaL6Oz4SVFox4/OJA/MGfX76+8t1gYGLR
         7qzTpjemHSkZ0R6l7LWzVWzIGs44kwWUuaURTimseeEOaq0nGponwXE3dGvbdQ9ir6
         nnDe1WWFkZPlg==
Date:   Tue, 30 Nov 2021 14:06:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Alex Gaynor <alex.gaynor@gmail.com>,
        Ayaan Zaidi <zaidi.ayaan@gmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Finn Behrens <me@kloenk.de>, Gary Guo <gary@garyguo.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: linux-next: manual merge of the rust tree with the coresight tree
Message-ID: <20211130140621.29261096@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KLz+i/mIm7X77RwIZpztsHL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KLz+i/mIm7X77RwIZpztsHL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rust tree got conflicts in:

  samples/Kconfig
  samples/Makefile

between commit:

  ede5bab874f5 ("coresight: syscfg: Example CoreSight configuration loadabl=
e module")

from the coresight tree and commit:

  2218f3460793 ("samples: add Rust examples")

from the rust tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc samples/Kconfig
index 22cc921ae291,8cbd6490823f..000000000000
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@@ -241,19 -223,6 +241,21 @@@ config SAMPLE_WATCH_QUEU
  	  Build example userspace program to use the new mount_notify(),
  	  sb_notify() syscalls and the KEYCTL_WATCH_KEY keyctl() function.
 =20
 +config SAMPLE_CORESIGHT_SYSCFG
 +	tristate "Build example loadable module for CoreSight config"
 +	depends on CORESIGHT && m
 +	help
 +	  Build an example loadable module that adds new CoreSight features
 +	  and configuration using the CoreSight system configuration API.
 +	  This demonstrates how a user may create their own CoreSight
 +	  configurations and easily load them into the system at runtime.
 +
+ source "samples/rust/Kconfig"
+=20
  endif # SAMPLES
 +
 +config HAVE_SAMPLE_FTRACE_DIRECT
 +	bool
 +
 +config HAVE_SAMPLE_FTRACE_DIRECT_MULTI
 +	bool
diff --cc samples/Makefile
index 1ae4de99c983,291663e56a3c..000000000000
--- a/samples/Makefile
+++ b/samples/Makefile
@@@ -32,4 -30,4 +32,5 @@@ obj-$(CONFIG_SAMPLE_INTEL_MEI)		+=3D mei
  subdir-$(CONFIG_SAMPLE_WATCHDOG)	+=3D watchdog
  subdir-$(CONFIG_SAMPLE_WATCH_QUEUE)	+=3D watch_queue
  obj-$(CONFIG_DEBUG_KMEMLEAK_TEST)	+=3D kmemleak/
 +obj-$(CONFIG_SAMPLE_CORESIGHT_SYSCFG)	+=3D coresight/
+ obj-$(CONFIG_SAMPLES_RUST)		+=3D rust/

--Sig_/KLz+i/mIm7X77RwIZpztsHL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGllS0ACgkQAVBC80lX
0Gw4GAf/SxZuoak7Ref3IZtCE3sUalYZWjborxdyqqhyma3RmXpEpwyoc3Iib5x2
rdIKapj8cubsJrJ2ha7kpvce39nzPiA1IQj6kI33GY6HkRwjd+cNWXxtC26QZvXZ
BNHAg1u9lfjAAil1vzr3ttPoxpgy0Pn+vKS8Qxfr2yj1yDfNYBS9/1C6TZ69d+Y8
Vh7vVa37KYbhnLG0/MlA4fWZzk6ozkPjiIfy+lapsXQDFLX5Ywt3hRWPnKeByanI
i4YH8sx4Zsx1i13PeKOLSvvKwCWaM7G7pfNRbhR6ejdsNU5j6jEy+DTBPOwW+0SY
3v8J0EK0pFC4yvSWXsO0PEfdD/s4lg==
=OMM9
-----END PGP SIGNATURE-----

--Sig_/KLz+i/mIm7X77RwIZpztsHL--
