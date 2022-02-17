Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB4F4B9AE0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 09:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237573AbiBQI1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 03:27:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237592AbiBQI1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 03:27:42 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8AD1F6B87;
        Thu, 17 Feb 2022 00:27:25 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jznxl4tSnz4xZq;
        Thu, 17 Feb 2022 19:27:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1645086443;
        bh=bApq11IKYHzDfTSJ/UX5xND0Jryd27YhT1z48powltU=;
        h=Date:From:To:Cc:Subject:From;
        b=Yl2fgvnVDft4zBJLzP+NaHDL9x5N5268chjYMlSSWO7esD2axln6QU/g5NmL/fiVw
         nG93jNhwj2pkKVYRlpPFrF/eoRxg5QJjvT+WqOrkANBRY3qj6ESIP4STcm5jjFJZVE
         OL4FK8wjJEQV0ueWbcHabSsZum5wGXrKA5tUmtXxpUCsgFklaDB9nSZUgM068sG2Xd
         JWz85fqTiUGvxyOiXN5NpeqXlqIBT2EmnrfrtiadmC+U1cCCQ6OgHO839rCK+qk4hP
         TgozynyJwEv6mW/uHoGpivNj8dbuDBx3vvFCyryBjtMsWMsD1xDri/LRaqPTmFROCK
         AsUX2RmYiQ6Pw==
Date:   Thu, 17 Feb 2022 19:27:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the maple tree
Message-ID: <20220217192722.1447f4a9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/to3ae14.n114hFdfGdKn2D4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/to3ae14.n114hFdfGdKn2D4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the maple tree, today's linux-next build (powerpc
allyesconfig) failed like this:

In file included from /home/sfr/next/next/mm/damon/vaddr.c:762:
/home/sfr/next/next/mm/damon/vaddr-test.h: In function 'damon_test_three_re=
gions_in_vmas':
/home/sfr/next/next/mm/damon/vaddr-test.h:85:1: error: the frame size of 27=
20 bytes is larger than 2048 bytes [-Werror=3Dframe-larger-than=3D]
   85 | }
      | ^
cc1: all warnings being treated as errors

Caused by commit

  42672fae77a4 ("damon: Convert __damon_va_three_regions to use the VMA ite=
rator")

I have dropped the maple tree for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/to3ae14.n114hFdfGdKn2D4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIOBuoACgkQAVBC80lX
0GzArgf/WP3eX4I0DJEIlR6DlPa/ZepBq3CEw4wPHdoszDZ6g/JqUKkMqzjaCSw9
+AIiTqqu8i2Ckq3kO/O1dTkYkWhcyjkwSF4wC1GqZ+mpIk51mPhPyxMY4v18v32q
c7corp9UMwXzn4fXiwe0hpz0UjJBCTnRtL44enyO1Mu84k/WIdQPkf+LzcRdd03I
7OqafppnC2febRbGd7/Ut4e9elNVOaxN1ac1SOjoeq+RY+rUCuKSHmDfg3J8AQ0Z
JYLHzJuuSGxot9VcDwxmdgKc4bO97PGe5dBqh6ofNBSs2IDMQLWRU/hyAbmmGA6Z
/0j7u/0DDo7IRWjWr05ofjwYJHjj9g==
=Ytvz
-----END PGP SIGNATURE-----

--Sig_/to3ae14.n114hFdfGdKn2D4--
