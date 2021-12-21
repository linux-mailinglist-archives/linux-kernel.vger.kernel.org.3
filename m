Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4411C47B66E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 01:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbhLUAUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 19:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbhLUAUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 19:20:01 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F967C061574;
        Mon, 20 Dec 2021 16:19:59 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JHxt05KRGz4xd4;
        Tue, 21 Dec 2021 11:19:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1640045993;
        bh=Ygl8qmZ71ubYi41QE9ioAWjlT0FI5HXu87pWOaGNiKI=;
        h=Date:From:To:Cc:Subject:From;
        b=mktxgVh3/79NAgOitHjTxLSeeM92+FnFKNUGwIO8iIt2sHAweDSYGmpLKwnxjOdIK
         0nCZoDoiG8g29eYeIamd2nh8Xm7AvBlD3Ab1uybjSrpGLlZEck6e9mGeCIRD/M446Z
         wRqIZcAUzilkcpsCYdUBspK0/mof2YUAflQWbV/zwq0W43zsy5NhQQzDDwBShyQupI
         mStEG2D32qxsL7ioJpN+XyzZSNaZ/OebLPPKv+JCPxxggkkHQVh3dtDsvm0cChrVDZ
         OpHt7+p346UqI2pNALVc7qU7UsWvzHEAlnNefZFlOQCIUctllqho0W8hxPR3/mQSkB
         28zSEblBSOJZg==
Date:   Tue, 21 Dec 2021 11:19:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Ilan Peer <ilan.peer@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sriram R <quic_srirrama@quicinc.com>
Subject: linux-next: manual merge of the mac80211-next tree with Linus' tree
Message-ID: <20211221111950.57ecc6a7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xbmfCk9_MyLFWDg8phdmQ=Y";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xbmfCk9_MyLFWDg8phdmQ=Y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mac80211-next tree got a conflict in:

  net/wireless/reg.c

between commit:

  e08ebd6d7b90 ("cfg80211: Acquire wiphy mutex on regulatory work")

from Linus' tree and commit:

  701fdfe348f7 ("cfg80211: Enable regulatory enforcement checks for drivers=
 supporting mesh iface")

from the mac80211-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc net/wireless/reg.c
index f8f01a3e020b,58e4b33aff04..000000000000
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@@ -2409,11 -2388,8 +2410,12 @@@ static bool reg_wdev_chan_valid(struct=20
  	case NL80211_IFTYPE_AP:
  	case NL80211_IFTYPE_P2P_GO:
  	case NL80211_IFTYPE_ADHOC:
+ 	case NL80211_IFTYPE_MESH_POINT:
 -		return cfg80211_reg_can_beacon_relax(wiphy, &chandef, iftype);
 +		wiphy_lock(wiphy);
 +		ret =3D cfg80211_reg_can_beacon_relax(wiphy, &chandef, iftype);
 +		wiphy_unlock(wiphy);
 +
 +		return ret;
  	case NL80211_IFTYPE_STATION:
  	case NL80211_IFTYPE_P2P_CLIENT:
  		return cfg80211_chandef_usable(wiphy, &chandef,

--Sig_/xbmfCk9_MyLFWDg8phdmQ=Y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHBHaYACgkQAVBC80lX
0GywRAgAidUPvuIpgXyiZWjvf4J2uM8zbhnzcbMNSrHUjR6tYsxhl2KT0uNiIgJR
R3iXob3tJqCuk/9NogtC1cXM3NK7mYV+fmgTOtDA1xU1winuV0cv+i1ahqbbYysZ
IZXEyPK4oP7na+rFmP1b7c9BhA45mE3Bp6ganMt0pL1ItXR5MXN01xELwwG5inDJ
Ma6vSsUt/2lFmSThi7y+fc53YpwYbhmyYZEM+QQh5Ulh3SGLc8Cdo4U+AU5Dhj0H
XUJYxfU0TgFfYMcPWlDbQNfScqhaCzqE3Ab1Rml+Gl1w78dh9a6uX0Zf2j7YDm1K
P6exuZJGf+xoSh+rR/tl/YArFayQyA==
=wVZe
-----END PGP SIGNATURE-----

--Sig_/xbmfCk9_MyLFWDg8phdmQ=Y--
