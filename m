Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E704249D623
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 00:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbiAZX3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 18:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiAZX3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:29:11 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF48C06161C;
        Wed, 26 Jan 2022 15:29:11 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jkg0P2Xg3z4y3l;
        Thu, 27 Jan 2022 10:29:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1643239749;
        bh=gy159p+nDeFwLbKD0rliIiOuHEQWw8xsfpJpm78v59c=;
        h=Date:From:To:Cc:Subject:From;
        b=rkX5nRgC6hMwUJ7n46Qep9O9+fpR8he03wN7VOTpo2ZHogJZW1iPQe5+88fe0dpD4
         ycxvAifp37EyRPRpVlAIadexXVqcT0Wc5NchRWLYTsowVHKUmzJNst+ag2fPGlQdUW
         9kWcGM5qxaKpz+FHEgdINbk86MhiXYw3lXGE57Jfi73GG7AWBMTlNPFUewFqbsHHCK
         fN6uldYfj8ZRk8UaCnlxDESr4JNNDLbj/woI8GiodJseEL33/2xl10n89zTSgGJK9t
         D6VnQXPYNaz/JlFf2bSazgisq9NIm02A/c6V4OSw8T0Pp6h1dEUr/pqNGoq/vVu6mu
         ie9QFXonDz0WA==
Date:   Thu, 27 Jan 2022 10:29:08 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the amdgpu tree with Linus' tree
Message-ID: <20220127102908.7845b53a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_l4HsC.Q60xl+m59P8T5mu2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_l4HsC.Q60xl+m59P8T5mu2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the amdgpu tree got a conflict in:

  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c

between commit:

  b95dc06af3e6 ("drm/amdgpu: disable runpm if we are the primary adapter")

from Linus' tree and commit:

  243c719e872a ("drm/amdgpu: handle BACO synchronization with secondary fun=
cs")

from the amdgpu tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b21bcdc97460,f3cada3f743b..000000000000
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@@ -1893,26 -1947,28 +1948,48 @@@ MODULE_DEVICE_TABLE(pci, pciidlist)
 =20
  static const struct drm_driver amdgpu_kms_driver;
 =20
 +static bool amdgpu_is_fw_framebuffer(resource_size_t base,
 +				     resource_size_t size)
 +{
 +	bool found =3D false;
 +#if IS_REACHABLE(CONFIG_FB)
 +	struct apertures_struct *a;
 +
 +	a =3D alloc_apertures(1);
 +	if (!a)
 +		return false;
 +
 +	a->ranges[0].base =3D base;
 +	a->ranges[0].size =3D size;
 +
 +	found =3D is_firmware_framebuffer(a);
 +	kfree(a);
 +#endif
 +	return found;
 +}
 +
+ static void amdgpu_get_secondary_funcs(struct amdgpu_device *adev)
+ {
+ 	struct pci_dev *p =3D NULL;
+ 	int i;
+=20
+ 	/* 0 - GPU
+ 	 * 1 - audio
+ 	 * 2 - USB
+ 	 * 3 - UCSI
+ 	 */
+ 	for (i =3D 1; i < 4; i++) {
+ 		p =3D pci_get_domain_bus_and_slot(pci_domain_nr(adev->pdev->bus),
+ 						adev->pdev->bus->number, i);
+ 		if (p) {
+ 			pm_runtime_get_sync(&p->dev);
+ 			pm_runtime_mark_last_busy(&p->dev);
+ 			pm_runtime_put_autosuspend(&p->dev);
+ 			pci_dev_put(p);
+ 		}
+ 	}
+ }
+=20
  static int amdgpu_pci_probe(struct pci_dev *pdev,
  			    const struct pci_device_id *ent)
  {

--Sig_/_l4HsC.Q60xl+m59P8T5mu2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHx2UQACgkQAVBC80lX
0GwTBwf/Tb79Uf7okT18k6FpEAeZaFpWeAM1y/KLwEinA/MMrh+owLlXE2ik2kuI
t2x03zdzAkbKX7ASlfSh47MxdcBrW7Cl6fXx8MtDyd+cezfjwcMZICRTOEgrLySx
WsaLLQDiySorlPNfUAUBdS0IDA8NnLd+NYEwREugvwmQizhnKRr71NmLIf/mqEwb
sUMJqDKvSm1woFf/Zfsc8POCwqsUXGItdRUOmAOtPOrWggt/F7pyg3gmVnjofAr1
FQDbLHggDs6It34HTVoxetJ2hR62wg9KYRMCrw6XL0+3D/BWxxiiOTJWRih/Cfuc
ePNIjpCdBXceFAmNDyis1xNBJ3Y8bQ==
=2kWz
-----END PGP SIGNATURE-----

--Sig_/_l4HsC.Q60xl+m59P8T5mu2--
