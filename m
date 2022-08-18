Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C72597B32
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 03:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241705AbiHRBxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 21:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbiHRBxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 21:53:40 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082D0DFBA;
        Wed, 17 Aug 2022 18:53:37 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M7SbH5Y6hz4x1d;
        Thu, 18 Aug 2022 11:53:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1660787612;
        bh=WCDa6lDwZpaaukzC/fCvtuvGLQ5zzB7/SPUXlj6aLLY=;
        h=Date:From:To:Cc:Subject:From;
        b=NWDxSxU6qwo3rh8jFIg9+/naoTb69OY+Q0cLikz4qbnH+hnVt6a0wYGKbiFVlgEAb
         RtFrtUNxFX6lbat19d2UF2gD++2TrdI8TE4i63ZfK431L6LISpDrTf5KymcdPcMyJD
         JcL5nN3NqoplBihEIv6Uokp4SORhuFxobiqYfHapx9dVahIigGAlbYzC0i4Ap4wQSg
         TQAoYHRLiKEaB3ZuHuGuwJQupKp8CB1lDy+gQ7mMs0C+JvRJ/NYB055WXG2k00nR9p
         iXWX1IljY9R/X6S26WzN9rz4q6ucvKq5adZSWz59xNExnR6kgVwKQhV7rPwPYbQyWQ
         Mz/rvMWRfqyTw==
Date:   Thu, 18 Aug 2022 11:53:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the icc tree
Message-ID: <20220818115326.407aa3e0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TiqgLJk9=M38NphCtopWxKl";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TiqgLJk9=M38NphCtopWxKl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the icc tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

drivers/interconnect/imx/imx8mp.c: In function 'imx8mp_icc_remove':
drivers/interconnect/imx/imx8mp.c:245:16: error: void value not ignored as =
it ought to be
  245 |         return imx_icc_unregister(pdev);
      |                ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/interconnect/imx/imx8mp.c:246:1: error: control reaches end of non-=
void function [-Werror=3Dreturn-type]
  246 | }
      | ^

Caused by commit

  d761e0e9c8f2 ("interconnect: imx: Make imx_icc_unregister() return void")

I have used the icc tree from next-20220817 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/TiqgLJk9=M38NphCtopWxKl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmL9m5YACgkQAVBC80lX
0GwyjAf7BEiMq1C4FsM2quJmn1VIpNU6Wajrt5n1RajvxAwT2FN4IqaiybseftYe
ZLeu+14uKER4ncbjgEqgvt/h16VFe/Ko937JYyXKaq8XvICXEl7o4L9eedTgkRrO
OZBd/farxd7y3wAJq3Tft+vVM6HNWcduv6CovGuvIr19bB+8Cvf5Adz5fby7IOx9
9mJ9TmJdc+N5mG7pQu+PEgr2k4iPrFOfb+2PXgWmkbP5WOJqboGCsHEQfav1UnzP
BH1Opo4pElX65Q83qWtmLJulDhCVov1eJNylUaXvIzScuM5O0THzV0ol3ZUoehth
a6WYJzVu4VeLC2IqMFmkxv5bDGJgSg==
=Lmuj
-----END PGP SIGNATURE-----

--Sig_/TiqgLJk9=M38NphCtopWxKl--
