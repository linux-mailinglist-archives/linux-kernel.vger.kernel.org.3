Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA074F8E24
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbiDHEsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 00:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiDHEso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 00:48:44 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735A9119845;
        Thu,  7 Apr 2022 21:46:41 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KZQgz5Y9Dz4xYM;
        Fri,  8 Apr 2022 14:46:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649393200;
        bh=N+Uzp5hyYZdNyex81yxQ//SgXuZyUvzRwZF/wWGe9IM=;
        h=Date:From:To:Cc:Subject:From;
        b=plvx7Zf/Fejsg8NvtOOm6pvbCZtOhW0U0gvmO+3VHt2DYyeaWV5drRR8i/mYoomgb
         g+lnidCCfWpwoyy67Z/RQKcUy+oMgaRs36qRsDYSW2GRRHyVGDHjNQ2UrSpHD95Ce8
         6Ec6hcmUC0xP9JsZ00rYDEqxY/hUqbUhrtw7KBPL2CP7VX6NVwNtxmy7cgBE7rIzAT
         h9ZHhD0gxyqoPVFlujpqrM1lcHERPQxYZtkdss/l685V357fwKjJpCIwhnVhlL/RyE
         G6Ae3YuBg+yc1vmUB/2coCO64+tnDIGR8Ck2avCvntWa6jzXYNuhZehzyIM4Cz3N2y
         o8W/riC5MSDeQ==
Date:   Fri, 8 Apr 2022 14:46:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Yongqiang Sun <yongqiang.sun@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20220408144639.21a0f6d0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XkCV5IUkhSHYCVbXjh9hVEq";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XkCV5IUkhSHYCVbXjh9hVEq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (powerpc
allyesconfig) failed like this:

drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c:28:10: fatal error: asm/hypervisor.=
h: No such file or directory
   28 | #include <asm/hypervisor.h>
      |          ^~~~~~~~~~~~~~~~~~

Caused by commit

  49aa98ca30cd ("drm/amd/amdgpu: Only reserve vram for firmware with vega9 =
MS_HYPERV host.")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/XkCV5IUkhSHYCVbXjh9hVEq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJPvi8ACgkQAVBC80lX
0Gziegf+OYswYy9kvA5dDOc4V1X6qeC8WV/zyCjOhXak1YWtuGBrJ956sB/HNocD
oleRfSFDCdW2twsfhKt7XKTAZEdIgYmf+zoRU68dJNV7ZB4vW4KH+I3uUMP81Fn8
epPHksXZ9G4hsxteZ6YvWPjL40m/S8mDClAUwXQsGq6IyQbJxNA3ZBGHrwLucvg6
PDSCzQqi0Yw+nmuyYqy8onudDQkN6VGLSd0qMIOXYmE/CnNbrLz0cX+WmKGt2eXB
6s9eqUK+upW/b1g/JfvDdCAXtQTd9PadDucPXWr15awfG4ChHpfgrIMSHvnnqHW4
i4NKXAk2HET95G5LgOhoAQ9um1tBqg==
=uZTb
-----END PGP SIGNATURE-----

--Sig_/XkCV5IUkhSHYCVbXjh9hVEq--
