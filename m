Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE054E5F65
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348574AbiCXHbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347922AbiCXHbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:31:32 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2354F98F7E;
        Thu, 24 Mar 2022 00:30:00 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KPH1K6tJQz4xLS;
        Thu, 24 Mar 2022 18:29:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1648106998;
        bh=zl1K11ExOjw0rzgZFetgYpA2ajms3q9F4tr5xHSwZhM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=biLFsUmnLBTt9DHqqKduKX9esRWaHezjR4sVG0Q+DgYZm940RrurzNGxUsqrvUDhG
         TGvL1Ytav2fauEOmetsBd3nnBhkJP+vn5lz5LFUEb+igHMRpUAWEn7iKR5JBBwFmgS
         S6LxxCK2IZQaviaUKziuchd7fx8EnzuIjRLJSPDkHRf3LPWCUw6+TBHlQTfR5GMOzW
         8yoqdsfdg7G/jELba8WmO3ZJZXhpMFh5qUTDG/Pvp1HYuSYZnjLiNLPvoKyXFqUWWu
         xsC6mIuC87+VvkUgAi0V+jQS3ZdGn2Gfq+FYhOBdnRrl2utazCJ5xSQIpDTSzlRM4l
         DPKBbqC2E/nBA==
Date:   Thu, 24 Mar 2022 18:29:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the vfs tree with the arm64 tree
Message-ID: <20220324182956.2b47b244@canb.auug.org.au>
In-Reply-To: <20220217100354.73b552d9@canb.auug.org.au>
References: <20220217100354.73b552d9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/keBY.CT9VClL2=45OdZGIBc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/keBY.CT9VClL2=45OdZGIBc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 17 Feb 2022 10:03:54 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Today's linux-next merge of the vfs tree got a conflict in:
>=20
>   arch/x86/um/Kconfig
>=20
> between commit:
>=20
>   b62a8486de3a ("elfcore: Replace CONFIG_{IA64, UML} checks with a new op=
tion")
>=20
> from the arm64 tree and commit:
>=20
>   6692531df62d ("uml/x86: use x86 load_unaligned_zeropad()")
>=20
> from the vfs tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
>=20
> diff --cc arch/x86/um/Kconfig
> index ead7e5b3a975,4eb47d3ba625..000000000000
> --- a/arch/x86/um/Kconfig
> +++ b/arch/x86/um/Kconfig
> @@@ -8,7 -8,7 +8,8 @@@ endmen
>  =20
>   config UML_X86
>   	def_bool y
>  +	select ARCH_BINFMT_ELF_EXTRA_PHDRS if X86_32
> + 	select DCACHE_WORD_ACCESS
>  =20
>   config 64BIT
>   	bool "64-bit kernel" if "$(SUBARCH)" =3D "x86"

This is now a conflict between the vfs tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/keBY.CT9VClL2=45OdZGIBc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmI8HfQACgkQAVBC80lX
0GyV5wgAl3OGWJBibZyuOvHOJOq+Vki8aubZoU9IrfBfDcfBefGW74hiaXTs9qWA
+PstU4h/qOJyZvU8NbwXmlWtpDWRWsOlwEM0/HjhLUTM9CVWIh0TD46GFoUayYk+
/kLondt+nsqJIONERhljirssYZaHxlvpvKL4hgRGtsCR5/dG57kqp9zIonxk8bYU
iqYBNt+4E6t4ky91Qhr4ri1n9TQd6GQIvtu8Ksud2tWerngEuMAFxKwOdgPwdvQ/
fEKmqHNizw42rHVI8eBl9BqahDhXyLB/LixJymseP6uhu+IupaAcxdaIn72xV+ZR
eofOC5vTE01lBfyek0cvv58+6usdPg==
=Gqc1
-----END PGP SIGNATURE-----

--Sig_/keBY.CT9VClL2=45OdZGIBc--
