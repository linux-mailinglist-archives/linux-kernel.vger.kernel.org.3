Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EAD5080AF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 07:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354577AbiDTFki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 01:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244915AbiDTFke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 01:40:34 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B211465E0;
        Tue, 19 Apr 2022 22:37:48 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KjqFR0Nhjz4xPw;
        Wed, 20 Apr 2022 15:37:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650433067;
        bh=pULjsedHHkS1AZd9uq8yGCZ8KIhQiLmdrjwOGuAdwK8=;
        h=Date:From:To:Cc:Subject:From;
        b=ojsA2BQwnu74vh2ir/SLL7MsgIvvowhqlEbdS6To+aMPW57fFgFe7/RfG8SDI8uz1
         6NWi+Anc7/Ek8SvEUF/G4uyOvl8aSSJ14RsDyycbjslLai0QvDxujhiIWh9tdmIzho
         BymTXtAAycBM5xwbaslcdECYo4Z5+uqwByHXkgUk3wyGkYJy1fEsujK0h4QM2/TpCd
         C+fz9A6IaMPwc1EKfymJcii0z6hwh73g3X1aejBPiILv5rM15MwhqyVLJNJSNNW79t
         cdEyOjHOYFWEcx/Gy/YAJ2gb1S5EP9fAShA3PpdVcjKwlKJ4MCLrVflhoyqko9pkHE
         wXOrkqDdnV4cA==
Date:   Wed, 20 Apr 2022 15:37:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Zhen Ni <nizhen@uniontech.com>
Subject: linux-next: manual merge of the sysctl tree with the rcu tree
Message-ID: <20220420153746.4790d532@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/M_QSrCxrp9GOQyxQTjDA66_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/M_QSrCxrp9GOQyxQTjDA66_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the sysctl tree got a conflict in:

  kernel/rcu/rcu.h

between commit:

  95d4e9e339d1 ("rcu: Provide a get_completed_synchronize_rcu() function")

from the rcu tree and commit:

  d9ab0e63fa7f ("sched: Move rt_period/runtime sysctls to rt.c")

from the sysctl tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc kernel/rcu/rcu.h
index 15b96f990774,7812c740b3bf..000000000000
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@@ -23,9 -23,8 +23,11 @@@
  #define RCU_SEQ_CTR_SHIFT	2
  #define RCU_SEQ_STATE_MASK	((1 << RCU_SEQ_CTR_SHIFT) - 1)
 =20
 +/* Low-order bit definition for polled grace-period APIs. */
 +#define RCU_GET_STATE_COMPLETED	0x1
 +
+ extern int sysctl_sched_rt_runtime;
+=20
  /*
   * Return the counter portion of a sequence number previously returned
   * by rcu_seq_snap() or rcu_seq_current().

--Sig_/M_QSrCxrp9GOQyxQTjDA66_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJfnCoACgkQAVBC80lX
0Gx80Af8CcJWs2Cd1TuEIBlZgJl62Nt4FumE0HImNvnfplQqmOVdnziSZtwafRP9
Tr4aSyR6/XsTaJW57ACYLjzleJ/4TfG9vOaS4j6TQneFty8oD2sQ13eh83qb7FT2
xnLv6085taj+c55xD0dv1MxbwocAj4mDyCV5ugGQ8ShBWWLyfHixdhum+Cr4b0w/
bkij7tpNaf635eYcIRSLaNL9yYcckKe97wvYz60jeYSqXG5hYLrYTWOaLVraTCfV
yvBpG9wOezF6InSdh/5U/CbBdYbRmQBu80JalKIQFVaaxuHAv4DmC6ym2hWLLUMB
9nUjU7KSPm/futKAuIluBi7Bgcnacw==
=hXPS
-----END PGP SIGNATURE-----

--Sig_/M_QSrCxrp9GOQyxQTjDA66_--
