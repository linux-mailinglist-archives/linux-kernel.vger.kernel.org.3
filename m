Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A80554287
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 08:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357096AbiFVFyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 01:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiFVFyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 01:54:12 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF542A72F;
        Tue, 21 Jun 2022 22:54:11 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LSXdF74pRz4xYD;
        Wed, 22 Jun 2022 15:54:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655877250;
        bh=Qv6StRWn/iQP7Wj440S+l/Ice7Q1nVV1BTkRzcJhIQM=;
        h=Date:From:To:Cc:Subject:From;
        b=qWbhPqtcFflC7apSqA1mekrhMIhT4CLy48KKmmLC9+gEl6PGZRdj8stkjC3mJzssF
         hI1rlR930uLdNO6Dv3Afo6zas+Xs85E9S0n2hOT+pL3gER9wNXzX8knqkU9+K+bwbA
         fslEfI1dvrXD23menlT+PmcW7D4GBzpguqnML0rIqduP0JNgM0xOb2c69EyOJHBmMO
         ASYUwF4XSt2VqiiIXzHldSqh1XhNriB3fnf1iUtS+0u3xrQiI2Dr/9aRVhSkVRqe1Z
         UvuUr9cbvkniuaa8Ssp3T8ko8vS7Is4v6CYhF31uJ3xdqhXZOZjNGenNgzPBqs3HJ2
         o3fqjn0LwjE9A==
Date:   Wed, 22 Jun 2022 15:54:08 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the mm tree
Message-ID: <20220622155408.3ba2a9b7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Vto.zuelBglrh_aqY5SvGUx";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Vto.zuelBglrh_aqY5SvGUx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (powerpc
ppc64_defconfig) produced this warning:

mm/hugetlb.c: In function 'hugetlb_mask_last_page':
mm/hugetlb.c:6908:23: warning: unused variable 'hp_size' [-Wunused-variable]
 6908 |         unsigned long hp_size =3D huge_page_size(h);
      |                       ^~~~~~~

Introduced by commit

  76005bedbc32 ("hugetlb: do not update address in huge_pmd_unshare")

--=20
Cheers,
Stephen Rothwell

--Sig_/Vto.zuelBglrh_aqY5SvGUx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKyroAACgkQAVBC80lX
0GwnhQf/XBx5G4wG5Fy+TPg6ynwOv1d/k29MSSVKJs+7+HnNwlCtvj49dNOqxVtx
m4vJc6MUidzfx3x8yzkE7yxvTjZzJoKiZJrx7cIdtk43lCBWkJi+esDmhmrqsOgm
CYaRaAd+TEDgxE66O7ZM1LgJR+OLyxUhUlZJTB4PX0VcvCBdI9j8DSA+6noWjNNZ
gmd1Yn3frxvOlJpgzOGrXO+6PstVOoDOW/nZJ18xBvp+brBnyRl6DU74yMec5N9f
M1vorynMtX0eqbpTAlrlbIe0p1pE/AuwSjkde/kkYLD87E/vrNBLnS2+VPH79qP4
suvWSls7pUhjR+IyuAKuch4S3Ygr6w==
=WdMS
-----END PGP SIGNATURE-----

--Sig_/Vto.zuelBglrh_aqY5SvGUx--
