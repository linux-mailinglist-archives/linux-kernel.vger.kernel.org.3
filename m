Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6515B57B690
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240895AbiGTMgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240873AbiGTMgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:36:10 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6C248EAF;
        Wed, 20 Jul 2022 05:36:08 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LnwD473V1z4xG0;
        Wed, 20 Jul 2022 22:36:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658320565;
        bh=JBExvrmQSPyJUmd0NBwaT5zRWx3kYK1P62cysTsHQkE=;
        h=Date:From:To:Cc:Subject:From;
        b=pVlDJZxah9QmtrcrIFC7bFftJVAxucQIJZV0cMOYTzucMr+B4czPZL59XgX5etpPQ
         KGJH2zRR87sE8t8bb5VEF3I05hCqkbKj976d/ObHpOFMKmDOVeJGkLJovQx5nsKmeT
         N2Sr/YN61sm72B0pWsXfiXC/Y2gjiV7rwTMzyp+t8sr9zg33hJR9BRyaciUgHNIzF+
         oJJFnDuuCfy4knD6Sy3ztJGpi+W16bQwEDNmA1rSoe39Fupocsvcsfw19JhbNE0RtQ
         PyJPNdvFj4SC7Kyc6E9eFj+KYfE6G+0T24cRN7KyuJ2JUIPirWhwCitQuPL+AzlP53
         eEtRt+UVxvYsw==
Date:   Wed, 20 Jul 2022 22:36:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the asm-generic tree
Message-ID: <20220720223603.58acc431@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Mbh3QRHhWzFLbljdrtYu99v";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Mbh3QRHhWzFLbljdrtYu99v
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the asm-generic tree, today's linux-next build (arm64
defconfig) failed like this:

drivers/char/mem.c: In function 'page_is_allowed':
drivers/char/mem.c:66:16: error: implicit declaration of function 'devmem_i=
s_allowed'; did you mean 'page_is_allowed'? [-Werror=3Dimplicit-function-de=
claration]
   66 |         return devmem_is_allowed(pfn);
      |                ^~~~~~~~~~~~~~~~~
      |                page_is_allowed
cc1: some warnings being treated as errors

Caused by commit

  cdfde8f61a00 ("asm-generic: correct reference to GENERIC_LIB_DEVMEM_IS_AL=
LOWED")

arm64 does not have a separate declaration of devmem_is_allowed() and
was using the asm-generic one by accident ... some other architectures
may be in the same boat.

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/Mbh3QRHhWzFLbljdrtYu99v
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLX9rMACgkQAVBC80lX
0GxA1Af/WocvKzZW3GyaBhEGVBdGakz9Tr7umYNCqtYBqQjn+M1QBglvL5b7WTu6
hFbcFV0jOhKoh+HsZlA5utI1uok7Lu/IbGdfLRiZqIFOyq9Qhw++fRLOr540vhcm
2FpQF+4F8b2uCdSyRGfHBjsxYwxQjquclytbhV+yMA+gzBmL+MVtEgWHfurIlk3Q
GgUsp+R/0MqxYLhujip+Fu9Kn8oRL2jrus/yXcUcBgrFYIRpD91uVqV7rNcMBhtR
M9stCNYnoliVmkonmPhVi9695uqfrE7x4At48fS3TSzT0+7fZ0BHOYHVc5CMUMvu
fbDoZaAUYeKk2HYdohHyzp6HDFplBg==
=Uf+H
-----END PGP SIGNATURE-----

--Sig_/Mbh3QRHhWzFLbljdrtYu99v--
