Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D145A70E1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 00:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbiH3WfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 18:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiH3We6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 18:34:58 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D9C12A85;
        Tue, 30 Aug 2022 15:34:56 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MHMZ54gR1z4x2c;
        Wed, 31 Aug 2022 08:34:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1661898894;
        bh=XyBfDsBCRdreSeRnz/K1HPjmJYlaIXf/BhqVKiKy9CM=;
        h=Date:From:To:Cc:Subject:From;
        b=i+Soh7IT0h+j28LJdmpF+fvGUU7bFikaC/27ValoCG+L0K/CTQAV7lc1hT/LJKzpO
         i6zn7vpUEkLvMp+KLIDGDNAovoGUVG635wbgpJBH8bpqPEQRJtK8ZKCzmjZ8wGPXye
         VqVf3YxDoDQFKZH3MGREOO8uKKwnUwQyceGkFDOMjc4z+S//uq1so0lJdDxnCZQlji
         akDcIyfUalsWgxyLVrSRLRuI1gxsZbXwOVlg/299121CBTnlUkZSai63FZ9elNjHmE
         yAPP+S3IVnyy2zprG/WSiwFefhCM4R13lLQZQpkMUr1OP0OTZlL6D7i5O9mqJJNV22
         n6VbslJJWqZxw==
Date:   Wed, 31 Aug 2022 08:34:52 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the perf tree
Message-ID: <20220831083452.2fc938cf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Kooy4_deoJnnM77V4_dH9L9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Kooy4_deoJnnM77V4_dH9L9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the perf tree, today's linux-next build (native perf)
failed like this:

In file included from /usr/include/stdio.h:866,
                 from /home/sfr/next/next/tools/perf/util/branch.h:9,
                 from util/branch.c:2:
In function 'fprintf',
    inlined from 'branch_type_stat_display' at util/branch.c:152:4:
/usr/include/powerpc64le-linux-gnu/bits/stdio2.h:105:10: error: '%8s' direc=
tive argument is null [-Werror=3Dformat-overflow=3D]
  105 |   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  106 |                         __va_arg_pack ());
      |                         ~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Presumably caused by commit

  9781e500dcb8 ("perf branch: Extend branch type classification")

"native" here is PowerPC64 LE.
$ gcc --version
gcc (Debian 11.2.0-10) 11.2.0

I have used the perf tree from next-20220830 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/Kooy4_deoJnnM77V4_dH9L9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMOkIwACgkQAVBC80lX
0GxT9gf/aDeR/aMSPZzWiylYmG+mo4U8UCPUcOL/XVw8pC0xa8x1buKrXqmjo99z
yse+urXF/LPuE4ighp2gvhOz982sYdxsMd1rEDxjX0ePuH8qoTxmkNckirJyiC56
GJ9NOwkmOw9MyXanrrAURBrf8xzztPDgVoxymCHwP1B+/c+L5zdSwMWN7O9Hdzg0
SVUpfXEwdIvgUfABqEKbkMcHx8bZXt7dtklpmGt6W+ZYTPvxtQB/Eu+6TGNASLO3
2dOXnMJayZzEzVBzcutmiOxfPbDKUnA85q68yEs4N4nnTSskRvvdup6Eozp4Gurg
OwzGmIOjGW2kEVEcNdnAXydkWuVz2A==
=OdUo
-----END PGP SIGNATURE-----

--Sig_/Kooy4_deoJnnM77V4_dH9L9--
