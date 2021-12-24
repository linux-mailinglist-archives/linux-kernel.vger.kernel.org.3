Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A3A47EABA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 04:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351074AbhLXDDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 22:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241120AbhLXDDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 22:03:05 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F094C061401;
        Thu, 23 Dec 2021 19:03:05 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JKsLv1ZPcz4xgr;
        Fri, 24 Dec 2021 14:03:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1640314983;
        bh=nsw/1j+8CPJziQ6m79BTrSOPmx/dg+esVKJNra7XgEs=;
        h=Date:From:To:Cc:Subject:From;
        b=TW+dld0zttRLwP3gPX3/v6U4NmmAHk1SEiAlYinPD+OX2Wc1NsqQb3bSLQy3mPHS1
         5LvsD56yQxH3Q2DjO7ViWPOGVFQO0dPW4jBI/g8Kgks+PXUj+xib0onzPlPeF2FCWo
         ouu8AapCg+IbnvEzTu5PIGH9Ha6yGkOtNmjjlsp4PXHqKSFx6nAckq3HWdI6d3R5Pb
         NrYipTUG7MrsaNNQq1bFWwtHp4VEeo2SHr1IeG5p9dN2IquTODaYOBdInad9SX5Psr
         0JLSWUMTjf7m++ZCszqsMXZSOpPtkzZ6+W2ZQN7tiZ3mIzoOCSVl7THRcW4Xntpmi1
         pzx+UdDeP5FxA==
Date:   Fri, 24 Dec 2021 14:03:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Aswath Govindraju <a-govindraju@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the phy-next tree
Message-ID: <20211224140302.33d25020@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_LnCfqenqwgTvRCzXp2Ppt_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_LnCfqenqwgTvRCzXp2Ppt_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the phy-next tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/phy/phy-can-transceiver.c: In function 'can_transceiver_phy_power_o=
n':
drivers/phy/phy-can-transceiver.c:35:9: error: implicit declaration of func=
tion 'mux_state_select'; did you mean 'mux_control_select'? [-Werror=3Dimpl=
icit-function-declaration]
   35 |   ret =3D mux_state_select(can_transceiver_phy->mux_state);
      |         ^~~~~~~~~~~~~~~~
      |         mux_control_select
drivers/phy/phy-can-transceiver.c: In function 'can_transceiver_phy_power_o=
ff':
drivers/phy/phy-can-transceiver.c:59:3: error: implicit declaration of func=
tion 'mux_state_deselect'; did you mean 'mux_control_deselect'? [-Werror=3D=
implicit-function-declaration]
   59 |   mux_state_deselect(can_transceiver_phy->mux_state);
      |   ^~~~~~~~~~~~~~~~~~
      |   mux_control_deselect
drivers/phy/phy-can-transceiver.c: In function 'can_transceiver_phy_probe':
drivers/phy/phy-can-transceiver.c:113:15: error: implicit declaration of fu=
nction 'devm_mux_state_get'; did you mean 'devm_mux_control_get'? [-Werror=
=3Dimplicit-function-declaration]
  113 |   mux_state =3D devm_mux_state_get(dev, NULL);
      |               ^~~~~~~~~~~~~~~~~~
      |               devm_mux_control_get
drivers/phy/phy-can-transceiver.c:113:13: error: assignment to 'struct mux_=
state *' from 'int' makes pointer from integer without a cast [-Werror=3Din=
t-conversion]
  113 |   mux_state =3D devm_mux_state_get(dev, NULL);
      |             ^
cc1: all warnings being treated as errors

Caused by commit

  1e68cd3ff73e ("phy: phy-can-transceiver: Add support for setting mux")

I have used the phy-next tree from next-20211223 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/_LnCfqenqwgTvRCzXp2Ppt_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHFOGYACgkQAVBC80lX
0GwCrAf8DL6zbDl9ESktqLhwGxSJEXJAmo+se5EdfU/mRmFEOJhzYmELemrqoGkP
VVBmKBL5JEbZTEsAeeTvSksjf5gFmtwFLnsN7prbMe4kTpDqtNvY0lf8JtXoHAS/
kb1OdOAWcpD/E+bIpyc8YBJTRFwMLpIv1VEIE8lBuUskrZTkLHLNlm4EnvaqPPrA
QH6luJsG7vWKrIICRrgpZYTacQMNsmviMrxkh+YLoEUwWOEBWyQXTF8Ta3OeT/Yt
QiLhJXAee6W1rmUyNvWIgzuTbmRYStzHLx4YErWRDtamlCbQiXFxIwevzLJiZyZ+
Qbs1DKk/YZEO6I9DELPu/VajH6wA6Q==
=xBdi
-----END PGP SIGNATURE-----

--Sig_/_LnCfqenqwgTvRCzXp2Ppt_--
