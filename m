Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4593450F0CC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245047AbiDZGTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 02:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244795AbiDZGT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:19:27 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BE7DFA0;
        Mon, 25 Apr 2022 23:16:20 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KnWq556BKz4xLb;
        Tue, 26 Apr 2022 16:16:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650953779;
        bh=Rz7R1qcyRB/h7ziJSljHEn9CO+x/cgNygE/+4YeJmAg=;
        h=Date:From:To:Cc:Subject:From;
        b=cTji6UeS2v073elvvX37udVMF5efKJJC7pqoBaFpeih3CeuZuGB4aB+lolS/22Brg
         GXmsuYQ7oCErbO+7DhYHaLeqvqMnvCNPgyanqLJxl56MdmKM58Pst+Ywr+yU8oCeCc
         iXKC287S0aIvxtX1NcKM7ZMCXFRU7dDEsLzUM7qK5WhRWUPu4hCKsxgHXZ+WlTfPfJ
         u+RxQdeJ2g3Fu4uC5LNEPeh6zJz4/XtmGzVbsOvD4BzMjcyL8A4y5+iO9abNU6St2g
         cbQD8KwtrNc+63RlP7zpWBr4MSW6rPf50h4pkKwMKM89DFHl5Y+sKOz9rdULTCiJ1W
         vRE3ZV7+EcQSA==
Date:   Tue, 26 Apr 2022 16:16:16 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@suse.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: linux-next: manual merge of the efi tree with the tip tree
Message-ID: <20220426161616.798cf1f2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/t4oeLJikwLUO0H4lJCq9nSO";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/t4oeLJikwLUO0H4lJCq9nSO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the efi tree got conflicts in:

  drivers/virt/Kconfig
  drivers/virt/Makefile

between commits:

  fce96cf04430 ("virt: Add SEV-SNP guest driver")
  9617f2f48310 ("virt: sevguest: Rename the sevguest dir and files to sev-g=
uest")

from the tip tree and commit:

  cbabf03c3ef3 ("virt: Add efi_secret module to expose confidential computi=
ng secrets")

from the efi tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/virt/Kconfig
index 0c1bba7c5c66,c877da072d4d..000000000000
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@@ -48,6 -48,6 +48,8 @@@ source "drivers/virt/nitro_enclaves/Kco
 =20
  source "drivers/virt/acrn/Kconfig"
 =20
 +source "drivers/virt/coco/sev-guest/Kconfig"
 +
+ source "drivers/virt/coco/efi_secret/Kconfig"
+=20
  endif
diff --cc drivers/virt/Makefile
index b2e6e864ebbe,067b5427f40f..000000000000
--- a/drivers/virt/Makefile
+++ b/drivers/virt/Makefile
@@@ -9,4 -9,4 +9,5 @@@ obj-y				+=3D vboxguest
 =20
  obj-$(CONFIG_NITRO_ENCLAVES)	+=3D nitro_enclaves/
  obj-$(CONFIG_ACRN_HSM)		+=3D acrn/
 +obj-$(CONFIG_SEV_GUEST)		+=3D coco/sev-guest/
+ obj-$(CONFIG_EFI_SECRET)	+=3D coco/efi_secret/

--Sig_/t4oeLJikwLUO0H4lJCq9nSO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJnjjAACgkQAVBC80lX
0GwtqQf9HPq5y/eYfvrTvd5/685bvFK2DEGd61OkthwypVVxPcy9NpUo030oxyqg
smy4RST/wCm9OfK8Xq5/uU47IfHZv4fL0jR0M/VbUegl0YDL/iuLLt8vbFiWsB+t
ldw40tS82WLYVLVSj2kREppOXYC376tStn2KW34MPpHuEspCjfyZ0eNsK706b8J5
ECnzpLg0R/TyDM2NxYBgRtV4obbPqJ6AP7W7Mmg0/V4UzPRNnz+5u84I2BW+8vAR
9jmymeRCjMhS7vhYW7evzqOXJqPjDATrQMQds6Q/H8Md/VePzTsqXKPzom6xaSsu
mWzGsQ7uzc410KoxyAa/WDOlDCzwdA==
=YQeW
-----END PGP SIGNATURE-----

--Sig_/t4oeLJikwLUO0H4lJCq9nSO--
