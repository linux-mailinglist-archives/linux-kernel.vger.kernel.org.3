Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F4E4D42EF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 09:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240537AbiCJI7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 03:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240515AbiCJI7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 03:59:09 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA0E4EF6B;
        Thu, 10 Mar 2022 00:58:07 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KDjdT40WRz4xLV;
        Thu, 10 Mar 2022 19:58:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646902686;
        bh=H9+RemA3dNdRdz11j7ZizqNUT1nC/DZnJ39M9LCSdm4=;
        h=Date:From:To:Cc:Subject:From;
        b=rs66ZYNWX3gWYbzTv5C0InhNMDXbvCaiZ6sRIwflkPjqX+ZHoDTNEgNii0ME372M/
         9i9nd9kS1gKdFyJ8kG1RqQdN5WFszCaskqckz2HIAO1+VywPS3xVtvucNH3JFT2333
         f3cDt6EN62fZb7XvftZfoaPaWm29zwMVR/B+OiSYexXqzWb0jOpG1NWdYoIcxEdq1S
         feac8wzl/dq53SciYnArykgM2xZ2mPgpXTiW1alCPMeHSzkbQkqDxaTOCD4p3BIurQ
         +2XhL0hYCFRBji1Tl4bRpRDy8VOFlm9Vt/1TT84rYoqtS6O9sw0h28MQnTNjmEAdOD
         CQfrZROgmRrSQ==
Date:   Thu, 10 Mar 2022 19:58:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20220310195802.6058a84f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KWihdqAgLoceuaFbTbySgx6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KWihdqAgLoceuaFbTbySgx6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm-current tree, today's linux-next build (arm64
defconfig) failed like this:

mm/mmap.c: In function 'vm_get_page_prot':
mm/mmap.c:122:16: error: implicit declaration of function 'arch_filter_pgpr=
ot' [-Werror=3Dimplicit-function-declaration]
  122 |         return arch_filter_pgprot(ret);
      |                ^~~~~~~~~~~~~~~~~~
mm/mmap.c:122:16: error: incompatible types when returning type 'int' but '=
pgprot_t' was expected
  122 |         return arch_filter_pgprot(ret);
      |                ^~~~~~~~~~~~~~~~~~~~~~~
mm/mmap.c:123:1: error: control reaches end of non-void function [-Werror=
=3Dreturn-type]
  123 | }
      | ^

Caused by commit

  e25ff72a53b9 ("mm: generalize ARCH_HAS_FILTER_PGPROT")

interacting with commit

  6e2edd6371a4 ("arm64: Ensure execute-only permissions are not allowed wit=
hout EPAN")

from Linus' tree (today).

I have applied the following merg fix patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 10 Mar 2022 19:50:30 +1100
Subject: [PATCH] fixup for "mm: generalize ARCH_HAS_FILTER_PGPROT"

Semantic conflict with commit

  6e2edd6371a4 ("arm64: Ensure execute-only permissions are not allowed wit=
hout EPAN")

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/arm64/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0b8f9328cd95..962c84952c98 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -25,7 +25,6 @@ config ARM64
 	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_ACPI_TABLE_UPGRADE if ACPI
 	select ARCH_HAS_FAST_MULTIPLIER
-	select ARCH_HAS_FILTER_PGPROT
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_GIGANTIC_PAGE
--=20
2.34.1

--=20
Cheers,
Stephen Rothwell

--Sig_/KWihdqAgLoceuaFbTbySgx6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIpvZoACgkQAVBC80lX
0GwFHwf9GWJbOCxfLRc2g/O+aB3Hzug7qjtfrExwlhwcVyQFWuILkOhzg8Gc+Qko
xYrZ5sQJWpupLT8izpJTwhuto2uwm7RLlfkJRGXneRVxTSuluc8fNGfq3skqTt9Z
siIJhwCWARoLwoyG1anp/hBDat7C5UDr9piX72/yw0JN021/lXZXFF061ItLMpDS
1PBQbalvVcia+77qQjQkvAXJ4FOX2IDQdZKCmm/tymlVhX5Oh2WGdeQxWd5u0spt
CINQe6zibpQcU7Uad4lZcsY6e0mVgjZF42k+tHh4MY0jHo/3dbOIZ+vk/NQHq82x
OAPQ7kaRY2beWmqBSaGz3jRoDaehbw==
=BM8m
-----END PGP SIGNATURE-----

--Sig_/KWihdqAgLoceuaFbTbySgx6--
