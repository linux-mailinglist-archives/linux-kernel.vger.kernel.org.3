Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1FB54A854
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 06:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbiFNEvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 00:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiFNEvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 00:51:18 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B742F35DD5;
        Mon, 13 Jun 2022 21:51:16 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LMbcL33Pzz4xXF;
        Tue, 14 Jun 2022 14:51:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655182274;
        bh=bbqzE0vIYjq//yReX+mVaqBWAYkBlexkhu66g69a/ps=;
        h=Date:From:To:Cc:Subject:From;
        b=h7D8ZJzaH0HAeX1BXSJPODcWzrGNoHj/s72oV5I/Zx2deOaoLDpReC9D5YOK0erys
         pFCfD09rSotdW/HhEBqmi9lt32IOiuOHHP3ZteGo0kcnsKhqowK3nSas1nPvdOR3vz
         kWGHNlTVHZTKpTHxFvbsRgCUKMHUo5eGd7RXDP0rM0CQC8jJO3O58cmRY199bUL12O
         LSIF7CiKuIlztg66MakXVlyGRrlNspTG/ECrJmaXMDV53/IFJ3gtT0ppusWAG+Iug/
         s4SVGc9SQQnwStr4gCfBC9euxBz8+PENyvN3L+ypikszelCDjN5uluBqbNAa0vGjVY
         w0rSPpnrs45EQ==
Date:   Tue, 14 Jun 2022 14:51:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20220614145112.4c3d1f52@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/YRepzUz5CcHMbFU6pm9rwbI";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YRepzUz5CcHMbFU6pm9rwbI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: In function 'd=
m_plane_format_mod_supported':
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:4941:13: error:=
 unused variable 'i' [-Werror=3Dunused-variable]
 4941 |         int i;
      |             ^
cc1: all warnings being treated as errors

Caused by commit

  d2d5adc87f69 ("drm/amd/display: ignore modifiers when checking for format=
 support")

I have revertd that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/YRepzUz5CcHMbFU6pm9rwbI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKoE8EACgkQAVBC80lX
0Gyingf9FyxWZDdL5WZkkxQsQTUTLsiRomBKCroOaKcIGOtbn3tqTSrwHwK5/ckv
et82uX897Al7708t1+lh5M02ILvDgPpLEEfCr6qUyn/onXyPu8CfxXmyPAXvO3P4
27h/rQYnaRFDczoVZujuQjLu0+bzufIKASry7TLoofxiWU+T3IDvzb5q8AG9sfhR
McIPdHD/p7w1bVNHITpa+2hDVFL9UpiU7ZRy2Lig56CDwYjYKPsAk/OqMDP9s0HS
npuAEnYMJGz05Iq6+x1e4R1eSFDo2yvtJXuZ9qTHY9bMOtaPHvyXNYfCKqmNPiXM
bhku9CruwHUtZYZ/S1s4zTkQBEXs5A==
=Q5f9
-----END PGP SIGNATURE-----

--Sig_/YRepzUz5CcHMbFU6pm9rwbI--
