Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DE44AB455
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236496AbiBGFuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 00:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237448AbiBGEG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 23:06:26 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74975C061A73;
        Sun,  6 Feb 2022 20:06:24 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JsXdB3VJmz4xcZ;
        Mon,  7 Feb 2022 15:06:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644206782;
        bh=0PvrRQGyoUUVt5t7B5BNiaVcCVXAC13TMQmAlx53dzw=;
        h=Date:From:To:Cc:Subject:From;
        b=ekBOqfyUwlrvDW2uRGUWWczy6uF1mMdu8F4XxB1RDdsT/1cuK7NoVS7ZBWQ9Qghwo
         Zsd0WC0qw5wUYBqZyoFMLkgqIvovLJaUUyoTigj5+SQbR5Witktdc92MXd2CfgHp+f
         xv/jMTMgkGa/LtLW0a2zypQkDPDnDu4zr7HujKk1DoJlvI2nId9VP0N6JCHIgCZxS5
         OCRHN1Dxxaw1//pozJlnDVxr+0BLImzm4cQKBYuQqzIkG66uLKYjCYSQSmIfar4TpS
         GKruj+7ZuFgTp4b5mskEd+K/weQLVcVb8AER+QgZdaMMm7HBrzZCEMtnuIBDkirGtI
         f+ohuNsvheUVQ==
Date:   Mon, 7 Feb 2022 15:06:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the folio tree
Message-ID: <20220207150621.0273b095@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/x8=gt.ikzbp+eHzLXYQEwFc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/x8=gt.ikzbp+eHzLXYQEwFc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the folio tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

mm/page_vma_mapped.c: In function 'page_vma_mapped_walk':
mm/page_vma_mapped.c:219:48: error: implicit declaration of function 'pmd_p=
fn'; did you mean 'pmd_off'? [-Werror=3Dimplicit-function-declaration]
  219 |                                 if (!check_pmd(pmd_pfn(pmde), pvmw))
      |                                                ^~~~~~~
      |                                                pmd_off

Caused by commit

  02ecfe9b9580 ("mm: Convert page_vma_mapped_walk to work on PFNs")

Presumably you need to explicitly include <linux/pgtable.h>?

I have used the folio tree from next-20220204 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/x8=gt.ikzbp+eHzLXYQEwFc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIAmr0ACgkQAVBC80lX
0GxQPwf9EbacIyEsg2U41ZrWHRjYJ7rkfFGPQw6uFYC+3B3kNubrw1rS3KIdWU0v
nlDl51ULyrDo2I3XJhEPpNizdZ8HqAyaM5yeGUlCYefQKV3c8gvLPMTT0n5Tvg91
GLDTh1KebdvMulC9dkHVvpZPevCAzRHT0bqae6fzWfhlpnVzzUNeY+niq2aunFnP
HuDd397S6dHdQ5qDsK2LNYyPz1Mf6A0I+5hIszvuLLUwtsjk5dt0pYYmfqfqxVCg
P1TqOVbzhy1bmJFdmjWITRfu+PipG4lQYJwGlXAl+HetJaYMo9KcSPcpJATn0m9S
+YuXBqaNsDrUXhjzUpCOyWIsQwfo0w==
=5wHo
-----END PGP SIGNATURE-----

--Sig_/x8=gt.ikzbp+eHzLXYQEwFc--
