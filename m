Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6471B51CB4F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 23:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386033AbiEEVkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 17:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385971AbiEEVjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 17:39:33 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E67613F3F;
        Thu,  5 May 2022 14:35:43 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KvRnk6sWQz4ySp;
        Fri,  6 May 2022 07:35:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651786539;
        bh=TKYTWsX4lxZyG270zY2XF4ob3AKxxzYGWlcANa+09ik=;
        h=Date:From:To:Cc:Subject:From;
        b=o73HXEMle4I3ZMjdCHFBuDmpwBgyQcDw/OwGeV4OG0BvY2AVJtgEO8y5Ts3dB1AOu
         RV0y+8LTlJnYuDm60U7+JUOPqWBiF8Vkx5rIOb5Z5IlHDymL13cDqYhYe7J39fdeaq
         r+5XGnrMJJiHZ1wta2nBpqhoUs+UcdOxAHSXIvlXrSjdUO7t95LRpVUrU5A1/6GsL+
         FaosLx66y0UOZycJ0zkSe8QXZy6JqoPAV9YtRkyj081Iv4yhEdCI3efIR/eowyVcHI
         WpGT443GXh5263vlit9eXQKkcFt9IBFdkjNWe6NlsIlyBIeESuZfeQgF3u5mIO0Zhz
         Y7SgZk8gPwnGg==
Date:   Fri, 6 May 2022 07:35:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the mm tree
Message-ID: <20220506073537.6da48a27@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cHvJ=en=fANYcvp=Kp+707r";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cHvJ=en=fANYcvp=Kp+707r
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (i386 allmodconfig
clang14) produced this warning:

mm/shmem.c:1704:7: error: variable 'folio' is used uninitialized whenever '=
if' condition is true [-Werror,-Wsometimes-uninitialized]

Introduced by commit

  2b58b3f33ba2 ("mm/shmem: convert shmem_swapin_page() to shmem_swapin_foli=
o()")

'folio' is used in the error path.
--=20
Cheers,
Stephen Rothwell

--Sig_/cHvJ=en=fANYcvp=Kp+707r
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ0QykACgkQAVBC80lX
0GwuZAf9ESrn7xp83mL3rPSMWph52bx+qqUQATtsHgHXWQyPmlWBRooE32KmfxB4
yuoZTaz6koy4MyJuDXczywV4e9epc+tN/1zfJQhSxFiQ2Fkog/+wpMRY6PJIZcBv
+pgFIIqOn65dY3sW0gv9zFhKvDJcHNm7eZvhaAQDER9nfawSUlEhDYOgnkG1Q4oQ
UCZT+XsSjQx59nXXbmKtwpBD7lUUgUAn/1+cGgJBvnrpRfVt5FCxBD04vXa6uDry
QIW8HJSZPwRzhUfU4p2HsYeQuWXlIMNsd9anOTvW364ZhFbk/Hsa6a5fsJW/WROL
7th5sHItSUPikSaseMJ7uG+NC7V3Qw==
=ZWQI
-----END PGP SIGNATURE-----

--Sig_/cHvJ=en=fANYcvp=Kp+707r--
