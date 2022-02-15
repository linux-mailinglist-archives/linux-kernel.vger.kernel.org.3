Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAA74B5FD6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 02:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbiBOBK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 20:10:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiBOBK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 20:10:56 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BD0DAAE7;
        Mon, 14 Feb 2022 17:10:46 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JyNLn13Pvz4xPt;
        Tue, 15 Feb 2022 12:10:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644887443;
        bh=sysgHelvaGoQWQhsN/U+bLrl1/j7SLwzQMRnwQ93Qtk=;
        h=Date:From:To:Cc:Subject:From;
        b=nJT0knRktIBysfBdBqRbXOk7CvLgaEknFetdRitCChZO3X6ETKMewHVDjLFrY3Aob
         19FX943QlH4PiSHyR2ZA32uEDly9TxXItixvkjnkRP2mng+yEdmFuDh79iyrVy9xr1
         r1CDY3eAjQYcYM5aK7cUGF9XcmqY1CQGkrzNhcev0TXCYjgvyFbrqAZ9qrMBTXrGy6
         TnoqhDpWt00N72nVwKR17PrNJrkqFmfYiNOED6boYSEK4uGoE7zJNowElNjN/aAgg0
         0J2cK/bfykgGh2SpahSAianwEsBl5ZtCp9m9Pq5x7nYG0F75y6/c9kJp2TSRkaZJFw
         pthNEkhmtAw0w==
Date:   Tue, 15 Feb 2022 12:10:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Dave Airlie <airlied@linux.ie>
Subject: linux-next: build failure after merge of the drm-intel tree
Message-ID: <20220215121039.1d1ec3e6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/iNPkmkrXrHfJuuRrqT7jTy7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iNPkmkrXrHfJuuRrqT7jTy7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-intel tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/gpu/drm/i915/gvt/kvmgt.c: In function 'handle_edid_regs':
drivers/gpu/drm/i915/gvt/kvmgt.c:595:38: error: implicit declaration of fun=
ction 'drm_edid_block_valid' [-Werror=3Dimplicit-function-declaration]
  595 |                                 if (!drm_edid_block_valid(
      |                                      ^~~~~~~~~~~~~~~~~~~~

Presumably caused by commit

  14da21cc4671 ("drm/i915: axe lots of unnecessary includes from i915_drv.h=
")

I am beginning to wonder if you guys run stuff through your CI before
relasing to linux-next.  Especially important when removing #include
statements from include files :-)

I have used the drm-intel tree from next-20220214 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/iNPkmkrXrHfJuuRrqT7jTy7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIK/Y8ACgkQAVBC80lX
0GzcTQf+LTxs6K5vvlhHDFfi9sLywA62S26SiPukd5M8LQmFQUfrnS3k84wRNyaf
ljDaUrdT1TxCmk4STGKGYq+jaYCHlt7fVwA2Cps5F7BSYibeGWLaBdEvNdfn0CFE
3ycP7KLf7c3cdY5ks2MU+d/vKhTm0s/wtFcXzFJ6zrXxnUXakL0EJ2PPh/WaIlna
r4mNbGMyhvK+SAZQ4sBo77m+KK6RN6f/Mh7qwpHI1UBL6lrOwiTltwlUkoJFT8xT
O7o/eh13cvuGAcMWxHHPfV95YNgp7gf2zpYGDlSE0s6r2NO0b80LHPRjrThVxKuk
byH3Zfrkz51IxRX6upG3kJSErt68TA==
=rp64
-----END PGP SIGNATURE-----

--Sig_/iNPkmkrXrHfJuuRrqT7jTy7--
