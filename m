Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84CF4D2CD1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 11:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbiCIKLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 05:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiCIKLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 05:11:34 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504DB166E0E;
        Wed,  9 Mar 2022 02:10:34 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KD7HW42vYz4xnG;
        Wed,  9 Mar 2022 21:10:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646820632;
        bh=gu3kMGWFNLQXKkpbB43CMf28pC0QJmfuIs98feV0Ycc=;
        h=Date:From:To:Cc:Subject:From;
        b=jOqmq6OqxRmPGmTHfhyBy7sV0Doq3Bu1qWHD6B2ElxmIaa01GolG7VoEHHuy3BRyA
         h/JZVqRMZ/gppO5EOq2TH5EqJwYL0a7yCHugMqNB0N0S2F04DttAE8hCrqRZgAAYUs
         XsAqpfZveToFzEj3E2L3CJCm3RpCOpkE5FeDlXgwSMUE0LKoDAzaE3946ATFt9bWt9
         FpfOcXAL7XGerI5YtdJ1K4qVlN7M1vHGK0kg+dHla1NdNay0mGQ8+t3KyGEcLOA1Xp
         B3IwLIx09gSElngn8XiUBv1cEiL44kphGDajOQEfg8pjAYebQXA/YmDU4rm/lxBGnp
         FFDiZXuPUAl8A==
Date:   Wed, 9 Mar 2022 21:10:29 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Mark Pearson <markpearson@lenovo.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the kspp tree
Message-ID: <20220309211029.0c766cac@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pV+54Z07pUrD+FTq5x_rNFG";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pV+54Z07pUrD+FTq5x_rNFG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kspp tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from include/linux/bitops.h:33,
                 from include/linux/kernel.h:22,
                 from drivers/platform/x86/thinkpad_acpi.c:37:
drivers/platform/x86/thinkpad_acpi.c: In function 'tpacpi_dytc_profile_init=
':
arch/x86/include/asm/bitops.h:207:22: error: array subscript 'long unsigned=
 int[0]' is partly outside array bounds of 'int[1]' [-Werror=3Darray-bounds]
  207 |                 (addr[nr >> _BITOPS_LONG_SHIFT])) !=3D 0;
      |                 ~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/platform/x86/thinkpad_acpi.c:10385:18: note: while referencing 'out=
put'
10385 |         int err, output;
      |                  ^~~~~~

Actually the test_bit() in line 10409.

Caused by commit

  e1c21608e3cf ("platform/x86: thinkpad_acpi: Add PSC mode support")

from the drivers-x86 tree interacting with the enablement of
-Werror=3Darray-bounds.

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/pV+54Z07pUrD+FTq5x_rNFG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIofRUACgkQAVBC80lX
0GzWpQf5AaFo2RN0WEpmnHUNqa9MgNOttV4LKaOhsDERSB+nCmtZcFcJH6xdZGEr
6kUPzb+W//0j0bhOsGK79fdwoUBUek/HZ1yiWB8oaO46sYURtME7Cn66c8iV/IFh
4VVuartJNAO3AUgVkjIt7+StjUI8I506thqKLEjzR52Ml0g8gdJ0s/s/inf+fsnF
CCqGM3WmQaI9zgXIf1U/mY2PeKPVE41G4z/FISGxYqXZV7sghkm1FD25T6AQ91Gy
ODmErVIrRg5KAJmva0itRB5+NkhQ1fCfl3Q4xx9vaVyiYVCl24mXRRBWNvdCY13T
Nv/AdIVtWxSybo6FY3q1Rwv0q2y/pQ==
=KSWy
-----END PGP SIGNATURE-----

--Sig_/pV+54Z07pUrD+FTq5x_rNFG--
