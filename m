Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3EA52495F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 11:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352253AbiELJqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 05:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352206AbiELJqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 05:46:11 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240F81F612;
        Thu, 12 May 2022 02:46:10 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KzRjr3NwZz4ySc;
        Thu, 12 May 2022 19:46:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652348768;
        bh=L2PJUWI3cJRBUXirrlMBPR8V5mQ7lx1Ud6N46L4EtIU=;
        h=Date:From:To:Cc:Subject:From;
        b=hR0eHZpMl7GoL2b85f2xBLLH7V1xKviVGmowug2CGhh2YYJeZ09VXOq5kJKGiVnVP
         UbLCAixcZ5uTuQcOcww6PlJaa5uZP76BfuIKPODKYFzPjgsnvMzvVg4+Aqqy2DsYZb
         JYOxQnFGdc6Frzd9zCjwJXRZA24vAbQdkTssG/Fk8+vRg/r9fRQbqCidHNLjArCqz0
         RbzfkFEeLQW/PHj6KV0f3Iqt4YMggBherCRgPDLnauFXKHEg8zEC1/SinFi3UeR04/
         1jjyejp2eyWYirsgjr3nGnZzdqOFk2hGJMqry8W6mUHIp6iyCBNhwhi8HBgRm1IU5C
         JmIUF7HCYei6A==
Date:   Thu, 12 May 2022 19:46:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the mm tree
Message-ID: <20220512194607.74ee330d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Ls4cPiFtTZrBry/HytMOfx=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ls4cPiFtTZrBry/HytMOfx=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (powerpc allnoconfig,
powerpc ppc44x_defconfig and arm64 defconfig) produced this warning:

WARNING: unmet direct dependencies detected for ARCH_ENABLE_MEMORY_HOTREMOVE
  Depends on [n]: MEMORY_HOTPLUG [=3Dn]
  Selected by [y]:
  - PPC [=3Dy]
Building: powerpc64 allnoconfig

WARNING: unmet direct dependencies detected for ARCH_ENABLE_MEMORY_HOTREMOVE
  Depends on [n]: MEMORY_HOTPLUG [=3Dn]
  Selected by [y]:
  - PPC [=3Dy]

WARNING: unmet direct dependencies detected for ARCH_ENABLE_MEMORY_HOTREMOVE
  Depends on [n]: MEMORY_HOTPLUG [=3Dn]
  Selected by [y]:
  - ARM64 [=3Dy]

WARNING: unmet direct dependencies detected for ARCH_ENABLE_MEMORY_HOTREMOVE
  Depends on [n]: MEMORY_HOTPLUG [=3Dn]
  Selected by [y]:
  - ARM64 [=3Dy]

Probably introduced by commit

  52bc69c65c03 ("mm: Kconfig: group swap, slab, hotplug and thp options int=
o submenus")

--=20
Cheers,
Stephen Rothwell

--Sig_/Ls4cPiFtTZrBry/HytMOfx=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ8118ACgkQAVBC80lX
0Gyhjgf/WoX3yvjqPZVrzUk7N3QSWdpur9bkATrT5xcC/584x0uE/awEMshVrpzq
dDEMDHuxV1kOdh/s+PBTEovetdiUBYVDdeTGena8zkPwea9FQrSPzheXUvoqFmuX
6a9quvVcsrdhISmCD56MOQkbmoUsU2laB/WxDoxwGhiaj+R4Lh+KjQyNlOVq3aR0
vCODbIJw5eKeqMgBzSKFQQ7u+yW39p8at+rA6dpHasWCf7C1Pg+nEIRbFFEOthSv
j8fQbf6PCbFgxXjDPKHMpjEuzZHoHUVshuYKVK+NR5ThS9tLTvUgPiswT9kTILID
5cdsPGVPRmgUuw1/6Ly63B5IBT7TBg==
=uorR
-----END PGP SIGNATURE-----

--Sig_/Ls4cPiFtTZrBry/HytMOfx=--
