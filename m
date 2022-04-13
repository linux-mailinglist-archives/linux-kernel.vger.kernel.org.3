Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC0D4FECF6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 04:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbiDMCez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 22:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbiDMCep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 22:34:45 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792CC27FEC;
        Tue, 12 Apr 2022 19:32:19 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KdRSZ6Nc2z4xLS;
        Wed, 13 Apr 2022 12:32:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649817135;
        bh=wWh7A1pF8tW1Y6A9R44xai1ZImvBv/lnkPKWeB4MEVY=;
        h=Date:From:To:Cc:Subject:From;
        b=FEBOWSr6Wswmer06jZPpS3QQL9vNk8VLTJd/cqwCJZ1ExcainIANXKcO0c46jHn7T
         K8aqaEDx/KJWdPCQbNjWN0L5CvxuihnGntVqSyKd97+ADY/9hMlGM6IrN/NybDs4Dk
         /NH25mdK1/YHEya1MULHhVH/h9a3GCYCLrHMuxBKepA/w8zMN7cnpOwopMHcK8ZAJu
         xIi4DdYU2ZHL6hwsQa8BLTuARDivoQ20Qn2AZpWQbBcUG5hRgVDr8Kz+ZOtctyX2qM
         LEXBm/UfVs+xOC2R4FmFNWXZzugUP1wrUA5GeQzXLPhl5HwH5IZAnqLD21VnXrNZom
         a/8F60nfEn/0Q==
Date:   Wed, 13 Apr 2022 12:32:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     David Zhang <dingchen.zhang@amd.com>,
        Pavle Kotarac <Pavle.Kotarac@amd.com>,
        Tom Chung <chiahsuan.chung@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20220413123214.2916366a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VSUMg3IFu=28NI3wB8IcmU8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VSUMg3IFu=28NI3wB8IcmU8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c: In fun=
ction 'is_psr_su_specific_panel':
drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:798:61:=
 error: 'DP_PSR2_WITH_Y_COORD_ET_SUPPORTED' undeclared (first use in this f=
unction); did you mean 'DP_PSR2_WITH_Y_COORD_IS_SUPPORTED'?
  798 |                 if (link->dpcd_caps.psr_info.psr_version >=3D DP_PS=
R2_WITH_Y_COORD_ET_SUPPORTED)
      |                                                             ^~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                                                             DP_PSR2=
_WITH_Y_COORD_IS_SUPPORTED
drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:798:61:=
 note: each undeclared identifier is reported only once for each function i=
t appears in

Caused by commit

  901029aa0017 ("drm/amd/display: implement shared PSR-SU sink validation h=
elper")

Please start including an x86_64 allmodconfig build in your local testing.

I have used the amdgpu tree from next-20220412 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/VSUMg3IFu=28NI3wB8IcmU8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJWNi4ACgkQAVBC80lX
0GxtDgf/R7QBwNAjE3s0lkfvYVxEBjoljx1M6pWxpwyvgzuVSEMHniFjBGG+kpsG
o3NjBUz2Z1OcefES2M0lTMYuROGCIKzmGjpcCBx0662EGi6PCXFYoW1/7zAGOCMm
arHKQBhzhI6FPAwDDNiMuanyEfStEqoQFdnhOmItniYnmk7qDqk6U5o9fkQBr7vL
i+I7t0Z9PMW2GZtyNqyB7kuv0W9GXNPqKIpk8qmIAjlpfDRD9w1OuBk+lP3dvvkw
Xp5FojeK9hwmj6prG8kMFBs6Eoxgc4wJ4IMs35b9SHWjYrbld/6BZ2WPBudlAJVu
j9xVD+NLcqcw/cUMhsE/9UP5jJBsug==
=S5Rb
-----END PGP SIGNATURE-----

--Sig_/VSUMg3IFu=28NI3wB8IcmU8--
