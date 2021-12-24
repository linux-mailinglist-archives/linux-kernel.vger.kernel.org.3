Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED0747EA8F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 03:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245378AbhLXCOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 21:14:54 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:55461 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbhLXCOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 21:14:53 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JKrHH5nrlz4xdB;
        Fri, 24 Dec 2021 13:14:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1640312092;
        bh=63gcLwqrHg8Fe3e63Lc6fgRXbrll9PwcAYa+KR7BT/w=;
        h=Date:From:To:Cc:Subject:From;
        b=QqKEZ0rMGfhbuJ0rtx9AHs1+Lz9Z3Zw4CTC04yF9joe5cTWG8e9oLl7FHwieuDlMc
         HxMXCTqoRVB9MzUGhLVlYRo8yjCyNna7WPdx2qYegPjhBUXuVN0SJqeUnY8GMqKVhh
         q3BofHXG0LRThahHG84vetrq6hG/9+VbJYJGSo2n934zGj9Qrh8oRjO1Ms3cD+cZUp
         cAudiJWr6M80lTW6Sa/VWgBrS7QXb355fNRYePhG0xjwa/HoQyf0De4o+3hC8oyG6P
         TW5s8unWWbKJTf9IgS7zsLRgSW5pESge9BbwrF27ZrLhLwKVObrIHV2LWotbpxvzqV
         uHn9DoIx4rKBg==
Date:   Fri, 24 Dec 2021 13:14:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the driver-core tree with the
 drivers-x86-fixes tree
Message-ID: <20211224131450.2c7e0dae@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/P_rhayNAE1PCLetlDULf7=i";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/P_rhayNAE1PCLetlDULf7=i
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the driver-core tree got a conflict in:

  drivers/platform/x86/intel/Kconfig

between commit:

  4f6c131c3c31 ("platform/x86/intel: Remove X86_PLATFORM_DRIVERS_INTEL")

from the drivers-x86-fixes tree and commit:

  a3c8f906ed5f ("platform/x86/intel: Move intel_pmt from MFD to Auxiliary B=
us")

from the driver-core tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/platform/x86/intel/Kconfig
index 40096b25994a,35a5d1a5eba8..000000000000
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@@ -170,3 -183,16 +170,14 @@@ config INTEL_UNCORE_FREQ_CONTRO
 =20
  	  To compile this driver as a module, choose M here: the module
  	  will be called intel-uncore-frequency.
+=20
+ config INTEL_VSEC
+ 	tristate "Intel Vendor Specific Extended Capabilities Driver"
+ 	depends on PCI
+ 	select AUXILIARY_BUS
+ 	help
+ 	  Adds support for feature drivers exposed using Intel PCIe VSEC and
+ 	  DVSEC.
+=20
+ 	  To compile this driver as a module, choose M here: the module will
+ 	  be called intel_vsec.
 -
 -endif # X86_PLATFORM_DRIVERS_INTEL

--Sig_/P_rhayNAE1PCLetlDULf7=i
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHFLRoACgkQAVBC80lX
0Gzpugf9E0/ttnF1guRE1jmsBeeLCh+ars5+/LX6DXvmMOCwxFVRxy/CTAXaYsId
/CMagQGa9D9IryjcEScTTAOc83HsForqKc+RlTSRaM1r4gCOFAhBHc4BDTJpZqra
xHC/2XOh//xmIYYVsbH/eDwE1b86io1FO7ybzTChGYjd+Z4F/OyvJ25BMX6IMeCt
Qlik6fsurOywC60s5Ydbva0Ir7QJF2j8V6SrftSXkfe16mPtm6Tg6EFPZhNgPP8k
3k/p01oKUVWwtmuxj/zWKz4XIk/FChczDhmB6y57z0b3pgiqyUmTqD++r6alfLjP
xFxi02u5eisAyC9ZVmYLvrIy/pYmtw==
=YTih
-----END PGP SIGNATURE-----

--Sig_/P_rhayNAE1PCLetlDULf7=i--
