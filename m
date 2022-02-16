Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC814B7BEF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 01:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245104AbiBPA34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 19:29:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245089AbiBPA3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 19:29:51 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B5AF70F0;
        Tue, 15 Feb 2022 16:29:37 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JyzNv5VSRz4y3h;
        Wed, 16 Feb 2022 11:29:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644971376;
        bh=H8k8WUZynKZijpCi/G91QOXAO1bA4PdhdLPjGZjr2ek=;
        h=Date:From:To:Cc:Subject:From;
        b=fmbGOoRii/fx4T7yunLpFAcnzSM5Q0usgTKbsB6phfcU8jtxntMoQznAvRnBFhY0m
         ePIBTDvKcMALPkILEm+H/NcU9Sdjs2BhcH5WhWoUmbklGpIrzb37O/LVyNQeQcWbLZ
         lAdZn9O2xpTNAMWrViOCF+9+I5xy/zLHnMAR5XXUhoncPwi8AX90uYOYFmZrbZEmqW
         V8h0rg1xlppLv0a21s+UGlB5dd2tT+N0PqM/FA/aVDGZ9pOfJcKD1ktJOHNCD/baZ3
         UdhVeDOb0VgRGrCxNO4aMJloiShi6tg1RdXYqrreVyjY1vv7xYkc7L5pGMgyEPS0lx
         8xqDHchr4uMYg==
Date:   Wed, 16 Feb 2022 11:29:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Helge Deller <deller@gmx.de>
Cc:     Yong Wu <yong.wu@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the fbdev tree
Message-ID: <20220216112934.108a27ad@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/j+7h.ZFM7fsrfHErsYeRzrk";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/j+7h.ZFM7fsrfHErsYeRzrk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the fbdev tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/video/fbdev/omap2/omapfb/dss/dss.c: In function 'dss_add_child_comp=
onent':
drivers/video/fbdev/omap2/omapfb/dss/dss.c:1209:49: error: 'component_compa=
re_dev' undeclared (first use in this function); did you mean 'component_ma=
ster_del'?
 1209 |         component_match_add(dev->parent, match, component_compare_d=
ev, dev);
      |                                                 ^~~~~~~~~~~~~~~~~~~=
~~
      |                                                 component_master_del

Caused by commit

  61038027aa13 ("video: fbdev: omapfb: Make use of the helper component_com=
pare_dev")

I have used the fbdev tree from next-20220215 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/j+7h.ZFM7fsrfHErsYeRzrk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIMRW4ACgkQAVBC80lX
0Gyc4wgAlw4E3TOEkQuPFQUCc2aEaxTc2ICD75l+cfax9Rr2CyWdu19MQYSzYFeJ
1zbsvcuvLdCFEEz9dVO1MXFhFtjJ11L/YdBN4LwppvcxCmQ8fywKTUVHWtqFULFy
w0qNjykvDHRA5vFuOrZYjG1k5+JJe04zycE9TKwC1FH5u5iJSrn5cGayP+4CtSXc
qwqqiatAs8NO7z0lKQmMySMHzKeaI5gEE8yEwxmPfsaf/VE3zIwjEtmENqCXixhA
Sxh4XVGvFp32vIggTn/2Iy2wtF/4FNro7EEXqpWEZw85wmviSuVlN+QkqQdVTomv
hlNoyHkAbnSnnp7nZ4Y37RIJRpzd1w==
=Cv8Z
-----END PGP SIGNATURE-----

--Sig_/j+7h.ZFM7fsrfHErsYeRzrk--
