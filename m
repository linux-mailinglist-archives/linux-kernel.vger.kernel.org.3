Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC65516BE7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 10:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381868AbiEBITV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 04:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383781AbiEBIS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 04:18:57 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C94340E76;
        Mon,  2 May 2022 01:15:14 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KsG9X4nGyz4ySl;
        Mon,  2 May 2022 18:15:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651479312;
        bh=Rzpw6ZsH/MWWZ/X5MTCwUPV2BZCr6uYUd8WpPKHD5L8=;
        h=Date:From:To:Cc:Subject:From;
        b=MiFw2G0etsH4FWY8E0+NUIWiCJV+EH4sTLonvA2d3bRnORgEkAGzRxR7u3xiOPv2V
         eQuSlWF49wgLqzDV7R8R6pFcIoLCFDNA2zYEt/IKn2kjsDFQ1oRJI/Rc2EoGhhEPzB
         GzA6XUPladwEY+De3+DV3SjTQ+aW57IFn6pNqH/dZQPdc6uBV7XVb3tTypK8ORUiyK
         hPV4Lgvh093FzIfZPeR8RmwlcN0eEUUzuKYfG4DnJI+Y7dCP2GxhEaAYuAykEt6Iim
         ZOBE4X0sl7T6SRteRdWSUydLKWbQ3lFY6eL67lijSjLkqV+V5QfTezDIVMVxvgGvGY
         FohKR2ApefHzg==
Date:   Mon, 2 May 2022 18:15:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the bitmap tree
Message-ID: <20220502181512.4b42ffc6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Gfd8S5fLDtCea+rpX4tQ_ZF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Gfd8S5fLDtCea+rpX4tQ_ZF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bitmap tree, today's linux-next build (native perf)
failed like this:

../lib/bitmap.c:21:5: error: conflicting types for '__bitmap_weight_cmp'; h=
ave 'int(const long unsigned int *, unsigned int,  int)'
   21 | int __bitmap_weight_cmp(const unsigned long *bitmap, unsigned int b=
its, int num)
      |     ^~~~~~~~~~~~~~~~~~~
In file included from ../lib/bitmap.c:6:
tools/include/linux/bitmap.h:15:5: note: previous declaration of '__bitmap_=
weight_cmp' with type 'int(const long unsigned int *, unsigned int,  unsign=
ed int)'
   15 | int __bitmap_weight_cmp(const unsigned long *bitmap, unsigned int b=
its,
      |     ^~~~~~~~~~~~~~~~~~~
../lib/bitmap.c: In function '__bitmap_weight_cmp':
../lib/bitmap.c:26:50: error: comparison of integer expressions of differen=
t signedness: 'unsigned int' and 'int' [-Werror=3Dsign-compare]
   26 |                 if (w + bits - k * BITS_PER_LONG < num)
      |                                                  ^
../lib/bitmap.c:31:23: error: comparison of integer expressions of differen=
t signedness: 'unsigned int' and 'int' [-Werror=3Dsign-compare]
   31 |                 if (w > num)
      |                       ^
cc1: all warnings being treated as errors
tools/perf/../lib/bitmap.c:21:5: error: conflicting types for '__bitmap_wei=
ght_cmp'; have 'int(const long unsigned int *, unsigned int,  int)'
   21 | int __bitmap_weight_cmp(const unsigned long *bitmap, unsigned int b=
its, int num)
      |     ^~~~~~~~~~~~~~~~~~~
In file included from tools/perf/../lib/bitmap.c:6:
tools/include/linux/bitmap.h:15:5: note: previous declaration of '__bitmap_=
weight_cmp' with type 'int(const long unsigned int *, unsigned int,  unsign=
ed int)'
   15 | int __bitmap_weight_cmp(const unsigned long *bitmap, unsigned int b=
its,
      |     ^~~~~~~~~~~~~~~~~~~
tools/perf/../lib/bitmap.c: In function '__bitmap_weight_cmp':
tools/perf/../lib/bitmap.c:26:50: error: comparison of integer expressions =
of different signedness: 'unsigned int' and 'int' [-Werror=3Dsign-compare]
   26 |                 if (w + bits - k * BITS_PER_LONG < num)
      |                                                  ^
tools/perf/../lib/bitmap.c:31:23: error: comparison of integer expressions =
of different signedness: 'unsigned int' and 'int' [-Werror=3Dsign-compare]
   31 |                 if (w > num)
      |                       ^
cc1: all warnings being treated as errors

Probably caused by commit

  4252f3915e02 ("tools: bitmap: sync bitmap_weight")

I have used the bitmap tree from next-20220429 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/Gfd8S5fLDtCea+rpX4tQ_ZF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJvkxAACgkQAVBC80lX
0GzSXwf8CFrhV2ag5S7nRSQZdQCaTTf31ASdAyMMt3ZzC8bsJQmrJEOIvWk9PbK0
0erXnPlGiHgQYOoloN5WTvX5V0AQnfA08hcwYkJ/rNUTgto1plxubSMPxR+JKX1e
5SYWhaBm/vfN3zQK0787+t0DbjI5YtFspn8qmSCLmuZvNRn4F+fSZ7NbRiVYVDvi
QwU6e5yXlu0RdASI+G3NmIn7bOOmcdUWAn2WX7VoCrgr6fPfmpZaHSjshiGPLdFL
9NXLEmyge/mxNc7HSaxlUdXDaIKBM9rfk1LxP2OHtyRGR5BDJQyoDG5YF85pK7LB
dl8Sx7luFdWUgXluVokY76Ah9Eun/g==
=BGNj
-----END PGP SIGNATURE-----

--Sig_/Gfd8S5fLDtCea+rpX4tQ_ZF--
