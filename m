Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B66569A0F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 07:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbiGGFvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 01:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbiGGFvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 01:51:38 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391413190F;
        Wed,  6 Jul 2022 22:51:37 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LdlsM52Gyz4xDB;
        Thu,  7 Jul 2022 15:51:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657173095;
        bh=erYmuSJaMtl8QYRptXou9ckJfT4DVP+Ob8Y99LsPIIQ=;
        h=Date:From:To:Cc:Subject:From;
        b=KTCiubXGeq/ezk3XpWKJRGf+qY2LCpDHkWIkYFtrIL0oqL46DIa08cNx12lmMpIdQ
         WQKEZREJA76/pqiK/fcT5XF6UkGnGwS0x8gmYEA65Z4yDzbs+j6MH0tx/zdgdJWDg7
         GlL2OjHa8elDXaO1EUhWueWH3Zep3wRQltci5IrIFOobDO+bi3DCeAB6AzmVy12H9v
         R2Bab9BUQ5mTdnvNSb/xrDPvbF0eA6JUs0U8j+icvCjg3kFLjXY0wc0zPjY02YDlHh
         XAyGcDu2dz2c+X9BfFjilDP7mCErSgC3cviYYYOuP4oQ7kM0nN9kB8vFStiEs9V3Vl
         p8JaGYJZniQ9g==
Date:   Thu, 7 Jul 2022 15:39:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the phy-next tree
Message-ID: <20220707153941.668cd6d5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hXdHKrv=JBiP0DAOAy4IOBz";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hXdHKrv=JBiP0DAOAy4IOBz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the phy-next tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/phy/qualcomm/phy-qcom-qmp-combo.c: In function 'qcom_qmp_phy_combo_=
vreg_init':
drivers/phy/qualcomm/phy-qcom-qmp-combo.c:2004:9: error: 'Return' undeclare=
d (first use in this function)
 2004 |         Return 0;
      |         ^~~~~~
drivers/phy/qualcomm/phy-qcom-qmp-combo.c:2004:9: note: each undeclared ide=
ntifier is reported only once for each function it appears in
drivers/phy/qualcomm/phy-qcom-qmp-combo.c:2004:15: error: expected ';' befo=
re numeric constant
 2004 |         Return 0;
      |               ^~
      |               ;
drivers/phy/qualcomm/phy-qcom-qmp-combo.c:2005:1: error: control reaches en=
d of non-void function [-Werror=3Dreturn-type]
 2005 | }
      | ^
cc1: all warnings being treated as errors

Caused by commit

  6bd9a9be5d73 ("phy: qcom-qmp: add regulator_set_load to dp phy")

I have used the phy-next tree from next-20220706 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/hXdHKrv=JBiP0DAOAy4IOBz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLGcZ0ACgkQAVBC80lX
0GwG+wf9Es2SHRQKBPZh9aMsmTol3LYUzu0T6EkF/k4fC2WDXfOBH2u6N+FATLI3
CEWsdG+BAyTQQ7qQBYCSi7h4hJtNz3Kg7IW6j2nnMcb1w7PGdnSk87amiTW4Dy+s
tWgnrO5DBMJvBGJeuIR0PjYtgfdwyHGceCXBulV7+X9anxeeKvJq/WSWwwFslHME
SCMsxuvbcye+8dVgQdw3U8/pYum73P5M41HNlVkpq84ZOUa4lkFWHxwIBxthNiUx
5d/bn8XOYTVvGMA4m4bx/sMaV63Btzr1BimlyGfd+CkWM+LTHEysL7j9EbSt3w6y
yF1BP16QnqSErlhaZnBw88X1C4tRwg==
=iJLV
-----END PGP SIGNATURE-----

--Sig_/hXdHKrv=JBiP0DAOAy4IOBz--
