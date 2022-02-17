Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA614B99C4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 08:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236183AbiBQHUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 02:20:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236104AbiBQHUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 02:20:30 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5997429E940;
        Wed, 16 Feb 2022 23:20:16 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JzmSG5Mndz4xZ2;
        Thu, 17 Feb 2022 18:20:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1645082414;
        bh=dfH6V5q/9/6cBEleEdRaeWGijBrGuQCH8Brl1bm04K4=;
        h=Date:From:To:Cc:Subject:From;
        b=PD3NsGlZu/CLlllrhTKQA5Zny6m4QLSt7mm+ydWt5KXfjXT0zkxwEo0GhrEN0QALY
         SQ99jAS8xPmpW9FIgYyINXZMtLe9sbUK4mbYwWIIX0m3OFI72so5e/io0cIAM+CG8v
         +kungbb56fp121DKq8oRrVWZh4gVfoEA6iEKjHtz39oo6V51tJoIfJsRweU2JItCZH
         /buRXCTJjS3eCs4YvTFxaGpTohaxO5SZhHzBMxkVAC50qsdVtOrG6G5YDmeN17OI8i
         /bqFVuydRQpUtLD6YqEgFRyeF4FpZnUuc/Gqs54IRYwXBDpD2MqqbbP6MLfx7kiQbE
         a8n2WOBSmpqSg==
Date:   Thu, 17 Feb 2022 18:20:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the folio tree
Message-ID: <20220217182013.45aa8e3f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+0SpxwSLx.Tl4l7XEMKzMcu";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+0SpxwSLx.Tl4l7XEMKzMcu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the folio tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

mm/mmap.c: In function 'do_mas_align_munmap':
mm/mmap.c:2373:25: error: implicit declaration of function 'munlock_vma_pag=
es_all'; did you mean 'munlock_vma_page'? [-Werror=3Dimplicit-function-decl=
aration]
 2373 |                         munlock_vma_pages_all(next);
      |                         ^~~~~~~~~~~~~~~~~~~~~
      |                         munlock_vma_page
mm/mmap.c: In function 'do_brk_munmap':
mm/mmap.c:2906:17: error: implicit declaration of function 'munlock_vma_pag=
es_range'; did you mean 'count_vma_pages_range'? [-Werror=3Dimplicit-functi=
on-declaration]
 2906 |                 munlock_vma_pages_range(&unmap, newbrk, oldbrk);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~
      |                 count_vma_pages_range

This is undoubtably due to something I missed in the merge resolution,
so I am giving up on merging the folio tree again today and am back to
the version from next-20220204 again.

--=20
Cheers,
Stephen Rothwell

--Sig_/+0SpxwSLx.Tl4l7XEMKzMcu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIN9y4ACgkQAVBC80lX
0GwHDQgAokbt6RjCsUWh8D96KD1Z6Jv9Cx5fMrgqjinTWpj5k4FyaouYM2NO8DS8
IV76O9+j8BAR/lWww0U9UHWBL1DlEEu0gr3/3SBSQkhYuvPs2cNJL5HByvh2G0JB
7Un0VMDo3345CjeL3jrrcqDwIyRfeOcYSDYh80ZhqHf8VKh8vLEx/5TNsPDzKP4U
h4SZiAk0irjCdr3fbJW/aD5QmRCGQI8U+ktl/jwAjwm6jyb7sufeQgA6/93gSYb5
o9fL+7KtPTyOfKDKLhXdf1RUgeqsXQDAwoUTRQZXmUkSqVBIu9wFy0YASvttGAmF
LiAXsaHo18uSbWe1lqOsnO6My/ZIEg==
=HmnJ
-----END PGP SIGNATURE-----

--Sig_/+0SpxwSLx.Tl4l7XEMKzMcu--
