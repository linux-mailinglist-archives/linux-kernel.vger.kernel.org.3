Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A9756B31D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237243AbiGHHKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236803AbiGHHKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:10:43 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DFE7694E;
        Fri,  8 Jul 2022 00:10:41 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LfPZ564nVz4xRC;
        Fri,  8 Jul 2022 17:10:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657264240;
        bh=g2bE+8fl/oBbo7lnGZqOvhPk3U8/hBGpGnWzWC/HYSY=;
        h=Date:From:To:Cc:Subject:From;
        b=cvdvol/JK1lXHXiWkyY3umERUj6tSYIV0GepFBnv/X3K+XSPQNEsEKHEp0La6O6rf
         oVYJB6S9dFT8DN0/Np4OqM+z4Xpw+YCboY908C0CyjBceHVzoYSMVKIvxWfJ8WxER9
         JfkVaybPAAGCcshgpGZJSdaS7euDEzp46igAt3Kxfkr30fyd+ELYJlUXxnBfMVN2Mo
         /8hkDebDg5t7DKQwa7X4BD0Chdr6SDCxXeuf5NmbxpIE9CfhWQ/zYSWhP1RxO9KZPa
         XH9pqPtCHubC5cdihDsNmwUCHm0cbXiDe0wi5pmReJkylVQhCMpFseVMS4zL/SaI8p
         SJRVCgyd3FDwg==
Date:   Fri, 8 Jul 2022 17:10:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@suse.de>, Jonathan McDowell <noodles@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the random tree with the tip tree
Message-ID: <20220708171030.135b12cd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Avnb=Jv4FeixyahQTk7zHJk";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Avnb=Jv4FeixyahQTk7zHJk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the random tree got conflicts in:

  arch/x86/include/uapi/asm/bootparam.h
  arch/x86/kernel/kexec-bzimage64.c
  arch/x86/kernel/setup.c

between commit:

  b69a2afd5afc ("x86/kexec: Carry forward IMA measurement log on kexec")

from the tip tree and commit:

  c337d5c7ec9b ("x86/setup: Use rng seeds from setup_data")

from the random tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/x86/include/uapi/asm/bootparam.h
index ca0796ac4403,a60676b8d1d4..000000000000
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@@ -11,7 -11,7 +11,8 @@@
  #define SETUP_APPLE_PROPERTIES		5
  #define SETUP_JAILHOUSE			6
  #define SETUP_CC_BLOB			7
 -#define SETUP_RNG_SEED			8
 +#define SETUP_IMA			8
++#define SETUP_RNG_SEED			9
 =20
  #define SETUP_INDIRECT			(1<<31)
 =20
diff --cc arch/x86/kernel/kexec-bzimage64.c
index c63974e94272,13b2c55ebbf0..000000000000
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@@ -217,7 -212,8 +239,8 @@@ static in
  setup_boot_parameters(struct kimage *image, struct boot_params *params,
  		      unsigned long params_load_addr,
  		      unsigned int efi_map_offset, unsigned int efi_map_sz,
- 		      unsigned int setup_data_offset)
 -		      unsigned int efi_setup_data_offset,
++		      unsigned int setup_data_offset,
+ 		      unsigned int rng_seed_setup_data_offset)
  {
  	unsigned int nr_e820_entries;
  	unsigned long long mem_k, start, end;
@@@ -435,12 -427,10 +461,14 @@@ static void *bzImage64_load(struct kima
  	params_cmdline_sz =3D ALIGN(params_cmdline_sz, 16);
  	kbuf.bufsz =3D params_cmdline_sz + ALIGN(efi_map_sz, 16) +
  				sizeof(struct setup_data) +
- 				sizeof(struct efi_setup_data);
+ 				sizeof(struct efi_setup_data) +
+ 				sizeof(struct setup_data) +
+ 				RNG_SEED_LENGTH;
 =20
 +	if (IS_ENABLED(CONFIG_IMA_KEXEC))
 +		kbuf.bufsz +=3D sizeof(struct setup_data) +
 +			      sizeof(struct ima_setup_data);
 +
  	params =3D kzalloc(kbuf.bufsz, GFP_KERNEL);
  	if (!params)
  		return ERR_PTR(-ENOMEM);
diff --cc arch/x86/kernel/setup.c
index 53f863f28b4c,409de5308a8c..000000000000
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@@ -415,9 -356,15 +416,18 @@@ static void __init parse_setup_data(voi
  		case SETUP_EFI:
  			parse_efi_setup(pa_data, data_len);
  			break;
 +		case SETUP_IMA:
 +			add_early_ima_buffer(pa_data);
 +			break;
+ 		case SETUP_RNG_SEED:
+ 			data =3D early_memremap(pa_data, data_len);
+ 			add_bootloader_randomness(data->data, data->len);
+ 			/* Zero seed for forward secrecy. */
+ 			memzero_explicit(data->data, data->len);
+ 			/* Zero length in case we find ourselves back here by accident. */
+ 			memzero_explicit(&data->len, sizeof(data->len));
+ 			early_memunmap(data, data_len);
+ 			break;
  		default:
  			break;
  		}

--Sig_/Avnb=Jv4FeixyahQTk7zHJk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLH2GYACgkQAVBC80lX
0Gyptgf/UryjIQXJ/UAbkaQGeEkhF+b7gmeNmjrSWtf4rdHP2EKo7J7IfN4XXT2u
4hWw4CVjHTTfB9w/T9N0Bgw04UJv6wVUyE6ySWkDL+EKI+wQPKaw1qsSMovHdIbx
pWc4jk8M2B9OBS9SRYJzJ5Qhe++rGRUdbSzc6IslLtgS/iwLJ6vjyIjhALOCl0+i
BXA95abPBAdxRiGgS96ZZbGSPEQZXdSjcCMDnKqiJBwFT7Z4qDHuhDhcxCCbISCc
xPjre+L/14TnwyUP4MkrDoLEblFok3rR776IzkhC0fuMHZv5Bzwi+oZGluBgDzw/
oPbaBMNLHGx7wKvBH+m+bzcjvDSKzw==
=kNmJ
-----END PGP SIGNATURE-----

--Sig_/Avnb=Jv4FeixyahQTk7zHJk--
