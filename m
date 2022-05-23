Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDA75309C7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 09:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiEWHEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiEWHEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:04:11 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF5819C14;
        Sun, 22 May 2022 23:56:54 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L66sG0b1tz4xD8;
        Mon, 23 May 2022 16:30:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1653287444;
        bh=xgg1hS9BSFr5BuV1JPPaBTBshDJNljlVHdKXJO5tQ78=;
        h=Date:From:To:Cc:Subject:From;
        b=sYnPmLi8oYAqcYCjY6GHNChs5KYvus+P0r4Ha+hu2Qpo4kVIGVj3bhfLVwJn2ECT9
         PItx4IuEgzjyncJt2ukJrkkvkgo/Fv1BP4r3Sg01O985QC2dDBSVqergEj1J6aeBmX
         ixUmaX8DtshIG85goiSPBdK6QLcd+4Upjjm8mwLFnhm21hocfXOfWy3xy9rOrqLOqU
         ah63LfYwt5wNL9w1tP47lwxGiCsdZJRhodfw3bW4nWXtmpm5os/6fD7q7RffpbUVdE
         GDUC0EEl/UfPdyuTfLneQT6/f8y+tw87u/TO1lbIuDfaV7ECB1+RjP5meIVBOmXYfT
         GTl8/z/PRXEbg==
Date:   Mon, 23 May 2022 16:30:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Xen Devel <xen-devel@lists.xenproject.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Maximilian Heyne <mheyne@amazon.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: linux-next: manual merge of the xen-tip tree with the pm tree
Message-ID: <20220523163040.6064b190@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LHaDpV_gDAUXQ2VrDx=4El=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LHaDpV_gDAUXQ2VrDx=4El=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the xen-tip tree got a conflict in:

  arch/x86/xen/enlighten_pv.c

between commit:

  f089ab674cea ("xen/x86: Use do_kernel_power_off()")

from the pm tree and commit:

  1591a65f55bc ("x86: xen: remove STACK_FRAME_NON_STANDARD from xen_cpuid")

from the xen-tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/x86/xen/enlighten_pv.c
index af1f6e886225,ca85d1409917..000000000000
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@@ -30,8 -30,6 +30,7 @@@
  #include <linux/pci.h>
  #include <linux/gfp.h>
  #include <linux/edd.h>
- #include <linux/objtool.h>
 +#include <linux/reboot.h>
 =20
  #include <xen/xen.h>
  #include <xen/events.h>

--Sig_/LHaDpV_gDAUXQ2VrDx=4El=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKLKhAACgkQAVBC80lX
0GwP1QgAm4zlmI0lzfyk52XGg8pKpPdKKocChsJEtTH1iwbUUM+owKfGB6L7OMlY
bRZFmQUgIy581cwpFPqYhi1vOcTkOX3E6npA1fhBdamYar7tCqu4xwq2f1A0rTjZ
Zb9+lcJZHYcp5nApkqC0Us7UICIrvI0ylGXF3okKtscKsoMLPT1jfqrUGo8UIjyA
l2jPDtIFntlk5bKhcjH4Bk1igoNW/hX97iPzsgj9KTrtVwQ2ISq5PjptZToaiaS0
JCE4UGrHdiXjmzaDo7saPc5lEs9cUpvLm1TV+9VHYDfs3/UJvS29BTlCHra02K6e
j3xKHiad9zTxderG5aSSt88c1YZ3AA==
=BbA2
-----END PGP SIGNATURE-----

--Sig_/LHaDpV_gDAUXQ2VrDx=4El=--
