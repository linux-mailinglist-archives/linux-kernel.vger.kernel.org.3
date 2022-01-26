Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F338949D64F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 00:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiAZXmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 18:42:55 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:37413 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbiAZXmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:42:54 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JkgJD3XN7z4xjx;
        Thu, 27 Jan 2022 10:42:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1643240572;
        bh=Yu6++roH7LHBMllyG+A8ccQ16RNfz/JX1ppO+BpEPBA=;
        h=Date:From:To:Cc:Subject:From;
        b=VAwEbcG+yH5zjzSDtBYlscoWJ4Vroy9PRqCvJjjHetc5z+hBH2l8gPjL4FDXvfoFm
         cTQZXKbuhGkBpyGecaS37hwOy8YllvZmxch3/JuEnLNPhidSGyRkDyhLP7UaCIy2gs
         Au6w8ySi+v2DPTe7kIZNxKK9h21C239m8s/bP2C/cH0l0XjE7NEfSYDygeon/E6oQs
         PkKghtKyZBeo2TXL6d6xUzJK2Kg52vZWrNMgCB5s/o5SPQummlbfTeklsl1W/T6sJl
         XCoSI4T+aySydtZiMWcRnwSV2uY9fmrB4JwdvA3IDGL1grJZHxW4wi+dL5sImvtcFM
         9wrwl8/XsVxIA==
Date:   Thu, 27 Jan 2022 10:42:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Tim Huang <tim.huang@amd.com>, Tim Huang <xiaohu.huang@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20220127104251.5a63a107@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EkqJh6pAIPv4xV.DxrL7kUt";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EkqJh6pAIPv4xV.DxrL7kUt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: In function 'd=
m_dmub_hw_init':
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:1030:20: error:=
 unused variable 'dc' [-Werror=3Dunused-variable]
 1030 |         struct dc *dc =3D adev->dm.dc;
      |                    ^~

Caused by commit

  3b36f50d3a69 ("drm/amd/display: convert to DCE IP version checking")

I have used the amdgu tree from next-20220125 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/EkqJh6pAIPv4xV.DxrL7kUt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHx3HsACgkQAVBC80lX
0GxQ2Qf/XhXciA8O2LnpDA5c2hxFam7ETz4FYPyJ3MFd4exkd4QZrx9gfExd1J3z
5YbbMSbrgbl2r6Nu+saDMj1f3KsV1ONS60Wgxh+SpKMYNx/0CWSOobnl/7cDVLqd
r+LvGbFK+0szHoAk+xM3NF5RlDc3Mp1M59KwwGKbrWxzNOcizSGBlUomSEHw651y
sUOS0i34pyTaOnc8z9RIJ1bzEFrTHrQ/HdRc42F/QoxEM/Lt0hPDej8idcdBlEcY
035xs3fqrhzcmNJyex7qXCT+xkPg8zliUQjX6/oW0bCcJ/36m5w3utOXBHurPDqn
vTZlO5RJ/KcYNpswyUhLkWOGWWPD8g==
=N+cv
-----END PGP SIGNATURE-----

--Sig_/EkqJh6pAIPv4xV.DxrL7kUt--
