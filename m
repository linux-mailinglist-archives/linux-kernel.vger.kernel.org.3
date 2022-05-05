Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D284251CB55
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 23:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381028AbiEEVlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 17:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233533AbiEEVle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 17:41:34 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5069C13D74;
        Thu,  5 May 2022 14:37:52 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KvRrG0jqzz4x7Y;
        Fri,  6 May 2022 07:37:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651786670;
        bh=n86/8gYxEzhlOHGFJmxvxteK50CUVJlT53soZq0ISz0=;
        h=Date:From:To:Cc:Subject:From;
        b=pCPdGBf86azeityq2xd+PvMPv7ZGkN161d9IGCD2RUskEF5Tc23qjql1w8Y8554Xy
         1USCQrDPohRpsTRK/He8lQYx/uUmU1Nrgrd9bW8xKwuATljhl32Drx1yfDyDYAY8Sb
         fY5iLhnAnLHFhw1/bb2qDrvPFLBGTMa4Pp7UnPUkapkgZGT+FVkpgQGYG12aDueGrk
         zgvvv0mc09UJqOJUknDE48wc1wqaszF5gBRV2AoFS4WVMY4lSvJoHll5oigmGGUCRO
         t+XasvV4LyB069rhJqFJhY9sj2yKJHe8/n/n2mrf3MizWT9h8AuM4pz8XywhAm0r4V
         BEHnReBEoERRw==
Date:   Fri, 6 May 2022 07:37:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20220506073749.73215f1d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ooJ7YSPsEE=6riEtJyTjeKO";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ooJ7YSPsEE=6riEtJyTjeKO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (i386 allmodconfig
clang14) failed like this:

mm/shmem.c:2337:8: error: variable 'page' is uninitialized when used here [=
-Werror,-Wuninitialized]

Introduced by commit

  b0bb08b2d5f3 ("mm/shmem: turn shmem_alloc_page() into shmem_alloc_folio()=
")

--=20
Cheers,
Stephen Rothwell

--Sig_/ooJ7YSPsEE=6riEtJyTjeKO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ0Q60ACgkQAVBC80lX
0GzX1Qf8DnRxCSIR4kwcm29Maar1xyboUM1ov3P1q0baFAdULzKYBInQdWCJc+ZU
ddnNT6BJjdBEf0/ayMtbt7nrXHSdKEakAMMt/viqjcbF78QjA0K1U58jd+vWDcW5
1dteuDNzdPwzenK2+6GRBBeIYUYOwbj5UdCrcbuDm28vwL/GAsp7vBAjiCMQIqUH
UGjag1o2snEm1HuxUyjlGFAG24SaTdF4YBCp/zFhSzuRIySIcH1t3nfvlqIqiZDp
N+TLtJjSojxAvNbZcx7w/mJpF3O0/ctBpvYB4rVudn3645oFmkvJ1pjN4XkJ88pj
tN8AH9KxAkP5CS+JiOlzvHv74uLY/A==
=qfuW
-----END PGP SIGNATURE-----

--Sig_/ooJ7YSPsEE=6riEtJyTjeKO--
